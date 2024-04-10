Return-Path: <netdev+bounces-86475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C171889EEBE
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7366B283A1E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1E315539F;
	Wed, 10 Apr 2024 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WWLEmesp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D041552EF
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741280; cv=none; b=acqEdPj1lVOPm18OdOMmcgFml165mB/M59EbYpgq3dxI4R6W4peAfAtfQY96L37h2x/tCCUP6PfT4GBeYdof4HT16Om+gIEj8TOT6WIn6SLFl8j8QUm0+e6SCIDyS8hL4nNoiG3WrbzvhJpq67FzoFkmvwFFgAzrfpbyv7YnKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741280; c=relaxed/simple;
	bh=ymnspScKCEabuUQBmwtD3RqvJPNgH6KEN8/vtK99rZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMs7ZISPB7+yTnNnL9pRUONBavPu1NfEa29210hH+vS9W6+soQJg1QGQx7+d/8j25HGJvYH2+eoCXcg7OKCiESWAr9OYhkBqG88eYKqxGjjbL+nIAuBNEGr/hc1ciMRT9GNhcXFn+s1HKLN/JaMNV848yWyhnkXTo6n2a6jLL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WWLEmesp; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51a7dc45easo619471266b.2
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 02:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712741276; x=1713346076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7hkgTE43uDhbuoW1S69dxQ4P7QbGFBMLprmMrbfgI4=;
        b=WWLEmespbffWnolwfCTJdcPZvBIjnWHWLLOW7kEOPU/IU66AmabY1MoMRZgCpxFqQQ
         0j62vEBc57kLBG54gcCZLKDl0iWiMr+Sg1iQXlMmXm7vcT5bDg/sL6HTFwVcBmTcjla0
         mATUUouoGdYHgFZhNA42lpA7UVSPypRkCS8xAaA8TqTID1I7my3eJm9ft6qgSwSiEcsl
         rCoXlE8FqPoOPyegQYOoGImH2tO45dfCqlx+zwj1sIOVrAoqiMKYD+BpyeTfroo0s71x
         zNx3gL1mZTYq7bss/9T8z7HkSVW/tMjAKMhbSF7R6Qx3GxvUX/AlvABUDMJNgXB8L41j
         TGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712741276; x=1713346076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7hkgTE43uDhbuoW1S69dxQ4P7QbGFBMLprmMrbfgI4=;
        b=cY8yNaTbnp3gFO3/8OLU7Ysq96VawL6J+EpNM1EyKK8nwKpGD59zwTOt5Gyys6GTL9
         ZiU2/qR5+4g3BAEOITlrzVt6WfGLYRFoQ0ZXDS8jpGszqDlb9CXaaeEmQTIH57z0sJ4/
         ChHVvwwXmDn6tzhb0YRR4rix2llEhfdyJ5x7MiHu/85PHfB38UczQkZsw0MMBkF28hOo
         HxeV0iDZmYFZRmlcgIepXeCUqJ3AQ6Lyiib4xQECA4E0+dWiZrqaqGfg1Z6/dV5/Nz0u
         0CZB8qzkJmmDkxm1Qw7vKrAm3KTnyBNrL5/9EgE2dtodAxNu3Frah7BnP4GOgSs8wAfU
         VRdA==
X-Gm-Message-State: AOJu0YyWRgavhdQx2jCjFVNheT6zt9DVLxVenwTVhjKhWTZcqf12cJQ4
	3LA5+0NYkFZmNaV0vom50VQhjkwOGOl7GVavZS4fWJg2Uh6fCcqN+hveN2jbxqQ=
X-Google-Smtp-Source: AGHT+IGjmUHpb4kdq7mkKU/gtwPa24152GQZL8LOskDkg3FclTEAdFimgW/EMQUSR+7FY0WpzG20xQ==
X-Received: by 2002:a17:906:cb9a:b0:a51:cab2:e55d with SMTP id mf26-20020a170906cb9a00b00a51cab2e55dmr1259181ejb.15.1712741275873;
        Wed, 10 Apr 2024 02:27:55 -0700 (PDT)
Received: from localhost (78-80-106-99.customers.tmcz.cz. [78.80.106.99])
        by smtp.gmail.com with ESMTPSA id dp12-20020a170906c14c00b00a51e5079c74sm2351221ejc.124.2024.04.10.02.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:27:55 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:27:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
	jiri@nvidia.com, shayd@nvidia.com
Subject: Re: [PATCH 2/2] devlink: Support setting max_io_eqs
Message-ID: <ZhZbmT8BIpw4E-a8@nanopsycho>
References: <20240410073903.7913-1-parav@nvidia.com>
 <20240410073903.7913-3-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410073903.7913-3-parav@nvidia.com>

Re subject, please specify the target project and tree:
[patch iproute2-next]....

Wed, Apr 10, 2024 at 09:39:03AM CEST, parav@nvidia.com wrote:
>Devices send event notifications for the IO queues,
>such as tx and rx queues, through event queues.
>
>Enable a privileged owner, such as a hypervisor PF, to set the number
>of IO event queues for the VF and SF during the provisioning stage.
>
>example:
>Get maximum IO event queues of the VF device::
>
>  $ devlink port show pci/0000:06:00.0/2
>  pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
>      function:
>          hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 10
>
>Set maximum IO event queues of the VF device::
>
>  $ devlink port function set pci/0000:06:00.0/2 max_io_eqs 32
>
>  $ devlink port show pci/0000:06:00.0/2
>  pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
>      function:
>          hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 32
>
>Signed-off-by: Parav Pandit <parav@nvidia.com>
>---
> devlink/devlink.c | 29 ++++++++++++++++++++++++++++-

Manpage update please.


