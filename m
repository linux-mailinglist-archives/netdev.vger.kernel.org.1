Return-Path: <netdev+bounces-77125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552588704A0
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F325F1F21C02
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CCC4642A;
	Mon,  4 Mar 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUzCXjdf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F737BE4C
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564306; cv=none; b=IIHWUT4Zasjf6D/THzOAWhJvO/F/xjw9ezxN1u1YifP8/YRAp7q6biaI1oqQU35KqqFCzMXYbKIikthu9JtTJiRf0gdQYIWTvDnjIwPjpCwxFr/jjoQ8ekTdT0kIARNV1awvCxETwwUWAcHTabNQoB1uOgRht6QrUCTXMtRoeMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564306; c=relaxed/simple;
	bh=ZuMKrqZIvp4hIrITLa+Z1hgSWTaN5ipl7necNr/My80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdF28kArQ3O3kyXZju5rSQZ6rMCE2IKANJmpl4NOPYJd3C54ACQcB4zD+pYf29bZ9G8BYB7UqLCEVB/XSMQJ3LEnXsD4ILcgIqmvEefYTOuW+SX9sWFCX3TfRGOhR3vTtWX1J7M55gMGu1yCKRS7587tNGF1SSxBvaNjYsfceRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUzCXjdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27992C43390;
	Mon,  4 Mar 2024 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709564304;
	bh=ZuMKrqZIvp4hIrITLa+Z1hgSWTaN5ipl7necNr/My80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lUzCXjdfBRT21Cx2OnzojSAWvubUeHlRTES9C+TnZgilevXCMUP/3PfUzATcGU1Rk
	 xNe0P1tN7skma3mcNWtlnpQ0OLMTxvc78ZJtWJEYbQRAeGdjMMotVax1PJX+74PGlh
	 HsOx8NLZw9wdRyEfTtdeW5qXlDVz3vNkJFPrH73zKZyoGpzq3zE6+T9K1SlGsYz+xj
	 hnKHcaXjJnAxrlFyTLJXG/IoLW+88x0eNCjkJUr9LempFVH7slcu/sNh54wTYAvEOk
	 e8IZ0mBlkhS7bwY2rVfopgsCg1UdNRvaM9pP5B6iXrKk4puhBw2dbOvDUqCr+dYi2z
	 NyYVQmkRn3cLQ==
Date: Mon, 4 Mar 2024 06:58:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us
Subject: Re: [PATCH net-next 2/4] tools: ynl: allow setting recv() size
Message-ID: <20240304065823.258dfabf@kernel.org>
In-Reply-To: <CAD4GDZzkVJackAf2yhG1E5vypd2J=n23HD5Huu356JK1F1oLKA@mail.gmail.com>
References: <20240301230542.116823-1-kuba@kernel.org>
	<20240301230542.116823-3-kuba@kernel.org>
	<CAD4GDZzkVJackAf2yhG1E5vypd2J=n23HD5Huu356JK1F1oLKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 13:38:51 +0000 Donald Hunter wrote:
> >  class YnlFamily(SpecFamily):
> > -    def __init__(self, def_path, schema=None, process_unknown=False):
> > +    def __init__(self, def_path, schema=None, process_unknown=False,
> > +                 recv_size=131072):  
> 
> An aside: what is the reason for choosing a 128k receive buffer? If I
> remember correctly, netlink messages are capped at 32k.

Attributes, not messages, right? But large messages are relatively
rare, this is to make dump use fewer syscalls. Dump can give us multiple
message on each recv().

> >          super().__init__(def_path, schema)
> >
> >          self.include_raw = False
> > @@ -423,6 +428,16 @@ genl_family_name_to_id = None
> >          self.async_msg_ids = set()
> >          self.async_msg_queue = []
> >
> > +        # Note that netlink will use conservative (min) message size for
> > +        # the first dump recv() on the socket, our setting will only matter  
> 
> I'm curious, why does it behave like this?

Dump is initiated inside a send() system call, so that we can
validate arguments and return any init errors directly.
That means we don't know what buf size will be used by subsequent
recv()s when we produce the first message :(

