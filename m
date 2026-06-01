Return-Path: <netdev+bounces-293570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF5uCaQlHWq6VwkAu9opvQ
	(envelope-from <netdev+bounces-293570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:24:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F97061A21D
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED6773006807
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923D3345757;
	Mon,  1 Jun 2026 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfTE0fNs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0AA1509AB
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294963; cv=none; b=cyYTfpiG4aI4i5n1B0ANmzaI1jXJ6qWvzOJ8rMW7yY15iqrgUp4OcWEQyH7bdkC1hVO4Ud36L+cZTqCTW8WZNK82GQEuVTO9f+CZ69fgomPXLP/hc4nBptV/72Mb4RgHJLobpz3K2JLMxfV2rconiKXe4qTYOTg97w9CMbupE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294963; c=relaxed/simple;
	bh=Sx5zVba1AnX22ZdgFk3iq6VA/32aXNUgrcVM0sKLbKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6reLeUB+vMhs3/0zXoi2Y/UhxBkthaq6hoK7YLrXPRBiQUpF4fTU0qIOusFsm4PHxlYHKhWVzoniqGTt3aw2NCjqAaXFzhsnpgy0XFGcU/NYgEAA55vuv58ONmglaAK8gltf9gGW0YwIvAh05JrscVZNRLEt4AZI5KY8iy8SiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfTE0fNs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780294961; x=1811830961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sx5zVba1AnX22ZdgFk3iq6VA/32aXNUgrcVM0sKLbKs=;
  b=IfTE0fNsjQoMCrZG4qqwODmPo93QH0bBOA9v+JZ1rpTFig1OO/Vyim3I
   /t7j7Hz8f3nhqUBJuUIR59/wDU/IvHW4B+2RSVKCICbINM6+F0fIvHJfU
   1Cb0KUZpvPwNX5fyHgI0yyk/npfCONiz5y8Q3J87BsU+G3lh0H3T1vXKP
   ZOTgtgPq36KU41kL1BnaPDcRi9S+8VxeDJHJCGo0LNY2Ll43LYQcmls0r
   V/m/49MTho6DQlElQWiB95LQxoORxM5qMKjWLtq9oPVvs7ZKvH9r38tON
   ww3X9zsvUvCGhydC0q5r/6NIpyvYOszrkiXzuDaTpDPS5CwdPqLSX/sLa
   A==;
X-CSE-ConnectionGUID: N3e+9cW5SyiZv3kVe4+qMg==
X-CSE-MsgGUID: Gn9ZTi3UQHCNFRi+YyYK+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="103715402"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="103715402"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 23:22:41 -0700
X-CSE-ConnectionGUID: ufpCYVqRRF2F1Oh/RIvP4A==
X-CSE-MsgGUID: npbwBp4JQJiUwauMNi5VfA==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 23:22:36 -0700
Date: Mon, 1 Jun 2026 08:22:33 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, kuba@kernel.org,
	simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
	maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 1/2] drm/drm_ras: Add drm_ras netlink error event
Message-ID: <ah0lKbnM9CD3JQoG@black.igk.intel.com>
References: <20260518112048.1746280-4-riana.tauro@intel.com>
 <20260518112048.1746280-5-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518112048.1746280-5-riana.tauro@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com];
	TAGGED_FROM(0.00)[bounces-293570-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,amd.com:email,intel.com:email,intel.com:dkim,davemloft.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,black.igk.intel.com:mid]
X-Rspamd-Queue-Id: 1F97061A21D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 04:50:50PM +0530, Riana Tauro wrote:
> Define a new netlink event 'error-event' and a new multicast group
> 'error-notify' in drm_ras. Each event contains device name, node and
> error information to identify the error triggering the event.
> 
> Add drm_ras_nl_error_event() to trigger an event from the driver.
> Userspace must subscribe to 'error-notify' to receive 'error-event'
> notifications.
> 
> Usage:
> 
>     $ sudo ./tools/net/ynl/pyynl/cli.py --family drm_ras \

Nit: Make the leading space consistent with other patches.

