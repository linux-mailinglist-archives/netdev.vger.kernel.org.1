Return-Path: <netdev+bounces-228577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D2DBCF190
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 09:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E1119A01AC
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA35226CF1;
	Sat, 11 Oct 2025 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mje/E9TW"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40625149E17;
	Sat, 11 Oct 2025 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760169248; cv=none; b=mBkykqBw6TaG5g64oDOz+A8nc0F/0UGk+s6YprV+rsIKOhY/NmdYyXRwMgrojRfICDr2xklKElJfZKnni9V8l6oPflByHjARpK0TIZPb/ekDBPTAcIddy6vc9oOopqlHn2qfYiySG4WjizdNovH3dPtzpeQC+yPZ6HiG0RfrL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760169248; c=relaxed/simple;
	bh=2/r63/c3u2LndzS+PA/2AZbt8mqOMKaz70ztAki/loA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LINRVew7AVBBTJi2tQz+4E3UUn9fkAhhOHtU6HPyOwP4EI4a7xdKiHIRCBB44LgpfLlihFpifs29mhimnGBPDLIBl1Zy6kAeMpwEIZiwDryEM+hFGieVFMBh2zN5eGUBL8t6HO6zdbBWkrt0n7EJwpTMn0JmfYHmbS3GCpOFwY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mje/E9TW; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=G8rDQLopsMZLS231VX7XRpDGHp/4H02/4S44xyUBN9E=;
	b=Mje/E9TWpdgFmEmwK4WD0V6RLJZQrfC8zH43XjEmDtcgCWvWGhuWZP7m5ec6oy
	4bkNXAMi1wglp06jl9Xo2pArjRWY56IW4WIP5lm4VDzJXpQBgBovSnPMOefV+Xxe
	H9m3u2JZSwLL/dThdNQk4bpziloNlgodHLeUVvCmhjHFc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v+TsDOpoK16yDQ--.50548S2;
	Sat, 11 Oct 2025 15:53:17 +0800 (CST)
From: yicongsrfy@163.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oliver@neukum.org
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH net v5 0/3] ax88179 driver optimization
Date: Sat, 11 Oct 2025 15:53:11 +0800
Message-Id: <20251011075314.572741-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v+TsDOpoK16yDQ--.50548S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWxZrW5JF15Wr1xtF4DCFg_yoW3ZrX_uF
	nrWr9xAw1jqFyUJayUJF1avry3Kay8u395XF98tryrX343JF1Dtw4kJr1Fg3WxXF48JFn8
	GrnFyayfZw42gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbsYwUUUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBzR-j22jqCTsn8AABsM

From: Yi Cong <yicong@kylinos.cn>

This series of patches first fixes the issues related to the vendor
driver, then reverts the previous changes to allow the vendor-specific
driver to be loaded.

Yi Cong (3):
  net: usb: support quirks in cdc_ncm
  net: usb: ax88179_178a: add USB device driver for config selection
  Revert "net: usb: ax88179_178a: Bind only to vendor-specific
    interface"

 drivers/net/usb/ax88179_178a.c | 94 ++++++++++++++++++++++++++++------
 drivers/net/usb/cdc_ncm.c      | 44 +++++++++++++++-
 2 files changed, 121 insertions(+), 17 deletions(-)

Link to v4: https://lore.kernel.org/all/20250930080709.3408463-3-yicongsrfy@163.com/

Changes since v4:
1. Reorder the three patches.
2. Complete the revision based on the previous review comments.

--
2.25.1


