Return-Path: <netdev+bounces-120070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7231958336
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40752822C5
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873418B496;
	Tue, 20 Aug 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQdt2Yh0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4027E17740;
	Tue, 20 Aug 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147482; cv=none; b=MN8bmYYeqIgIROlTovevKQY3aho7gTbmACG1Cya516t/e2PLGHqhyJDevSCS3g+TiNQv06ABs+MBHm4xJSh5iKUSyB79+/47zfscgi0C6nqLtvHyuICriWd6PlMuHyD+okVETHgltrO5YQwtFhaUAOirEhB+/yQPBdsZNSRziYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147482; c=relaxed/simple;
	bh=5LLqeNnlj5ERfY5+bSqk5h4OdUBqZbKQgmzJJSrhj+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As6MGfDxzcCbueT7DQpiVo6bau/ma5/2F+1IPfO6KAb9OQMW8mOl1eEKOV2YRS4rubMGAjDuJEWwW6r72cTxGhrc4+fBI/5RqNnaidKRK6982pNxgevQg5cnp6rpeYggrbgbLImsnyJA3dNQ/JD1k5k24Cg/tDm03yL7j+ZfMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQdt2Yh0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7de4364ca8so584880366b.2;
        Tue, 20 Aug 2024 02:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724147479; x=1724752279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMRO5aEOOPp2GA4SgmW2MhbGQ/rLz3tZNU53B/4+f4g=;
        b=dQdt2Yh0auIJ1tsGUK0Bp4KO0MnHq7DhWv9VBcrnT9xIKXEKU6SSoUYj5kVRA5mvsP
         ZB0r4WqpkDoQ6ZFtd42BelItc3XNGGOwEgMOemqI/MjvSYvdbap5c0PGu6RXd8+XadcQ
         OCJiwGhuXyUYROZuLZg9MLrwzc2Ij05q+Wr9mCZH7+n3ZNDwQtVVqBfIK9vW4fg6Km5/
         G3FoH3mTamqmHbk4vscp5XfijKTT8rOmgew7li1c3R7D0O04PInjIEfmyRGsgGKlC886
         XU69DlzNQIS8me+yPbl0MqtK10eGeRAw9VAN8M/iGTxLTWX55B/OgNhporOMs1N9R4he
         GXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724147479; x=1724752279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMRO5aEOOPp2GA4SgmW2MhbGQ/rLz3tZNU53B/4+f4g=;
        b=A33JAw9FrtywymactOn/uaEihDa1By22CU1ZFD6uoy/zQGAsLB2Wtd22Gp387WVklb
         WAoeXNiW0o8eg3qaNkvHPpecdx5YMfBKVKb84WJFsSRMKNUBH7JkfOj5Ahioq16WLw+A
         qpgkO7WTY41xa8cVdCNEtKpagLqPfAaEZiAnyLoY7doSw3dE+YaL9RXaBp1Uh+Rk87EE
         rEc0fTOQoqrC6tMHu9RG5x1yhroiFTyLOWSYzSttAKvcfGLNUWnMYThksh0gEpp9APN0
         MgD+8625l4YgK5bvKB/FXiQ45cf657XFVKymhO/APicFcfWRQNQJHv4IK4rNpIctyf98
         QayA==
X-Forwarded-Encrypted: i=1; AJvYcCWAapDxJoTfBf+LZTC6rhfWtZzisOqsZaxD/6yg8+5vhuggQ+qHBEI9P6pnXu02ahs9AjK3xXSJksKUXBcqeaq232ZsX+zMQrw6W8mp4wUuhOcdYOYXDOASxO50qPFAQWjyASFJ
X-Gm-Message-State: AOJu0YxWnwu8SP0v/ZkeCJ0637pyIoEbPAk7iW4GB8NcH1+zTTZFAPtG
	LdYHpi42ycunGhLgSqaGBFCOXLX68LppDUmXqQnzHpw2UyaxuVsZvyJAteQu
X-Google-Smtp-Source: AGHT+IFe89MF4PAXRq87PUkDRnYToPhl3veGvDUpACgEFBVjcT25Az4FnOvuI3g+DR4n6Ox2qbTARg==
X-Received: by 2002:a17:907:7e94:b0:a7d:c148:ec85 with SMTP id a640c23a62f3a-a8392a38e70mr1068397266b.62.1724147478406;
        Tue, 20 Aug 2024 02:51:18 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838393560bsm741330866b.139.2024.08.20.02.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:51:17 -0700 (PDT)
Date: Tue, 20 Aug 2024 12:51:15 +0300
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
Subject: Re: [PATCH net-next v4 5/7] net: stmmac: support fp parameter of
 tc-mqprio
Message-ID: <20240820095115.bhg4rv7oeondetol@skbuf>
References: <cover.1724145786.git.0x1207@gmail.com>
 <413a36781a9b215c857bd8ec3c9ee03462e861d7.1724145786.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413a36781a9b215c857bd8ec3c9ee03462e861d7.1724145786.git.0x1207@gmail.com>

On Tue, Aug 20, 2024 at 05:38:33PM +0800, Furong Xu wrote:
> +static int tc_setup_mqprio(struct stmmac_priv *priv,
> +			   struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct netlink_ext_ack *extack = mqprio->extack;
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	struct net_device *ndev = priv->dev;
> +	int num_stack_tx_queues = 0;
> +	int num_tc = qopt->num_tc;
> +	u16 offset, count;
> +	int tc, err;
> +
> +	if (!num_tc) {
> +		stmmac_reset_tc_mqprio(ndev, extack);
> +		return 0;
> +	}
> +
> +	if (mqprio->preemptible_tcs && !ethtool_dev_mm_supported(ndev)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Device does not support preemption");
> +		return -EOPNOTSUPP;
> +	}

When I said that "this condition is dealt with by the core, now"
https://lore.kernel.org/netdev/20240819114242.2m6okk7bq64e437c@skbuf/
I meant that the driver doesn't need to check anything - the check has
already run once, in the Qdisc layer. See taprio_parse_tc_entries() and
mqprio_parse_tc_entries(). I was not asking to insert this test, just to
completely remove, rather than adapt, the entire block:

	if (fpe && !priv->dma_cap.fpesel) {
		mutex_unlock(&priv->est_lock);
		return -EOPNOTSUPP;
	}

