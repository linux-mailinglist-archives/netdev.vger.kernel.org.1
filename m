Return-Path: <netdev+bounces-139148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF4A9B0703
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DD11F23D85
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E2721B875;
	Fri, 25 Oct 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="F0f8uzvT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF870838
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868487; cv=none; b=SHqYYzWJKjCnmf/Nyb3XVE3AYKGvBVWGKq68SZXqHcWH4Wl9zSFD/FwBb57ginRpTKvlogJD39UKBqihdBMJCp96qoU6PSDqQCX4WZXqJ0hg9ylefYI+8XNlOOwPBP76jQwjV/xG3yFlgmOS//KKC4D6vV8QGTz7TNcTj56wEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868487; c=relaxed/simple;
	bh=5zExvWG43h03bpMHJnWNBhVEBuw/E64PFzRDCBa3r4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A21cucy4KUFjFgDVUYjQvhD7xdo9A6bJ81QSwj15P6f5lS/Pb8cxaul2RRMy2RUvBOETzrWBc9Og6nR7I73Ven6ce92G/lT7J4NrM9CzC+aQOq3cXKh+7ga93OhcgFNJbYd6E/DZmlMX36NnPlXFAc1fmeD0E12ZL+QqGbl83sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=F0f8uzvT; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539ee1acb86so2394642e87.0
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1729868482; x=1730473282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqBlcn31y0XmBP6O2eLDkvXms4gyOzAKu9fGbPWi2Io=;
        b=F0f8uzvTTd4nIoxE78PchiedYZ6BS3ch4Wpzl2tIK3ds4O+/gejr7oHxavM6lhRsMy
         b/eBzNAno33ewAJitlBE/SxxMl7AMK6Ew3yHE1+qaYWMTwrlaRZdxa5iF5zjJA3rCNnP
         7keAu6Dx91/q2FqwuwcWYNdakraYRSK8hL0EOGVn8tDoLQDumjTEaH3ekTaNe38PNHlQ
         z+ZWMcoj+/zeEaPxVx0cmsEJdZXsy3UezHMeyPN7suf2d6Cq/KiMXJmihhXuqu0PiQSf
         LH6cWqgtGkHzDwXfn+0Kp5auo1RrHURqmv83y6pG7vWcowEm+jp110btKIbzyDdidGw3
         5qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868482; x=1730473282;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqBlcn31y0XmBP6O2eLDkvXms4gyOzAKu9fGbPWi2Io=;
        b=EJ5Mcx8ojwLmzTOqUHAb39/VOJ1DNC0NhZgZc7hA3FNtKN52L3IQqDHCJ7ZeSRQR0n
         GqFMcOn90KnpadCJotHFgvLbnhLhi8yammBmbspIz0VSTwrvAMAudukuanAODV0eTpvU
         Kq51ojUr8edbxpf9nBriqOPcDqtKEKBzRFnrdqx+Lag3iHXN0Wd/a2R+AnbEZEaE7CgO
         B+eV6+YfpiuygJJQkQes5EiPlhIcCA0khwvMR+jSSYHYOVIhcfyyFV7H3elHxzB9qx/7
         Vc93BTkoSY+xzftmqGwz4t6jHoi88Fe5oGuFnpT/P0Ot1dnn6s2F7jOZpk4B/oo4G3Lv
         lKvw==
X-Gm-Message-State: AOJu0Yw3PnmkvTUeew3+KuI9n7Aw0d+ClSGKK3UwaejEKxtqTtAmFBaB
	sdArGILhpoXd2MMVrlmAanj41wPunRsfhajR4aNwz9Zfioj8up7StX04cu2p6lI=
X-Google-Smtp-Source: AGHT+IHV0ynp73tyX5tVescAMeICzOzAykSvRIk6SZ7XkRfLdFZbjMXBzQLNmDLUOe9RcO1NDxU7tQ==
X-Received: by 2002:a05:6512:3d0c:b0:537:a824:7e5 with SMTP id 2adb3069b0e04-53b1a30203amr5413552e87.18.1729868481794;
        Fri, 25 Oct 2024 08:01:21 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1429ecsm210499e87.117.2024.10.25.08.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:01:19 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: =?utf-8?Q?Herv=C3=A9?= Gourmelon <herve.gourmelon@ekinops.com>, Andrew
 Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vivien Didelot
 <vivien.didelot@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>
