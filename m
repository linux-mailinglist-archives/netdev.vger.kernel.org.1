Return-Path: <netdev+bounces-198318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB1CADBD5E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2291E17196A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E52F2192E4;
	Mon, 16 Jun 2025 23:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpV3QvZj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB33BB44
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750115073; cv=none; b=datWpGsVL6DyDPuaSqadkmUpmFtqb2h7Pzlq0WsoIz4yjVr33lXCB1WsIgJjgDBcP/6Y2smpD63/VHlUZBPWm0yss8RV+Pc0biKG0G5dgiaDA3cEsh3NMsEoOA4CV6PwqybN6WrFPfYOEyG1UxoFVXRyQUSbDiJHMGjHCOpogBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750115073; c=relaxed/simple;
	bh=lQ/EYaozTTwcUWcsL83MRoZ/L3Gb0ImMCHkMSeuFfSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIuizxio5t/4d/uAK5LtDhMTPH+5r4gGhor5htKeXCeAmqhkYSVsFnWkyXxDAECpJkFokej9us0JP4B4gjuPbuw5oO4a2RXsT+hU1pF1oKwVHIuz11VzSecY/TUYDXLpFvlsJpdg5EcEMaFwO/KlVdAMMGC2uCkXldW0vOWmuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpV3QvZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BC4C4CEEA;
	Mon, 16 Jun 2025 23:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750115072;
	bh=lQ/EYaozTTwcUWcsL83MRoZ/L3Gb0ImMCHkMSeuFfSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HpV3QvZjpFa3ejt4sOm6yHSdCaF5rYF7H/OLooolrEwlXPSpvVbi6IzJZkpZs4VhA
	 DoCh4kb2lTdxdDO3fzivIs7C0Xg4m+ZRjasW3cDHkJKzlsvguleNDve8e5xTIVxYSE
	 CmxuteWGEMzT4z9LofwP6unsu6pq/59+Fpb9Lsyv0f5s2459EAfRxkkqi8Kx+MxbMZ
	 R7tmFn5xl1gqniuvOTuwz+f31m6SXx42moRLQvA5hcrEXeNxo2pIMw2p/DbVHOLl+1
	 +jJF4O9CGXH8KAnYX3/2BMl4j3u7Ibk5B+pmDVElMSibE3FvCD4vw4ZjDrlvb78HI7
	 uj2umngIJiEIw==
Date: Mon, 16 Jun 2025 16:04:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Zengbing Tu <tuzengbing@didiglobal.com>
Subject: Re: [net-next v6 1/4] net: bonding: add broadcast_neighbor option
 for 802.3ad
Message-ID: <20250616160431.2aff8ec6@kernel.org>
In-Reply-To: <ff319dfdedc2bc319431c49d7f71faaa80c42d44.1749525581.git.tonghao@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
	<ff319dfdedc2bc319431c49d7f71faaa80c42d44.1749525581.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 11:44:42 +0800 Tonghao Zhang wrote:
> +		if (bond->params.broadcast_neighbor)
> +			static_branch_inc(&bond_bcast_neigh_enabled);
>  	}
>  
>  	if (bond_mode_can_use_xmit_hash(bond))
> @@ -4475,6 +4480,10 @@ static int bond_close(struct net_device *bond_dev)
>  		bond_alb_deinitialize(bond);
>  	bond->recv_probe = NULL;
>  
> +	if (BOND_MODE(bond) == BOND_MODE_8023AD &&
> +	    bond->params.broadcast_neighbor)
> +		static_branch_dec(&bond_bcast_neigh_enabled);

is .broadcast_neighbor automatically cleared when mode is changed?
I don't see it in the code.
-- 
pw-bot: cr

