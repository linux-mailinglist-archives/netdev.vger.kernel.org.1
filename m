Return-Path: <netdev+bounces-101128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33618FD6C4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8304C1F27E88
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBCE15443B;
	Wed,  5 Jun 2024 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaqxZLI+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E36154436;
	Wed,  5 Jun 2024 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617083; cv=none; b=T6UM2mD1+W+RSzgGN3n1UG0sNN2GODdBg1oM9IRmSTvPZGtOWpDM/3mUSeYcmX4bluBGuoIJz9xwGiMpzSdyg1IJ/nUFsFauqu/ik0IJxnVUM6q1pLgMTkPnlUqm/3uq/KkFTutVHAH7+zl4FVrhUW89iGiF6YlNLSv5A4FCJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617083; c=relaxed/simple;
	bh=41iLXtRakTOZqv2vBnh0hQcqUw/AeJryNuhiaoedJ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iONyMQu8JOldhXx4b2TnNTAvSLBYeWxDPKOkvEnJBaavH5vw3jwTGw12vvt0NYZKj4nsz7lEYKCqbPD5eQHy6q0Pa6YaXPiLfCYkMR1ueV05C5dZFOsUOFMmXihiO3u5NpZ1rF+scEvP6DYuZOS0x8g8IJqWOZisskUVTQRhubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaqxZLI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B281C2BD11;
	Wed,  5 Jun 2024 19:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717617083;
	bh=41iLXtRakTOZqv2vBnh0hQcqUw/AeJryNuhiaoedJ2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaqxZLI+2cB24EwHJTLJbXiihQiwYcxhN5QYLFPVeXsxCPAh7xv185XcWVOUoYHax
	 3UT5mJDBVRO44xUCjiPIaPpugGOIGLEFLR0do+4FaFIDOD2o+MaRGodvBdq95hZ+dE
	 9Yg3yRVrd3f+M3grquR+Awyd0QiZx2y+3+Lq0xRUVodMS87bc5khz28kk/FUUPwlD1
	 iiSIdvgCB1IoZcW3VrmEK3EvAE6hBTFSNtUHZNdZwZ2Y6p5yABoeRDAehXVnMgaiLG
	 dZkl04UBnywnZyzoo7IsOBis0HqVhb/s8vgwhaIw1YMemDBfSdFGVByAd4hh1dI8rZ
	 DireAE1JRzXkw==
Date: Wed, 5 Jun 2024 20:51:17 +0100
From: Simon Horman <horms@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	i.maximets@ovn.org, dev@openvswitch.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
Message-ID: <20240605195117.GY791188@kernel.org>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-6-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603185647.2310748-6-amorenoz@redhat.com>

On Mon, Jun 03, 2024 at 08:56:39PM +0200, Adrian Moreno wrote:
> Add support for a new action: emit_sample.
> 
> This action accepts a u32 group id and a variable-length cookie and uses
> the psample multicast group to make the packet available for
> observability.
> 
> The maximum length of the user-defined cookie is set to 16, same as
> tc_cookie, to discourage using cookies that will not be offloadable.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Hi Adrian,

Some minor nits from my side.

...

> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> index efc82c318fa2..a0e9dde0584a 100644
> --- a/include/uapi/linux/openvswitch.h
> +++ b/include/uapi/linux/openvswitch.h
> @@ -914,6 +914,30 @@ struct check_pkt_len_arg {
>  };
>  #endif
>  
> +#define OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE 16
> +/**
> + * enum ovs_emit_sample_attr - Attributes for %OVS_ACTION_ATTR_EMIT_SAMPLE
> + * action.
> + *
> + * @OVS_EMIT_SAMPLE_ATTR_GROUP: 32-bit number to identify the source of the
> + * sample.
> + * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cookie that contains
> + * user-defined metadata. The maximum length is 16 bytes.
> + *
> + * Sends the packet to the psample multicast group with the specified group and
> + * cookie. It is possible to combine this action with the
> + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packet being emitted.
> + */
> +enum ovs_emit_sample_attr {
> +	OVS_EMIT_SAMPLE_ATTR_UNPSEC,
> +	OVS_EMIT_SAMPLE_ATTR_GROUP,	/* u32 number. */
> +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> +	__OVS_EMIT_SAMPLE_ATTR_MAX
> +};
> +
> +#define OVS_EMIT_SAMPLE_ATTR_MAX (__OVS_EMIT_SAMPLE_ATTR_MAX - 1)
> +
> +

nit: One blank line is enough.

     Flagged by checkpatch.pl

>  /**
>   * enum ovs_action_attr - Action types.
>   *
> @@ -1004,6 +1028,7 @@ enum ovs_action_attr {
>  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
>  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
>  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
> +	OVS_ACTION_ATTR_EMIT_SAMPLE,  /* Nested OVS_EMIT_SAMPLE_ATTR_*. */

nit: Please add OVS_ACTION_ATTR_EMIT_SAMPLE to the Kenrel doc
     for this structure.

>  
>  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
>  				       * from userspace. */

...

