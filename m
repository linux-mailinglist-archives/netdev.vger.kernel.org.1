Return-Path: <netdev+bounces-265978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A0lGpPvr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:16:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D85082493B4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE76A3076AF5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98144D014;
	Tue, 10 Mar 2026 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJwHwT0V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612644B68D
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137561; cv=none; b=R+xmmWTSJQI9S5bBXMmstX24Z5PZxPrLrDD+O79kHsBdW/MtXijKR0xIaUp4IEhxWIG+UI0aqfUU6egwX6HKA2MMJJ1mlsgTfA6D3TEbMTs/6NWkMMKB2soz2UUxoxmetpfaaWCMBuCPVAcLr3eB0h4B5z5UASf78uGqGxZSkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137561; c=relaxed/simple;
	bh=IXDgAjyGns8ZHUuhsbE04eGQ4QoGzZPIewBT4PQDLDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3KGYsDH9H/KVADH5TzS0ics9RIJ18J2aiavx53FWUNEIC4BeTQYKGpwDaBPIGLIH3sDNxRCzGr/ynDq4wns1yVk8rA1GpZDfL9LATjShgtDtBOTG7XRtkhYyggQB+2DYN1Fzrh+1Pd+vCIGV2BQE9OrAD6K9JjtE7ZSVNlM/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJwHwT0V; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89a0ece9f14so108188306d6.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773137559; x=1773742359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5nGmykeIzZqpT2d4t5X2fcZ/uaJRdZFOjoMw7bJxzg=;
        b=TJwHwT0VXN495w+4F+l9i6bkd2b2M2j7yKudpzHmVO3Pu3HeIR5spy0bs5AZgIubI5
         jmM2CKncQbphl3ZEgi5W3V83R8a6DIwqm747dSs9LUIpZnFOFCJU2VAaZEHOzPOZ7DfC
         pzIiTw+rRCw1QcZxh04HMADWYJ4PvtcFRcMrJG+Ep8To/dnMRyadx4aMuIWZNyY5U+HF
         +3NqwAMQWQgVNCwIK547zTj3P0NXz6pbeNLCvZvnW15TaWzHnRqP7/0paSOXEah3XQkl
         T/Jd6Lw8R2+hk4InOsdjch9yYkLGlAlJA+YRJ3dA/8r6VHcBJbiZqGMJUKHxIzXXGhEI
         X77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773137559; x=1773742359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h5nGmykeIzZqpT2d4t5X2fcZ/uaJRdZFOjoMw7bJxzg=;
        b=kfofpnY9lHz2MsFfrsoYZced8yNcIIlCNtFd7wt7/kwn7n9uMtMk2GkPWx+KGcru3/
         7ARi8dYeaD98ubXlM6vBPKP7wX2g0cQ1N6fqwJXYLUQZTvw7da3K2WEg2JvaI0rbAt0i
         fEXD6m4CACBMmqiqWCGiHMNnxKoOjae0Bov7p4hC5HpHVc2BeyJAG5gz8MGUxtfGGQHP
         jozUX1tZ3/k0TohiDRr90s1OkSMRoXzVVkwS6YFzdlARInkHgLtTsOeDWjeTXa05v5Yc
         PElY9AT9xLdsvRyXtzFDdfsRtmiPBfUDzhe+8bQRqZJnMNwbS/stXcF4/NOXI7fRCX/T
         g5CA==
X-Gm-Message-State: AOJu0YwjXhaH+mOBzEMQI7yG5QoUb/LZkrzETO+XKGuGXNNfFb1IcH9h
	5VGBKqR0ihwwQZUlzNf5bviV7e+wIRIwvNof01SSYDnFVxKT5NhwC5o2
X-Gm-Gg: ATEYQzw/J4OsVLvAUGA/TG+gQgqMi6+9Xa1PNX+Bp2ZEMbN0B5GEHp4In8epVIIe2V1
	VjdByeZZ2m4LHFc/AANEZW9OFv8pfQ0ycvGB4Ht70ZtTud/kKgYtllRajEHJVwWwAthMBKKq6gv
	Ore7Xt2ElIPFCIW25pax2zvVGMpZtKkz/6guHJLGNp0O/v6qIs1MwMrcZ/dPHuDVinVH8l4Re26
	wQ8mwbL2h+5VxWp1LWcUOUZsf1aYqIbgElA3SVFFRhdK3MmMjiPD9kMIYgxYq6BjOY/Trz4l6zY
	ILK8dhMfjCWD2mvZi+f6CCtaGuwpYpNe25TDF/JZ/fLPKBEwMQU++duljzzQYQJrC7vnFWGTWo4
	m/AvVLPQUPp8su6wBDqqYTvgdvXracurlN1fIfVn5oLkCRW4fFrSoMmCFsXHkGQdo+o9hcnfFSc
	UIAvjjqhdWVe59yHppgM1kFG/nE1WJkNXz
