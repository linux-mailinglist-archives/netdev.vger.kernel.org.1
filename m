Return-Path: <netdev+bounces-78273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAE48749D5
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC951F22F49
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC7C71728;
	Thu,  7 Mar 2024 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NcX1Gai1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D704A8286B
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800663; cv=none; b=oAsfPcGSH2PCfWVifzsxELTfEOCTJga7z5YPXUhd97ad+qbdsvjgq09rDXOJD67MTQEWJsk5pVy8YL7Sz6EqpMec32EPctduxfdqHrayXpMAri7FJPEoxn3R/lMWcaq/e7Hg2zmW01hDSPFWOdNcFx3NPYq5WnkdXnJnx9YvJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800663; c=relaxed/simple;
	bh=GmFtMoPOyiLH8bzORAZn8FvvjYhb2uYqXQ3UYQdZ7fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GInVPVsgA0weN+szm+GlhihGOhcYvUIXhTMSTO/bjOVNYHFMotJwo4JpAyNNIm+dlD2hGuqRGf1ML3OHB+FkuJI/zP9Sxco8zH780W9ipcim7i1sC8uCVJM79BNdA9A5BloOVKI2FGycr2d+ANKDAAYpJOwDyTDZDqPNZoAkPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NcX1Gai1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512e4f4e463so837389e87.1
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 00:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709800660; x=1710405460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5S76SdU6JClwN911l2VaNXiJf3/Bi8ejPY+nnpIZVrQ=;
        b=NcX1Gai1kvRs7VsEsakCPTxcn8SbG6OskUTVkb7OkuQurasa4ND4Ugm6CKzTwB+3Sc
         YICsGOjf9J4YqFM5OYX/yZwiBVFtA9IAFSg3xT2QR9d0iipeUZLVKNoA/tPhHAT5purw
         DgTsd7pNJngqfco5ZbqzlnL6eJtkovH+yXzUw54KBTi1nZei3KCMmtc2GHA2Ge/kO/um
         zKpWClVQfZnd2PHJuD9+2+TbKzLII7TJqMpAYSVmwctfK481+gBB/craQ/pDR43be8G9
         Uj9g+l3sUbroNwurige5HRnOKeWw6mN7r7uPl08VzbMZE8qcIcqSWHcX6LdsDzdC1cHO
         E6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709800660; x=1710405460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S76SdU6JClwN911l2VaNXiJf3/Bi8ejPY+nnpIZVrQ=;
        b=ZZ1yvCd3CAMhLXrXXB69lXc4XBpenFl7kt5hajmbNf6KXYKnQcz8mmm+YAMOrNdyBn
         88zIWxApRugLr3eD8M0JiVRXN/Cp6CVWJ/s1tUACPKrXoZveSwlvaoUgeRV5QkOHEJKN
         9t9Csad4zrJqSUDZPPd/mXpS07Xxrloxp8T42aIbBpAn/ByREqMu42sYjJmiz0Pssevy
         fcSjZb8uXmvddg48pmLjz5JyHCCtxJhaqP1JMTYQk4MU5dUdQwarVVrL8kPRJSH02dZT
         RYqfFuEwvYrlD22DEGpYNYsR8GgIzTR/qEU31agCSg+QlkLDw7/uWlaMltGj2u8ipYe8
         BeCA==
X-Gm-Message-State: AOJu0YxB+0cMWfsBV3TQ3tohK0r/rvS+qZEhKOIA10bOZjv1QL7u+5Sf
	N+erbf8FySORtvvuzss7j3Bpuh9NJY26tOW4meks01yBFpPc18OA4yERnbE0nh4=
X-Google-Smtp-Source: AGHT+IFN5Hn+GwtpQHlI9yZI85LicQX+Z810R1A+nNxn30XL/dsjB+neJTLbfSdoKUI8HV+Z/Lo61g==
X-Received: by 2002:a19:7614:0:b0:513:1e2a:f9c5 with SMTP id c20-20020a197614000000b005131e2af9c5mr942408lff.17.1709800659691;
        Thu, 07 Mar 2024 00:37:39 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v23-20020a05600c215700b00412e84e59d8sm1794174wml.44.2024.03.07.00.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 00:37:39 -0800 (PST)
