Return-Path: <netdev+bounces-75787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6483986B2CF
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787F31C233FE
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD5715B988;
	Wed, 28 Feb 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpcrobOo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB715B97C
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133104; cv=none; b=fA/PaKigWSB77XuPwF5taWOkh2rmlWAMmlaCFfzURBpSi5ewRBmgNjWdr8z0UNfKogPAHhK3KvQ7zXbHtpqlewXn5mKsY2O9pjELsgdu389g571A/Vu6rRyFfQzogafrxBsI6dBKWhH7geIUPqm9KlWs32lSGOUbQbTYAFUbfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133104; c=relaxed/simple;
	bh=RS6MJmosP807L6gRHG3o2sEXO8NSts7Ny2svQq+6A3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPgO83HppVm1JKlq7+a7dlCE9pNvbqhXgzQvainc2j1JFIbjCvg2i8BjVymu3+BojomvAsonGUh8b8vAwQpy2JRRYsGJJnscpTdquTa93W113hw3VV6bhB4W332ymKXmezouP7RFACVmLXyD1qlLCFAqDXa3+HU3IvFDsz1Esk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpcrobOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AF6C433C7;
	Wed, 28 Feb 2024 15:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709133104;
	bh=RS6MJmosP807L6gRHG3o2sEXO8NSts7Ny2svQq+6A3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZpcrobOoT7TA4wIwsHZqx/JUsHR0HMIc5MB2MniLWIsfmtVAwZ19nAEnjFHTT/AaS
	 LXFWb98P427SrT3xP86Zaf9ZjwebnVLy/TQnlIFdxBfw2YPuF7bsPGgVuHAQspnNpv
	 xXVEW6Tlk9xUc6YKFN70h3DL22WAuoe2LJl92y/YDZS1yg0JnVncwxAboF6uNMGi7m
	 Zin6NNEhSyXa+OxTq2jL/YY1LUgd+aGLpMOSkbC/kX3NhCpp3iR17mWCOp6HUlBow0
	 kRkoTPY6EcMZNVjkEN7Bv9ryA2gj94POCIspoFMBzjA70hCQ+RNmQeJpTo4eTaOs6p
	 /YIzn2g4wTYXA==
Date: Wed, 28 Feb 2024 07:11:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Jiri Pirko
 <jiri@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 03/15] ipv6: addrconf_disable_ipv6()
 optimizations
Message-ID: <20240228071142.29c8fe1c@kernel.org>
In-Reply-To: <CANn89iLefNuOXBdf2Cg8SbwAXCm=X+qZ-Cqkx8CQ=vESv-LYSg@mail.gmail.com>
References: <20240227150200.2814664-1-edumazet@google.com>
	<20240227150200.2814664-4-edumazet@google.com>
	<20240227185157.37355343@kernel.org>
	<CANn89iLwcd=Gp7X7DKsw+kG2FHA1PzwG3Up8Tb2wjA=Bz94Oxg@mail.gmail.com>
	<CANn89iLefNuOXBdf2Cg8SbwAXCm=X+qZ-Cqkx8CQ=vESv-LYSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 10:28:28 +0100 Eric Dumazet wrote:
> > Good catch, I simply misread the line.  
> 
> I note that addrconf_disable_policy() does not have a similar write.
> 
> When writing on net->ipv6.devconf_all->disable_policy, we loop over all idev
> to call addrconf_disable_policy_idev(),
> but we do _not_ change net->ipv6.devconf_dflt->disable_policy
> 
> This seems quite strange we change net->ipv6.devconf_dflt->disable_ipv6 when
> user only wanted to change net->ipv6.devconf_all->disable_policy

The all / default behavior is a complete mess, I don't mind changing!
I commented because there was a flake in TCP-AO tests and I was trying
to find any functional changes :)