> 1 file changed, 28 insertions(+), 1 deletion(-)
>
>diff --git a/devlink/devlink.c b/devlink/devlink.c
>index dbeb6e39..6b058c85 100644
>--- a/devlink/devlink.c
>+++ b/devlink/devlink.c
>@@ -309,6 +309,7 @@ static int ifname_map_update(struct ifname_map *ifname_map, const char *ifname)
> #define DL_OPT_PORT_FN_RATE_TX_PRIORITY	BIT(55)
> #define DL_OPT_PORT_FN_RATE_TX_WEIGHT	BIT(56)
> #define DL_OPT_PORT_FN_CAPS	BIT(57)
>+#define DL_OPT_PORT_FN_MAX_IO_EQS	BIT(58)
> 
> struct dl_opts {
> 	uint64_t present; /* flags of present items */
>@@ -375,6 +376,7 @@ struct dl_opts {
> 	const char *linecard_type;
> 	bool selftests_opt[DEVLINK_ATTR_SELFTEST_ID_MAX + 1];
> 	struct nla_bitfield32 port_fn_caps;
>+	uint32_t port_fn_max_io_eqs;
> };
> 
> struct dl {
>@@ -773,6 +775,7 @@ devlink_function_policy[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1] = {
> 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR ] = MNL_TYPE_BINARY,
> 	[DEVLINK_PORT_FN_ATTR_STATE] = MNL_TYPE_U8,
> 	[DEVLINK_PORT_FN_ATTR_DEVLINK] = MNL_TYPE_NESTED,
>+	[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS] = MNL_TYPE_U32,
> };
> 
> static int function_attr_cb(const struct nlattr *attr, void *data)
>@@ -2298,6 +2301,17 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
> 			if (ipsec_packet)
> 				opts->port_fn_caps.value |= DEVLINK_PORT_FN_CAP_IPSEC_PACKET;
> 			o_found |= DL_OPT_PORT_FN_CAPS;
>+		} else if (dl_argv_match(dl, "max_io_eqs") &&
>+			   (o_all & DL_OPT_PORT_FN_MAX_IO_EQS)) {
>+			uint32_t max_io_eqs;
>+
>+			dl_arg_inc(dl);
>+			err = dl_argv_uint32_t(dl, &max_io_eqs);
>+			if (err)
>+				return err;
>+			opts->port_fn_max_io_eqs = max_io_eqs;
>+			o_found |= DL_OPT_PORT_FN_MAX_IO_EQS;
>+
> 		} else {
> 			pr_err("Unknown option \"%s\"\n", dl_argv(dl));
> 			return -EINVAL;
>@@ -2428,6 +2442,9 @@ dl_function_attr_put(struct nlmsghdr *nlh, const struct dl_opts *opts)
> 	if (opts->present & DL_OPT_PORT_FN_CAPS)
> 		mnl_attr_put(nlh, DEVLINK_PORT_FN_ATTR_CAPS,
> 			     sizeof(opts->port_fn_caps), &opts->port_fn_caps);
>+	if (opts->present & DL_OPT_PORT_FN_MAX_IO_EQS)
>+		mnl_attr_put_u32(nlh, DEVLINK_PORT_FN_ATTR_MAX_IO_EQS,
>+				opts->port_fn_max_io_eqs);
> 
> 	mnl_attr_nest_end(nlh, nest);
> }
>@@ -4744,6 +4761,7 @@ static void cmd_port_help(void)
> 	pr_err("       devlink port function set DEV/PORT_INDEX [ hw_addr ADDR ] [ state { active | inactive } ]\n");
> 	pr_err("                      [ roce { enable | disable } ] [ migratable { enable | disable } ]\n");
> 	pr_err("                      [ ipsec_crypto { enable | disable } ] [ ipsec_packet { enable | disable } ]\n");
>+	pr_err("                      [ max_io_eqs [ value ]\n");

"value" is not optional as the help entry suggests, also don't use
"value", also, it should capital letter as it is not a fixed string.
Be in sync with the rest:

	pr_err("                      [ max_io_eqs EQS\n");

Something like that.

Rest of the patch looks ok.


> 	pr_err("       devlink port function rate { help | show | add | del | set }\n");
> 	pr_err("       devlink port param set DEV/PORT_INDEX name PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
> 	pr_err("       devlink port param show [DEV/PORT_INDEX name PARAMETER]\n");
>@@ -4878,6 +4896,15 @@ static void pr_out_port_function(struct dl *dl, struct nlattr **tb_port)
> 				     port_fn_caps->value & DEVLINK_PORT_FN_CAP_IPSEC_PACKET ?
> 				     "enable" : "disable");
> 	}
>+	if (tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS]) {
>+		uint32_t max_io_eqs;
>+
>+		max_io_eqs = mnl_attr_get_u32(tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS]);
>+
>+		print_uint(PRINT_ANY, "max_io_eqs", " max_io_eqs %u",
>+			   max_io_eqs);
>+	}
>+
> 	if (tb[DEVLINK_PORT_FN_ATTR_DEVLINK])
> 		pr_out_nested_handle_obj(dl, tb[DEVLINK_PORT_FN_ATTR_DEVLINK],
> 					 true, true);
>@@ -5086,7 +5113,7 @@ static int cmd_port_function_set(struct dl *dl)
> 	}
> 	err = dl_argv_parse(dl, DL_OPT_HANDLEP,
> 			    DL_OPT_PORT_FUNCTION_HW_ADDR | DL_OPT_PORT_FUNCTION_STATE |
>-			    DL_OPT_PORT_FN_CAPS);
>+			    DL_OPT_PORT_FN_CAPS | DL_OPT_PORT_FN_MAX_IO_EQS);
> 	if (err)
> 		return err;
> 
>-- 
>2.26.2
>
>

