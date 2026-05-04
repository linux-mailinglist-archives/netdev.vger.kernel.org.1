Return-Path: <netdev+bounces-284032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VP4HEw/2+GmH3gIAu9opvQ
	(envelope-from <netdev+bounces-284032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:39:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9714C3508
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C02A5300909C
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833543DCDB8;
	Mon,  4 May 2026 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG2+mXrk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6DC3A1CF3
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923596; cv=none; b=sdF8dZ7EnDj62VdmJbvTRqarCS4q/l+GGlrlTfyMKHvjACvt/D2kTG5sTrVAUB4DOa2f/YvNgGvdJlpYIkdGV+JQtCXVZ9blzh2KdRhuuMQX4OlvRdNASPoSuZh6942Z07yOXitfhdUI23CFiePqtjND0stZ8s350V6BGOk9pCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923596; c=relaxed/simple;
	bh=1JOyIRRgBwbB/DhfXPbjmSn8yLF9GaFDLeyZF/pITec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BfZtoqWP8HVlyJv4d0xmMnWf3qSaCSPAYbMaZfxOvgyX5jrFI2cWpNjKIP0FGcmNDN5JY0+yRqMQdoexykFxtp5tXfqpLpLWFY3+WqvWXkP+hvqywHrZuBgRevF3RzRqI8sNXN4m0BPENj8kb4NvrQZGO+DgzEyvwCJGRmrBhoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG2+mXrk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad21f437eeso26934675ad.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777923595; x=1778528395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0aIguRQYWYljT8AmitpZ9/B4tpFTi2ewvWnvOjrRTM=;
        b=ZG2+mXrkii6uMsk38ZUbJ9zpykUFGwED22CQ3eU3Qj6ggGYEAx0L2upz/DiRTmsSWj
         YpVCkgzNAAPnepys+I7Az52FLEcgnaCGpE87lh+XEJ/WdUE2maQmi0Dd3+05vuH5hew/
         9FHBg9foCe4gukAZr1+CrwDYe0cZzGEhE0Zx63AyG2CZnkcgTC8PENzH7BMxFv/JeIvJ
         2f5emh9lqyT+q1pq1SKyrxk2EUtvGC9Jbsj1pMQWpPzpBRwciGDmdZ696zFChgseTH2u
         xaMgG7qdV7aufzPdX09+dQA+PUyQCFuO/JR1hnXz0i/77yCu4+vvi9WuWZxTvmbd2hHP
         rg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777923595; x=1778528395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0aIguRQYWYljT8AmitpZ9/B4tpFTi2ewvWnvOjrRTM=;
        b=DMvBfhoGjNILfiY4pqRCh63CSYrdILPnfp5HK6GlKBjlx/dCOpsLthe8RsQ64kOpk9
         Wjyr27VBehdKAHPa/Dy+uc72hxERL7A21IiUV1xIGU6O8bIFsySlqQ7ACDi87EG3B2uw
         eLcnaNXUg+nhK/dhMZQUHUvtm6wud/Y5tk4aEjS2ppH2FzGs+3+2U3cEJay8X7+kThEU
         3g7oCGoMDcvd8hBDfxpwJqUHtBI2paT7ndnvGHZqnsA7J7LVMisKzhyHWyS4qhEUK77K
         KsSSc9wO4ZZOSjT5KKm8YPlGdaz8G7WpE4MwrqEavzGlIo+1l5/cFhHfT+hQ1dgP5w03
         8h6A==
X-Forwarded-Encrypted: i=1; AFNElJ/gTM/YwG327nowWXfCYaEibjn3Ba5F1CQ/bQjUW9itYPxPP5zqb9yQ+VkxXq97foz7P7DZUOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKj1vBrro9yVM0VVmEPrzGwDCDRwFjBo4BrSiyc6zAiSvujuuR
	5YyDjEsvLsr9HSM3XiVaKP6XXgocgBI/AKV0b6haiGA8bmUWR+ez8Zj1
X-Gm-Gg: AeBDietWwuVQ/wpzXMutMZiNZzh9ask8Zc6rSuVgeD/MBRBWPF89r9xi3u0Ug2HBCFE
	YSC7r2iqBJfpBCSkeo8B9+Aij7X4IRSK3xrskli6z9xHjp0RbJby72hTt+LrogDsZ0vdk2rhyIi
	e3EWnsQROhZgtNvM5fA4KuLScIfhCu75VNs8auxa2fN2eAsJuQV4iJxHbkyh4wchc1O8BHjKfQ3
	9gePMV47bXk4++/Rw64d/iqk4Xr8kCGrDTLpi2ROTK4gMtPqjajA/WsWVKG12Ya/J0BAdAVcVLQ
	YXGe+E+KuNs451kNhuAv12KTOE1ciVRJZZ5HLIZUtT00cWDVyxzzuCzyvR+t9lPQvuN887C8sNv
	++9dw3Nv4xw12vnul8pKkdBFhJDkh46DK6d17NL6VCclr33W4HDG+NNp+/5KaK7rMvtLSDpN0zM
	uzF5PvFPs42Uf5DczfmwX+Vw3FntObgnaOZn6E7BnqQpBrVsoVvNa4XyUZfvKNmuB04rwEUQmM
X-Received: by 2002:a17:902:cf4c:b0:2b2:53f5:461f with SMTP id d9443c01a7336-2ba4e4d4b4amr6067815ad.25.1777923594624;
        Mon, 04 May 2026 12:39:54 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae363d9sm116121755ad.57.2026.05.04.12.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:39:54 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	Parvathi Pudi <parvathi@couthit.com>
Cc: Roger Quadros <rogerq@kernel.org>,
	Mohan Reddy Putluru <pmohan@couthit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>,
	Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH net] i2c: sun6i-p2wi: fix of_node reference leak in probe
Date: Tue,  5 May 2026 01:08:34 +0530
Message-Id: <20260504193834.3516862-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE9714C3508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-284032-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,couthit.com,davemloft.net,google.com,redhat.com,lunn.ch,linaro.org,vger.kernel.org,lists.infradead.org,cambiumnetworks.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.990];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cambiumnetworks.com:mid,cambiumnetworks.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

of_get_next_available_child() returns a device_node pointer with an
incremented reference count.  The reference taken in p2wi_probe() for
the optional child node was dropped on neither the early return when
the "reg" property is missing/invalid nor on the success path, so a
reference is leaked once on every successful probe and twice on every
failed one.

Use the scoped __free(device_node) cleanup helper at the point of
acquisition so the reference is dropped automatically on every exit
path.

Suggested-by: Felix Gu <ustc.gu@gmail.com>
Link: https://lore.kernel.org/linux-i2c/20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com/
Fixes: 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support")

Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/i2c/busses/i2c-sun6i-p2wi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index fb5280b8cf7f..652b37b57159 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -184,7 +184,6 @@ static int p2wi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *childnp;
 	unsigned long parent_clk_freq;
 	u32 clk_freq = I2C_MAX_STANDARD_MODE_FREQ;
 	struct p2wi *p2wi;
@@ -223,7 +222,8 @@ static int p2wi_probe(struct platform_device *pdev)
 	 * In this case the target_addr is set to -1 and won't be checked when
 	 * launching a P2WI transfer.
 	 */
-	childnp = of_get_next_available_child(np, NULL);
+	struct device_node *childnp __free(device_node) =
+		of_get_next_available_child(np, NULL);
 	if (childnp) {
 		ret = of_property_read_u32(childnp, "reg", &target_addr);
 		if (ret) {
-- 
2.25.1


