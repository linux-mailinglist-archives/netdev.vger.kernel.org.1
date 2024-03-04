Return-Path: <netdev+bounces-77170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C388387063B
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B0DB2EE85
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAA24F885;
	Mon,  4 Mar 2024 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVYGF4uF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71234F215
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567064; cv=none; b=qBjh+///ebzJ6cJYgb8PRBPfefzOAz/2C+RM75Q6LoNoENASIpk2seVmhDePWoEIDNS3y2g6R3jdGvA023W5twoWwjGVjiiDmu3j0WmfGh5EqdqpyjJwvZApU761FuITBl+fLY/3J1r78d5znWq3Gve33qV8kv6Bsmes3ykB1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567064; c=relaxed/simple;
	bh=FfoN+4twHIH5RjAcj+dLL3rmJHUef3ZiIEoyntEaqjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+hMnJloQi1QsHwPxtW5FCTkeT29T8a8eLKwMM8EB1laiB/aZdK+bFaZfXE4YqTNXN0C/jRM3csUCNcDLE1YmPL238IGCtyIJJXoZ7Y/fGOsGlbjz44ay8ThcPvXUg6xturEIb4sqAqeCMP7RlHS5spLXVq5nrj4FMC4Igj9e/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVYGF4uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E40C43394;
	Mon,  4 Mar 2024 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709567063;
	bh=FfoN+4twHIH5RjAcj+dLL3rmJHUef3ZiIEoyntEaqjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rVYGF4uFjCTI1TjK2muSV4jkIOa2Qv+H1uNAunqmgqAc81phLct7NLKEQC7ht3lgf
	 QvG2fn+UL0nHcvcyNuhSPr/ZRRjpznWiaxTJjV2v+KURfLE6HpEWyd9S3ULYv1QDaU
	 t/r7sWiQSt3/VwinUrMNlEgbXl0+qpy4egVvfO/T1vfS947poRPYqFHybTQfTh1abj
	 c6YLosvUavlWNZQ89oT37edoUWIeDznFzreJzJHIzft6V256NQ9UKPbn1kqIFCn8uQ
	 s+WlKVOnUhlCAwDO+rJjCJCvh9k2Pk/ASKY53/aFvFm8fY6G8upu496yWO4k/CXQka
	 GhnyyCSnZtMSQ==
Date: Mon, 4 Mar 2024 07:44:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, kuifeng@meta.com
Subject: Re: [PATCH net-next] selftests/net: force synchronized GC for a
 test.
Message-ID: <20240304074421.41726c4d@kernel.org>
In-Reply-To: <d2a4bcab-4fab-4750-b856-a8a9b674a31a@gmail.com>
References: <20240223081346.2052267-1-thinker.li@gmail.com>
	<20240223182109.3cb573a2@kernel.org>
	<b1386790-905f-4bc4-8e60-c0c86030b60c@kernel.org>
	<6b73aa09-b842-4bd0-abab-7011495e7176@gmail.com>
	<d2a4bcab-4fab-4750-b856-a8a9b674a31a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 16:45:58 -0800 Kui-Feng Lee wrote:
> However, some extra waiting may be added to it.
> There are two possible extra waiting. The first one is calling
> round_jiffies() in fib6_run_gc(), that may add 750ms at most. The second
> one is the granularity of waiting for 5 seconds (in our case) is 512ms
> for HZ 1000 according to the comment at the very begin of timer.c.
> In fact, it can add 392ms for 5750ms (5000ms + 750ms). Overall, they may
> contribute up to 1144ms.
> 
> Does that make sense?
> 
> Debug build is slower. So, the test scripts will be slower than normal
> build. That means the script is actually waiting longer with a debug build.

Meaning bumping the wait to $((($EXPIRE + 1) * 2))
should be enough for the non-debug runner?

