Return-Path: <netdev+bounces-264441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHOvLdiaqWm7AgEAu9opvQ
	(envelope-from <netdev+bounces-264441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:01:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE77214134
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5AF03007E31
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE633B4EB0;
	Thu,  5 Mar 2026 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0nzSvkN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6B3B530F
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722642; cv=none; b=nL2lzmSuZqfpIw4zcThbXtV4iuAgNgED9QXb5CeCW33SLLuqQNjbvWUmuz6Pu0ZiMccxP46se6BwljLG+dxG3qKkwx8hkY28HVt4FpHVut2Il6Eo2s4jO6Qh16+F3iweQ7hm1LaCGINMUr3kioRwtu7abfBh6D3wdIG0JEFSGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722642; c=relaxed/simple;
	bh=gPSp+kdrdzwIcc1CIwiTe2fa64oQOsHcFXdE2HNQ+/0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hcUbUsMT6piK73hNuK8THLcHFcP6+7h612/jTiOd7ZGgRtHp2GSOqqmsvFy1uJ+I0JYvW07o7JkIYKUbC8bclXLibP47y1MZmX1BRcmb8/O+teYXFKjNX7RHbIKmPGj9t0m4BkVI+RsD8G4Qwy13oz+wOaXd60N8a7rmPIGY9WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0nzSvkN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7986e0553bdso78967717b3.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 06:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772722640; x=1773327440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wug6obtsVc9Nb/4oIEKb+34EjPpaCh6LrblPTpDaoEY=;
        b=f0nzSvkN3aFkWog1GFkAsbWV8CPb/3ilxYzF7AQVtJBIi263Is06oZQ/AXcnBp7/Lk
         fWoaj1aFmEYYKTbtelcGolDssZ+6A9H6KiT+P8Y0HRYIMwoE7ClzLxNVXytGr+nigx5i
         2vglLe/gd6p2Vv/Qtxry9cqEJfFrfIWEuzXDhAOF96pOUwIhtyDJuthzNW1xt5Oshd1K
         OqSVRghmAAaMEEUWw6HuwoLt4/gH/cS50jMxVVQeegFeRUMg2k43c1bn9cc78gxHtgEf
         l/xkBTtRZl6lsQ5Xu7UFXMewLj25T2fHM9aJgOVV0M3oTni7VSrSo3DFCwlNQXV3hwaW
         zzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772722640; x=1773327440;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wug6obtsVc9Nb/4oIEKb+34EjPpaCh6LrblPTpDaoEY=;
        b=xT5xZJB0UrFpKd3OXZBOJRDWtn4zZ9H7N4SE5p2+RVBJvs+tgT/XaqzwUzroTSIj+C
         6m76wFaMeHFbzrfb8qt2YSd2DJPfYEvX7qAehvKGpjRL8EzwG7/wfnDTcx7udHned++h
         gw11ROeXuN1hkzImrd34JNNRG1kK3XytazJEGnIWVDJTFDOW9aP5fY/jzSry2C3UnP+i
         8rSLEWS743367kH7fgAgDIyEKqmkKNcFYhTgkg5lV/MjYD6ST9y9rmWwPGrlWqRZpJxz
         c1HNOK9oFqChogXHumqWtX7FbY9xTnES1F+9KsLlUvbrpJwlMJJisqfaP+rTtmQvVFqo
         VONQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1Onv7vJCt2Ol8NJmEaKAIFfkSk3i/jcyEucG66JkJSqpYzCLJsjTYNhY4TXekg1cLTeQK3G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCmsaVrZp3ds3mqIGNwIHEcf48teFRzIjLlRvaF6T1QAwo2Bk
	UEfrgsuwLovsrZyU2puQMHnYhcNIVyi9NYod/Iv9gf9Ux1X/uJwG3uUj
X-Gm-Gg: ATEYQzzFoyKR/yGWHO73xzpBKHzG5qNVt8ZUHLMHKqmS30rS8XrreX0GaEDineOwWVM
	QjfNtZjxB2bGzKRS/gPW2IqRh7Xobs3OuV02qFnTzNGE+zFP8xhI2mYsJVQc1FX/4kNJ6bHehG0
	JhlCzlNt7YBG4pqoaIqWUKJldedSk3hoOGnNQ1AK50QWQf8az5Q3UMzWvcFRguOrQk9arU8AWj6
	RP9sk1Wci4f/n0Ig/8rVYYjkx4RkL4S5CRrA5dh6qjCktp5okwiqoMslzg7r1WwTQcB8BtMZ+JQ
	rQsRqtn7MVJJUsAf+5yBP0PdTHvW7jpANftKtJGOixKhf/mdgLdVJTzzM0o4nyLtm+F84Tg6937
	9t/HtcgiufvJ6MsyuCdJasGV+RDNqCweYTyaX3o0X1HVCjAYEj1GkylHETwKli3U5r3zzLWyDk7
	SDWjhOnJpJtgVYP14FpolgGaFweYtjXIMhwFxqU4BiXqTTpPjmZSHgVgsa4VVs7w/+72zVJzk=
X-Received: by 2002:a05:690c:dd5:b0:798:68c0:d9fc with SMTP id 00721157ae682-798da50bbf6mr404867b3.49.1772722639533;
        Thu, 05 Mar 2026 06:57:19 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79876bf8103sm89597177b3.27.2026.03.05.06.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:57:18 -0800 (PST)
Date: Thu, 05 Mar 2026 09:57:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: xietangxin <xietangxin@yeah.net>, 
 Jakub Ramaseuski <jramaseu@redhat.com>, 
 netdev@vger.kernel.org
Cc: kuba@kernel.org, 
 horms@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 sdf@fomichev.me, 
 ahmed.zaki@intel.com, 
 aleksander.lobakin@intel.com, 
 benoit.monin@gmx.fr, 
 willemb@google.com, 
 Tianhao Zhao <tizhao@redhat.com>, 
 Michal Schmidt <mschmidt@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <willemdebruijn.kernel.d12bc5fb9c16@gmail.com>
In-Reply-To: <0414e7e2-9a1c-4d7c-a99d-b9039cf68f40@yeah.net>
References: <20250814105119.1525687-1-jramaseu@redhat.com>
 <0414e7e2-9a1c-4d7c-a99d-b9039cf68f40@yeah.net>
Subject: Re: [PATCH net v3] net: gso: Forbid IPv6 TSO with extensions on
 devices with only IPV6_CSUM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CBE77214134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264441-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,fomichev.me,intel.com,gmx.fr,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[yeah.net,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

xietangxin wrote:
> =

> =

> =E5=9C=A8 2025/8/14 18:51, Jakub Ramaseuski =E5=86=99=E9=81=93:
> > When performing Generic Segmentation Offload (GSO) on an IPv6 packet =
that
> > contains extension headers, the kernel incorrectly requests checksum =
offload
> > if the egress device only advertises NETIF_F_IPV6_CSUM feature, which=
 has =

> > a strict contract: it supports checksum offload only for plain TCP or=
 UDP =

> > over IPv6 and explicitly does not support packets with extension head=
ers.
> > The current GSO logic violates this contract by failing to disable th=
e feature
> > for packets with extension headers, such as those used in GREoIPv6 tu=
nnels.
> > =

> > This violation results in the device being asked to perform an operat=
ion
> > it cannot support, leading to a `skb_warn_bad_offload` warning and a =
collapse
> > of network throughput. While device TSO/USO is correctly bypassed in =
favor
> > of software GSO for these packets, the GSO stack must be explicitly t=
old not =

> > to request checksum offload.
> > =

> > Mask NETIF_F_IPV6_CSUM, NETIF_F_TSO6 and NETIF_F_GSO_UDP_L4
> > in gso_features_check if the IPv6 header contains extension headers t=
o compute
> > checksum in software.
> > =

> > The exception is a BIG TCP extension, which, as stated in commit
> > 68e068cabd2c6c53 ("net: reenable NETIF_F_IPV6_CSUM offload for BIG TC=
P packets"):
> > "The feature is only enabled on devices that support BIG TCP TSO.
> > The header is only present for PF_PACKET taps like tcpdump,
> > and not transmitted by physical devices."
> > =

> > kernel log output (truncated):
> > WARNING: CPU: 1 PID: 5273 at net/core/dev.c:3535 skb_warn_bad_offload=
+0x81/0x140
> > ...
> > Call Trace:
> >  <TASK>
> >  skb_checksum_help+0x12a/0x1f0
> >  validate_xmit_skb+0x1a3/0x2d0
> >  validate_xmit_skb_list+0x4f/0x80
> >  sch_direct_xmit+0x1a2/0x380
> >  __dev_xmit_skb+0x242/0x670
> >  __dev_queue_xmit+0x3fc/0x7f0
> >  ip6_finish_output2+0x25e/0x5d0
> >  ip6_finish_output+0x1fc/0x3f0
> >  ip6_tnl_xmit+0x608/0xc00 [ip6_tunnel]
> >  ip6gre_tunnel_xmit+0x1c0/0x390 [ip6_gre]
> >  dev_hard_start_xmit+0x63/0x1c0
> >  __dev_queue_xmit+0x6d0/0x7f0
> >  ip6_finish_output2+0x214/0x5d0
> >  ip6_finish_output+0x1fc/0x3f0
> >  ip6_xmit+0x2ca/0x6f0
> >  ip6_finish_output+0x1fc/0x3f0
> >  ip6_xmit+0x2ca/0x6f0
> >  inet6_csk_xmit+0xeb/0x150
> >  __tcp_transmit_skb+0x555/0xa80
> >  tcp_write_xmit+0x32a/0xe90
> >  tcp_sendmsg_locked+0x437/0x1110
> >  tcp_sendmsg+0x2f/0x50
> > ...
> > skb linear:   00000000: e4 3d 1a 7d ec 30 e4 3d 1a 7e 5d 90 86 dd 60 =
0e
> > skb linear:   00000010: 00 0a 1b 34 3c 40 20 11 00 00 00 00 00 00 00 =
00
> > skb linear:   00000020: 00 00 00 00 00 12 20 11 00 00 00 00 00 00 00 =
00
> > skb linear:   00000030: 00 00 00 00 00 11 2f 00 04 01 04 01 01 00 00 =
00
> > skb linear:   00000040: 86 dd 60 0e 00 0a 1b 00 06 40 20 23 00 00 00 =
00
> > skb linear:   00000050: 00 00 00 00 00 00 00 00 00 12 20 23 00 00 00 =
00
> > skb linear:   00000060: 00 00 00 00 00 00 00 00 00 11 bf 96 14 51 13 =
f9
> > skb linear:   00000070: ae 27 a0 a8 2b e3 80 18 00 40 5b 6f 00 00 01 =
01
> > skb linear:   00000080: 08 0a 42 d4 50 d5 4b 70 f8 1a
> > =

> > Fixes: 04c20a9356f283da ("net: skip offload for NETIF_F_IPV6_CSUM if =
ipv6 header contains extension")
> > Reported-by: Tianhao Zhao <tizhao@redhat.com>
> > Suggested-by: Michal Schmidt <mschmidt@redhat.com>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
> > ---
> > ---
> >  net/core/dev.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > =

> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index b28ce68830b2b..1d8a4d1da911e 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3778,6 +3778,18 @@ static netdev_features_t gso_features_check(co=
nst struct sk_buff *skb,
> >  		if (!(iph->frag_off & htons(IP_DF)))
> >  			features &=3D ~NETIF_F_TSO_MANGLEID;
> >  	}
> > +
> > +	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
> > +	 * so neither does TSO that depends on it.
> > +	 */
> > +	if (features & NETIF_F_IPV6_CSUM &&
> > +	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> > +	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> > +	      vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6))) &&
> > +	    skb_transport_header_was_set(skb) &&
> > +	    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr) &&
> > +	    !ipv6_has_hopopt_jumbo(skb))
> > +		features &=3D ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP=
_L4);
> >  =

