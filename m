Return-Path: <netdev+bounces-117283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEFA94D771
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7901C22546
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA4E161328;
	Fri,  9 Aug 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSyuUQ5z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2615A876;
	Fri,  9 Aug 2024 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232307; cv=none; b=QWhNJtF5JOikMV5ob+WSiRkRHS7m7z/8YvB63hphXobeeixdVX25/vduVrovNs/aEEmXkDRJgslPeO8jXtYQ/ToPLgQdCO4LTuSUsfrvUt3X2VVOhAB+08PD39c6Yi8rsNpRXpO6dCoPfmyYFg/lZfPDTSucUNBDfcqLbmRPn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232307; c=relaxed/simple;
	bh=Zz/cv3UXzDZf9i2qPD7wfnCs58Gt9LLq/F8Owr2MssE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrr9/gTBfRh5MZEUBZx8OuCtqUYAWLE3Aglspsj4BrkdNzFu8jJY3Kb4dAUQKKl9IVVm2PIJfGCt0AHgVJbD09wwJWUeozZpahdRSr6i1vb9ys5ocDgKlnSNUoSriXL6gyCOHjB79DsjIFlBuoDjb6X9l7gsTcL7Jg5PqSM1wSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSyuUQ5z; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso25610711fa.1;
        Fri, 09 Aug 2024 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723232303; x=1723837103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgC3swiv5SXbh7i4mE8QJwRNEjiR6PHybrqQb9FZqrY=;
        b=LSyuUQ5zWpxUKLv7gPqDZEzwksyTODN8Jxfs3x9rs++1ySBaTBBRvykkpWcOB+VUNj
         BtXVzExjfsUlGJdp5cSRNVlfi+9j94nJMvjTiMcnzK81LcUas937et6eH0llYLek4PKm
         U7BvJLFUNELb6eP24R6SLC04ug9fjcPWQZZK9F7Azjkv5eulsfZP4T3VbsKJelTWJHhc
         HyPfbCiTveCdr8QBArv75OYWEWaPRTXMERdfgjJNkTOOE9uvc26a5p6p9cgEegy8uz8u
         e54QujXVJnOBnNbnqDIEqOc0b4wKV/c0z+qCS8JD9Pbo2pBfRvSzGa6VFwnlmQwPqEMp
         f2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232303; x=1723837103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgC3swiv5SXbh7i4mE8QJwRNEjiR6PHybrqQb9FZqrY=;
        b=KoxFLjFjXyCVj0P1cRaGJ5KyI+XaXmzcEKa2hljaQ5kGchoF8cFipXFXfTWm55Qn7R
         frE52HblcnNANW23KQPCC1zdaAJ98snAak4fUDkWEwyPF2dsvXO6MRuTDCDS2ln5I8Xe
         o5WFrfLJs09QoqaWWE6NVbW6dPfCoGyqC54a04HpzpvAYvgyF/GqcWOciE9BU+p/x5K1
         PkjUeFulh7aIGvR0nflTN+vf2EQfLHOTv7+Gr2niAsRipojhMqXDVnMXzXRu/EasM+Fs
         vQLbael3ntLgJmi3bwLywfUXoPQTOpo7UIZj+o2yc0Raxo6CHYd5DU8DgRGPJ/1Jfpal
         J18g==
X-Forwarded-Encrypted: i=1; AJvYcCVIvNTDNMkuqaTJb1gZXh6OWHTGd3XO78cNC46CN5I0gGLfmnycXfG8Y8PhKAzKZMLlGlvpG3Zt6cYsqLIoerJWx16/0VQ/lr7DQcIG
X-Gm-Message-State: AOJu0Yyr6B/ExsH/LviUJKwSNKSNbrCL7IMvI72Sa9VyxBciJmQflRkA
	5QL8hUorY7ZjrxKyu1bW+VeMToIPxEpousIEIYQfzpe4bkGaXm9SEzlhK+mh
X-Google-Smtp-Source: AGHT+IGM6yFFiNlrb7zXSgCb+PpQZrGmtHcjpFkYbKspEgSK+ZhAke+kwE4f6qVKgHAcSSeXWGc68Q==
X-Received: by 2002:a2e:712:0:b0:2ef:2c0f:2846 with SMTP id 38308e7fff4ca-2f1a6ce94fbmr16461701fa.17.1723232303140;
        Fri, 09 Aug 2024 12:38:23 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:8a4a:2fa4:7fd1:3010])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f291df4987sm451311fa.50.2024.08.09.12.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:38:22 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/5] net: dsa: vsc73xx: fix port MAC configuration in full duplex mode
Date: Fri,  9 Aug 2024 21:38:02 +0200
Message-Id: <20240809193807.2221897-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809193807.2221897-1-paweldembicki@gmail.com>
References: <20240809193807.2221897-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet description ("Port Mode Procedure" in 5.6.2),
the VSC73XX_MAC_CFG_WEXC_DIS bit is configured only for half duplex mode.

The WEXC_DIS bit is responsible for MAC behavior after an excessive
collision. Let's set it as described in the datasheet.

Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - resend only
v2:
  - Added 'Fixes' and 'Reviewed-by' to commit message.

This patch came from net-next series[0].
Changes since net-next:
  - rebased to netdev/main only

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index d9d3e30fd47a..f548ed4cb23f 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -957,6 +957,11 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 
 	if (duplex == DUPLEX_FULL)
 		val |= VSC73XX_MAC_CFG_FDX;
+	else
+		/* In datasheet description ("Port Mode Procedure" in 5.6.2)
+		 * this bit is configured only for half duplex.
+		 */
+		val |= VSC73XX_MAC_CFG_WEXC_DIS;
 
 	/* This routine is described in the datasheet (below ARBDISC register
 	 * description)
@@ -967,7 +972,6 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 	get_random_bytes(&seed, 1);
 	val |= seed << VSC73XX_MAC_CFG_SEED_OFFSET;
 	val |= VSC73XX_MAC_CFG_SEED_LOAD;
-	val |= VSC73XX_MAC_CFG_WEXC_DIS;
 
 	/* Those bits are responsible for MTU only. Kernel takes care about MTU,
 	 * let's enable +8 bytes frame length unconditionally.
-- 
2.34.1


