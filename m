Return-Path: <netdev+bounces-259667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IqzBywcmGnp/wIAu9opvQ
	(envelope-from <netdev+bounces-259667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:32:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8E0165B02
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28390307AA54
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D713358D3;
	Fri, 20 Feb 2026 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FPIAKQM8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BA933556E
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576090; cv=none; b=WwyFtUZ6RPM2AZ4UZDFa3+jLGQ3u0Yu1w4H2IJb/Ou3CoFAqSLdKqUPhkEADh5u78ENx/UIXeftP3gTpEl7BVhtmojSEwt2iQfCSLMfjEWqp994R9sskarpgB5Lk5kDGpauT02CB5NOmEqkSc0WVMDpi2uwrrddM6B5ex9jE+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576090; c=relaxed/simple;
	bh=0m9SXNeE/1HuxmVVgd6EQeU2mfVVz/U5fwVARClwTUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QaO7wAqpIGe640fIoBcU6ZV2akeyFGbiCqpQoZO1nbxiVHBQmoBD174eTZn/rNMs7TcbOjGgwyLX+NINSQUzXzKNRXdhU2n2nijfhKHGUZoN59mkvZU9g2I/a7+pSZc/TLaZ2rI+lk7GptJrNm3yvIZ36b0fBzjJbgu7nfa4WY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FPIAKQM8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4362197d174so1153744f8f.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771576087; x=1772180887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kucOBfKNVCMhrq/sy0oackHKIElCYKPpoLdnzqCWN7A=;
        b=FPIAKQM8tbI+Ag4tbuMQBsZI4uo5VZ2/ZC8ajnfP1WtyjB60NpY8IpC767cJ/qOvaf
         +JIaYJzzOEgmHrNTtJ5LK75Fc/Ghj+0b5bjiwDfvwhG3yIM1tKPJTOPamNLNkf+MokqX
         uy8V4k4A8nae45wpMJJXIMXaZWKX9bpKGreKR01Ia5LYHzlTUBpfESM8csG8hDesllEZ
         gKotvWTFeotD0aXv3VzLbXfi5GBIDxpfo/toiMt4xmwYGG/3TIMh08Vg4BJKAMZ8BBFi
         yJSpVKnKJHrRKDotGsa8J/JEu/Ud6yLZowYBcQKDVhE28tugBdjeP/qBx/yJVbdZc2ju
         kxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771576087; x=1772180887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kucOBfKNVCMhrq/sy0oackHKIElCYKPpoLdnzqCWN7A=;
        b=sDPF31qyEEM07Zq0zwUzY2GxpQnnhi7Du5bFpjay5+fDtZ/q2/xP5EaaBXRTt1Tw6M
         HJCOzO80hnzbrHpJwg9gx+1Aa3qGm2mvce8EMJe7QqkWXHsZYThwfaD0ArXbmrf60hr7
         7MoZCu/70FRfvZjpjNIw2+hhdqkN/kAZTUZ2Q+7GwFW3xp7OpQsPfOmynxu0TvmD+jTS
         cg5xullLADKcNWJxgSJkqvjTfiwlCp/SL0uttwRvjBVgbJtAPNe1W59ZyRBOcWcOzOWg
         pd2mxmZkrsvknq80ted7CBVAwfTeALo1/Le+h8CJuMXaljPGuOT2tF4/7TaebzD7hybh
         AXXg==
X-Gm-Message-State: AOJu0YwiyHy71Dv84CjKgmJ+jNUeqWaN463dCNqsgG8w6JLB3yU1BGkw
	E/gaL9x1ZYwDN3zAEg7CXE0kferPDBj4waj4lER87d1vhsSUIrCcBJPOKrJQS5zhIAk=
X-Gm-Gg: AZuq6aILRjBZ7tmF7j9R2dzdiabvXUhH3Dax+9TU+cxQD3QAGZ872eTXIFH413093c/
	fvbMDM/EwzFfbMNw3l8leMUCQle9vseZbDy3SVIM0KgZUeUDEfe6ZT6+KpqkbnbJZNXpo5uUyvU
	G/zWqePq3K2mje2soe2xDnlLlMrzTllB+u2SQO9GPW1AAvprL1lhNfk5ypumLXYBmJp68Yp3YLR
	PBduOYwDToQ2BEwxEtntqSktJpGfk08f3aXo3gTuN87MKZXGTTeZBa0BxyPHhNiN7wzRepo9Wrs
	ympOcqNGS+G+xLUV5SqISL29rp4SrWzdGxrv9kDIa1q0h7pdumNJwcJ7MCTLU2IjBQ2b6A4J5F2
	6lkgNNRr3eSWVbOqDgZdY4urAMprmIGKTs+sNZlN5P5QrEf5jTPhlqARo9y2CyJ+1V9O7Fkasrr
	sOTJvLFaGPtv1LC6NT1vcG
X-Received: by 2002:a05:6000:24c1:b0:437:81b0:6638 with SMTP id ffacd0b85a97d-43958e541e9mr13914164f8f.59.1771576086872;
        Fri, 20 Feb 2026 00:28:06 -0800 (PST)
Received: from [127.0.1.1] ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1bfsm54717688f8f.13.2026.02.20.00.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 00:28:06 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 20 Feb 2026 16:27:07 +0800
Subject: [PATCH 3/5] net: macb: Add support for SiFive FU740-C000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-fu740-v1-3-c8af54130c58@sifive.com>
References: <20260220-fu740-v1-0-c8af54130c58@sifive.com>
In-Reply-To: <20260220-fu740-v1-0-c8af54130c58@sifive.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Thomas Gleixner <tglx@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Conor Dooley <conor@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, Max Hsu <max.hsu@sifive.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2939; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=0m9SXNeE/1HuxmVVgd6EQeU2mfVVz/U5fwVARClwTUI=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBpmBr8KrQfSF56ZFRp7zsifCcNkjxhIe9isJ/dR
 /Xauu9FbtqJAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCaZga/AAKCRDSA/2dB3lA
 vY0fC/9G0xFFMdVahjzntxTBBBwK1F7PW8C7zDUURKiLa8PkirTxJxTourqf4rQb2XgFbwLO0rN
 us4GMZapSvbla4BFvmyqGflep/5R/NUytr0oUofbP+aszYNwhy64wx+9EsJ8m06/dawIB6Ijc0i
 v4NFVg9sY/qP/AvpcNnza98E35pHbJrRPzkkla5r/RuOYDOZmqahA7xNbeR68Bhl5CYfs5OK0uU
 hz+bQGglKUjorGsOdwVMXVSfnAzhzssdWBYS1dpwN/mw8vSwHSTcyK/No3seAEFAAtxkDll8c58
 EqMwp00Fn4lQwl3cRrNCMvL7gK0e8olM3Yj7ZWt9clJf+phxFQibD6hu4Qk6af224t9ZaFN2IM/
 8P7vdlJRFc6wUcSrx2a8yMSJXpl9ARr15zMKVOmOERjn4mOuBVA6iAVC5Vb1EXEgGUvqD3hkMAe
 tsXWsIwDXasWBbXpx+Ny84ejE0h8Plckd3fkHi9XhHKJXsYjAXFaJCYf6aVAQpczzEkQQ=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259667-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[sifive.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.hsu@sifive.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:mid,sifive.com:dkim,sifive.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF8E0165B02
X-Rspamd-Action: no action

Add a distinct configuration for the SiFive FU740-C000 ethernet
controller to comply with the SiFive IP versioning guidelines.

The FU740 ethernet controller uses the same management IP block as
the FU540, which is tightly coupled with the Cadence MACB IP and
manages boundary signals. To avoid code duplication while maintaining
distinct SoC identification, this patch:

- Renames sifive_fu540_macb_mgmt to sifive_macb_mgmt to reflect
  that it's shared between FU540 and FU740
- Adds a fu740_c000_config structure that reuses the FU540
  initialization functions
- Follows the established pattern in this driver where multiple
  SoC configs share the same init functions

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..10d049391a73 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -39,8 +39,8 @@
 #include <net/pkt_sched.h>
 #include "macb.h"
 
-/* This structure is only used for MACB on SiFive FU540 devices */
-struct sifive_fu540_macb_mgmt {
+/* This structure is used for MACB on SiFive FU540/FU740 devices */
+struct sifive_macb_mgmt {
 	void __iomem *reg;
 	unsigned long rate;
 	struct clk_hw hw;
@@ -4650,7 +4650,7 @@ static const struct macb_usrio_config macb_default_usrio = {
 /* max number of receive buffers */
 #define AT91ETHER_MAX_RX_DESCR	9
 
-static struct sifive_fu540_macb_mgmt *mgmt;
+static struct sifive_macb_mgmt *mgmt;
 
 static int at91ether_alloc_coherent(struct macb *lp)
 {
@@ -5236,6 +5236,16 @@ static const struct macb_config fu540_c000_config = {
 	.usrio = &macb_default_usrio,
 };
 
+static const struct macb_config fu740_c000_config = {
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
+		MACB_CAPS_GEM_HAS_PTP,
+	.dma_burst_length = 16,
+	.clk_init = fu540_c000_clk_init,
+	.init = fu540_c000_init,
+	.jumbo_max_len = 10240,
+	.usrio = &macb_default_usrio,
+};
+
 static const struct macb_config at91sam9260_config = {
 	.caps = MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
 	.clk_init = macb_clk_init,
@@ -5411,6 +5421,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,zynqmp-gem", .data = &zynqmp_config}, /* deprecated */
 	{ .compatible = "cdns,zynq-gem", .data = &zynq_config }, /* deprecated */
 	{ .compatible = "sifive,fu540-c000-gem", .data = &fu540_c000_config },
+	{ .compatible = "sifive,fu740-c000-gem", .data = &fu740_c000_config },
 	{ .compatible = "microchip,mpfs-macb", .data = &mpfs_config },
 	{ .compatible = "microchip,sama7g5-gem", .data = &sama7g5_gem_config },
 	{ .compatible = "microchip,sama7g5-emac", .data = &sama7g5_emac_config },

-- 
2.43.0


