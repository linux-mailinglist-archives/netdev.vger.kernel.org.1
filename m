Return-Path: <netdev+bounces-223988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5371B7C6B4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D06D2A1CCB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E88435AAA4;
	Wed, 17 Sep 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKW0W/pb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562D30ACFE
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109295; cv=none; b=QsXbgqUfwD5RKkQK3/jM+OYQeHK+dU1POHJiBepxKCDzHQcbQ0XXiHPTHPR4u8qVfIU8oNE7bJHVIpSRyYgWm3Id8ZPqrFtPrEUgv98Ei/9642ffTLkbElnjVh+16c/t1NW6agRJDlR0U627gDm0+cNA+YQ/arD+mDK3YCupbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109295; c=relaxed/simple;
	bh=N/Ee7PwVVD0Btz2fKiYLBUQb8Z3NZU3V0y/CRtFbjSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8+7l9jaM6OkiUUqEil9Dadnge8AuQBLHS0ge8KpXwbr1Wgcr7Fvep5+TGR1VVxa81RAKJ3fsvi0/8WVWNANJID1/TEn9u7QZi7oYiKOR6xdAy1w78/ilZuitTVcEjPhOfzU7pzivZdlwQfdlLr3jGBJFiaAYgkx/lpP6a77cok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKW0W/pb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-26799bf6a2eso29158855ad.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758109293; x=1758714093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/71U6mk1HE0y17xhkV6xojGxhUtQ/FIiDu4wfoMksm4=;
        b=EKW0W/pbg9cMSg6fB7b1BouuG0gkjiRWe7E+nVCM77Yf6cL7E102AqI/eugcToG8JZ
         RY6j464BIGUq3sGAX4OtI4WyrrsBDw6S7WkqzXVhZXfmAokaIvPfcmxHGwHBRAE6mvdC
         U9zHX1iaZsjM89WrSeMrkf4x0YsGMEsfmbamjqYWese1JtWyfuv4RXKEJTwVzw6TOf6c
         EADN37ocsbv9vTGWLRiGT7XCqcr8zLGBrBUdWtrkZu9BHRJzaZXfh2GYhWBRlUb3SRlU
         mG/4vlYEEKw6yIfavvRgA2513XFgtJEv0AGr4gVjJxjf//haot2ZPlWch/7EGMZWG9A1
         42iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758109293; x=1758714093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/71U6mk1HE0y17xhkV6xojGxhUtQ/FIiDu4wfoMksm4=;
        b=cFjIteNDMxAus5LwcFjmu2mn8dAAOnwdzcDj/aFo3s4AKLZKoNPMm17lb2qbVRJ1dk
         J7xUE0wpAvjpeaK0FGQip0NX7bYIjp/q4YSHM7btmjlR2XX0IPv8ruQhaoBWX2C+b/ZF
         33Ea/ByiuPeTEKpqCLO+lAXxe63tFrwU/kGMIKc4L1eFWCdzezNUWpZJsIXmYG8QG2ZB
         brfwf28VPy8LUGUx1ulqoSnMrFDqyWQhLdbZprmIs4dApz+k4M/OvcGCa/h2Z+RXhudU
         1hlq2siFrUyYGg8q8hJYJXSbB7PHu3Vko/nLJLtmsgEdr0SHNWM6vKf0/f0Fb4Ghl1Bc
         WL0w==
X-Gm-Message-State: AOJu0YyF6Gtl75woo4PMWkSnh25ktR/yvstDtIaqdpL9Ld9bYs0k7//0
	jEXbZv2nU7tIUQB7giQ+RwAxiykPkYdd/V3kEOTbL+IDTnbxuBzMA7lZ
