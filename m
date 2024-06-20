Return-Path: <netdev+bounces-105235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E4F91038C
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F8E1F21DE3
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D28176255;
	Thu, 20 Jun 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbPphemy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2829F170826;
	Thu, 20 Jun 2024 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884799; cv=none; b=ffQOrL5golHcLHm3XPGzWQIzsshnqbYkZTznJOwKSCJWvAa16Nl1Z2ulPljgH18iHqDLVaq4cRLVNbfY0Bm1KbhsFLlae3MfU1ykvrtCFGU9RJPwoSSWK7VoJJUpOLm/rUbvc9i4CvqYxqq0DrqDAKEyPty9g9CJYQ30WqGNCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884799; c=relaxed/simple;
	bh=mMAyT118f4/SPrlUHPCnF5f1pdscHUbd4F1/9PWE/18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZjWTnqP3blyLqyul2to/Oxe8w1US1wyiL4g5uJPU/7KYR3apn0JjPrK7/hLVO+RGRU357RIvgL9AlJbnfn25up2MZUXhAvFWp4yzNNhtXAR19e/Uq1BvEpbCgTzSo9v4ZWwUzh8CSXSslKw9oexQfhuCHex4R5a9cBEcDBAUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbPphemy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f176c5c10so90747866b.2;
        Thu, 20 Jun 2024 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718884795; x=1719489595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=42CxBGdJ0osIF5zKhGnhoo5w2tPCyrYUZdNSZCktvaQ=;
        b=kbPphemyol6ory2MzEz1+2gHYC5s6pdP8SBhAnz9k8NpZjheoC95CNZb4F585Lzxsf
         hPjo0To/1Owudo92SnNrNmetBuZqp8wWnaj75QMofK1j8fC9coRVHBFGMMdBvhDXeVTy
         boaYol2ggQhar6J158Mj5ygOWprBPPFutU+gNApX9PRonDET5hi2Yfb0QpAHXyy3uhJ/
         Jkp5faHQrZNaYaNYQ7x8JQsCIp26XOx2b40XaijbItHqi/nI5MKBDMQqSmW0kJ7Pweo9
         OBSkUMTEOL1BXSykMkBl0JX5RstnK84JElV6wOsCo46xvQ56HJbmXRELpk3QPL0kcVIk
         ZbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884795; x=1719489595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42CxBGdJ0osIF5zKhGnhoo5w2tPCyrYUZdNSZCktvaQ=;
        b=WpW/zeNguVDo87pddbTYO/m4duG4cl9DH8p0/MMzqxb2j0jvhwgLiOZ0Iii9LLluh0
         z8UTOAj/kDMe7R/5RtaLRd3QkDcAMB9kmOeu+OSb1pYYlYt/1e4p0F5bDWXKvxUNjDFp
         2JUuH0FgwBE8r0shZxI8BDasHu9d9lvQzlOq1mOgB7mzx2sOqR0sDS0lUQhPB1960yop
         gdTD9+bh1o2nUVl1Ubf7TCgUUk7SvkrT1jXZdhQf8dOQ+Yd1h/+jyekOsdPUqHl5vmUr
         5iQawBDwYkVWj9EUYjnLnAq3GVPtuAn7N7wJ9tdNW2RrFzBSIBVZEurNI4ssJjZaaL17
         aJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeJCsdmFic4yDfLkxWpjvTemHh+mNN1zzqySIC2uf31HszJto5g8ocpBwn1Arn+sx6ro+L6g2KOInbu/gqAKV3NUZ/RiW/i6ANRhKj
X-Gm-Message-State: AOJu0YyOfXhO36bkUm0It2w1ghzjICy0eDYmeScxHX+tCMffxBSB/rvd
	5k0VDn3bP/eZSmL4rK749Q7n3PU3pXEd3fQ/Hy5YQBLjQ3tZeKvd
