Return-Path: <netdev+bounces-147314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EEE9D90D0
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 04:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981E4282C57
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 03:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8BC2940D;
	Tue, 26 Nov 2024 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fgSmGhAD"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DF9CA64
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732593077; cv=none; b=a3lsmMw16nkNbZ8ZHIcgnN9iZv7ZAIaYsvkG9winbnUjgC17vFimE+ZgxraAK9t0Sxb9G5abJzBcKrdRIbVJOJQ7FJ4CYZ5LuauHglMI0IeF8xeEhnBJoDlPU3E0/ihQ7wF0QSA/pnPbWBnRqRSX407BPqRrRKhiCCfgOESr4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732593077; c=relaxed/simple;
	bh=Af6yQBo8HP/bk9RqZ+ntYq312O6X56S1Du5MYCryg0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRN17qd7ZCboIgopAtoX7XHDKF74l2UzT3qIx21ddNFg4Zbs6rE9kMqSf7M6zY58CWGPFwHApopU2yecwPdF9xsqntN4p7WxRXMhy8+FsBOhCZPabTscmHLIbbmR9cCc9hDEfwWwbyLfnXpApVRrxIUM0GhxECQYpwqqAAx6rfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fgSmGhAD; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Nov 2024 22:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732593072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RAFYmCIgq34bui9zVKntUJpjJlbeW2VkA5UXXG8mn+w=;
	b=fgSmGhADXE5QkHW4MERejBNDoW8C2ohS22rZ6IaMP3wpQASzCLVQLaWSzliFomadjS0+pC
	SBL6JWRCGHa3mpAHkyLsnK8hEXf3NwSWjcmfSgYGIf4xMUoNE59c05NW7XYlmPfb9h78PZ
	fMXENABbtdesuMURT9nSMWqgFHgRMyk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>, 
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <dhgvxsvugfqrowuypzwizy5psdfm4fy5xveq2fuepqfmhdlv5e@pj5kt4pmansq>
References: <>
 <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
 <173257789029.1734440.16216135574521669815@noble.neil.brown.name>
 <yaxjp5k4o37vh2bl2ecuj3qoyz6x3lwau2kf7zevq5v3krcmtu@idoh3wd4zyqu>
 <Z0U4bfbBoooHIZVB@gondor.apana.org.au>
 <t3a3ggvcvnle6dnnmzf3ehlgcxhgpnn2mbpyukjv3g67iqxlah@spqeyovloafo>
 <Z0U9IW12JklBfuBv@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0U9IW12JklBfuBv@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 26, 2024 at 11:14:41AM +0800, Herbert Xu wrote:
> On Mon, Nov 25, 2024 at 10:12:44PM -0500, Kent Overstreet wrote:
> >
> > Does the knob have to be insecure_elasticity? Neal's idea of just
> > blocking instead of returning -EBUSY seems perfectly viable to me, most
> > uses I'm aware of don't need insertions to be strictly nonblocking.
> 
> Well having a knob is not negotiable because we must have this
> defence for networking users where hostile actors are a fact of
> life.
> 
> And no you cannot block in networking.

I just meant having a knob that's called "insecure". Why not a knob
that selects nonblocking vs. reliable?

