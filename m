Return-Path: <netdev+bounces-70477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1983C84F276
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95C72856D1
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B850F66B2C;
	Fri,  9 Feb 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN+Quamp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C09664B1
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471798; cv=none; b=rKGUeeIpb2K5hpTpOn2eLuoxyzeMgbhmEIGmqzDBasj/z+e870kZFOtVnZtSHQo/O0/rLBUp5+c2td1h2ibGIfjSptgzaWYGjw/Ay/ehl2cY95qE1KN4FhsB/gZ75daTpiPJB4FifDGS3Hw24osAxBCokyeTE0pGlHVilkzEfdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471798; c=relaxed/simple;
	bh=JWSLJdgBxWPZ2amRKZ34VYbMONd4prT0naH94Nzp308=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm6ovKUDfl5UDLBKoOP/HOKy9weeOvfThMN4m/BMzpgYsel/w30pPV4jSCbxndPIg7pUqGfOU0TxVQ0Wne/X8X9WD0AJbPLjRKB7VZHT261JoVS9hmeYzFD8Zhm8zJrzvcBEY4HCRdunikOIfDt2NpUYzffhGwuYHJabrUJBUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN+Quamp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B66C433C7;
	Fri,  9 Feb 2024 09:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707471798;
	bh=JWSLJdgBxWPZ2amRKZ34VYbMONd4prT0naH94Nzp308=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QN+QuamphJUbnnOtQ910CHsVFr1tba2qCVDz2Kvi0R9YFXKsPOYEJvUfa8KjKs0ww
	 DT7tkkcB2YWUVn8lwuFbQTucbWUygfQwuZKgauoK5r16GaVAicY4avEcwsRqYWcFtZ
	 6XndQpk7W6YURoPTOuXjq0lomo0PS0soKHQ91NqUYITOl5l/t//2OztKQ2x+GRZrwU
	 2a+emvQQjaJyfGzDvf/Mkb1kOGJwNzYwH4FVd5ceeTm6lTYza3vgBZzqprK568RSQM
	 bbaJvoS+DdQSxr7dJrQcmmKhV2rCiwg/RxlLayWBYeE+8dWlTorq4g5LmPDG2oPP66
	 teSUt9SKzL/tg==
Date: Fri, 9 Feb 2024 09:41:43 +0000
From: Simon Horman <horms@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, kernel@mojatatu.com,
	pctammela@mojatatu.com
Subject: Re: [PATCH net v2] net/sched: act_mirred: Don't zero blockid when
 net device is being deleted
Message-ID: <20240209094143.GT1435458@kernel.org>
References: <20240207222902.1469398-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207222902.1469398-1-victor@mojatatu.com>

On Wed, Feb 07, 2024 at 07:29:02PM -0300, Victor Nogueira wrote:
> While testing tdc with parallel tests for mirred to block we caught an
> intermittent bug. The blockid was being zeroed out when a net device
> was deleted and, thus, giving us an incorrect blockid value whenever
> we tried to dump the mirred action. Since we don't increment the block
> refcount in the control path (and only use the ID), we don't need to
> zero the blockid field whenever a net device is going down.
> 
> Fixes: 42f39036cda8 ("net/sched: act_mirred: Allow mirred to block")
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
> v1 -> v2:
> - Reword commit message to emphasise the bug is caused when a net
>   device is being deleted
> - Reword subject to emphasise the bug is caused when a net device is
>   being deleted. Original patch subject was:
>   "net/sched: act_mirred: Don't zero blockid when netns is going down"

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


