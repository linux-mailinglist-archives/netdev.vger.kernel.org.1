Return-Path: <netdev+bounces-293499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BTlIEn0HGrxUQkAu9opvQ
	(envelope-from <netdev+bounces-293499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:54:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA47618F00
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E3123007B2B
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 02:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8AA23D7DC;
	Mon,  1 Jun 2026 02:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ/e8QXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3EB233924
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282423; cv=none; b=HHUXlNyAxGF2s2HJGUNuD+rWTABmxTqWju9BBEg+WDY9GDCMxgt/38s8gUIyzRfGcH3QZ06LmgOQrW4ns2LLQgZSq4mdFBMMgimKzcBzx0zJ40Ftgz9FOd0a5TYKraN5zksumLFFbgK6tXqpzPTbeZmjFGCDg1FXU22cKy8eqLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282423; c=relaxed/simple;
	bh=6vvUpEnA3zuZyhkh5L9tx3acH0/PiR28xnODKHfdVgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpcvZlAOKWvLwNjxnawfxo8Q8ngKc3/nODSdrNDa3jHlwC2336r3KjPt1xbGEdred1rXUrXHXFEWt0nYFSPFW9EWnI1XLCH7WsTtfcsu/n7wK6jmDNniIkOQhS83EHWqWv1gtp/rweVJ2Mec+waQcJyPPEdxMj2ZF8jrAvlpwmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQ/e8QXJ; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66077f6c438so576459d50.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 19:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780282421; x=1780887221; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgdsNgCTJpv8k0KRcqQg2bYC+LqfZpfIBBy5KwRLQzE=;
        b=cQ/e8QXJ1QTCAtv81BcypunUHPID91NN5YSB7l6keIrgg7A4GoUm4K2tiqKr0Vj3k/
         l/rKdwOXBpwxdja8w+i433AILUmFyMZhRU0xhv3OMirrChD98plnrYO4NZXtGUjt3HtK
         03umuBgyDJj1BLFcHA7MaQAW4v7ulMtYXpIcZmXSbdM/mVq+33P7e8vZDnPdrzRO8BhX
         r0nRwwKMURczmLXfVjd0jHA8bBmRZIQMdMzwE4OZAqgJOlRe2n02eCqz4QOLVBhZWklc
         knqMmTEDAQLH2Gq8NvNqlM4LuswwqhrEhRL+u1DxXqTjPAyQCTVEutNX7klYG9qhP6xq
         tDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780282421; x=1780887221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rgdsNgCTJpv8k0KRcqQg2bYC+LqfZpfIBBy5KwRLQzE=;
        b=P1k1rBaSHIsA4ceBl5HxV4b6oSOwEraNK5fUbC4aV0Ou+LnyIQ6KxXmWkw3a7ad1E0
         69TzJYhgjbB8ziMPPqvfTpvpnRw4dir6bqxruVuV6eL1NX3VVpGvKVOg8x44EK8WDg8D
         TC3uJ12SEPudSrFUr9TA1Y3EkWCxbx5hOTzdDrp+cS9IQWnmQkmkR2eCEConNXlwJekx
         KoNHCkBv42Z5ewPA4/EfL1zwSTe5O6GV0UH5RhlKdRUvE2MdGAv7ARiOULIQMNsRlYTt
         S6dvwwMNwnbJ0UfjJwO3Cy19hbQLaVG7vSDjnURbGJ+u/xNPkcpnsGdWMOVhOuU4qmEP
         ncHw==
X-Gm-Message-State: AOJu0YzT9JMpbm2/tH/y6HJkLmUQ3bVKKy0aJmvtR7fK0NzD6/E6PhWY
	x/9xSMxCFS1zk2ar9YFXMJmFrSIvcpzxwL9RB1si8Jtafjsfv4qHnaZItVCiSilmEwQ=
X-Gm-Gg: Acq92OE++oQUarNTlBNVamCDgxoSgfyZWITaNztRSjDa7kh8YBj0w3UsLLIr2x1aGkZ
	euvk2w5KYx+3KT12ErSYTR8iBXcUm6UImoCp+ItLd2Xqou8aa+Gf61T/d+pj1P3Swhg7zo1nOlQ
	dEcDmpLpWEWVaTx6gN4KJLhXUmDhFmN/RsnNU2JxApYYigJHjOV1iJmDlp0bBhmShOiOSAgdAgQ
	vDiPBT5bEW/I25/WnhYN/SzwI3TKVFf56i8LRBzIC94apwwr2L9Mqu1HISx84fPmE3QUX4sTc83
	LIkoKUT8H9zxbOe0voMwQBi7FOXxNEFPVekMA58dWHLuZm0CfkQ+c8WAICyiL0P28layl2315oA
	90rXZziVAtM+BoFNP02l2NgCFQTN4AFjxtwW3JKNcRVHjwNpNeN6CeZOiMSOLwzScOg7dWDnlnp
	i30tol1QYLVuLylP0HXz+141NLtSYVwQND5r0rg2OgeMvbs5wOrg==
X-Received: by 2002:a05:690e:4086:b0:660:8e05:d0da with SMTP id 956f58d0204a3-6608e05d7c5mr1635382d50.59.1780282420651;
        Sun, 31 May 2026 19:53:40 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6606977ab05sm2952518d50.9.2026.05.31.19.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 19:53:39 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 31 May 2026 23:53:16 -0300
Subject: [net-next PATCH v11 1/9] net: dsa: realtek: rtl8365mb: use ERR_PTR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-realtek_forward-v11-1-50d60f5717e8@gmail.com>
References: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
In-Reply-To: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293499-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7FA47618F00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert numeric error codes into human-readable strings by using %pe
together with ERR_PTR() in dev_err() messages.  Also use dev_err_probe()
instead of checking for -EPROBE_DEFER.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 51 +++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 0da048da533a..2637884fe472 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -803,8 +803,8 @@ static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 	ret = rtl8365mb_phy_ocp_read(priv, phy, ocp_addr, &val);
 	if (ret) {
 		dev_err(priv->dev,
-			"failed to read PHY%d reg %02x @ %04x, ret %d\n", phy,
-			regnum, ocp_addr, ret);
+			"failed to read PHY%d reg %02x @ %04x, ret %pe\n", phy,
+			regnum, ocp_addr, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -831,8 +831,8 @@ static int rtl8365mb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	ret = rtl8365mb_phy_ocp_write(priv, phy, ocp_addr, val);
 	if (ret) {
 		dev_err(priv->dev,
-			"failed to write PHY%d reg %02x @ %04x, ret %d\n", phy,
-			regnum, ocp_addr, ret);
+			"failed to write PHY%d reg %02x @ %04x, ret %pe\n", phy,
+			regnum, ocp_addr, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -1082,8 +1082,8 @@ static void rtl8365mb_phylink_mac_config(struct phylink_config *config,
 		ret = rtl8365mb_ext_config_rgmii(priv, port, state->interface);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to configure RGMII mode on port %d: %d\n",
-				port, ret);
+				"failed to configure RGMII mode on port %d: %pe\n",
+				port, ERR_PTR(ret));
 		return;
 	}
 
@@ -1112,8 +1112,8 @@ static void rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 						     false, false);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to reset forced mode on port %d: %d\n",
-				port, ret);
+				"failed to reset forced mode on port %d: %pe\n",
+				port, ERR_PTR(ret));
 
 		return;
 	}
