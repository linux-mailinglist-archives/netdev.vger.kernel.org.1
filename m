Return-Path: <netdev+bounces-70749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D61778503C7
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 11:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918791F2365E
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 10:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D0B36117;
	Sat, 10 Feb 2024 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b="0O55Wb6K";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="PMuYU9Yy"
X-Original-To: netdev@vger.kernel.org
Received: from e234-5.smtp-out.ap-northeast-1.amazonses.com (e234-5.smtp-out.ap-northeast-1.amazonses.com [23.251.234.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C755539C
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707559331; cv=none; b=HnXTDpom/0HhYx+LMipPN6FOgsev5SyB6mnnPQDj0gSG/GJAetAamZna3NxVz31BBIa4yGzdxjO+pLO0RfdagjhTKGBWrN+HhgqcSVTJHDcTtSKrn3SlIRvUg2g62o2fUhWiSQzBBXdVqO8d1uwfB3srw++WJthsVN75lmk50NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707559331; c=relaxed/simple;
	bh=agL9AgIAe/eZ1tw5Yr0v+hqP61J7jBZMj2yUqRfZewQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swyvNs4XVocT1J0K1KZVwPMwb0+DnXwSZqBx1xlNRy8HfOn0tmYbpKP+NaNutTS2SgQTxH9nTlvO8xIny2+Kh6NqmxAyC/qzp4cNS0aZoYuZCzM+PeqbQ4k1sLvEnoGcLnYNfAMjMVdIiEIPYQjPHO4gLcuh9Qkh2HqV+gKL32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com; dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b=0O55Wb6K; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=PMuYU9Yy; arc=none smtp.client-ip=23.251.234.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=otpfqkfjftndw3gmuo745xikcugpdsgy; d=hrntknr.net; t=1707559328;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=agL9AgIAe/eZ1tw5Yr0v+hqP61J7jBZMj2yUqRfZewQ=;
	b=0O55Wb6K63/rr6FfHkKUEsXNXJNbfVqGVemrp787QVgmcQKs+5f2VpuvbHHO0ots
	Ejt/h0QwtbPEsNGfPbcMaYL7n8yIU38wAV/jemRtrB8mI16fIQ4YnMEi2o2D0eyx0va
	um+JXh7ouzLWH9rOFvAd3jFZ3Ha17pxfOx6cKgq1ZSmuC3uNMVZElvtIzeRp8Cy2bvR
	bZ79kdoLpbxNK1aem0NnOSi4xeNkqkrUqI5XHKF4PbnE+Mts/5d3Sivk8Y7TLeVgWtd
	5qdYQI1s7e5z7yGOAlNrV3av4xTI4oRX6YTgOnlZjKxwaKVparHLeSPI6JfSkFlq5+w
	0VTSEXcB4Q==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1707559328;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=agL9AgIAe/eZ1tw5Yr0v+hqP61J7jBZMj2yUqRfZewQ=;
	b=PMuYU9Yy7tnaMwCZDGVSb29E2XNSStx1L4UkVdFOIfdclTn9N/I7teRIdPPvOxaw
	YHD9ktkRtBd+zvq/JLlUJ89TsLFH79j8pGxJo4EVq7uTk0yd1W/AD4ykcsNH3l3NIpY
	uVRu88N/T5eR04oSaPD3nVShj5dfshqXCsydm62Q=
Date: Sat, 10 Feb 2024 10:02:08 +0000
From: Takanori Hirano <me@hrntknr.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] tc: Support json option in tc-fw.
Message-ID: <0106018d927798fb-9c1b1019-3a9b-42e7-9947-142f14472ec9-000000@ap-northeast-1.amazonses.com>
References: <0106018d8e3feccb-51048e17-d81c-4a1b-97cb-bc3809ad3eca-000000@ap-northeast-1.amazonses.com>
 <20240209083743.2bd1a90d@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209083743.2bd1a90d@hermes.local>
Feedback-ID: 1.ap-northeast-1.rx1zlehJXIhTBJXf7/H1gLdwyBf0eKXp6+AKci1nnIg=:AmazonSES
X-SES-Outgoing: 2024.02.10-23.251.234.5

On Fri, Feb 09, 2024 at 08:37:43AM -0800, Stephen Hemminger wrote:
> On Fri, 9 Feb 2024 14:22:50 +0000
> Takanori Hirano <me@hrntknr.net> wrote:
> 
> > Fix json corruption when using the "-json" option in cases where tc-fw is set.
> > 
> > Signed-off-by: Takanori Hirano <me@hrntknr.net>
> 
> This looks correct, but there area a number of other places in the filter (f_XXX.c)
> files that still are broken with JSON.
> 
Thanks for the review.
I will send you v2 patch with the other filters fixed.


