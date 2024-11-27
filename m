Return-Path: <netdev+bounces-147613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804299DAABA
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 16:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395AD2815F3
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E900B1FF7D0;
	Wed, 27 Nov 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="pfP6uYr5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013151E51D
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721204; cv=none; b=XpJ20FTUmidcjwm3JmIl5b64QQPR2OVvIoUuqrqHzKgsUSZPLAwesr53KF5go/FTebqopkltuJTm+miNyhQhprJkaPi/MQfZuZwF8PAuFkKjwSi4nfYSpx4Uteh7jnnrM8LV1uwoXSn6niBji3xlBm70BR3pYAZ4odr+zqeLkxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721204; c=relaxed/simple;
	bh=GJf3i/XDIVDhsA/XhOwq8syjtapR6LMIST7/HQ/e8Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/D6sMPmvp4+wE4dvKjbBGPvRX6L3cdis8rtT9dbOnIUfpcMqoxyWwIbedtGrGMZ7lCDmaX7RC5Jn/GbSvujVw0sFB6sjUpkNHXKF7WJfb4Abhcm0yz2Tb4bC7ddHNz0L8+/ZKFiRT4D4HhhDg2BmmhIXnd6FxSATondSuC/huQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=pfP6uYr5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3823cae4be1so4262229f8f.3
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 07:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1732721201; x=1733326001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fW/M4oPV0/KPGqG0SIYH3NNGppK50TUAetW8hAYS+Xs=;
        b=pfP6uYr5uPMyBSQLQRnViEnKIERrlCP5GPIDCtXLDd/FEnLp6z82Mh2uShQZwlvUms
         qhqKZss11nPjHeqqNC4LbzgPa2GdGEG+xT9yKMzmAn4Lcc4SuGGypohP7q4UITm2zBPV
         jLQVbraDiz/PElcv4ok2j2qOE7D0xtZc5WOX9l5aFrHtQ5kJOvge5og+GuxljiUIyR79
         q7KT19Je03/yTPJ3/3q62uqZEHt3tnk4Jsbmipke7U2UALxky6h3PSuBgPbQyC3I5D0Y
         nKyQIpjlG5d6E5+2jBfN/ZLLiUTXLqw4tX9LtvzOcO6xCOV9UdEvVAaVR+n65k08xbpE
         7OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732721201; x=1733326001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fW/M4oPV0/KPGqG0SIYH3NNGppK50TUAetW8hAYS+Xs=;
        b=LnvAd9NmVR9HzT0CWtoPy539h53ioKJwf84C+r+XhcXuN89L2xasPEvQIcfJg6hP2k
         1eAtI9UDUQ7hpGc+2ITeOyNQqG0sWQhJ2OUx/nxQT3LkYaGYyqvoNs/csjRk8+aFZTVJ
         7fVAdAZuiE0DlAZjRbBPQmVK5cR4o1xaW9nJJrqgBFfbD9+E0WHZx0EkP6yce9yZaFPQ
         LV6zi9t9k6XraKOKwUtej7UaqcwkOV59SDsBmS14hgm/VSJe3rgRW7bwMUFcd88f6W1n
         jILMPamBoL9leZ4jMI6KKZt1Jd5x7s/71SZNpBitxT/TVP0tRjnqJ3gNPloIwUgWzEsK
         6wqg==
X-Forwarded-Encrypted: i=1; AJvYcCWhex53tUWLlOuZVPdyZtd5iEbDY3aR7U2EidKF0QnLwRPnZ1QK1EXsBdmHZyk5OOtGbGNTT+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKuI7GPlYY8iq7VA63+1nNmc2aLPnpvJBMQJwR4jcr0p9K77HN
	tqSXZnBuf+lquUSaBdzyt1/0KBFdkZomNh0IWYih/ZlcOjK9PRTGeTo8kp8WMAM=
X-Gm-Gg: ASbGncthJRxl4MN51c+BtqlMrXSwKqomZXfttjVAF+nJgEW3ojUTcEIizQXHZph853d
	GxKtCeiQDPs3TG+PTrxSj/Pf/9ZxQDkVkAjSnybJ/N8qaun8uP12Jo7Nvo+xMWUpcSHj88r5gL8
	TmfjDj17PJ6sQUWgddjRYXZ0zku+BVQ1znXxCPuDPLsrH0pUY7eeIk9ew1nmTyqsjSJjzzezyoF
	EhRBpraxOjsQj8aGUM9lhYIipCeCO8H0PBTlSk0n+Mr6JJMhVSN
X-Google-Smtp-Source: AGHT+IFoxy7WV35Ygj3vsbdYcky2hEvBC0FIqeNel/qXKrrNnmPVuy76qDW0Q5E6BNRWF87nahyzcQ==
X-Received: by 2002:a05:6000:4405:b0:382:503c:da57 with SMTP id ffacd0b85a97d-385c6eba9ecmr2064794f8f.33.1732721201276;
        Wed, 27 Nov 2024 07:26:41 -0800 (PST)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe3cbsm16506610f8f.38.2024.11.27.07.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 07:26:40 -0800 (PST)
