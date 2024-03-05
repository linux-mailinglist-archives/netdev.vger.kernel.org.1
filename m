Return-Path: <netdev+bounces-77530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E709872200
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0414B20931
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9858595C;
	Tue,  5 Mar 2024 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4Rb2FSA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776E6127
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650401; cv=none; b=aaK2brJwTAvwrU8TQ/q4zNklrhR4OH0utNOPC1tA4HyJIO1nZf6qdOpn4BmonZpGXjvHFxlKspWKMw0LzGOkYTB006RX/FfwgQlc1ksG+VGyx7rJ5c8xI6VzREjcZOhChoGWvaXCNwRBAXnt6tbeA6LuefmxuudGFDinnWuBT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650401; c=relaxed/simple;
	bh=JjO9KmthjmHOFgWIhmiSccjUb7+ZjpgggJEaUqJKQsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUVQiSVEdbYvSQPc4KkVljzTBqtFWS0oy/hoAT4uQaRf9kLPub8J14RGdf/40yjMbfOf/qtFoVZrI15bi22xJJoJk4ZvUgJL8BWhZyZ78zlJ9VMs43D4flyGpOE5p8kNbuLCKIAhpb+y6834L/acc9oqyVBaYBb+5eNZpxeSfJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4Rb2FSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7492BC433C7;
	Tue,  5 Mar 2024 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709650400;
	bh=JjO9KmthjmHOFgWIhmiSccjUb7+ZjpgggJEaUqJKQsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4Rb2FSA2N2OMn2dTxJ0oy0y/zNnRBZxuTJ2t+oRW1DVyP5OV/7nZ3gB3ekQF5M9F
	 UUHmdRNVp3x2Fgew6ku84cdj1siVJAK7u5A7yKDfbRow6Eu3MTfs0d8+bqHo75jRm/
	 KKmZsKwcolqipHdWuv8crm6zvakUlqQiMRaeNKG5U7talMrrH1NfYX0Swr8XBcm5LU
	 m+d15X9QK2MHFXxtXzfDQNz0zjgEamolXNz+XfWY7TmJ3y6RICxX+y+2HZq9VZktnG
	 XuOpZEvW9lwg86H2U0ZsB2WfP0bxzDuIsnkzp/qknPgAOVe3+5+iIDkcyVj/XyOdSm
	 82FGqHXpLAUQw==
Date: Tue, 5 Mar 2024 14:51:47 +0000
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 05/22] ovpn: implement interface
 creation/destruction via netlink
Message-ID: <20240305145147.GI2357@kernel.org>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-6-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-6-antonio@openvpn.net>

On Mon, Mar 04, 2024 at 04:08:56PM +0100, Antonio Quartulli wrote:
> Allow userspace to create and destroy an interface using netlink
> commands.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/ovpn/netlink.c | 50 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 2e855ce145e7..02b41034f615 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c
> @@ -154,7 +154,57 @@ static void ovpn_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb
>  		dev_put(ovpn->dev);
>  }
>  
> +static int ovpn_nl_new_iface(struct sk_buff *skb, struct genl_info *info)
> +{
> +	enum ovpn_mode mode = OVPN_MODE_P2P;
> +	struct net_device *dev;
> +	char *ifname;
> +	int ret;
> +
> +	if (!info->attrs[OVPN_A_IFNAME])
> +		return -EINVAL;
> +
> +	ifname = nla_data(info->attrs[OVPN_A_IFNAME]);
> +
> +	if (info->attrs[OVPN_A_MODE]) {
> +		mode = nla_get_u8(info->attrs[OVPN_A_MODE]);
> +		netdev_dbg(dev, "%s: setting device (%s) mode: %u\n", __func__, ifname,
> +			   mode);

nit: dev is uninitialised here.

> +	}
> +
> +	ret = ovpn_iface_create(ifname, mode, genl_info_net(info));
> +	if (ret < 0)
> +		netdev_dbg(dev, "error while creating interface %s: %d\n", ifname, ret);

And here.

Flagged by Smatch.

> +
> +	return ret;
> +}

...

