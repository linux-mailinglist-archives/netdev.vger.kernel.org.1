Return-Path: <netdev+bounces-241641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26C6C87112
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3390C3B68CA
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D262D3218;
	Tue, 25 Nov 2025 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWolHSHN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD12C234A
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102687; cv=none; b=uIBnyDvgo78P4AXCUZOPa1F0Y3vrBt9njmvR/VNSB+PDmUbo8t6K6vJYBegcGeAK60ITzvzQo/MF82MNDKdsqLZXqqbiH+7euv1FnxkWWbfeDX0QItrmmuKUf5XVueuuppiqUDqVCIEits11kpwSeyicGZW/pxJ+WmZXZkm1Pqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102687; c=relaxed/simple;
	bh=troMU0Ar/0xAbJTUFfyYVZd8WZLmq8++JDD0Lqu65dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKkcv6Wg3tHfcm86sjGsI5vTcI5Rm7J+i39bmiF2OKzgdEfj6lCHp+bhgbqkX9wheX0hpcb7WmxEqeH7gIuOAf36Cqz0DVejQ0PQy8mILQ28gL56mB+m/Zhmw8KrBpZ/O9Db8iXGU2WF56NwFNoaS2QfGgqenp/zCC0x7nA3Tj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWolHSHN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47798f4059fso7238985e9.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 12:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764102683; x=1764707483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+ihlgFQmOqmlPkpkg2OQM9Rd9p6jiFttnfc8R2g1Tc=;
        b=nWolHSHNli1fEalWPeJpPVdxLq9+uGtXH05uW2iMdSKw3btctNFLpXpOeBUGC6jymu
         0SVyvrLLm9qqlIZBMXSMnWlbR4eYg/tQAmHoYICCytBmu5MbaxSuxWYiyObtF/R3n/cY
         X02bCACsDTi0i/m02nfxMTzBuEPs5wlc4rDi09PBkj1dAEwkT3xG+dil+jDQwwZEl5dv
         kdXdW/+8qV/sGV0AsinfqULzph1EL59lm0Bl2+IfpMrdC8+npKKETy1TRs4itd+6AJy9
         Fzumgkt0l1v4tYgShecCUrEXquKhlFVkbxypSAA6Ot8h5IFqFHIPm25Gx4071I4eu+32
         GENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102683; x=1764707483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+ihlgFQmOqmlPkpkg2OQM9Rd9p6jiFttnfc8R2g1Tc=;
        b=akBEpj8pLbcklE65qJDrdjwflT+n22Wv9teMAtOEkajIj+WKliaANDxnwWcxT+htU7
         OQZrBMOSmfnaVfxIBjC3k66VNfZljjilSDlFyuMEqa/REDTf5Tl+nKpSUrFuhvlsf5Zy
         1ChhMTdlcbDg8RRF4X0nGbn7wc5CYfZzpD/bTeuDSYdsYHgxXiwkkdeDvlfL23arfd5S
         enh2or9qH/V7DICe3NTuDh7kh5nwj6+AO3vLFaosBh+61ebMlCONZr1MLBz6zsZTZ++R
         iulL+g8j7BmbrE1y6mR6/LO0kPiWo6W5QNZhKbKpSLStDEVcEQtqDcKKdq9sWKXRMkWO
         gW8A==
X-Forwarded-Encrypted: i=1; AJvYcCXGrKZAPqzIA45yN/Prhr4KRlpOfpMcshrbIhfziJkppoF7OGiaoXi56wOlaCD1Ghmk57WM9lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdqOPjbqwDbS8DMsauhyr62RjEAmGirO9/aNpPAUI0EdUBqza
	ODdRPWOzvd0ly6LGV6Txp1bEm6U4Ss+t8D30kCT2kFYEQqygZZT57u3V
X-Gm-Gg: ASbGnctwHKwui767ysWuSp/HZ8fPz2LELgjYL9+KGMdYb3/1k4UECksPpVoOT1bfL30
	l5Ejap4Ec3S4D2LCDgRyNKCDJdrXeYAa3lRmaX5xlcLtfMgna63J05+03dlHX3jBPcopcu8ZPmh
	2ICdVyE+zQZb55/fxkpgxWcZ7GobVhGQf2PDQhRVNFfhFv1xaAHFjS1r/M7/JD1mSSrnC/UH2sj
	tZj+auo1QYcba6Cj5oD4C+VhdK8t1OQi4apFV/mAbb/3AgLaO2xEXQLP2wgMiJ9cWM5nP/+fq0Z
	0QNg56z25hRR5frhzpVCCguNlOZ0ufDXq9EyHa10zokFGTh/AR3blmnyJQXPLaDp+vWhq9/vFeE
	oUB3wJhDqZanK0/QnYGSPiR6HA9Qagx4gwjaV9qfPt+P0LvsO5oMMHuyvk4ycJ8MAV7dKtXMGcD
	CoxHA=
