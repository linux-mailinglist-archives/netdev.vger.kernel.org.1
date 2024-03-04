Return-Path: <netdev+bounces-77187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E813870732
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 17:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29009280351
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36532562F;
	Mon,  4 Mar 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3M28oo4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF538DCC
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569975; cv=none; b=Vaf6eU1cQ8zD2oy2AtcMgT0YV+uweWcE6JoMf/a5W56qdDzdvvGWEVx9L6Z2zgXCebXdLjUGKzDNCMnX4F4DyBYpwOo/jSXQhKRrkFpL/Ia1FrufYL8F3S2kESLEfIGo2atuxSKIdo0rRfcDiUgF0TdiMKr4R1piDFv8uEmtFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569975; c=relaxed/simple;
	bh=mh3mSdy8Biw8bVv8Q5uNgnse0LSvfSHLh+L7zUE0owo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yx5JqJebY4Ystb1DY8hslczsYdtSeyy1xoR+2dvOMFIau1CKTvom5g3S6tXUVugRm3wF9NIeq23i4xt0sB/IdAFyioBoywdlEPJaggIVH0ZBYMwQNh8l1Rn442/A84fpYtO6BIFWtCHSk/pB7MRYt7nLvYm51jRdimovkEtRe74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3M28oo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559F0C433F1;
	Mon,  4 Mar 2024 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569975;
	bh=mh3mSdy8Biw8bVv8Q5uNgnse0LSvfSHLh+L7zUE0owo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J3M28oo4dLZ3P8I5JFxRJXo2xh7SqG8tPzgQ9YJaYSS2w2jj2/B7E8nNM+YTVTCBM
	 etiSCjByJ78ISnx1w0RoBg98hw3HuL9/MpHFqTwPdtHf8N/POjnrAuD9jTPkPqN9sX
	 +E29M53Q/+Lrzl/gtos+MroOPEobJlDmNySgHdDNGjv6pYdDRPr1uOkH06JbCBBkAs
	 XxY+yaoihDlOP/UeW1+7XVFUB3bhpyraQLi/nx5xtATl1H1DpnuWIZfNCzR21YIoDq
	 bb+1vnF8st3CnlYwZHY4mCwXuAcU+jsISfWq36kOUac6jOxZ8aUwiR9V8LqddU6BKi
	 4vQst6oLeREqA==
Date: Mon, 4 Mar 2024 08:32:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 3/4] tools/net/ynl: Extend array-nest for
 multi level nesting
Message-ID: <20240304083254.65caaf03@kernel.org>
In-Reply-To: <CAD4GDZxP1VwOw2uTtZH27oEx8jooR1a9jrM88Pg2MLk+T1aQ7w@mail.gmail.com>
References: <20240301171431.65892-1-donald.hunter@gmail.com>
	<20240301171431.65892-4-donald.hunter@gmail.com>
	<20240302200536.511a5078@kernel.org>
	<CAD4GDZwHXNM++G3xDgD_xFk1mHgxr+Bw35uJuDFG+iOchynPqw@mail.gmail.com>
	<20240304072231.6f21159e@kernel.org>
	<CAD4GDZxP1VwOw2uTtZH27oEx8jooR1a9jrM88Pg2MLk+T1aQ7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 16:21:11 +0000 Donald Hunter wrote:
> > Yeah.. look at the example I used for type-value :)
> >
> > https://docs.kernel.org/next/userspace-api/netlink/genetlink-legacy.html#type-value  
> 
> Apologies, I totally missed this. Is the intended usage something like this:
> 
>       -
>         name: policy
>         type: nest-type-value
>         type-value: [ policy-id, attr-id ]
>         nested-attributes: policy-attrs

Yes, I believe that'd be the right way. And then the policy-id and
attr-id are used as keys in the output / response dict.

