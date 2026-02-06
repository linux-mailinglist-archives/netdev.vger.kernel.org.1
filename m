Return-Path: <netdev+bounces-257502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLmlBRW2hWmOFgQAu9opvQ
	(envelope-from <netdev+bounces-257502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:36:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B2FC16E
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52F09304C072
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D1235DD0A;
	Fri,  6 Feb 2026 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="T8s0Lqb1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36E313295
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370434; cv=none; b=rNqjlmHUAabjo7fODgo4aTYe7yiNHNfSZ8MCYT/+ARAGDN/PBKqIQNoA4TvOagdpShzSNZD+spFPAfT10U2Mg0pzZSAYzUxYUYmZfZSlqmBUMrnHbuWqOmM0Ksk0w4ub2I17M4DpFUrEn+GJNXh14hjcnIXhLTeXoMBqNgSuXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370434; c=relaxed/simple;
	bh=c+GiUJQTfwJdt0D4FrdPca+NjRLul/+/cXZFtg415KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ton5X7dFQYTEPj9nev9vehIgHW+NS32qgKDLOOxtv0iN+CipRZiRamPfXL5/Rsd8MwT73Mv+UGsLl+fUJ28LHQVuGeBJI2YcRZ9pQjxTVSkIDijoqUYDGtZvipjkcRN3/RIXryU2jyRLv1Tfs2+I/OY/3zW7YKBcNye2FWbNUYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=T8s0Lqb1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4832701b9b7so1301685e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 01:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770370432; x=1770975232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56MUvuCz4kq0jyDggo6mUeNBZRMTvfCb+XKL3S/XDRU=;
        b=T8s0Lqb1oNsUcQFpml28rmErHuUAn+On6w1dppEGr3pDG5G77o0Py0FeS+MxpyxCyq
         z5LV1817Pp5NU1nhAEAtGRYvHoFhzixOPIKBwwBxR1Pl8YOw843zYsa+HHYK8UYTXnkj
         0xHMeujCLFcT69ent5dSbj+ajtJ1Lb2C+0KjKJvikQq5VsW2i2mKqgVMBJ4ukMwRd5Jg
         Y9qNKTAwX/ExTtrun8sEd7m5mB0sN7sbEDTno4CD/PqbGD8AHMUABwgM7Z3HcGlEGOc4
         WC91wj+W2kveJQMWR5BT7sljjvvGZfgJwgV1BtI00WRNaW4MfDjFVYkmu0WUgpw6PTpy
         4vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370432; x=1770975232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56MUvuCz4kq0jyDggo6mUeNBZRMTvfCb+XKL3S/XDRU=;
        b=a5GLA5i8QCFSP7PbCBsldf3A1qh0hoFUgC5gECeB418hg/3eG/LfKsA9NphxDfjahw
         MXrszBXr4rCRqIoh+lij2xc1mpB9zaAcBttVFgcrzlVoROX7x/YkRo2LcGYxXjLO1OEe
         s3aFSeCZ4gy0S95yfLzp1rOhge6alVATbpUZ78aiVVeGqVmlD6RF1+iU93TxfCzDpxWz
         Ij27LS9ygon2uL5YlmE2vAKTfVAsDHZcknal/WfxkE5LYtSsVx1lH9u7mBUBsSJvc1uE
         y0of4PC7ElgeC48LuOVvd0YgIQ6RZelsDCLSscPOtjuyJhtOrI8fZbcrO39Cos7n2qcw
         34cA==
X-Forwarded-Encrypted: i=1; AJvYcCVc31P2i7iAEPxTiH9glwHjEiSB+MlnwV+LGhXOlB/aWWQ9GHZh9HRabn5pCx7SnbSwfy2SprI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSkXd6sTi5Zvu5pdKSBx9xUJMv7YQEuYSn6YyTW26zh75i/wO
	6je8wUn816Z43wWT3Q3Y8EQzmsDUW1HLmhJqth4OPAzz5mTPX45VOg9Ra/6up6HbAlE=
X-Gm-Gg: AZuq6aIGsVz/JQijSZ1h9nbSekO4iHuKQdS3vXTz0mISXsHctfxt6O1EVjk4x/UvE20
	iOwntEFcOpKo8kglVdmEGZkwMToyEtVDo4GVOVuonadtQtOoVwV/m4QPC6QEA0qhFzubJst8/WI
	3KcEocXmiLIX/KmDzQmZPV+WQgJBarx1Wtd9BWby02qH6uC5qtECzhMC3J5Mq0CFtBU3jrLu4I9
	2YXJOXgsCLn2rayY/C5AkjytcQ34md8+1aN0jmKb2F/rBRXIKmopBf8DHAaLExdo+VcKT9PKpxy
	D7VflPo5imQrWi8C5hVYzVBU+WTE8A2d2HxdjTM+xd9VW9qJSS3HJkcAcYoalZlGiPHwxQ2QeE9
	vLtORi/lANM/LAtEjtu0v/5K4KVnNMtCvLdD0Znda74hZ/9YOJhXALFfACKbhV14ew2D9Dg6Y3a
	gZt9FNg4mycaUIGEOjsg4=
X-Received: by 2002:a05:600c:528a:b0:47f:1a8d:4f30 with SMTP id 5b1f17b1804b1-4832021cd67mr28793385e9.26.1770370432345;
        Fri, 06 Feb 2026 01:33:52 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203e5b63sm26740685e9.1.2026.02.06.01.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:33:51 -0800 (PST)
Date: Fri, 6 Feb 2026 10:33:50 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH net-next V2 3/7] devlink: Add port resource netlink
 command
