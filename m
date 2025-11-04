Return-Path: <netdev+bounces-235462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF5FC30F6F
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E180189A936
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AAC2E5B13;
	Tue,  4 Nov 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="D9m1yPCS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B827470
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258871; cv=none; b=cMR7jGmBHAlL19S2TUgHRjiwDk5sB7K9NsZdJEmsO6KPmHdv4EqNem7fVCFRZnqLN/uFMiq8O4OFAd1GIVqfnLt3xZvm/Ps2b3qslAEZs9lsQdKOM5WcSEIhPRSEMy883wQMVrBSl5n74kjLoHksLjYu70ROv22BpQu0purVOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258871; c=relaxed/simple;
	bh=7/iFG5WAzUfDx6M3aJ8HMxRqjLannXvtDd7sxFaC5ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGHrmiu/5y6feXl7MtAvDZ3YsnK+Q/VCgXPG5cVxQAVhnV93i1UTwFoS6s1DpP43OkkNW5qzRRmeGbB0teAX9gLo1wpC4+mTX0gc/tdF6LKX/NtrjP6jqxQ38EbE5cMLJe1pQbgz/PKV2REqxa4oCv3Ey+/HfKRR+iEHahRB9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=D9m1yPCS; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so4607594a12.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 04:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762258865; x=1762863665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIVUgC/iS+GQBOZrHTrQQryq92A92IQg/Ogu+NF5aA0=;
        b=D9m1yPCSmqVIQzb1Uu/SAXbmfz1TtDE3Al82WTZ4DE+gdYhcslYn/IKIJG+zcEwAlt
         M96XbhPGtLRjsWN0qFysYVG6Ls4NCDniDy+/YKRUMvTgfq/vfQXsQjNgsHZnA4vkHwT1
         Af6Cd6hjUr16EgUSVR30tkWxSBIwXEOJFZce+ijipH7YmPE7vjw6OwU/GNk7to/7qxAe
         YtsH6R2jEPwQohTC/2G+kg792ozLpLz3Wn3J7GGRG2Yh5EZydpP4ag8iN3VvjAvg9a2o
         XzXRgIljeGZkh8TZU/Gqs+uii3YdSKRKOyNs1npzIrbDQntHWHOzLUTmU8Vo1G7uW20W
         ye6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762258865; x=1762863665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIVUgC/iS+GQBOZrHTrQQryq92A92IQg/Ogu+NF5aA0=;
        b=AQ6m/uZVN3Y62pcipHKus7z4AFyMctmTwSShSaJzyIbx+I/yC9h7RSm8O0e8USBzAW
         fMe/yc16fvKyeHjVP7YxEVRzDFXvXXgS3ZkTLi3801F+Fa7YP4gFEau6k8uE9PtNEebT
         CdfvTpMIxR+F/FyAB/p1brDiFWePuDWMdt1pJ+H4BA3SnI/3c8B6QzY6IiAEpqxNGuWJ
         mmQvRmyUEluG8Jg8aFMs2SrFYtnXROfGES0G5DfuqGtqNCfRa3qtOkvx6Ali4KWpKOzY
         62+tzslB91AoTHhmNxLHPeqBW5XbUu69/E9JF13cKrJsA0ky3/xdwFvVg60ZbRzuVDvF
         HG9Q==
X-Gm-Message-State: AOJu0YyC8zVOpx1AD4Cx6gndIPb0vRQrVpASsNNoNb6zywfzUYma5p50
	zs57vfFG9VYLfTkqcF1Z5JosHNsrqIdAqF9FcosHP/D0wTSQhYmZpwVdfYl06fP87sKqEKyAJaj
	WgldBn66/Jw==
X-Gm-Gg: ASbGnctE3Pbez5aaJURRFMTgJafoypp5QLWRK2PXwenbfAS8StxEslvfrUC+6AAazQd
	uTv6lxhxy4fSyrVaHH4VxNFbzZvJKUX45p/RsTRaabGtVG+NB3r1qQqiJLyZiS0auEcwtC84oMh
	O2tNjKU5whdiO9FcPsOuP8ts2wUuSzr1k54bWEZNgTOy/qKhlUmKgT80pQk9L16SiEzbe0X1jWV
	gZPUDCSAYksoP6MdHy7qWrgMJWmsjovK1M/wPiPTGM50VJUPXCbY9qpn+PiJ/ClHLir9xgkpLLV
	wMpe0kzbf4jAXaQStikdenGr44XgB0YF3zOstzbEmULRW/57mjm35eGVHDqHrcKKnQeyBB0Uw0+
	wDTPk1O9/m7Dc5UWAUrKiCNzWIq0CC7sXKOsxYdmOa3eIaftCwRrZmumCvE3cGh30KENsGIurlE
	0xXD0hO7YA95uJBcY2hQEoEbb6i1VLtXhS
