Return-Path: <netdev+bounces-205744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A881DAFFF44
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 12:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AC33A34E9
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9D2E4246;
	Thu, 10 Jul 2025 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y5wKNHAg"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8F92D9485;
	Thu, 10 Jul 2025 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143234; cv=none; b=q4uHK4YXCX8dAU0F8llBFdbklvx0QlNCAWDZKvmNzNBwRHf+DmXGi2eRDjDZQ5Qaf7eS9SGLExmilps187W98GizKW3Yvp3AC8SZIPwHD9sgKtkXINs7o+NCOSzWPEtikYd9xs9hy7SZqxDJIcv6Ep//3cqhhFU8ZmJQU11hujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143234; c=relaxed/simple;
	bh=I0/QHHzAjSBcqiV4muq10ktYgKHX4yjQuzWgTe4rKLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROccrPlP37qoWnVdBXrVhZURQhC/GyB/+WgkhVYGNZrIIRm2LRSnD92/lGDRZx7emn/dLwEyMRdnIlUjBs20mFGFti4R6QDWWMPw1HUmItUEY0iOT100aCeWols6m78DpQbhct0bckcaa7OAUIOGT6rBqCFEZye8VJKOefA6Bv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y5wKNHAg; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=HV
	zeAnBgsoG3vdPpfl8IP3P79FDWDH+2wt+OB+ZIgDA=; b=Y5wKNHAgC3nnkW/uod
	/akOfETZZw4Vj8ioRDIC9Q+RHqIdNUY7r5lqRtMlaOuBgCoDJ7YHVtJLocm7C5GD
	qZG0bfA3PaHLwl4VUKJTKXZyjJXs8mQBfdYB3RfSWHAwQCu3w0ZHOkfLADLQCH1f
	zhFLyflQHCB+S8fiDn7JwUPOk=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAXowFflW9oGKJ1Dw--.26998S2;
	Thu, 10 Jul 2025 18:26:39 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] fix two issues and optimize code on tpacket_snd()
Date: Thu, 10 Jul 2025 18:26:36 +0800
Message-ID: <20250710102639.280932-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXowFflW9oGKJ1Dw--.26998S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Gw1fWryDWFW8Cw45AF4xZwb_yoW8Jry7pa
	9YkF9xG3Wqyr1avF4Sgan7tr13Kw4rGFWv9340v34SywsrZFnY93yIkr4Y9F9rZF92kw4Y
	q3ZrJr1jya4DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeT5dUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiWwuGzmhvj82eWwAAsY

From: Yun Lu <luyun@kylinos.cn>

This series fix two issues and optimize the code on tpacket_snd():
1, fix the SO_SNDTIMEO constraint not effective;
2, fix a soft lockup issue on a specific edge case;
3, optimize the packet_read_pending function called on tpacket_snd().

---
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

Yun Lu (3):
  af_packet: fix the SO_SNDTIMEO constraint not effective on
    tpacked_snd()
  af_packet: fix soft lockup issue caused by tpacket_snd()
  af_packet: optimize the packet_read_pending function called on
    tpacket_snd()

 net/packet/af_packet.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
2.43.0


