Return-Path: <netdev+bounces-268923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGviInpmumklWAIAu9opvQ
	(envelope-from <netdev+bounces-268923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:46:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 262B22B85BE
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6295B30B8DAA
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B2239D6C5;
	Wed, 18 Mar 2026 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlvTfxqS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015D39A807
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823352; cv=none; b=MgnfKRJmBbXCEbinELMsWwTUIypIPFG5OQLtWD90RQWmefZJjElLfVKfmGYXKjO/OHf4s7SjYp8Frw1EFivmv9BpkDjx7JUFCPIB3lTznqTigdDxwAenMj41UMDXJ9zb5VrlRiidarwnbGZPWz/ms6yGtewLSL0hPS/qnFSffkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823352; c=relaxed/simple;
	bh=FLSNbXbJ1wplfBqtjcLyvhHCLsdlffFOB/yceOu8h2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1/B3iFF9Vhbbel0oQhLYo1R6b8Df93O/0q1+hYjX2LsiK7WHr4S3G8xv4/GQ/KY2btV5Ic8OANY6GsAB4oMbLWBKkWbkDiXQsjezScehhhv6KAg5qINy8m1AK0Ib3EiFVN6AbHcQ6FJVwnsg8+ERrnpY4b5+JXFtcKyFTomLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlvTfxqS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c73f107789cso1236874a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773823347; x=1774428147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gacjDmEMQGmdBNRvJ1O5mHVdwFG2Gz17UEE6HRUs/Vw=;
        b=KlvTfxqSynKLuGflo1wectB1GS+4afX9H+7oojc3q+KkXzu8opEaTa8jGxWZyp61Vf
         Ygk3lEqKG8eQ87eLTWtxiaK4gkkFXjEIC7SqLjwntd1DUzyojmD8WtBlSCjcy6ahx9tl
         WFg/uDgAeWd5ILtnGNisMH8OtYOcaYmdsbKuJGcE0HdHpU+AMkUZpR81VM01xygme1Lg
         pW91Hnt0DJM45zR5ob0gX12lmeNPa/5jNjPICO0YAWUgexW6oNaDHblR4Z700x3xiEoX
         sOtPsq3iZqi640CzQtPrFq7E+if2b6f5baKFTO5FgtnJej24EeGor2Hfq6bE94pkbctA
         pluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773823347; x=1774428147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gacjDmEMQGmdBNRvJ1O5mHVdwFG2Gz17UEE6HRUs/Vw=;
        b=s2Jz9PnfPHASdFdTC+xmZ3WXT3tdZCWPdkNwerLU/pI0nS7KRBICK/UI1ii3Vv0CMF
         dZYWtxvpxFlYhl1/V9zWq+pVCqXi5ReSSch50sLLg/XtWaXDJOR2X/VU9iNnOLWw8wPM
         wffjCf5dMNYTBRq4JULP5y7LW/AhJ26Y1kEYFmlgDn3xjuBFJqJhcmaaZ/EvSAs1o5/1
         4aFuUj/cI1UyTgps/N9O+x8rcTxnUMWqvf63b0cxaCOhTqXBdU/jhI8OhbOe0329WILC
         BcEl8d1dtxM1zNgGzOlTPRyqK2VmSI21lp8Jrcd0djb0ZVCJ2jIv8SKp2hHyfilc8ehj
         OQeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXz0SQeuS5w/gzpYh4o6ZcBOsnN3Ce9Ec63Rl+1+2mRIMx/ddrb8k9S+s8kLVqpH1cv+e08xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmosi6qIsiUu89OspbEErJReeH/4O60tvAi7u3tqVH4aNTw4qu
	v5eVA4LHGenTR6eGqoxg4cGs1A1CIEv9uetPrPQhtZEX5DsvtLYnN2Gr
X-Gm-Gg: ATEYQzxkT7kJ8v59BliTKF4C9UsIy7kNkL9c+tl7wodjsy55Pv/qaeFVa2uKPDIMZy0
	Ezwz58gf3Bi/+Z+mKa05plUMhDO6NI2qIaLT6BNZBLptwYSu7fgMz8A6zWDXk79ALdJXeCNj6M+
	KP8O4gSXKo+HhU7SRGGv4KaiQ7ISdy5U8m1UpSNVjzUCbMgmKDFidEGVvbJa+5Tw1MV1RghojYX
	eGKTO0L+XMLmwHsNgB7TPbXPIg7cnZ0Oaihc7cplICfVqEi2k1OrqYb1wRxj0G3V9Wb6lfCqMMn
	SN3zDfFd0mQp1bp0wtDhNP1I2jX7Wzt9oeOUL+f29r5J2sbh+Kgeag8ysoOssec9Li7V/OEc2Eo
	ZMmU1GVWOp/g22jyBLg/rCwnD7b/32jyLPKfERyrFbxOi1tuwwaQ9aTR1jHHRafgwkVM65hbqYT
	bbXwcZJJ3QLPw738CT5XI4yGwg
X-Received: by 2002:a17:902:d4c5:b0:2b0:6ba2:3d3a with SMTP id d9443c01a7336-2b06e30a339mr25574145ad.14.1773823346954;
        Wed, 18 Mar 2026 01:42:26 -0700 (PDT)
Received: from ubuntu.. ([152.58.155.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e5f0ac2sm19580465ad.52.2026.03.18.01.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 01:42:26 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: jonas.gorski@gmail.com
Cc: florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anas Iqbal <mohd.abd.6602@gmail.com>
Subject: [PATCH net v3] net: dsa: bcm_sf2: fix missing clk_disable_unprepare() in error paths
Date: Wed, 18 Mar 2026 08:42:12 +0000
Message-ID: <20260318084212.1287-1-mohd.abd.6602@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAOiHx==pVOOtvOb3eooRGt8EcwjTtkY-33Nn+Cu_m3pu2gVtpg@mail.gmail.com>
References: <CAOiHx==pVOOtvOb3eooRGt8EcwjTtkY-33Nn+Cu_m3pu2gVtpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268923-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohdabd6602@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 262B22B85BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Smatch reports:
drivers/net/dsa/bcm_sf2.c:997 bcm_sf2_sw_resume() warn:
'priv->clk' from clk_prepare_enable() not released on lines: 983,990.

The clock enabled by clk_prepare_enable() in bcm_sf2_sw_resume()
is not released if bcm_sf2_sw_rst() or bcm_sf2_cfp_resume() fails.

Add the missing clk_disable_unprepare() calls in the error paths
to properly release the clock resource.

Fixes: e9ec5c3bd238 ("net: dsa: bcm_sf2: request and handle clocks")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
---
v3:
- Add Fixes tag as suggested by Jonas Gorski
- Add Reviewed-by from Florian Fainelli
- Add proper separator (---) for changelog
---
 drivers/net/dsa/bcm_sf2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 960685596093..de3efa3ce9a7 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -980,15 +980,19 @@ static int bcm_sf2_sw_resume(struct dsa_switch *ds)
 	ret = bcm_sf2_sw_rst(priv);
 	if (ret) {
 		pr_err("%s: failed to software reset switch\n", __func__);
+		if (!priv->wol_ports_mask)
+			clk_disable_unprepare(priv->clk);
 		return ret;
 	}
 
 	bcm_sf2_crossbar_setup(priv);
 
 	ret = bcm_sf2_cfp_resume(ds);
-	if (ret)
+	if (ret) {
+		if (!priv->wol_ports_mask)
+			clk_disable_unprepare(priv->clk);
 		return ret;
-
+	}
 	if (priv->hw_params.num_gphy == 1)
 		bcm_sf2_gphy_enable_set(ds, true);
 
-- 
2.43.0


