Return-Path: <netdev+bounces-283550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFm+K0bp9mnhZgIAu9opvQ
	(envelope-from <netdev+bounces-283550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:20:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 130A14B496B
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 553243009B3C
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 06:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB43A8722;
	Sun,  3 May 2026 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGy/2Eyq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AD93A63E3
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777789133; cv=none; b=VEHGP1kOYJI/WEK3sKBV73v1/NmUlnls/Wi9BSX4mH8BTJ/6S6OMda4kxFcm0+lX8kPp+TMbMIhoRd6o3R0OC2B2qXx6ZL1cPEMphwOYRduJDWCHG8dACMPiI0M279HVBrUL77Mh9yuWmWqUXIx63Kpk8qSvP/Mc+6DRNGeHlF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777789133; c=relaxed/simple;
	bh=qwDzsA2taPaL1eST2ggBq0akW+5G1WR8cblm690fHtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYHYZW2S5xaV1Qyl4BPTXphwMNTKXxdu4kDKlCGeDdQVdwA8UJNQ6LzNjXOCkNVYA4JelUbb6f1fXWTUaQDqWjbyCOSjomeWcnHTCG4MQlPQW32NelT9i7VomYEpuiN/m+QJC5wTweWs3UFRCx+carsT1yHEXKF7D3SoCj7S9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGy/2Eyq; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso3455139eec.1
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 23:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777789131; x=1778393931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7ITjrpEoQ51KJnIIcurR4KO11CHvDe3s/7wP1+6xW4=;
        b=cGy/2EyqkSPJIyqKD5vhPTMLWWCBoEU7dNkK08Jgv7f/LpSLfmVMM+BMK7Qi/f4ySk
         oIyBggcDk9uJ6tPb5yh+ttLLvEXEO3/0i5hKHmdoPtCbc5e+INk1ZlbpWCeKlsl9EmXX
         7K4oKu3nQyM/ZJcYi2t6wPS/yefmWzRpz0WAmsTlWqFUCG8x5LBDu0NP42AnLp4ooXSj
         CEA+eEIglSrcMjCS1yXAMHQZOQl1aDUCRdvKAYoFLl/biFhAcrNHGgiWoohxwU7kX5QL
         0kilEVXi9Kmc6tOSpoG2g5HoR0EMJVJoDeySoqT2SfPnmZeutxYxttaOA3Cbwz4BuXDM
         0GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777789131; x=1778393931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b7ITjrpEoQ51KJnIIcurR4KO11CHvDe3s/7wP1+6xW4=;
        b=KoNdKM/6HcwqqI2xRWmu+dXB5NM+aw8GrXLAI/y18ulLQpWLQiA69OrxeWsAVrbdzm
         3w4FrM6AE5I3Sr6KBBcOOnwUpaoGRH6DJrrhMrQbj/8A3vvM7Tu7sd8wyZywBUFZUNlm
         vYWCFX5qwjjlu5Cv86mjDVicOWnaBI2/WbE6mkMYqIeJlsNES1zEsbMGW2EZGP1Ihqhw
         p8B+l1Dq19mldBa52uk5oPWzfQVr37/AqRZP2jrlEgEwZ0kHJWvUeF6TRys2pjHfqET3
         V+0LEgefHU4LaAxTgHTc4U1votopcG5wwjmSPVDXXDmpR+Me67MkmJl83U3osZo+wZml
         yROg==
X-Gm-Message-State: AOJu0Yy3DZCv7at+kJCxQeKqTTrg948Hl5NLI8PX2eSlagTHDKYTg6ZU
	7jGSp5mDGngjk/xd4qIxAUHu8bAEpA4IwqMZH298OQ2PhrGatM/fboKS
X-Gm-Gg: AeBDievDwMenRbULSUr9EFlBNkDSfNs4th5jR7IP0HAZJojWNUTRVrQ+Dd0ny2j3Ybt
	eohreqSt8b+hZ8uGyn8ID/zwxEQfKKd49si77+6a0CeoVJTEksjyJ2YTkK4OxJwkKWUyM2qaUP3
	dTcYHHfarsnHdd4q/EQLfLkueEeVSGzmHOcAPHn+r0+yxjnanZ6Et8U6Gc98khKwJlvQbHcdlov
	wCNFtJ8iEvsqNlpct8qz5HF9c4OKjCx5BgZI9PCMSLumikbfUVJbicUpG+jPUvxmem2XH+G7M5K
	3X7UT3XriFny/kED8NJ5PlPRrlW1lAvJlNVZUoO7Cgs4pot5ElITc2Jt8ptVmxy7MbghnOWK+he
	MtxRXRgwrrbAgqnW8Y9zGuIG7Ls6CWghEmxvcUrtrXdxvZt+jBGhUZ71Gqa4ylvvP0yIcX2n19h
	Yej7zH7hMtnlsyC5U8Udc0OpCQVB7Ol03bhv/nVIdtRpkbFCMlEg==
X-Received: by 2002:a05:7300:5b9e:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2efb80ba515mr2101939eec.8.1777789130949;
        Sat, 02 May 2026 23:18:50 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bf6811fsm11100344eec.29.2026.05.02.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 23:18:50 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 03 May 2026 03:18:23 -0300
Subject: [net-next PATCH v2 3/8] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260503-realtek_forward-v2-3-d064e220b391@gmail.com>
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
In-Reply-To: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 130A14B496B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283550-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Rename rtl8365mb.c to rtl8365mb_main.c in preparation for subsequent
commits which add additional source files to the driver.

The trailing backslash in the Makefile is deliberate. It allows for new
files to be added without clobbering git history.

Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/Makefile                          | 1 +
 drivers/net/dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c} | 0
 2 files changed, 1 insertion(+)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 17367bcba496..3f986e04912f 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -16,3 +16,4 @@ ifdef CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS
 rtl8366-objs 				+= rtl8366rb-leds.o
 endif
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
+rtl8365mb-objs := rtl8365mb_main.o \
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
similarity index 100%
rename from drivers/net/dsa/realtek/rtl8365mb.c
rename to drivers/net/dsa/realtek/rtl8365mb_main.c

-- 
2.53.0


