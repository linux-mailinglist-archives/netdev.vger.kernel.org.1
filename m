Return-Path: <netdev+bounces-127986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAECA9776C4
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 04:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C50B21A93
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 02:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBE41D131C;
	Fri, 13 Sep 2024 02:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK+WqHSB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3048455886;
	Fri, 13 Sep 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726193589; cv=none; b=PqNHkRPSABcU2e6jTBSOG+tUUEmAqLWOdbDKO0SDP475VTrYJjwZrq7SW2qxYDZuixzYs9MXacjQSTYQiLPp9o++izJvt7Axs4SMWlgYG2HYCPcqKZ4Le+LNzAgVymO6LHZu8/YZW2Z4bpCMNl4slumJXW0JsIYWLWZc3HNPP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726193589; c=relaxed/simple;
	bh=TvUg8JpVDCWZbKxhwdcbMY2TgwsG2HjjEy20zkRhrEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/3WDCcZYezs/jwMgGj4V5rBQEWSnBVruTCa/YAfi+SsW9bQy8xwRdVwNDUgivdUjwjpkzrd8gDjMhfY9qXwkPgc/TmpAJWZD4OUxcixGoaCFXeRpv0LLiehPQ7opmkLsOAW08VWWlk8wkBC0JnWaatpXStdiXwgocEI/IZjhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK+WqHSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35308C4CEC3;
	Fri, 13 Sep 2024 02:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726193588;
	bh=TvUg8JpVDCWZbKxhwdcbMY2TgwsG2HjjEy20zkRhrEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cK+WqHSBFZgbtB9lKdv4jslrMn6pHtJAp7iETp8ZTBGu0w82I6LSsG1u0dVw0l2T/
	 zVrcr+uWZUTjyiqJMOgjl5yqNnf0+/XTDZkiGfLdyW+6KNaeMRrftCjXyW3YYCLY3r
	 5c0qj8d2gBlH4JRFu+VGOgUAJXv8mEAX6RqkcP8b+AjLrA8j/JUZSRfHdSOPz8wY1F
	 OOjFnhjZvToj9yFnHk6FY4U4SlEUkllFF9SIYFuNQn/3GzGydDOsISAp81EoXaLIqJ
	 McqU8LG6Y/hbqLi+Tdk9/nXh/2SvBQZMByRcu+1cLRNMOVziv/kBfa2WBV368x+6hO
	 qrGZL43FN594g==
Date: Thu, 12 Sep 2024 19:13:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jacob Martin <jacob.martin@canonical.com>,
 dann frazier <dann.frazier@canonical.com>
Subject: Re: Namespaced network devices not cleaned up properly after
 execution of pmtu.sh kernel selftest
Message-ID: <20240912191306.0cf81ce3@kernel.org>
In-Reply-To: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 17:20:29 -0500 Mitchell Augustin wrote:
> We recently identified a bug still impacting upstream, triggered
> occasionally by one of the kernel selftests (net/pmtu.sh) that
> sometimes causes the following behavior:
> * One of this tests's namespaced network devices does not get properly
> cleaned up when the namespace is destroyed, evidenced by
> `unregister_netdevice: waiting for veth_A-R1 to become free. Usage
> count = 5` appearing in the dmesg output repeatedly
> * Once we start to see the above `unregister_netdevice` message, an
> un-cancelable hang will occur on subsequent attempts to run `modprobe
> ip6_vti` or `rmmod ip6_vti`

Thanks for the report! We have seen it in our CI as well, it happens
maybe once a day. But as you say on x86 is quite hard to reproduce,
and nothing obvious stood out as a culprit.

> However, I can easily reproduce the issue on an Nvidia Grace/Hopper
> machine (and other platforms with modern CPUs) with the performance
> governor set by doing the following:
> * Install/boot any affected kernel
> * Clone the kernel tree just to get an older version of the test cases
> without subtle timing changes that mask the issue (such as
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/noble/tree/?h=Ubuntu-6.8.0-39.39)
> * cd tools/testing/selftests/net
> * while true; do sudo ./pmtu.sh pmtu_ipv6_ipv6_exception; done

That's exciting! Would you be able to try to cut down the test itself
(is quite long and has a ton of sub-cases). Figure out which sub-cases
trigger this? And maybe with an even quicker repro we'll bisect or
someone will correctly guess the fix?

Somewhat tangentially but if you'd be willing I wouldn't mind if you
were to send patches to break this test up upstream, too. It takes
1h23m to run with various debug kernel options enabled. If we split 
it into multiple smaller tests each running 10min or 20min we can 
then spawn multiple VMs and get the results faster.

