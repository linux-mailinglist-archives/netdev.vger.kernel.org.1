Return-Path: <netdev+bounces-151439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB1B9EF117
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E2717781E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F8B2288E1;
	Thu, 12 Dec 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pRcmFPlO"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473F4218592
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020051; cv=none; b=bupjDaFltuqMFmvv7CY+oE3nhQK0JLbJQz8osWSXmeM+lkLqxh/GdDySLY7vZW7Q9IyT78vHo1re4Q2yjkpa1PacyiYhukKy54WtKr1FnDmOZ+T3VUwKm+vnCCdrpG9D+WgdflN7oksR9YBM7SOykTywm+JTG9JHfYMYp6ZSTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020051; c=relaxed/simple;
	bh=eR0ZbRH6HLHvoah/9oCZXptW0VitzX95uvgWjSzU06w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj0PkLlH09O4CWBq2WxwZMtGpktxI/zyY/Eurl+ZPilXxXPX5jPd9v2JXg6zY76lspIYVBFfaIZ4EHZirz084kxSsn5VLcqefjqwIsZ65eq+3JE+R9uISiE3VZFpjUB7TasMksOk2Ed6321MDOYQ6GZ6yK/h3WTz5DHoHxdJF4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pRcmFPlO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6018013802EA;
	Thu, 12 Dec 2024 11:14:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 12 Dec 2024 11:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734020047; x=1734106447; bh=WeclAqIy9sf4mR+Xqw9pFD+R2mGlqRZf/7c
	rEsdQr7o=; b=pRcmFPlOI8gSCYtNlYFkUlXDwtD9Qn+q7AKlXIotsyuI9CU41F+
	yrobB5mDj5OZmbd01WFmottOsHTBY5rNpxy2IbFoIs8HA34ROBEAbLFD/LbeGpUg
	P+cIIwIV48YtWCLzo8zm64mP6u9U+J8ttkTagUkVnQZtUM3UzAlmBSMJ0pgtiiF6
	oFAdkRtiRZ7HyRYXjCTNw1CmGx6f9zwVVyUrk30P2zINdAsPIGe/HoprGSVXyhap
	lNRM0a0QUkfS9q/bFbXC5Zp/Er8wBJBHMNGloiRMGSmnSRXG4vfP9h4JJIOrVJH2
	3FGPqeYCP8U6kkCdFobd/E7Cz/YHQ0MJVVA==
X-ME-Sender: <xms:zgtbZzj7pxHbcTY_8qJXuRbBEQrF5OB17M8HuMe4r84Ia-R6ps17Zg>
    <xme:zgtbZwBj0N-GG4weQ-Qno-JvMy3XU_e5349Qwr3Jjx-rqj5xr6fJC6wesTrdzd13O
    GVvulOiFvOOVlk>
X-ME-Received: <xmr:zgtbZzF_DMCpH2PWSNNy9WlsA8SUTQ2vAUNpTfQJaQ3iwhmQG069GXQSrkIrt95ZepA0xc6CsQhVIG3lEYA8BMwjT9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpefhffejgefhjeehjeevheevhfetveevfefgueduueei
    vdeijeeihfegheeljefgueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehi
    ughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehrrhgvnhguvggtsehrvgguhhgrthdrtghomhdprhgtphhtthhopehr
    rgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtoheprhhoohhprgesnhhvih
    guihgrrdgtohhmpdhrtghpthhtohepsghrihgughgvsehlihhsthhsrdhlihhnuhigrdgu
    vghvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhi
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:zgtbZwSapwMLePUOQR2dMfggzSVFw1uM90_q9WjyORUqJ0_bx15Meg>
    <xmx:zgtbZwzwr9ILgIpllFtM8bYiuvpjDgW_j8DcTQNOSEgLgNeRVA-w2A>
    <xmx:zgtbZ26Zivoj0GzAWpFs5GTMCYUPmgutHbQgGrlNR-f6KygdhRwHlg>
    <xmx:zgtbZ1y54XoL5gEqZR17ATEivbvtjSSM1idpWej6IakylyfIon9HVQ>
    <xmx:zwtbZ8dDp6OTbIx-MhDwo4PRSEkhCJiWvyRQmabzUFyVjo-T6kcGNMm5>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 11:14:05 -0500 (EST)
Date: Thu, 12 Dec 2024 18:14:02 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Radu Rendec <rrendec@redhat.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next] net/bridge: Add skb drop reasons to the most
 common drop points
Message-ID: <Z1sLyqZQCjbcCOde@shredder>
References: <20241208221805.1543107-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208221805.1543107-1-rrendec@redhat.com>

