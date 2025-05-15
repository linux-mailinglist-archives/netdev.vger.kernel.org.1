Return-Path: <netdev+bounces-190757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6AAAB8A13
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2724E3AA836
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B6E1FBC8C;
	Thu, 15 May 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j591/9DC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A615A864;
	Thu, 15 May 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320988; cv=none; b=p2cbT3IKc5STTD92An5gfxulPorDd/SRMCe/AqAezD8MKXbi0eig3oPnhkyFXKFaXm15+xiCSVkFoFqjHZCA8E9ZDnMhC+U/kR4ghMzsWPPrAiHSRL+BjlwI4r2LxJAJx0W5QqHFUh7Fngxvq8sMLvgpXjTXXemDl4CnhYvSHBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320988; c=relaxed/simple;
	bh=xw7LivwhsE0lWGOs2o4XklvIJ7bTYAB8+1ZsaoredCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7nKK/rfHfV0T4CR9xtj89f7PlCxObE56kdOnxtUsqsUwinDY3GeixFOBvud17S7O98Z7lWz9m/bw4K3eAAEcPH5Dc96MKgJ/ATfTRXBOsRwwyY8eNlFZJhlLWc57o+gxNJJkqpeFVhNn3uW2fRpopXHGgU8iiuTDRxcSn92xUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j591/9DC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762DCC4CEE7;
	Thu, 15 May 2025 14:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747320988;
	bh=xw7LivwhsE0lWGOs2o4XklvIJ7bTYAB8+1ZsaoredCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j591/9DCJIUhbDudupHMc/C32/vaLzjFo4HDwU/blt49n8/Ac0fZzerkROr3cKY22
	 R6rNOMZFXG9UFJrbna25/dp0YC0G+T5xLGWC7PTdEyCBKpYF5UyLM8UZumGjBIwnnp
	 NWvwHzJaRkbiqxbq4MtB2PnuaigxiIv3k2E1p+k8SJiAgxQ6wMrBe6nXzGsaxVZZF4
	 m7jWAqk5pmXx3NRk2AFva4lnwYK5xhq4PrARffMYWv/AP1r5+vHoKMe0bNw3J1r7Nv
	 qLIeEO1C3LWtxTyzofUs2kaghxDbb+ro1ulFC6qgntFRonu0kNW3r6fC8gAyC7ysAu
	 /45pmKBqtdWVQ==
Date: Thu, 15 May 2025 07:56:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, andrew+netdev@lunn.ch,
 sdf@fomichev.me, linux-kernel@vger.kernel.org,
 syzbot+53485086a41dbb43270a@syzkaller.appspotmail.com
Subject: Re: [PATCH net] team: grab team lock during team_change_rx_flags
Message-ID: <20250515075626.43fbd0e0@kernel.org>
In-Reply-To: <20250514220319.3505158-1-stfomichev@gmail.com>
References: <20250514220319.3505158-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 15:03:19 -0700 Stanislav Fomichev wrote:
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1778,8 +1778,8 @@ static void team_change_rx_flags(struct net_device *dev, int change)
>  	struct team_port *port;
>  	int inc;
>  
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(port, &team->port_list, list) {
> +	mutex_lock(&team->lock);
> +	list_for_each_entry(port, &team->port_list, list) {

I'm not sure if change_rx_flags is allowed to sleep.
Could you try to test it on a bond with a child without IFF_UNICAST_FLT,
add an extra unicast address to the bond and remove it?
That should flip promisc on and off IIUC.