X-Google-Smtp-Source: AGHT+IGKl3PmdPBWDZJeKL5c6rPvHD7WfRJpYbmzL65pQzNCCmZ/n1/AIEJgQsI2ANGWsVx08RMxnw==
X-Received: by 2002:a05:6000:4201:b0:429:d084:d210 with SMTP id ffacd0b85a97d-42cc19f1577mr10931568f8f.0.1764102683009;
        Tue, 25 Nov 2025 12:31:23 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:a04c:7112:155f:2ee5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8c47sm37646485f8f.38.2025.11.25.12.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:31:22 -0800 (PST)
Date: Tue, 25 Nov 2025 22:31:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 7/7] net: dsa: b53: allow VID 0 for BCM5325/65
Message-ID: <20251125203119.fw746rr3ootunqts@skbuf>
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
 <20251125075150.13879-8-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125075150.13879-8-jonas.gorski@gmail.com>

Hi Jonas,

On Tue, Nov 25, 2025 at 08:51:50AM +0100, Jonas Gorski wrote:
> Now that writing ARL entries works properly, we can actually use VID 0
> as the default untagged VLAN for BCM5325 and BCM5365 as well, so use 0
> as default PVID always.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  drivers/net/dsa/b53/b53_common.c | 49 +++++++++++---------------------
>  1 file changed, 17 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index ac995f36ed95..4eff64204897 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -870,14 +870,6 @@ static void b53_enable_stp(struct b53_device *dev)
>  	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, gc);
>  }
>  
> -static u16 b53_default_pvid(struct b53_device *dev)
> -{
> -	if (is5325(dev) || is5365(dev))
> -		return 1;
> -	else
> -		return 0;
> -}
> -

I am in favour of a more minimal change, where b53_default_pvid()
returns 0, and its call sites are kept unmodified, if only and for
code documentation purposes. Other drivers use a macro to avoid
hardcoding the 0 everywhere the default VLAN is meant. This driver
doesn't have a macro but it already has b53_default_pvid().

