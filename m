Return-Path: <netdev+bounces-145649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C2C9D0460
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 15:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F4F281C65
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DA61D27B4;
	Sun, 17 Nov 2024 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FThDwYR5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829F21898FC
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731855443; cv=none; b=Mcavyo/HTfDIRPbU4W7CAjdqzxZgGtEjearh0qttjnk0EdWnaI0pFYOtRiP+PB7QMZDvarkmx6Ynd59ATBucQMZRoWBjIjvJ/CnWmKkFwFAn+4MPVLremY93mxzpng8QbCoxgTazShPceCK/rvYUlFY1eY0VuOrxL7B/OJwD/Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731855443; c=relaxed/simple;
	bh=snfkYPaWe+CfQBHUxNee2e66M+fgKK/+EG/1DfWK6Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tImxKbrV1XDKmmEsHUGHWGCZw836jOIwXbR9dfJ2yUroPklG9Z40HHdKsXoFD2Xw9Nf4bECY5JYtej0I+3vqUNzOz+FRE9nWW9nhO6JSZ6rRIoJR29YP7EUtBtvX6mnUjj2mWiPaEZJ4UPywPq6B5kBuS2OrB/1iAXA4PLONVz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FThDwYR5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4319399a411so30449985e9.2
        for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 06:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1731855436; x=1732460236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7/xWOIYpQ0Ns3fXoTzKaWNFpw/mbzXLlGRov0L+NLs=;
        b=FThDwYR5xBaWpCRzuw1JzF58OzEpSvW920OYV4ztYQc0yJbrOzBQyzYEBu+8gQYO0u
         mU6vsoUH7xMK/I4ig+Vh8B5O6uH117xom54gJP5nVTfP5eHDG6qVmMvspZ0N13vSmd4B
         pAD5Rnof0C/gzmmILbuUoBhja1wbx3TayIni8RXbkX66Ymj7ML72y/HaYS5DAWhun106
         3+zcNkMWBeFNcq3+IdSvYVZp0l7sKCJqlFoOmHWjHZmD/qn1nehgWXWRok+R8YcklJFS
         98+wqGOxhR3Pxvk3yw6CWdpUoCqCQE+qSgW5oMSmYg54GPwG8NNKt45sa8YQNwXa9DnE
         FF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731855436; x=1732460236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7/xWOIYpQ0Ns3fXoTzKaWNFpw/mbzXLlGRov0L+NLs=;
        b=uBL9cXYdKVozOrbzgVvUcGyHkrMFkgGt42cRdoTQIXGqA0LSRN8f3wpl8Nh0mgRXdW
         iPU1RR5s9udexpMsnFBmmohRRsGaVZD+W5ngiopl4DvZ9vP1NMVU7HroKPpQ1XsCPp4a
         81QJi1KIfw1C8V4Bewhz7WFh/kIrgUGcoOF0yJiYUXiiegd8KgcA9l2VJovomhnormph
         AeNwec2FA8KoBXnyASwpOnZI8MVf9I6VycgfTWXyzPj0hZL7WS5DyG4+5KqsJQiwrvn2
         I08WbbDyjo50da782irVZbqzCJKhaR1o6qYxukJKMPLZowklcvuMOo+wo1Pyq3cSYS9A
         LcXw==
X-Forwarded-Encrypted: i=1; AJvYcCUlK4GWsBCQNnGMXxHtWnYx9OBHQbQJu9DHAjQxSqQNe4KfRZTjn0PIrpLGZ1gHEPzv/YJd4dA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UWuuZen3gFLT44dIZWFGb2rEwn5m7+vfGy45b6N+4u8OTswp
	p/ZJCymWc0jxTrvyXU8XAjK1bkuqcxNckX8wjefENCcFa+V9BsnD+sxwT+h2xUs=
X-Google-Smtp-Source: AGHT+IGCjdwuIyZspgDexqMblh33V2tpjd8JDtgqU7iYmmfnkIDocwehWJ6mZkUcolqxoDx0WY9Z+w==
X-Received: by 2002:a05:6000:1fad:b0:382:38e6:1eb3 with SMTP id ffacd0b85a97d-38238e6257amr3422438f8f.30.1731855436431;
        Sun, 17 Nov 2024 06:57:16 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265907sm127578105e9.13.2024.11.17.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 06:57:14 -0800 (PST)
