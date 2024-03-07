Return-Path: <netdev+bounces-78271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F08749C3
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32678B2388A
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92CF82D87;
	Thu,  7 Mar 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="f3AdrA00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C182D7A
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800546; cv=none; b=f6CvGA+GqKuyrc2050jzGml8a+SQY2WyWMLeMauHZ7qXiabaZo5Z0nYY/utw8wEGYJILW0M1iK6DYjSYMGebAgZLxIqqkZsgYZJEXwm83ST9S+SAQuyqNgWYpnwgkz6gH/l19yXhMIodzZ19xjbFvpOgfzSnKTf8oaviDXKS37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800546; c=relaxed/simple;
	bh=W3TKnfGFSbRnqXKIeTJeO+s0nVZ9/0NYzuqNQRows+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERD3zSk0b8nbKRKW8F6N7dYBNJhDQrQl4EdIjnSPhxQ5271Fv2vBb4gUTCmpFp/56q4tmP8Z1q6cq7+Gxh43ax2rjihNlUpcrrMIFewV6B/0YmfbnRhw2Dkj8IpO1m7misEUJMq7jCR+m6kowgxqy85jRMYdXiP+1LEnrttmKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=f3AdrA00; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso7172141fa.2
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 00:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709800542; x=1710405342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+bXBJixQOUsop2TJKZ58GCIYbvqkD+ezDVnGT61Olk=;
        b=f3AdrA00hD91/zHYiGvhtypxEkcsNOcZEk4AotUb68tjHxD8sIiAQ72eaI3P2lqLVI
         lPXFEeR1/OGtAPLoJdEv1MmJ6jlKDJ/ettQEfuSBRlpVsu1gHrQYyuzXOOozrC+0bD++
         426oIxnWV3rfJsuJiAnqixnUeG7flCy70HHrHIjgLNgrrLDJubO8KoHEJp5zZROd01ko
         l2S0lSLeR8fg6iToMbiJFkN7C8JfH+LqD7OveMGc+izKLBwCHfRJTun3Q5ACpw2h0dGX
         4pCPOeytzdiRGoM6sHkzAvl8yQru3XaqYl1Jf2XCpxN4b+wdExrqNTLiiSN+3lu9+Zmc
         Ksng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709800542; x=1710405342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+bXBJixQOUsop2TJKZ58GCIYbvqkD+ezDVnGT61Olk=;
        b=NaGWFZ8Sx7sp/rr6mZ6VkPw93Kf7R+iApqswejbMd7iaL6LKthq7C3ArWDBEfAdDr8
         Oo3oP45Rwz6USvpQgjhGub+6egGA2qf8F8Uqhd3knxfRtJlqszcJC99M1Xb4vDrcByzn
         +SdS5Cco12t5E7boD79PHxbrbGIzVjx99jXfLC/BXJwl0+hk9kbqvmj5LiuOOd343ytB
         /YAuDoJ+bVMuikWJMSCi1RXZPqmJcQA8GHsuHCbART/jSmK0TkanzMXqjxJHDvktmR64
         n4YOxqi27Md7r8yO5zAjaV2GH5PFKNOElrp3+peHsq2EDw9rrQiUALX2lVxM8Da02x1E
         YXkg==
X-Gm-Message-State: AOJu0Yw/FaCdP/ejkojYQ2JbdZi9llAH0IeJw7pR7dq5aBSj57XhAcaV
	y/bXvQel4kl2L2U1NoHAgPMh0epl+f3fsr7L15E7EehariLVELAsDzEo+eEdp+Q=
X-Google-Smtp-Source: AGHT+IEc5Or50maI4OA0EUo0VoeQmuXpjXjSMufMtXHGHGCENFlZK+bpqzV7FYMhodkCXmmDIueoUA==
X-Received: by 2002:a2e:be23:0:b0:2d2:5668:3a40 with SMTP id z35-20020a2ebe23000000b002d256683a40mr974616ljq.4.1709800542066;
        Thu, 07 Mar 2024 00:35:42 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id cr14-20020a05600004ee00b0033dd06e628asm19644957wrb.27.2024.03.07.00.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 00:35:41 -0800 (PST)
