Return-Path: <netdev+bounces-39409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB90B7BF10A
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 04:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE8C1C20A11
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E7C38C;
	Tue, 10 Oct 2023 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOfweUPi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28294361
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1ABC433C7;
	Tue, 10 Oct 2023 02:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696905772;
	bh=WkoJ/Jatt7ehaS0mf0TQB3j7edh/9ZJslhYaC7s63JI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YOfweUPibfP3MB6pfrKxWBwhUTKXgUQ/nOotvbhXBwU0rHoZuuXFklMJdllX0ayKd
	 Eb2Z7+OZwd/UEGYaqquPYKubvmsyl7MYuaC9bAdEIT1MjeLNPW48c3Aye/B0O1CG3V
	 iQWOZO2aq61tqD3H0wcHAhn3+Wo/njh6EZ2I7DDC1XP1RiVYE/i1LAGvXWrdceSc2C
	 6OZ3bx6zSl+SYwcf4AXr/lvZlqUzIyTlelimqDzKW6TWYRluQWzPyKytIHoi1eZn8B
	 b8IUUEObvrogXDah2NIXpYWq5CFVG6e86itvWPIse9XYf9FRfDIJjE3AuMfvdIIwCT
	 8thpG5/6S1uww==
Date: Mon, 9 Oct 2023 19:42:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, vadim.fedorenko@linux.dev, lkp@intel.com,
 horms@kernel.org, Sean Tranchetti <quic_stranche@quicinc.com>
Subject: Re: [PATCH net-next v4] net: qualcomm: rmnet: Add side band flow
 control support
Message-ID: <20231009194251.641e9134@kernel.org>
In-Reply-To: <20231006001614.1678782-1-quic_subashab@quicinc.com>
References: <20231006001614.1678782-1-quic_subashab@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Oct 2023 17:16:14 -0700 Subash Abhinov Kasiviswanathan wrote:
> Individual rmnet devices map to specific network types such as internet,
> multimedia messaging services, IP multimedia subsystem etc. Each of
> these network types may support varying quality of service for different
> bearers or traffic types.
> 
> The physical device interconnect to radio hardware may support a
> higher data rate than what is actually supported by the radio network.
> Any packets transmitted to the radio hardware which exceed the radio
> network data rate limit maybe dropped. This patch tries to minimize the
> loss of packets by adding support for bearer level flow control within a
> rmnet device by ensuring that the packets transmitted do not exceed the
> limit allowed by the radio network.
> 
> In order to support multiple bearers, rmnet must be created as a
> multiqueue TX netdevice. Radio hardware communicates the supported
> bearer information for a given network via side band signalling.
> Consider the following mapping -
> 
> IPv4 UDP port 1234 - Mark 0x1001 - Queue 1
> IPv6 TCP port 2345 - Mark 0x2001 - Queue 2
> 
> iptables can be used to install filters which mark packets matching these
> specific traffic patterns and the RMNET_QUEUE_MAPPING_ADD operation can
> then be to install the mapping of the mark to the specific txqueue.

I don't understand why you need driver specific commands to do this.
It should be easily achievable using existing TC qdisc infra.
What's the gap?

