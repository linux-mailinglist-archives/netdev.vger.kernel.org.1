Return-Path: <netdev+bounces-120377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7B295910A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F79285CE0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE311C7B72;
	Tue, 20 Aug 2024 23:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIvfL8BQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E908B2C18C;
	Tue, 20 Aug 2024 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724196013; cv=none; b=WZaK/Aix7HV55BdtzMeNgtEIdXr9aNf7qFkfMJa5tTdEeh9HnUHgOCp63mJIAfDD2AX9mvljFDSBG5YNSD18RRrtdjgO9qk6jImZgy4A+ylbzbAz5NNp+lHtIHEmxNR6bX5MBLL53B5ENmtDgEjLrt7SyaLxYEkL878y4WG4Ck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724196013; c=relaxed/simple;
	bh=EMWg3UUovfMDlt3OFyTdFcb0kZP3CP34happlgewt1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5rHoRxt+aZ5PtWLo8ulQd07eYncifymk4yuoBgbpupYDjrezfF5iticOMNtE/FwxmtJcFffqcJnzsa4182eGfWR62QjTi6CInLIJc/8MwQAIozMx0WkDGa+9rPcLvjiDLvXUzJJJGOkg3vGPli4mqANudQhEkbNxVPjCTOSHPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIvfL8BQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6129C4AF53;
	Tue, 20 Aug 2024 23:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724196012;
	bh=EMWg3UUovfMDlt3OFyTdFcb0kZP3CP34happlgewt1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CIvfL8BQEC5K0fJQ0JbsUIN2rUS81FYVEBchqQO5uqDf4FnvNcBXIbr3SdSXOPgbq
	 C/Z2w0oDKTqee6WiF/yYqZVhASyvoQV/yoR7U/o5w/Mpef85FYhPLAH4Pp7gXhmoW7
	 xye46fJuZxyyhtQHdsugSesfNbpQXEN9RcHsmpItfippFPu9lTQLj1wRStI3s5ljXO
	 Kz+YE76TY4LLaoJMMbgwyMo8gtlAv9fkguouA7nF6HuS67VYdb30b4VLIGnUrOA+qR
	 uL+WKBASq7Bh67YwMzk269ZHM50TSsYbgaq8Btyi5ohnyjHXaWSlkmeKDoGINR+yCJ
	 +sFixhE2GJibg==
Date: Tue, 20 Aug 2024 16:20:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Rik van Riel
 <riel@surriel.com>
Subject: Re: [PATCH net-next v2 1/3] netpoll: Ensure clean state on setup
 failures
Message-ID: <20240820162010.1e89b641@kernel.org>
In-Reply-To: <20240819103616.2260006-2-leitao@debian.org>
References: <20240819103616.2260006-1-leitao@debian.org>
	<20240819103616.2260006-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 03:36:11 -0700 Breno Leitao wrote:
> +	DEBUG_NET_WARN_ON_ONCE(np->dev);
>  	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
>  		np_err(np, "%s doesn't support polling, aborting\n",
> -		       np->dev_name);
> +		       ndev->name);
>  		err = -ENOTSUPP;
>  		goto out;
>  	}

>  put:
> +	DEBUG_NET_WARN_ON_ONCE(np->dev);

nit: having two warnings feels a bit excessive, let's pick one location?

