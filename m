Return-Path: <netdev+bounces-241514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AAFC84CA0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 12:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70FFC349430
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CBB314A89;
	Tue, 25 Nov 2025 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb570MeP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58E2F39B9
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071148; cv=none; b=msfTbYsfTCTl00m2wQe3H8bKGlIk53eiBYWR+b88CZkYhkE3E/2e8nRfi4PtdKEkLvh1k3qfiHfsN+BEIFYpTyOvk+HYYKbwT8Ow1qF29SH6HHzrxbJcq3vJbdlpyPCd1CQ1rLqc+3CEXWOjFSvP9pZukzHgXuViPzIa5ux5w7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071148; c=relaxed/simple;
	bh=eUpQhDWpgpZlAeQnEl90VyphU89LAG4Ey1HWcwW2mTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZCWwsxeQXjXA/0iGbf7rpAt2VTMr528B0PvNqY/SSCYIY5SBq0hmkn2hyLpohqLxLN5I3u3mbKVTf+gBBPZeZEWsMMvIOyysiRy8vzCdksXYWB4SFU1HE6gvIQW/apClSvZkP+TYLmcHKf1u05T5yiahL02KRMkcXzta7B5gKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb570MeP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-343684a06b2so5406626a91.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 03:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764071146; x=1764675946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2nSxZr296cTLk2jDylXNLI5Wnnk8TWh4DK2ghNWJUw=;
        b=gb570MePP+WCMZUyD8Bb+cb6El4SA813QjmIx06Z7YtqcCplXZi7VpmsnqLMZADmrd
         ddXriTN84aOtpW1+r9a3KE+Vka7z+UOeHgwIde3zS0sA7QARxfOWhpMfZV2QUaNrpKPG
         wC3AWukLX4/HAP2v0h58GqIvJWRp3/1y9TAWeOo6WbBNQtIw9g42gS6wLw93SZ2Y4Sqs
         +BGSrgoVTglWd0waAIXFAnf9P8VFxCRgFu8vVz+Nq6CJxgKirj+PNWthhIfDUCfZ5Jep
         zZGxpIMEQcAiz/koq9e+aTW88EiU5ffHOQzl+9v6RdjrXzasHclMqzw4Cbicbr7ByQGT
         cjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764071146; x=1764675946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D2nSxZr296cTLk2jDylXNLI5Wnnk8TWh4DK2ghNWJUw=;
        b=Pyey+cWfuKTcuHTdAE+H1N2+kl1QmTvMPJYrm/z/I5LuBBoPVLcJkSq05VD3HgU0Xy
         58f6w/Ss52oxw6tmuzr0ya5ut4pYfe501kGbVRmKTS/ZkhAxB+DMaA5QVhuK1PtzF1ml
         LY7OGTQhnLlqlr9GiFHV13ytN/oHI3UU9bWL9iI5kr6lytgEeaccgvNIiNKJtFNjuCpU
         /7Bjw92XfuiThMZO1snmsyyM7R1/0PX3j1aq/L8knBaIhwef4maYv9+4m0v1pTHY6oRo
         KKBvLSI2RCYNE3qXMp+p4t4k1h5ff1uo6D3JReOULjuLyt+DNLbwWQlTw+xhAMh1eu1W
         9hmg==
X-Forwarded-Encrypted: i=1; AJvYcCW1HXnmSgLOZ8o05vVU6/DiViQEHFG4s0FBQyYOYKi0sxyYz0JDC4ihMYqq3iyuY31rCZNRKwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL4lixLoAyw19XBK3mB42JCwjB/VbDXZihCjMTMOAOuV76Bx5C
	DYP37L6AK7b352fPxN1O+q1LZfto1PNDg5WkxkYbfbIv8pG3mbZPZ+eKYr4maE0gmLiwKA3zWtR
	OyvCfYYUdP3bwixL/r7H0DHb5k+/KbraZRO3c
X-Gm-Gg: ASbGncs7T5KN1tcOep1PRCp5ktD3DpF0J4NMM3uxXunaIOxu2y0xJy9Q0/0tnYM7DO+
	yy9qXitO6ws4ljkhJzC4pYF++ZmHBIJEiU61Lhk+ZSqweB4Q7wpdP8m7fYjmghFB2GMuWwlJMH8
	yE3zLljjnXMeNxZ/8teGLChcpKPxNfXvMTpRar3EhJjDfsa1rdPgdfBzh6Uqfw3N+cS1HPeE4G2
	ZuZ4Dl+544SPidx2FgATzqWYLysPZzi5si7uBwzl0j5UV1OxY87Cr+GYCle17VYJ8XfQBlP+MmM
	wUbFl0XIF866dZ8QYWi8F7ape0Wt