>  static bool b53_vlan_port_needs_forced_tagged(struct dsa_switch *ds, int port)
>  {
>  	struct b53_device *dev = ds->priv;
> @@ -906,14 +898,12 @@ int b53_configure_vlan(struct dsa_switch *ds)
>  	struct b53_device *dev = ds->priv;
>  	struct b53_vlan vl = { 0 };
>  	struct b53_vlan *v;
> -	int i, def_vid;
>  	u16 vid;
> -
> -	def_vid = b53_default_pvid(dev);
> +	int i;
>  
>  	/* clear all vlan entries */
>  	if (is5325(dev) || is5365(dev)) {
> -		for (i = def_vid; i < dev->num_vlans; i++)
> +		for (i = 0; i < dev->num_vlans; i++)
>  			b53_set_vlan_entry(dev, i, &vl);
>  	} else {
>  		b53_do_vlan_op(dev, VTA_CMD_CLEAR);
> @@ -927,7 +917,7 @@ int b53_configure_vlan(struct dsa_switch *ds)
>  	 * entry. Do this only when the tagging protocol is not
>  	 * DSA_TAG_PROTO_NONE
>  	 */
> -	v = &dev->vlans[def_vid];
> +	v = &dev->vlans[0];
>  	b53_for_each_port(dev, i) {
>  		if (!b53_vlan_port_may_join_untagged(ds, i))
>  			continue;
> @@ -935,16 +925,15 @@ int b53_configure_vlan(struct dsa_switch *ds)
>  		vl.members |= BIT(i);
>  		if (!b53_vlan_port_needs_forced_tagged(ds, i))
>  			vl.untag = vl.members;
> -		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i),
> -			    def_vid);
> +		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i), 0);
>  	}
> -	b53_set_vlan_entry(dev, def_vid, &vl);
> +	b53_set_vlan_entry(dev, 0, &vl);
>  
>  	if (dev->vlan_filtering) {
>  		/* Upon initial call we have not set-up any VLANs, but upon
>  		 * system resume, we need to restore all VLAN entries.
>  		 */
> -		for (vid = def_vid + 1; vid < dev->num_vlans; vid++) {
> +		for (vid = 1; vid < dev->num_vlans; vid++) {
>  			v = &dev->vlans[vid];
>  
>  			if (!v->members)
> @@ -1280,7 +1269,6 @@ static int b53_setup(struct dsa_switch *ds)
>  	struct b53_device *dev = ds->priv;
>  	struct b53_vlan *vl;
>  	unsigned int port;
> -	u16 pvid;
>  	int ret;
>  
>  	/* Request bridge PVID untagged when DSA_TAG_PROTO_NONE is set
> @@ -1310,8 +1298,7 @@ static int b53_setup(struct dsa_switch *ds)
>  	}
>  
>  	/* setup default vlan for filtering mode */
> -	pvid = b53_default_pvid(dev);
> -	vl = &dev->vlans[pvid];
> +	vl = &dev->vlans[0];
>  	b53_for_each_port(dev, port) {
>  		vl->members |= BIT(port);
>  		if (!b53_vlan_port_needs_forced_tagged(ds, port))
> @@ -1740,7 +1727,7 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
>  	if (pvid)
>  		new_pvid = vlan->vid;
>  	else if (!pvid && vlan->vid == old_pvid)
> -		new_pvid = b53_default_pvid(dev);
> +		new_pvid = 0;
>  	else
>  		new_pvid = old_pvid;
>  	dev->ports[port].pvid = new_pvid;
> @@ -1790,7 +1777,7 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
>  	vl->members &= ~BIT(port);
>  
>  	if (pvid == vlan->vid)
> -		pvid = b53_default_pvid(dev);
> +		pvid = 0;
>  	dev->ports[port].pvid = pvid;
>  
>  	if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
> @@ -2269,7 +2256,7 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
>  	struct b53_device *dev = ds->priv;
>  	struct b53_vlan *vl;
>  	s8 cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
> -	u16 pvlan, reg, pvid;
> +	u16 pvlan, reg;
>  	unsigned int i;
>  
>  	/* On 7278, port 7 which connects to the ASP should only receive
> @@ -2278,8 +2265,7 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
>  	if (dev->chip_id == BCM7278_DEVICE_ID && port == 7)
>  		return -EINVAL;
>  
> -	pvid = b53_default_pvid(dev);
> -	vl = &dev->vlans[pvid];
> +	vl = &dev->vlans[0];
>  
>  	if (dev->vlan_filtering) {
>  		/* Make this port leave the all VLANs join since we will have
> @@ -2295,9 +2281,9 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
>  				    reg);
>  		}
>  
> -		b53_get_vlan_entry(dev, pvid, vl);
> +		b53_get_vlan_entry(dev, 0, vl);
>  		vl->members &= ~BIT(port);
> -		b53_set_vlan_entry(dev, pvid, vl);
> +		b53_set_vlan_entry(dev, 0, vl);
>  	}
>  
>  	b53_read16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), &pvlan);
> @@ -2336,7 +2322,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
>  	struct b53_vlan *vl;
>  	s8 cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
>  	unsigned int i;
> -	u16 pvlan, reg, pvid;
> +	u16 pvlan, reg;
>  
>  	b53_read16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), &pvlan);
>  
> @@ -2361,8 +2347,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
>  	b53_write16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), pvlan);
>  	dev->ports[port].vlan_ctl_mask = pvlan;
>  
> -	pvid = b53_default_pvid(dev);
> -	vl = &dev->vlans[pvid];
> +	vl = &dev->vlans[0];
>  
>  	if (dev->vlan_filtering) {
>  		/* Make this port join all VLANs without VLAN entries */
> @@ -2374,9 +2359,9 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
>  			b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, reg);
>  		}
>  
> -		b53_get_vlan_entry(dev, pvid, vl);
> +		b53_get_vlan_entry(dev, 0, vl);
>  		vl->members |= BIT(port);
> -		b53_set_vlan_entry(dev, pvid, vl);
> +		b53_set_vlan_entry(dev, 0, vl);
>  	}
>  }
>  EXPORT_SYMBOL(b53_br_leave);
> -- 
> 2.43.0
> 

Not covered in this patch, but I wonder whether it should have been.

This test in b53_vlan_prepare() seems obsolete and a good candidate for
removal:

	if ((is5325(dev) || is5365(dev)) && vlan->vid == 0)
		return -EOPNOTSUPP;

especially since we already have the same check below in b53_vlan_add()
for all chip IDs:

	if (vlan->vid == 0)
		return 0;

