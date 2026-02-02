Return-Path: <netdev+bounces-256014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC22IG8bgWm0EAMAu9opvQ
	(envelope-from <netdev+bounces-256014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 22:47:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37026D1C55
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 22:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C38EE3015C9E
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 21:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AFD3009DA;
	Mon,  2 Feb 2026 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmaFB0UJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103C314D0B
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068816; cv=none; b=OtSeTGHNYwh6e5XART2TA6WOBFxHHR46mizwEuFky5vtvk1vovwx14gzE5R0aTHEnFw6gDTC1b695RGHEwqm6kL40TfqbWL/G13v5O976dyujw2j4JUsHKVhvA4rlrs8SE9ijqBEzZrsyETgIm8vSfJjnhl+bSbfUxoZNSNzx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068816; c=relaxed/simple;
	bh=gBGCPpGyRHwMDIBD5kcKShgONrYAgcwaovDBHoI9j5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cv8sx+GYRBI/PmucTWn+iLYFI+ZzJNqlZcaoKBA4TAPpbCCENuSmtcE0MyvvY4kATOeKgOQEHY5Wf56yR16lrY6HA+nbF2WZ6CFPTCoS/ScKXsM64/BjOxuPId6XPbcZKOmrjjekq3r1JeBQDmQXbbZ8/lpaoHw/jCEFEXZ606A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmaFB0UJ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c2f335681so2590438a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 13:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770068814; x=1770673614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYwkWIa62iKMGNb+/cN0lfCIRQboySo0Z2wCV3jAcY8=;
        b=DmaFB0UJFLFBKIlJroRai25z0KwwC8GWpCjIV1mC3dlYO7lzHXNYH7FthkaYWjJu4i
         wCRV0NpASQW55ImwUlMJ74N7s2CJFCH3HUD2wtz/UNGfUFlDs1JgTdrlWGD/ZdcEV7bY
         buw9UGfpzR53Nazn5D1rA5pWjF59BxNWeQ+gXBWhKZ8IqAzYo/qYntV6YfzMbOKtggeB
         IAYjhWpsi5gh8qF15BYqvV3FKh9G+0vv0uqBD7aF3/ZbvId341AoGeMwTlai6cBWEBj8
         1eNIEP9B/KN26XV0VaB6t6IY036R/IeYIaBAN+keYJSQR0XwdD+TgdJ52iiWOR18XP7c
         qECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770068814; x=1770673614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYwkWIa62iKMGNb+/cN0lfCIRQboySo0Z2wCV3jAcY8=;
        b=cW91/1KceLSD4g1fc1zqJWh5I+WTup6vkO9F3QFtQ3jQYTla46O6/8hsLt4rZedNwX
         dDZwek30V9J6TKJIHH1zCchgcInYyhyQ/1eBwn/oidOkxJyQDLw7q6sDTOuEIMyxqUnJ
         PfnXVx03c/nLs8Bwbd6CQV940QZ2N6JtgWUasuj6Xd7g0TiGAwm4HwgSpnmTxFL6htUC
         EHkDN5hINAeAMPuTA9u8kEyixuX4Yzcrbsi+NSvChyKo0eJeWUwDcoi06zZTXcypv9bE
         QMXDKxgcjIO/7xVaIm4fvPmbVvGdph6ScZ79ca4TeEVuaPByVkG0NQTGRFm36wcHzGhN
         BaKA==
X-Gm-Message-State: AOJu0YwLiCK+gP65RgPhSIVctt/AoCyQYCepyazCXxGe901Ej809jQgs
	7dzG0mVdLbW1YWBl/BomSfP1tlYuqg6wjoElJkf+wbo0Lmp5ODiqjOgID9xd+w==
X-Gm-Gg: AZuq6aJqeXiRbydjeuXvDzFOsz48VWDs6O51DYSHNwjJVgE2ETW6YohydNrx5NY2sft
	d/pHPU3PYsb7NpA8fop0cqML94nuFDF7jxtQp61ZBVZiHajSor59uVdYfo4hP6HLxh7gfgJQMhH
	inHbzt7ETZOnTwdQabtsnAPKyZUbHIMsYAAPTp71pUvoMtbLwzxlE7KfeJ6VtX/3lLZJTuhev6q
	q6IQa4ey9/cXW6Hy3+NZwc7m7aWktlOw7b4N7Il1CVtFFya7/KwWrPEyE4tnvofM6VMBbkpyjJP
	buGf5paIzZgyjzW6aZHvtqZJt7TalzxBRtY+7l0HCod2uFvjmFpqtF0F18Xe0EVthR11cJo8hwJ
	1jRM5luCZdflYfPaLuLjaKqkvFA/SLXgqrXYnriI6N6DIba5UmdI/3FTlug==
X-Received: by 2002:a17:90b:5446:b0:340:9cf1:54d0 with SMTP id 98e67ed59e1d1-3543b2ebd00mr11957551a91.1.1770068813848;
        Mon, 02 Feb 2026 13:46:53 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3547767cf29sm391215a91.10.2026.02.02.13.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 13:46:53 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT:Keyword:phylink\.h|struct\s+phylink|\.phylink|>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 3/3] net: ag71xx: call phylink_destroy on failure
Date: Mon,  2 Feb 2026 13:46:34 -0800
Message-ID: <20260202214634.72738-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202214634.72738-1-rosenp@gmail.com>
References: <20260202214634.72738-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256014-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37026D1C55
X-Rspamd-Action: no action

phylink_create has no devm equivalent and must therefore be handled
manually in probe and remove.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 7114f2970ac6..285a99ee35f5 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1921,8 +1921,6 @@ static int ag71xx_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	platform_set_drvdata(pdev, ndev);
-
 	err = ag71xx_phylink_setup(ag);
 	if (err)
 		return dev_err_probe(&pdev->dev, err,
@@ -1931,25 +1929,29 @@ static int ag71xx_probe(struct platform_device *pdev)
 	err = register_netdev(ndev);
 	if (err) {
 		netif_err(ag, probe, ndev, "unable to register net device\n");
-		platform_set_drvdata(pdev, NULL);
-		return err;
+		goto err_phylink;
 	}
 
+	platform_set_drvdata(pdev, ndev);
+
 	netif_info(ag, probe, ndev, "Atheros AG71xx at 0x%08lx, irq %d, mode:%s\n",
 		   (unsigned long)ag->mac_base, ndev->irq,
 		   phy_modes(ag->phy_if_mode));
 
 	return 0;
+
+err_phylink:
+	phylink_destroy(ag->phylink);
+	return err;
 }
 
 static void ag71xx_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
-
-	if (!ndev)
-		return;
+	struct ag71xx *ag = netdev_priv(ndev);
 
 	unregister_netdev(ndev);
+	phylink_destroy(ag->phylink);
 	platform_set_drvdata(pdev, NULL);
 }
 
-- 
2.52.0