Message-ID: <d2a44w5lausinhwqagu332nkuxqmdrfjlrvt2piscd5cg3zjgf@jefnbqja5xbh>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
 <20260205142833.1727929-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205142833.1727929-4-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257502-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,nvidia.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 750B2FC16E
X-Rspamd-Action: no action

Thu, Feb 05, 2026 at 03:28:29PM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>
>
>Add support for userspace to query resources registered on devlink
>ports, allowing drivers to expose per-port resource limits and usage.
>
>Example output:
>
>  $ devlink port resource show
>  pci/0000:03:00.0/196608:
>    name max_SFs size 20 unit entry
>  pci/0000:03:00.1/262144:
>    name max_SFs size 20 unit entry
>
>  $ devlink port resource show pci/0000:03:00.0/196608
>  pci/0000:03:00.0/196608:
>    name max_SFs size 20 unit entry
>
>Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>---
> Documentation/netlink/specs/devlink.yaml |  23 ++++++
> include/uapi/linux/devlink.h             |   3 +
> net/devlink/netlink.c                    |   2 +-
> net/devlink/netlink_gen.c                |  32 ++++++-
> net/devlink/netlink_gen.h                |   6 +-
> net/devlink/resource.c                   | 101 +++++++++++++++++++++++
> 6 files changed, 164 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>index 837112da6738..0290db1b8393 100644
>--- a/Documentation/netlink/specs/devlink.yaml
>+++ b/Documentation/netlink/specs/devlink.yaml
>@@ -2336,3 +2336,26 @@ operations:
>             - bus-name
>             - dev-name
>             - port-index
>+
>+    -
>+      name: port-resource-get
>+      doc: Get port resources.
>+      attribute-set: devlink
>+      dont-validate: [strict]
>+      do:
>+        pre: devlink-nl-pre-doit-port
>+        post: devlink-nl-post-doit
>+        request:
>+          value: 85
>+          attributes: *port-id-attrs
>+        reply: &port-resource-get-reply
>+          value: 85
>+          attributes:
>+            - bus-name
>+            - dev-name
>+            - port-index
>+            - resource-list
>+      dump:
>+        request:
>+          attributes: *dev-id-attrs
>+        reply: *port-resource-get-reply
>diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>index e7d6b6d13470..1cabd1f6cba0 100644
>--- a/include/uapi/linux/devlink.h
>+++ b/include/uapi/linux/devlink.h
>@@ -141,6 +141,9 @@ enum devlink_command {
> 
> 	DEVLINK_CMD_NOTIFY_FILTER_SET,
> 
>+	DEVLINK_CMD_PORT_RESOURCE_GET,	/* can dump */
>+	DEVLINK_CMD_PORT_RESOURCE_SET,
>+
> 	/* add new commands above here */
> 	__DEVLINK_CMD_MAX,
> 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
>diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
>index 593605c1b1ef..c78c31779622 100644
>--- a/net/devlink/netlink.c
>+++ b/net/devlink/netlink.c
>@@ -367,7 +367,7 @@ struct genl_family devlink_nl_family __ro_after_init = {
> 	.module		= THIS_MODULE,
> 	.split_ops	= devlink_nl_ops,
> 	.n_split_ops	= ARRAY_SIZE(devlink_nl_ops),
>-	.resv_start_op	= DEVLINK_CMD_SELFTESTS_RUN + 1,
>+	.resv_start_op	= DEVLINK_CMD_PORT_RESOURCE_GET + 1,
> 	.mcgrps		= devlink_nl_mcgrps,
> 	.n_mcgrps	= ARRAY_SIZE(devlink_nl_mcgrps),
> 	.sock_priv_size		= sizeof(struct devlink_nl_sock_priv),
>diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
>index f4c61c2b4f22..692d7862183a 100644
>--- a/net/devlink/netlink_gen.c
>+++ b/net/devlink/netlink_gen.c
>@@ -604,8 +604,21 @@ static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_
> 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
> };
> 
>+/* DEVLINK_CMD_PORT_RESOURCE_GET - do */
>+static const struct nla_policy devlink_port_resource_get_do_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
>+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>+	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
>+};
>+
>+/* DEVLINK_CMD_PORT_RESOURCE_GET - dump */
>+static const struct nla_policy devlink_port_resource_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
>+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>+};
>+
> /* Ops table for devlink */
>-const struct genl_split_ops devlink_nl_ops[74] = {
>+const struct genl_split_ops devlink_nl_ops[76] = {
> 	{
> 		.cmd		= DEVLINK_CMD_GET,
> 		.validate	= GENL_DONT_VALIDATE_STRICT,
>@@ -1284,4 +1297,21 @@ const struct genl_split_ops devlink_nl_ops[74] = {
> 		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
> 		.flags		= GENL_CMD_CAP_DO,
> 	},
>+	{
>+		.cmd		= DEVLINK_CMD_PORT_RESOURCE_GET,
>+		.validate	= GENL_DONT_VALIDATE_STRICT,
>+		.pre_doit	= devlink_nl_pre_doit_port,
>+		.doit		= devlink_nl_port_resource_get_doit,
>+		.post_doit	= devlink_nl_post_doit,
>+		.policy		= devlink_port_resource_get_do_nl_policy,
>+		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
>+		.flags		= GENL_CMD_CAP_DO,
>+	},
>+	{
>+		.cmd		= DEVLINK_CMD_PORT_RESOURCE_GET,
>+		.dumpit		= devlink_nl_port_resource_get_dumpit,
>+		.policy		= devlink_port_resource_get_dump_nl_policy,
>+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
>+		.flags		= GENL_CMD_CAP_DUMP,
>+	},
> };
>diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
>index 2817d53a0eba..204a665d2fd2 100644
>--- a/net/devlink/netlink_gen.h
>+++ b/net/devlink/netlink_gen.h
>@@ -18,7 +18,7 @@ extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_
> extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
> 
> /* Ops table for devlink */
>-extern const struct genl_split_ops devlink_nl_ops[74];
>+extern const struct genl_split_ops devlink_nl_ops[76];
> 
> int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
> 			struct genl_info *info);
>@@ -146,5 +146,9 @@ int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
> int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
> int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
> 				      struct genl_info *info);
>+int devlink_nl_port_resource_get_doit(struct sk_buff *skb,
>+				      struct genl_info *info);
>+int devlink_nl_port_resource_get_dumpit(struct sk_buff *skb,
>+					struct netlink_callback *cb);
> 
> #endif /* _LINUX_DEVLINK_GEN_H */
>diff --git a/net/devlink/resource.c b/net/devlink/resource.c
>index 1b06a1f408fa..42ad7c96a740 100644
>--- a/net/devlink/resource.c
>+++ b/net/devlink/resource.c
>@@ -227,6 +227,7 @@ static int devlink_resource_fill(struct genl_info *info,
> 				 struct list_head *resource_list,
> 				 enum devlink_command cmd, int flags)
> {
>+	struct devlink_port *devlink_port = info->user_ptr[1];
> 	struct devlink *devlink = info->user_ptr[0];
> 	struct devlink_resource *resource;
> 	struct nlattr *resources_attr;
>@@ -257,6 +258,10 @@ static int devlink_resource_fill(struct genl_info *info,
> 	if (devlink_nl_put_handle(skb, devlink))
> 		goto nla_put_failure;
> 
>+	if (devlink_port && nla_put_u32(skb, DEVLINK_ATTR_PORT_INDEX,
>+					devlink_port->index))
>+		goto nla_put_failure;
>+
> 	resources_attr = nla_nest_start_noflag(skb,
> 					       DEVLINK_ATTR_RESOURCE_LIST);
> 	if (!resources_attr)
>@@ -576,3 +581,99 @@ void devl_port_resources_unregister(struct devlink_port *devlink_port)
> 				    &devlink_port->resource_list);
> }
> EXPORT_SYMBOL_GPL(devl_port_resources_unregister);
>+
>+static int devlink_nl_port_resource_fill(struct sk_buff *msg,
>+					 struct devlink_port *devlink_port,
>+					 enum devlink_command cmd,
>+					 u32 portid, u32 seq, int flags)
>+{
>+	struct devlink *devlink = devlink_port->devlink;
>+	struct devlink_resource *resource;
>+	struct nlattr *resources_attr;
>+	void *hdr;
>+
>+	if (list_empty(&devlink_port->resource_list))
>+		return 0;
>+
>+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
>+	if (!hdr)
>+		return -EMSGSIZE;
>+
>+	if (devlink_nl_put_handle(msg, devlink))
>+		goto nla_put_failure;
>+	if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, devlink_port->index))
>+		goto nla_put_failure;
>+
>+	resources_attr = nla_nest_start_noflag(msg, DEVLINK_ATTR_RESOURCE_LIST);
>+	if (!resources_attr)
>+		goto nla_put_failure;
>+
>+	list_for_each_entry(resource, &devlink_port->resource_list, list) {
>+		if (devlink_resource_put(devlink, msg, resource)) {
>+			nla_nest_cancel(msg, resources_attr);
>+			goto nla_put_failure;
>+		}
>+	}
>+	nla_nest_end(msg, resources_attr);
>+	genlmsg_end(msg, hdr);
>+	return 0;
>+
>+nla_put_failure:
>+	genlmsg_cancel(msg, hdr);
>+	return -EMSGSIZE;


