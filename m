Return-Path: <netdev+bounces-224042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C979BB7FE7D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F427BAE88
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E2B2E1EFD;
	Wed, 17 Sep 2025 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKhqAzz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B32E11C3
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118073; cv=none; b=TnWEhHTBX5V102giiSvYe/GCCvM9UcUeGtYxnMbOy9XudSG6OONOtEC3kG9xzQNDEdPGGnhKMtCr9E23xnis0f/b2YkLOMbbbtJRIaQJAHO+CelljRdNHGG0uhy8GIZsnLT9b5kWAiocOMGYJJBm+3Kpi7dJrBXogAJSAHlV+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118073; c=relaxed/simple;
	bh=2GfL6H8CYFvd2zlRSEbFF6hlTsz3/QN8XHAewO9l4TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSIWyoRqB+zm270/MkAdRVw/PSAQsX544qkg0YWBzVOi5bs6LKzE7Cqcs8IR67dAeB3DRFYsqZ95y52SS/faeEbwGF+OVlRXXJu7wZNRXABJV9fpKxajU0IC8qK6gkzq0KI7yybaG64dtAMy3srtdLcOu8qqTks6svHqj0uO5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKhqAzz1; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso5948988a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758118071; x=1758722871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1lF4l0V5Y3ywmZyeZWtOMP5+EAmRdCLutinoQNvLsYc=;
        b=bKhqAzz1RYU+WN4YcRXTAuRdtzatwy3JvyKDgt/OiYTrysCutpZduydK3ohWeewB2B
         jeJvZekRb1vJsntgRTiBy5blW0xkO2+8LflNlvVn5EzWECLMpYqh/S7r/sypOHjlZzyh
         qR5DVRXlMowpvoDLuTBIc1Rvib+4d8uZDUaXoZpFFQGMxi3KxELsgdx/PlfO8ZTTToU0
         rJFzOe1F4vKYcR3bklsa6uG1E7HNb1PFo7sR2NL3tdoH/6NT/sFAS6hAfUu9s2aQiwVb
         juoeMrTNCjfVO272DJc1NrQ3YJ8sZGMhEB990KjXAZwQ3Z1hmnnO9B7ed9VbIXFVQCo6
         eLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118071; x=1758722871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lF4l0V5Y3ywmZyeZWtOMP5+EAmRdCLutinoQNvLsYc=;
        b=qJkuY0eAB9qPHJHxrwO+NgC3ItubadjfvD1qkOuL8nTyVKXLBBSLygcU8Ye4+4zEyX
         mNOAzAXbxbzpcpHlh/JtKS4CDfjCaPbS62pX3mxudO/dMDKxiv7/SjfbZV3agZox2YMz
         l7E7o2uRFZSu8p9M+BS1PZZT8OCiwhyHniwdejXZz4Wtwz5k7klxvYWUvB0rhcoVqiWn
         WswOmgWRu79vyGCVAtQxbH+x7sjPgDiDN1l1uRx6HJon7EWj5pA8bfUWApL70efVAW5X
         edFbdeH2gmSx0XqNV/zI4YirukvMIZtvmqjSIZAe0jcya7qaowK4IC5V5UpJ5K82heW0
         rFSA==
X-Gm-Message-State: AOJu0YyFFsRMldz8aq6Kx7tkG1G+lYIStNb1TY0Wm1e1jWNvOcWSdJ48
	e5YT5vvtqaqjBTNev59aVolITTq6rG0srWX0ILXUS24foACnfKgfLF5p
X-Gm-Gg: ASbGnctrzYz5mYecKSQmgec3t37xbsaYM7VhQVXECtUp1rYvEWR2jbVU2+7QWCRTBjn
	q/a672hafcq3P0JcSDuItN/xNY/gPF5jIdx3Xnp1EWzqlA+aFcK3MmdR9aBUm/esa7xfneVbn06
	KZFcb6JmzUlAYLjtHFFeapvRdcYwU3kMIb8ahud/YLoGrPqKB1xPpww4UrsewieqvBfMt7OIjV2
	QmPvYNXNl23wx8oGOUHMQBcJwpHv/ChxHf/cvKSlnVarKGVYGJI485V1Avg3Jbg3q5Mz01ah7vt
	1lOWUZIA0AiDwPkFmPpL8zOxV1iGEkG0A+dEdzNYu5rMvn8o+ktCZE/mEugajCmCW4CyBCVcNXK
	I+A/KIaZl5hpthwzpI7N6UVeCKDr+KX10PtUFsF0=
