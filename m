Return-Path: <netdev+bounces-245620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA23CD38ED
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 00:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A80230021D2
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 23:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940FE2EB874;
	Sat, 20 Dec 2025 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDBDUO/m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iu3039gd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D8E2D781F
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766274721; cv=none; b=usHQaURfUZAqS8pOGjYHlj9ZmMzSrCVwVT0Uo3Z1A7fY74P4xXWGhzqOLwR9hfg7t34FOpG8+5JIgFR+B9Bxrv6b10dSa03PnCdT3I7fjtvGLIds2ukZD44TRn9YBmvpLkEIkq8m2BGRU1yU3UDrVfs6u7o6x9+SL7J2NGZY0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766274721; c=relaxed/simple;
	bh=l2PyQVTgqs01DZmXDlMhIQnlDCtL2iqVhFjR0T7jhnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdElj46SAyCiX/o240WAbV/bs0dk/IQSHQX4QiL6LM8b3dmUcAkwx/PVUlCJob+8QhJdqYZO+VEKB42y6ZGgCmAP1E3totbdiNX+A18AKbykczmeFCK13k2efkiS9cn4HcsB3R8z/jjDhhmz4M+yUFCBq6vsProTvA2qLEu74T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDBDUO/m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iu3039gd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766274717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMu8Cn7zpWjBrB94ozhjaLB+K9rnR2bm8BvgLplbPI0=;
	b=SDBDUO/m4R8lg5uPRuyAhz7s+e51BastABGsUT3i60isjvnKqxtQch4qEp80IQWHfzNz2V
	uyJDoV3q+co9yCqh4iPf+V2/7IAneC4Yntj9sVSXa/LoKV2Jd9hrjRetWXEdmNPLdzjEdh
	CjOgEx2hImRQXHGJguwqFENo4wMJXEg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-LTHWlsXZP2SBZn_NU6uKWw-1; Sat, 20 Dec 2025 18:51:56 -0500
X-MC-Unique: LTHWlsXZP2SBZn_NU6uKWw-1
X-Mimecast-MFC-AGG-ID: LTHWlsXZP2SBZn_NU6uKWw_1766274715
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b72de28c849so228912266b.1
        for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 15:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766274714; x=1766879514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMu8Cn7zpWjBrB94ozhjaLB+K9rnR2bm8BvgLplbPI0=;
        b=Iu3039gd2Tos9pl71s1xj5hCP4RDcAF+ix+bodgFBDs9paxAvGMb4eeV90qHxA4AEq
         7Evrtl3HqYwg9tKWFoljZIgRai7/m1KH2YYw9ZmWfDp3hh34q7hUbj01Lc1bo6e2I6oq
         /YOTiOoUxtx6vOgSOMufmqG2/paChaBYbKRyTwTAQ420naa51ApdvaozG6pt3Ix4/jem
         6ASCsSC5bkz/5QF1rtGMeQVVlagFO2pUi5YcQ/FAIsay/D1PzqFfhb5EGa3a5Jk0rJA/
         H7YMF77e4CHORubl8jKd9oULqwsvraLDpk+piPeG2xHTwoDKZqKGzoAPxhmVaCFoPDyR
         m4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766274714; x=1766879514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMu8Cn7zpWjBrB94ozhjaLB+K9rnR2bm8BvgLplbPI0=;
        b=SSxsAY9tBkvblkH/+fhT14x6DqrSDFZtmiw55CWLkJX0z53HyaizQTsPqc9LoOY6Qh
         PxsG1oGIo+nQA2dP2SvIojoj/mKmyBuPwbiibtxOZvgMrNXkuIj7g3VoQ7skfeAqfFFm
         R7aGxkZksCP7kuJrWP0vN4Ch/6i4SFprMSYuecCMnPh9AW7QNoJiPS9QEvAXkcX4FNdZ
         Yb8N7oBLbflTtdfmwfD6IuoRHQh/LDiFHKUT7V4YkMgYoFdG3FCAdheV3sY2K9Thc3Zt
         hCfHRECej4gvrjtPVSMmjy7mLNZXlx4XZEOfK3gDkFPc4QKE7XNeliJ2x1mIMP6HGPLl
         zhhA==
X-Gm-Message-State: AOJu0YwWDRuCiIjISfPSx8rUcxcYwOJaStPJIyPwArYsf23oEU+iprt3
	/EJovh/RLqQjhh9k7t/nSM+WU7msHIG2i+PpB3yzQBhMSCHdYDcwqsX9fwDm/ZhQ+zMpJOrRwlx
	jh356WpIItsjzfGumG7mVlHdvz/nVxT+MvD/ADT9UOB8HVGbpjLRG4swv8jILOGVAVGokTmHnwb
	2sk9AedWyeRx6DeFEcXohtYaAgBqcxJLe5k1SzfHk5ug==
X-Gm-Gg: AY/fxX6d24J9T2f5lO32fSH8I42ebPRARoF4TF3gTPYJB26wZlOcRANKROoOuiED/8H
	rN5yAmdIrazx4+bnjOqk0l9xpIuMO3298BEKOKrJY5OFAT6SttPN3AKg4AZxMy0/hu3bki9lznJ
	7F3PxelX/7Er0zgYCKLLxGJNS0gqyeZkH80w2h6TzLz4kkeoe+YaKDc4hSXkDD5z18ACiYQDydL
	ZhJ3SHuULzGYOjnV63FRuBursUBA1czGnZ4Rk8cWBTnOE9k/UXX/mG5mp80NDC7dM6IDgbxgoBK
	f1MoKP4Uzb9Kps1z2MhPD9cP/oFm2t4lBMPpGp+1GdiJVGSeHZSNgivofN1GU44Dsq+6m70s+KO
	g/6duIdwH2ACY6EjwmCvK/5IJyNsv1i9P+F/pe5Y=
X-Received: by 2002:a17:907:7e85:b0:b7f:eb45:f572 with SMTP id a640c23a62f3a-b80371e9f7amr633440566b.55.1766274713893;
        Sat, 20 Dec 2025 15:51:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoqCZqk8h82BZ/6mRn8VngtQd0cvdLG+RqJnPkeh2WijOLTqMht0NlDK+zsOIptC6I4ehZow==
X-Received: by 2002:a17:907:7e85:b0:b7f:eb45:f572 with SMTP id a640c23a62f3a-b80371e9f7amr633438666b.55.1766274713465;
        Sat, 20 Dec 2025 15:51:53 -0800 (PST)
Received: from localhost (net-5-94-8-139.cust.vodafonedsl.it. [5.94.8.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad2732sm623818066b.20.2025.12.20.15.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 15:51:50 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH RFC net-next v2 4/8] cadence: macb: use the current queue number for stats
Date: Sun, 21 Dec 2025 00:51:31 +0100
Message-ID: <20251220235135.1078587-5-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220235135.1078587-1-pvalerio@redhat.com>
References: <20251220235135.1078587-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gem_get_ethtool_stats calculates the size of the statistics
data to copy always considering maximum number of queues.

The patch makes sure the statistics are copied only for the
active queues as returned in the string set count op.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
This is not related to XDP, but an issue related to this was
spotted while introducing ethtool stats support resulting in page
pool stats pollution.
Page pool stats support patch was later dropped from the series
once realized its deprecation.
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 9e1efc1f56d8..582ceb728124 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3253,7 +3253,7 @@ static void gem_get_ethtool_stats(struct net_device *dev,
 	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
-			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
+			* (GEM_STATS_LEN + QUEUE_STATS_LEN * bp->num_queues));
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-- 
2.52.0


