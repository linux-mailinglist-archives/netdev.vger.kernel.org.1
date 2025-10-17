Return-Path: <netdev+bounces-230585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8228DBEB9F5
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76BB3BB704
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DB234C9B9;
	Fri, 17 Oct 2025 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIaXFVrp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9FC34EEE3
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732025; cv=none; b=ufF30SOgEstjGh+FgeBO/5KUArAPK1rChm6uE/s6EJaBWsDQ1vitJJSKDMlMM7pikxyyJX3P2rDBzLsTYme675oCRiWNlxp7keJTT1QTt/tOYL47fWA0DN2G7HD6L3uIftGwxw5r3/cPX3z6qN2U0C6j9JtupQ8xqR+WCsB/b/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732025; c=relaxed/simple;
	bh=kjUOqtKdnyFkRakQLGh9uZuHxWqClH1OIdbEJi3SndA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BGIobUZ3CDFwdmLtuJQqRT5qu7UywGs0guFFboGzEql8qNozRESZECGZ7ZbNMtyaLNqSvTTqFeJlVz8JMPo9sz5k2i33sZLdS3iAAkQUqMFtKxkvfoRecom5M50oGjulXYKrL2uw8g/fAYODX+TxJ+CmIfnknmYb/F8/j42nyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIaXFVrp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso1992718f8f.3
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 13:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760732020; x=1761336820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aJ9dtamMQ4aPqgu1Co18zyi1ZgClELgB0wWAsbVasCo=;
        b=bIaXFVrppkLCNROMeH18+Y7uuS2IhJOgm3iVKIzq7+43Od4hvyhvDz2HrQZjLJ8B8H
         wJsB80d/i4mdIBhM96/Bh1xQXxieHLh2Sl6T2lCTUdp+pdTF61zK4tgTDADySy9rH9Zs
         JzxxWsFSZL+63+0nvp7LniFyLw+LQLzGEGemyFmnCRBoOmOylob+d6zuG6IlUi+zUmKd
         XPcuo5/LZcNjbSa8pCE+XAXT/85ENABQgf3tFXWfAVpjdxBWxfXUTlPedoVlwRk39Q1G
         aP/KIp2C8cJvk8mvXSxEHZ8Y8W4aVNeIpVA4IEoRuOicwRLYXtU4S4oNfRJvl5IQg/Bf
         TaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732020; x=1761336820;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJ9dtamMQ4aPqgu1Co18zyi1ZgClELgB0wWAsbVasCo=;
        b=gj7/JbbsrXwRBTKlZs2W1w0NcqDrWDicAU4wnLQSu7wrilKyj7FWuYG+TLm+N5T/Tr
         J+aqMPF0M3O+d35P3i27u0llseYi4/A+cT9TJbsW61rcXrMJDgufjjfkKGFC2ni9tB8n
         FXydndMN/TI4c6QOGsP8VZWcLlGwjVnjcVtSVCdrM4rKz3SL0gC2X76u38P6fDws+FRP
         rXsBpq6glTS00dHBRJF/X8by0DjfOZnqRBtjzVPNjgpn6qJSjyjqNXWYgRiEmTPhWpAm
         SsqAZrjlobEhj8E+NNyEKUgFXY1Mr66OaGmCkWc1hd7z2vtPOflu0LfaGGg9T6MpKyyw
         xz8w==
X-Gm-Message-State: AOJu0Yy42duLCyp0wxiaFXDmZvYseTBpQRRUJK3ektL5oEJHFOB7VNwl
	Ti8x9WlDVxaqC9VKjP40B+MfL5X7AiCMTcELpjTzAKI/JNzD13BIphvK
X-Gm-Gg: ASbGncvEr9+Q/4uXif8cJOJzr4HL1AMvlaeFsZ7SuyirCAaW5lrD+E2LgC7xhqZSROH
	It1LcHMhpLI21NjvDVFsV/S8Pq9JFqwKiUlUHfyZS3/njcHf/gzuIXLlpWs2OdRAiC3nlGr/sum
	A9OAQrE95jFQVXJEgCk6IScTvmWPKxG0R3IHT+C1xYIbiOiFLgHlvD+Tw7u5tF6b7WBE5y2EIrA
	rLsCcqtLQN5rvoItx+co74YcgJW4za1CIoq5bDpn24Y9EwXfJzyDFP6Sh5HbmCfhSucB68/j06o
	Im0QIjDgiBgo4Vd2txj2bGlIBggA8KQEf4SjpNXqfop2JWqKm9QCaw8NIGRjKsZKaByutaUqfO0
	2ZhKIalBCVv0ZlCFtYCNOfZrcJKYwSzKVz8BBkYSLYuVA6oeWr8bmY8/Z7EImrRVAF9O3XhZU8K
	+PKj2ZssaxjeoVEYQ1pnCiITvDY1hdauUd7Z8+02sZy5NuL1prbB3egBcoJc+Nex//Z6Rea2myy
	ePusmru2IVEEwlaTmrblGlKe7RQyafZVcgZNL2A81xrb4lX0bY=
X-Google-Smtp-Source: AGHT+IFc8nBqsUKJqpzPKB/n3wnyAQhHJiC9eXu9nER7wJsMSRRxsBT9KJuxrcNqux+HN/tiJqbu8w==
X-Received: by 2002:a05:6000:4285:b0:405:8ef9:ee6e with SMTP id ffacd0b85a97d-42704d76412mr3721842f8f.25.1760732019627;
        Fri, 17 Oct 2025 13:13:39 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f33:9c00:f581:27c5:5f61:b9b? (p200300ea8f339c00f58127c55f610b9b.dip0.t-ipconnect.de. [2003:ea:8f33:9c00:f581:27c5:5f61:b9b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4715257d972sm11134035e9.1.2025.10.17.13.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 13:13:39 -0700 (PDT)
Message-ID: <7fbb5ab7-f77c-4e13-8607-fe4572f1d302@gmail.com>
Date: Fri, 17 Oct 2025 22:14:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] net: dsa: loop: use new helper
 fixed_phy_register_100fd
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d6598983-83b1-4e1c-b621-8976520869c7@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <d6598983-83b1-4e1c-b621-8976520869c7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use new helper fixed_phy_register_100fd() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/dsa/dsa_loop.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index 650d93226..4a416f271 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -441,11 +441,6 @@ static int __init dsa_loop_create_switch_mdiodev(void)
 
 static int __init dsa_loop_init(void)
 {
-	struct fixed_phy_status status = {
-		.link = 1,
-		.speed = SPEED_100,
-		.duplex = DUPLEX_FULL,
-	};
 	unsigned int i;
 	int ret;
 
@@ -454,7 +449,7 @@ static int __init dsa_loop_init(void)
 		return ret;
 
 	for (i = 0; i < NUM_FIXED_PHYS; i++)
-		phydevs[i] = fixed_phy_register(&status, NULL);
+		phydevs[i] = fixed_phy_register_100fd();
 
 	ret = mdio_driver_register(&dsa_loop_drv);
 	if (ret) {
-- 
2.51.1.dirty