Date: Thu, 7 Mar 2024 09:37:35 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
	tariqt@nvidia.com, yossiku@nvidia.com, kuba@kernel.org
Subject: Re: [PATCH RFC v3 iproute2-next] devlink: Add shared memory pool
 eswitch attribute
Message-ID: <Zel8zzXM18k3FnGL@nanopsycho>
References: <20240306232922.8249-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306232922.8249-1-witu@nvidia.com>

Thu, Mar 07, 2024 at 12:29:22AM CET, witu@nvidia.com wrote:
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
>v3:
>- change to 1 attributes and rename to spool-size
>
>v2: feedback from Stephen
>- add man page, send to iproute2-next
>---
> devlink/devlink.c            | 25 +++++++++++++++++++++++--
> include/uapi/linux/devlink.h |  1 +
> man/man8/devlink-dev.8       |  6 ++++++
> 3 files changed, 30 insertions(+), 2 deletions(-)
>
>diff --git a/devlink/devlink.c b/devlink/devlink.c
>index dbeb6e397e8e..5ad789caa934 100644
>--- a/devlink/devlink.c
>+++ b/devlink/devlink.c
>@@ -309,6 +309,7 @@ static int ifname_map_update(struct ifname_map *ifname_map, const char *ifname)
> #define DL_OPT_PORT_FN_RATE_TX_PRIORITY	BIT(55)
> #define DL_OPT_PORT_FN_RATE_TX_WEIGHT	BIT(56)
> #define DL_OPT_PORT_FN_CAPS	BIT(57)
>+#define DL_OPT_ESWITCH_SPOOL_SIZE	BIT(58)
> 
> struct dl_opts {
> 	uint64_t present; /* flags of present items */
>@@ -375,6 +376,7 @@ struct dl_opts {
> 	const char *linecard_type;
> 	bool selftests_opt[DEVLINK_ATTR_SELFTEST_ID_MAX + 1];
> 	struct nla_bitfield32 port_fn_caps;
>+	uint32_t eswitch_spool_size;
> };
> 
> struct dl {
>@@ -630,6 +632,7 @@ static const enum mnl_attr_data_type devlink_policy[DEVLINK_ATTR_MAX + 1] = {
> 	[DEVLINK_ATTR_ESWITCH_MODE] = MNL_TYPE_U16,
> 	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = MNL_TYPE_U8,
> 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = MNL_TYPE_U8,
>+	[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE] = MNL_TYPE_U32,
> 	[DEVLINK_ATTR_DPIPE_TABLES] = MNL_TYPE_NESTED,
> 	[DEVLINK_ATTR_DPIPE_TABLE] = MNL_TYPE_NESTED,
> 	[DEVLINK_ATTR_DPIPE_TABLE_NAME] = MNL_TYPE_STRING,
>@@ -1672,6 +1675,7 @@ static const struct dl_args_metadata dl_args_required[] = {
> 	{DL_OPT_LINECARD,	      "Linecard index expected."},
> 	{DL_OPT_LINECARD_TYPE,	      "Linecard type expected."},
> 	{DL_OPT_SELFTESTS,            "Test name is expected"},
>+	{DL_OPT_ESWITCH_SPOOL_SIZE,   "E-Switch shared memory pool size expected."},
> };
> 
> static int dl_args_finding_required_validate(uint64_t o_required,
>@@ -1895,6 +1899,13 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
> 			if (err)
> 				return err;
> 			o_found |= DL_OPT_ESWITCH_ENCAP_MODE;
>+		} else if (dl_argv_match(dl, "spool-size") &&
>+			   (o_all & DL_OPT_ESWITCH_SPOOL_SIZE)) {
>+			dl_arg_inc(dl);
>+			err = dl_argv_uint32_t(dl, &opts->eswitch_spool_size);
>+			if (err)
>+				return err;
>+			o_found |= DL_OPT_ESWITCH_SPOOL_SIZE;
> 		} else if (dl_argv_match(dl, "path") &&
> 			   (o_all & DL_OPT_RESOURCE_PATH)) {
> 			dl_arg_inc(dl);
>@@ -2547,6 +2558,9 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
> 	if (opts->present & DL_OPT_ESWITCH_ENCAP_MODE)
> 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_ESWITCH_ENCAP_MODE,
> 				opts->eswitch_encap_mode);
>+	if (opts->present & DL_OPT_ESWITCH_SPOOL_SIZE)
>+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_ESWITCH_SPOOL_SIZE,
>+				 opts->eswitch_spool_size);
> 	if ((opts->present & DL_OPT_RESOURCE_PATH) && opts->resource_id_valid)
> 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_RESOURCE_ID,
> 				 opts->resource_id);
>@@ -2707,6 +2721,7 @@ static void cmd_dev_help(void)
> 	pr_err("       devlink dev eswitch set DEV [ mode { legacy | switchdev } ]\n");
> 	pr_err("                               [ inline-mode { none | link | network | transport } ]\n");
> 	pr_err("                               [ encap-mode { none | basic } ]\n");
>+	pr_err("                               [ spool-size { SIZE } ]\n");


SIZE should not be in brackets, it's not an enum selection:
	pr_err("                               [ spool-size SIZE ]\n");
Same in man



> 	pr_err("       devlink dev eswitch show DEV\n");
> 	pr_err("       devlink dev param set DEV name PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
> 	pr_err("       devlink dev param show [DEV name PARAMETER]\n");
>@@ -3194,7 +3209,12 @@ static void pr_out_eswitch(struct dl *dl, struct nlattr **tb)
> 			     eswitch_encap_mode_name(mnl_attr_get_u8(
> 				    tb[DEVLINK_ATTR_ESWITCH_ENCAP_MODE])));
> 	}
>-
>+	if (tb[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE]) {
>+		check_indent_newline(dl);
>+		print_uint(PRINT_ANY, "spool-size", "spool-size %u",
>+			   mnl_attr_get_u32(
>+				    tb[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE]));
>+	}
> 	pr_out_handle_end(dl);
> }
> 
>@@ -3239,7 +3259,8 @@ static int cmd_dev_eswitch_set(struct dl *dl)
> 	err = dl_argv_parse(dl, DL_OPT_HANDLE,
> 			    DL_OPT_ESWITCH_MODE |
> 			    DL_OPT_ESWITCH_INLINE_MODE |
>-			    DL_OPT_ESWITCH_ENCAP_MODE);
>+			    DL_OPT_ESWITCH_ENCAP_MODE |
>+			    DL_OPT_ESWITCH_SPOOL_SIZE);
> 	if (err)
> 		return err;
> 
>diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>index e77170199815..c750e29a1c5c 100644
>--- a/include/uapi/linux/devlink.h
>+++ b/include/uapi/linux/devlink.h
>@@ -614,6 +614,7 @@ enum devlink_attr {
> 
> 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
> 
>+	DEVLINK_ATTR_ESWITCH_SPOOL_SIZE,	/* u32 */
> 	/* add new attributes above here, update the policy in devlink.c */
> 
> 	__DEVLINK_ATTR_MAX,
>diff --git a/man/man8/devlink-dev.8 b/man/man8/devlink-dev.8
>index e9d091df48d8..081cc8740f8b 100644
>--- a/man/man8/devlink-dev.8
>+++ b/man/man8/devlink-dev.8
>@@ -34,6 +34,8 @@ devlink-dev \- devlink device configuration
> .BR inline-mode " { " none " | " link " | " network " | " transport " } "
> ] [
> .BR encap-mode " { " none " | " basic " } "
>+] [
>+.BR spool-size " { SIZE } "
> ]
> 
> .ti -8
>@@ -151,6 +153,10 @@ Set eswitch encapsulation support
> .I basic
> - Enable encapsulation support
> 
>+.TP
>+.BR spool-size " SIZE"
>+Set the rx shared memory pool size in bytes.
>+
> .SS devlink dev param set  - set new value to devlink device configuration parameter
> 
> .TP
>-- 
>2.38.1
>
>