Why you don't unify this function with existing devlink_resource_fill()?
Unnecessary code duplication, plus devlink_resource_fill() already know
how to handle multipart message.


This is related to my request to implement dump for devlink dev
resources. I would like to see the code unification for dump ops as
well.

Thanks!



>+}
>+
>+int devlink_nl_port_resource_get_doit(struct sk_buff *skb,
>+				      struct genl_info *info)
>+{
>+	struct devlink_port *devlink_port = info->user_ptr[1];
>+	struct sk_buff *msg;
>+	int err;
>+
>+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>+	if (!msg)
>+		return -ENOMEM;
>+
>+	err = devlink_nl_port_resource_fill(msg, devlink_port,
>+					    DEVLINK_CMD_PORT_RESOURCE_GET,
>+					    info->snd_portid, info->snd_seq, 0);
>+	if (err) {
>+		nlmsg_free(msg);
>+		return err;
>+	}
>+
>+	return genlmsg_reply(msg, info);
>+}
>+
>+static int
>+devlink_nl_port_resource_get_dump_one(struct sk_buff *msg,
>+				      struct devlink *devlink,
>+				      struct netlink_callback *cb, int flags)
>+{
>+	enum devlink_command cmd = DEVLINK_CMD_PORT_RESOURCE_GET;
>+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
>+	struct devlink_port *devlink_port;
>+	unsigned long port_index;
>+	int err;
>+
>+	xa_for_each_start(&devlink->ports, port_index, devlink_port,
>+			  state->idx) {
>+		err = devlink_nl_port_resource_fill(msg, devlink_port,
>+						    cmd,
>+						    NETLINK_CB(cb->skb).portid,
>+						    cb->nlh->nlmsg_seq, flags);
>+		if (err) {
>+			state->idx = port_index;
>+			return err;
>+		}
>+	}
>+
>+	return 0;
>+}
>+
>+int devlink_nl_port_resource_get_dumpit(struct sk_buff *skb,
>+					struct netlink_callback *cb)
>+{
>+	return devlink_nl_dumpit(skb, cb,
>+				 devlink_nl_port_resource_get_dump_one);
>+}
>-- 
>2.44.0
>