Date: Sun, 17 Nov 2024 15:57:10 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V2 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <ZzoERmGLfn2h3L_D@nanopsycho.orion>
References: <20241114220937.719507-1-tariqt@nvidia.com>
 <20241114220937.719507-4-tariqt@nvidia.com>
 <Zzb9m-nyVoHLtJ75@nanopsycho.orion>
 <91609e70-110e-44b6-a45d-177f86ab7c99@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91609e70-110e-44b6-a45d-177f86ab7c99@nvidia.com>

Sun, Nov 17, 2024 at 03:33:06PM CET, cjubran@nvidia.com wrote:
>
>
>On 15/11/2024 9:51, Jiri Pirko wrote:
>> Thu, Nov 14, 2024 at 11:09:32PM CET, tariqt@nvidia.com wrote:
>> > From: Carolina Jubran <cjubran@nvidia.com>
>> > 
>> > Introduce support for specifying bandwidth proportions between traffic
>> > classes (TC) in the devlink-rate API. This new option allows users to
>> > allocate bandwidth across multiple traffic classes in a single command.
>> > 
>> > This feature provides a more granular control over traffic management,
>> > especially for scenarios requiring Enhanced Transmission Selection.
>> > 
>> > Users can now define a specific bandwidth share for each traffic class,
>> > such as allocating 20% for TC0 (TCP/UDP) and 80% for TC5 (RoCE).
>> > 
>> > Example:
>> > DEV=pci/0000:08:00.0
>> > 
>> > $ devlink port function rate add $DEV/vfs_group tx_share 10Gbit \
>> >   tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0
>> > 
>> > $ devlink port function rate set $DEV/vfs_group \
>> >   tc-bw 0:20 1:0 2:0 3:0 4:0 5:10 6:60 7:0
>> > 
>> > Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> > Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> > ---
>> > Documentation/netlink/specs/devlink.yaml | 22 ++++++++
>> > include/net/devlink.h                    |  7 +++
>> > include/uapi/linux/devlink.h             |  4 ++
>> > net/devlink/netlink_gen.c                | 15 +++--
>> > net/devlink/netlink_gen.h                |  1 +
>> > net/devlink/rate.c                       | 71 +++++++++++++++++++++++-
>> > 6 files changed, 113 insertions(+), 7 deletions(-)
>> > 
>> > diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>> > index 09fbb4c03fc8..68211b8218fd 100644
>> > --- a/Documentation/netlink/specs/devlink.yaml
>> > +++ b/Documentation/netlink/specs/devlink.yaml
>> > @@ -817,6 +817,16 @@ attribute-sets:
>> >        -
>> >          name: rate-tx-weight
>> >          type: u32
>> > +      -
>> > +        name: rate-tc-index
>> > +        type: u8
>> > +
>> > +      - name: rate-bw
>> 
>> This is bandwidth of tc. The name therefore should be "rate-tc-bw".
>> Could you also document units of this attr value?
>> 
>> 
>
>I will rename it to rate-tc-bw and update the documentation to include the
>valid range (0-100).

So is it percent? I asked about the units.


