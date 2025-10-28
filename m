Return-Path: <netdev+bounces-233476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA55C14074
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E99F64E43CC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CF32DEA96;
	Tue, 28 Oct 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZjiM7yf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BCD1D31B9
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646538; cv=none; b=ihtRU4aCJJ+SD0vPnjXqBqcy0ftyqLpgDVflkIXhYODY97zTbQL+a/Vc0n45gWYTXJaVHphh8Yeqjw8NWwubL1YkfWd6GY1KybiyLnv4XHHAdl2X/l1atWW8+Mg9Qb6F6O4q9Y2RTABFxscB8/VxQ1T2vVbX0ulekftve+CbVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646538; c=relaxed/simple;
	bh=oegOIuOLWZnxgVhV5bm440oKNgkE3fmywG5NEyYKmLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTvPekauRTf+JIByCdN9Nwr9ghHtMQTf3cIDbypAOcvKbm0C8heTWa2BSopdrQ9kmFQ8ugxLfeCuQ6sQx+WA5L7c+l4adDlUMf4TbqNJW7JuI0PXi4pj7b2eEBEiTIpNLObx0V64QPA+AtrbwwtPl0mDsTYfatAWvDk2UjcOcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZjiM7yf; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-781014f4e12so71928997b3.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761646536; x=1762251336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNHXjAW4IVd8qz752IwOiVtTmfQ/HgBTHiqv5gq9H9c=;
        b=TZjiM7yfsLSvaL4E0YVaVqKqZa9fCtHeNOwi2hhCL2bO7DYm1ErefqxKUvfC8DY+Ba
         VUXCKcEEg0NQTlPTgUhf4RMHzFZ7389QWvDS03jsgiTRYhuO0BqKLjaYVhLnvy8Rn4q7
         9VaKVreYbnZF+MXid/0Vh9nliwqhZej1730mWpLnwlyqbzd+29zuCkPrBowRFTn/HBgN
         EworFQG1jkydMr+ZqqqFWzJ6XxMbbqt3s/2gSnehxXlpyI2bPWY8ddcCxuQIyH835egj
         CTAR9M8K2GA4KnPHhwg5kfXxyIZAt/wc3kP3l7UDVFet6/hYnCXzjZESeTNS8TOB+E+l
         NdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761646536; x=1762251336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNHXjAW4IVd8qz752IwOiVtTmfQ/HgBTHiqv5gq9H9c=;
        b=DgYXQ5U/Hb+BS8odwFcRC7nHR8Frzo7e+ZXCJB33ubIPAMOGCMoqlW0koe/cVp7Wyf
         aLkqJQDEFQFPiVTU3i47LNcouSoLsZKKCBaJv7Ok/oV8SMNchBM9upuTD9wUXmU++F/f
         miruMeb1gfz1E5hnLpv2WhY/wtm4w1HiRnE6FdocKv4y6LFV9CR+w8wGiBHX4/Fgsw85
         WngRKdfqVp67SxVDMEgE3zypM6yYF/+HHLdnevQ7SfrTSGGKLRi6zhh9hqmB/Cylbqaq
         kDhcgyFJ30BLAd8YoG8KmKQNtaimAKRIgYUIkKoEPKa0QrAbsii1Ev/hZ4znsOud16Cz
         BHLA==
X-Forwarded-Encrypted: i=1; AJvYcCWOkuNUBOLOghe7+QWicyB3+yoCAk7h2OSr4TW5fvmpflSVhpSE41LrgLQNsrFVlW7XXmz7Ua8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIIL9mAz1vdDm/4JUin4pLIWi/iK6gqYaaUhSlrikcoxxHAzW
	JHkXLe+M2A+U2SU+1sBpNYa/61iOhskHbofYkJlgSdBDTZCgCn8XiBINnQGzUVyCNO+A8yTmSmz
	cENimTkCxgskWbPMfdv75oaq0BXcjrv4=
X-Gm-Gg: ASbGncu3NZz6HXwrfiyFAvvvER5ciM25so/ut8b4M64ZHysVEwycx1AMTxnvDZ+OXsY
	el69ldXq9ZKA6oxxUd5j7UJreNF/gxZdoliCIAQGfTqwmvUJ1uKdFTAmalLnFw5JOR3J9nMfniN
	Q3qd7GPVwI6TCsJyKMwHV+VkcN4WJqVKWrElWnJQwP/IlU+wTmyhW3QZNIab/2aWfQCoEkWVlV/
	RFO2wfCJ4bKIzRGbJPxopQzNK8uJoR9nKzBKtSY5hpOnmoGH/46ZkvKMl4=
X-Google-Smtp-Source: AGHT+IGQrJ7T6oXGC6ovCSoTGg9bGE+susDXm+91pMoC8tFr90jF6WcXKzvtZYkN0P/nhoxnyYWxHcn8ZEXD8FJQPhQ=
X-Received: by 2002:a05:690c:9a8d:b0:784:88df:d8c with SMTP id
 00721157ae682-78617d10f31mr27392647b3.0.1761646535735; Tue, 28 Oct 2025
 03:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027194621.133301-1-jonas.gorski@gmail.com> <20251027211540.dnjanhdbolt5asxi@skbuf>
