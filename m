Return-Path: <netdev+bounces-105774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F597912BC2
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A970B218B2
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C4D15AACD;
	Fri, 21 Jun 2024 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhsEQm0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4750A80;
	Fri, 21 Jun 2024 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988494; cv=none; b=NJN9P6kmOyV7eq6AjwvpSNzdggfRa4qazQKu/pk0YFiRrWaHHcBT3G1mHD5JG4FDFSzq/Q9v5dTH3BxtYuQAtdutgGUImxqniv51TGvnuj/1TogHoHNmMCfc/1oMOCmqtFaZHu2ugghtINDPRIbjltbLspDslnXukIIFJ7ZAqyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988494; c=relaxed/simple;
	bh=G9rdu6POwjtn8CVz9zdpZUJgDFoNCSPEfqDk8aDQXEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlGPBW262lxEOXOax/3+ZWm9bKbArIamGzedrbvWcyOSdsFw8lJj+og9rWwaALLUaiS68gKd4zVfx7skGuaA2BYW4yHd4XSKoaLhbV5nW32JHpxM8f7OvSabiD5OwxtCnHtACMY/PuyMMUd0N+3y6z3KJcvUu+lRbsf97G90ayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhsEQm0h; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so13458635e9.1;
        Fri, 21 Jun 2024 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718988491; x=1719593291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAvt17O7wVBgeXSp8Ee8sP8BbLPmXgrdP5H3qWQaSLU=;
        b=WhsEQm0h/W1LCS6Kc8xHePyMZ+C5+W1tve+t6Edxibt8oVT+JlT528It8LwbXQCOs0
         IXUTH7kelfNVvpU7tjibOE6UaVN/FJoBwWhJFZu265m7ODhHysr93uDKr9KXAXIBtVZq
         qKuRxoFpjx4NhTdnlr6YV6NGAoh+fJhPtbZ8hLlHvGdBCnGl6zKFmikSnaEcOBbxvUj+
         f/MRtIJo/3EpPO8bJ1puJTNbpL+0I5EWFx/8T2r/knlGeb43xdat9Rtpg/5QlR6N3awI
         wGNqdeH/i+V9eoiSrH7HNEHKLS66t9PHl9kyQSt/LTvkCiY0BcMfs7JuFvjnea2IXvPn
         wVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718988491; x=1719593291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAvt17O7wVBgeXSp8Ee8sP8BbLPmXgrdP5H3qWQaSLU=;
        b=K7RZdyCM32DWZL6Vq/fSSY/rdO7xhYiTCEiTYZRMBB/Yp0sf4FeL5H7WrtAcfV6NhN
         FcmNuBUGHghp23ga1CT+wXUY4cwtOiuDOd7KyiwByku6csvP+F3Fn/Eb8ZwuYIj57Ckb
         29OnL42ofKQAyJX13FmJpSnSixmtRZaDt47FKI+BRE0ldZzZ+lty+LMLKRkn62tJm6AR
         85UVzorlOmuQbpI0iMxfgIE9PvbWqTcJcx/Owv8JmYOEJIz8suH1ouXdC/uF5oUB/QV4
         5i+FvHV0aGq4m+rUkUeQqjPTC0iu9OBOFQxBAyKeMk661xzcLAcJ3oLefL90Yys54Yii
         wwng==
X-Forwarded-Encrypted: i=1; AJvYcCVT4aplQTkolZKC54oqfbA52QQCRka02MjNHZfVJQn+pSBgJF02P2XpiKANxEnblOLAGS/e9cCDa+ZWiGtgNjh14jWmBK7yNAnAKiDBO/gER0pIPGlrEGoaZpHBDaLC0ulXRxO2
X-Gm-Message-State: AOJu0YxmPV5UMIVfgEndPCu3D6Cy7MFPRlyScqOt39lmcSOwlqjNYHBy
	AJ2rNNDis9OOA3SIlqCHIf/+CD5It9BFk02cZKVE9LWAdZBfxBCa
X-Google-Smtp-Source: AGHT+IFGTxY+ex16EKYbH7ZKmmuSSpBxJClWHEFhaUb/k4+GfZMqfbSe3iK62K5QbjdTfbtMMg+0yg==
X-Received: by 2002:a05:600c:3546:b0:422:1def:e1ac with SMTP id 5b1f17b1804b1-4248635f7demr3214515e9.20.1718988491128;
        Fri, 21 Jun 2024 09:48:11 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b869esm2275286f8f.37.2024.06.21.09.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 09:48:10 -0700 (PDT)
Date: Fri, 21 Jun 2024 19:48:08 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: dsa: qca8k: factor out bridge
 join/leave logic
Message-ID: <20240621164808.saiic5utb2fcazsq@skbuf>
References: <cover.1718899575.git.mschiffer@universe-factory.net>
 <7fbdc27fab4df365db91defca8037b87bdf49438.1718899575.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fbdc27fab4df365db91defca8037b87bdf49438.1718899575.git.mschiffer@universe-factory.net>

On Thu, Jun 20, 2024 at 07:25:49PM +0200, Matthias Schiffer wrote:
> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index b33df84070d3..09108fa99dbe 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c
> @@ -614,6 +614,49 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>  	qca8k_port_configure_learning(ds, port, learning);
>  }
>  
> +static int qca8k_update_port_member(struct qca8k_priv *priv, int port,
> +				    const struct net_device *bridge_dev,
> +				    bool join)
> +{
> +	struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
> +	u32 port_mask = BIT(dp->cpu_dp->index);
> +	int i, ret;
> +
> +	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
> +		if (i == port)
> +			continue;
> +		if (dsa_is_cpu_port(priv->ds, i))
> +			continue;
> +
> +		other_dp = dsa_to_port(priv->ds, i);

I would have liked to see less of the "dsa_to_port() in a loop"
antipattern.
https://lore.kernel.org/netdev/20211018152136.2595220-7-vladimir.oltean@nxp.com/T/

I'll send a patch which refactors the new function to use
dsa_switch_for_each_user_port().

