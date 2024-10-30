Return-Path: <netdev+bounces-140350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3ED9B6252
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF811F21331
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A51E882A;
	Wed, 30 Oct 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfFCvXBT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B95E1E7C3A;
	Wed, 30 Oct 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289098; cv=none; b=mLPHwBjJ2Tl+Bni98wpfKoJPV83aMUeG1lygI0r8Y03O7wpf2Rp2cBXBQGuzbS6eY6Tnrp4MjEcoWqYhyo5tPSf3cmSNP4rqI2XzUi+72fLWFOUryF7d0eZwrOFASrYmj47QotS1GEkeDNrXl3tvXIfoBbjB5u998Wb9rXzhBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289098; c=relaxed/simple;
	bh=lL7CbLBsv0wNSXq2J1Qr5rBSjhJ2hJVrply4+wOChBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzCc/K/d2/aCE3FZCffzgaqls9tVny++KZQF60p8w01HB3kb1RyeWaQyPfiGZwfdhBgDoQYMoWxJvp6rGq/qAr7lyEAqGh0+ygV+X/TydQRrh3I3lwn3DKBokh7odjgEa2yd/BPjkIZGAj8PCwvoDbaLIvPhtcpxUJD0cotfZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfFCvXBT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d450de14fso552604f8f.2;
        Wed, 30 Oct 2024 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730289093; x=1730893893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zr8em/6KB2VzZDWr+lWK7JictXqq7aOltFeo+p/9gI8=;
        b=HfFCvXBTb/V6zcyV4LFjFxKn4ILwoxJ8XYPtXcijWxX8lIOzFk+ku2epF/xhu64tPe
         BIs3Ou90ka4GRte1+bjhl+n025/cQfIVkaMAg/gKQobQlwCItHGAu/odZwZ8DX7v0Gkg
         sniXNU9hFSjaNoOh597xRTTVpiNyr/pw6J315w+3vzQh2AaS1qLJB8H5VyFkXd0rAsuv
         y6GT03pupS1s03IA7s/aJmie3MEtqBsX0Eoho05CcpzLxp59U6RlQcthuiuLgXPKMU9V
         dqS0aiZqX223y4c8zQBaHk9/jaMEL+FVBRX83MdfYNfcQ76/oi54BXJVyhPLpIc5umzJ
         xOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730289093; x=1730893893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zr8em/6KB2VzZDWr+lWK7JictXqq7aOltFeo+p/9gI8=;
        b=uaKe9DN1QE7Mg8Rt5rYQ4VztzJrfFhfzmd3cdqs5cy57G1Kex4pgxiUYps5CvigwOf
         TUn9UhD3ozZfWr7otTHOewoVi5HC1I0GqQfI2eXIATavKSIFe6sEgcMpRehqJH+sfGof
         Rv9X2emMK3XdCVAaOJMarx3FMEC6kMGRWVfoPmb6dimkLupheq6UQVKIVS3WZQxTc2NY
         M3vuhFU63Yfj9/b8EwlbBOdCZJwnivGWJl0fnrYwNAPpiACsUXtt+wD9A9TsjDCdWB+T
         r1fa8dO/q8UA+YL8wcb4naBMZrJTrTHjX+lyK1RTe58XzdvWl9HRqCgLvpZ6+DJmjvVH
         R4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+R0lhDQSWFM5kZX41BE7mUykvLWRwPKUTFOyFuWS7bRIH5EaT2JvrhS9ATe/uTaapD/clhsWc4kJ6ILE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4iVQDuNT+RQLWAtXb2EGq2nNKs1sI2whNipwYWbHt4OrITLHh
	Y0gLfuwMI9wdwCU6/MpqKnrNm4r0UvOiypu5DIs8n6EUja0ThiPi
X-Google-Smtp-Source: AGHT+IHfOnqANP7C09P+cywgl9OXz0QiH/fs1DGqvzLpja17LiaKIrBmvdJfRFGCtH5Hajte3gqlzQ==
X-Received: by 2002:a5d:64cf:0:b0:37e:d92f:8272 with SMTP id ffacd0b85a97d-38061222801mr5875538f8f.6.1730289093192;
        Wed, 30 Oct 2024 04:51:33 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70d5csm15250055f8f.89.2024.10.30.04.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:51:32 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:51:30 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v6 5/6] net: stmmac: xgmac: Complete FPE support
Message-ID: <20241030115130.pnfoy5iiioha5oxk@skbuf>
References: <cover.1730263957.git.0x1207@gmail.com>
 <cover.1730263957.git.0x1207@gmail.com>
 <7d6db0a3e995163b6f2ff69f88b650eea812ce5d.1730263957.git.0x1207@gmail.com>
 <7d6db0a3e995163b6f2ff69f88b650eea812ce5d.1730263957.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d6db0a3e995163b6f2ff69f88b650eea812ce5d.1730263957.git.0x1207@gmail.com>
 <7d6db0a3e995163b6f2ff69f88b650eea812ce5d.1730263957.git.0x1207@gmail.com>

On Wed, Oct 30, 2024 at 01:36:14PM +0800, Furong Xu wrote:
> +int dwxgmac3_fpe_map_preemption_class(struct net_device *ndev,
> +				      struct netlink_ext_ack *extack, u32 pclass)
> +{
> +	u32 val, offset, count, preemptible_txqs = 0;
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	u32 num_tc = ndev->num_tc;

Curiously, struct net_device :: num_tc is s16. Just use netdev_get_num_tc()
and store it as int...

> +
> +	if (!num_tc) {
> +		/* Restore default TC:Queue mapping */
> +		for (u32 i = 0; i < priv->plat->tx_queues_to_use; i++) {
> +			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
> +			writel(u32_replace_bits(val, i, XGMAC_Q2TCMAP),
> +			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
> +		}
> +	}
> +
> +	/* Synopsys Databook:
> +	 * "All Queues within a traffic class are selected in a round robin
> +	 * fashion (when packets are available) when the traffic class is
> +	 * selected by the scheduler for packet transmission. This is true for
> +	 * any of the scheduling algorithms."
> +	 */
> +	for (u32 tc = 0; tc < num_tc; tc++) {
> +		count = ndev->tc_to_txq[tc].count;
> +		offset = ndev->tc_to_txq[tc].offset;
> +
> +		if (pclass & BIT(tc))
> +			preemptible_txqs |= GENMASK(offset + count - 1, offset);
> +
> +		for (u32 i = 0; i < count; i++) {
> +			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
> +			writel(u32_replace_bits(val, tc, XGMAC_Q2TCMAP),
> +			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
> +		}
> +	}
> +
> +	val = readl(priv->ioaddr + XGMAC_MTL_FPE_CTRL_STS);
> +	writel(u32_replace_bits(val, preemptible_txqs, FPE_MTL_PREEMPTION_CLASS),
> +	       priv->ioaddr + XGMAC_MTL_FPE_CTRL_STS);
> +
> +	return 0;
> +}

