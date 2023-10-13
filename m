Return-Path: <netdev+bounces-40808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7017C8ADE
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE4C1C20B05
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3982F20B0B;
	Fri, 13 Oct 2023 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSdJ+ZfS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182773D011
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 16:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3960C433C8;
	Fri, 13 Oct 2023 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697214000;
	bh=jB3xhsGiwedT1y0wsLmc3+3AK+4h8XgMTED+Ov12vqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rSdJ+ZfS8hra/kHxpm4imBJSuOolm27MNMNZ7jyYCdnRGaeygnfM70LBwbbbY6STu
	 ELaUi+KmT0gJGPp0k/4ekqUeFMjk4RTbXsgjnCRIIlMQJFu9LteNfhak5LfQssUGcC
	 Tp3Vka37L6UIDskAq0wYaih8iStrWdDOzllpwGS9otXToYwuN1X4QbYgO64hZOf5CD
	 7sSDOEyGx1YRlX48QCwwlRf2PljlPkd+dMrW7hVbunqdXNIJHoI435npJEEr1w8rHP
	 9XIviSGO+1peoa+CkVn2iPLSc+rM6rLHJ7MbKr5IPW128AggXALCnpCJIBis2HJpl8
	 ErDyxdrYzXX5A==
Message-ID: <e18c52e8-116e-f258-7f2c-030a80e88343@kernel.org>
Date: Fri, 13 Oct 2023 11:19:58 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [net] ipv4: Fix broken PMTUD when using L4 multipath hash
Content-Language: en-US
To: "Nabil S. Alramli" <nalramli@fastly.com>, sbhogavilli@fastly.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: srao@fastly.com, dev@nalramli.com
References: <20231012005721.2742-2-nalramli@fastly.com>
 <20231012234025.4025-1-nalramli@fastly.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231012234025.4025-1-nalramli@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/23 5:40 PM, Nabil S. Alramli wrote:
> From: Suresh Bhogavilli <sbhogavilli@fastly.com>
> 
> On a node with multiple network interfaces, if we enable layer 4 hash
> policy with net.ipv4.fib_multipath_hash_policy=1, path MTU discovery is
> broken and TCP connection does not make progress unless the incoming
> ICMP Fragmentation Needed (type 3, code 4) message is received on the
> egress interface of selected nexthop of the socket.

known problem.

> 
> This is because build_sk_flow_key() does not provide the sport and dport
> from the socket when calling flowi4_init_output(). This appears to be a
> copy/paste error of build_skb_flow_key() -> __build_flow_key() ->
> flowi4_init_output() call used for packet forwarding where an skb is
> present, is passed later to fib_multipath_hash() call, and can scrape
> out both sport and dport from the skb if L4 hash policy is in use.

are you sure?

As I recall the problem is that the ICMP can be received on a different
path. When it is processed, the exception is added to the ingress device
of the ICMP and not the device the original packet egressed. I have
scripts that somewhat reliably reproduced the problem; I started working
on a fix and got distracted.

