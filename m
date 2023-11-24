Return-Path: <netdev+bounces-50845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C2E7F7473
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12745281D2C
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300E11EB3D;
	Fri, 24 Nov 2023 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0o0oZln+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA0DD72
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:59:35 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a049d19b63bso265753766b.2
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1700830774; x=1701435574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqA538BoNFqhxnPN11T+HJoW31TjGyAqxKbufoNptpo=;
        b=0o0oZln+NHIf1ZTc+PxYMlZyQqbdOSO//duT9wil7hbXvpIFUxbLHiJrO5i1blqwO6
         vKa6hto3p+htZy9u5nv0vPqep5+rIUf005A5kaGugZoHY9Z69RRm8srXK76VNXE9bixE
         nSJd6ABtY+0byN5rkAPwP+lFzvqCsGjAOFL1KwCACay1XNh+/coqfhghXhNMkQiVzb3e
         YHsypUhbdgR0wZyVFVqm+j7pSd5UVNTBiF7kVvwE+3PnE+zWv+Toyv/Ja/94qD+gvmBS
         Z863m+d+FoG6RIAmUbhJN+5vvxGw0pl7j4fPAuDNfxEbQD/wvUFo5RTjxaRjQ3QasZry
         ieoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700830774; x=1701435574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqA538BoNFqhxnPN11T+HJoW31TjGyAqxKbufoNptpo=;
        b=R9wUXj8OKtcfBCp+3irv2FA4Y/1ZbifkS0Em5D7gGba6dIjX05SEUySYRot5d7I4Yg
         45UQVK4wlzqc5nFlLm0lbMhMlSSsZwlSqlcHRz3RJB54dA5c5S8Dd+m+F5AR6+/ZxwfU
         O/Z7KivGPSdjn4fUxZlpnQ4Tmhopzmh2nBe9n3BF7ohX+d6SAmwpMa18tA96aAMUUZcy
         7dgmi3IMfo9PC0Dj7/QDt93ri4EmmadDrm33HByRyZdQrOXkMkpD8vyeOyIpC/4vgjvN
         GSkEvN2lpt6iQZ7XTNYd03dtFThFG1WGVc7aapXO3u1Q2SS4LqyJgyv1kV7Xas8y84eG
         vIoQ==
X-Gm-Message-State: AOJu0Yy7d3UV3WwIUMcXjhESdWlyRopqR1bAy42grBvqn0Escy9D54Uy
	YYQ39r3paWdohMZcTLKPMZbV6Q==
X-Google-Smtp-Source: AGHT+IGuUn9E/9e7T13aSrOn4tFG1HFz+p56lEHF56yB+JSjWuczYIMsRT0CCio8mO8HqSHzZfLVrw==
X-Received: by 2002:a17:906:f357:b0:a0a:2704:e4f6 with SMTP id hg23-20020a170906f35700b00a0a2704e4f6mr460339ejb.21.1700830773768;
        Fri, 24 Nov 2023 04:59:33 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id t6-20020a170906064600b00a047f065fa6sm2012427ejb.206.2023.11.24.04.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 04:59:33 -0800 (PST)
Message-ID: <9f34ffca-ed5c-39a0-ab18-4a81ab96df45@blackwall.org>
Date: Fri, 24 Nov 2023 14:59:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv2 net-next 04/10] docs: bridge: Add kAPI/uAPI fields
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marc Muehlfeld <mmuehlfe@redhat.com>
References: <20231123134553.3394290-1-liuhangbin@gmail.com>
 <20231123134553.3394290-5-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231123134553.3394290-5-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/23 15:45, Hangbin Liu wrote:
> The current bridge kernel doc is too old. It only pointed to the
> linuxfoundation wiki page which lacks of the new features.
> 
> Here let's start the new bridge document and put all the bridge info
> so new developers and users could catch up the last bridge status soon.
> 
> First, add kAPI/uAPI and FAQ fields. These 2 fields are only examples and
> more APIs need to be added in future.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 84 +++++++++++++++++++++++++----
>   net/bridge/br_private.h             |  2 +
>   2 files changed, 76 insertions(+), 10 deletions(-)
> 

The title says add fields, but it also adds doc?
Perhaps split the last change into its own patch.
The rest looks good.

> diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
> index c859f3c1636e..84aae94f6598 100644
> --- a/Documentation/networking/bridge.rst
> +++ b/Documentation/networking/bridge.rst
> @@ -4,18 +4,82 @@
>   Ethernet Bridging
>   =================
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
> +   :identifiers: net_bridge_vlan
>   
> +Bridge uAPI
> +===========
> +
> +Modern Linux bridge uAPI is accessed via Netlink interface. You can find
> +below files where the bridge and bridge port netlink attributes are defined.
> +
> +Bridge netlink attributes
> +-------------------------
> +
> +.. kernel-doc:: include/uapi/linux/if_link.h
> +   :doc: Bridge enum definition
> +
> +Bridge port netlink attributes
> +------------------------------
> +
> +.. kernel-doc:: include/uapi/linux/if_link.h
> +   :doc: Bridge port enum definition
> +
> +Bridge sysfs
> +------------
> +
> +All sysfs attributes are also exported via the bridge netlink API.
> +You can find each attribute explanation based on the correspond netlink
> +attribute.
> +
> +NOTE: the sysfs interface is deprecated and should not be extended if new
> +options are added.
> +
> +.. kernel-doc:: net/bridge/br_sysfs_br.c
> +   :doc: Bridge sysfs attributes
> +
> +FAQ
> +===
> +
> +What does a bridge do?
> +----------------------
> +
> +A bridge transparently forwards traffic between multiple network interfaces.
> +In plain English this means that a bridge connects two or more physical
> +Ethernet networks, to form one larger (logical) Ethernet network.
> +
> +Is it L3 protocol independent?
> +------------------------------
> +
> +Yes. The bridge sees all frames, but it *uses* only L2 headers/information.
> +As such, the bridging functionality is protocol independent, and there should
> +be no trouble forwarding IPX, NetBEUI, IP, IPv6, etc.
> +
> +Contact Info
> +============
> +
> +The code is currently maintained by Roopa Prabhu <roopa@nvidia.com> and
> +Nikolay Aleksandrov <razor@blackwall.org>. Bridge bugs and enhancements
> +are discussed on the linux-netdev mailing list netdev@vger.kernel.org and
> +bridge@lists.linux-foundation.org.
> +
> +The list is open to anyone interested: http://vger.kernel.org/vger-lists.html#netdev
> +
> +External Links
> +==============
> +
> +The old Documentation for Linux bridging is on:
> +https://wiki.linuxfoundation.org/networking/bridge
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 6b7f36769d03..051ea81864ac 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -186,6 +186,7 @@ enum {
>    * struct net_bridge_vlan - per-vlan entry
>    *
>    * @vnode: rhashtable member
> + * @tnode: rhashtable member
>    * @vid: VLAN id
>    * @flags: bridge vlan flags
>    * @priv_flags: private (in-kernel) bridge vlan flags
> @@ -196,6 +197,7 @@ enum {
>    * @refcnt: if MASTER flag set, this is bumped for each port referencing it
>    * @brvlan: if MASTER flag unset, this points to the global per-VLAN context
>    *          for this VLAN entry
> + * @tinfo: bridge tunnel info
>    * @br_mcast_ctx: if MASTER flag set, this is the global vlan multicast context
>    * @port_mcast_ctx: if MASTER flag unset, this is the per-port/vlan multicast
>    *                  context


