Return-Path: <netdev+bounces-134869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 462C199B6A1
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 20:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C5D1F21FD3
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A21481B3;
	Sat, 12 Oct 2024 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fBVQF915"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE67ECF;
	Sat, 12 Oct 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728758899; cv=none; b=fUkyBETJutapM32pHDeHEv04UOskfsquKjFF5zD0gRqR0LkopPq/LIGa0sbdQHi/X7wXc9+E2EMK0B1O4KbgC7rjpVSO3QiYD7OtQR3fFx8Ji00frbb5ZgwkbKdpxMnpu2kIyEw02XRgislUO0gut5WdS8+R+Wj/gz+JYYuJjso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728758899; c=relaxed/simple;
	bh=+5ObR+YOgsLNxZXq+Wm3rjqEMzYPP67PEHb3nvrfw9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YazN2RksmmUTzVt8LUNQwgN0BOEM2fT7QzcK7pa4KmfGwb5pEOSrWTnm45BgF+at45/NIWi8OqNOzifVUZnkoTiqBT2MZdwAJ/khKji050Jr9GTQ2AegEm8SKv/e/cOmricP4uJmXYaqmH6PKFz9xH9BLMxYOa8sfUjPcFaP9B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fBVQF915; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ehJBOQ/wMwgBIKhb+328nTmy5efKQXASssE1QNq+1iM=;
	b=fBVQF915dkKqqnvgiVZWj4VN9MnLSe0FFvIHjNKB8g1qAJKokuqLtyRk0h/DvS
	7A3AL9OMobQr8DFTC4oqii15ERIPze48EMwUIerrIssP2NELbUG2ZTLBoXD9os8g
	cNCMI+ZJWJcS6OuoJW1lKinaU709+5V1XFJ0SzE79Vcho=
Received: from localhost (unknown [58.243.42.186])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCXntY1xApnsBj3Ag--.10512S2;
	Sun, 13 Oct 2024 02:47:18 +0800 (CST)
Date: Sun, 13 Oct 2024 02:47:17 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: krzk@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
	syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com
Subject: [PATCH] nfc/nci: Fix uninit-value issue in nci_ntf_packet
Message-ID: <ZwrENfTGYG9wnap0@fedora>
References: <ZwqEijEvP7tGGZtW@fedora>
 <670ab923.050a0220.3e960.0029.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670ab923.050a0220.3e960.0029.GAE@google.com>
X-CM-TRANSID:_____wCXntY1xApnsBj3Ag--.10512S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWfZFy7ZFy5Gr17ZrW5Wrg_yoWkCrb_uF
	yfWr15Ww1DGr12yr4DCFyayryqv347uryv9wnxtaySkayDXF18Xa1DZr4rCrnxWFWxAFZr
	C390qr1FkrW3GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0JGYJUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYA52amcKw2wJNwAAsO

When an unsupported rf_tech_and_mode (0xe6) occurs in nci_rf_discover_ntf_packet,
the ntf.ntf_type may be assigned an uninitialized value.

To resolve this, use the __GFP_ZERO flag when calling alloc_skb(),
ensuring that skb->data is properly initialized.

Reported-by: syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
Tested-by: syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com
Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/nfc/virtual_ncidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index 6b89d596ba9a..31da26287327 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -117,7 +117,7 @@ static ssize_t virtual_ncidev_write(struct file *file,
 	struct virtual_nci_dev *vdev = file->private_data;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(count, GFP_KERNEL);
+	skb = alloc_skb(count, GFP_KERNEL | __GFP_ZERO);
 	if (!skb)
 		return -ENOMEM;
 
-- 
2.47.0