>
>> > +        type: u32
>> > +      -
>> > +        name: rate-tc-bw
>> > +        type: nest
>> > +        nested-attributes: dl-rate-tc-bw
>> >        -
>> >          name: region-direct
>> >          type: flag
>> > @@ -1225,6 +1235,16 @@ attribute-sets:
>> >        -
>> >          name: flash
>> >          type: flag
>> > +  -
>> > +    name: dl-rate-tc-bw
>> > +    subset-of: devlink
>> > +    attributes:
>> > +      -
>> > +        name: rate-tc-index
>> > +        type: u8
>> > +      -
>> > +        name: rate-bw
>> > +        type: u32
>> > 
>> > operations:
>> >    enum-model: directional
>> > @@ -2148,6 +2168,7 @@ operations:
>> >              - rate-tx-max
>> >              - rate-tx-priority
>> >              - rate-tx-weight
>> > +            - rate-tc-bw
>> >              - rate-parent-node-name
>> > 
>> >      -
>> > @@ -2168,6 +2189,7 @@ operations:
>> >              - rate-tx-max
>> >              - rate-tx-priority
>> >              - rate-tx-weight
>> > +            - rate-tc-bw
>> >              - rate-parent-node-name
>> > 
>> >      -
>> > diff --git a/include/net/devlink.h b/include/net/devlink.h
>> > index fbb9a2668e24..277b826cdd60 100644
>> > --- a/include/net/devlink.h
>> > +++ b/include/net/devlink.h
>> > @@ -20,6 +20,7 @@
>> > #include <uapi/linux/devlink.h>
>> > #include <linux/xarray.h>
>> > #include <linux/firmware.h>
>> > +#include <linux/dcbnl.h>
>> > 
>> > struct devlink;
>> > struct devlink_linecard;
>> > @@ -117,6 +118,8 @@ struct devlink_rate {
>> > 
>> > 	u32 tx_priority;
>> > 	u32 tx_weight;
>> > +
>> > +	u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
>> > };
>> > 
>> > struct devlink_port {
>> > @@ -1469,6 +1472,8 @@ struct devlink_ops {
>> > 					 u32 tx_priority, struct netlink_ext_ack *extack);
>> > 	int (*rate_leaf_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
>> > 				       u32 tx_weight, struct netlink_ext_ack *extack);
>> > +	int (*rate_leaf_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
>> > +				   u32 *tc_bw, struct netlink_ext_ack *extack);
>> > 	int (*rate_node_tx_share_set)(struct devlink_rate *devlink_rate, void *priv,
>> > 				      u64 tx_share, struct netlink_ext_ack *extack);
>> > 	int (*rate_node_tx_max_set)(struct devlink_rate *devlink_rate, void *priv,
>> > @@ -1477,6 +1482,8 @@ struct devlink_ops {
>> > 					 u32 tx_priority, struct netlink_ext_ack *extack);
>> > 	int (*rate_node_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
>> > 				       u32 tx_weight, struct netlink_ext_ack *extack);
>> > +	int (*rate_node_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
>> > +				   u32 *tc_bw, struct netlink_ext_ack *extack);
>> > 	int (*rate_node_new)(struct devlink_rate *rate_node, void **priv,
>> > 			     struct netlink_ext_ack *extack);
>> > 	int (*rate_node_del)(struct devlink_rate *rate_node, void *priv,
>> > diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>> > index 9401aa343673..a66217808dd9 100644
>> > --- a/include/uapi/linux/devlink.h
>> > +++ b/include/uapi/linux/devlink.h
>> > @@ -614,6 +614,10 @@ enum devlink_attr {
>> > 
>> > 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
>> > 
>> > +	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
>> > +	DEVLINK_ATTR_RATE_BW,			/* u32 */
>> > +	DEVLINK_ATTR_RATE_TC_BW,		/* nested */
>> > +
>> > 	/* Add new attributes above here, update the spec in
>> > 	 * Documentation/netlink/specs/devlink.yaml and re-generate
>> > 	 * net/devlink/netlink_gen.c.
>> > diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
>> > index f9786d51f68f..fac062ede7a4 100644
>> > --- a/net/devlink/netlink_gen.c
>> > +++ b/net/devlink/netlink_gen.c
>> > @@ -18,6 +18,11 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
>> > 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
>> > };
>> > 
>> > +const struct nla_policy devlink_dl_rate_tc_bw_nl_policy[DEVLINK_ATTR_RATE_BW + 1] = {
>> > +	[DEVLINK_ATTR_RATE_TC_INDEX] = { .type = NLA_U8, },
>> > +	[DEVLINK_ATTR_RATE_BW] = { .type = NLA_U32, },
>> > +};
>> > +
>> > const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
>> > 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .type = NLA_FLAG, },
>> > };
>> > @@ -496,7 +501,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
>> > };
>> > 
>> > /* DEVLINK_CMD_RATE_SET - do */
>> > -static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
>> > +static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
>> > 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>> > 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>> > 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
>> > @@ -504,11 +509,12 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
>> > 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
>> > 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
>> > 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
>> > +	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_nl_policy),
>> > 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
>> > };
>> > 
>> > /* DEVLINK_CMD_RATE_NEW - do */
>> > -static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
>> > +static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
>> > 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>> > 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>> > 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
>> > @@ -516,6 +522,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
>> > 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
>> > 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
>> > 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
>> > +	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_nl_policy),
>> > 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
>> > };
>> > 
>> > @@ -1164,7 +1171,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
>> > 		.doit		= devlink_nl_rate_set_doit,
>> > 		.post_doit	= devlink_nl_post_doit,
>> > 		.policy		= devlink_rate_set_nl_policy,
>> > -		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
>> > +		.maxattr	= DEVLINK_ATTR_RATE_TC_BW,
>> > 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> > 	},
>> > 	{
>> > @@ -1174,7 +1181,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
>> > 		.doit		= devlink_nl_rate_new_doit,
>> > 		.post_doit	= devlink_nl_post_doit,
>> > 		.policy		= devlink_rate_new_nl_policy,
>> > -		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
>> > +		.maxattr	= DEVLINK_ATTR_RATE_TC_BW,
>> > 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> > 	},
>> > 	{
>> > diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
>> > index 8f2bd50ddf5e..df37c3ef3113 100644
>> > --- a/net/devlink/netlink_gen.h
>> > +++ b/net/devlink/netlink_gen.h
>> > @@ -13,6 +13,7 @@
>> > 
>> > /* Common nested types */
>> > extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
>> > +extern const struct nla_policy devlink_dl_rate_tc_bw_nl_policy[DEVLINK_ATTR_RATE_BW + 1];
>> > extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
>> > 
>> > /* Ops table for devlink */
>> > diff --git a/net/devlink/rate.c b/net/devlink/rate.c
>> > index 8828ffaf6cbc..dbf1d552fae2 100644
>> > --- a/net/devlink/rate.c
>> > +++ b/net/devlink/rate.c
>> > @@ -86,7 +86,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
>> > 				int flags, struct netlink_ext_ack *extack)
>> > {
>> > 	struct devlink *devlink = devlink_rate->devlink;
>> > +	struct nlattr *nla_tc_bw;
>> > 	void *hdr;
>> > +	int i;
>> > 
>> > 	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
>> > 	if (!hdr)
>> > @@ -124,10 +126,29 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
>> > 			devlink_rate->tx_weight))
>> > 		goto nla_put_failure;
>> > 
>> > -	if (devlink_rate->parent)
>> > -		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
>> > -				   devlink_rate->parent->name))
>> > +	nla_tc_bw = nla_nest_start(msg, DEVLINK_ATTR_RATE_TC_BW);
>> > +	if (!nla_tc_bw)
>> > +		goto nla_put_failure;
>> > +
>> > +	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
>> 
>> Wait, so you fill this up unconditionally? I mean, for set you check if
>> the driver supports it. For get you always fill this up? That looks
>> wrong. Any reason to do so?
>> 
>> 
>
>I followed the existing pattern in devlink, where attributes like tx_share
>and tx_weight are filled unconditionally in the get operation.
>Should I still add a check to see if tc_bw_set is supported?

