Return-Path: <netdev+bounces-39611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA3D7C018E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5621C20B50
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CC3347B0;
	Tue, 10 Oct 2023 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FplpEcq0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FBD27470
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DD7C433C8;
	Tue, 10 Oct 2023 16:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696955164;
	bh=6zo37YWaVuaqfFuhVFKXF7CJDGCVGAhXDUBjLQ45+R4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FplpEcq0RzIkOdrmXDOMIhQUbOixntSWXHUyNLnEEexl1M8kwqBqH3ZxVQkMmoGMy
	 uFoWu1yGzt04A7Cyc+gu4JGgCvQfoyiflK93hN/lPfLh/uHMSTw2fs/ABuIYq7JLOG
	 r/y47BNzF+ldTibsAdzgq5tVpX9S158swVGEyKqumNAzuFC1pYfi3GuphKBSKf5940
	 gX02estIu2QIMVviIv+yXeBNVJsLXBXrAjlVqqJeitFkGlUbsOcK0yPFJdP8SX9yvf
	 9Stg8AalO945SwYAbKJd8zqN0dkHS9UeytXSgSkh6hwpAHnc0k9LASI+VrvOS/DCLD
	 NJq7TLAbiQEuA==
Message-ID: <c6f97249-ff76-8078-a9a4-c18658de9f6d@kernel.org>
Date: Tue, 10 Oct 2023 10:26:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] net-next: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment
 after fragment check
Content-Language: en-US
To: Heng Guo <heng.guo@windriver.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, filip.pudak@windriver.com
References: <20231008005922.24777-1-heng.guo@windriver.com>
 <20231008005922.24777-2-heng.guo@windriver.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231008005922.24777-2-heng.guo@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/23 6:59 PM, Heng Guo wrote:
> According to RFC 4293 "3.2.3. IP Statistics Tables",
>   +-------+------>------+----->-----+----->-----+
>   | InForwDatagrams (6) | OutForwDatagrams (6)  |
>   |                     V                       +->-+ OutFragReqds
>   |                 InNoRoutes                  |   | (packets)
>   / (local packet (3)                           |   |
>   |  IF is that of the address                  |   +--> OutFragFails
>   |  and may not be the receiving IF)           |   |    (packets)
> the IPSTATS_MIB_OUTFORWDATAGRAMS should be counted before fragment
> check.
> 
> The existing implementation, instead, would incease the counter after
> fragment check: ip_exceeds_mtu() in ipv4 and ip6_pkt_too_big() in ipv6.
> 
> So move IPSTATS_MIB_OUTFORWDATAGRAMS counter to ip_forward() for ipv4 and
> ip6_forward() for ipv6.
> 
> Reviewed-by: Filip Pudak <filip.pudak@windriver.com>
> Signed-off-by: Heng Guo <heng.guo@windriver.com>
> ---
>  net/ipv4/ip_forward.c | 4 ++--
>  net/ipv6/ip6_output.c | 6 ++----
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

Please repost as just a single patch and add in the details from the
cover letter.


