Return-Path: <netdev+bounces-49007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA27F0627
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 13:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8351F21A6D
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 12:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032F25691;
	Sun, 19 Nov 2023 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTatvJft"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37B2131;
	Sun, 19 Nov 2023 04:25:32 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso481245166b.1;
        Sun, 19 Nov 2023 04:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700396731; x=1701001531; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tjBUe+8pD5EhysloSQei8tIcX5fvkeXnqi/PHKa743o=;
        b=eTatvJftTIYhtWKXfWs/F+QDck6UPo8ncidDJjREuovdp5fwQ8Bez9n8Zwvb/uR2O3
         rda7rDDT7FvQ/082/xxc+ssG5WuNp5jGEh0d/5EWvxgKJxOGgqO+oJbXCe84dNmPkLkM
         UbOwJI+mCbZgFNnLQkLA27aMJn1o4h4n1X6J0kUi048e/rqg8+SO4zu89XuLEuFzLH8N
         uh8DA8wXj5sx3I1FKBFBn3HA8nxbUxLC9c9Vmu1n84tsIYqDNP2tz8dZ7cN1e1cn3n5o
         KPLvkTySrgTpRBuMfvBP3l2NfEBDiPIvpeQ1yMPzFUYz0yofCTPYP02dSkZSW6T996/t
         FUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700396731; x=1701001531;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjBUe+8pD5EhysloSQei8tIcX5fvkeXnqi/PHKa743o=;
        b=vZiefN6kWUTcN0PuPBC3HCp/us9Cg3g208X2KXX1oAOn1DoV4hudxeZFs5FSjy8pw4
         TBxnujZbWLbVnUAC4tc3sA8Rty50vnTGwnlyD1p4qG24+cNC0KFKzut5f/e9N2jaxjPc
         b9/uL1YD2CAcyskxN99lqipXLUQXCZXy2qc5oXqU01MllZLtQNNSptBL7rzZ6tlkTc8X
         r9Dqn6rqXzFcQVUUyTQMWK7Sz6YhsyznsvD9t0wDWBXdXP/QqHye8jpnENnCGTBmi7iL
         A2HBicgQ5H19V314UFbqubNTGtX49Fp+PTv4uTZjxQi2eiRgEa7EvACu0i8FDzbque+e
         cjgQ==
X-Gm-Message-State: AOJu0YxD4MYWCds4aIUPxf5jrSwoJ8cZTsZ5vIn+8nqZ8wwjuui7Hcf7
	IqWZaAj5t0vM+4Ti7naEYig=
X-Google-Smtp-Source: AGHT+IHmRWTR6dkvNCQRdmHyDpQY38kA+br73Yvjtw+tD15hi2UZKyom9XBHid029R8bKNivscPAGg==
X-Received: by 2002:a17:906:73d0:b0:9de:52b:6938 with SMTP id n16-20020a17090673d000b009de052b6938mr3045764ejl.9.1700396730896;
        Sun, 19 Nov 2023 04:25:30 -0800 (PST)
Received: from skbuf ([188.26.185.114])
        by smtp.gmail.com with ESMTPSA id g25-20020a1709064e5900b009e7e7c0d1a9sm2824311ejw.185.2023.11.19.04.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 04:25:30 -0800 (PST)
Date: Sun, 19 Nov 2023 14:25:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 01/15] net: dsa: mt7530: always trap frames to
 active CPU port on MT7530
Message-ID: <20231119122527.ccp56obhpofvc3vo@skbuf>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-2-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231118123205.266819-2-arinc.unal@arinc9.com>

On Sat, Nov 18, 2023 at 03:31:51PM +0300, Arınç ÜNAL wrote:
> +static void
> +mt753x_conduit_state_change(struct dsa_switch *ds,
> +			    const struct net_device *conduit,
> +			    bool operational)
> +{
> +	struct mt7530_priv *priv = ds->priv;
> +	struct dsa_port *cpu_dp = conduit->dsa_ptr;

nitpick: reverse Christmas tree variable ordering

> +
> +	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
> +	 * forwarded to the numerically smallest CPU port which the DSA conduit
> +	 * interface its affine to is up.
> +	 */
> +	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
> +		return;
> +
> +	if (operational)
> +		priv->active_cpu_ports |= BIT(cpu_dp->index);
> +	else
> +		priv->active_cpu_ports &= ~BIT(cpu_dp->index);
> +
> +	if (priv->active_cpu_ports)
> +		mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, CPU_EN |
> +			   CPU_PORT(__ffs(priv->active_cpu_ports)));
> +}