@@ -1143,8 +1143,8 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 						     rx_pause);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to force mode on port %d: %d\n", port,
-				ret);
+				"failed to force mode on port %d: %pe\n", port,
+				ERR_PTR(ret));
 
 		return;
 	}
@@ -1299,8 +1299,8 @@ static void rtl8365mb_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *da
 						 mib->length, &data[i]);
 		if (ret) {
 			dev_err(priv->dev,
-				"failed to read port %d counters: %d\n", port,
-				ret);
+				"failed to read port %d counters: %pe\n", port,
+				ERR_PTR(ret));
 			break;
 		}
 	}
@@ -1652,7 +1652,8 @@ static irqreturn_t rtl8365mb_irq(int irq, void *data)
 	return IRQ_HANDLED;
 
 out_error:
-	dev_err(priv->dev, "failed to read interrupt status: %d\n", ret);
+	dev_err(priv->dev, "failed to read interrupt status: %pe\n",
+		ERR_PTR(ret));
 
 out_none:
 	return IRQ_NONE;
@@ -1725,10 +1726,13 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	/* rtl8365mb IRQs cascade off this one */
 	irq = of_irq_get(intc, 0);
 	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(priv->dev, "failed to get parent irq: %d\n",
-				irq);
-		ret = irq ? irq : -EINVAL;
+		if (!irq) {
+			dev_err(priv->dev, "failed to map IRQ\n");
+			ret = -EINVAL;
+		} else {
+			ret = dev_err_probe(priv->dev, irq,
+					    "failed to get parent irq\n");
+		}
 		goto out_put_node;
 	}
 
@@ -1790,7 +1794,8 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	ret = request_threaded_irq(irq, NULL, rtl8365mb_irq, IRQF_ONESHOT,
 				   "rtl8365mb", priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to request irq: %d\n", ret);
+		dev_err(priv->dev, "failed to request irq: %pe\n",
+			ERR_PTR(ret));
 		goto out_remove_irqdomain;
 	}
 
@@ -1966,14 +1971,16 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 
 	ret = rtl8365mb_reset_chip(priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to reset chip: %d\n", ret);
+		dev_err(priv->dev, "failed to reset chip: %pe\n",
+			ERR_PTR(ret));
 		goto out_error;
 	}
 
 	/* Configure switch to vendor-defined initial state */
 	ret = rtl8365mb_switch_init(priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to initialize switch: %d\n", ret);
+		dev_err(priv->dev, "failed to initialize switch: %pe\n",
+			ERR_PTR(ret));
 		goto out_error;
 	}
 
@@ -2091,8 +2098,8 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	ret = rtl8365mb_get_chip_id_and_ver(priv->map, &chip_id, &chip_ver);
 	if (ret) {
-		dev_err(priv->dev, "failed to read chip id and version: %d\n",
-			ret);
+		dev_err(priv->dev, "failed to read chip id and version: %pe\n",
+			ERR_PTR(ret));
 		return ret;
 	}
 

-- 
2.54.0