X-Received: by 2002:a05:6214:2a82:b0:899:fc48:4e63 with SMTP id 6a1803df08f44-89a309770bdmr207172936d6.0.1773137558835;
        Tue, 10 Mar 2026 03:12:38 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c4a0c6sm18867736d6.52.2026.03.10.03.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:12:38 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Tue, 10 Mar 2026 18:12:09 +0800
Subject: [PATCH net-next 3/3] net: macb: Clean up the .usrio settings in
 macb_config instances
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-macb-cleanup-v1-3-928c1a91a7dc@gmail.com>
References: <20260310-macb-cleanup-v1-0-928c1a91a7dc@gmail.com>
In-Reply-To: <20260310-macb-cleanup-v1-0-928c1a91a7dc@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: D85082493B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265978-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

All instances of macb_config currently have the .usrio set, but most of
them use &macb_default_usrio. In fact, there is no need to duplicate
this across all macb_config instances. Remove the .usrio setting from
instances that use &macb_default_usrio, and ensure that the default is
selected at runtime when no other value is explicitly set.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 27ec1f16c4f18c2be67f5052fd248ed17ea2281b..0524109d47531785b63f1207aab9609e63de377e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5406,37 +5406,31 @@ static const struct macb_config fu540_c000_config = {
 	.clk_init = fu540_c000_clk_init,
 	.init = fu540_c000_init,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config at91sam9260_config = {
 	.caps = MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config sama5d3macb_config = {
 	.caps = MACB_CAPS_SG_DISABLED |
 		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config pc302gem_config = {
 	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE,
 	.dma_burst_length = 16,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config sama5d2_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
 	.dma_burst_length = 16,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config sama5d29_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config sama5d3_config = {
@@ -5444,25 +5438,21 @@ static const struct macb_config sama5d3_config = {
 		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
 	.dma_burst_length = 16,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config sama5d4_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
 	.dma_burst_length = 4,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config emac_config = {
 	.caps = MACB_CAPS_NEEDS_RSTONUBR | MACB_CAPS_MACB_IS_EMAC,
 	.clk_init = at91ether_clk_init,
 	.init = at91ether_init,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config np4_config = {
 	.caps = MACB_CAPS_USRIO_DISABLED,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config zynqmp_config = {
@@ -5472,14 +5462,12 @@ static const struct macb_config zynqmp_config = {
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config zynq_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF |
 		MACB_CAPS_NEEDS_RSTONUBR,
 	.dma_burst_length = 16,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config mpfs_config = {
@@ -5488,7 +5476,6 @@ static const struct macb_config mpfs_config = {
 		MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
-	.usrio = &macb_default_usrio,
 	.max_tx_length = 4040, /* Cadence Erratum 1686 */
 	.jumbo_max_len = 4040,
 };
@@ -5517,7 +5504,6 @@ static const struct macb_config versal_config = {
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config eyeq5_config = {
@@ -5527,7 +5513,6 @@ static const struct macb_config eyeq5_config = {
 	.dma_burst_length = 16,
 	.init = eyeq5_init,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config raspberrypi_rp1_config = {
@@ -5536,7 +5521,6 @@ static const struct macb_config raspberrypi_rp1_config = {
 		MACB_CAPS_GEM_HAS_PTP |
 		MACB_CAPS_EEE,
 	.dma_burst_length = 16,
-	.usrio = &macb_default_usrio,
 	.jumbo_max_len = 10240,
 };
 
@@ -5575,7 +5559,6 @@ static const struct macb_config default_gem_config = {
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
-	.usrio = &macb_default_usrio,
 	.jumbo_max_len = 10240,
 };
 
@@ -5662,7 +5645,7 @@ static int macb_probe(struct platform_device *pdev)
 	bp->wol = 0;
 	device_set_wakeup_capable(&pdev->dev, 1);
 
-	bp->usrio = macb_config->usrio;
+	bp->usrio = macb_config->usrio ? : &macb_default_usrio;
 
 	/* By default we set to partial store and forward mode for zynqmp.
 	 * Disable if not set in devicetree.

-- 
2.53.0


