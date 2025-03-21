Return-Path: <netdev+bounces-176753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3287A6BFF7
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083123B02DE
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6BB22C324;
	Fri, 21 Mar 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfP7a2kB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68BF22B8D2
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574685; cv=none; b=LyiMkl2AV/yb6SL6hZ4NKqV27twzRhb+ZBkNmJ0Sx1FdUvrTtcLyDz1Zy6VUDhGmkK0axaoUcQdemEgvo8zLUQubpTb11v22rThx65PQoO8f3Jx+pmBnOLAygOwkp3hLB7JmGA3rh2XYsIH6f8N887gNe1K0/irABbPlngt+AsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574685; c=relaxed/simple;
	bh=TTuTJrh7x9Bt4TSiLnCijMGPZZ4HvDdlyCy/gTUUm5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJoFtDkzsPz9PGafjG/0CZFg3rxtwo6V5Sd2vwDs0y8JnecidpEmRFqo0sDWSYCOV59fmcivvnFYqDwZIQrI2FV+19ro7xz1EawfEPonk6ozbfujZkkvYtLw2Bbk+olY+daCp14iHu5zgqOs5LkKG5Av+K56v1AdBQejyDx5Exw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfP7a2kB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742574682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rs+RwcS9h+V2ikhjyQECAnVV51IDsPepgkZ5ImH1XsI=;
	b=FfP7a2kBYhrvq/VhEVR6vO1LcX5Amfgf9YWa4O4emOoAyiE0vtSLK/oU3fJkQq/ZGdM8Bz
	Y7rBqdYsUD5YgESj8Q4YDhFXU1o0otcMXY4hgsdZge5suTQsVbYVkMGLoc3wJRKPoztVvY
	XScpJlhu6GgK20uLDInCCDvBn5tCCwU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149--T2C3q6jOmyk92l9EplpBA-1; Fri, 21 Mar 2025 12:31:21 -0400
X-MC-Unique: -T2C3q6jOmyk92l9EplpBA-1
X-Mimecast-MFC-AGG-ID: -T2C3q6jOmyk92l9EplpBA_1742574680
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912d9848a7so1660645f8f.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 09:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574680; x=1743179480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rs+RwcS9h+V2ikhjyQECAnVV51IDsPepgkZ5ImH1XsI=;
        b=togEnvl3QrCOv+/BAhirKE7gCwAT2FAZXsX3f5sv3Cfi+hnTWp8EjEVusEIjmSAYFL
         JiomWWdxIAMAc23QjD4w+BiUWqoSSxdBJJ8FHFhkkVm2OFnwhHwYUdivQJ8erEIxyGyd
         TiIMTqR+Oa8M0G3gfWurxs/wt5jzl2+YMA90fwAYIUrS6WHuBsTPngF6Z1UOls/bbc8a
         9Ri/1X0rFPG/wVnS8K5G1iAE/c5wsS/AD3AuMdo9AqbiKeKITucYHpx2AcaSbRROrN8H
         fBV3Il1vPwOmMzugw+mek7gqeXz0mvor13mVBsE8z1tcIqpLoA/vt2AfbyTIEuiBqjA9
         n3pA==
X-Gm-Message-State: AOJu0Yx5MqqYIHSLfFfFicwRA0clwxKU6J2wD/Znh+AvUhWRqtY9xhG5
	NwYp0BrjggZGdf4eJ5vSZgNVSgTYs9QIcDv2eESZGldYxFfLTg0uGPyrUdsgsK3ilzJJkYmt64u
	cL+GYQAtHQSHnxhGSDrKdBIVPBN5RqJk+3KSCHSY2+0oTtRznnHMAyg==
