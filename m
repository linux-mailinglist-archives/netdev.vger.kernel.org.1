Return-Path: <netdev+bounces-98372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AB48D1278
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 05:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2481C215E6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 03:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F083F4EB;
	Tue, 28 May 2024 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JjjkF4gy"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361111BC20;
	Tue, 28 May 2024 03:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716866336; cv=none; b=C+GNNDP16Xz83BX6V9zblXNHWKISFQE308MfGQHChwO15ByBuaJEpC2mOkRqRAsVOGjzxhWPMolnlTLW9QbTwLE7SrIzja6YSz/bmZGgw6waYU/yn6Wt4JkMrrYK8gzkJTb9CCnOdEbH/4bdfXhIVxS3OxtH6CuDGydkuD86Yks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716866336; c=relaxed/simple;
	bh=G4xWxHxviUZgZNZ4B9LEhX6CBsrFq5sUCxRNJjz0cFY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LQRF3GKlqXi5J7rRyNWNpdiX7nyDUsvrcpYOuQAWN5JIBxZP0umlKjDahfHM6H5YpoDW2Pyh8AOs00Wrb6yvJKHlnngtZhrNGUJYGOzhYrr1UMEzecXuxAr4UDcyXgLthpgMmgLvHWlsb+yW6/o5voT7ebjjncZER/bC5kDmesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JjjkF4gy; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716866323; bh=5Pht2AsU+jZDT84gMZB+Yjne2Pxcf/7ECz8bDPhMwww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JjjkF4gyGX/mOpwp9XGzsHl9RevSpPfwmw5o7bYVBz+YJqpdZOQM8G6i4IExyxfNW
	 mIc2S8tHwA7EojcqRbCBuwoD6SljYw8//+49f372KrhtbRsPlvwPXrolHiukbRk6cw
	 uNA16fsbElq0xDbyMSpjeNMJQjLpelB6iR92ANsY=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 31E376B2; Tue, 28 May 2024 11:12:30 +0800
X-QQ-mid: xmsmtpt1716865950tkxn1u6wi
Message-ID: <tencent_53E8065F49BD2ECD2EC28C9AE7EC86EC5206@qq.com>
X-QQ-XMAILINFO: M5znx2hx04lbxlEEO+mqGqEROpB9MPkRN2A1jjEV5bh4FH+Dq6mcfbHvn/IE94
	 dAYebOzSjFfW6AXBxwJiyrMnMTO2ylLAu7iWX6HrHz1Kegi86OPD6exqglK1bLFzYtvWYqushkzw
	 0xR1pnRp/7SHE2QeExQPsNP6Uwb19BMM0pgglMEpRy42W4C3feu/uWDBaMxP9q5p31Q5WZ7ajQVL
	 C7isiO84HPBIx59FOWBeze48PzTD7tPuV10ALgzl8qx5F9QPORYeGWCqv3kdYecpdb2RtG76dLS+
	 +dGjFq50xAIDFrL1VA5hgUUkgYuNW0SO+JBXrUacSZkPJYBF3ATBrtKeadEqSX0otQeDHghdxKsA
	 LPVRPrm+2yHTB+LdlADUJ70GswLm4su77VTt17VfNt4/KAcUxq12+IN6RjcLvTYHBeqVxng/jzqi
	 /w/ynoA30c9ra+AoiowbAXijtcip55c6WWPkMG/Uz61Op6/7PyK5RW4iQ42C4Vuk7lhN/CWdbehh
	 eowawPXXqKHvj4wiiDDFUZxNwWlG+GK60jhdHDE19IGaRGKYmGWX1iDlukbBVnPCyUS4sA0dDcpg
	 MRZ3wAfijlP4tnQAG+vNJSIFGb9sU9INkMja9WKzyptMMfzvpqONmXSm8JoAThP16Uxn97LKknfo
	 3bwqUeTsMWNjEwsrbhh0a750hvpF/06c41ksSJyf1f4pCEtfavnnF67ob2/HIepCvDsM7/O9hlKW
	 J0oiT7zuJqWFRd9o32z8VZkTxtic+gGoi+OqvM+kNcgKWAmlg3rAVrvpgs8C1sHb2ZXJfx31BVju
	 NyHj6HigPTw5+Rok2Go1wjbhfRsadKPuANXxiCe8tuSOVTMTlYO6tmLGpIZGHQNYErJmQ6Hwyqzw
	 vYz2TTXMemMyH1r+zr7nabdtXPk+JmKSWf/T8G3bao2aAXn1HJ3gvVr5kMqQuv5A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+71bfed2b2bcea46c98f2@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	krzk@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] nfc/nci: Add the inconsistency check between the input data length and count
Date: Tue, 28 May 2024 11:12:31 +0800
X-OQ-MSGID: <20240528031230.1190547-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000007018c0061964aa67@google.com>
References: <0000000000007018c0061964aa67@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

write$nci(r0, &(0x7f0000000740)=ANY=[@ANYBLOB="610501"], 0xf)

Syzbot constructed a write() call with a data length of 3 bytes but a count value
of 15, which passed too little data to meet the basic requirements of the function
nci_rf_intf_activated_ntf_packet().

Therefore, increasing the comparison between data length and count value to avoid
problems caused by inconsistent data length and count.

Reported-and-tested-by: syzbot+71bfed2b2bcea46c98f2@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/nfc/virtual_ncidev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index 590b038e449e..6b89d596ba9a 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -125,6 +125,10 @@ static ssize_t virtual_ncidev_write(struct file *file,
 		kfree_skb(skb);
 		return -EFAULT;
 	}
+	if (strnlen(skb->data, count) != count) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	nci_recv_frame(vdev->ndev, skb);
 	return count;
-- 
2.43.0