X-Google-Smtp-Source: AGHT+IH8cVHYscLefxIcEJuggnNxve65uQtNHTATNzJQbkd2CLkgy6BzKvjkgT+q137lRK6cHvNTMA==
X-Received: by 2002:a17:906:f902:b0:a6e:feb5:148e with SMTP id a640c23a62f3a-a6fab6171f0mr312135566b.27.1718884794846;
        Thu, 20 Jun 2024 04:59:54 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f6be36a5fsm604795366b.58.2024.06.20.04.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:59:54 -0700 (PDT)
Date: Thu, 20 Jun 2024 14:59:51 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/12] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20240620115951.3awsf7yt66t32buf@skbuf>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-3-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619205220.965844-3-paweldembicki@gmail.com>

On Wed, Jun 19, 2024 at 10:52:08PM +0200, Pawel Dembicki wrote:
> This patch implements VLAN filtering for the vsc73xx driver.
> 
> After starting VLAN filtering, the switch is reconfigured from QinQ to
> a simple VLAN aware mode. This is required because VSC73XX chips do not
> support inner VLAN tag filtering.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v2:
>   - removed not needed INIT_LIST_HEAD
>   - fix vsc73xx_vlan removing procedure
>   - fix code spell
>   - handle return codes from 'vsc73xx_vlan_commit*' functions
>   - move 'vsc73xx_vlan_commit*' call from port_setup to port_enable to
>     avoid unused port configuration
> v1:
>   - refactored pvid, untagged and vlan filter configuration
>   - fix typo
>   - simplification

Thanks for the changes. This is much simpler for my mind to process.
Hopefully you won't mind a few nitpicks below.

> +static int vsc73xx_set_vlan_conf(struct vsc73xx *vsc, int port,
> +				 enum vsc73xx_port_vlan_conf port_vlan_conf)
> +{
> +	u32 val = 0;
> +	int ret;
> +
> +	if (port_vlan_conf == VSC73XX_VLAN_IGNORE)
> +		val = VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA |
> +		      VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA;
> +
> +	ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +				  VSC73XX_CAT_VLAN_MISC,
> +				  VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA |
> +				  VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA, val);
> +	if (ret)
> +		return ret;
> +
> +	val = (port_vlan_conf == VSC73XX_VLAN_FILTER) ?
> +	      VSC73XX_TXUPDCFG_TX_INSERT_TAG : 0;
> +
> +	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +				   VSC73XX_TXUPDCFG,
> +				   VSC73XX_TXUPDCFG_TX_INSERT_TAG, val);
> +}
> +
> +static int vsc73xx_vlan_commit_conf(struct vsc73xx *vsc, int port)

Could you please add a kernel-doc stating what is the logical input and
output of this routine? Something like:

/**
 * vsc73xx_vlan_commit_conf - Update VLAN configuration of a port
 * @vsc: Switch private data structure
 * @port: Port index on which to operate
 *
 * Update the VLAN behavior of a port to make sure that when it is under
 * a VLAN filtering bridge, the port is either filtering with tag
 * preservation, or filtering with all VLANs egress-untagged. Otherwise,
 * the port ignores VLAN tags from packets and applies the port-based
 * VID.
 *
 * Must be called when changes are made to:
 * - the bridge VLAN filtering state of the port
 * - the number or attributes of VLANs from the bridge VLAN table,
 *   while the port is currently VLAN-aware
 */

> +{
> +	enum vsc73xx_port_vlan_conf port_vlan_conf = VSC73XX_VLAN_IGNORE;
> +	struct dsa_port *dp = dsa_to_port(vsc->ds, port);
> +
> +	if (port == CPU_PORT) {
> +		port_vlan_conf = VSC73XX_VLAN_FILTER;
> +	} else if (dsa_port_is_vlan_filtering(dp)) {
> +		struct vsc73xx_vlan_summary summary;
> +
> +		port_vlan_conf = VSC73XX_VLAN_FILTER;
> +
> +		vsc73xx_bridge_vlan_summary(vsc, port, &summary, VLAN_N_VID);
> +		if (summary.num_tagged == 0)
> +			port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
> +	}
> +
> +	return vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
> +}
> +
> +static int
> +vsc73xx_vlan_change_untagged(struct vsc73xx *vsc, int port, u16 vid, bool set)
> +{
> +	u32 val = 0;
> +
> +	if (set)
> +		val = VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA |
> +		      ((vid << VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT) &
> +		       VSC73XX_TXUPDCFG_TX_UNTAGGED_VID);
> +
> +	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +				   VSC73XX_TXUPDCFG,
> +				   VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA |
> +				   VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, val);
> +}
> +
> +static int vsc73xx_vlan_commit_untagged(struct vsc73xx *vsc, int port)

