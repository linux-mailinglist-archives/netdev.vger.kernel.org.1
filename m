Return-Path: <netdev+bounces-23851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF376DDD5
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5285281F17
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC28C2107;
	Thu,  3 Aug 2023 02:06:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F87F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F77C433C8;
	Thu,  3 Aug 2023 02:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691028407;
	bh=F7jcE1coWI7butGrmgWnkAlL4JiykzmKbIjWoEuOFfU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XNGOVjuDkI1hr5qFgxFmEi+47j3P11mDX5WfgSm2O93/C/3X6yF+2XqLT6L8PmFS6
	 Wokxv9wAKviJA9QyRQJYNoEihkgGwE6SpP7/IzOjgArKr47MJPuj2C360HB8ICNJL2
	 TfQCqvTjvQa0PlkUWSgtucx+jc+8xXO5Ow+iv1brTyH0I4DGcB/14gek0GoqG1Ljxb
	 GhEAAe1K4PFRPeDOS546w+LlAceYIs8ZyZTav1sOiQUG5rfV3XHoXbhRaJOB4Rk+uI
	 IKr/1oqUkPnLWurxSOpl/xbILh49YlciTM4ZRUjNkiXxdqBIY0wXEMrELrRFd6Ol4u
	 4r/MFCpxBibyA==
Message-ID: <85c6c94e-1243-33ae-dadd-9bcdd7d328d1@kernel.org>
Date: Wed, 2 Aug 2023 20:06:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v5 2/2] selftests: fib_tests: Add a test case for
 IPv6 garbage collection
Content-Language: en-US
To: thinker.li@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 martin.lau@linux.dev, kernel-team@meta.com, yhs@meta.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20230802004303.567266-1-thinker.li@gmail.com>
 <20230802004303.567266-3-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230802004303.567266-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/23 6:43 PM, thinker.li@gmail.com wrote:
\> @@ -747,6 +750,97 @@ fib_notify_test()
>  	cleanup &> /dev/null
>  }
>  
> +fib6_gc_test()
> +{
> +	echo
> +	echo "Fib6 garbage collection test"
> +
> +	STRACE=$(which strace)
> +	if [ -z "$STRACE" ]; then
> +	    echo "    SKIP: strace not found"
> +	    ret=$ksft_skip
> +	    return
> +	fi
> +
> +	EXPIRE=10
> +
> +	setup
> +
> +	set -e
> +
> +	# Check expiration of routes every 3 seconds (GC)
> +	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=300
> +
> +	$IP link add dummy_10 type dummy
> +	$IP link set dev dummy_10 up
> +	$IP -6 address add 2001:10::1/64 dev dummy_10
> +
> +	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
> +
> +	# Temporary routes
> +	for i in $(seq 1 1000); do
> +	    # Expire route after $EXPIRE seconds
> +	    $IP -6 route add 2001:20::$i \
> +		via 2001:10::2 dev dummy_10 expires $EXPIRE
> +	done
> +	N_EXP=$($IP -6 route list |grep expires|wc -l)
> +	if [ $N_EXP -ne 1000 ]; then

race condition here ... that you can install all 1000 routes and then
run this command before any expire. 10 seconds is normally more than
enough time, but on a loaded server it might not be. And really it does
not matter. What matters is that you install routes with an expires and
they disappear when expected - and I believe the flush below should not
be needed to validate they have been removed.



