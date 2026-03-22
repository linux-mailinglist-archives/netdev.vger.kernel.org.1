Return-Path: <netdev+bounces-270303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFQ7JOTev2ml9wMAu9opvQ
	(envelope-from <netdev+bounces-270303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 13:21:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2BE2E922A
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 13:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D780D300E395
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C85A2E542C;
	Sun, 22 Mar 2026 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDNvtMmr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B519992C
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774181808; cv=none; b=f400jWLVxzGlGuiihJyuxjbAgPntTdT0e3U/q31XuWHbC8rhvyR6m2+dArvGwCx1csFlRUMjs+voxIMbUGoEhbZx/f4YaQXIKtvvHgkSzAM4Te3ueUz8ICwBRUOkwEldJGKp06M+04RVnRWKXISmDE3yaUoj7OdLW5zzGSEFIZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774181808; c=relaxed/simple;
	bh=h+eXb6BWvQbevGQI/eEwbI+5Z3/xPDT5GvKIrnm07bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMGS/w0SY8muPK5mBLYLkiiJM2c2Y+wzYN9uEPj7B7P8EkJxELDZpWllxoZ2wJS5aXSfnkG+7XbDPf3xGRu4mut6bNfeQfeh1sfKjeYePc3aeiwLkrdDMCl46G02mk96wi0Z/TwyQTvoW1BUNDB2dOfD/5sX+0KHjgrk372fiOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDNvtMmr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so4579807f8f.0
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 05:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774181805; x=1774786605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7Q8r8jgdo8Jp+NqEWEM8v5GgTLMCpOYSldfF6W4qVA=;
        b=QDNvtMmrVoe1WJMYj03AOFTLjVjjjyxbeHGFVpLDNYXDYpOW5MH9TybNbLTal+a5LX
         owkS6/eoeBpC1fY6ivqcZg6rHshZQxH/z/AwloLfXtNYYwNmT8drt4w6562VllcP4SYF
         B8DsClORwRoUKRC44czGMh5e2KK+h7AhnNoQsD4s7BeuHD9JyqgOjuKYYMtwGaK/NZ/T
         5dgAUN9R0NRMvMSGkGaa870ml0NuxB9z9dlSEJBHzdTGPiSN5JB7Pla1oMJTwLcMYP78
         V58fa5V8EGj5tcWFNKnRFNvv8HcjhVvQR/P82nZ+7t8IYjYs++f8lb1PPhnU6of6xqbM
         2gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774181805; x=1774786605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7Q8r8jgdo8Jp+NqEWEM8v5GgTLMCpOYSldfF6W4qVA=;
        b=TXZ7OAzgKnhm7ZhaSZcA+t/Oss/9aP6rnC06S7tMF4dBz548AbwNNUHe45WGuiNmqM
         Clu68oYBLldJl3dD9VYiKvv1CORP1kWQLMfYEuxZss4pL+m1VGzpKtVJElQth+koHiGO
         3tF09RZ1zscHi0ZjBhXcUVaeIp1jx3rFEIDRkBWeYlVPSadFHBH5U0AmzR2zBRiGW/uu
         XPHexL5oJH0D+0Q0dMOAx6rELROrcYQ20YICUJhQ9Tijrr6NtY4vfNIZxkEFTLZDOmJQ
         9DU3Xq2aUruSyp/ICTDzBRpApF909CZ161/jlGm1Uhvsgix83yNXSzKLvL37awsLv0qU
         PnMw==
X-Forwarded-Encrypted: i=1; AJvYcCV1JzB7eAmdSZSAuqG0awuASLfexy9luA70TMH6pqMgp9UBWJoSS5LS3hy27kKHtZ/s3JxQSCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYgQmlaewIrFJ2zRxEGoFcs57XTjaYJJhhaBq8jNlbcjmQrBiB
	cZJ4S7NTbzczXZ8qSrPI7Vx94OFWHki7BCnQ3owhOJqdw603RX1IFhk=
X-Gm-Gg: ATEYQzzMwdPczl3CprBvR05OUBMKqx+cD6y9y7z3b41k6shnKHFAwHTXNUBM8eKfgly
	VuMgpbuBxbm0UfyCYKiZUABz5WnG+FxV1wKx2vathwhO5fDndxjP4aZElRoPk84Cv1pOsk3QLRl
	zeJSIHEDwaNGVxC3n3WR3SXuyhSh1G7EpNlcCx9ANrStvqVUIn75tyXLr2akdLvl3AjPUhpZxk4
	eK4s7H6raXosdmM3EsjHwhZzVkhf0LFVRMbcf8AaCCuVYGNMNhPIQxYGY67V+nRIlQmKw0GXHdS
	jume1yTM5zisNGSntx5YttX5KZaZ9VsjaWYgyZlalWY+y2ZNf6+rNEjTE6WlcK2gAOIHH076d2B
	u3QOlzDyErDE9Ds4KsVxU9SxailDtajyjUfaJiNFDzqzmZYMPgnwW8d+Ivqae/xasCgFni9xb7d
	ZoZ9bBxKpfZE3pN5VI5w9PbrnAVHhRc3s/QJlTVH5Edy0rRtgx1jViNduZ/O3QtFxXI+iQeaQ=
X-Received: by 2002:a05:600c:c16e:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-486fee0f975mr112156595e9.19.1774181805297;
        Sun, 22 Mar 2026 05:16:45 -0700 (PDT)
Received: from hp-ubuntu.. ([41.249.139.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870504f2e4sm30072515e9.18.2026.03.22.05.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 05:16:44 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: ecree.xilinx@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH] sfc: Fix spelling mistake
Date: Sun, 22 Mar 2026 13:16:40 +0100
Message-ID: <20260322121640.34113-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,amd.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270303-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[med08elkadiri@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E2BE2E922A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the Solarflare MCDI protocol header, the word 'address' was
misspelled as 'adress' in a comment. Correcting this improves code
readability and documentation consistency within the networking
subsystem.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 drivers/net/ethernet/sfc/mcdi_pcol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
index b9866e389e6d..a9a7076c00e4 100644
--- a/drivers/net/ethernet/sfc/mcdi_pcol.h
+++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
@@ -21387,7 +21387,7 @@
 #define          MC_CMD_PRIVILEGE_MASK_IN_GRP_ALL_MULTICAST 0x200 /* enum */
 #define          MC_CMD_PRIVILEGE_MASK_IN_GRP_PROMISCUOUS 0x400 /* enum */
 /* enum: Allows to set the TX packets' source MAC address to any arbitrary MAC
- * adress.
+ * address.
  */
 #define          MC_CMD_PRIVILEGE_MASK_IN_GRP_MAC_SPOOFING_TX 0x800
 /* enum: Privilege that allows a Function to change the MAC address configured
-- 
2.43.0