>       --subscribe error-notify
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
> ---
>  Documentation/gpu/drm-ras.rst            | 21 ++++++
>  Documentation/netlink/specs/drm_ras.yaml | 50 ++++++++++++++
>  drivers/gpu/drm/drm_ras.c                | 86 ++++++++++++++++++++++++
>  drivers/gpu/drm/drm_ras_nl.c             |  6 ++
>  drivers/gpu/drm/drm_ras_nl.h             |  4 ++
>  include/drm/drm_ras.h                    |  5 ++
>  include/uapi/drm/drm_ras.h               | 15 +++++
>  7 files changed, 187 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index 83c21853b74b..5a96dde75539 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -56,6 +56,7 @@ User space tools can:
>    ``node-id`` and ``error-id`` as parameters.
>  * Clear specific error counters with the ``clear-error-counter`` command, using both
>    ``node-id`` and ``error-id`` as parameters.
> +* Subscribe to the ``error-notify`` multicast group to receive ``error-event`` notifications.
>  
>  YAML-based Interface
>  --------------------
> @@ -111,3 +112,23 @@ Example: Clear an error counter for a given node
>  
>      sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>      None
> +
> +Example: Subscribe to ``error-notify`` multicast group
> +
> +.. code-block:: bash
> +
> +    sudo ./tools/net/ynl/pyynl/cli.py --family drm_ras --output-json --subscribe error-notify

So ynl can't do this? If yes, make it consistent with other commands
(and also in commit message). If no, please document it.

> +
> +.. code-block:: json
> +
> +    {
> +        "name": "error-event",
> +        "msg": {
> +            "device-name": "0000:03:00.0",
> +            "node-id": 1,
> +            "node-name": "uncorrectable-errors",
> +            "error-id": 1,
> +            "error-name": "error_name1",
> +            "error-value": 1
> +        }
> +    }
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index e113056f8c01..d94c73a61aea 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -69,6 +69,35 @@ attribute-sets:
>          name: error-value
>          type: u32
>          doc: Current value of the requested error counter.
> +  -
> +    name: error-event-attrs
> +    attributes:
> +      -
> +        name: device-name
> +        type: string
> +        doc: >-
> +             Device name chosen by the driver at registration.
> +             Can be a PCI BDF, UUID, or module name if unique.
> +      -
> +        name: node-id

Curious, can we reuse existing partial attr-set?