/**
 * vsc73xx_vlan_commit_untagged - Update native VLAN of a port
 * @vsc: Switch private data structure
 * @port: Port index on which to operate
 *
 * Update the native VLAN of a port (the one VLAN which is transmitted
 * as egress-tagged on a trunk port).
 *
 * TODO: I need to figure out more about the implementation :)
 */

> +{
> +	struct vsc73xx_portinfo *portinfo = &vsc->portinfo[port];
> +	bool valid = portinfo->untagged_tag_8021q_configured;
> +	struct dsa_port *dp = dsa_to_port(vsc->ds, port);
> +	u16 vid = portinfo->untagged_tag_8021q;

Question: when tag_8021q is active and the port is VSC73XX_VLAN_IGNORE,
does the untagged_tag_8021q VID matter at all?

> +
> +	if (dsa_port_is_vlan_filtering(dp)) {

If not, wouldn't it be better to just return early and do nothing
if !dsa_port_is_vlan_filtering(dp)?

> +		struct vsc73xx_vlan_summary summary;
> +
> +		vsc73xx_bridge_vlan_summary(vsc, port, &summary, VLAN_N_VID);
> +
> +		if (summary.num_untagged > 1)
> +			/* Port must untag all vlans in that case.
> +			 * No need to commit untagged config change.
> +			 */
> +			return 0;
> +
> +		valid = (summary.num_untagged == 1);
> +		if (valid)
> +			vid = vsc73xx_find_first_vlan_untagged(vsc, port);
> +	}
> +
> +	return vsc73xx_vlan_change_untagged(vsc, port, vid, valid);
> +}
> +
> +static int
> +vsc73xx_vlan_change_pvid(struct vsc73xx *vsc, int port, u16 vid, bool set)
> +{
> +	u32 val = 0;
> +	int ret;
> +
> +	val = set ? 0 : VSC73XX_CAT_DROP_UNTAGGED_ENA;
> +
> +	ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +				  VSC73XX_CAT_DROP,
> +				  VSC73XX_CAT_DROP_UNTAGGED_ENA, val);
> +	if (!set || ret)
> +		return ret;
> +
> +	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +				   VSC73XX_CAT_PORT_VLAN,
> +				   VSC73XX_CAT_PORT_VLAN_VLAN_VID,
> +				   vid & VSC73XX_CAT_PORT_VLAN_VLAN_VID);
> +}
> +

/**
 * vsc73xx_vlan_commit_pvid - Update port-based default VLAN of a port
 * @vsc: Switch private data structure
 * @port: Port index on which to operate
 *
 * Update the PVID of a port so that it follows either the bridge PVID
 * configuration, when the bridge is currently VLAN-aware, or the PVID
 * from tag_8021q, when the port is standalone or under a VLAN-unaware
 * bridge. A port with no PVID drops all untagged and VID 0 tagged
 * traffic.
 *
 * Must be called when changes are made to:
 * - the bridge VLAN filtering state of the port
 * - the number or attributes of VLANs from the bridge VLAN table,
 *   while the port is currently VLAN-aware
 */

