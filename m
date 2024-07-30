Return-Path: <netdev+bounces-114196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F229414C8
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE17B2610F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8189F1A2C1C;
	Tue, 30 Jul 2024 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8hoRhjY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2C41A2C17;
	Tue, 30 Jul 2024 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350908; cv=none; b=YZZ402t+m3fS9qVU+02v5LFVkln+yU3M9LcEbggqc5QwlqcqyAEgHoQ/DbP9gkf7csu42RRIB0naWL9/5XzUTNleATdEsYnTFiKoN10Xr5Kc6cEb8IQ7GHlhpVcnlOOHh1+GtmQLauwdXEsO7cDTTIzChfMND6Ik9677tlGucrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350908; c=relaxed/simple;
	bh=/UavuWlxBk8ZMeHO20CGj3Nh6udroPjLGaNbZWSlZmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8239GZnWhoGoo3HEcRPud0B/dnQKG/WKjxfkf3i7bE5yHwMMYqdKeSZnevjwr0UAamAQcse8PFF3PqHcZkwiAjZm03vJmztqmZxWKvrhxpGekhi2YuwsM28PD0Oc85qyinIOSxh5WxugPD5CrybXBazsUNl9xRLGZy65tTA9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8hoRhjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C7CC32782;
	Tue, 30 Jul 2024 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722350907;
	bh=/UavuWlxBk8ZMeHO20CGj3Nh6udroPjLGaNbZWSlZmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a8hoRhjYsxetcR5EsIvILYQBVythYzX2cx5zOX1tkF+26ChCuPck2USBbiL5Fxt2p
	 sM2q6qPhnx6vaUgAPs2s+qCT+his/hwx863drxajqFEEZSqjaxhRX26cpW6laccHZE
	 RVVASgT8G9jHAmp8hE1RQjJGbhZJ2R7aMTf9izWYl6eBGyK6NwMmeTN5pyzwtpa7ZG
	 FxZyh5gDo/8dIAG5/SBF1eRn5klFywRQpLBJLw1FLH5Nl0FdxqI2gGZ7TcqlHMP2XV
	 zplDnvo0+ILDMtaayRsZvM72ZA86fziMOv86SHQJsS/f/fSEj0sZD1rgpKeJc6x7nS
	 3jZe0lCze5U/Q==
Date: Tue, 30 Jul 2024 07:48:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, Breno Leitao <leitao@debian.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, leit@meta.com, Chris Mason <clm@fb.com>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref
 when debugging
Message-ID: <20240730074826.3b1c6948@kernel.org>
In-Reply-To: <16add5c4-b1c2-4242-8b71-51332c3bae44@redhat.com>
References: <20240729104741.370327-1-leitao@debian.org>
	<e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
	<20240730105012.GA1809@breakpoint.cc>
	<c61c4921-0ddc-42cf-881d-4302ff599053@redhat.com>
	<20240730071033.24c9127c@kernel.org>
	<16add5c4-b1c2-4242-8b71-51332c3bae44@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 16:37:10 +0200 Paolo Abeni wrote:
> I think that better specifying the general guidance/expectation should 
> be enough. What about extending the knob description with something alike:
> ---
> diff --git a/net/Kconfig.debug b/net/Kconfig.debug
> index 5e3fffe707dd..058cf031913b 100644
> --- a/net/Kconfig.debug
> +++ b/net/Kconfig.debug
> @@ -24,3 +24,5 @@ config DEBUG_NET
>          help
>            Enable extra sanity checks in networking.
>            This is mostly used by fuzzers, but is safe to select.
> +         This could introduce some very minimal overhead and
> +         is not suggested for production systems.

I'd go with:

             Enable extra sanity checks in networking.
-            This is mostly used by fuzzers, but is safe to select.
+            This is mostly used by fuzzers, and may introduce some
+            minimal overhead, but is safe to select.

What's acceptable on prod systems really depends on the workload..

