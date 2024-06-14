Return-Path: <netdev+bounces-103536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA29087BF
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699AA2855CB
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF681192B70;
	Fri, 14 Jun 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwjQynal"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCA192B6D
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358184; cv=none; b=tuaqaoAvGQk2WhoFV/UvPCywIGWwJsbK7vHHgo192uwb6E3VTuA7OcSKvT/Pg++T5FQCjgL4IGY35Th4amRWNwdUd+9zax1XOBvoF2I8RkC6iEfIUJYltfuo2kqcdcqkycNNsRng0NzJ0k6y+/H4ACYjQNP8O7/0jCOxFdmkoE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358184; c=relaxed/simple;
	bh=I1iBGOoWQpj8pNaZCVoh6D0cVztaXLFRZEggNb2CDKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O2kRCm/NGEG28PvZ0BRFFNC2mHl3hS5AQRjJ5l8NdNDAGz66XcozppgONgGhiinXPcnzjV1EdI+hW0Uij0taPXr5h5ob8NFTeC3k9vUREgtyA7IkPCaaRo+Gf+AdCjG1i8Pnz+OJZrpOp+F0WSUM7M1mR4HyKNbFCYcaLdyMEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwjQynal; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718358180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=49kqpfNtEJVAp6h4kYqZK0c4CReSme2XQohBc3CWwNA=;
	b=hwjQynalEtZGTjUJKqv0g7kv+4ZfkkbACkG8gABfiv2VRhBCu7u0J4ELk6A1TpL7hD5bei
	G4aZIZn6cFX2NX8GrjQyZpi2gMPn25+rmmpkcSS2knVETjZepnMQuZ3peIcdHX9Z2VozED
	M/QejSKxPIQJSylViHY7xotZKb1V1Oo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384--2tUsfiTOrGgZKQtOKBR0w-1; Fri, 14 Jun 2024 05:42:55 -0400
X-MC-Unique: -2tUsfiTOrGgZKQtOKBR0w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4217e21bcd4so1899275e9.2
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 02:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358172; x=1718962972;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49kqpfNtEJVAp6h4kYqZK0c4CReSme2XQohBc3CWwNA=;
        b=KDYslIDcZIcDnRras8qu5UT85zoGitqodgEZrrsvJ0PGq+hJ9YNWda2KfhEistY6We
         qakSGQmZ8aw4vjg7XQboLIyXsjw503TYQ/1CiFojD75m6qUDN8P2nuY40g00zR9rsS4C
         mqMSWgo/h53t0fNstMq+pCfPDXzPam2TkUmGg4SvJZRMPERduEpGIgeJfIvBDqALWZeg
         ImpPjgk/11m6I0nOXM3SeNyJmDG3zUGVQnzGjFZzxfwtm4ZOGxADYwlCGougva9h820s
         AaYg6br6LcQojnNxtfs0fMqRwD+pU21UbhlmZeEOOLjl1NXphpOSne3E4V/jh1QpNKac
         rnKw==
X-Forwarded-Encrypted: i=1; AJvYcCVUC5MpEGJq/2Xyar3ZM3cC3KTv/m2myX19DyGReNnolX6gDXKWR8PzV6Q6Mo6em8q18hvC7/K2X5PPNukZ2waeaxcesh8B
X-Gm-Message-State: AOJu0YwYVK3X+gjyeVfLVs8SNV95bDZ9tttqVrOP+geC2VwPh2DDEvpk
	j7VKynlzr+CM5MxovKvhSbbavhqcULN+Bp+ycphDMyj+zpdCjvw4KOYoCgvBg059tk4xO2dgaew
	1ROY03NAQj9ozdL4UpCX61WGlf6V4i9we2lLG37eZVfTf9ZY86xG8ew==
X-Received: by 2002:a05:600c:3b1d:b0:422:70d4:7e72 with SMTP id 5b1f17b1804b1-4230484ea2emr17133815e9.2.1718358172501;
        Fri, 14 Jun 2024 02:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH/gW21YE7qXaSCcubY+8W1tCCly0CvUof2CfWLfbaGfA0Re6EqsXO4zQhRBDD7p0BvrkEXQ==
X-Received: by 2002:a05:600c:3b1d:b0:422:70d4:7e72 with SMTP id 5b1f17b1804b1-4230484ea2emr17133615e9.2.1718358172093;
        Fri, 14 Jun 2024 02:42:52 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b083:7210:de1e:fd05:fa25:40db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104b2esm3857063f8f.101.2024.06.14.02.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:42:51 -0700 (PDT)
