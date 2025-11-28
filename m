Return-Path: <netdev+bounces-242513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EEDC911A1
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9909C3450FC
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119192F1FD0;
	Fri, 28 Nov 2025 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvZRDNb5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590112E7F1D
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317213; cv=none; b=pm1SdeqN2oIF705feF8UtgHVaOM7F4zs0JYytsweoVTvNmkJFaK78GyR35Ycv4ZvIiABSE5fc+PSKkvqkz03jESFYJkxHR1i/gZ7eFeFERZFvVdjLbKPM/jPbTtCrn8Ia5FOthzPPsotk1DkE8UD/kqw6v8PZsYgd2orJBryzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317213; c=relaxed/simple;
	bh=dVGM7YzgCKLuuKDe4mee+rTwbCjC2sQraxKVJra6rhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7zQLq7RAkwtMePeNVz3AhNpz3Fe5E6NIhjfu8c4/K6aGr3gdjJsfMLNntfLSCACZLzACWWT3H49Feo5XJAgy3boc3veKbQVgsffc6uCcQdbVyl6h29hj+WWIgOa8xrcpahbDkH+yZ4qKZauYAGJZnMizfk8Y84yjJzdwZyN6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvZRDNb5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b736d883ac4so66953066b.2
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764317210; x=1764922010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQd3PLzZ8AJbcv65jBMHGIJOzjOGRj9r3Be1kNVC/Ic=;
        b=KvZRDNb5irA94iilqxfownV+vH9M+4O80BC8bHlybQz8G9u4x1MI9O7FlAwg6AnoIn
         hXewKpbYIHX522tPwRv2NcIbyooJ1/7R2D5dBOkCmBnfCx+DJSnX6lx5zBVCRp9pTnJz
         Tlu93ZpcOQO0vgLxaa7n/MPMjX+xqAyUoM4sT0woZPK0gAmR4HfcFqrNh9EDNzQKmOZa
         XciFLp8NUDR4vNxDqJfZUMQLYd2x+9zTcYWBW0hbHQIcAiWmmBRSZOwd5u0bmtNRTLwl
         FRrUrJn9WzlPZS9ipmvG8O3GXYn7U/yFjoIRj+lqFijJn6xgtrz/7Zg5M0h3xKBL6f8g
         xf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317210; x=1764922010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQd3PLzZ8AJbcv65jBMHGIJOzjOGRj9r3Be1kNVC/Ic=;
        b=nzcJjXfywDIppYpMSxN7SY8vA9IBXiGTFNNKdgSXY+oj6Sdp2ELW/4bsGAEL5ATFPw
         XQHqQbQBo15/yZZjXpHXvL3olfEgFRQc+UE13fqbvMHj/w+YJCwMWzdIU7nQE9aDaSFH
         Z+rwRsi2F3IPiwbvE0uxv1h2HUucgOqzAl9+UixMVainv6CKP28yZ/XwYrIk2LnV5bTa
         akKwX4hbKrKLXMs32sUdMVyiRDPoQgWIQW4TJTHeSldpahxln2iv+x35rFMYiK2qoYhB
         WLhdVIokWGEDfXYQVwBKYTUopwKaqLhhIsFIJyY5rcSjSSxbwHFiiQOkU1VmpPVzC507
         sXaA==
X-Forwarded-Encrypted: i=1; AJvYcCUx49HKKv+t09fbsSsCggTkg4JItZ6TxPSTuL7dpZG/BrwYWPzs7L+TyOHdEFJfX7g51bDnzBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DKz+9NyO5iKtZJJB14NRCukwU/B4au7Y1IDCXl7JRkW9tWhT
	ou7gy9aTwvFZaufVLi+P5468LIg5zVVXR/0/wCgbKk2DYmzSvzT0nkSQ
X-Gm-Gg: ASbGncvLJ1BHS69+VEVxd3L6j8SlVtoXlQvcAu62Ta9yioUImYg9O9d2kXDxRb8j/jx
	gBBgjjXQpcpdENJVbpVWj/Dq2HkEvNyjcd1vWFWAiT2JipGUavvV5ikGJtfZ0icCeUdEbxygAj2
	mD1jIyw1Bj8mwraBiuVXyl0JFxEk05+XhvawGLOrfhrkeTFoPA2yceyAgGKkNebpWymxg69mVPN
	g674uqg6sVkLMg5sKo/pjhhJIOsRC95Iw27OKmF7YMSul/SP7BO8hskD88hKxF31eu6YjuEmJOX
	C7TvcPZWeb6+90tmsxlZNDaeHId6pvd5EuaLYeuPvY+phkAJh0KIZnA8Q3v6ENRW9H7aKwXQWNG
	d5kkvHRxR74+acXUN1rIhfBu9w31axyU6Axzmc777/nt/bc+v9AuTqsve1HKp+Qn38w6NvlsGOK
	KEXrtCxV7ngOFX2SMruT0D9KBZmO63i5Pv6PoFbPuB7Zya8J7GYR119W8dZsMxIhbda0/YrpL6N
	aaoEg==
X-Google-Smtp-Source: AGHT+IEBGcglZmu8UrcQJT0JgBbFxWtKvu+DEkJonDsMZMH6PC17vDq/FnrusP+b1vwXSbsvChKoVg==
X-Received: by 2002:a17:907:3e95:b0:b75:7b39:88bc with SMTP id a640c23a62f3a-b76718b286fmr3231326066b.58.1764317209502;
        Fri, 28 Nov 2025 00:06:49 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162d31sm385418766b.9.2025.11.28.00.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:06:49 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/7] net: dsa: b53: allow VID 0 for BCM5325/65
Date: Fri, 28 Nov 2025 09:06:25 +0100
Message-ID: <20251128080625.27181-8-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128080625.27181-1-jonas.gorski@gmail.com>
References: <20251128080625.27181-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that writing ARL entries works properly, we can actually use VID 0
as the default untagged VLAN for BCM5325 and BCM5365 as well.

So use 0 as default PVID for all chips and do not reject VLAN 0 anymore,
which we ignored since commit 45e9d59d3950 ("net: dsa: b53: do not allow
to configure VLAN 0") anyway.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 * just let b53_default_pvid() return 0 instead of replacing its call
   everywhere
 * drop the explicit rejection of VID 0 for bcm5325/65
 * reword and expand the commit message a bit

 drivers/net/dsa/b53/b53_common.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index ac995f36ed95..a1a177713d99 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -872,10 +872,7 @@ static void b53_enable_stp(struct b53_device *dev)
 
 static u16 b53_default_pvid(struct b53_device *dev)
 {
-	if (is5325(dev) || is5365(dev))
-		return 1;
-	else
-		return 0;
+	return 0;
 }
 
 static bool b53_vlan_port_needs_forced_tagged(struct dsa_switch *ds, int port)
@@ -1699,9 +1696,6 @@ static int b53_vlan_prepare(struct dsa_switch *ds, int port,
 {
 	struct b53_device *dev = ds->priv;
 
-	if ((is5325(dev) || is5365(dev)) && vlan->vid == 0)
-		return -EOPNOTSUPP;
-
 	/* Port 7 on 7278 connects to the ASP's UniMAC which is not capable of
 	 * receiving VLAN tagged frames at all, we can still allow the port to
 	 * be configured for egress untagged.
-- 
2.43.0


