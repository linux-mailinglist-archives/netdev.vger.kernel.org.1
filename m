Return-Path: <netdev+bounces-297659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PqYINehYKWqrVQMAu9opvQ
	(envelope-from <netdev+bounces-297659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:30:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 231736694B3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:30:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=cmVIGQtZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297659-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297659-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35AA1304399A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191A4071EB;
	Wed, 10 Jun 2026 12:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43024071DB
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:30:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094617; cv=none; b=ZyUEzR6Hjx67gCvm0ESw0XIq6UEBNLzngdNYaDaqkoNqseSiGGqBdxSJA/L7bRGisA4XUHAIcRi9DrkBVTSiZJq4A1ztvfFTWi13/Nz2PUAz0cjhcE8cgGNsX1au1liyNkY3kXhMytviSpZF52RREcrRThUIaEuHAMw+jBmXI1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094617; c=relaxed/simple;
	bh=X5giAahWKCgxRNNMKpRda2pbSb84nq3shUVKMlpCIFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HieMRC0Ii+19rcURf6JNejStaj5jSd45eerJu7QMlD3DvCxYy2K+DVB1x2Cr2a+c4r/1/4q+dlUP6cad7KevWxeflM9v1E+kU5+1qrQqh3S/h/sXl6LZ82amoATZmGYWdXQiw2xYVhXLK5UDKR/3iVftuO7rCPDUPOO6q+sqh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=cmVIGQtZ; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b613a17bso65751675e9.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781094614; x=1781699414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDWJDQUwQ0uQHyCuBG7403wQa5ywBdqSwJZptO+kZgs=;
        b=cmVIGQtZumUUCR5u/IkLaSAVitUM5fFohPulfBrH2Ywhy9TFZRJba3v7aOtw2R0Y+w
         1pUmEDbNlNMY/SwfnS/4sfH0DCFbWStu5NrDJoNh6073uoR/+6L2hYD81eFavL1ITdEF
         59roc+JjV+474GyksPkvRXO7zh3V1V+O0q1U1k8eoKOAip/x4vOh5kgjFv7VXZ+Xp9tk
         TMl1c1kbvT7vUZjBCA+MnW8TmZYcll7lHb+WGsYLZ+jlhalNTE/tdXz8WZu2b+fHjx7r
         3eCscBq90yx7AUQ/UrzloDbU04zkjjqJk/Ao1uAtD47SHIa2bsozY0cHTC8aJvQo8bL3
         Bswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781094614; x=1781699414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDWJDQUwQ0uQHyCuBG7403wQa5ywBdqSwJZptO+kZgs=;
        b=ps79kj2PfWV5dVKBIcTazD4mzQGtvk1pZIVwBg6xLSDwfqItFeaod1aLLkIlCy4UQI
         xm3s4aOOaU8TFkwzvrLR6Pd91P7JGKqT29S17X7A2SMx2FhzNmdmwaUqKR6YWUANdf2h
         3qks2/eyyLB0EQNi2+Ff6t8Egnf0pnIYaCDrvHqtuTtvjvri0P9GZ5Oz/VR3vJd/UHfP
         JiDV0W6pyDMiQLF8w/XOT2tx/vnyVpr1BH4DNqRKWzIk/a3SjKVpwSNJsj0/8Vw/RMVW
         rrDibT/yaLeJBYq9RYQ0uDPE8h6LE26ZF3ZLaEJxdLYsJNW9BJSHlJeo+7zvnIzz12X4
         5/iQ==
X-Gm-Message-State: AOJu0YyFUh7ymq6BA76aR8UcXBYfqTsxPUObrR+jMZjvspHsxtX04HlA
	4xXA18ujnfHuq9bwEAY3fWG99yHqY43O2Wx1CEb/XVXf2s2V5MBYK8vmnlvvACGfeYT8IkZjxxx
	TzVn2Jj8=
X-Gm-Gg: Acq92OEy3XVg/F+6f2PlFvenUB99+sXDLOo/odfdDP4B/FWH4cEdzV4EAmOdfZC6XBc
	Cls58EhEFRZrZBL1YYof64uJPW7VoMk8ITt5ivlrHaTDrDB6bq03z8c6CY0TNGtLrKeJwf3/QLg
	FR7/VF93Fan1OPX0hqGCen8h6k6GgMVv5w401s7x/c4ZQJ9TFitdbi0vhfqxAwZiHrNqc2BeD97
	QdTy8BntjvY+dzrnYBX2wz7sdKsF3H2FO7xGmdc+ksUTeycR3a2BuWKFxAQ+YQag7md5KBIC1tY
	7KOQ/k1N9thpeG2YT+iFcKnEwA+edvDQlOGAEZIbbld2sT1M9vELH8zY9D37ZI7qSBOeiidIZxM
	tZWTwa4OpzkA6a5CM3j+CKFEHmKT2GIyyKYUkIrNRk17cB/bFn2JucPUO94ZKeUVZrYPokSg3vj
	/cQXq3tipW3W9CvXUjXANbUrOQjZXlV5tnB6HDhkAm1DCxDF2SoGzP4GxNCrF6LY4+ZzX/+xdfD
	z4=
X-Received: by 2002:a05:600c:4894:b0:490:e1a6:261 with SMTP id 5b1f17b1804b1-490e1a602d8mr1136045e9.26.1781094613953;
        Wed, 10 Jun 2026 05:30:13 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e5a00sm554599895e9.15.2026.06.10.05.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 05:30:13 -0700 (PDT)
Message-ID: <1f949cfc-eebc-4813-9dfc-b9a9ec79494d@blackwall.org>
Date: Wed, 10 Jun 2026 15:30:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: add sysfs interface for
 broadcast_neighbor
Content-Language: en-US, bg
To: Yafang Shao <laoar.shao@gmail.com>, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, Tonghao Zhang <tonghao@bamaicloud.com>
References: <20260610120812.49054-1-laoar.shao@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260610120812.49054-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297659-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:laoar.shao@gmail.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:tonghao@bamaicloud.com,m:laoarshao@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[blackwall.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bamaicloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 231736694B3

On 10/06/2026 15:08, Yafang Shao wrote:
> The upstream kernel has supported broadcast_neighbor for 802.3ad mode since
> commit ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad").
> When upgrading from our local kernel to 6.18.y stable, we switched from our
> out-of-tree implementation to the upstream one.
> 
> However, the iproute2 package on our production servers is too old to
> support the broadcast_neighbor option. To enable this feature, add a new
> sysfs attribute at:
> 
>    /sys/class/net/<bond>/bonding/broadcast_neighbor
> 
> This allows enabling the feature by writing "1" to the sysfs file, matching
> the interface we previously maintained in our local kernel.
> 
> The result is as follows,
> 
> - For 802.3ad mode
> 
>    $ ip link add bond0 type bond mode 802.3ad
>    $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
>    0
>    $ echo 1 > /sys/class/net/bond0/bonding/broadcast_neighbor
>    $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
>    1
> 
> - For other modes
> 
>    $ ip link add bond1 type bond
>    $ cat /sys/class/net/bond1/bonding/broadcast_neighbor
>    0
>    $ echo 1 > /sys/class/net/bond1/bonding/broadcast_neighbor
>    bash: echo: write error: Permission denied
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Tonghao Zhang <tonghao@bamaicloud.com>
> ---
>   drivers/net/bonding/bond_sysfs.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
> index eaba44c76a5e..24eb23634d98 100644
> --- a/drivers/net/bonding/bond_sysfs.c
> +++ b/drivers/net/bonding/bond_sysfs.c
> @@ -750,6 +750,17 @@ static ssize_t bonding_show_ad_user_port_key(struct device *d,
>   static DEVICE_ATTR(ad_user_port_key, 0644,
>   		   bonding_show_ad_user_port_key, bonding_sysfs_store_option);
>   
> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct bonding *bond = to_bond(d);
> +
> +	return sysfs_emit(buf, "%d\n", bond->params.broadcast_neighbor);
> +}
> +static DEVICE_ATTR(broadcast_neighbor, 0644,
> +		   bonding_show_broadcast_neighbor, bonding_sysfs_store_option);
> +
>   static struct attribute *per_bond_attrs[] = {
>   	&dev_attr_slaves.attr,
>   	&dev_attr_mode.attr,
> @@ -789,6 +800,7 @@ static struct attribute *per_bond_attrs[] = {
>   	&dev_attr_ad_actor_system.attr,
>   	&dev_attr_ad_user_port_key.attr,
>   	&dev_attr_arp_missed_max.attr,
> +	&dev_attr_broadcast_neighbor.attr,
>   	NULL,
>   };
>   

Then update your iproute2 package, sysfs use for options is discouraged
and is not being extended on purpose. Move to netlink.

Cheers,
  Nik



