Return-Path: <netdev+bounces-102009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB83901179
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7229E1F212B4
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D7756B7C;
	Sat,  8 Jun 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWqHL8Bh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211755896;
	Sat,  8 Jun 2024 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717850593; cv=none; b=OGJaOCk9tWrqmvXBV9cjxXq05wlAWy3MbKv1E7WFEqQgRSadJ2VayQlT8wOH1P2DfXroUvU8WmJt8W4IjQe3z2S4npdSgbY92q8PFOW0EOmXyafhwrOjvKd9ofcIicZZcKxDvoXZ9Qfq9fdlza6NhHzW+7y+qjgb2kX8E83IV/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717850593; c=relaxed/simple;
	bh=8nyWEsXGX2UC3fntWUZe5tv9qmwbftOOI1ptiVpeTlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUphpSJS63ksvEoCm9K7jFBYvzKvIdYghrC6ootVBP4T4q+jQUqixpagiLaozlbeBgISc8yL0kVopFCH8z1H1vNrWfboH8hPNTkiMC99C0hcLQR6phfk6HHvR3qQUFZzEmIuS0N90mb/FfS0Q7lbi3LNYW4zajsInygYaa+2eAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWqHL8Bh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a63359aaacaso455803866b.1;
        Sat, 08 Jun 2024 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717850590; x=1718455390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2jJpnazhyNnGAHA2J872EkU21KY+hirrOIRfP72bSc=;
        b=WWqHL8Bhg8UlSSyGoa9DpFuLV47VbsmE+UIbPpvreWKExoeLgV+m8LSy9f+L/vniPN
         KLm7op9lzFvUr74wDoon92sTKEfGQkrKknuI9cf6EBA/+jH83agVh/xp8i17e4oUWG6l
         5/Tr86en0VaWdSD4T8KKITfwDXKzVX2ZPvAEbP5akE/7vkj/4Qyij1sYQXIiA/f/aDbQ
         4zgE3ZCpSpRP/kmnZ6UWvc2Yt9+F5MMwA7+nmynAnexOinNsXOeu7NZXFNiLJpH0Jho4
         BPlxv0YxoQ8f5UsHFCZsLtaHSTSixroOiNhlGBdbjdIK+l/+MqJ8OeEmxxk6GTN2rzmT
         YslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717850590; x=1718455390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2jJpnazhyNnGAHA2J872EkU21KY+hirrOIRfP72bSc=;
        b=oGHvH03r+bRovhZF2eFOF70suUE416bA5Igploh/3beWifyjwdgvT7OB9roY8FnGrH
         VbKHAPWeDl3p+XdV9/jCYgvCTeL32TmF9myEvOzbnUe35ZA/9WMZcnhJKdv7wVWIaOwS
         qDmORotbLvDBIy6icv60h1AnKffS+oEhNDqCRPH75OW/Um4GdQ9+ut8p8SmHk/48DN5U
         kEbv1N3pGNvyIeQKneZcbEgO0nsxgBmeU0rKfQQ+ErScsSfxzXtpMIBhDTDLz7AonE8w
         egiemnrLR0mBpEqjuIWmJ7k8stFGhKIdEA9J86/kZXh2zknOqnPn328W6e9FFi3RSvOG
         5HnA==
X-Forwarded-Encrypted: i=1; AJvYcCUF3EXA6a/hWT5Z0pZNDRm/8sT7BAwsWJUXVHcsyx63kyq/8hcUSWhiIUNqPY2XQkTjGLy/q7a7ykEpFjMNooEyskYeVk2xECtM9C+fJk0FV2tIb0hBXC5O5wxlWDWy1WP5d3q4
X-Gm-Message-State: AOJu0Yzu+tSete/woYFUAo7X9t8Vy7qkh2c6AdOCIGKaxz+ImnNstFem
	Cz/ZE2aO1ye7tK4TkL0UG4EZXr9+psyuckd4xA4S0SUjWtxMFair