X-Google-Smtp-Source: AGHT+IHBOafY5cOuAu68UmWFeJRNGfrKPEO8ulraWmif4ReiD5qaWhPlEmkkBTl3byctOZGb69yOYVzYUiHR+dE0gwQ=
X-Received: by 2002:a17:90b:540b:b0:341:88c9:aefb with SMTP id
 98e67ed59e1d1-34733e53d8cmr13413313a91.5.1764071145829; Tue, 25 Nov 2025
 03:45:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125075150.13879-1-jonas.gorski@gmail.com> <20251125075150.13879-8-jonas.gorski@gmail.com>
In-Reply-To: <20251125075150.13879-8-jonas.gorski@gmail.com>
From: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date: Tue, 25 Nov 2025 12:45:10 +0100
X-Gm-Features: AWmQ_blDl7oLgUL8MeVJe2KJRsFITUkpxv_Mc7NRmNFtb6ga-jYy4nQlpiBe1uk
Message-ID: <CAKR-sGdrJ4Zdw_j1Xj2DbRk0ksrjLS7xYcYGa_LDZsfT4ODhdw@mail.gmail.com>
Subject: Re: [PATCH net-next 7/7] net: dsa: b53: allow VID 0 for BCM5325/65
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 25 nov 2025 a las 8:52, Jonas Gorski
(<jonas.gorski@gmail.com>) escribi=C3=B3:
>
> Now that writing ARL entries works properly, we can actually use VID 0
> as the default untagged VLAN for BCM5325 and BCM5365 as well, so use 0
> as default PVID always.
>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  drivers/net/dsa/b53/b53_common.c | 49 +++++++++++---------------------
>  1 file changed, 17 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_c=
ommon.c
> index ac995f36ed95..4eff64204897 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -870,14 +870,6 @@ static void b53_enable_stp(struct b53_device *dev)
>         b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, gc);
>  }
>
> -static u16 b53_default_pvid(struct b53_device *dev)
> -{
> -       if (is5325(dev) || is5365(dev))
> -               return 1;
> -       else
> -               return 0;
> -}
> -
>  static bool b53_vlan_port_needs_forced_tagged(struct dsa_switch *ds, int=
 port)
>  {
>         struct b53_device *dev =3D ds->priv;
> @@ -906,14 +898,12 @@ int b53_configure_vlan(struct dsa_switch *ds)
>         struct b53_device *dev =3D ds->priv;
>         struct b53_vlan vl =3D { 0 };
>         struct b53_vlan *v;
> -       int i, def_vid;
>         u16 vid;
> -
> -       def_vid =3D b53_default_pvid(dev);
> +       int i;
>
>         /* clear all vlan entries */
>         if (is5325(dev) || is5365(dev)) {
> -               for (i =3D def_vid; i < dev->num_vlans; i++)
> +               for (i =3D 0; i < dev->num_vlans; i++)
>                         b53_set_vlan_entry(dev, i, &vl);
>         } else {
>                 b53_do_vlan_op(dev, VTA_CMD_CLEAR);
> @@ -927,7 +917,7 @@ int b53_configure_vlan(struct dsa_switch *ds)
>          * entry. Do this only when the tagging protocol is not
>          * DSA_TAG_PROTO_NONE
>          */
> -       v =3D &dev->vlans[def_vid];
> +       v =3D &dev->vlans[0];
>         b53_for_each_port(dev, i) {
>                 if (!b53_vlan_port_may_join_untagged(ds, i))
>                         continue;
> @@ -935,16 +925,15 @@ int b53_configure_vlan(struct dsa_switch *ds)
>                 vl.members |=3D BIT(i);
>                 if (!b53_vlan_port_needs_forced_tagged(ds, i))
>                         vl.untag =3D vl.members;
> -               b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i),
> -                           def_vid);
> +               b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i),=
 0);
