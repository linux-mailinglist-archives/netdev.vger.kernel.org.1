Return-Path: <netdev+bounces-27416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F5D77BDEE
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 18:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012D62811BC
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17524C8E6;
	Mon, 14 Aug 2023 16:29:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122EC139
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 16:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D344C43391;
	Mon, 14 Aug 2023 16:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692030566;
	bh=DNY59+l4eLHFd7cPF+IJT2wogfX2f9bA2o7xtjOlI0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GXKkyKRjJrgG9ZKR4/KXM/ZQifAN3LmqgAJoTQwlcqp94JcyJIZogGfhJRr3yD56l
	 7S/JhwlMX+t9g1l4j04OKOiNu/sXlVUnksPsinCU7BlFH3flO5h/+inLouDz7Y1bpO
	 VGyTuUg0V+uzdq6RD28Vzx7liNaFgq/k5tQ8OKR6Anbpc6QAK7BqoFvngM2GRMDJst
	 yYo9S8r8j5Owfu9hs/Jq7gUwiGl+zUmH43+cdbvjs1mTutjgkQIPOddTewnFyAgUOm
	 hlEs/nSOadUMNlkettYYJJkjXIsHjFs7qMZFyjtcgEaL6gAZ662gE7NmkhqrejY7JG
	 jOWm+uADUauTA==
Message-ID: <ee132c0c-daed-3ffb-b6d9-156e1bbd9e1f@kernel.org>
Date: Mon, 14 Aug 2023 10:29:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [net-next v2 2/2] selftests: seg6: add selftest for NEXT-C-SID
 flavor in SRv6 End.X behavior
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
 <20230812180926.16689-3-andrea.mayer@uniroma2.it>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230812180926.16689-3-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/23 12:09 PM, Andrea Mayer wrote:
> From: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
> 
> This selftest is designed for testing the support of NEXT-C-SID flavor
> for SRv6 End.X behavior. It instantiates a virtual network composed of
> several nodes: hosts and SRv6 routers. Each node is realized using a
> network namespace that is properly interconnected to others through veth
> pairs, according to the topology depicted in the selftest script file.
> The test considers SRv6 routers implementing IPv4/IPv6 L3 VPNs leveraged
> by hosts for communicating with each other. Such routers i) apply
> different SRv6 Policies to the traffic received from connected hosts,
> considering the IPv4 or IPv6 protocols; ii) use the NEXT-C-SID
> compression mechanism for encoding several SRv6 segments within a single
> 128-bit SID address, referred to as a Compressed SID (C-SID) container.
> 
> The NEXT-C-SID is provided as a "flavor" of the SRv6 End.X behavior,
> enabling it to properly process the C-SID containers. The correct
> execution of the enabled NEXT-C-SID SRv6 End.X behavior is verified
> through reachability tests carried out between hosts belonging to the
> same VPN.
> 
> Signed-off-by: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
> Co-developed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  tools/testing/selftests/net/Makefile          |    1 +
>  .../net/srv6_end_x_next_csid_l3vpn_test.sh    | 1213 +++++++++++++++++
>  2 files changed, 1214 insertions(+)
>  create mode 100755 tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


