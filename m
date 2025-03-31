Return-Path: <netdev+bounces-178423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C9A76FA7
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C19165F89
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6362153E7;
	Mon, 31 Mar 2025 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9V9ZCCY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2911E0E0B
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454093; cv=none; b=iKhv8U63PNzaVjjNF/jmFdDhyaGDWR1BIFgfHJYjgJ3WBfmWYCf1m7pmqB06XWMaGOkXhUGf6iW2eR41Ii105R2kIXqjxp85wpik+zX6IDpX+7v30WHAmz8JAVFr5g3UghhevWqCIOeNp+g3OFGd2LVidT43Uzy644q+U84Zo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454093; c=relaxed/simple;
	bh=ZyhPFFJK4lxZORXQuFCvDWRqmNPa4hX6HglO/v4cSxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqZi5weh5WSG1u6+OVLYnoVHTGJxpy88DcI01IBKgsAYTfJhPiiN9/Ru8v0/g4Y/aOk0Y8/SnS6/GR9ONHoPbMa5UwlDCbuab2rQ4EryqO1ihODps2jmY5hdkeQ9veKdIpaMFVRmL25JJOy0cudZypK/wUMzpzPZr8m7W6wbw3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9V9ZCCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FCDC4CEE3;
	Mon, 31 Mar 2025 20:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454092;
	bh=ZyhPFFJK4lxZORXQuFCvDWRqmNPa4hX6HglO/v4cSxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q9V9ZCCYCqBKygcMKw2h9xhkFVBPp0kH5qwLWbs0f3GCvuyyiYbM1XrQULEqspXIL
	 MoqnZySrX1U9XgVamcWr/c8hkSJdluXlBgxlulnqFwe/RNXEh5AEWp6kJaIjXfvG7f
	 hj+t9QX3BW48VIfQTTvU2TBGoLpkwvL2IzsOBjkp8cWQlejgb77pIRU5Q1pQQ1VVa5
	 nnH5PQDtSnqn2FZuB6grlaNee7uY6KURsORdL+rgZdcSLuPNjVIXP+PhXuWohxkg+W
	 xHmosxBsjy2GZAydmp08TuE0UD0mqK7XmDx//ffZZILVSmDUR8Mhj7/VttPT9V6B4U
	 q10pzFFew1nfw==
Date: Mon, 31 Mar 2025 13:48:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v4 02/11] net: hold instance lock during
 NETDEV_REGISTER/UP
Message-ID: <20250331134811.02655264@kernel.org>
In-Reply-To: <20250331150603.1906635-3-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
	<20250331150603.1906635-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 08:05:54 -0700 Stanislav Fomichev wrote:
> Callers of inetdev_init can come from several places with inconsistent
> expectation about netdev instance lock. Grab instance lock during
> REGISTER (plus UP). Also solve the inconsistency with UNREGISTER
> where it was locked only during move netns path.

Couple of nits, with that:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

> diff --git a/net/core/dev_api.c b/net/core/dev_api.c
> index 8dbc60612100..cb3e5807dce8 100644
> --- a/net/core/dev_api.c
> +++ b/net/core/dev_api.c
> @@ -119,9 +119,7 @@ int dev_change_net_namespace(struct net_device *dev, struct net *net,
>  {
>  	int ret;
>  
> -	netdev_lock_ops(dev);
> -	ret = netif_change_net_namespace(dev, net, pat, 0, NULL);
> -	netdev_unlock_ops(dev);
> +	ret = __dev_change_net_namespace(dev, net, pat, 0, NULL);
>  
>  	return ret;
>  }

nit: no need for the temp variable for ret, now

> @@ -3042,14 +3040,16 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>  
>  		new_ifindex = nla_get_s32_default(tb[IFLA_NEW_IFINDEX], 0);
>  
> -		err = netif_change_net_namespace(dev, tgt_net, pat,
> -						 new_ifindex, extack);
> +		err = __dev_change_net_namespace(dev, tgt_net, pat, new_ifindex,

nit: over 80 chars now

> +						 extack);
>  		if (err)
> -			goto errout;
> +			return err;