In-Reply-To: <20251027211540.dnjanhdbolt5asxi@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 28 Oct 2025 11:15:23 +0100
X-Gm-Features: AWmQ_bmKqDvNEsIM6yQblBzfU5uW9_HGNNdTlMg--2VP9AOr9k9QJU6SNq7XkRg
Message-ID: <CAOiHx=nw-phPcRPRmHd6wJ5XksxXn9kRRoTuqH4JZeKHfxzD5A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:15=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com=
> wrote:
>
> On Mon, Oct 27, 2025 at 08:46:21PM +0100, Jonas Gorski wrote:
> > The internal switch on BCM63XX SoCs will unconditionally add 802.1Q VLA=
N
> > tags on egress to CPU when 802.1Q mode is enabled. We do this
> > unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configure
> > VLANs while not filtering").
> >
> > This is fine for VLAN aware bridges, but for standalone ports and vlan
> > unaware bridges this means all packets are tagged with the default VID,
> > which is 0.
> >
> > While the kernel will treat that like untagged, this can break userspac=
e
> > applications processing raw packets, expecting untagged traffic, like
> > STP daemons.
> >
> > This also breaks several bridge tests, where the tcpdump output then
> > does not match the expected output anymore.
> >
> > Since 0 isn't a valid VID, just strip out the VLAN tag if we encounter
> > it, unless the priority field is set, since that would be a valid tag
> > again.
> >
> > Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
>
> Sorry for dropping the ball on v1. To reply to your reply there,
> https://lore.kernel.org/netdev/CAOiHx=3DmNnMJTnAN35D6=3DLPYVTQB+oEmedwqrk=
A6VRLRVi13Kjw@mail.gmail.com/
> I hadn't realized that b53 sets ds->untag_bridge_pvid conditionally,
> which makes any consolidation work in stable trees very complicated
> (although still desirable in net-next).

It's for some more obscure cases where we cannot use the Broadcom tag,
like a switch where the CPU port isn't a management port but a normal
port. I am not sure this really exists, but maybe Florian knows if
there are any (still used) boards where this applies.

If not, I am more than happy to reject this path as -EINVAL instead of
the current TAG_NONE with untag_bridge_pvid =3D true.

>
> | And to sidetrack the discussion a bit, I wonder if calling
> | __vlan_hwaccel_clear_tag() in
> | dsa_software_untag_vlan_(un)aware_bridge() without checking the
> | vlan_tci field strips 802.1p information from packets that have it. I
> | fail to find if this is already parsed and stored somewhere at a first
> | glance.
>
> 802.1p information should be parsed in vlan_do_receive() if vlan_find_dev=
()
> found something:
>
>         skb->priority =3D vlan_get_ingress_priority(vlan_dev, skb->vlan_t=
ci);
>
> This logic is invoked straight from __netif_receive_skb_core(), and
> relative to dsa_switch_rcv(), it hasn't run yet.

I see. So I presume it runs again after dsa_switch_rcv() has run? Or
rather __netif_receive_skb_core() jumps to to another_round or so?

> Apart from that and user-configured netfilter/tc rules, I don't think
> there's anything else in the kernel that processes the vlan_tci on
> ingress (of course that isn't to say anything about user space).
>
> With regard to dsa_software_untag_vlan_unaware_bridge(), which I'd like
> to see removed rather than reworked, it does force you to use a br0.0
> VLAN upper to not strip the 802.1p info, which is OK.
>
> With regard to dsa_software_untag_vlan_aware_bridge(), it only strips
> VID values which are !=3D 0 (because the bridge PVID iself is !=3D 0 - if=
 it
> was zero that would be another bug, the port should have dropped the
> packet with a VLAN-aware bridge).

AFAICT if a port on a vlan aware bridge has no PVID configured and
receives a VID 0 tagged packet, then
dsa_software_untag_vlan_aware_bridge() will strip it:

Since skb-proto is 802.1Q, we call skb_vlan_untag(), which will set
skb->vlan_proto to 802.1q and skb->vlan_tci to 0

skb->vlan_all is now !=3D 0, so skb_vlan_tag_present() returns true.

skb_vlan_tag_get_id() returns 0, since skb->vlan_tci is 0.

So on a vlan_aware bridge with untag_vlan_aware_bridge_pvid enabled we
now call dsa_software_untag_vlan_aware_bridge() with vid =3D 0.

In there br_vlan_get_pvid_rcu() sets pvid to 0 if no PVID is
configured since br_get_pvid() returns 0 in that case, so the
condition (vid =3D=3D pvid) is fulfilled, so we call
__vlan_hwaccel_clear_tag(), stripping the tag.

Obviously for any other configurations (e.g. PVID > 0 and VID =3D 0) we
don't do anything.

For BCM63xx, the issue with VID 0 tagged traffic on egress on the CPU
port is only if there is no PVID configured on a port - once there is
a PVID, the ingress untagged traffic will be tagged with the
appropriate VLAN ID on egress on the CPU port, and everything is fine.
So in a sense it happens to work by accident for ports without a PVID
and untagged traffic on them.

But vlan aware bridges are the only cases where PVIDs do get
configured/are active, in all other configurations PVID is programmed
as 0 on ports.

Best regards,
Jonas

