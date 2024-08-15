Return-Path: <netdev+bounces-118834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE5952E81
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B891F238B2
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5484A1A76A2;
	Thu, 15 Aug 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjRLxHbL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E110B1A706B;
	Thu, 15 Aug 2024 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725979; cv=none; b=HEYmSWKzCktJj4qVyj7023nSwN5Q/gHoleU0G7Slb5HFbWLhgFO8YHrO2yb4UwtEcdkERVX9GpE38S5EPIFjcF0BnMwCvDSABCCESauZiXM7XIxvZDR6pkCFF0N9dzpOC/M5ZlJN9PA+7UJLMrJyVFx63JvJQopEBMLrKr9RBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725979; c=relaxed/simple;
	bh=/8Xjug9bDatFQaCoDv2mOXA+Ru/cTRDYG/LMRyOKDhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JvvDR4kMOeWdMhDBeg30eVSEkVaiv4Aicn0Z/zPfB9imuRPd3/OiFZzfRfka4ftHBeYpM6fqHr+ewD2/K1JJBzLmpGDJNafcuf/r5rY5oo36OxRig2A40AhavoCsyzLnsD+GvZ49i+3WpLu4ABJjhyM6WnFvF88DpuQjweuLaxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjRLxHbL; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-70d1d6369acso1281052b3a.0;
        Thu, 15 Aug 2024 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725977; x=1724330777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZcwrG171fB+S6a+qbmGaXbr7G29MG8vYWKPAWyBxTA=;
        b=ZjRLxHbL8Nok+r7GmWmurF1aAncFDkcHFTV+J9AmM+OjK7srzxyvlTVgH4DEE8+GT2
         OCgn8pMTW6IZyGt2hxsKpFRDRTt3Dj0KqDSxUwyWejr3uFfQHojjtWEHhlTO7qqUn1e/
         uRzZc82hpIbnHt3JH/TialBbDVwH6h/6ojQcwP1i+HYjMbAdZPyyvd963rGs1n+6HOJX
         F4hQxOKnNka72fShqilMaaEy3Gnq0LvDAN936VtQdUylyVPQuOLHfrcCqudJrHwirOxA
         kog1RsBIm0fMJ35gyjWJ8NFysd6/eSsatc9RtpUHV7sJvUF2S5T2woiiMl4IjAwS4Fm5
         6acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725977; x=1724330777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZcwrG171fB+S6a+qbmGaXbr7G29MG8vYWKPAWyBxTA=;
        b=EqVHXAQz/dUMLhXYwUpt59+RSTEdZCCqS3BLEQzol69B0WBFZAB+hXAibkmmv09JEs
         li73vmlwKwZwMNdf7bcMB3A92AOjJ+zZO8uLzPhPVaIMwBRGEYU0AVJ0ftvcLaQpAyaa
         +/O2xTwkxHPrUVF4AIxMJzm1k0PItgIWUm8ah/wOrksdXF9+p4QgqmCbom7qt5qyeg0I
         +cOx94QvHULVVMzdmrz8RoEh6z+NKtdUnlwd2weXkc3MQeVLOULaw7UjxS6B4EUNfVeF
         dS2f3oHUHcSWg2OU8lY2MNtOiK3lm5QXI6WjwqXJxpgubgjImqIE5rFYZz7a8uC2vExc
         Q5DA==
X-Forwarded-Encrypted: i=1; AJvYcCXdSC63EcQ5HXloOFXMB+OUTuRWJPFqbsoXEkx7Z3GaI2Kt1UXeVfmpAwb8MirPs1eVnqZ7PMXIOGEQ1P0p9nhyTaM2lTUJVfnsR/XhKZG+x0qxqDodBgj9+u/eY7PDWE5KeB4h
X-Gm-Message-State: AOJu0Yy10JxF6ZnMOgpJtbwsuYKAbjtaATLG9O2suCN0gobb1Rj140h0
	r7OhsfcobnqKnW4OrbEqb0NAaTPwR+sula7WM2s9L2oIRYwgNZXW
X-Google-Smtp-Source: AGHT+IEWYmb+hdNdp2KsTxXJrtApwjcGEk4P+B81Hilxkx+v0GiVj67NqdVhzeA20pLc/09tWW6Yyw==
X-Received: by 2002:a05:6a20:d487:b0:1c4:b2d8:43ed with SMTP id adf61e73a8af0-1c8f85c59f5mr6189269637.14.1723725977068;
        Thu, 15 Aug 2024 05:46:17 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af2b942sm923605b3a.183.2024.08.15.05.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:46:16 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 07/10] net: vxlan: use vxlan_kfree_skb() in vxlan_xmit()
Date: Thu, 15 Aug 2024 20:42:59 +0800
Message-Id: <20240815124302.982711-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815124302.982711-1-dongml2@chinatelecom.cn>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb() with vxlan_kfree_skb() in vxlan_xmit(). Following
new skb drop reasons are introduced:

/* txinfo is missed in "external" mode */
VXLAN_DROP_TXINFO
/* no remote found */
VXLAN_DROP_REMOTE

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/drop.h       | 2 ++
 drivers/net/vxlan/vxlan_core.c | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
index cae1e0ea8c56..da30cb4a9ed9 100644
--- a/drivers/net/vxlan/drop.h
+++ b/drivers/net/vxlan/drop.h
@@ -12,6 +12,8 @@
 	R(VXLAN_DROP_FLAGS)			\
 	R(VXLAN_DROP_VNI)			\
 	R(VXLAN_DROP_MAC)			\
+	R(VXLAN_DROP_TXINFO)			\
+	R(VXLAN_DROP_REMOTE)			\
 	/* deliberate comment for trailing \ */
 
 enum vxlan_drop_reason {
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 9a61f04bb95d..22e2bf532ac3 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2729,7 +2729,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			if (info && info->mode & IP_TUNNEL_INFO_TX)
 				vxlan_xmit_one(skb, dev, vni, NULL, false);
 			else
-				kfree_skb(skb);
+				vxlan_kfree_skb(skb, VXLAN_DROP_TXINFO);
 			return NETDEV_TX_OK;
 		}
 	}
@@ -2792,7 +2792,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			dev_core_stats_tx_dropped_inc(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
-			kfree_skb(skb);
+			vxlan_kfree_skb(skb, VXLAN_DROP_REMOTE);
 			return NETDEV_TX_OK;
 		}
 	}
@@ -2815,7 +2815,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (fdst)
 			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
 		else
-			kfree_skb(skb);
+			vxlan_kfree_skb(skb, VXLAN_DROP_REMOTE);
 	}
 
 	return NETDEV_TX_OK;
-- 
2.39.2


