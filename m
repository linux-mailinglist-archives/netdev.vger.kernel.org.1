Return-Path: <netdev+bounces-234547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE90C22DC3
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52183189583B
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749BB22D7A9;
	Fri, 31 Oct 2025 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQLYvy/K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEAF1DE3DC;
	Fri, 31 Oct 2025 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873666; cv=none; b=Uce3Of9RGIoGb8kq1zAILTni8BDeTGsVuhcTnQyUFh+TGddgVopg1+mdBdHWAcckdoqApkcTebeEVDVvFKp7IxceAkQmihbrlewXpG4f33aK1ijOTy/vMlOipXzAWsJiXIaFjUjxC8Py0/uOABT3AoCz3VeDo9O+V6lDh0R6H9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873666; c=relaxed/simple;
	bh=tTqbo5njp8Fn5qaH4dtpPxFuBnygQOg+LpM5/wYyMB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0HEhH725Y0OdZIFwi9V/KPotsgVZ6o7M6rEIiCWvkAIHvxDW5/V2jeuzA+sovo55A19Dyf8CEJ6SAxXT1KEtbTAl+kV7JT1wIkBTobb9B/VUmY8pUiGcxBhxfCndW3bKv7UaTwjb7HpxD8wYFYnnsNV2NKH5mVaR1aduKO6YhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQLYvy/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF35C4CEFD;
	Fri, 31 Oct 2025 01:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761873663;
	bh=tTqbo5njp8Fn5qaH4dtpPxFuBnygQOg+LpM5/wYyMB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CQLYvy/Kptl11EaOtQj6JqWImsChv3X2U08wCHQPTo8t/scsh1ZZ9Nb1Qha+1yStz
	 jXlQRNRcaomKrfBBtRcQt9gVj8xP35fJTBtxUIWJzK+BIFWj1pzchwSEviI66Owkd+
	 8q6ntH6Qvm82De4zEDvR/Zkw0nnsrqimvDIgibukvYg6FNpf/rStDIuQ1wVJm41lzP
	 Fs3QCa/BKE9raAo63kuK20fDbzQvVsKzLAphFrLSUDfxnZ7eCktb38NzDWXwv/LVCv
	 J59Fc4Tz/wKppyeGZg0Az9gvkCu5DG231/oEJcWw/1m8Mo6p3h5q5Bjw5C4QQguKPx
	 1dHuoQAtbeD5A==
Date: Thu, 30 Oct 2025 18:20:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com, toke@redhat.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, Cong Wang
 <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
Message-ID: <20251030182057.59731b84@kernel.org>
In-Reply-To: <20251029080154.3794720-1-amorenoz@redhat.com>
References: <20251029080154.3794720-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 09:01:52 +0100 Adrian Moreno wrote:
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1275,8 +1275,9 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
>  	       + nla_total_size(IFALIASZ) /* IFLA_IFALIAS */
>  	       + nla_total_size(IFNAMSIZ) /* IFLA_QDISC */
>  	       + nla_total_size_64bit(sizeof(struct rtnl_link_ifmap))
> -	       + nla_total_size(sizeof(struct rtnl_link_stats))
> -	       + nla_total_size_64bit(sizeof(struct rtnl_link_stats64))
> +	       + ((ext_filter_mask & RTEXT_FILTER_SKIP_STATS) ? 0 :
> +		  (nla_total_size(sizeof(struct rtnl_link_stats)) +
> +		   nla_total_size_64bit(sizeof(struct rtnl_link_stats64))))
>  	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_ADDRESS */
>  	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_BROADCAST */
>  	       + nla_total_size(4) /* IFLA_TXQLEN */

Forgive me but now I'm gonna nit pick ;)
Please break this out into a proper if condition.
It's quite hard to read.

	size_t size;

	size = NLMSG_ALIGN(sizeof(struct ifinfomsg))
		+ /* .. litany .. */

	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS))
		size += nla_total_size(sizeof(struct rtnl_link_stats)) +
			nla_total_size_64bit(sizeof(struct rtnl_link_stats64));

	return size;
-- 
pw-bot: cr