X-Gm-Gg: ASbGnct4dZkl5QRH0cVxFntfVkf1U3t0X9U1+KHv5AnpF0EjaZr88H7cygaIDc6JCgD
	E30ybKrXRZxSiah68+kKXCbtaQVYRVAxU4DHqMTORAlQTYgU7mUr6Q7BhUAmvW0HZzLc/R8N8fx
	zAzv9QxWtfIXlG2ahiPgQMTZ8DIv6JNhlWwwijM324IdzUgAZKEFgqjIfN6MOC4C51qrsURMqgj
	DFyly26IEQQFjiG15xTyoFp5r7P6D4pEVMhB3SUQrHDKCNA45UYc4ojdnIAKGPkO7PSK7zq29uI
	cQ4vgH09uPWBsnpC5wnP/8J8tAl+pj+wV8KnWNavVlZiRkCjf2kmJSEmXlsGSLQbDuZiouB4+Ov
	CNP6jpF4LU1i8SqqmMcemQ9v5bNqBNzf/mRJtEAY=
X-Google-Smtp-Source: AGHT+IF4IlklU6MYc9xEkBsSBCRnBKDqQDO2bhUmKc2QNEE0v/TjKfWMhF7G9o+gmjzjr/VZtfcv4g==
X-Received: by 2002:a17:903:2c9:b0:246:441f:f144 with SMTP id d9443c01a7336-26813e00ab9mr24839985ad.56.1758109292952;
        Wed, 17 Sep 2025 04:41:32 -0700 (PDT)
Received: from cortexauth ([2402:e280:2313:10b:d917:bfec:531b:9193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269741690a2sm2722865ad.92.2025.09.17.04.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 04:41:32 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: krzk@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
Subject: [PATCH] net: nfc: nc: Add parameter validation for packet data
Date: Wed, 17 Sep 2025 17:09:37 +0530
Message-ID: <20250917113937.57499-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported an uninit-value bug at nci_init_req for commit
5aca7966d2a7

This bug arises due to very limited and poor input validation
that was done at net/nfc/nci/core.c:1543. This validation only
validates the skb->len (directly reflects size provided at the
userspace interface) with the length provided in the buffer
itself (interpreted as NCI_HEADER). This leads to the processing
of memory content at the address assuming the correct layout
per what opcode requires there. This leads to the accesses to
buffer of `skb_buff->data` which is not assigned anything yet

Following the same silent drop of packets of invalid sizes,
I have added validation in the `nci_nft_packet` which processes
NFT packets and silently return in case of failure of any
validation check

Possible TODO: because we silently drop the packets, the
call to `nci_request` will be waiting for completion of request 
and will face timeouts. These timeouts can get excessively logged
in the dmesg. A proper handling of them may require to export
`nci_request_cancel` (or propagate error handling from the 
nft packets handlers)

Reported-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=740e04c2a93467a0f8c8
Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
---
 net/nfc/nci/ntf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index a818eff27e6b..05ee474a1068 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -809,34 +809,52 @@ void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
 
 	switch (ntf_opcode) {
 	case NCI_OP_CORE_RESET_NTF:
+		if (skb->len < sizeof(struct nci_core_reset_ntf))
+			return;
 		nci_core_reset_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_CORE_CONN_CREDITS_NTF:
+		if (skb->len < sizeof(struct nci_core_conn_credit_ntf))
+			return;
 		nci_core_conn_credits_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_CORE_GENERIC_ERROR_NTF:
+		if (skb->len < 1)
+			return;
 		nci_core_generic_error_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_CORE_INTF_ERROR_NTF:
+		if (skb->len < sizeof(struct nci_core_intf_error_ntf))
+			return;
 		nci_core_conn_intf_error_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_RF_DISCOVER_NTF:
+		// tech specific params are included as unions
+		if (skb->len < sizeof(struct nci_rf_discover_ntf))
+			return;
 		nci_rf_discover_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_RF_INTF_ACTIVATED_NTF:
+		// tech specific params are included as unions
+		if (skb->len < sizeof(struct nci_rf_intf_activated_ntf))
+			return;
 		nci_rf_intf_activated_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_RF_DEACTIVATE_NTF:
+		if (skb->len < sizeof(struct nci_rf_deactivate_ntf))
+			return;
 		nci_rf_deactivate_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_NFCEE_DISCOVER_NTF:
+		if (skb->len < sizeof(struct nci_nfcee_discover_ntf))
+			return;
 		nci_nfcee_discover_ntf_packet(ndev, skb);
 		break;
 
-- 
2.51.0


