Return-Path: <netdev+bounces-98672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CD48D2071
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076CCB21C2A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B7813AD3E;
	Tue, 28 May 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b="Y+ACyjRe"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nohats.ca (mx.nohats.ca [193.110.157.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73E4171088
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910427; cv=none; b=RxyK3sOH4Enb0oX/Qfbuwuqm+ADpQSWkWOHCsFTvDt1bzrMH2jcPpZwoKgqRIgIZXwHHyuPveQjc4aUgfty8NkOjKWXeQcH0kcF5jBhreOQ0vWB1q7huf4YE5693NUlCv9sylo8BhP3PwpNjcUjeOfgLiA0o0/nkw5PG+DPJlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910427; c=relaxed/simple;
	bh=AUsoA/6lWkwXWQSrcBCKAQMcXaazqW8LHPge82Xl8U8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Jg7fxznyigDzvhAwA0vLDcZuIM3TuC23nZcqQnmf3bMuWC/K0XDe6zFUY15lGB4596ZGDkJzaJ2BWFTf43kle+3MKTE/f1Ap/BkfNSpltfFhO1Ge141aOIopcE/NLuEXIOmUdhaxG4KT0TOU5uuJvHLiPu51KV/nXFGlWd7l40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nohats.ca; spf=fail smtp.mailfrom=nohats.ca; dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b=Y+ACyjRe; arc=none smtp.client-ip=193.110.157.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nohats.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nohats.ca
Received: from localhost (localhost [IPv6:::1])
	by mx.nohats.ca (Postfix) with ESMTP id 4Vpc3z5MkCz9LF;
	Tue, 28 May 2024 17:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nohats.ca;
	s=default; t=1716910415;
	bh=AUsoA/6lWkwXWQSrcBCKAQMcXaazqW8LHPge82Xl8U8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Y+ACyjRehFTLwd9es3ySNN6VZrYIGqQjxGMpRhpOLrQG9aMqo3AYBuIFUvAjCGuBq
	 OCMditdwxvfZ1vy0PcDc9xSOTaR9l3j2H5t6/8Sx9xvNNcnL7pL2k4v0P3EYc0pFyB
	 qzmmFDUolHRxIXKaIjiHfGOqCh12VHecZ9ImR/lE=
X-Virus-Scanned: amavisd-new at mx.nohats.ca
X-Spam-Flag: NO
X-Spam-Score: 0.566
X-Spam-Level:
Received: from mx.nohats.ca ([IPv6:::1])
	by localhost (mx.nohats.ca [IPv6:::1]) (amavisd-new, port 10024)
	with ESMTP id JvfcY9lFPsKe; Tue, 28 May 2024 17:33:34 +0200 (CEST)
Received: from bofh.nohats.ca (bofh.nohats.ca [193.110.157.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.nohats.ca (Postfix) with ESMTPS;
	Tue, 28 May 2024 17:33:34 +0200 (CEST)
Received: by bofh.nohats.ca (Postfix, from userid 1000)
	id 2B44D12015D7; Tue, 28 May 2024 11:33:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by bofh.nohats.ca (Postfix) with ESMTP id 2761E12015D6;
	Tue, 28 May 2024 11:33:33 -0400 (EDT)
Date: Tue, 28 May 2024 11:33:33 -0400 (EDT)
From: Paul Wouters <paul@nohats.ca>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: Steffen Klassert <steffen.klassert@secunet.com>, 
    Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
    pabeni@redhat.com, borisp@nvidia.com, gal@nvidia.com, cratiu@nvidia.com, 
    rrameshbabu@nvidia.com, tariqt@nvidia.com
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP
 connections
In-Reply-To: <6655e0eecb33a_29176f29427@willemb.c.googlers.com.notmuch>
Message-ID: <81646030-00b9-10ad-abed-a7a78f0c511e@nohats.ca>
References: <1da873f4-7d9b-1bb3-0c44-0c04923bf3ab@nohats.ca> <ZlWm/rt2OGfOCiZR@gauss3.secunet.de> <6655e0eecb33a_29176f29427@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 28 May 2024, Willem de Bruijn wrote:

> One point about why PSP is that the exact protocol and packet format
> is already in use and supported by hardware.

Using mostly the IPsec hw code? :)

> It makes sense to work to get to an IETF standard protocol that
> captures the same benefits. But that is independent from enabling what
> is already implemented.

How many different packet encryption methods should the linux kernel
have? There are good reasons to go through standard bodies. Doing your
own thing and then saying "but we did it already" to me does not feel
like a strong argument. That's how we got wireguard with all of its
issues of being written for a single use case, and now being unfit for
generic use cases.

Going through standards organizations also gains you interoperability
with non-linux (hardware) vendors, again reducing the number of
different mostly similar schemes that need to be supported and
maintained for years or decades.

Paul