>         }
> -       b53_set_vlan_entry(dev, def_vid, &vl);
> +       b53_set_vlan_entry(dev, 0, &vl);
>
>         if (dev->vlan_filtering) {
>                 /* Upon initial call we have not set-up any VLANs, but up=
on
>                  * system resume, we need to restore all VLAN entries.
>                  */
> -               for (vid =3D def_vid + 1; vid < dev->num_vlans; vid++) {
> +               for (vid =3D 1; vid < dev->num_vlans; vid++) {
>                         v =3D &dev->vlans[vid];
>
>                         if (!v->members)
> @@ -1280,7 +1269,6 @@ static int b53_setup(struct dsa_switch *ds)
>         struct b53_device *dev =3D ds->priv;
>         struct b53_vlan *vl;
>         unsigned int port;
> -       u16 pvid;
>         int ret;
>
>         /* Request bridge PVID untagged when DSA_TAG_PROTO_NONE is set
> @@ -1310,8 +1298,7 @@ static int b53_setup(struct dsa_switch *ds)
>         }
>
>         /* setup default vlan for filtering mode */
> -       pvid =3D b53_default_pvid(dev);
> -       vl =3D &dev->vlans[pvid];
> +       vl =3D &dev->vlans[0];
>         b53_for_each_port(dev, port) {
>                 vl->members |=3D BIT(port);
>                 if (!b53_vlan_port_needs_forced_tagged(ds, port))
> @@ -1740,7 +1727,7 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
>         if (pvid)
>                 new_pvid =3D vlan->vid;
>         else if (!pvid && vlan->vid =3D=3D old_pvid)
> -               new_pvid =3D b53_default_pvid(dev);
> +               new_pvid =3D 0;
>         else
>                 new_pvid =3D old_pvid;
>         dev->ports[port].pvid =3D new_pvid;
> @@ -1790,7 +1777,7 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
>         vl->members &=3D ~BIT(port);
>
>         if (pvid =3D=3D vlan->vid)
> -               pvid =3D b53_default_pvid(dev);
> +               pvid =3D 0;
>         dev->ports[port].pvid =3D pvid;
>
>         if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
> @@ -2269,7 +2256,7 @@ int b53_br_join(struct dsa_switch *ds, int port, st=
ruct dsa_bridge bridge,
>         struct b53_device *dev =3D ds->priv;
>         struct b53_vlan *vl;
>         s8 cpu_port =3D dsa_to_port(ds, port)->cpu_dp->index;
> -       u16 pvlan, reg, pvid;
> +       u16 pvlan, reg;
>         unsigned int i;
>
>         /* On 7278, port 7 which connects to the ASP should only receive
> @@ -2278,8 +2265,7 @@ int b53_br_join(struct dsa_switch *ds, int port, st=
ruct dsa_bridge bridge,
>         if (dev->chip_id =3D=3D BCM7278_DEVICE_ID && port =3D=3D 7)
>                 return -EINVAL;
>
> -       pvid =3D b53_default_pvid(dev);
> -       vl =3D &dev->vlans[pvid];
> +       vl =3D &dev->vlans[0];
>
>         if (dev->vlan_filtering) {
>                 /* Make this port leave the all VLANs join since we will =
have
> @@ -2295,9 +2281,9 @@ int b53_br_join(struct dsa_switch *ds, int port, st=
ruct dsa_bridge bridge,
>                                     reg);
>                 }
>
> -               b53_get_vlan_entry(dev, pvid, vl);
> +               b53_get_vlan_entry(dev, 0, vl);
>                 vl->members &=3D ~BIT(port);
> -               b53_set_vlan_entry(dev, pvid, vl);
> +               b53_set_vlan_entry(dev, 0, vl);
>         }
>
>         b53_read16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), &pvlan=
);
> @@ -2336,7 +2322,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, =
struct dsa_bridge bridge)
>         struct b53_vlan *vl;
>         s8 cpu_port =3D dsa_to_port(ds, port)->cpu_dp->index;
>         unsigned int i;
> -       u16 pvlan, reg, pvid;
> +       u16 pvlan, reg;
>
>         b53_read16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), &pvlan=
);
>
> @@ -2361,8 +2347,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, =
struct dsa_bridge bridge)
>         b53_write16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), pvlan=
);
>         dev->ports[port].vlan_ctl_mask =3D pvlan;
>
> -       pvid =3D b53_default_pvid(dev);
> -       vl =3D &dev->vlans[pvid];
> +       vl =3D &dev->vlans[0];
>
>         if (dev->vlan_filtering) {
>                 /* Make this port join all VLANs without VLAN entries */
> @@ -2374,9 +2359,9 @@ void b53_br_leave(struct dsa_switch *ds, int port, =
struct dsa_bridge bridge)
>                         b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN=
_EN, reg);
>                 }
>
> -               b53_get_vlan_entry(dev, pvid, vl);
> +               b53_get_vlan_entry(dev, 0, vl);
>                 vl->members |=3D BIT(port);
> -               b53_set_vlan_entry(dev, pvid, vl);
> +               b53_set_vlan_entry(dev, 0, vl);
>         }
>  }
>  EXPORT_SYMBOL(b53_br_leave);
> --
> 2.43.0
>

Thank you so much for these patches.

I've tested all of them on a Huawei HG556a (bcm6358 + bcm5325).

Tested-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>

