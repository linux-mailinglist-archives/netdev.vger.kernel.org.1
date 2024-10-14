Return-Path: <netdev+bounces-135050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B47F99BFEC
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B481F21B3A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 06:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2E13C3D3;
	Mon, 14 Oct 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="wppyEZm7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8013FD83
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886737; cv=none; b=n+z7hHm2XWHYqbLVPiWyclczksnr0CcT2zFvmWuXUPsvqwEI+KoHu9C/O2qrFw66ZqleTAKUoZ96bfa1HELYmrW2JoTGTqq8u2+zjzSt8H7dUr0XNSt3OBemz//AK/qw4TGsB4wDKIbt3spqPSduHsxSRF1DYX58GWXfXvW4Cqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886737; c=relaxed/simple;
	bh=W47EBxUd4So3WOQ3aEFBi0JujL0V1WGzhx5BEdhOZMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMb1CZvaa19jKlOWuRCXV5+i3DJpUIezN6sXtirU6NXH1156d411dixhrP0PirD9XMFoG82d6VD1w5fEenTRLpMeWQZy6h6P+wMAU6qI0CO3kSkA43jZQD55+Ztf0Kahh5NvtshqsJIJ6L7qIXhw0ZTz0YsFmKkV6KUNKhH6pw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=wppyEZm7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso647205566b.3
        for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728886734; x=1729491534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zure5lvUwd4y3h6SKiHFc2bGJpvRNoEVud01V6tGSD8=;
        b=wppyEZm7UCEzWoXX0GpJ6QHKfybG56fvf3Fmo0vMyIxoiUzxZ0ZBBIHDzITWHloPhi
         vhwbNwmrYKcWIFWA8LLQveIG6ZyYDeHYMdKB3mSvV/Wv6pwGtOC8WTfyy40X7ymUrWrH
         mezEH6ImhD0kDKXdixK/8y8M11dxQ3UcCu9588A/QAlhl3POqTFaPmlhkeew/iB8QyGs
         wMCOFvA4Sg34idPR+AwswHej4O3kHRX+Tr5nZ/R/EGsMVpboHsc7gEIfyJ+HQJ4/1G5X
         XHhnyORgAVkobknQg26a3tc7psMHXVT3TuU+vixH4BhDYmyzBkyTj+2+Nq95qsdpYrK6
         h54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728886734; x=1729491534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zure5lvUwd4y3h6SKiHFc2bGJpvRNoEVud01V6tGSD8=;
        b=GOKiL9UrCCsOWvrvWCrZ6conouksHdWNeYpTSEdd0hlNFf8NFC4uQE5aT4SswLGcsY
         8gs2GDLfU0BV7PGjip6/TW+TKWijfDgg67yu5U7PndpBvvAYtXBdsyUCfNfJPcayPEMb
         FVRztwEaEuBInTraOlPnAY3vrgf3Ef+7XB2piXE5ZB3ZNhihSFQVtyitgPlrUYo4Z/XU
         JfFtWIUAQVSAJ22AoRmXPxS1paXCa22J6He1CQluOClZ3SSg17Ih3hrLsv3r/CFPVgEF
         4c3uM+1/Qw1g3FkvQXF8accW1HTK4uZ28JohJOENV/YzgeSRTOTb8f658SFvU4/MxSAA
         pCnw==
X-Gm-Message-State: AOJu0YzYp/1rQKULBfGwP5LA8atG7cgiFu1RegtAhkeY1S20jxB9B2OC
	6Z8GHe8V2FezCCUNmcHUElboyAJKqva0tzvMVu7YmiaRERQ2t3GR+XJ6wB7uiEg=
X-Google-Smtp-Source: AGHT+IEq3aFz947OeC3fnnlhKWldwZ4U2/ijCIgS712duTcB6H5tPdhjhbywyLClV0UUqizNN5JhcQ==
X-Received: by 2002:a17:907:1c03:b0:a99:4ce4:27eb with SMTP id a640c23a62f3a-a99e3e51bb2mr731229266b.46.1728886733995;
        Sun, 13 Oct 2024 23:18:53 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f330496fsm255136366b.26.2024.10.13.23.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 23:18:53 -0700 (PDT)