Message-ID: <4522c622-3e77-4191-8af6-f0ee8cd9061e@blackwall.org>
Date: Wed, 27 Nov 2024 17:26:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 2/2] net: bridge: multicast: update multicast
 contex when vlan state gets changed
To: Yong Wang <yongwang@nvidia.com>, roopa@nvidia.com, davem@davemloft.net,
 netdev@vger.kernel.org
Cc: aroulin@nvidia.com, idosch@nvidia.com, ndhar@nvidia.com
References: <20241126213401.3211801-1-yongwang@nvidia.com>
 <20241126213401.3211801-3-yongwang@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241126213401.3211801-3-yongwang@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2024 23:34, Yong Wang wrote:
> Add br_vlan_set_state_finish() helper function to be executed right after
> br_vlan_set_state() when vlan state gets changed, similar to port state,
> vlan state could impact multicast behaviors as well such as igmp query.
> When bridge is running with userspace STP, vlan state can be manipulated by
> "bridge vlan" commands. Updating the corresponding multicast context
> will ensure the port query timer to continue when vlan state gets changed
> to those "allowed" states like "forwarding" etc.
> 
> Signed-off-by: Yong Wang <yongwang@nvidia.com>
> Reviewed-by: Andy Roulin <aroulin@nvidia.com>
> ---
>  net/bridge/br_mst.c          |  5 +++--
>  net/bridge/br_multicast.c    | 18 ++++++++++++++++++
>  net/bridge/br_private.h      | 11 +++++++++++
>  net/bridge/br_vlan_options.c |  2 ++
>  4 files changed, 34 insertions(+), 2 deletions(-)
> 

A few comments below,

> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
> index 1820f09ff59c..b77c31a24257 100644
> --- a/net/bridge/br_mst.c
> +++ b/net/bridge/br_mst.c
> @@ -80,10 +80,11 @@ static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
>  	if (br_vlan_get_state(v) == state)
>  		return;
>  
> -	br_vlan_set_state(v, state);
> -
>  	if (v->vid == vg->pvid)
>  		br_vlan_set_pvid_state(vg, state);
> +
> +	br_vlan_set_state(v, state);
> +	br_vlan_set_state_finish(v, state);

This state_finish function is called after every instance of br_vlan_set_state(),
just add that call to br_vlan_set_state.

>  }
>  
>  int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 8b23b0dc6129..3a3b63c97c92 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4270,6 +4270,24 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
>  #endif
>  }
>  
> +void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
> +{
> +	struct net_bridge *br;
> +
> +	if (!br_vlan_should_use(v))
> +		return;
> +
> +	if (br_vlan_is_master(v))
> +		return;
> +
> +	br = v->port->br;
> +
> +	if (br_vlan_state_allowed(state, true) &&
> +	    (v->priv_flags & BR_VLFLAG_MCAST_ENABLED) &&

checking this flag without mcast lock is racy.

> +	    br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))

this should be the first check

> +		br_multicast_enable_port_ctx(&v->port_mcast_ctx);

What about disable? What if the state is != LEARNING/FORWARDING ?

> +}
> +
>  void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
>  {
>  	struct net_bridge *br;
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 9853cfbb9d14..9c72070956e3 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1052,6 +1052,7 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
>  				struct net_bridge_vlan *vlan,
>  				struct net_bridge_mcast_port *pmctx);
>  void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx);
> +void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state);
>  void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on);
>  int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
>  				      struct netlink_ext_ack *extack);
> @@ -1502,6 +1503,10 @@ static inline void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pm
>  {
>  }
>  
> +static inline void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
> +{
> +}
> +
>  static inline void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan,
>  						bool on)
>  {
> @@ -1853,6 +1858,12 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
>  bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
>  			      const struct net_bridge_vlan *v_opts);
>  
> +/* helper function to be called right after br_vlan_set_state() when vlan state gets changed */
> +static inline void br_vlan_set_state_finish(struct net_bridge_vlan *v, u8 state)
> +{

A one line helper that directly calls another function is not helping anything.
Please just call that function directly and remove the helper.

> +	br_multicast_update_vlan_mcast_ctx(v, state);
> +}
> +
>  /* vlan state manipulation helpers using *_ONCE to annotate lock-free access */
>  static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
>  {
> diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
> index 8fa89b04ee94..bad187c4f16d 100644
> --- a/net/bridge/br_vlan_options.c
> +++ b/net/bridge/br_vlan_options.c
> @@ -123,6 +123,8 @@ static int br_vlan_modify_state(struct net_bridge_vlan_group *vg,
>  		br_vlan_set_pvid_state(vg, state);
>  
>  	br_vlan_set_state(v, state);
> +	br_vlan_set_state_finish(v, state);
> +
>  	*changed = true;
>  
>  	return 0;