Subject: Re: [PATCH 1/1] net: dsa: fix tag_dsa.c for untagged VLANs
In-Reply-To: <MR1P264MB3681CCB3C20AD95E1B20C878F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
References: <MR1P264MB3681CCB3C20AD95E1B20C878F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
Date: Fri, 25 Oct 2024 17:01:17 +0200
Message-ID: <87msis9qgy.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On fre, okt 25, 2024 at 13:46, Herv=C3=A9 Gourmelon <herve.gourmelon@ekinop=
s.com> wrote:
> Hello,

Hi,

>
> Trying to set up an untagged VLAN bridge on a DSA architecture of=20
> mv88e6xxx switches, I realized that whenever I tried to emit a=20
> 'From_CPU' or 'Forward' DSA packet, it would always egress with an=20
> unwanted 802.1Q header on the bridge port.

Could you provide the iproute2/bridge commands used to create this
bridge?

As Vladimir pointed out: the bridge will leave the .1Q-tag in the packet
when sending it down to the port netdev, to handle all offloading
scenarios (multiple untagged memberships can not be supported without
this information). tcpdump does not tell you how the packet will look
when it egresses the physical port in this case.

> Taking a closer look at the code, I saw that the Src_Tagged bit of the
> DSA header (1st octet, bit 5) was always set to '1' due to the
> following line:
>
> 	dsa_header[0] =3D (cmd << 6) | 0x20 | tag_dev;
>
> which is wrong: Src_Tagged should be reset if we need the frame to
> egress untagged from the bridge port.

This only matters for FROM_CPU tags, which contain _destination_
information.

FORWARD tags contain information about how a packet was originally
_received_. When receiving a FORWARD, the switch uses VTU membership
data to determine whether to egress tagged or untagged, per port.

> So I added a few lines to check whether the port is a member of a VLAN
> bridge, and whether the VLAN is set to egress untagged from the port,
> before setting or resetting the Src_Tagged bit as needed.
>
> Signed-off-by: Herv=C3=83=C2=A9 Gourmelon <herve.gourmelon@ekinops.com>
> ---
>  net/dsa/tag_dsa.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
> index 2a2c4fb61a65..14b4d8c3dc8a 100644
> --- a/net/dsa/tag_dsa.c
> +++ b/net/dsa/tag_dsa.c
> @@ -163,6 +163,21 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *s=
kb, struct net_device *dev,
>  	 */
>  	if (skb->protocol =3D=3D htons(ETH_P_8021Q) &&
>  	    (!br_dev || br_vlan_enabled(br_dev))) {

The only way past this guard is (1) that the packet has a .1Q-tag, and
that either (2a) it is a standalone port, or (2b) it is a port in a VLAN
filtering bridge.

In case 1+2a: We will generate a FROM_CPU, so the tagged bit has
meaning. But since the port is standalone, the tag in the packet is
"real" (not coming from bridge offloading) and should be in the packet
when it hits the wire.

In case 1+2b: (Your case) We will generate a FORWARD, so the tagged bit
does not matter at all.

Does that make sense?

> +		struct bridge_vlan_info br_info;
> +		u16 vid =3D 0;
> +		u16 src_tagged =3D 1;
> +		u8 *vid_ptr;
> +		int err =3D 0;
> +
> +		/* Read VID from VLAN 802.1Q tag */
> +		vid_ptr =3D dsa_etype_header_pos_tx(skb);
> +		vid =3D ((vid_ptr[2] & 0x0F) << 8 | vid_ptr[3]);
> +		/* Get VLAN info for vid on net_device *dev (dsa slave) */
> +		err =3D br_vlan_get_info_rcu(dev, vid, &br_info);
> +		if (err =3D=3D 0 && (br_info.flags & BRIDGE_VLAN_INFO_UNTAGGED)) {
> +			src_tagged =3D 0;
> +		}
> +
>  		if (extra) {
>  			skb_push(skb, extra);
>  			dsa_alloc_etype_header(skb, extra);
> @@ -170,11 +185,11 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *=
skb, struct net_device *dev,
>=20=20
>  		/* Construct tagged DSA tag from 802.1Q tag. */
>  		dsa_header =3D dsa_etype_header_pos_tx(skb) + extra;
> -		dsa_header[0] =3D (cmd << 6) | 0x20 | tag_dev;
> +		dsa_header[0] =3D (cmd << 6) | (src_tagged << 5) | tag_dev;
>  		dsa_header[1] =3D tag_port << 3;
>=20=20
>  		/* Move CFI field from byte 2 to byte 1. */
> -		if (dsa_header[2] & 0x10) {
> +		if (src_tagged =3D=3D 1 && dsa_header[2] & 0x10) {
>  			dsa_header[1] |=3D 0x01;
>  			dsa_header[2] &=3D ~0x10;
>  		}
> --=20
> 2.34.1

