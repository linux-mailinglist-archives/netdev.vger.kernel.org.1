Return-Path: <netdev+bounces-87068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF7E8A186C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 17:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8742B278AA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D72512E7F;
	Thu, 11 Apr 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEkw8LSC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED00617582
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848573; cv=none; b=mZxUPmx1dgHZv0C9FFSFysEhT6Bztca0ZKhS/aQwDFJWW2lfSAUjw/0CGlyoZlDfcYcVC2s0D2+g5z4JJUu9rTGUxltSzwOjgcwk6HAbjqYNeM2IAqWr94O/27sRtNBHbIHc6bu374C7VZx8W4qKe6c6Dxg7MCI68BcWFJr6OVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848573; c=relaxed/simple;
	bh=V0KYsAMbdteBXq8r1vMjpNZAO2KtsnPtdLPa6QQC6+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNZtJoB+E5Jhpl4E+JQDQMgm8swGMGph3suA5FZeepbyHePsVjQTOZAHENSGLJCJkmx6UVtC1qqGF6mGL/YQNcQaXG3oXCf9Svsh0PFm/inGacLiZX5x3ZRPS0BwcY5VCom32pFtksEiXWrK+w1CTH8kdd/ePWoQzUcYP6EeA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEkw8LSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74E4C072AA;
	Thu, 11 Apr 2024 15:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712848572;
	bh=V0KYsAMbdteBXq8r1vMjpNZAO2KtsnPtdLPa6QQC6+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tEkw8LSCZrmMnym4ZcIY60Rt9mk/qrYrkAVxv9REb4SqKkNF+a9j7mnWNWpEC67sA
	 /+UpgUsDZQy5huN0UFZdh3n3f+vpdb6pNBcx5DCSkqRJxEpi25MVcE/cb+yhHN8Nm6
	 IjX5BOl6OcIokxSFKfvpd1YsQ8Igubvih+f6g6JRxa0Oe333/Vivccj7wqnstpjLXi
	 PRcjoy5eLgDU7gxL35NRnpIxJ2RoZI0F9eHiPHHNqnHfWw7PX1Z2a+Gj/fsUbSeRcA
	 0rUJvoyuCnra4hH6doibFnCG5dOrUjGmcw5CQPxZ11WRIbSyePHzaH5sfzzeOZaVeP
	 jmlNGq1HFmWZA==
Date: Thu, 11 Apr 2024 08:16:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Eric Dumazet <edumazet@google.com>, Stefano Brivio <sbrivio@redhat.com>,
 davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 jiri@resnulli.us, idosch@idosch.org, johannes@sipsolutions.net,
 fw@strlen.de, pablo@netfilter.org, Martin Pitt <mpitt@redhat.com>, Paul
 Holzinger <pholzing@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
Message-ID: <20240411081610.71818cfc@kernel.org>
In-Reply-To: <02b50aae-f0e9-47a4-8365-a977a85975d3@ovn.org>
References: <20240303052408.310064-1-kuba@kernel.org>
	<20240303052408.310064-4-kuba@kernel.org>
	<20240315124808.033ff58d@elisabeth>
	<20240319085545.76445a1e@kernel.org>
	<CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
	<20240319104046.203df045@kernel.org>
	<02b50aae-f0e9-47a4-8365-a977a85975d3@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 00:52:15 +0200 Ilya Maximets wrote:
> /usr/sbin/ipsec auto --config ipsec.conf --ctlsocket pluto.ctl \
>                      --start --asynchronous tun-in-1
> 
> recvfrom(7, 
> [
>   [{nlmsg_len=52, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI, ...],
>   ...
>   [{nlmsg_len=52, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI, ...],
>   [{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, ...]
> ], 40960, 0, {sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, [12])
> 
> recvfrom(7, <-- Stuck here forever

I think we should probably fix this..
Would you mind sharing the sendmsg() call? Eyeballing rtnl_dump_all() -
it does seem to coalesce DONE..

