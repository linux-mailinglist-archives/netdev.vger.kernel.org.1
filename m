Return-Path: <netdev+bounces-189126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B51AAB0895
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 05:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE40D7AE072
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 03:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE9123817E;
	Fri,  9 May 2025 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL0DS+G5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B617D2;
	Fri,  9 May 2025 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760244; cv=none; b=EOwOdiboZn1tPNYm68qWhf+yr0L8+lUWbarbSZ//BB6twsGyOjzJxnfa1Cu2h4joRpc+akqnXwdDyx7C/F0YWWwBvk2uM8buu1q7BA35iwpFmEgEhg1VPil/3dwGSa4mknAQAuQM5EZnkFPsKQZGCNBlwP5JnredQOM1qmYH6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760244; c=relaxed/simple;
	bh=s1ETFXOwwqofly5aQjxNB4thS4bfGifegfni1cfZo20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzIkxqgPpHjvOIvuU86X+VFR07kGfL75GF5vOK1ofkAzABFaTwB8WpwSneWnzfy4Pn2+n/cTHZPV9ZubTWIjNiokwFKp1JjB+5u+PmcPul/PV1h1en2TecxfH0anatXSR6gtJCW8x6X+TX47HxIAtTrZJ12f+N/cpLXA8J2ec4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL0DS+G5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1B5C4CEE7;
	Fri,  9 May 2025 03:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746760243;
	bh=s1ETFXOwwqofly5aQjxNB4thS4bfGifegfni1cfZo20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JL0DS+G5sEsymGT+cBPZljtBjjAuRhBF6f6Zn7RrF9H7jkyN9248J8Qbp3vHEvQdP
	 tfSyRCo/UWYwOHECkOSvVtZ3ekW/Nw+3vACqrOcUK0C2k5wxUEhxYLuztTkJO2Fx0T
	 FvsQc7oq4FdDVoRA5jkC7NRVdA5Ss5YWqk9Co7+ACrENo6jrfNfdg8TeEg1kBBMaS3
	 Ap9hljvvX2QtZ2dNLf9QcZ+elUTQePrbJTAK4QbZ9KcRycSfAduhQS1sc/FZgrig7b
	 6ZtXxmsQX+0CfT1F+7E3jChHeQQyqQQuo8Divi5b33jVT0M5ERZXCLnx36gL31smLt
	 wSKWVHglaWYgA==
Date: Thu, 8 May 2025 20:10:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 02/13] net: pse-pd: Add support for
 reporting events
Message-ID: <20250508201041.40566d3f@kernel.org>
In-Reply-To: <20250506-feature_poe_port_prio-v10-2-55679a4895f9@bootlin.com>
References: <20250506-feature_poe_port_prio-v10-0-55679a4895f9@bootlin.com>
	<20250506-feature_poe_port_prio-v10-2-55679a4895f9@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 May 2025 11:38:34 +0200 Kory Maincent wrote:
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index c650cd3dcb80..fbfd293987c1 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -98,6 +98,12 @@ definitions:
>      name: tcp-data-split
>      type: enum
>      entries: [ unknown, disabled, enabled ]
> +  -
> +    name: pse-events
> +    type: flags
> +    name-prefix: ethtool-pse-event-
> +    header: linux/ethtool.h
> +    entries: [ over-current, over-temp ]

please change this enum similarly to what I suggested on the hwts
source patch

>  attribute-sets:
>    -
> @@ -1528,6 +1534,18 @@ attribute-sets:
>          name: hwtstamp-flags
>          type: nest
>          nested-attributes: bitset
> +  -
> +    name: pse-ntf
> +    attr-cnt-name: __ethtool-a-pse-ntf-cnt

please use -- instead of underscores

> +    attributes:
> +      -
> +        name: header
> +        type: nest
> +        nested-attributes: header
> +      -
> +        name: events
> +        type: uint
> +        enum: pse-events

A tiny "doc:" here or better explanation in the Documentation/ 
may be nice. I thought it was a counter when I first looked...


> +  ===============================  ======  ========================
> +  ``ETHTOOL_A_PSE_HEADER``         nested  request header
> +  ``ETHTOOL_A_PSE_EVENTS``         bitset  PSE events
> +  ===============================  ======  ========================
> +
> +When set, the optional ``ETHTOOL_A_PSE_EVENTS`` attribute identifies the
> +PSE events.
> +
> +.. kernel-doc:: include/uapi/linux/ethtool.h
> +    :identifiers: ethtool_pse_events

I guess in HTML the enum will get rendered here so it will be clearer.