> +        type: u32
> +        doc: Node ID of the node that triggered the event.
> +      -
> +        name: node-name
> +        type: string
> +        doc: Node name of the node that triggered the event.
> +      -
> +        name: error-id
> +        type: u32
> +        doc: Error ID of the counter that triggered the event.
> +      -
> +        name: error-name
> +        type: string
> +        doc: Name of the error that triggered the event.
> +      -
> +        name: error-value
> +        type: u32
> +        doc: Current value of the error counter.
>  
>  operations:
>    list:
> @@ -124,3 +153,24 @@ operations:
>        do:
>          request:
>            attributes: *id-attrs
> +    -
> +      name: error-event
> +      doc: >-
> +           Notify userspace of an error event.
> +           The event includes the device, node and error information
> +           of the error that triggered the event.
> +      attribute-set: error-event-attrs
> +      mcgrp: error-notify
> +      event:
> +        attributes:
> +          - device-name
> +          - node-id
> +          - node-name
> +          - error-id
> +          - error-name
> +          - error-value
> +
> +mcast-groups:
> +  list:
> +    -
> +      name: error-notify
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394..6696ec21782e 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -41,6 +41,11 @@
>   *    Userspace must provide Node ID, Error ID.
>   *    Clears specific error counter of a node if supported.
>   *
> + * 4. ERROR_NOTIFY: Subscribe to this multicast group to receive error events
> + *
> + * 5. ERROR_EVENT: Notify userspace of an error event. The event contains device, node
> + *    and error information that triggered the event.
> + *
>   * Node registration:
>   *
>   * - drm_ras_node_register(): Registers a new node and assigns
> @@ -186,6 +191,34 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>  			   value);
>  }
>  
> +static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *node,
> +				     u32 error_id, const char *error_name, u32 value)
> +{
> +	int ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME, node->device_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID, node->id);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME, node->node_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID, error_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME, error_name);
> +	if (ret)
> +		return ret;
> +
> +	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value);
> +}
> +
>  static int doit_reply_value(struct genl_info *info, u32 node_id,
>  			    u32 error_id)
>  {
> @@ -222,6 +255,59 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>  	return genlmsg_reply(msg, info);
>  }
>  
> +/**
> + * drm_ras_nl_error_event() - Notify listeners of an error event
> + * @node: Node structure
> + * @error_id: ID of the error
> + * @error_name: Name of the error
> + * @value: Value associated with the error
> + * @flags: GFP flags for memory allocation
> + *
> + * Sends a notification to all listeners about an error event on a specific
> + * RAS node.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
> +			   u32 value, gfp_t flags)
> +{
> +	struct genl_info info;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	int err = -EMSGSIZE;

Redundant initialization, see below.

> +	if (!error_name)
> +		return -EINVAL;
> +
> +	if (!genl_has_listeners(&drm_ras_nl_family, &init_net, DRM_RAS_NLGRP_ERROR_NOTIFY))
> +		return 0;
> +
> +	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
> +	msg = genlmsg_new(NLMSG_GOODSIZE, flags);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(msg, &info);

Make this part of below and return err directly.

> +	if (!hdr)
> +		goto err_free_msg;
> +
> +	err = msg_put_error_event_attrs(msg, node, error_id, error_name, value);
> +	if (err)
> +		goto err_cancel;
> +
> +	genlmsg_end(msg, hdr);
> +	genlmsg_multicast(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_NOTIFY, flags);
> +	return 0;
> +
> +err_cancel:
> +	genlmsg_cancel(msg, hdr);
> +err_free_msg:
> +	nlmsg_free(msg);
> +	return err;
> +}
> +EXPORT_SYMBOL(drm_ras_nl_error_event);
> +
>  /**
>   * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
>   * @skb: Netlink message buffer
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index dea1c1b2494e..ac724bb87a3b 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>  	},
>  };
>  
> +static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> +	[DRM_RAS_NLGRP_ERROR_NOTIFY] = { "error-notify", },
> +};
> +
>  struct genl_family drm_ras_nl_family __ro_after_init = {
>  	.name		= DRM_RAS_FAMILY_NAME,
>  	.version	= DRM_RAS_FAMILY_VERSION,
> @@ -66,4 +70,6 @@ struct genl_family drm_ras_nl_family __ro_after_init = {
>  	.module		= THIS_MODULE,
>  	.split_ops	= drm_ras_nl_ops,
>  	.n_split_ops	= ARRAY_SIZE(drm_ras_nl_ops),
> +	.mcgrps		= drm_ras_nl_mcgrps,
> +	.n_mcgrps	= ARRAY_SIZE(drm_ras_nl_mcgrps),
>  };
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index a398643572a5..17e1af8cc3b3 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>  int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>  					struct genl_info *info);
>  
> +enum {
> +	DRM_RAS_NLGRP_ERROR_NOTIFY,
> +};
> +
>  extern struct genl_family drm_ras_nl_family;
>  
>  #endif /* _LINUX_DRM_RAS_GEN_H */
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index f2a787bc4f64..d4a275efdbb0 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -78,9 +78,14 @@ struct drm_device;
>  #if IS_ENABLED(CONFIG_DRM_RAS)
>  int drm_ras_node_register(struct drm_ras_node *node);
>  void drm_ras_node_unregister(struct drm_ras_node *node);
> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
> +			   u32 value, gfp_t flags);
>  #else
>  static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
>  static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
> +static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
> +					 const char *error_name, u32 value, gfp_t flags)
> +{ return 0; }
>  #endif
>  
>  #endif
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 218a3ee86805..bb2a8a872a44 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -38,13 +38,28 @@ enum {
>  	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
>  };
>  
> +enum {
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME = 1,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE,
> +
> +	__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
> +};
> +
>  enum {
>  	DRM_RAS_CMD_LIST_NODES = 1,
>  	DRM_RAS_CMD_GET_ERROR_COUNTER,
>  	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> +	DRM_RAS_CMD_ERROR_EVENT,
>  
>  	__DRM_RAS_CMD_MAX,
>  	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
>  };
>  
> +#define DRM_RAS_MCGRP_ERROR_NOTIFY	"error-notify"

Where is this used?

Raag

>  #endif /* _UAPI_LINUX_DRM_RAS_H */
> -- 
> 2.47.1
> 

