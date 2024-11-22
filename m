Return-Path: <netdev+bounces-146871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC9D9D65E2
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291A3282A6D
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921519CC21;
	Fri, 22 Nov 2024 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JPJ7RabL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B018E04C
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315604; cv=none; b=qkNL9p6/X/Y96Ppf9ZdKEzZqJZhPxYjBicpxbS8gzDGpTBwP9wdG10ckiGNCxEQvdx7BRQENhbXzLeTuA3OaH38aEquanx/+0SsGPDoZsFdt/VTLHaBRYYGbVP7s6Mevjq/5DGmFJQ18LPXWhwKxP25C+FnkBGvFSpwpzPZHQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315604; c=relaxed/simple;
	bh=aKmccEP2i2MAD8yXIiNgPC0TiTRaBByPYLOdBuIetcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdOeQ5FJvVbYS/mMQUcG65NUJL2v2XGMg5F2fx2VfzTt5k/pbUDmKNITjCIE6yxA1p1HAJmSXV1WG3Y1VCrLhZQ5piCIl5tVN9aK2wWJ88LH51VpeOSP4xXkfRRXrUdAbq2UTndGvlXqIBuzdOhyX6+c7VP1Xv3OGjSBRFMqrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JPJ7RabL; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-514c3c8f150so937312e0c.1
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 14:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732315599; x=1732920399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa9bUMYaa23CTuS4iLDGF4dwcnY5Wd7sqofJOGstvYo=;
        b=JPJ7RabLqS4ETsulChc017IFAUZeMsqbUEUAdAu8j0MsGhvX7LkMHWqerkFvx6wG/L
         Zz+NbCrfaVp8s9j+0iNOxCBzsvt0pYe3WU4C7Ii60OvLpo5kebnZ06+moPaTp30oYHPu
         VvfyFqjupq07oqURK8XQZZdN0lZO1E2dsFH+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732315599; x=1732920399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa9bUMYaa23CTuS4iLDGF4dwcnY5Wd7sqofJOGstvYo=;
        b=P7CLQQkTSulO65qT6acoFSVddovjHgZKpJ9xl87g/PjIywiT4KMI548vh4gaBgBvQ6
         6CZARMqhmobUkZw395lMCHjSqHp2FRVmQpdndu5FJBK93tgVY8NR4QTMEyw/orkfGpwd
         SjZkWosiQbxItmr/SsZ4h5buRsqpfXx1CI/0zDcGcH4Ct1VFVSoij3802bj2238sHaQP
         7C+602XOOhuqTzQD3qdnAd507CdzJGYNHUAaiajjPKb6sQA/UQN+8Ds2DDWg1QiXEs5w
         /WtAxzWuhZxOJENKLtsO8D/7kHEiwJ/BVLl6/Averf46tsRHLk/CMx8mgt8FnlfXjplb
         LRcA==
X-Gm-Message-State: AOJu0YwEutmyeRkDIEGYvhJAAIlUy7G8/uk8XQLmS2mTbQl2OXzh8Y8N
	79V8sQHWuKw23q7XsfBp1A1bHUPAp69U9UczXaMZDDokH5iUkRD4joA55MK/RA==
X-Gm-Gg: ASbGncsZq15EAew2ZpJ/5w0XHM9X0vX+yEZuIjDC1k4yALBqklz5tNbZE1kOi0zrAV0
	SdhOHVeNShpaVKenpF/z1t1Ippf2CEbqx43AFeK9eAMg0qHzIQZy7ZvMvsmfT7JNJCLu+rZGBKN
	mZNY3QYeps5K8U8ozECu25Qh9poXw/yrMuVSqTZZCwZ46tNaKIxyB9/IsxPSHK2MDSYyPG7U4WZ
	cKuNlvJaoHGQWRG9WO1iFCq319/U/5I5DxemdKSWWibHggO6pOS8jMidhtDhn/6SFK2B5wVSH1d
	JmB7uiHpNp6vB5bYd68zR5NIiw==
X-Google-Smtp-Source: AGHT+IEavv1aBG9yv+3JuZfUDuGAm/UUnNZnW1gm1+XQd+T3/RXHR9wO8zKh6DdNZ8aeVJOKhOsfHw==
X-Received: by 2002:a05:6122:46a4:b0:50d:4aa2:fa16 with SMTP id 71dfb90a1353d-515009ad36bmr5769941e0c.12.1732315598989;
        Fri, 22 Nov 2024 14:46:38 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b51415286esm131270485a.101.2024.11.22.14.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:46:38 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net 4/6] bnxt_en: Fix receive ring space parameters when XDP is active
