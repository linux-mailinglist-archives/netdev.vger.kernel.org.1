Return-Path: <netdev+bounces-234891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEAEC28D11
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 11:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17ACF1890372
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A898226ED5A;
	Sun,  2 Nov 2025 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYh0UbBY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401B26B2D3
	for <netdev@vger.kernel.org>; Sun,  2 Nov 2025 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762078095; cv=none; b=cRep44Is2RTEHdp1qLzn9uRdNw0XN5bZMAFilKpI/iDy+y8J4qIKaIDulHsC/lcvKuFNuPGsb9iMG29Pzds/9H9fIo5D3/PoDAJOiMKkcNMAXSgVaCbHAXORXYhYqYjt+ckvUgH1l25KH+Ri5/k7pKJUN3GI+fAi+0oaGK0Wemw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762078095; c=relaxed/simple;
	bh=WI4dQmbLbeoKJWX9vM37NTMbEzqifytGUR62+BIwjxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAY6E8C66oHJW/FoOvbZSK6/ram6eWZjuRLZOTI63jdlmp2kcgHqwxNGbABKNELanKEMb9bICVVycVEDQCUc6edASWERdK1xi/Z+D73v4Xf22jrJSIWbx0D7kkS3w9bFb3Y5YiGRrYo1IL3/rmwjVxNlWNllfNusNk27hHURVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYh0UbBY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7042e50899so588518266b.0
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 02:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762078092; x=1762682892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2yJpF3civfosxPDRl0+B7YozBy9HKcj8ntbRaz1DgQ=;
        b=kYh0UbBY9NtZbv/ElIRgi+dQBTnkgLnRsNUb0cXHnyGJQSZwyF1tAVDqnqp5sCZYqv
         PRMgOyxR2B+V5YVnc3+m8OEL5kHF103qvuHSRjQawMTFmF5LQJpxKbd2J1E0ea0Ic6rL
         pqjQJv5BUuYJ5ILFl45M81PXYR8bkaxqOyOuujRRMBjGvzm+b6qc02JtibtuxfpUNE4N
         bxLkF6x/MTBEV94i3FWvf+VCdLj512rVH6uct4nF1ugzDmIAG3hL+5gDnJxtOVWRb2aK
         p+mvIGA8VGb53EChYtf1JNVC9U50C4+zrpAoDxK8T3snoVkcjYedX0OgocjtlMNPvTei
         7SLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762078092; x=1762682892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2yJpF3civfosxPDRl0+B7YozBy9HKcj8ntbRaz1DgQ=;
        b=gOoqfigrB/JUZVK4Tm/ThnXZ/3m85BSEVNsik9SI3pnScMak6OrYWvt96naADBbvPn
         zlgsgdZkS5uhqr0Sm8LuZqYYhxVgrCc3HXKilIr1gUGgo9ZA32orxN+01Ftst6YvBrkD
         ybRPP2Cu6bE59lQsImy0ynL08N8qOrX4rwWFKLuWUzEsXzufRHP3/Ql421G/vwXglJPQ
         IvZJxZP6L4Y/WwZlCppP/SfAwrNWauoFtxKPVBegP+2sV5vqveT+PpUmCEwDBci6WSjX
         Hu/qY3uH/DwVxNDnopCxqOwSi9uDegJuU7KLi1dkOn0pslEIFvpjVEW4/meVYdATt+39
         C3jw==
X-Forwarded-Encrypted: i=1; AJvYcCWKxqGNRMHNY62ciRmmdtXuLzvC++n1k3jqpnBrcNFHpPonFQldYvgPYRb+sk+9FwKYz6Y+b1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJQSnx27ABLy0Ift19kkItSwzR5/diWbOzoZvWmR7/bNxF/kE
	EpI31rKLnvTobq5a2q92maLs5ZuiWSc1qblKr0S2wMTvto7GR3XmO/dq
X-Gm-Gg: ASbGncuW8xUyLu0YzpBlDUtegYOjebrWWFt8RcqMFCEtvlUBwXJe4shF6CtuZELGMnh
	A4q2X2B4uK+HmxPYZ1gAO1hifsGavAi95ZpGoMPhec8/FNRlRJPeWTWeDVbN74J+BFLRUNsnW9V
	+UkKcM1kleiXbndbs1ix7nzFtzkMoXppp9EqhuYEXaeG87CxVf1tBL7nfvztg1wA6Jo+6EfKdsw
	QNBxuArUwtmHqiVxedlYlt8neRdli0jmOpCfbN9sxrsgCL2JKcOnLhSn+AZ/3kdXRU8dRf3WNhi
	H1ae4fZcReuOBx1m5xzheaJNcj2uaRaxUu2O1dN1uAsZppPCB8J5BN3/8fIuH58wbdCJI1XUDgh
	LeywU7OjII5t3XhMhRH0QPksGJSO32WUOZ6OrroJGje4j/oW6kYHsVOZE972GlLI8+H+lGoY4jL
	4NWtRt0mRBrzfvhRVX1CJFXvOE2bknIEU6COubXnBijc3ridICxihw7oB1DPpFqv6yhR8=
X-Google-Smtp-Source: AGHT+IEAG5nQVhDNsX+9aZwh3wdhl2C9Vw2sp0EPsCLie1GqINXDtUq7QOv1si7kb/MocTldpCex+g==
X-Received: by 2002:a17:907:7ba3:b0:b6d:3e39:aa94 with SMTP id a640c23a62f3a-b70704bc306mr925456866b.32.1762078091901;
        Sun, 02 Nov 2025 02:08:11 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077c3ea2asm683153566b.38.2025.11.02.02.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:08:11 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: dsa: b53: properly bound ARL searches for < 4 ARL bin chips
Date: Sun,  2 Nov 2025 11:07:58 +0100
Message-ID: <20251102100758.28352-4-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251102100758.28352-1-jonas.gorski@gmail.com>
References: <20251102100758.28352-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iterating over the ARL table we stop at max ARL entries / 2, but
this is only valid if the chip actually returns 2 results at once. For
chips with only one result register we will stop before reaching the end
of the table if it is more than half full.

Fix this by only dividing the maximum results by two if we have a chip
with more than one result register (i.e. those with 4 ARL bins).

Fixes: cd169d799bee ("net: dsa: b53: Bound check ARL searches")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 82cce7b82da2..6232eb5336a3 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2068,13 +2068,16 @@ static int b53_fdb_copy(int port, const struct b53_arl_entry *ent,
 int b53_fdb_dump(struct dsa_switch *ds, int port,
 		 dsa_fdb_dump_cb_t *cb, void *data)
 {
+	unsigned int count = 0, results_per_hit = 1;
 	struct b53_device *priv = ds->priv;
 	struct b53_arl_entry results[2];
-	unsigned int count = 0;
 	u8 offset;
 	int ret;
 	u8 reg;
 
+	if (priv->num_arl_bins > 2)
+		results_per_hit = 2;
+
 	mutex_lock(&priv->arl_mutex);
 
 	if (is5325(priv) || is5365(priv))
@@ -2096,7 +2099,7 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
 		if (ret)
 			break;
 
-		if (priv->num_arl_bins > 2) {
+		if (results_per_hit == 2) {
 			b53_arl_search_rd(priv, 1, &results[1]);
 			ret = b53_fdb_copy(port, &results[1], cb, data);
 			if (ret)
@@ -2106,7 +2109,7 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
 				break;
 		}
 
-	} while (count++ < b53_max_arl_entries(priv) / 2);
+	} while (count++ < b53_max_arl_entries(priv) / results_per_hit);
 
 	mutex_unlock(&priv->arl_mutex);
 
-- 
2.43.0