> +static int vsc73xx_vlan_commit_pvid(struct vsc73xx *vsc, int port)
> +{
> +	struct vsc73xx_portinfo *portinfo = &vsc->portinfo[port];
> +	bool valid = portinfo->pvid_tag_8021q_configured;
> +	struct dsa_port *dp = dsa_to_port(vsc->ds, port);
> +	u16 vid = portinfo->pvid_tag_8021q;
> +
> +	if (dsa_port_is_vlan_filtering(dp)) {
> +		vid = portinfo->pvid_vlan_filtering;
> +		valid = portinfo->pvid_vlan_filtering_configured;
> +	}
> +
> +	return vsc73xx_vlan_change_pvid(vsc, port, vid, valid);
> +}
> +
>  static int vsc73xx_port_enable(struct dsa_switch *ds, int port,
>  			       struct phy_device *phy)
>  {
>  	struct vsc73xx *vsc = ds->priv;
> +	int ret;
>  
>  	dev_info(vsc->dev, "enable port %d\n", port);
>  	vsc73xx_init_port(vsc, port);
>  
> -	return 0;
> +	ret = vsc73xx_vlan_commit_untagged(vsc, port);
> +	if (ret)
> +		return ret;
> +
> +	ret = vsc73xx_vlan_commit_pvid(vsc, port);
> +	if (ret)
> +		return ret;
> +
> +	return vsc73xx_vlan_commit_conf(vsc, port);
>  }
>  
>  static void vsc73xx_port_disable(struct dsa_switch *ds, int port)
> @@ -1032,6 +1361,184 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
>  	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
>  }
>  
> +static int
> +vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
> +			    bool vlan_filtering, struct netlink_ext_ack *extack)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +	int ret;
> +
> +	/* The commit to hardware processed below is required because vsc73xx
> +	 * is using tag_8021q. When vlan_filtering is disabled, tag_8021q uses
> +	 * pvid/untagged vlans for port recognition. The values configured for
> +	 * vlans and pvid/untagged states are stored in portinfo structure.
> +	 * When vlan_filtering is enabled, we need to restore pvid/untagged from
> +	 * portinfo structure. Analogous routine is processed when
> +	 * vlan_filtering is disabled, but values used for tag_8021q are
> +	 * restored.
> +	 */
> +	ret = vsc73xx_vlan_commit_untagged(vsc, port);
> +	if (ret)
> +		return ret;
> +
> +	ret = vsc73xx_vlan_commit_pvid(vsc, port);
> +	if (ret)
> +		return ret;
> +
> +	return vsc73xx_vlan_commit_conf(vsc, port);

Could you please group these 3 calls together in a separate subroutine,
like vsc73xx_port_update_vlan(), and just call that? The pattern is
repeated in a number of places.

