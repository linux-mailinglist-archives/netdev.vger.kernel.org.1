Return-Path: <netdev+bounces-186186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7BDA9D655
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1523B6701
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361872973B8;
	Fri, 25 Apr 2025 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gltM073e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110AE13B7A3
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745624498; cv=none; b=XbKaCLUBkyJh7GpgFq1AbjgDdJGGbEd2PdBWaiKA6i7yIsk+6BCGDXxp9s4YJmQA442HHxcVRSJ9AAgTOHN3FOdDZU4kaG6PB2xknRAuJ3Mk1f3t1y+srvXea/SbMBJtz9KmUuF9031yhYU8YxTDKCb4OKYa+FgnomeFMleE06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745624498; c=relaxed/simple;
	bh=6RqWBC4UUyiSgS0KV2XDiFI+066+bkNWD6ZxUVMZ4og=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TL8tvUbyLAQADHyLc/pnvQsG/P36cFT5kiTRuTOJzok8CHljvXfLHm+I6v3ZpdfBZKqtP/idF3MvDjeQi70ecZJ+pJ3X6hd5vd4qbmPWa9calhDdq2fnz8Q3pdyxzXBGhXn4UZdhtY4vaYMODLfq61vTBu7gSRBzMW3FT8xnxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gltM073e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03870C4CEE4;
	Fri, 25 Apr 2025 23:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745624497;
	bh=6RqWBC4UUyiSgS0KV2XDiFI+066+bkNWD6ZxUVMZ4og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gltM073ebVXjcInc1CrlaXmZwyEb+UXsmrnzNpAWhoc94v9xaK/2IdAb+vOOwkC7n
	 NKg+Dfu9F5tDIL8zjOzKZLzEUE+cxJn81W1ng2dOPL7saqaMTPztdDnsDlnwomIVYx
	 l10a1GQxzdnIvNQznQ1x/dp4E5K8haJTw66PI5+FSUBqJ2TiG+wn1K7rZ0qmmWNGGX
	 1JYAnTep3i9Jjg0GDI69Q2tMuMNEoDeMmBEcSIC4gzoAxMkqlI2IRCX5YK/ejRx/BY
	 gHnxSktEFbknP2qoXnKqXUnh4vg2fDBoNQSEAFjQQre19QXTg5mGyhfaSEuUCrR/ti
	 omRPQcb7Xf3wQ==
Date: Fri, 25 Apr 2025 16:41:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
 dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
 jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 17/22] netdev: add support for setting rx-buf-len
 per queue
Message-ID: <20250425164136.03b38e7c@kernel.org>
In-Reply-To: <aAfAvxX707BGyLOZ@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-18-kuba@kernel.org>
	<aAfAvxX707BGyLOZ@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 09:15:59 -0700 Stanislav Fomichev wrote:
> > +    -
> > +      name: queue-set
> > +      doc: Set per-queue configurable options.
> > +      attribute-set: queue
> > +      do:
> > +        request:
> > +          attributes:
> > +            - ifindex
> > +            - type
> > +            - id
> > +            - rx-buf-len  
> 
> Do we want some guidance going forward on what belongs to queue-set
> vs napi-set? (mostly) HW settings for the queue-set and (mostly) SW
> settings for (serving the queues) in napi-set?

One NAPI can have multiple queues hanging off, so all HW settings
with the exception of IRQ coalescing should probably be on the queue?