X-Google-Smtp-Source: AGHT+IENWRfmlV9P17N5ZlhgCIeMTm8nEfcZT9bxZ2XnEMDFm4tmpuNEJmNOAIW98mTrbihiyO83MQ==
X-Received: by 2002:a05:6402:13c5:b0:634:ce70:7c5 with SMTP id 4fb4d7f45d1cf-64077040ccbmr13947262a12.17.1762258865100;
        Tue, 04 Nov 2025 04:21:05 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640ff615e64sm46612a12.28.2025.11.04.04.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:21:04 -0800 (PST)
Message-ID: <87bb6973-26e5-46c7-8253-3a5eb636dd6a@blackwall.org>
Date: Tue, 4 Nov 2025 14:21:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bridge: fix use-after-free due to MST port
 state bypass
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com, idosch@nvidia.com, kuba@kernel.org,
 davem@davemloft.net, bridge@lists.linux.dev, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org,
 syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
References: <20251104120313.1306566-1-razor@blackwall.org>
 <20251104120313.1306566-2-razor@blackwall.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251104120313.1306566-2-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 14:03, Nikolay Aleksandrov wrote:
> syzbot reported[1] a use-after-free when deleting an expired fdb. It is
> due to a race condition between learning still happening and a port being
> deleted, after all its fdbs have been flushed. The port's state has been
> toggled to disabled so no learning should happen at that time, but if we
> have MST enabled, it will bypass the port's state, that together with VLAN
> filtering disabled can lead to fdb learning at a time when it shouldn't
> happen while the port is being deleted. VLAN filtering must be disabled
> because we flush the port VLANs when it's being deleted which will stop
> learning. This fix avoids adding more checks in the fast-path and instead
> toggles the MST static branch when changing VLAN filtering which
> effectively disables MST when VLAN filtering gets disabled, and re-enables
> it when VLAN filtering is enabled && MST is enabled as well.
> 
> [1] https://syzkaller.appspot.com/bug?extid=dd280197f0f7ab3917be
> 
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Reported-by: syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69088ffa.050a0220.29fc44.003d.GAE@google.com/
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
> Initially I did look into moving the rx handler
> registration/unregistration but that is much more difficult and
> error-prone. This solution seems like the cleanest approach that doesn't
> affect the fast-path.
> 
>  net/bridge/br_mst.c     | 18 +++++++++++++-----
>  net/bridge/br_private.h |  5 +++++
>  net/bridge/br_vlan.c    |  1 +
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
> index 3f24b4ee49c2..4abf8551290f 100644
> --- a/net/bridge/br_mst.c
> +++ b/net/bridge/br_mst.c
> @@ -194,6 +194,18 @@ void br_mst_vlan_init_state(struct net_bridge_vlan *v)
>  		v->state = v->port->state;
>  }
>  
> +void br_mst_static_branch_toggle(struct net_bridge *br)
> +{
> +	/* enable the branch only if both VLAN filtering and MST are enabled
> +	 * otherwise port state bypass can lead to learning race conditions
> +	 */
> +	if (br_opt_get(br, BROPT_VLAN_ENABLED) &&
> +	    br_opt_get(br, BROPT_MST_ENABLED))
> +		static_branch_enable(&br_mst_used);
> +	else
> +		static_branch_disable(&br_mst_used);
> +}
> +
>  int br_mst_set_enabled(struct net_bridge *br, bool on,
>  		       struct netlink_ext_ack *extack)
>  {
> @@ -224,11 +236,7 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
>  	if (err && err != -EOPNOTSUPP)
>  		return err;
>  
> -	if (on)
> -		static_branch_enable(&br_mst_used);
> -	else
> -		static_branch_disable(&br_mst_used);
> -
> +	br_mst_static_branch_toggle(br);
>  	br_opt_toggle(br, BROPT_MST_ENABLED, on);
>  	return 0;
>  }
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 16be5d250402..052bea4b3c06 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1952,6 +1952,7 @@ int br_mst_fill_info(struct sk_buff *skb,
>  		     const struct net_bridge_vlan_group *vg);
>  int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
>  		   struct netlink_ext_ack *extack);
> +void br_mst_static_branch_toggle(struct net_bridge *br);
>  #else
>  static inline bool br_mst_is_enabled(struct net_bridge *br)
>  {
> @@ -1987,6 +1988,10 @@ static inline int br_mst_process(struct net_bridge_port *p,
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline void br_mst_static_branch_toggle(struct net_bridge *br)
> +{
> +}

oh, just realized this is actually unnecessary since MST relies on bridge vlan filtering
to be enabled, I will wait 24h for feedback and post v2 without this

>  #endif
>  
>  struct nf_br_ops {
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index ce72b837ff8e..636d11f932eb 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -911,6 +911,7 @@ int br_vlan_filter_toggle(struct net_bridge *br, unsigned long val,
>  	br_manage_promisc(br);
>  	recalculate_group_addr(br);
>  	br_recalculate_fwd_mask(br);
> +	br_mst_static_branch_toggle(br);
>  	if (!val && br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
>  		br_info(br, "vlan filtering disabled, automatically disabling multicast vlan snooping\n");
>  		br_multicast_toggle_vlan_snooping(br, false, NULL);


