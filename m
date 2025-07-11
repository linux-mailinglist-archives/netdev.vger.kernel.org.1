Return-Path: <netdev+bounces-206105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E91B01802
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A1AB41019
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5023327BF85;
	Fri, 11 Jul 2025 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QxLfCjMY"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D4279DB8;
	Fri, 11 Jul 2025 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226413; cv=none; b=Q1v4IE9vgVc6R3uDRNG5FaOoDlCao6Wx0yNB2AYmTNPDOmmS8XKuYXO/Lj8grM69ObvPyv6j5lYgbfXv0QTez3bamCZ4RF5qzbUulLuoSwLqiSpMko+l52aTH+VjaoJJ5jOdW4qFHKbmtHYS7xW2HdQ6N6WnZHx5ZlOVTu2f4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226413; c=relaxed/simple;
	bh=ayn9UyQgGPkxHVjrMTJ8UDAqwunFabS5yds3/4jipEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uCnUlN/2PNEdCb+8/GmnFNmu5Vt2hLnVbM1JxjlJrFDnFZgsrTBtgcdd1coIzWnG2vXdMKgoShTmYPcEgIecS3Ve31zwSIEiaS8vcpaX9ffr8VbZtlycXBz3f8ajpwpl7hzjXkIEUuQ6mXXSsfb4otjcmOvLKUSHfNE0CVxvmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QxLfCjMY; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=O/
	yKf0YGV4uA9y6rRmSBQzq74Azxg2OhlYfwb+qE+HU=; b=QxLfCjMY7Xa/oYO98a
	AazYWgscCF7ZkpGSQqw4R33fi0DiDSdC/yP/BUFeGSSYmmdViLauMHv1bdzKbw0c
	VwbONTBk21Nmv30J8EhKUTpIwNO/xed2N6UmExPxQDd2WwkX6mC0/dCeuFp/AkOv
	YsgJHzmnKjE2eejNq0AK4eRz4=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wA3hOpP2nBo+FkNEQ--.57493S2;
	Fri, 11 Jul 2025 17:33:03 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] fix two issues and optimize code on tpacket_snd()
Date: Fri, 11 Jul 2025 17:32:58 +0800
Message-ID: <20250711093300.9537-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3hOpP2nBo+FkNEQ--.57493S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1rtFWftr45KFyDZF45trb_yoW8GF4xpa
	90vFZxGwn8tryfXFs3Ww4xtw15Kw4rGrWvg34UZw1Syw4DAF1F93yI9w4a9F9rZrZrKw13
	t3W7XF17Ka4DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeApnUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiQxOHzmhw1QaoAgAAs4

From: Yun Lu <luyun@kylinos.cn>

This series fix two issues and optimize the code on tpacket_snd():
1, fix the SO_SNDTIMEO constraint not effective due to the changes in
commit 581073f626e3;
2, fix a soft lockup issue on a specific edge case, and also optimize
the loop logic to be clearer and more obvious;

---
Changes in v5:
- Still combine fix and optimization together, change to while(1). 
  Thanks: Willem de Bruijn.
- Link to v4: https://lore.kernel.org/all/20250710102639.280932-1-luyun_611@163.com/

Changes in v4:
- Fix a typo and add the missing semicolon. Thanks: Simon Horman.
- Split the second patch into two, one to fix, another to optimize.
  Thanks: Willem de Bruijn
- Link to v3: https://lore.kernel.org/all/20250709095653.62469-1-luyun_611@163.com/

Changes in v3:
- Split in two different patches.
- Simplify the code and reuse ph to continue. Thanks: Eric Dumazet.
- Link to v2: https://lore.kernel.org/all/20250708020642.27838-1-luyun_611@163.com/

Changes in v2:
- Add a Fixes tag.
- Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_611@163.com/


Yun Lu (2):
  af_packet: fix the SO_SNDTIMEO constraint not effective on
    tpacked_snd()
  af_packet: fix soft lockup issue caused by tpacket_snd()

 net/packet/af_packet.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

-- 
2.43.0