X-Google-Smtp-Source: AGHT+IEr/hdZRZQ5SAxQUru2gpuQ/w8Xb+9gVyVGs2q8Lew9lO8+3ZDoV3nfvoNYt6YCJNKJutUiJA==
X-Received: by 2002:a17:903:4b03:b0:251:3d1c:81f4 with SMTP id d9443c01a7336-26813cf3339mr34224225ad.54.1758118070389;
        Wed, 17 Sep 2025 07:07:50 -0700 (PDT)
Received: from cortexauth ([2402:e280:2313:10b:d917:bfec:531b:9193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267c9996c93sm53058285ad.122.2025.09.17.07.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:07:49 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: krzk@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
Subject: [PATCH v2] net: nfc: nc: Add parameter validation for packet data
Date: Wed, 17 Sep 2025 19:35:47 +0530
Message-ID: <20250917140547.66886-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 for the original patch, I realized soon after 
sending the patch that I missed the release of skb before
returning, apologies.

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

Following the same silent drop of packets of invalid sizes, at
net/nfc/nci/core.c:1543, I have added validation in the 
`nci_nft_packet` which processes NFT packets and silently return
in case of failure of any validation check

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
 net/nfc/nci/ntf.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index a818eff27e6b..f5e03f3ff203 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -809,35 +809,61 @@ void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
 
 	switch (ntf_opcode) {
 	case NCI_OP_CORE_RESET_NTF:
-		nci_core_reset_ntf_packet(ndev, skb);
+		if (skb->len < sizeof(struct nci_core_reset_ntf))
+			goto end;
+		else
+			nci_core_reset_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_CORE_CONN_CREDITS_NTF:
-		nci_core_conn_credits_ntf_packet(ndev, skb);
+		if (skb->len < sizeof(struct nci_core_conn_credit_ntf))
+			goto end;
+		else
+			nci_core_conn_credits_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_CORE_GENERIC_ERROR_NTF:
-		nci_core_generic_error_ntf_packet(ndev, skb);
+		if (skb->len < 1)
+			goto end;
+		else
+			nci_core_generic_error_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_CORE_INTF_ERROR_NTF:
-		nci_core_conn_intf_error_ntf_packet(ndev, skb);
+		if (skb->len < sizeof(struct nci_core_intf_error_ntf))
+			goto end;
+		else
+			nci_core_conn_intf_error_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_RF_DISCOVER_NTF:
-		nci_rf_discover_ntf_packet(ndev, skb);
+		// tech specific params are included as unions
+		if (skb->len < sizeof(struct nci_rf_discover_ntf))
+			goto end;
+		else
+			nci_rf_discover_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_RF_INTF_ACTIVATED_NTF:
-		nci_rf_intf_activated_ntf_packet(ndev, skb);
+		// tech specific params are included as unions
+		if (skb->len < sizeof(struct nci_rf_intf_activated_ntf))
+			goto end;
+		else
+			nci_rf_intf_activated_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_RF_DEACTIVATE_NTF:
-		nci_rf_deactivate_ntf_packet(ndev, skb);
+		if (skb->len < sizeof(struct nci_rf_deactivate_ntf))
+			goto end;
+		else
+			nci_rf_deactivate_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_NFCEE_DISCOVER_NTF:
-		nci_nfcee_discover_ntf_packet(ndev, skb);
+		if (skb->len < sizeof(struct nci_nfcee_discover_ntf))
+			goto end;
+		else
+			nci_nfcee_discover_ntf_packet(ndev, skb);
 		break;
 
 	case NCI_OP_RF_NFCEE_ACTION_NTF:
-- 
2.51.0