Date: Fri, 22 Nov 2024 14:45:44 -0800
Message-ID: <20241122224547.984808-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241122224547.984808-1-michael.chan@broadcom.com>
References: <20241122224547.984808-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shravya KN <shravya.k-n@broadcom.com>

The MTU setting at the time an XDP multi-buffer is attached
determines whether the aggregation ring will be used and the
rx_skb_func handler.  This is done in bnxt_set_rx_skb_mode().

If the MTU is later changed, the aggregation ring setting may need
to be changed and it may become out-of-sync with the settings
initially done in bnxt_set_rx_skb_mode().  This may result in
random memory corruption and crashes as the HW may DMA data larger
than the allocated buffer size, such as:

BUG: kernel NULL pointer dereference, address: 00000000000003c0
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 17 PID: 0 Comm: swapper/17 Kdump: loaded Tainted: G S         OE      6.1.0-226bf9805506 #1
Hardware name: Wiwynn Delta Lake PVT BZA.02601.0150/Delta Lake-Class1, BIOS F0E_3A12 08/26/2021
RIP: 0010:bnxt_rx_pkt+0xe97/0x1ae0 [bnxt_en]
Code: 8b 95 70 ff ff ff 4c 8b 9d 48 ff ff ff 66 41 89 87 b4 00 00 00 e9 0b f7 ff ff 0f b7 43 0a 49 8b 95 a8 04 00 00 25 ff 0f 00 00 <0f> b7 14 42 48 c1 e2 06 49 03 95 a0 04 00 00 0f b6 42 33f
RSP: 0018:ffffa19f40cc0d18 EFLAGS: 00010202
RAX: 00000000000001e0 RBX: ffff8e2c805c6100 RCX: 00000000000007ff
RDX: 0000000000000000 RSI: ffff8e2c271ab990 RDI: ffff8e2c84f12380
RBP: ffffa19f40cc0e48 R08: 000000000001000d R09: 974ea2fcddfa4cbf
R10: 0000000000000000 R11: ffffa19f40cc0ff8 R12: ffff8e2c94b58980
R13: ffff8e2c952d6600 R14: 0000000000000016 R15: ffff8e2c271ab990
FS:  0000000000000000(0000) GS:ffff8e3b3f840000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000003c0 CR3: 0000000e8580a004 CR4: 00000000007706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 __bnxt_poll_work+0x1c2/0x3e0 [bnxt_en]

To address the issue, we now call bnxt_set_rx_skb_mode() within
bnxt_change_mtu() to properly set the AGG rings configuration and
update rx_skb_func based on the new MTU value.
Additionally, BNXT_FLAG_NO_AGG_RINGS is cleared at the beginning of
bnxt_set_rx_skb_mode() to make sure it gets set or cleared based on
the current MTU.

Fixes: 08450ea98ae9 ("bnxt_en: Fix max_mtu setting for multi-buf XDP")
Co-developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3bee485b50f0..b7541156fe46 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4661,7 +4661,7 @@ int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 	struct net_device *dev = bp->dev;
 
 	if (page_mode) {
-		bp->flags &= ~BNXT_FLAG_AGG_RINGS;
+		bp->flags &= ~(BNXT_FLAG_AGG_RINGS | BNXT_FLAG_NO_AGG_RINGS);
 		bp->flags |= BNXT_FLAG_RX_PAGE_MODE;
 
 		if (bp->xdp_prog->aux->xdp_has_frags)
@@ -14740,6 +14740,14 @@ static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 		bnxt_close_nic(bp, true, false);
 
 	WRITE_ONCE(dev->mtu, new_mtu);
+
+	/* MTU change may change the AGG ring settings if an XDP multi-buffer
+	 * program is attached.  We need to set the AGG rings settings and
+	 * rx_skb_func accordingly.
+	 */
+	if (READ_ONCE(bp->xdp_prog))
+		bnxt_set_rx_skb_mode(bp, true);
+
 	bnxt_set_ring_params(bp);
 
 	if (netif_running(dev))
-- 
2.30.1


