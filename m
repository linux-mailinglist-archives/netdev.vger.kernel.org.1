Return-Path: <netdev+bounces-44758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1537D9843
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C2FB20D5C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A561E1EB37;
	Fri, 27 Oct 2023 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72162D053
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:32:15 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (unknown [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E081B1;
	Fri, 27 Oct 2023 05:32:13 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qwLzu-0005El-M8; Fri, 27 Oct 2023 14:31:30 +0200
Date: Fri, 27 Oct 2023 14:31:30 +0200
From: Florian Westphal <fw@strlen.de>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [RFC Draft PATCHv2 net-next] Doc: update bridge doc
Message-ID: <ZTutokxEXya0rqYs@strlen.de>
References: <20231027071842.2705262-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027071842.2705262-1-liuhangbin@gmail.com>

Hangbin Liu <liuhangbin@gmail.com> wrote:

[ cc nf-devel ]

> The current bridge kernel doc is too old. It only pointed to the
> linuxfoundation wiki page which lacks of the new features.

Indeed, thanks for taking time to improve the documention.

> +Netfilter
> +=========
> +
> +The bridge netfilter module allows packet filtering and firewall functionality
> +on bridge interfaces. As the Linux bridge, which traditionally operates at
> +Layer 2 and connects multiple network interfaces or segments, doesn't have
> +built-in packet filtering capabilities.

No, this is not what this module does.  br_netfilter module should NEVER
be used.  I'd love to remove it, but its very popular unfortunately.

Suggestion:

The bridge netfilter module is a legacy feature that allows to filter bridged
packets with iptables and ip6tables.  Its use is discouraged.  Users
should consider using nftables for packet filtering.

The older ebtables tool is more feature-limited compared to nftables, but
just like nftables it doesn't need this module either to function.

The br_netfilter module intercepts packets entering the bridge, performs
minimal sanity tests on ipv4 and ipv6 packets and then pretends that
these packets are being routed, not bridged.  br_netfilter then calls
the ip and ipv6 netfilter hooks from the bridge layer, i.e. ip(6)tables
rulesets will also see these packets.

br_netfilter is also the reason for the iptables 'physdev' match:
This match is the only way to reliably tell routed and bridged packets
apart in an iptables ruleset.

Side note:

You might want to somehow massage the bits below, perhaps it would be
good to have the historical context as to why br_netfilter exists in the
first place.

> +With bridge netfilter, you can define rules to filter or manipulate Ethernet
> +frames as they traverse the bridge. These rules are typically based on
> +Ethernet frame attributes such as MAC addresses, VLAN tags, and more.
> +You can use the *ebtables* or *nftables* tools to create and manage these
> +rules. *ebtables* is a tool specifically designed for managing Ethernet frame
> +filtering rules, while *nftables* is a more versatile framework for managing
> +rules that can also be used for bridge filtering.

ebtables and nftables will work fine without the br_netfilter module.

iptables/ip6tables/arptables do not work for bridged traffic because they
plug in the routing stack.

nftables rules in ip/ip6/inet/arp families won't see traffic that is
forwarded by a bridge either, but thats very much how it should be.

br_netfilter is only needed if users, for some reason, need to use
ip(6)tables to filter packets forwarded by the bridge, or NAT bridged
traffic.

Historically the feature set of ebtables was very limited (it still is),
so this module was added to pretend packets are routed and invoke the
ipv4/ipv6 netfilter hooks from the bridge so users had access to the
more feature-rich iptables matching capabilities (including conntrack).

nftables doesn't have this limitation, pretty much all features work
regardless of the protocol family.

> +The bridge netfilter is commonly used in scenarios where you want to apply
> +security policies to the traffic at the data link layer. This can be useful
> +for segmenting and securing networks, enforcing access control policies,
> +and isolating different parts of a network.

See above, for pure link layer filtering, this module isn't needed.