Message-ID: <281cce27-c832-41c8-87d0-fbac05b8e802@blackwall.org>
Date: Mon, 14 Oct 2024 09:18:51 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 net-next 11/12] bridge:
 br_vlan_fill_forward_path_mode no _UNTAG_HW for dsa
To: Eric Woudstra <ericwouds@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241013185509.4430-1-ericwouds@gmail.com>
 <20241013185509.4430-12-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241013185509.4430-12-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2024 21:55, Eric Woudstra wrote:
> In network setup as below:
> 
>              fastpath bypass
>  .----------------------------------------.
> /                                          \
> |                        IP - forwarding    |
> |                       /                \  v
> |                      /                  wan ...
> |                     /
> |                     |
> |                     |
> |                   brlan.1
> |                     |
> |    +-------------------------------+
> |    |           vlan 1              |
> |    |                               |
> |    |     brlan (vlan-filtering)    |
> |    |               +---------------+
> |    |               |  DSA-SWITCH   |
> |    |    vlan 1     |               |
> |    |      to       |               |
> |    |   untagged    1     vlan 1    |
> |    +---------------+---------------+
> .         /                   \
>  ----->wlan1                 lan0
>        .                       .
>        .                       ^
>        ^                     vlan 1 tagged packets
>      untagged packets
> 
> Now that DEV_PATH_MTK_WDMA is added to nft_dev_path_info() the forward
> path is filled also when ending with the mediatek wlan1, info.indev not
> NULL now in nft_dev_forward_path(). This results in a direct transmit
> instead of a neighbor transmit. This is how it should be, But this fails.
> 
> br_vlan_fill_forward_path_mode() sets DEV_PATH_BR_VLAN_UNTAG_HW when
> filling in from brlan.1 towards wlan1. But it should be set to
> DEV_PATH_BR_VLAN_UNTAG in this case. Using BR_VLFLAG_ADDED_BY_SWITCHDEV
> is not correct. The dsa switchdev adds it as a foreign port.
> 
> Use BR_VLFLAG_TAGGING_BY_SWITCHDEV to make sure DEV_PATH_BR_VLAN_UNTAG is
> set when there is a dsa-switch inside the bridge.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/bridge/br_private.h |  1 +
>  net/bridge/br_vlan.c    | 18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 8da7798f9368..7d427214cc7c 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -180,6 +180,7 @@ enum {
>  	BR_VLFLAG_MCAST_ENABLED = BIT(2),
>  	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
>  	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
> +	BR_VLFLAG_TAGGING_BY_SWITCHDEV = BIT(5),
>  };
>  
>  /**
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 1830d7d617cd..b7877724b969 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -3,6 +3,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/slab.h>
> +#include <net/dsa.h>
>  #include <net/switchdev.h>
>  
>  #include "br_private.h"
> @@ -100,6 +101,19 @@ static void __vlan_flags_commit(struct net_bridge_vlan *v, u16 flags)
>  	__vlan_flags_update(v, flags, true);
>  }
>  
> +static inline bool br_vlan_tagging_by_switchdev(struct net_bridge *br)

no inline in .c files and also constify br

> +{
> +#if IS_ENABLED(CONFIG_NET_DSA)
> +	struct net_bridge_port *p;
> +
> +	list_for_each_entry(p, &br->port_list, list) {
> +		if (dsa_user_dev_check(p->dev))

I don't think this can change at runtime, so please keep a counter in
the bridge and don't walk the port list on every vlan add.

> +			return false;
> +	}
> +#endif
> +	return true;
> +}
> +
>  static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
>  			  struct net_bridge_vlan *v, u16 flags,
>  			  struct netlink_ext_ack *extack)
> @@ -113,6 +127,8 @@ static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
>  	if (err == -EOPNOTSUPP)
>  		return vlan_vid_add(dev, br->vlan_proto, v->vid);
>  	v->priv_flags |= BR_VLFLAG_ADDED_BY_SWITCHDEV;
> +	if (br_vlan_tagging_by_switchdev(br))
> +		v->priv_flags |= BR_VLFLAG_TAGGING_BY_SWITCHDEV;
>  	return err;
>  }
>  
> @@ -1491,7 +1507,7 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
>  
>  	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
>  		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
> -	else if (v->priv_flags & BR_VLFLAG_ADDED_BY_SWITCHDEV)
> +	else if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
>  		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG_HW;
>  	else
>  		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG;


