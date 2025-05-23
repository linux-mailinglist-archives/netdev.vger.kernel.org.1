Return-Path: <netdev+bounces-193017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D89C8AC234C
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544E71BC080B
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD0B18641;
	Fri, 23 May 2025 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXoqLBym"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110579F5;
	Fri, 23 May 2025 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005337; cv=none; b=ONXZ5kMRzPimxsZmWC18JIzOLjr96TjxEEyPtQ2EYpn8p+L5n6Q6A4uHhj3JIKegLoUEOGws/tePeWXuE8LQBQPSaCSfjmqSIZnEFkeTRa7I8ujDZk9oEoIMjMpw+2tbXvBaM+rlzA/Z9ZDXM7WOj0/pbIWpcWXTjBBl62AAclE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005337; c=relaxed/simple;
	bh=SzcwOE3E23QUT821w3cP2dTgX+YTN9bdkHDtA1NsdHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsBYmrgnvU1iBidfRUUkmm1bMWBEIhhOsHzcMVB5Tf89DqqaRO5HnRDJMsSFUGLBDvwvrcBSzuVy1ir72+LSDIcpUEird6yQ5JUGTzwZKQk4XB/ECAFvDphk8nhPpHhSvZfUMDO+305xdIiN0PIWRPWsWWP/TMUGZFVhkfA6oWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXoqLBym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023F4C4CEE9;
	Fri, 23 May 2025 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748005335;
	bh=SzcwOE3E23QUT821w3cP2dTgX+YTN9bdkHDtA1NsdHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXoqLBympPBWc+7Bj2PHeggW4OphEg3rXoyHRobwvG15KY0qdTxB8xKiodXg8Pr73
	 Vba5DMZf+xxZA1n1IY966z3m9NgB4M0LHoDQ3Yvmpunlesm3DeIaqpvZuzbwT91KLO
	 F+72Gbkyg7N8gTfFwpfasY1vVo5Z72BGiw26J3/ukFfsUYLJVUaVSyZb5ChWCDasOK
	 zU9vfVPJxufsUkZpsMd6cy8E+aF5TfizoEAhbW2dIdVHh4qLwZ5HtVioS35SoGvrY/
	 YE7kojK5tI64tyQcpSWgU5ZDZSVw96UEwC5NdEtD7/8XQcM+Uj+b2pCWX9NZOS/BzX
	 LmXeu6azfjJkw==
Date: Fri, 23 May 2025 14:02:08 +0100
From: Simon Horman <horms@kernel.org>
To: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	openwrt-devel@lists.openwrt.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Ivan Vecera <ivecera@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Jan Hoffmann <jan.christian.hoffmann@gmail.com>,
	Birger Koblitz <git@birger-koblitz.de>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next 3/5] net: bridge: mcast: check if snooping is
 enabled for active state
Message-ID: <20250523130208.GS365796@horms.kernel.org>
References: <20250522195952.29265-1-linus.luessing@c0d3.blue>
 <20250522195952.29265-4-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250522195952.29265-4-linus.luessing@c0d3.blue>

On Thu, May 22, 2025 at 09:17:05PM +0200, Linus Lüssing wrote:
> To be able to use the upcoming SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE
> as a potential replacement for SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED
> also check and toggle the active state if multicast snooping is enabled
> or disabled. So that MC_ACTIVE not only checks the querier state, but
> also if multicast snooping is enabled in general.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  include/uapi/linux/if_link.h |  6 ++++--
>  net/bridge/br_multicast.c    | 35 +++++++++++++++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 41f6c461ab32..479d039477cb 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -746,12 +746,14 @@ enum in6_addr_gen_mode {
>   * @IFLA_BR_MCAST_ACTIVE_V4
>   *   Bridge IPv4 mcast active state, read only.
>   *
> - *   1 if an IGMP querier is present, 0 otherwise.
> + *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled and an IGMP querier is present,
> + *   0 otherwise.
>   *
>   * @IFLA_BR_MCAST_ACTIVE_V6
>   *   Bridge IPv4 mcast active state, read only.
>   *
> - *   1 if an MLD querier is present, 0 otherwise.
> + *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled and an MLD querier is present,
> + *   0 otherwise.
>   */
>  enum {
>  	IFLA_BR_UNSPEC,
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index b66d2173e321..0bbaa21c1479 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1150,6 +1150,7 @@ static int br_ip6_multicast_check_active(struct net_bridge_mcast *brmctx,
>   *
>   * The multicast active state is set, per protocol family, if:
>   *
> + * - multicast snooping is enabled
>   * - an IGMP/MLD querier is present
>   * - for own IPv6 MLD querier: an IPv6 address is configured on the bridge
>   *
> @@ -1169,6 +1170,13 @@ static int __br_multicast_update_active(struct net_bridge_mcast *brmctx,
>  
>  	lockdep_assert_held_once(&brmctx->br->multicast_lock);
>  
> +	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
> +		force_inactive = true;
> +
> +	if (br_opt_get(brmctx->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
> +	    br_multicast_ctx_vlan_disabled(brmctx))
> +		force_inactive = true;
> +
>  	ip4_active = !force_inactive;
>  	ip6_active = !force_inactive;
>  	ip4_changed = br_ip4_multicast_check_active(brmctx, &ip4_active);
> @@ -1396,6 +1404,22 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
>  	return NULL;
>  }
>  
> +static int br_multicast_toggle_enabled(struct net_bridge *br, bool on,
> +				       struct netlink_ext_ack *extack)
> +{
> +	int err, old;
> +
> +	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, on);
> +
> +	err = br_multicast_update_active(&br->multicast_ctx, extack);
> +	if (err && err != -EOPNOTSUPP) {
> +		br_opt_toggle(br, BROPT_MULTICAST_ENABLED, old);

Hi Linus,

Old appears to be used uninitialised here.

Flagged by allmodconfig builds on x86_64 with clang-20.1.4.

...