X-Google-Smtp-Source: AGHT+IGDEYouqAB0pPS44aRwekYh9i439dQuEXVnbRKmELsUCwf2icDlFZh9N5imcqNACwiXv9tutg==
X-Received: by 2002:a17:906:25c5:b0:a6c:8bc3:aabd with SMTP id a640c23a62f3a-a6cd7d684e9mr310486466b.46.1717850589544;
        Sat, 08 Jun 2024 05:43:09 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f10d1c044sm10633466b.163.2024.06.08.05.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 05:43:09 -0700 (PDT)
Date: Sat, 8 Jun 2024 15:43:06 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	wojciech.drewek@intel.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net v4 PATCH] net: stmmac: replace priv->speed with the
 portTransmitRate from the tc-cbs parameters
Message-ID: <20240608124306.nh2olzpybffitw6w@skbuf>
References: <20240608044557.1380550-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608044557.1380550-1-xiaolei.wang@windriver.com>

On Sat, Jun 08, 2024 at 12:45:57PM +0800, Xiaolei Wang wrote:
> The current cbs parameter depends on speed after uplinking,
> which is not needed and will report a configuration error
> if the port is not initially connected. The UAPI exposed by
> tc-cbs requires userspace to recalculate the send slope anyway,
> because the formula depends on port_transmit_rate (see man tc-cbs),
> which is not an invariant from tc's perspective. Therefore, we
> use offload->sendslope and offload->idleslope to derive the
> original port_transmit_rate from the CBS formula.
> 
> Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> 
> Change log:
> 
> v1:
>     https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240528092010.439089-1-xiaolei.wang@windriver.com/
> v2:
>     Update CBS parameters when speed changes after linking up
>     https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240530061453.561708-1-xiaolei.wang@windriver.com/
> v3:
>     replace priv->speed with the  portTransmitRate from the tc-cbs parameters suggested by Vladimir Oltean
>     link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240607103327.438455-1-xiaolei.wang@windriver.com/
> v4:
>     Delete speed_div variable, delete redundant port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope; and update commit log
> 
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 20 +++++++------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 222540b55480..87af129a6a1d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -344,10 +344,11 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  {
>  	u32 tx_queues_count = priv->plat->tx_queues_to_use;
>  	u32 queue = qopt->queue;
> -	u32 ptr, speed_div;
> +	u32 ptr;
>  	u32 mode_to_use;
>  	u64 value;
>  	int ret;
> +	s64 port_transmit_rate_kbps;
>  
>  	/* Queue 0 is not AVB capable */
>  	if (queue <= 0 || queue >= tx_queues_count)
> @@ -355,27 +356,20 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  	if (!priv->dma_cap.av)
>  		return -EOPNOTSUPP;
>  
> +	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
> +
>  	/* Port Transmit Rate and Speed Divider */
> -	switch (priv->speed) {
> +	switch (div_s64(port_transmit_rate_kbps, 1000)) {
>  	case SPEED_10000:
> -		ptr = 32;
> -		speed_div = 10000000;
> -		break;
>  	case SPEED_5000:
>  		ptr = 32;
> -		speed_div = 5000000;
>  		break;
>  	case SPEED_2500:
> -		ptr = 8;
> -		speed_div = 2500000;
> -		break;
>  	case SPEED_1000:
>  		ptr = 8;
> -		speed_div = 1000000;
>  		break;
>  	case SPEED_100:
>  		ptr = 4;
> -		speed_div = 100000;
>  		break;
>  	default:
>  		return -EOPNOTSUPP;

I have one more request.

It is very discouraging for a user to give invalid parameters and
receive -EOPNOTSUPP, because this is indicative of other "usual
suspects": "did I enable CONFIG_NET_SCH_CBS?"

It is unfortunate that struct tc_cbs_qopt_offload does not carry a
netlink extack, but I'm also not requesting you to add one here.
Instead, please at least change the return code to something like
-EINVAL, and print something to the console along the lines of:
"Invalid portTransmitRate %lld (idleSlope - sendSlope)\n".

