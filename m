Return-Path: <netdev+bounces-47199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAAA7E8C47
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 20:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BF1280E9C
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 19:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B541B27E;
	Sat, 11 Nov 2023 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4i8YqiV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AFB1BDEC
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 19:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34486C433C8;
	Sat, 11 Nov 2023 19:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699729664;
	bh=KTspa5oUzWnS3bLUzEkJoayWGXdX0hxAUXytoJACcz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4i8YqiVwD+gxoJGd1mdGluEL3nEGJ0CeVUtZB4Zuol69jffGREmsWK2n97siXgLI
	 joILWGdG2stayiQwqp6/ds+3+dRHw7E9Vj5UhGN1cKJmivNRpf6VjAeVnMuh5ii+lZ
	 0+ylvB4ccee8tuA1/hn0oTeAL5EOMGZd+NsR+C+wKmY3GbdQdmoEVfYGHTYzUYhGQ8
	 pSqN5govnirGtTlVPaUXBcitt+fIdkHXZAuVnbIA54bCUC16vbpYFSh9NWgq+cDTOT
	 cXjCAFWU4VCH7Tq9EON+vy01OitMgMF7+lfgbyx3lSRtoC8f89DW3TT6s6/bU8nWL8
	 8h6y0slLWl8QA==
Date: Sat, 11 Nov 2023 19:07:33 +0000
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC PATCHv3 net-next 04/10] docs: bridge: Add kAPI/uAPI fields
Message-ID: <20231111190733.GD705326@kernel.org>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
 <20231110101548.1900519-5-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110101548.1900519-5-liuhangbin@gmail.com>

On Fri, Nov 10, 2023 at 06:15:41PM +0800, Hangbin Liu wrote:
> The current bridge kernel doc is too old. It only pointed to the
> linuxfoundation wiki page which lacks of the new features.
> 
> Here let's start the new bridge document and put all the bridge info
> so new developers and users could catch up the last bridge status soon.
> 
> First add kAPI/uAPI and FAQ fields. These 2 fileds are only examples and
> more APIs need to be added in future.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  Documentation/networking/bridge.rst | 83 +++++++++++++++++++++++++----
>  1 file changed, 73 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
> index c859f3c1636e..d06c51960f45 100644
> --- a/Documentation/networking/bridge.rst
> +++ b/Documentation/networking/bridge.rst
> @@ -4,18 +4,81 @@
>  Ethernet Bridging
>  =================
>  
> -In order to use the Ethernet bridging functionality, you'll need the
> -userspace tools.
> +Introduction
> +============
>  
> -Documentation for Linux bridging is on:
> -   https://wiki.linuxfoundation.org/networking/bridge
> +A bridge is a way to connect multiple Ethernet segments together in a protocol
> +independent way. Packets are forwarded based on Layer 2 destination Ethernet
> +address, rather than IP address (like a router). Since forwarding is done
> +at Layer 2, all Layer 3 protocols can pass through a bridge transparently.
>  
> -The bridge-utilities are maintained at:
> -   git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/bridge-utils.git
> +Bridge kAPI
> +===========
>  
> -Additionally, the iproute2 utilities can be used to configure
> -bridge devices.
> +Here are some core structures of bridge code.
>  
> -If you still have questions, don't hesitate to post to the mailing list 
> -(more info https://lists.linux-foundation.org/mailman/listinfo/bridge).
> +.. kernel-doc:: net/bridge/br_private.h

nit: Building htmldocs reports:

 ./net/bridge/br_private.h:240: warning: Function parameter or member 'tnode' not described in 'net_bridge_vlan'
 ./net/bridge/br_private.h:240: warning: Function parameter or member 'tinfo' not described in 'net_bridge_vlan'

...