Message-ID: <84281d30907c09a2f15d741088833b0ae6597b89.camel@redhat.com>
Subject: Re: [PATCH net-next 02/12] net: dsa: vsc73xx: Add vlan filtering
From: Paolo Abeni <pabeni@redhat.com>
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Date: Fri, 14 Jun 2024 11:42:50 +0200
In-Reply-To: <20240611195007.486919-3-paweldembicki@gmail.com>
References: <20240611195007.486919-1-paweldembicki@gmail.com>
	 <20240611195007.486919-3-paweldembicki@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Tue, 2024-06-11 at 21:49 +0200, Pawel Dembicki wrote:
> +static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan,
> +				 struct netlink_ext_ack *extack)
> +{
> +	bool untagged =3D vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> +	bool pvid =3D vlan->flags & BRIDGE_VLAN_INFO_PVID;
> +	struct dsa_port *dp =3D dsa_to_port(ds, port);
> +	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
> +	struct vsc73xx_vlan_summary summary;
> +	struct vsc73xx_portinfo *portinfo;
> +	struct vsc73xx *vsc =3D ds->priv;
> +	bool commit_to_hardware;
> +	int ret =3D 0;
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
> +	if ((untagged && summary.num_tagged > 0 && summary.num_untagged > 0) ||
> +	    (!untagged && summary.num_untagged > 1)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Port can have only none, one or all untagged vlan");
> +		return -EBUSY;
> +	}
> +
> +	vsc73xx_vlan =3D vsc73xx_bridge_vlan_find(vsc, vlan->vid);
> +
> +	if (!vsc73xx_vlan) {
> +		vsc73xx_vlan =3D kzalloc(sizeof(*vsc73xx_vlan), GFP_KERNEL);
> +		if (!vsc73xx_vlan)
> +			return -ENOMEM;
> +
> +		vsc73xx_vlan->vid =3D vlan->vid;
> +		vsc73xx_vlan->portmask =3D 0;
> +		vsc73xx_vlan->untagged =3D 0;
> +
> +		INIT_LIST_HEAD(&vsc73xx_vlan->list);

INIT_LIST_HEAD() is not needed, as the entry will be unconditionally
added in the statement below.

> +		list_add_tail(&vsc73xx_vlan->list, &vsc->vlans);
> +	}
> +
> +	/* CPU port must be always tagged because port separation is based on
> +	 * tag_8021q.
> +	 */
> +	if (port =3D=3D CPU_PORT)
> +		goto update_vlan_table;
> +
> +	vsc73xx_vlan->portmask |=3D BIT(port);
> +
> +	if (untagged)
> +		vsc73xx_vlan->untagged |=3D BIT(port);
> +	else
> +		vsc73xx_vlan->untagged &=3D ~BIT(port);
> +
> +	portinfo =3D &vsc->portinfo[port];
> +
> +	if (pvid) {
> +		portinfo->pvid_vlan_filtering_configured =3D true;
> +		portinfo->pvid_vlan_filtering =3D vlan->vid;
> +	} else if (portinfo->pvid_vlan_filtering_configured &&
> +		   portinfo->pvid_vlan_filtering =3D=3D vlan->vid) {
> +		portinfo->pvid_vlan_filtering_configured =3D false;
> +	}
> +
> +	commit_to_hardware =3D !vsc73xx_tag_8021q_active(dp);
> +	if (commit_to_hardware) {
> +		vsc73xx_vlan_commit_pvid(vsc, port);
> +		vsc73xx_vlan_commit_untagged(vsc, port);
> +		vsc73xx_vlan_commit_conf(vsc, port);
> +	}
> +
> +update_vlan_table:
> +	ret =3D vsc73xx_update_vlan_table(vsc, port, vlan->vid, true);
> +	if (!ret)
> +		return 0;
> +
> +	list_del(&vsc73xx_vlan->list);
> +	kfree(vsc73xx_vlan);

This does not look correct. I guess you should clear bit(port) in
vsc73xx_vlan->portmask and dispose the entry only when portmask becomes
0. You probably can factor out a common helper to be used here and in
vsc73xx_port_vlan_del().=20

Thanks,

Paolo