Date: Thu, 7 Mar 2024 09:35:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
	tariqt@nvidia.com, yossiku@nvidia.com, kuba@kernel.org
Subject: Re: [PATCH RFC v3 net-next 1/2] devlink: Add shared memory pool
 eswitch attribute
Message-ID: <Zel8WpMczric0fz3@nanopsycho>
References: <20240306231253.8100-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306231253.8100-1-witu@nvidia.com>

Thu, Mar 07, 2024 at 12:12:52AM CET, witu@nvidia.com wrote:
>Add eswitch attribute spool_size for shared memory pool size.
>
>When using switchdev mode, the representor ports handles the slow path
>traffic, the traffic that can't be offloaded will be redirected to the
>representor port for processing. Memory consumption of the representor
>port's rx buffer can grow to several GB when scaling to 1k VFs reps.
>For example, in mlx5 driver, each RQ, with a typical 1K descriptors,
>consumes 3MB of DMA memory for packet buffer in WQEs, and with four
>channels, it consumes 4 * 3MB * 1024 = 12GB of memory. And since rep
>ports are for slow path traffic, most of these rx DMA memory are idle.
>
>Add spool_size configuration, allowing multiple representor ports
>to share a rx memory buffer pool. When enabled, individual representor
>doesn't need to allocate its dedicated rx buffer, but just pointing
>its rq to the memory pool. This could make the memory being better
>utilized. The spool_size represents the number of bytes of the memory
>pool. Users can adjust it based on how many reps, total system
>memory, or performance expectation.
>
>An example use case:
>$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
>  spool-size 4096000
>$ devlink dev eswitch show pci/0000:08:00.0
>  pci/0000:08:00.0: mode legacy inline-mode none encap-mode basic \
>  spool-size 4096000
>
>Disable the shared memory pool by setting spool_size to 0.
>
>Signed-off-by: William Tu <witu@nvidia.com>
>---
>v3: feedback from Jakub
>- introduce 1 attribute instead of 2
>- use spool_size == 0 to disable
>- spool_size as byte unit, not counts
>
>Question about ENODOCS:
>where to add this? the only document about devlink attr is at iproute2
>Do I add a new file Documentation/networking/devlink/devlink-eswitch-attr.rst?

Yeah. Please document the existing attrs as well while you are at it.


