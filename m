Return-Path: <netdev+bounces-109999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92C292AA41
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E754C282BF6
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6164D1CD23;
	Mon,  8 Jul 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQJJA/r9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BBD7494
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469049; cv=none; b=OGG3Mb+EIP8iarUBfmtek3xh5laaWu1miqUzuS5Gs7lRnYa06mJfwcICKFbn837feN9dCH3m2XEvqCY7X6fNk5XyA4HLIkMbehojcuZcTKvDq5N7Ssvs6eNiGB+nGHaI7trvH+aBi6JqO3Egj5Jib/LyeXHpM/iqZRX+EdQbRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469049; c=relaxed/simple;
	bh=LhWYvHkpR4scv3RZtrZEhzVug1rJepKz8rlmjvb16u8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6Epyflzo7Z8VW5AqBK4r3qY18FQiGVE5q31ulFBH1Kx0T8YsNGXFrECHm3z3I43IvOf6KDfeucz3H92xvFUX35gyN20ajjapTce9VW0F9OIiWFo1utipxa+XEbg7Ri/oZQYW5A66UvNUL2+Cs8FcrkfKzn2/RqsIm7P9zsywD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQJJA/r9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52129C116B1;
	Mon,  8 Jul 2024 20:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720469048;
	bh=LhWYvHkpR4scv3RZtrZEhzVug1rJepKz8rlmjvb16u8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QQJJA/r9UerPGFOF4N2i47ElPYTzHqeO/GcGgjytpnnTdOH7TdJyXKv0pFc2ql9e8
	 9ZA2hfkiZ8lyxuMzsSfTnebyD/OL6N7RYpz+qa7F3rYWdyZGVLEPn0pO6iTTdVtASP
	 13ey9VPjJ2U6oCVxLF5uM83OOACW3BLF1+uBjSICNj8PE8eHMLbcsNUg6EGZvndvn1
	 w+IYTDam3Vke5EIt9kY7KEaxzsvlVmN9+JjOeCEPP48m4iWys+UtzPj7+QXluHgh9d
	 ihXHgKAPo6N2bGYFUn0+veTZo6xzMtbwTQHn50WbMfe6EvdBi8lFdgbaT/e9mXFRwo
	 nzJScMf0yrQrA==
Date: Mon, 8 Jul 2024 13:04:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, petrm@nvidia.com, przemyslaw.kitszel@intel.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 3/5] selftests: drv-net: rss_ctx: test queue
 changes vs user RSS config
Message-ID: <20240708130407.7d22058d@kernel.org>
In-Reply-To: <668c1a2168f55_1960bd29446@willemb.c.googlers.com.notmuch>
References: <20240705015725.680275-1-kuba@kernel.org>
	<20240705015725.680275-4-kuba@kernel.org>
	<66894e1a6b087_12869e294de@willemb.c.googlers.com.notmuch>
	<20240708091701.4cb6c5c0@kernel.org>
	<668c1a2168f55_1960bd29446@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 08 Jul 2024 12:56:01 -0400 Willem de Bruijn wrote:
> > There may be background noise traffic on the main context.
> > If we are running iperf to the main context the noise will just add up
> > to the iperf traffic and all other queues should be completely idle.
> > If we're testing additional context we'll get only iperf traffic on
> > the target context, and all non-iperf noise stays on main context
> > (hence noise rather than empty)  
> 
> That makes sense. Should the following be inverted then?
> 
> +    if main_ctx:
> +        other_key = 'empty'
> +        defer(ethtool, f"-X {cfg.ifname} default")
> +    else:
> +        other_key = 'noise'

No, unless I'm confused. if we're testing the main context the other
queues will be empty. Else we're testing other (additional) contexts
and queues outside those contexts will contain noise (the queues in 
the main context, specifically).