> >  	return features;
> >  }
> question about this patch affecting tunneled IPv6-in-IPv4 packets
> =

> In our environment with a hinic NIC, we use VXLAN tunnels where
> the outer header is IPv4 and the inner is IPv6. After this commit,
> large packets no longer use hardware TSO and fall back to software segm=
entation.
> =

> In the VXLAN IPv6-in-IPv4 case, `skb_shinfo(skb)->gso_type` includes
> `SKB_GSO_TCPV6` (inner is IPv6 TCP), but the network header points to t=
he outer
> IPv4 header. Thus `skb_network_header_len(skb)` returns the IPv4 header=
 length
> (usually 20), which is not equal to `sizeof(struct ipv6hdr)` (40). This=
 causes
> the condition to trigger and clears `NETIF_F_TSO6`, even though the inn=
er IPv6
> packet has no extension headers and the device is capable of handling T=
SO for
> such packets.
> =

> Is it the intended behavior to disable TSO for all tunneled IPv6-in-IPv=
4 packets
> when the NIC lacks NETIF_F_HW_CSUM, even if the inner IPv6 header has n=
o extensions?
> =

> Any feedback or guidance would be greatly appreciated.

That is definitely unintended.

Thanks for the clear analysis.

I was about to write a refinement that might catch this case,
something like

@@ -3819,8 +3819,10 @@ static netdev_features_t gso_features_check(const =
struct sk_buff *skb,
            (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
             (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
              vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6))) &&
-           skb_transport_header_was_set(skb) &&
-           skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
+             ((!skb->encapsulation &&
+               skb_transport_header_was_set(skb) &&
+               skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr)) =
||
+              (skb_inner_network_header_len(skb) !=3D sizeof(struct ipv6=
hdr))))
                features &=3D ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_=
F_GSO_UDP_L4);

But, how are these VXLAN IPv6-in-IPv4 packets having
vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6)?

Shouldn't that be the protocol of the outer headr, so ETH_P_IP, and
thus this branch not reached at all? (Which itself would leave a false
positive as now an inner network header with extensions would not be
caught..)


