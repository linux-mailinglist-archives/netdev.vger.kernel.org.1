Return-Path: <netdev+bounces-286409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3ZDwAkMOAWo4QQEAu9opvQ
	(envelope-from <netdev+bounces-286409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 01:01:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E62C506BD9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 01:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 726DD300F516
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 23:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AE136166E;
	Sun, 10 May 2026 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KesRpOI/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DFD32A3FE
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778454076; cv=none; b=napANT6T7cBN59cCB2tzk+4dM4uKOKfuiWmSeTBKttFBCeH5YcqJreCasL4k5iRlcoGDgWWhY6IjcGlU4B0i6sbdGi2iDGi/UFwiHcu68PKOjVlq+tOzffk8c3FQ5OufHN6mA9HAIEYj3sWVzaSSSwAbCcN3ImCZhjWKdfvdU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778454076; c=relaxed/simple;
	bh=xhAX2opUTOs0mANDhaJuTGp89zLQ4lB0uxkEA7zGsJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0h9spHkYG6lBUNTY6SveiUQXkePs1GH734nHOMQNx2YFXbRwwzW3cVudNJ7qw5OlJgErc3LWEQ13DdQLxuiiFDloMEUv2cxpkOkbblL1Zqh3Odm3RWbP8IdA0EGrz9A8ieINRRKkxhWKBun2UjFAIsTkyO7V0rD+muyhv+Lxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KesRpOI/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso31662995e9.0
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778454073; x=1779058873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Y5qc7YaxBE2RoCFNrTqE3IvuvDAuLAlOsFtRoL1WSk=;
        b=KesRpOI/LKKPms1+Kbodl4pKiwwT+I6TMDWzXZKpZwnTjaQ5InkJAr5f6CzjiEWu0j
         Epyh6004GxaCO/gsh2uavMcEPDTmN9RzxXIhMWKg2rxGF0PbwmQIw5HFPvo7jngJ3YJB
         m7e6krZi2sy0sseo4FRiYnISrXJiIFHE+V1O0wAaOZ6cBbja6jIxVXBJ3i+WF2BDZifh
         758dw6cXM9WCDjXflDtU27mSHIFmzdu6L0w+dD7D6iO39TpHdyjhN7nQaRACqRk2WMmx
         zs9WKBY88mo8W3zjJeeyYcV+pvKia7Qs28DKOAMUdTsq8cqyTQ8NY/UvyMe2elOd/cCA
         zJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778454073; x=1779058873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Y5qc7YaxBE2RoCFNrTqE3IvuvDAuLAlOsFtRoL1WSk=;
        b=pcSjzR+OYGcjNEpIKXvrOULrvT6Cu6MOZhH19Gp4REr4NnEgJVM5TXCZPmQrj6oe03
         3WWgfuTnCr0yJy7X19Q1JOuIfIIbtyc9hNtunLBMqSfr/ZBL6pceQEadhRKAvlBvbs4c
         pvo9fnRtOL8j+XZ/5Yvd4tazJgL8VSzvtVgktPxvXnPCJX426EN+uxKPZp9nv0fHVD2d
         vOLioo+otxjRf4t+ou10VlmJQadBi1xKovcSeZA4J7xzBXMC8bN8LFtHARcmURWr0bnV
         plQuIEKqV9JqjHOhK9UisR32o7l0TRqY7yLskpvq6AoeHk9BiM+y1XU5KfYMxyWP/hHW
         U5oA==
X-Forwarded-Encrypted: i=1; AFNElJ8zLciTf5yChRe67t6GEWF22wRcDblkpb8xLlxKLl3osn3/ppdOr9BPdZmD8F9y4T+j171MF8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDBwUm9363dzG2Hi+V8RI0dGNzHeehyf0SjMdH3hj7tni3jLR
	9/Ey3ffjB+Taus05QAE0k6A0fq/svYknUJEGZ9hFO0NYpP/8Z8YLD5Pj
X-Gm-Gg: Acq92OGlPvoJKdM1WDNw2jAWYAE9NEvYE/NVFK/EhRtZC/55elkbcTJcFL+xWv4A/2d
	uXRvSPAiRjTI5DZynmz8Y5r+0L9yZW4a83qYmoQaLJ0CfoRolQ7F6S1gHWEeaY1D9AmSb+5peQR
	nRO3emGpojt8dfWlIWPPx44AS+COUQo+vMvfaTErTAYkvwhQ56wyCNTPpM6SInruwqyBAHxttKz
	0eBVlIW3ZuediAvS0UOsrMBGQ8qUA8z4WdsLtF2xpvg7211QNx3tgvBnR/zSzwlp8QhGYX5LWAB
	l6DddDIgdjYvXY5I6Qy2wbOtohw/ZDsfbj8keKyiN3FSAANiu5A6q3lBxUIajolPoxgw9NLHuhQ
	L/FsIqOTqPLGrCsqp/+htv+s3TBtdyiwLyLMxqKGk0IVOtKdHDjlZTWJCOUDo3SWRvdGBYx1hpx
	ZDoN5uafAhz4dPFO2bvUtRnHhGpoKTKNV12UorfDR48CUi7057yslf2unv1AdbcyBcE88V4ejWV
	CavDxixcEOgjdYwbqOzhoc8kLv7xyKrtVRHqgYXvg==
X-Received: by 2002:a05:600c:c091:b0:488:a977:8de with SMTP id 5b1f17b1804b1-48e706b264cmr89258645e9.16.1778454072967;
        Sun, 10 May 2026 16:01:12 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8e4f8csm51450045e9.12.2026.05.10.16.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 16:01:12 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Carolina Jubran <cjubran@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5e: Fix eswitch mode block underflow on IPsec acquire SA
Date: Sun, 10 May 2026 23:59:00 +0100
Message-ID: <20260510225903.13184-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E62C506BD9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,lunn.ch,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-286409-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

mlx5e_xfrm_add_state() handles acquire-flow temporary SAs by allocating
software state and skipping hardware offload setup.

That path jumps to the common success label before taking the eswitch mode
block. After tunnel-mode validation was moved earlier, the common success
label unconditionally calls mlx5_eswitch_unblock_mode(). For acquire SAs,
this decrements esw->offloads.num_block_mode without a matching increment.

Return directly after installing the acquire SA offload handle, so only the
paths that successfully called mlx5_eswitch_block_mode() call the matching
unblock.

Fixes: 22239eb258bc ("net/mlx5e: Prevent tunnel reformat when tunnel mode not allowed")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index a52e12c3c95a..db260e3d1412 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -792,8 +792,10 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
 	sa_entry->dev = dev;
 	sa_entry->ipsec = ipsec;
 	/* Check if this SA is originated from acquire flow temporary SA */
-	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
-		goto out;
+	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ) {
+		x->xso.offload_handle = (unsigned long)sa_entry;
+		return 0;
+	}
 
 	err = mlx5e_xfrm_validate_state(priv->mdev, x, extack);
 	if (err)
@@ -870,7 +872,6 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
 		xa_unlock_bh(&ipsec->sadb);
 	}
 
-out:
 	x->xso.offload_handle = (unsigned long)sa_entry;
 	if (allow_tunnel_mode)
 		mlx5_eswitch_unblock_encap(priv->mdev);
-- 
2.43.0


