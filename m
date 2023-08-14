Return-Path: <netdev+bounces-27413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E402277BDC1
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 18:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948B928115A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756E1C8DB;
	Mon, 14 Aug 2023 16:16:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF848C15C
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 16:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE590C433BD;
	Mon, 14 Aug 2023 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692029807;
	bh=XKO2xiTql41TuJLWtHYgWjPpFQF/Knxed55Bfd0sH6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N04TVlLA2sSYBppKAwbJPd63MGeg3lZCanL0qajx5zFZXwvmsxyuwQTVgYRHm/Mqs
	 syaqNxvXLKpWuKfLPSN6fv/QV3sQKkawCCt9I2GdfCoK5laCBr5qH6t17hAUf01nUd
	 yfXR0YGud2GcHSC85CpKfMzLS9bFhU6PwKsuwtu3KIdOmZ4vPAOW6GnIVdUIiJlRRN
	 vKKWSs82TOdZiGvg+2C0StnxbSgV3mRshEO2/g+j86IU/8vswNcZnjhw+MsuvEYw3g
	 PU6v6iN/ePYTVD0TPU6+jfphRXeLuD4k3rizkpy0xlC/lZiFsbo3996Weog9THEV1V
	 htAhxBqooDLqg==
Message-ID: <92d32852-17f0-099c-a2b5-12a29da14133@kernel.org>
Date: Mon, 14 Aug 2023 10:16:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [net-next v2 1/2] seg6: add NEXT-C-SID support for SRv6 End.X
 behavior
Content-Language: en-US
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels.dev@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>
References: <20230812180926.16689-1-andrea.mayer@uniroma2.it>
 <20230812180926.16689-2-andrea.mayer@uniroma2.it>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230812180926.16689-2-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/23 12:09 PM, Andrea Mayer wrote:
> The NEXT-C-SID mechanism described in [1] offers the possibility of
> encoding several SRv6 segments within a single 128 bit SID address. Such
> a SID address is called a Compressed SID (C-SID) container. In this way,
> the length of the SID List can be drastically reduced.
> 
> A SID instantiated with the NEXT-C-SID flavor considers an IPv6 address
> logically structured in three main blocks: i) Locator-Block; ii)
> Locator-Node Function; iii) Argument.
> 
>                         C-SID container
> +------------------------------------------------------------------+
> |     Locator-Block      |Loc-Node|            Argument            |
> |                        |Function|                                |
> +------------------------------------------------------------------+
> <--------- B -----------> <- NF -> <------------- A --------------->
> 
>    (i) The Locator-Block can be any IPv6 prefix available to the provider;
> 
>   (ii) The Locator-Node Function represents the node and the function to
>        be triggered when a packet is received on the node;
> 
>  (iii) The Argument carries the remaining C-SIDs in the current C-SID
>        container.
> 
> This patch leverages the NEXT-C-SID mechanism previously introduced in the
> Linux SRv6 subsystem [2] to support SID compression capabilities in the
> SRv6 End.X behavior [3].
> An SRv6 End.X behavior with NEXT-C-SID flavor works as an End.X behavior
> but it is capable of processing the compressed SID List encoded in C-SID
> containers.
> 
> An SRv6 End.X behavior with NEXT-C-SID flavor can be configured to support
> user-provided Locator-Block and Locator-Node Function lengths. In this
> implementation, such lengths must be evenly divisible by 8 (i.e. must be
> byte-aligned), otherwise the kernel informs the user about invalid
> values with a meaningful error code and message through netlink_ext_ack.
> 
> If Locator-Block and/or Locator-Node Function lengths are not provided
> by the user during configuration of an SRv6 End.X behavior instance with
> NEXT-C-SID flavor, the kernel will choose their default values i.e.,
> 32-bit Locator-Block and 16-bit Locator-Node Function.
> 
> [1] - https://datatracker.ietf.org/doc/html/draft-ietf-spring-srv6-srh-compression
> [2] - https://lore.kernel.org/all/20220912171619.16943-1-andrea.mayer@uniroma2.it/
> [3] - https://datatracker.ietf.org/doc/html/rfc8986#name-endx-l3-cross-connect
> 
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/seg6_local.c | 108 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 88 insertions(+), 20 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


