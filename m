Return-Path: <netdev+bounces-75506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E028F86A290
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1841C257F1
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AD255E64;
	Tue, 27 Feb 2024 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="y+hnvOjs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17855C1B
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073229; cv=none; b=Cv/Bg7Dl81NVfDjh7rM9EGfxJk0U4/QiPhn8Qv2f17rVxh/UGbvg/l+EJqVaTmikBQ0vM2vNYvmgOHRsZlA6ITOmgBpN2ukFFSoAMMPKU0cMOncv+JkN0ayZwwriX8FIujbqzSSRzZiuJZg6OVc8tCf+iQR7Gt+D1lb2+dTAoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073229; c=relaxed/simple;
	bh=Ao1FWtffkqJ9KRoIkl1k/5tDFclXvxCsdQRSHocsnPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kl6aNzDHQTJQBAZUcJSHH82FQwxwlbfMAvrPGEOxnahnOSZ6jH9NhFX2F2W7iB2BSS3icqtNsIwJrYwduSHpxzMP0AIXI2rHguvDRSu3FszIsncaxkN+5AdZVw0vUbGc1b/C3So1OhAy0wo3PPNsLdpkIBNuAeh+up8Xx1T/oO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=y+hnvOjs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3e7ce7dac9so548507766b.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 14:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1709073226; x=1709678026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CNtE/x60rLGdFNFLyfmJDD8m85VRqTZFQIwmxPWLtY=;
        b=y+hnvOjsFCmSRiCdSJBnYhnOyjzbYdjN9RCANArhEkYpgouLYhRfa7F0UWlLQYh73e
         LO3gOEUjQ6GSHxBZBKt1GuOwDgaNZvYqGcKE2OEsHcu+o/BDBlMER/Icgou+MKHK5fP7
         jJOIyEO7f6huOkR4ar/PVP0QckpcmLoBL5vGOw2vb5EDhkSyznkJfha1MjXNKEeddpv/
         VnooexThFaK40egaHDSrtxmP5ajXxX39qfKQ1hol1gPCrHo9+4oXUJdzZ0fXDkSk87vg
         UcL1g9P79KXWEuKa8jHEYSMpbzMymf4yp0d/nMskG616TQeker4pk+D4Zt3AbcfUQ8a/
         2bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709073226; x=1709678026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CNtE/x60rLGdFNFLyfmJDD8m85VRqTZFQIwmxPWLtY=;
        b=P7v2nhsoqfDBKzxrLJoeIGGJ+IMOEIBhAna0sT+/3Rof5ZuRFbhPi7OmyR/pMBEG1x
         AgrljuhlmEyNBKabhD/51/vUIUwjyCBRYAgYkqaCY3ZW7lEvhv99r/q2z3z3OA7aOSYF
         DJrarQpOsa4qRiSgepA50eZma6QkU1ZZ4HkSUOopOFg7qQ9aLLcYo9AtISYyTjNrjTuu
         uCysA5sonYB5xq7Apvzab13U9k6pooZMvAZRcZ+7qhyUSqIRxg1poDXJS6UFI6OlqNj9
         Mx3zl5+HP5MflJ7LFvAK401jak3HmvORxm5Hf0byt0PKEdcUSuE4qXcyZ3N0GTqIe6zP
         k++w==
X-Forwarded-Encrypted: i=1; AJvYcCUMAAtvVQPemfWAgIDy4eLdMIpKA2nh7JXtb8Tu7u2DWz6wCtMa73P47MoKqhjLuFeRGxHRbIt77/8UNpoF9Zw09tRwLdIj
X-Gm-Message-State: AOJu0YzAuEmvUKm0QVwjEmWTdQOkUH0oxaUqaQm9UrUCGkMaD0e4k1Oh
	F3EU1YekavPaB/s4b1jmFFlBKJhdUf5dZuhnhH3rYuiz/46HbJop5hTjyVr/JEY=
X-Google-Smtp-Source: AGHT+IHbjyAXLsMjLpjzmJ+hOWBl+CKmWVQt3VnpN4whuwI0A61IRv+/PyE67Yx84Tg/jVhf8wBhpg==
X-Received: by 2002:a17:906:26db:b0:a3e:5856:9b03 with SMTP id u27-20020a17090626db00b00a3e58569b03mr8127948ejc.18.1709073225723;
        Tue, 27 Feb 2024 14:33:45 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.googlemail.com with ESMTPSA id jp11-20020a170906f74b00b00a437b467c92sm1195860ejb.177.2024.02.27.14.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:33:45 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [net-next,v2 4/6] ravb: Use the max frame size from hardware info for RZ/G2L
Date: Tue, 27 Feb 2024 23:33:03 +0100
Message-ID: <20240227223305.910452-5-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227223305.910452-1-niklas.soderlund+renesas@ragnatech.se>
References: <20240227223305.910452-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the define describing the RZ/G2L maximum frame size and only use
the information in the hardware information struct. This will make it
easier to merge the R-Car and RZ/G2L code paths.

There is no functional change as both the define and the maximum frame
length in the hardware information is set to 8K.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 1 -
 drivers/net/ethernet/renesas/ravb_main.c | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 751bb29cd488..7fa60fccb6ea 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1017,7 +1017,6 @@ enum CSR2_BIT {
 
 #define RX_BUF_SZ	(2048 - ETH_FCS_LEN + sizeof(__sum16))
 
-#define GBETH_RX_BUFF_MAX 8192
 #define GBETH_RX_DESC_DATA_SIZE 4080
 
 struct ravb_tstamp_skb {
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e6b025058847..45383635e8e2 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -568,7 +568,7 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 	}
 
 	/* Receive frame limit set register */
-	ravb_write(ndev, GBETH_RX_BUFF_MAX + ETH_FCS_LEN, RFLR);
+	ravb_write(ndev, priv->info->rx_max_frame_size + ETH_FCS_LEN, RFLR);
 
 	/* EMAC Mode: PAUSE prohibition; Duplex; TX; RX; CRC Pass Through */
 	ravb_write(ndev, ECMR_ZPF | ((priv->duplex > 0) ? ECMR_DM : 0) |
@@ -629,6 +629,7 @@ static void ravb_emac_init(struct net_device *ndev)
 
 static int ravb_dmac_init_gbeth(struct net_device *ndev)
 {
+	struct ravb_private *priv = netdev_priv(ndev);
 	int error;
 
 	error = ravb_ring_init(ndev, RAVB_BE);
@@ -642,7 +643,7 @@ static int ravb_dmac_init_gbeth(struct net_device *ndev)
 	ravb_write(ndev, 0x60000000, RCR);
 
 	/* Set Max Frame Length (RTC) */
-	ravb_write(ndev, 0x7ffc0000 | GBETH_RX_BUFF_MAX, RTC);
+	ravb_write(ndev, 0x7ffc0000 | priv->info->rx_max_frame_size, RTC);
 
 	/* Set FIFO size */
 	ravb_write(ndev, 0x00222200, TGC);
-- 
2.43.2