>  static DEFINE_MUTEX(pse_list_mutex);
>  static LIST_HEAD(pse_controller_list);
> @@ -23,6 +27,7 @@ static LIST_HEAD(pse_controller_list);
>   * @list: list entry for the pcdev's PSE controller list
>   * @id: ID of the PSE line in the PSE controller device
>   * @refcnt: Number of gets of this pse_control
> + * @attached_phydev: PHY device pointer attached by the PSE control
>   */
>  struct pse_control {
>  	struct pse_controller_dev *pcdev;
> @@ -30,6 +35,7 @@ struct pse_control {
>  	struct list_head list;
>  	unsigned int id;
>  	struct kref refcnt;
> +	struct phy_device *attached_phydev;
>  };

Adding the attached_phydev should be a separate patch, I think

>  static int of_load_single_pse_pi_pairset(struct device_node *node,
> @@ -208,6 +214,52 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
>  	return ret;
>  }
>  
> +/**
> + * pse_control_find_net_by_id - Find net attached to the pse control id
> + * @pcdev: a pointer to the PSE
> + * @id: index of the PSE control
> + * @tracker: refcount tracker used by netdev
> + *
> + * Return: net device pointer or NULL. The device returned has had a
> + *	   reference added and the pointer is safe until the user calls
> + *	   netdev_put() to indicate they have finished with it.
> + */
> +static struct net_device *
> +pse_control_find_net_by_id(struct pse_controller_dev *pcdev, int id,
> +			   netdevice_tracker *tracker)
> +{
> +	struct pse_control *psec, *next;
> +
> +	mutex_lock(&pse_list_mutex);
> +	list_for_each_entry_safe(psec, next, &pcdev->pse_control_head, list) {
> +		if (psec->id == id) {
> +			struct net_device *netdev = NULL;
> +			struct phy_device *phydev;
> +
> +			kref_get(&psec->refcnt);
> +			/* Release the mutex before taking the rtnl lock
> +			 * to avoid deadlock in case of a pse_control_put
> +			 * call with the rtnl lock held.
> +			 */
> +			mutex_unlock(&pse_list_mutex);
> +			/* Acquire rtnl to protect the net device
> +			 * reference get.
> +			 */
> +			rtnl_lock();
> +			phydev = psec->attached_phydev;
> +			if (phydev->attached_dev) {
> +				netdev = phydev->attached_dev;
> +				netdev_hold(netdev, tracker, GFP_ATOMIC);

GFP_KERNEL ?

> +			}
> +			rtnl_unlock();
> +			pse_control_put(psec);
> +			return netdev;
> +		}
> +	}
> +	mutex_unlock(&pse_list_mutex);
> +	return NULL;
> +}
> +
>  static int pse_pi_is_enabled(struct regulator_dev *rdev)
>  {
>  	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);

> +/**
> + * devm_pse_irq_helper - Register IRQ based PSE event notifier
> + *

Why the empty line here but not in the other kdocs?

> + * @pcdev: a pointer to the PSE
> + * @irq: the irq value to be passed to request_irq
> + * @irq_flags: the flags to be passed to request_irq
> + * @d: PSE interrupt description
> + *
> + * Return: 0 on success and failure value on error

... and errno on failure ?

> + */

> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index 4f6b99eab2a6..1234bce46413 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -12,6 +12,7 @@
>  #include <linux/ethtool_netlink.h>
>  #include <linux/ethtool.h>
>  #include <linux/phy.h>
> +#include "bitset.h"

Unused include.

>  struct pse_req_info {
>  	struct ethnl_req_info base;
> @@ -315,3 +316,46 @@ const struct ethnl_request_ops ethnl_pse_request_ops = {
>  	.set			= ethnl_set_pse,
>  	/* PSE has no notification */
>  };
> +
> +void ethnl_pse_send_ntf(struct net_device *netdev, unsigned long notifs,
> +			struct netlink_ext_ack *extack)
> +{
> +	struct genl_info info;
> +	void *reply_payload;
> +	struct sk_buff *skb;
> +	int reply_len;
> +	int ret;
> +
> +	if (!netdev || !notifs)
> +		return;
> +
> +	ethnl_info_init_ntf(&info, ETHTOOL_MSG_PSE_NTF);
> +	info.extack = extack;

You don't seem to be using this info for anything.

> +	reply_len = ethnl_reply_header_size() +
> +		    nla_total_size(sizeof(u32)); /* _PSE_NTF_EVENTS */
> +
> +	skb = genlmsg_new(reply_len, GFP_KERNEL);
> +	if (!skb)
> +		return;
> +
> +	reply_payload = ethnl_bcastmsg_put(skb, ETHTOOL_MSG_PSE_NTF);
> +	if (!reply_payload)
> +		goto err_skb;
> +
> +	ret = ethnl_fill_reply_header(skb, netdev,
> +				      ETHTOOL_A_PSE_NTF_HEADER);

first on a single line

> +	if (ret < 0)
> +		goto err_skb;
> +
> +	if (nla_put_u32(skb, ETHTOOL_A_PSE_NTF_EVENTS, notifs))

put_uint? Or make notifs argument u32, either way is fine, since we only
have 2 bits defined now. The mixing is a bit surprising.

> +		goto err_skb;
> +
> +	genlmsg_end(skb, reply_payload);
> +	ethnl_multicast(skb, netdev);


