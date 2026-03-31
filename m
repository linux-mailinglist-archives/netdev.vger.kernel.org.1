Return-Path: <netdev+bounces-273424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uErkNtkcy2kEEAYAu9opvQ
	(envelope-from <netdev+bounces-273424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1708B362F40
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BC88301A43B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850D223A9BD;
	Tue, 31 Mar 2026 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="88C4Ya+Z";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Ozh4OGnj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0630F547;
	Tue, 31 Mar 2026 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918848; cv=none; b=befUXoCp4yFQ16IWp+yXEE9G4+7Rqbv+PwWwrg4Y244/2R9C2HQC1oRMI24YlU+3NLoFRPKGCPGHo/7FmO9USqPIAo3Y7OSrfXujq+Iy08jQs/N1ckngovprIL5K+yqvHj9kolhM3jUGqvtoezSqRv0QCN0USNzCOKIPoqrEVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918848; c=relaxed/simple;
	bh=1PMYpS3eHXdozYEG0BLpvIo8mJnGFpw+EGQEAaPg+uE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QF0pYbI+GLrgPL7oDzGdOKv9hQNy2Ep2+UaGPyrA6zlKnAE/EybIxVAZMk27KAxPGijTWxExEL5I2eRDxEQbyNzRQUGKMmSDGQiwaq7MT4CACSmuRMjQIBmeNzNAd9cY1z0AtEohbFagCl4k3cYYfdqy0cLKH8ixPEOb2+XFniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=88C4Ya+Z; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Ozh4OGnj; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62V0xxO6008641;
	Tue, 31 Mar 2026 03:00:04 +0200
Received: from lubuntu-18.04 (host-82-51-149-179.retail.telecomitalia.it [82.51.149.179])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id AF59C1204E9;
	Tue, 31 Mar 2026 02:59:53 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1774918794; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hluqR8Jvewx7Jb4dA5xRd82YyqNTyiQaRFsleJlVd1Q=;
	b=88C4Ya+ZNC1+oG3LNWDLu96fzb4qBCEFlJPBt/rOtNFQiDbca7kjz4Xy/O0Oi0SVws9aJ+
	62/uV2arM9Gx67DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1774918794; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hluqR8Jvewx7Jb4dA5xRd82YyqNTyiQaRFsleJlVd1Q=;
	b=Ozh4OGnjzQJZsDy+6XHfskYHcBXJ3lx+xDs+2MaR4Tvl6wl8yWCpmk2vVFeDLV83o7212q
	4k7j64gO4KgUa6cO36LHhGj0Pa4VevB+l+b0pR52Ve4pI4oxIWDSSLFooQn9R6Azez+ReR
	ZLcR5BqAsiIPsxHN1HDPyVuYaHAogUJe2gqBPykM2CYYSFmwW+VvZUznc/7tkxvBcUeJvW
	Tq2fxveKaVwp2W3Hb3V/gzMax+PxSqBQQC1AxB2mwYX2jfDlglRKhNXMUwo837TqZa2WfG
	Xu3LmjSJixDp1qROymSzNUYTkiYDj+31cpZ6rRV/UtyfzLasSsUjV+ZVV9f/Gw==
Date: Tue, 31 Mar 2026 02:59:52 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: nicolas.dichtel@6wind.com
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman
 <horms@kernel.org>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo
 Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam
 <ahabdels@cisco.com>,
        Justin Iurman <justin.iurman@6wind.com>, linux-kernel@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [RFC PATCH net-next 2/3] seg6: add SRv6 L2 tunnel device (srl2)
Message-Id: <20260331025952.6cc772c826739da350d0c56e@uniroma2.it>
In-Reply-To: <a4a4ba6d-da13-4bb1-b6b2-1f9a5de190a7@6wind.com>
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
	<20260322000557.12559-3-andrea.mayer@uniroma2.it>
	<a4a4ba6d-da13-4bb1-b6b2-1f9a5de190a7@6wind.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273424-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1708B362F40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 17:44:29 +0100
Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:

>=20
>=20

Thanks Nicolas for your time and for the review.


> Le 22/03/2026 =E0 01:05, Andrea Mayer a =E9crit=A0:
> > Introduce srl2, an Ethernet pseudowire device over SRv6. It
> > encapsulates L2 frames in IPv6 with a Segment Routing Header for
> > transmission across an SRv6 network.
> >=20
> > The encapsulation logic reuses seg6_do_srh_encap() with
> > IPPROTO_ETHERNET. The transmit path uses the standard IPv6 tunnel
> > infrastructure (dst_cache, ip6_route_output, ip6tunnel_xmit).
> >=20
> > The device is configured with a segment list for point-to-point
> > L2 encapsulation.
> >=20
> > Usage:
> >=20
> >   ip link add srl2-0 type srl2 segs fc00::a,fc00::b
> >=20
> > Co-developed-by: Stefano Salsano <stefano.salsano@uniroma2.it>
> > Signed-off-by: Stefano Salsano <stefano.salsano@uniroma2.it>
> > Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> > ---
> >  include/linux/srl2.h      |   7 +
> >  include/uapi/linux/srl2.h |  20 +++
> >  net/ipv6/Kconfig          |  16 +++
> >  net/ipv6/Makefile         |   1 +
> >  net/ipv6/seg6.c           |   1 +
> >  net/ipv6/srl2.c           | 269 ++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 314 insertions(+)
> >  create mode 100644 include/linux/srl2.h
> >  create mode 100644 include/uapi/linux/srl2.h
> >  create mode 100644 net/ipv6/srl2.c
> >=20
> > diff --git a/include/linux/srl2.h b/include/linux/srl2.h
> > new file mode 100644
> > index 000000000000..c1342b979402
> > --- /dev/null
> > +++ b/include/linux/srl2.h
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +#ifndef _LINUX_SRL2_H
> > +#define _LINUX_SRL2_H
> > +
> > +#include <uapi/linux/srl2.h>
> > +
> > +#endif
> Is this really needed?

No. Moving IFLA_SRL2_* to if_link.h makes both srl2.h headers
unnecessary.


>=20
> > diff --git a/include/uapi/linux/srl2.h b/include/uapi/linux/srl2.h
> > new file mode 100644
> > index 000000000000..e7c8f6fc0791
> > --- /dev/null
> > +++ b/include/uapi/linux/srl2.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
> > +/*
> > + *  SRv6 L2 tunnel device
> > + *
> > + *  Author:
> > + *  Andrea Mayer <andrea.mayer@uniroma2.it>
> > + */
> > +
> > +#ifndef _UAPI_LINUX_SRL2_H
> > +#define _UAPI_LINUX_SRL2_H
> > +
> > +enum {
> > +	IFLA_SRL2_UNSPEC,
> > +	IFLA_SRL2_SRH,	/* binary: struct ipv6_sr_hdr + segments */
> > +	__IFLA_SRL2_MAX,
> > +};
> > +
> > +#define IFLA_SRL2_MAX (__IFLA_SRL2_MAX - 1)
> It should probably be generated automatically from specs, see
> https://docs.kernel.org/userspace-api/netlink/intro-specs.html
>=20

We'll add srl2 to rt-link.yaml. It seems that if_link.h is not
auto-generated from the spec yet, so I think we need to add
IFLA_SRL2_* there manually like the other link types.


> > [snip]
> > +static void srl2_setup(struct net_device *dev)
> > +{
> > +	ether_setup(dev);
> > +
> > +	dev->netdev_ops =3D &srl2_netdev_ops;
> > +	dev->needs_free_netdev =3D true;
> > +	dev->pcpu_stat_type =3D NETDEV_PCPU_STAT_DSTATS;
> > +	dev->needed_headroom =3D LL_MAX_HEADER + sizeof(struct ipv6hdr) +
> > +			       SRL2_SRH_HEADROOM_EST;
> > +
> > +	dev->priv_flags &=3D ~IFF_TX_SKB_SHARING;
> > +	dev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
> > +	dev->lltx =3D true;
> > +
> Maybe setting dev->netns_immutable to true ?
>=20

It makes sense; the SRv6 configuration is bound to the current
netns, so the device should stay there as well.


> Regards,
> Nicolas

Thanks,
Andrea