> +}
> +
> +static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan,
> +				 struct netlink_ext_ack *extack)
> +{
> +	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> +	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
> +	struct vsc73xx_vlan_summary summary;
> +	struct vsc73xx_portinfo *portinfo;
> +	struct vsc73xx *vsc = ds->priv;
> +	bool commit_to_hardware;
> +	int ret = 0;
> +
> +	/* Be sure to deny alterations to the configuration done by tag_8021q.
> +	 */
> +	if (vid_is_dsa_8021q(vlan->vid)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Range 3072-4095 reserved for dsa_8021q operation");
> +		return -EBUSY;
> +	}
> +
> +	/* The processed vlan->vid is excluded from the search because the VLAN
> +	 * can be re-added with a different set of flags, so it's easiest to
> +	 * ignore its old flags from the VLAN database software copy.
> +	 */
> +	vsc73xx_bridge_vlan_summary(vsc, port, &summary, vlan->vid);
> +
> +	/* VSC73XX allow only three untagged states: none, one or all */

allows

> +	if ((untagged && summary.num_tagged > 0 && summary.num_untagged > 0) ||
> +	    (!untagged && summary.num_untagged > 1)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Port can have only none, one or all untagged vlan");
> +		return -EBUSY;
> +	}
> +
> +	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
> +
> +	if (!vsc73xx_vlan) {
> +		vsc73xx_vlan = kzalloc(sizeof(*vsc73xx_vlan), GFP_KERNEL);
> +		if (!vsc73xx_vlan)
> +			return -ENOMEM;
> +
> +		vsc73xx_vlan->vid = vlan->vid;
> +		vsc73xx_vlan->portmask = 0;
> +		vsc73xx_vlan->untagged = 0;

kzalloc gives you 0-initialized memory, so "portmask" and "untagged" are
already 0.

> +
> +		list_add_tail(&vsc73xx_vlan->list, &vsc->vlans);
> +	}
> +
> +	/* CPU port must be always tagged because port separation is based on
> +	 * tag_8021q.

I would say "source port identification" rather than separation.

> +	 */
> +	if (port == CPU_PORT)
> +		goto update_vlan_table;
> +
> +	vsc73xx_vlan->portmask |= BIT(port);
> +
> +	if (untagged)
> +		vsc73xx_vlan->untagged |= BIT(port);
> +	else
> +		vsc73xx_vlan->untagged &= ~BIT(port);
> +
> +	portinfo = &vsc->portinfo[port];
> +
> +	if (pvid) {
> +		portinfo->pvid_vlan_filtering_configured = true;
> +		portinfo->pvid_vlan_filtering = vlan->vid;
> +	} else if (portinfo->pvid_vlan_filtering_configured &&
> +		   portinfo->pvid_vlan_filtering == vlan->vid) {
> +		portinfo->pvid_vlan_filtering_configured = false;
> +	}
> +
> +	commit_to_hardware = !vsc73xx_tag_8021q_active(dp);
> +	if (commit_to_hardware) {
> +		ret = vsc73xx_vlan_commit_untagged(vsc, port);
> +		if (ret)
> +			goto err;
> +
> +		ret = vsc73xx_vlan_commit_pvid(vsc, port);
> +		if (ret)
> +			goto err;
> +
> +		ret =  vsc73xx_vlan_commit_conf(vsc, port);
> +		if (ret)
> +			goto err;
> +	}
> +
> +update_vlan_table:
> +	ret = vsc73xx_update_vlan_table(vsc, port, vlan->vid, true);
> +	if (!ret)
> +		return 0;
> +err:
> +	vsc73xx_bridge_vlan_remove_port(vsc73xx_vlan, port);
> +	return ret;
> +}
> +
> +static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan)
> +{
> +	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
> +	struct vsc73xx_portinfo *portinfo;
> +	struct vsc73xx *vsc = ds->priv;
> +	bool commit_to_hardware;
> +	int ret;
> +
> +	ret = vsc73xx_update_vlan_table(vsc, port, vlan->vid, false);
> +	if (ret)
> +		return ret;
> +
> +	portinfo = &vsc->portinfo[port];
> +
> +	if (portinfo->pvid_vlan_filtering_configured &&
> +	    portinfo->pvid_vlan_filtering == vlan->vid)
> +		portinfo->pvid_vlan_filtering_configured = false;
> +
> +	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
> +
> +	if (vsc73xx_vlan)
> +		vsc73xx_bridge_vlan_remove_port(vsc73xx_vlan, port);
> +
> +	commit_to_hardware = !vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
> +	if (commit_to_hardware) {
> +		ret = vsc73xx_vlan_commit_untagged(vsc, port);
> +		if (ret)
> +			return ret;
> +
> +		ret = vsc73xx_vlan_commit_pvid(vsc, port);
> +		if (ret)
> +			return ret;
> +
> +		return vsc73xx_vlan_commit_conf(vsc, port);
> +	}
> +
> +	return 0;
> +}
> +
> +static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
> +{
> +	struct vsc73xx_portinfo *portinfo;
> +	struct vsc73xx *vsc = ds->priv;
> +
> +	portinfo = &vsc->portinfo[port];
> +
> +	portinfo->pvid_vlan_filtering_configured = false;
> +	portinfo->pvid_tag_8021q_configured = false;
> +	portinfo->untagged_tag_8021q_configured = false;

Initialization with 0, false etc isn't really needed. Not worth adding a
DSA callback for no useful action.

> +
> +	return 0;
> +}
> +
>  static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
>  {
>  	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
> @@ -1126,11 +1633,15 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.get_strings = vsc73xx_get_strings,
>  	.get_ethtool_stats = vsc73xx_get_ethtool_stats,
>  	.get_sset_count = vsc73xx_get_sset_count,
> +	.port_setup = vsc73xx_port_setup,
>  	.port_enable = vsc73xx_port_enable,
>  	.port_disable = vsc73xx_port_disable,
>  	.port_change_mtu = vsc73xx_change_mtu,
>  	.port_max_mtu = vsc73xx_get_max_mtu,
>  	.port_stp_state_set = vsc73xx_port_stp_state_set,
> +	.port_vlan_filtering = vsc73xx_port_vlan_filtering,
> +	.port_vlan_add = vsc73xx_port_vlan_add,
> +	.port_vlan_del = vsc73xx_port_vlan_del,
>  	.phylink_get_caps = vsc73xx_phylink_get_caps,
>  };
>  
> diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> index 2997f7e108b1..3c7586868e1b 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx.h
> +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> @@ -14,6 +14,27 @@
>   */
>  #define VSC73XX_MAX_NUM_PORTS	8
>  
> +/**
> + * struct vsc73xx_portinfo - port data structure: contains storage data
> + * @pvid_vlan_filtering_configured: imforms if port have configured pvid in vlan
> + *	filtering mode
> + * @pvid_vlan_filtering: pvid vlan number used in vlan filtering mode
> + * @pvid_tag_8021q_configured: imforms if port have configured pvid in tag_8021q
> + *	mode
> + * @pvid_tag_8021q: pvid vlan number used in tag_8021q mode
> + * @untagged_tag_8021q_configured: imforms if port have configured untagged vlan
> + *	in tag_8021q mode
> + * @untagged_tag_8021q: untagged vlan number used in tag_8021q mode
> + */

