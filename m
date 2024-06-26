Return-Path: <netdev+bounces-106798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306AD917ACE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC807282829
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4F815F41B;
	Wed, 26 Jun 2024 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ExISM7cA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D9144D1D
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390147; cv=none; b=TKQUomlw4rJSHgXxqFBtmUgn/evjpeAtsP8Doeicti2z2iGU3vrmS+0R0bFJ5ZMcRCZphXCo3WoOouFkVHB77cZ0UIp+0K8D0ME/3qpsRKF2NuA9lk4oKoi2rSBa0XhlrstcxLo5i4exoMvFRQVRtQm9+XuRo9EcUqaP92+QYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390147; c=relaxed/simple;
	bh=JYps23Xz3Ds42IowldrCoX128pLgt4VoIKfObOfZb4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4RKtApjHlFOfAHbiWkSWblSTEejNbjNU6rI5JRlY4tJ6ekhzJP2EqtcLX0igbvAbvRsC0CC6ES+QBFY3i3syG55hl35nHTWbXnzT+cebQKCAhIx1xSDVPlCdvRgRztvGhH7BM8M0oVZyKbx1vWeiUH/C8uz9W8HMmVD5uVyIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ExISM7cA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57d2fc03740so5351836a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719390143; x=1719994943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUnD46cZDELIGwQTFYeVfK+9zP8guow0ZZ8apVMdLX4=;
        b=ExISM7cAaGpAHyUIqNWidCT9IIAccb6q3k3tE+9AiS9C6Mb27azZsPWPte0mCQNRSf
         FHnDlf8dl4w51TWIan7hdJBWqOjW6BWH24d0IlytuzZhdwXT19fkP2HtOgbJQ5SaDOFd
         nPlob8jKQCQkMNZSiSP2whiHVzZxJ5KpZNaYNYTXAFVEiYnvP8mVTmORAW1+17+LhFJI
         LplP5voWbYJs+bo4yM8mfsLW2YjvjLg9K0H2wmjbCvkgqJdFNdSdRQ3f1ORP3s9OD7KL
         xm00jPS95sFwY2gGYqbgah1vS+nxulwETAh2zYc/e1jP4avnKM5cs/UiKYIODRG6trLf
         bKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719390143; x=1719994943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUnD46cZDELIGwQTFYeVfK+9zP8guow0ZZ8apVMdLX4=;
        b=Xdb6+TinorHoxUODtMX+yAE1GWXb51sbIW/zMddCV8cGF8ifN8u9lhKJ//uoC1uU/t
         nsabnpPIOQEYtmalcQ4ezLIIVKswywa21rIQtc3kL7mBNoZeIIKZENBzf7h+oFW2ggZz
         J3QJC3OrtTpttXivNJy2kLxKZHFFd77pOuBws7ZGCFuP/lU+av2urxQKondfQNxBrZcV
         8zUeDbDxOOeYLVWuqeV6itsU9Cy+gHqrJ30yZCRjcWo64ZlidUyxxIVwMb+lxeXp7H49
         rMjeuGZ+TDnnxMCGj4u3alQg8kd2nTZDFv5JzjqiJ6DEsalcMuyD9XbnAeKSs1toA1ky
         cv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2oUW8KFCqS3vtmt2ifFCDrDZ/g7ItwdaHb/HqyP7RkGtU+jPbl3/syBf9kH6FyviN9zIV2N4hKHvw0OUyUE5u1FIyf+uW
X-Gm-Message-State: AOJu0Yx/HdU37SC8ySk7UVv2IYszanopCZ2dOgXS4QBnmzKsPE/ym0l1
	FVS5ROU5b5pzOjYZPxhi7BJf2V2UCS1FU4lITtnJ/ycy9d18MytQgKMYkUDBM7pMeUQMTZMsnx/
	rvW1dtw==
X-Google-Smtp-Source: AGHT+IFXKH1o8vVxh8R+wfPdREH64UqNWOnxRoYX17Z/Y1NEXzdLxKd8LFPpdPc6Q4I6VVqB1la9jg==
X-Received: by 2002:a50:d653:0:b0:57c:74ea:8d24 with SMTP id 4fb4d7f45d1cf-57d4bd71891mr6140198a12.18.1719390143271;
        Wed, 26 Jun 2024 01:22:23 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30534e4bsm6828111a12.66.2024.06.26.01.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 01:22:22 -0700 (PDT)
Message-ID: <6003cec0-d711-4fae-bb89-17ca26421d1f@blackwall.org>
Date: Wed, 26 Jun 2024 11:22:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240626075156.2565966-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/2024 10:51, Hangbin Liu wrote:
> Currently, administrators need to retrieve LACP mux state changes from
> the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
> this process, let's send the ifinfo notification whenever the mux state
> changes. This will enable users to directly access and monitor this
> information using the ip monitor command.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v3: forgot to use GFP_ATOMIC. (Nikolay Aleksandrov)
>     export symbol for rtmsg_ifinfo. It's weird that my build succeed with
>     tools/testing/selftests/drivers/net/bonding/config without export
>     the symbol, but build failed with tools/testing/selftests/net/config.
> v2: don't use call_netdevice_notifiers as it will case sleeping in atomic
>     context (Nikolay Aleksandrov)
> 
> After this patch, we can see the following info with `ip -d monitor link`
> 
> 7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     veth
>     bond_slave state BACKUP mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 143 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,expired> ad_partner_oper_port_state 55 ad_partner_oper_port_state_str <active,short_timeout,aggregating,collecting,distributing> ...
> 7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     veth
>     bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 79 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,defaulted> ad_partner_oper_port_state 1 ad_partner_oper_port_state_str <active> ...
> 7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     veth
>     bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 63 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state 63 ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ...
> ---
>  drivers/net/bonding/bond_3ad.c | 3 +++
>  net/core/rtnetlink.c           | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab7..b57c5670b31a 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -11,6 +11,7 @@
>  #include <linux/etherdevice.h>
>  #include <linux/if_bonding.h>
>  #include <linux/pkt_sched.h>
> +#include <linux/rtnetlink.h>
>  #include <net/net_namespace.h>
>  #include <net/bonding.h>
>  #include <net/bond_3ad.h>
> @@ -1185,6 +1186,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
>  		default:
>  			break;
>  		}
> +
> +		rtmsg_ifinfo(RTM_NEWLINK, port->slave->dev, 0, GFP_ATOMIC, 0, NULL);
>  	}
>  }
>  
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index eabfc8290f5e..4507bb8d5264 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4116,6 +4116,7 @@ void rtmsg_ifinfo(int type, struct net_device *dev, unsigned int change,
>  	rtmsg_ifinfo_event(type, dev, change, rtnl_get_event(0), flags,
>  			   NULL, 0, portid, nlh);
>  }
> +EXPORT_SYMBOL(rtmsg_ifinfo);
>  
>  void rtmsg_ifinfo_newnet(int type, struct net_device *dev, unsigned int change,
>  			 gfp_t flags, int *new_nsid, int new_ifindex)

Looks good to me, thanks!
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


