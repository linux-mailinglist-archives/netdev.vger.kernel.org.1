Return-Path: <netdev+bounces-38084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682A07B8E7E
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 72C421C20325
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5A23745;
	Wed,  4 Oct 2023 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLx1T4sK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72C1D692
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 21:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1A0C433C8;
	Wed,  4 Oct 2023 21:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696453677;
	bh=6z1GNyMKc+NHUVCUy1/YobvF7U4qRt200m97Wx/WBu4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=LLx1T4sKVnfdi1PFYKxY2hGimH4zFEvBAXb7eZ9aEAZoaX+8I+K1ibAbq7KqovxGN
	 bn+P/KwUqMX7LXTUBHGusv2sJqrhpHb52idcHEeknj4DfmY19JnivH46auV8fp6AVC
	 TJ8yOmlxcAKIcE7l7wddNZyS99lidwYBa03r1D1V4O+mf8rblHwvRNVKtDSOLlYQC7
	 W23CipYUfcRzHj7p10ABwHNjqMSldILD70KA545Sbty4kdrpTZjEolzDVkIYgWI3/T
	 p2IlghG0P443Y46wDcVELs1Wd0qK4be2bRSLC2Mo5uX9abmr/kp0WglbAMaBQvNZtT
	 SRDHiPSkzwfRg==
Message-ID: <921f2209-1cdd-9ec7-ac25-19ce0e0e5d91@kernel.org>
Date: Wed, 4 Oct 2023 15:07:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: question: ip link "dev" keyword deprecated?
Content-Language: en-US
To: Donald Buczek <buczek@molgen.mpg.de>, netdev@vger.kernel.org
References: <bc7bf168-2a37-cd8e-3cac-cfd7ae475ebc@molgen.mpg.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <bc7bf168-2a37-cd8e-3cac-cfd7ae475ebc@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/23/23 6:09 AM, Donald Buczek wrote:
> Hi,
> 
> I've noticed, that veth(4) (from Linux man-pages) missed the "name"
> keyword in the second usage example:
> 
>     # ip link add <p1-name> netns <p1-ns> type veth peer <p2-name> netns
> <p2-ns>
> 
> which doesn't work with older iproute2 versions, e.g. 4.4, where
> <p2-name> is silently ignored.
> 
> I was about to send a man patch, but actually the syntax works with
> current iproute2 versions, because special coding has been removed and
> iplink_parse() interprets the non-keyword value "<p2-name>" from
> "<p2-name> netns <p2-ns>" as a "dev" option (with "dev" implied) and
> sets "name" to "dev" if only "dev" is given. So now for the same reason
> we can do
> 
>     ip link show lo
>     ip link show dev lo
> 
> we can also do any of
> 
>     # ip link add <p1-name> type veth peer name <p2-name>
>     # ip link add <p1-name> type veth peer dev <p2-name>
>     # ip link add <p1-name> type veth peer <p2-name>
> 
> But this looks like inherited baggage. And it doesn't work for older
> iproute2 versions. And veth(4) seems inconsistent with its two examples:
> 
>     # ip link add <p1-name> type veth peer name <p2-name>
>     # ip link add <p1-name> netns <p1-ns> type veth peer <p2-name> netns
> <p2-ns>
> 
> And even ip-link(8) from iproute2 itself doesn't talk about the "dev"
> keyword.
> 
> So I want to ask if there is a canonical syntax which should
> consistently be published and used, even if some legacy construct (like
> "peer <p2-name>") happen to work?
> 
> Related: Is the "dev" keywords generally deprecated?
> 
> 

"dev" still has relevance as `ip link help` shows.

Perhaps this commit is causing the change you noticed:

commit c58213f69c294c75ae6bd1ae16af7e0df29cf187
Author: Serhey Popovych <serhe.popovych@gmail.com>
Date:   Wed Mar 7 10:40:39 2018 +0200

    iplink: Perform most of request buffer setups and checks in
iplink_parse()

    To benefit other users (e.g. link_veth.c) of iplink_parse() from
    additional attribute checks and setups made in iplink_modify(). This
    catches most of weired cobination of parameters to peer device
    configuration.

    Drop @name, @dev, @link, @group and @index from iplink_parse()
parameters
    list: they are not needed outside.



