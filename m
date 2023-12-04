Return-Path: <netdev+bounces-53535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D38039F5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3BC1F2117B
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0BA2D784;
	Mon,  4 Dec 2023 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYfhrR1+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20645C6
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:18:28 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c09ba723eso16159845e9.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 08:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701706706; x=1702311506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6gTDKa8XeLwDn2k99kZp/LlfNJLkZGNrQil7SG5bEc=;
        b=WYfhrR1+OPfmqGw/t6HMJfonCTGUyIXG9ucruWmMZz4MQ+R3PPT9xH9cj4OThx8HBO
         DiwcabmyKZTqao4uEjFcK65Ec1rMtu9cgb0lsECJJode7yhZC+7ynugnBtmSmNxdVIHa
         JCwpFBeY0tE1hHn4SP6iXr+445OETsIIWhNK9Mnr+t7qKv3f9w4u0eJkRsgfuLNYyTL+
         ytbF1DL7wbRvAznzDavqmZmohB2XRXbaPv7LVy+nr1GkYW3FujXCfxflm3a/3AqVcm6s
         daTevcYslWkYsQRExmWsVmv80DwyKKX5Rtj0SbBdnIodkr2/LWTtZ0FSfU6c2RLewBu+
         PtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706706; x=1702311506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6gTDKa8XeLwDn2k99kZp/LlfNJLkZGNrQil7SG5bEc=;
        b=nRt8nTCnMPuZBVPIGPxpLxeFAy7VC884yrB6/9oAY5g1ZiqcGJcCbtWjvAPnYB2TWA
         TOJnxyihwvo6kx9Yvh+NiAAKTT/MeXZVt8yTE7vOGNYPtu5l+SqOcbPEfJ2qFeeqVaFO
         xIHN77QyL9SeQOXtiIYrlOMCMXZ81kdPEkNnztHZ5QqLeuPoLaxN8JpScd9Edq7BA/B2
         kWyW+K3+e7MXTPiPb7QOr2/vdtkBKjbTUDdiITGPQxuUmZsJopsa94irFyuByZSGQS/Q
         5kNGmWTKXUM9LHEYl500bvK9l9iMom/jpen0rk4YcGSkDxASO0CeRoUR9XTjuR7XzdpU
         339w==
X-Gm-Message-State: AOJu0Yx7pSJbiBnryfkNOxFj6NbI8O7Z/YHmSSyj0TXhiNv3nGaI+yA8
	N0elu4P42qvvvfnX5ZbM+Pc=
X-Google-Smtp-Source: AGHT+IFmwFW4URqc/Gws4o01/W3ngf0MrIP5qqBSTWyX28iDlFN0lkOgCgxM2c0Nz8LNo4ZNUjHkQA==
X-Received: by 2002:a05:600c:450f:b0:40a:5c71:2c3e with SMTP id t15-20020a05600c450f00b0040a5c712c3emr2348687wmo.19.1701706706235;
        Mon, 04 Dec 2023 08:18:26 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id fa10-20020a05600c518a00b00405442edc69sm19161745wmb.14.2023.12.04.08.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:18:25 -0800 (PST)
Date: Mon, 4 Dec 2023 18:18:23 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: dsa: mv88e6xxx: Create API to read a
 single stat counter
Message-ID: <20231204161823.eyac4mwjakizygmz@skbuf>
References: <20231201125812.1052078-1-tobias@waldekranz.com>
 <20231201125812.1052078-1-tobias@waldekranz.com>
 <20231201125812.1052078-2-tobias@waldekranz.com>
 <20231201125812.1052078-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201125812.1052078-2-tobias@waldekranz.com>
 <20231201125812.1052078-2-tobias@waldekranz.com>

On Fri, Dec 01, 2023 at 01:58:09PM +0100, Tobias Waldekranz wrote:
> This change contains no functional change. We simply push the hardware
> specific stats logic to a function reading a single counter, rather
> than the whole set.
> 
> This is a preparatory change for the upcoming standard ethtool
> statistics support (i.e. "eth-mac", "eth-ctrl" etc.).
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

I think I like this patch set. Some nitpicks below.

> -static int mv88e6320_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
> -				     uint64_t *data)
> +static int mv88e6xxx_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
> +				    const struct mv88e6xxx_hw_stat *stat,
> +				    uint64_t *data)
>  {
> -	return mv88e6xxx_stats_get_stats(chip, port, data,
> -					 STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
> -					 MV88E6XXX_G1_STATS_OP_BANK_1_BIT_9,
> -					 MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
> +	int ret = 0;
> +
> +	if (chip->info->ops->stats_get_stat) {
> +		mv88e6xxx_reg_lock(chip);
> +		ret = chip->info->ops->stats_get_stat(chip, port, stat, data);
> +		mv88e6xxx_reg_unlock(chip);
> +	}

There is no chip->info->ops which does not provide stats_get_stat().
As a separate change, I suppose you could drop the "if".

> +
> +	return ret;
>  }
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
> index 44383a03ef2f..b0dfbcae0be9 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.h
> +++ b/drivers/net/dsa/mv88e6xxx/chip.h
> @@ -574,8 +585,9 @@ struct mv88e6xxx_ops {
>  	/* Return the number of strings describing statistics */
>  	int (*stats_get_sset_count)(struct mv88e6xxx_chip *chip);
>  	int (*stats_get_strings)(struct mv88e6xxx_chip *chip,  uint8_t *data);
> -	int (*stats_get_stats)(struct mv88e6xxx_chip *chip,  int port,
> -			       uint64_t *data);
> +	int (*stats_get_stat)(struct mv88e6xxx_chip *chip,  int port,
> +			      const struct mv88e6xxx_hw_stat *stat,
> +			      uint64_t *data);

Since you are touching this function prototype anyway, I guess you could
change its return type. Int assumes it can also return a negative error
code, which it doesn't. Maybe size_t to denote that it returns an unsigned
count of statistics?

Also, there is an extraneous space before the "int port" argument which
you could fix up now.

>  	int (*set_cpu_port)(struct mv88e6xxx_chip *chip, int port);
>  	int (*set_egress_port)(struct mv88e6xxx_chip *chip,
>  			       enum mv88e6xxx_egress_direction direction,