s/imforms/informs/
s/port have/port has/

> +struct vsc73xx_portinfo {
> +	bool		pvid_vlan_filtering_configured;
> +	u16		pvid_vlan_filtering;
> +	bool		pvid_tag_8021q_configured;
> +	u16		pvid_tag_8021q;
> +	bool		untagged_tag_8021q_configured;
> +	u16		untagged_tag_8021q;
> +};
> +

I think it may be more economical to put all u16 elements first, then
all bool elements. Pahole should be able to tell.

>  /**
>   * struct vsc73xx - VSC73xx state container: main data structure
>   * @dev: The device pointer
> @@ -25,6 +46,10 @@
>   * @addr: MAC address used in flow control frames
>   * @ops: Structure with hardware-dependent operations
>   * @priv: Pointer to the configuration interface structure
> + * @portinfo: Storage table portinfo structructures
> + * @vlans: List of configured vlans. Contains port mask and untagged status of
> + *	every vlan configured in port vlan operation. It doesn't cover tag_8021q
> + *	vlans.
>   */
>  struct vsc73xx {
>  	struct device			*dev;
> @@ -35,6 +60,8 @@ struct vsc73xx {
>  	u8				addr[ETH_ALEN];
>  	const struct vsc73xx_ops	*ops;
>  	void				*priv;
> +	struct vsc73xx_portinfo		portinfo[VSC73XX_MAX_NUM_PORTS];
> +	struct list_head		vlans;
>  };
>  
>  /**
> @@ -49,6 +76,21 @@ struct vsc73xx_ops {
>  		     u32 val);
>  };
>  
> +/**
> + * struct vsc73xx_bridge_vlan - VSC73xx driver structure which keeps vlan
> + *	database copy
> + * @vid: VLAN number
> + * @portmask: each bit represents one port
> + * @untagged: each bit represents one port configured with @vid untagged
> + * @list: list structure
> + */
> +struct vsc73xx_bridge_vlan {
> +	u16 vid;
> +	u8 portmask;
> +	u8 untagged;
> +	struct list_head list;
> +};
> +
>  int vsc73xx_is_addr_valid(u8 block, u8 subblock);
>  int vsc73xx_probe(struct vsc73xx *vsc);
>  void vsc73xx_remove(struct vsc73xx *vsc);
> -- 
> 2.34.1
> 