On Sun, Dec 08, 2024 at 05:18:05PM -0500, Radu Rendec wrote:
> The bridge input code may drop frames for various reasons and at various
> points in the ingress handling logic. Currently kfree_skb() is used
> everywhere, and therefore no drop reason is specified. Add drop reasons
> to the most common drop points.
> 
> The purpose of this patch is to address the most common drop points on
> the bridge ingress path. It does not exhaustively add drop reasons to
> the entire bridge code. The intention here is to incrementally add drop
> reasons to the rest of the bridge code in follow up patches.
> 
> Most of the skb drop points that are addressed in this patch can be
> easily tested by sending crafted packets. The diagram below shows a
> simple test configuration, and some examples using `packit`(*) are
> also included. The bridge is set up with STP disabled.
> (*) https://github.com/resurrecting-open-source-projects/packit
> 
> The following changes were *not* tested:
> * SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT in br_multicast_flood(). I could
>   not find an easy way to make a crafted packet get there.
> * SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD in br_handle_frame_finish()
>   when the port state is BR_STATE_DISABLED, because in that case the
>   frame is already dropped in the switch/case block at the end of
>   br_handle_frame().
> 
>     +---+---+
>     |  br0  |
>     +---+---+
>         |
>     +---+---+  veth pair  +-------+
>     | veth0 +-------------+ xeth0 |
>     +-------+             +-------+
> 
> SKB_DROP_REASON_MAC_INVALID_SOURCE - br_handle_frame()
> packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
>   -e 01:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
>   -p '0x de ad be ef' -i xeth0
> 
> SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL - br_handle_frame()
> packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
>   -e 02:22:33:44:55:66 -E 01:80:c2:00:00:01 -c 1 \
>   -p '0x de ad be ef' -i xeth0
> 
> SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD - br_handle_frame()
> bridge link set dev veth0 state 0 # disabled
> packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
>   -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
>   -p '0x de ad be ef' -i xeth0
> 
> SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD - br_handle_frame_finish()
> bridge link set dev veth0 state 2 # learning
> packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
>   -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
>   -p '0x de ad be ef' -i xeth0
> 
> SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT - br_flood()
> packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
>   -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
>   -p '0x de ad be ef' -i xeth0
> 
> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> ---
>  include/net/dropreason-core.h | 18 ++++++++++++++++++
>  net/bridge/br_forward.c       |  4 ++--
>  net/bridge/br_input.c         | 24 +++++++++++++++---------
>  3 files changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index c29282fabae6..1f2ae5b387c1 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -108,6 +108,9 @@
>  	FN(TUNNEL_TXINFO)		\
>  	FN(LOCAL_MAC)			\
>  	FN(ARP_PVLAN_DISABLE)		\
> +	FN(MAC_IEEE_MAC_CONTROL)	\
> +	FN(BRIDGE_INGRESS_PORT_NFWD)	\
> +	FN(BRIDGE_NO_EGRESS_PORT)	\
>  	FNe(MAX)
>  
>  /**
> @@ -502,6 +505,21 @@ enum skb_drop_reason {
>  	 * enabled.
>  	 */
>  	SKB_DROP_REASON_ARP_PVLAN_DISABLE,
> +	/**
> +	 * @SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL: the destination MAC address
> +	 * is an IEEE MAC Control address.
> +	 */

IMO, dropping pause frames is not among "the most common drop points".
Are you planning on reusing this reason in other modules? If not, then I
prefer removing it. My understanding is that we should not try to
document every obscure drop with these reasons.

> +	SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL,
> +	/**
> +	 * @SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD: the STP state of the
> +	 * ingress bridge port does not allow frames to be forwarded.
> +	 */
> +	SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD,

Are you intending on reusing this for other ingress drops (e.g., VLAN,
locked port) or is this specific to ingress STP filtering? I think it
will be useful to distinguish between the different cases, so I suggest
renaming this reason to make it clear it is about ingress STP.

> +	/**
> +	 * SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT: no eligible egress port was
> +	 * found while attempting to flood the frame.
> +	 */
> +	SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT,
>  	/**
>  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>  	 * shouldn't be used as a real 'reason' - only for tracing code gen
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index e19b583ff2c6..e33e2f4fc3d9 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -249,7 +249,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
>  
>  out:
>  	if (!local_rcv)
> -		kfree_skb(skb);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);
>  }
>  
>  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> @@ -349,6 +349,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
>  
>  out:
>  	if (!local_rcv)
> -		kfree_skb(skb);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);
>  }
>  #endif
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index ceaa5a89b947..fc00e172e1e1 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -96,8 +96,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  	if (br_mst_is_enabled(br)) {
>  		state = BR_STATE_FORWARDING;
>  	} else {
> -		if (p->state == BR_STATE_DISABLED)
> -			goto drop;
> +		if (p->state == BR_STATE_DISABLED) {
> +			kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> +			return 0;
> +		}
>  
>  		state = p->state;
>  	}
> @@ -155,8 +157,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  		}
>  	}
>  
> -	if (state == BR_STATE_LEARNING)
> -		goto drop;
> +	if (state == BR_STATE_LEARNING) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> +		return 0;
> +	}
>  
>  	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
>  	BR_INPUT_SKB_CB(skb)->src_port_isolated = !!(p->flags & BR_ISOLATED);
> @@ -331,8 +335,10 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
>  	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
>  		return RX_HANDLER_PASS;
>  
> -	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> -		goto drop;
> +	if (!is_valid_ether_addr(eth_hdr(skb)->h_source)) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_MAC_INVALID_SOURCE);
> +		return RX_HANDLER_CONSUMED;
> +	}
>  
>  	skb = skb_share_check(skb, GFP_ATOMIC);
>  	if (!skb)
> @@ -374,7 +380,8 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
>  			return RX_HANDLER_PASS;
>  
>  		case 0x01:	/* IEEE MAC (Pause) */
> -			goto drop;
> +			kfree_skb_reason(skb, SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL);
> +			return RX_HANDLER_CONSUMED;
>  
>  		case 0x0E:	/* 802.1AB LLDP */
>  			fwd_mask |= p->br->group_fwd_mask;
> @@ -423,8 +430,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
>  
>  		return nf_hook_bridge_pre(skb, pskb);
>  	default:
> -drop:
> -		kfree_skb(skb);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
>  	}
>  	return RX_HANDLER_CONSUMED;
>  }
> -- 
> 2.47.1
> 
> 