X-Gm-Gg: ASbGnctTYLlLvxmofLr9VRAYaWDY0li1qEzAsceSAJVQu4s/lEpy4TvqcaduvagaqCa
	khaA/zoJFAD1HpejubGslrVMCW7DqO6hVXADmIurJAariz2QRvjAfs4TIDDbn2DFY6mxKjuhQON
	KaWsIPLWgQOtv4wBPxqDxR1VBQK8MXQpVnSaVlPP2U2rx0DtfA3RMgGNffnsnSSjvl0GpLspHhO
	0yjPvkc6UiRbULH4YbBEK6yhmHAVoRs4Do5P3I2QJRkkxPPbJxqp4vNgS48o+Asd+b31yhSKdEx
	uJOylX97pOlTz0ZPupDXPs/9EuVYQ3NAggaTWc5QrZY8dA==
X-Received: by 2002:a5d:64ce:0:b0:38d:dc03:a3d6 with SMTP id ffacd0b85a97d-399795567f7mr7617675f8f.4.1742574680074;
        Fri, 21 Mar 2025 09:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd4IZz5KXdcrX0+aF/TgGlXF2jzu4TiS7+n1daZwv+t8eYjf13W84OlRjl+h4tIxUwcH3iXA==
X-Received: by 2002:a5d:64ce:0:b0:38d:dc03:a3d6 with SMTP id ffacd0b85a97d-399795567f7mr7617598f8f.4.1742574679564;
        Fri, 21 Mar 2025 09:31:19 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f6bsm2830317f8f.39.2025.03.21.09.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 09:31:19 -0700 (PDT)
Message-ID: <c4e5bd2f-6216-4f74-b677-46c79343eb21@redhat.com>
Date: Fri, 21 Mar 2025 17:31:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/7] net: ethtool: netlink: Allow
 per-netdevice DUMP operations
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
References: <20250313182647.250007-1-maxime.chevallier@bootlin.com>
 <20250313182647.250007-2-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250313182647.250007-2-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/25 7:26 PM, Maxime Chevallier wrote:
> We have a number of netlink commands in the ethnl family that may have
> multiple objects to dump even for a single net_device, including :
> 
>  - PLCA, PSE-PD, phy: one message per PHY device
>  - tsinfo: one message per timestamp source (netdev + phys)
>  - rss: One per RSS context
> 
> To get this behaviour, these netlink commands need to roll a custom
> ->dumpit().
> 
> To prepare making per-netdev DUMP more generic in ethnl, introduce a
> member in the ethnl ops to indicate if a given command may allow
> pernetdev DUMPs (also referred to as filtered DUMPs).
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  net/ethtool/netlink.c | 45 +++++++++++++++++++++++++++++--------------
>  net/ethtool/netlink.h |  2 ++
>  2 files changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index a163d40c6431..7adede5e4ff1 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -587,21 +587,38 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
>  	int ret = 0;
>  
>  	rcu_read_lock();

Maintain the RCU read lock here is IMHO confusing...

> -	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> -		dev_hold(dev);
> +	if (ctx->req_info->dev) {
> +		dev = ctx->req_info->dev;

.. as this is refcounted.

I suggest to move the rcu_read_lock inside the if.


>  		rcu_read_unlock();
> +		/* Filtered DUMP request targeted to a single netdev. We already
> +		 * hold a ref to the netdev from ->start()
> +		 */
> +		ret = ethnl_default_dump_one(skb, dev, ctx,
> +					     genl_info_dump(cb));
> +		rcu_read_lock();
> +		netdev_put(ctx->req_info->dev, &ctx->req_info->dev_tracker);
>  
> -		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
> +		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
> +			ret = skb->len;
>  
> -		rcu_read_lock();
> -		dev_put(dev);
> +	} else {
> +		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> +			dev_hold(dev);
> +			rcu_read_unlock();
> +
> +			ret = ethnl_default_dump_one(skb, dev, ctx,
> +						     genl_info_dump(cb));
> +
> +			rcu_read_lock();
> +			dev_put(dev);
>  
> -		if (ret < 0 && ret != -EOPNOTSUPP) {
> -			if (likely(skb->len))
> -				ret = skb->len;
> -			break;
> +			if (ret < 0 && ret != -EOPNOTSUPP) {
> +				if (likely(skb->len))
> +					ret = skb->len;

IMHO a bit too many levels of indentation. It's possibly better to move
this code in a separate helper.

Thanks,

Paolo