>---
> Documentation/netlink/specs/devlink.yaml |  4 ++++
> include/net/devlink.h                    |  3 +++
> include/uapi/linux/devlink.h             |  1 +
> net/devlink/dev.c                        | 21 +++++++++++++++++++++
> net/devlink/netlink_gen.c                |  5 +++--
> 5 files changed, 32 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>index cf6eaa0da821..cb46fa9d6664 100644
>--- a/Documentation/netlink/specs/devlink.yaml
>+++ b/Documentation/netlink/specs/devlink.yaml
>@@ -429,6 +429,9 @@ attribute-sets:
>         name: eswitch-encap-mode
>         type: u8
>         enum: eswitch-encap-mode
>+      -
>+        name: eswitch-spool-size
>+        type: u32
>       -
>         name: resource-list
>         type: nest
>@@ -1555,6 +1558,7 @@ operations:
>             - eswitch-mode
>             - eswitch-inline-mode
>             - eswitch-encap-mode
>+            - eswitch-spool-size
> 
>     -
>       name: eswitch-set
>diff --git a/include/net/devlink.h b/include/net/devlink.h
>index 9ac394bdfbe4..164c543dd7ca 100644
>--- a/include/net/devlink.h
>+++ b/include/net/devlink.h
>@@ -1327,6 +1327,9 @@ struct devlink_ops {
> 	int (*eswitch_encap_mode_set)(struct devlink *devlink,
> 				      enum devlink_eswitch_encap_mode encap_mode,
> 				      struct netlink_ext_ack *extack);
>+	int (*eswitch_spool_size_get)(struct devlink *devlink, u32 *p_size);
>+	int (*eswitch_spool_size_set)(struct devlink *devlink, u32 size,
>+				      struct netlink_ext_ack *extack);
> 	int (*info_get)(struct devlink *devlink, struct devlink_info_req *req,
> 			struct netlink_ext_ack *extack);
> 	/**
>diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>index 130cae0d3e20..cbe51be7a08a 100644
>--- a/include/uapi/linux/devlink.h
>+++ b/include/uapi/linux/devlink.h
>@@ -614,6 +614,7 @@ enum devlink_attr {
> 
> 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
> 
>+	DEVLINK_ATTR_ESWITCH_SPOOL_SIZE,	/* u32 */
> 	/* add new attributes above here, update the policy in devlink.c */

While at it, could you please update this comment? It should say:
 	/* Add new attributes above here, update the spec in
	 * Documentation/netlink/specs/devlink.yaml and re-generate
	 * net/devlink/netlink_gen.c. */
As a separate patch please.


> 
> 	__DEVLINK_ATTR_MAX,
>diff --git a/net/devlink/dev.c b/net/devlink/dev.c
>index 19dbf540748a..561874424db7 100644
>--- a/net/devlink/dev.c
>+++ b/net/devlink/dev.c
>@@ -633,6 +633,7 @@ static int devlink_nl_eswitch_fill(struct sk_buff *msg, struct devlink *devlink,
> {
> 	const struct devlink_ops *ops = devlink->ops;
> 	enum devlink_eswitch_encap_mode encap_mode;
>+	u32 spool_size;
> 	u8 inline_mode;
> 	void *hdr;
> 	int err = 0;
>@@ -674,6 +675,15 @@ static int devlink_nl_eswitch_fill(struct sk_buff *msg, struct devlink *devlink,
> 			goto nla_put_failure;
> 	}
> 
>+	if (ops->eswitch_spool_size_get) {
>+		err = ops->eswitch_spool_size_get(devlink, &spool_size);
>+		if (err)
>+			goto nla_put_failure;
>+		err = nla_put_u32(msg, DEVLINK_ATTR_ESWITCH_SPOOL_SIZE, spool_size);
>+		if (err)
>+			goto nla_put_failure;
>+	}
>+
> 	genlmsg_end(msg, hdr);
> 	return 0;
> 
>@@ -708,10 +718,21 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
> 	struct devlink *devlink = info->user_ptr[0];
> 	const struct devlink_ops *ops = devlink->ops;
> 	enum devlink_eswitch_encap_mode encap_mode;
>+	u32 spool_size;
> 	u8 inline_mode;
> 	int err = 0;
> 	u16 mode;
> 
>+	if (info->attrs[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE]) {
>+		if (!ops->eswitch_spool_size_set)

Fill up extack msg here please.


>+			return -EOPNOTSUPP;
>+		spool_size = nla_get_u32(info->attrs[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE]);
>+		err = ops->eswitch_spool_size_set(devlink, spool_size,
>+						  info->extack);
>+		if (err)
>+			return err;
>+	}
>+
> 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
> 		if (!ops->eswitch_mode_set)
> 			return -EOPNOTSUPP;
>diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
>index c81cf2dd154f..acbf484b28a2 100644
>--- a/net/devlink/netlink_gen.c
>+++ b/net/devlink/netlink_gen.c
>@@ -194,12 +194,13 @@ static const struct nla_policy devlink_eswitch_get_nl_policy[DEVLINK_ATTR_DEV_NA
> };
> 
> /* DEVLINK_CMD_ESWITCH_SET - do */
>-static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_ENCAP_MODE + 1] = {
>+static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE + 1] = {
> 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
> 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
> 	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 1),
> 	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U16, 3),
> 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
>+	[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE] = { .type = NLA_U32, },
> };
> 
> /* DEVLINK_CMD_DPIPE_TABLE_GET - do */
>@@ -787,7 +788,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
> 		.doit		= devlink_nl_eswitch_set_doit,
> 		.post_doit	= devlink_nl_post_doit,
> 		.policy		= devlink_eswitch_set_nl_policy,
>-		.maxattr	= DEVLINK_ATTR_ESWITCH_ENCAP_MODE,
>+		.maxattr	= DEVLINK_ATTR_ESWITCH_SPOOL_SIZE,
> 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> 	},
> 	{
>-- 
>2.38.1
>
>

