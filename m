Return-Path: <netdev+bounces-120157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F75958760
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EAB1C21962
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF7A18FDC2;
	Tue, 20 Aug 2024 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVr5AS5s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6418FC9F;
	Tue, 20 Aug 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158349; cv=none; b=hBiEZ4E7MXXyQ/dGdNX7kx9HsIScYZkOGf209wzBPT037XEWeVXAEcYXcWvYMG68AGhrW5zsm9SLqzSakfMGkz5KZ7Z9Yoi9PtRFNsGZp7c3oDvvgiMKpyJ2dHucl7Bjm3eRI6B6bRO6QTBFx9971rBQTA708Yf+7Vim5HS+c+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158349; c=relaxed/simple;
	bh=yf9wDAJ1EE7oBFoK8jZd6mTqGqB12az4qCouRbLhsMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7C9CzB4uGDnAqgfD549W+qGu/tDHjeW3g8GIbCIvfZmG3gRuOiZcbUoZW3e5vBFsOaBoIOxk+CGa5HntJ/13wUdWFmHelV2Dn1qIV5iId+54k3Y3PgAOs1MPBf1/xqKqyVb8gJ9dN9DIOIDcHLMqE5kiES5Hjz8XVtjZiHn2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVr5AS5s; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a81bd549eso443724266b.3;
        Tue, 20 Aug 2024 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724158346; x=1724763146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Knx/Wm8d04mP0mUth0cL+YGIY2+xGYXs0Lh/UFhf76o=;
        b=bVr5AS5sNYB6q1DTMQ/g5KpoqwgkByIbmCxzYdvRX4VogQfxOmGs6dvO/NYM6TR1mh
         9Rkv5/HWGVXoAbDuxkiWojYX4c7RjJYVBFs7QZGwq4eqT3wtBWX3YPrKd+Q3P0CCs23T
         sQe7jp0bnmyd+eR7KIy1QF9rWVwfJlIHNJ67zjuHRzyilI+m4hAOJBqAYKDJkRaTbqgq
         asRLTHn9ors+dmYWCkvw88waesXWBNtsqNEwCi1Vq/YIRcMWODsVUJ5ltM6ktSkYOQg2
         bs2d8OWjuX5X/Xd8e3zqBVVbN6l/V4eGQ5ozpwNgHq06Ddne82NtUh0LFbav1H3skQnX
         PB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724158346; x=1724763146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Knx/Wm8d04mP0mUth0cL+YGIY2+xGYXs0Lh/UFhf76o=;
        b=nHizZFyLuZxRjwJm3ebxMfdItNikXVNK9+u21BMK2UvJ6yrw8t1oNlBc3LslITBUD1
         jn5LGSPMSw9ugiyj1wOFIDHrAA2ibSesnFR97m0ekgZu1spCR71+8rj8jn4/w+kGrHkd
         RIQ1pJC8TSD1v1vijz/23igZUW9Y/sThg+V3DQS9FYC36DzIvephhgtJvZIt4YMMhcW3
         v4r5COj6iSQhdmKk7/3sopc34LQRakE0MfqVysfupXkEV8DNlnaOtTfEiSm6XPI+R1ng
         31XEkTTvVxP60ZB4Yp0KGcf+Kl2/dqAUm+tFBhioewQPSowH3rpM2J6lY+bleKLdcQkB
         0bTg==
X-Forwarded-Encrypted: i=1; AJvYcCWC3b9NOFcNm00j1jAyCTyM0J5Zd/cmn3+aR4LEj/5AS8n/8ZpCBA2MIdHu3hkLIEV+lF2rm6Nd@vger.kernel.org, AJvYcCXvGoFYcmVasFot6OwQ+Ahj0CC4H27gDtGb76wkhBZQZp9oXuFjocJ6+onQsyLiCR00tF+PpRFBEUvD9/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZjqoTw27H/vZH53OssWhG4kNhMU1xKrFYUBCJPYv4g6Kp4rk
	PWOPnJWJoc63L4GqSABbuJDd0mcwxxq/vwI/RnvFH35XURYpj9m3
X-Google-Smtp-Source: AGHT+IELQXfyg2G1L4D9vQw2uIX24lD9ZaNlxT9BSo4Kp7kVm3c1WwrsSrVTXpg6pVqMkwFN2/fdDQ==
X-Received: by 2002:a17:907:9717:b0:a72:6b08:ab24 with SMTP id a640c23a62f3a-a83928a4178mr1099966866b.14.1724158345821;
        Tue, 20 Aug 2024 05:52:25 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6bfcsm762540966b.28.2024.08.20.05.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 05:52:25 -0700 (PDT)
Date: Tue, 20 Aug 2024 15:52:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com
Subject: Re: [PATCH net-next v4 3/7] net: stmmac: refactor FPE verification
 process
Message-ID: <20240820125222.uia4m27wizy2767a@skbuf>
References: <cover.1724145786.git.0x1207@gmail.com>
 <bc4940c244c7e261bb00c2f93e216e9d7a925ba6.1724145786.git.0x1207@gmail.com>
 <20240820123456.qbt4emjdjg5pouym@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820123456.qbt4emjdjg5pouym@skbuf>

On Tue, Aug 20, 2024 at 03:34:56PM +0300, Vladimir Oltean wrote:
> I took the liberty of rewriting the fpe_task to a timer, and delete the
> workqueue. Here is a completely untested patch, which at least is less
> complex, has less code and is easier to understand. What do you think?

I already found a bug in the code I sent, sorry. verify_limit needs to
be reset each time status is reset to ETHTOOL_MM_VERIFY_STATUS_INITIAL,
to allow for 3 retries on each clean-state verification process.

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 3eb5344e2412..530793bce231 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1333,7 +1333,6 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 	fpe_cfg->tx_enabled = cfg->tx_enabled;
 	fpe_cfg->verify_time = cfg->verify_time;
 	fpe_cfg->verify_enabled = cfg->verify_enabled;
-	fpe_cfg->verify_limit = 3; /* IEEE 802.3 constant */
 	if (!cfg->verify_enabled)
 		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fa74504f3ad5..a88ec40c4b6d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7405,6 +7405,7 @@ void stmmac_fpe_apply(struct stmmac_priv *priv)
 				     fpe_cfg->pmac_enabled);
 	} else {
 		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+		fpe_cfg->verify_limit = 3; /* IEEE 802.3 constant */
 		stmmac_fpe_verify_timer_arm(fpe_cfg);
 	}
 }