So is are zeroes correct values passed to user when set is not
supported? I guess 0 is default right? Same question goes to tx_weight
and others.

If the answer is yes, I'm okay to pass it unconditionally.


>
>> > +		struct nlattr *nla_tc_entry = nla_nest_start(msg, i);
>> > +
>> > +		if (!nla_tc_entry) {
>> > +			nla_nest_cancel(msg, nla_tc_bw);
>> > +			goto nla_put_failure;
>> > +		}
>> > +
>> > +		if (nla_put_u8(msg, DEVLINK_ATTR_RATE_TC_INDEX, i) ||
>> > +		    nla_put_u32(msg, DEVLINK_ATTR_RATE_BW, devlink_rate->tc_bw[i])) {
>> > +			nla_nest_cancel(msg, nla_tc_entry);
>> > +			nla_nest_cancel(msg, nla_tc_bw);
>> > 			goto nla_put_failure;
>> > +		}
>> > +
>> > +		nla_nest_end(msg, nla_tc_entry);
>> > +	}
>> > +
>> > +	nla_nest_end(msg, nla_tc_bw);
>> > 
>> > 	genlmsg_end(msg, hdr);
>> > 	return 0;
>> > @@ -380,6 +401,38 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
>> > 		devlink_rate->tx_weight = weight;
>> > 	}
>> > 
>> > +	if (attrs[DEVLINK_ATTR_RATE_TC_BW]) {
>> > +		struct nlattr *nla_tc_bw = attrs[DEVLINK_ATTR_RATE_TC_BW];
>> > +		struct nlattr *tb[DEVLINK_ATTR_RATE_BW + 1];
>> > +		u32 tc_bw[IEEE_8021QAZ_MAX_TCS] = {0};
>> > +		struct nlattr *nla_tc_entry;
>> > +		int rem, tc_index;
>> > +
>> > +		nla_for_each_nested(nla_tc_entry, nla_tc_bw, rem) {
>> > +			err = nla_parse_nested(tb, DEVLINK_ATTR_RATE_BW, nla_tc_entry,
>> > +					       devlink_dl_rate_tc_bw_nl_policy, info->extack);
>> > +			if (err)
>> > +				return err;
>> > +
>> > +			if (tb[DEVLINK_ATTR_RATE_TC_INDEX] && tb[DEVLINK_ATTR_RATE_BW]) {
>> > +				tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
>> 
>> Ough, you trust user to provide you index to array. Recipe for disaster.
>> NLA_POLICY_RANGE() for tc-index would sanitize this. Btw, you use nested
>> array to carry rate-bw and tc-index attrs, isn't the array index good
>> enough? Then you can avoid tc-index attr (which in most cases holds
>> redundant index value). Or do you expect userspace to pass only partial
>> set of tcs?
>> 
>> 
>
>I will drop the tc-index attribute as it is redundant. To address your
>question: I expect userspace to always provide a complete set of tcs.

Okay. Makes sense.


>
>> > +				tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_BW]);
>> > +			}
>> > +		}
>> > +
>> > +		if (devlink_rate_is_leaf(devlink_rate))
>> > +			err = ops->rate_leaf_tc_bw_set(devlink_rate, devlink_rate->priv,
>> > +						       tc_bw, info->extack);
>> > +		else if (devlink_rate_is_node(devlink_rate))
>> > +			err = ops->rate_node_tc_bw_set(devlink_rate, devlink_rate->priv,
>> > +						       tc_bw, info->extack);
>> > +
>> > +		if (err)
>> > +			return err;
>> > +
>> > +		memcpy(devlink_rate->tc_bw, tc_bw, sizeof(tc_bw));
>> > +	}
>> > +
>> > 	nla_parent = attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME];
>> > 	if (nla_parent) {
>> > 		err = devlink_nl_rate_parent_node_set(devlink_rate, info,
>> > @@ -423,6 +476,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
>> > 					    "TX weight set isn't supported for the leafs");
>> > 			return false;
>> > 		}
>> > +		if (attrs[DEVLINK_ATTR_RATE_TC_BW] && !ops->rate_leaf_tc_bw_set) {
>> > +			NL_SET_ERR_MSG_ATTR(info->extack,
>> > +					    attrs[DEVLINK_ATTR_RATE_TC_BW],
>> > +					    "TC bandwidth set isn't supported for the leafs");
>> > +			return false;
>> > +		}
>> > 	} else if (type == DEVLINK_RATE_TYPE_NODE) {
>> > 		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_node_tx_share_set) {
>> > 			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the nodes");
>> > @@ -449,6 +508,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
>> > 					    "TX weight set isn't supported for the nodes");
>> > 			return false;
>> > 		}
>> > +		if (attrs[DEVLINK_ATTR_RATE_TC_BW] && !ops->rate_node_tc_bw_set) {
>> > +			NL_SET_ERR_MSG_ATTR(info->extack,
>> > +					    attrs[DEVLINK_ATTR_RATE_TC_BW],
>> > +					    "TC bandwidth set isn't supported for the nodes");
>> > +			return false;
>> > +		}
>> > 	} else {
>> > 		WARN(1, "Unknown type of rate object");
>> > 		return false;
>> > -- 
>> > 2.44.0
>> > 
>

