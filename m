Return-Path: <netdev+bounces-115794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85303947CCA
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B151F2367D
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD213A884;
	Mon,  5 Aug 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms7uSgOx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E5558A5
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867927; cv=none; b=hCCEnAuBqCdBiSsLtss7cegkyC9iBcWIyEkNOayaTIyLfHr4EuzgALlxrbPWmJ83dc96f3thPpyqsD4cLHwcBh8/aM9X2FJp1nKkIAUtLQ1QIZIBK+ogJfuHcR+xMeSKeGBYcRFyt+HneX7qDqxUMat/DVewH/8YGwVeNWVkRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867927; c=relaxed/simple;
	bh=NAtnJxejDo4oVY4XYwVqIP+GLZk0LEgY6hvtQgimeh4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=s8b9yAyM/0/3AIDlCe8LgGE7N0Bac9igq0Wn10Gfbc6QspR76JlLEg6EjADfC93QwiUDDpHy7lBf0s2QIxIETUCC96UmXNuGCfVdkDqbNe4ADO+2Hkc+K+dWlC7B3Ev/3dF0JCdjHofikGMwle2obf4lafepoSOX6BUK3OXcFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ms7uSgOx; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44ff50affc5so59406201cf.1
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722867925; x=1723472725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xnOSGhWLeyQ1G5BTNUkcht4f1HKPO3tPwy7SvQIfOA=;
        b=Ms7uSgOxtECGdgJZFQjTJvl5+OWLN/kDNIhSxDlu97eJ3EztYPkcr5YHbtvjdiq5CO
         q2okYTIhQvkUmU+3WEp/2tdhIb0WXuQGfCSQi/b/Q7JqTjucBgnvfss66CCHrJewCp9x
         jjZzOnU1xyTsUjjRrJwClbRQoye6aXXhLnY4hYpfG40TjXfnw1Cv2V24T8wM0LEues27
         5brM3SL3puOU1MiUTVhTlrxVh9mPMv/SFJP9PuD4j0Sm9jX1OXtTNevolm1prXm15kbJ
         Tv3Xj/7Tg7VbObq2mcvoyUvesBwE+/yecLkNDp1CFF7DFWBsXLI5wkqe4JC7nvJo+MwO
         +toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722867925; x=1723472725;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3xnOSGhWLeyQ1G5BTNUkcht4f1HKPO3tPwy7SvQIfOA=;
        b=uWZsTPf7chUzXsAFIJ93npxghCrO/+XnBEoveiaA9jwsSCSlpfrwuedb/Keeq0fFLT
         D92VUv/GYRz1CMq2MnLQuUGNp2G/LdFxsCSYw0JaNWwngzLQP4OWGtXxOf9FscvriyU1
         XzDDg995o3Eu9U0gH/OtRaYI2ubV5+JtQL8kVxP3VV3FPFeVJjZZze6zoUNmoSCuGYFD
         kdstXOsJMXsZlWu1pRMb+FLWD9JNNJGOBwpwuo1gEo+VFLvJxzTJmWMnGD70Gpbb4N6r
         4TkDpTV5144OvLjZaWWGU/VF8kzJCBlEy95Hh8f1TTyFPXnHvQinA+d8MbOlAd1hrdLH
         oazg==
X-Gm-Message-State: AOJu0YzF/6J5247/IGMd9ozvZPYasR2bdbVHOh7o6fw2sVOg8oN2//02
	ZqsidyiGFqfI6Kz1nsm+zgwgS2rpcaBiPdAxi0Q4B2nN6qVtza5V
X-Google-Smtp-Source: AGHT+IFGidlURkXiCsV7Q2a2T8BUzw5VKj6mr1oZdEV/K6i5M25/Vfuy+hEhVdLJ8l/NFzZs1ruobw==
X-Received: by 2002:a05:622a:cb:b0:447:f211:43f2 with SMTP id d75a77b69052e-451892549abmr176767081cf.12.1722867924699;
        Mon, 05 Aug 2024 07:25:24 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6ae6fesm29789421cf.17.2024.08.05.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:25:24 -0700 (PDT)
Date: Mon, 05 Aug 2024 10:25:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com, 
 syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Message-ID: <66b0e0d3c2119_2f5edf294c1@willemb.c.googlers.com.notmuch>
In-Reply-To: <87ed73z3oe.fsf@cloudflare.com>
References: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
 <20240801-udp-gso-egress-from-tunnel-v2-1-9a2af2f15d8d@cloudflare.com>
 <CAF=yD-JaeHASZacOPk=k2gzpfY7OzMwDPr99FMfthMS0w9S7bA@mail.gmail.com>
 <87ed73z3oe.fsf@cloudflare.com>
Subject: Re: [PATCH net v2 1/2] gso: Skip bad offload detection when device
 supports requested GSO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Sitnicki wrote:
> On Thu, Aug 01, 2024 at 03:13 PM -04, Willem de Bruijn wrote:
> > On Thu, Aug 1, 2024 at 10:09=E2=80=AFAM Jakub Sitnicki <jakub@cloudfl=
are.com> wrote:
> >>
> >> In commit 10154dbded6d ("udp: Allow GSO transmit from devices with n=
o
> >> checksum offload") we have intentionally allowed UDP GSO packets mar=
ked
> >> CHECKSUM_NONE to pass to the GSO stack, so that they can be segmente=
d and
> >> checksummed by a software fallback when the egress device lacks thes=
e
> >> features.
> >>
> >> What was not taken into consideration is that a CHECKSUM_NONE skb ca=
n be
> >> handed over to the GSO stack also when the egress device advertises =
the
> >> tx-udp-segmentation / NETIF_F_GSO_UDP_L4 feature.
> >>
> >> This can happen in two situations, which we detect in __ip_append_da=
ta()
> >> and __ip6_append_data():
> >>
> >> 1) when there are IPv6 extension headers present, or
> >> 2) when the tunnel device does not advertise checksum offload.
> >>
> >> Note that in the latter case we have a nonsensical device configurat=
ion.
> >> Device support for UDP segmentation offload requires checksum offloa=
d in
> >> hardware as well.
> >>
> >> Syzbot has discovered the first case, producing a warning as below:
> >>
> >>   ip6tnl0: caps=3D(0x00000006401d7869, 0x00000006401d7869)
> >>   WARNING: CPU: 0 PID: 5112 at net/core/dev.c:3293 skb_warn_bad_offl=
oad+0x166/0x1a0 net/core/dev.c:3291
> >>   Modules linked in:
> >>   CPU: 0 PID: 5112 Comm: syz-executor391 Not tainted 6.10.0-rc7-syzk=
aller-01603-g80ab5445da62 #0
> >>   Hardware name: Google Google Compute Engine/Google Compute Engine,=
 BIOS Google 06/07/2024
> >>   RIP: 0010:skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
> >>   [...]
> >>   Call Trace:
> >>    <TASK>
> >>    __skb_gso_segment+0x3be/0x4c0 net/core/gso.c:127
> >>    skb_gso_segment include/net/gso.h:83 [inline]
> >>    validate_xmit_skb+0x585/0x1120 net/core/dev.c:3661
> >>    __dev_queue_xmit+0x17a4/0x3e90 net/core/dev.c:4415
> >>    neigh_output include/net/neighbour.h:542 [inline]
> >>    ip6_finish_output2+0xffa/0x1680 net/ipv6/ip6_output.c:137
> >>    ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
> >>    ip6_send_skb+0x112/0x230 net/ipv6/ip6_output.c:1958
> >>    udp_v6_send_skb+0xbf5/0x1870 net/ipv6/udp.c:1292
> >>    udpv6_sendmsg+0x23b3/0x3270 net/ipv6/udp.c:1588
> >>    sock_sendmsg_nosec net/socket.c:730 [inline]
> >>    __sock_sendmsg+0xef/0x270 net/socket.c:745
> >>    ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
> >>    ___sys_sendmsg net/socket.c:2639 [inline]
> >>    __sys_sendmmsg+0x3b2/0x740 net/socket.c:2725
> >>    __do_sys_sendmmsg net/socket.c:2754 [inline]
> >>    __se_sys_sendmmsg net/socket.c:2751 [inline]
> >>    __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2751
> >>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >>    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>    [...]
> >>    </TASK>
> >>
> >> We are hitting the bad offload warning because when an egress device=
 is
> >> capable of handling segmentation offload requested by
> >> skb_shinfo(skb)->gso_type, the chain of gso_segment callbacks won't =
produce
> >> any segment skbs and return NULL. See the skb_gso_ok() branch in
> >> {__udp,tcp,sctp}_gso_segment helpers.
> >>
> >> To fix it, skip bad offload detection when gso_segment has returned
> >> nothing. We know that in such case the egress device supports the de=
sired
> >> GSO offload, which implies that it can fill in L4 checksums. Hence w=
e don't
> >> need to check the skb->ip_summed value, which reflects the egress de=
vice
> >> checksum capabilities.
> >>
> >> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no c=
hecksum offload")
> >> Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
> >> Closes: https://lore.kernel.org/all/000000000000e1609a061d5330ce@goo=
gle.com/
> >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> >
> > It's a bit odd, in that the ip_summed =3D=3D CHECKSUM_NONE ends up ju=
st
> > being ignored and devices are trusted to always be able to checksum
> > offload when they can segment offload -- even when the device does no=
t
> > advertise checksum offload.
> >
> > I think we should have a follow-on that makes advertising
> > NETIF_F_GSO_UDP_L4 dependent on having at least one of the
> > NETIF_F_*_CSUM bits set (handwaving over what happens when only
> > advertising NETIF_F_IP_CSUM or NETIF_F_IPV6_CSUM).
> =

> I agree. I've also gained some clarity as to how the fix should
> look. Let's circle back to it, if we still think it's relevant once we
> hash out the fix.
> =

> After spending some quality time debugging the addded regression test
> [1], I've realized this fix is wrong.
> =

> You see, with commit 10154dbded6d ("udp: Allow GSO transmit from device=
s
> with no checksum offload"), I've opened up the UDP_SEGMENT API to two
> uses, which I think should not be allowed:
> =

> 1. Hardware USO for IPv6 dgrams with extension headers
> =

> Previously that led to -EIO, because __ip6_append_data won't annotate
> such packets as CHECKSUM_PARTIAL.
> =

> I'm guessing that we do this because some drivers that advertise csum
> offload can't actually handle checksumming when extension headers are
> present.
> =

> Extension headers are not part of IPv6 pseudo header, but who knows wha=
t
> limitations NIC firmwares have.
> =

> Either way, changing it just like that sounds risky, so I think we need=

> to fall back to software USO with software checksum in this case.
> =

> Alternatively, we could catch it in the udp layer and error out with EI=
O
> as ealier. But that shifts some burden onto the user space (detect and
> segment before sendmsg()).
> =

> 2. Hardware USO when hardware csum is unsupported / disabled
> =

> That sounds like a pathological device configuration case, but since it=

> is possible today with some drivers to disable csum offload for one IP
> version and not the other, it seems safest to just handle that
> gracefully.
> =

> I don't know why one might want to do that. Perhaps as a workaround for=

> some firmware bug while waiting for a fix?

I doubt that this is actually used. But today it can be configured.

Which is why I suggested making NETIF_F_GSO_UDP_L4 dependent on csum
offload (in netdev_fix_features). I doubt that that will break any
real user.
 =

> In this scenario I think we also need to fall back to software USO and
> checksum.
> =

> Code-wise that could look like below. WDYT?

Since this only affects USO, can we fix this is in __udp_gso_segment.
Basically, not taking the NETIF_F_GSO_ROBUST path.

skb_segment is so complicated already. Whatever we can do to avoid
adding to that.

> [1] I feel silly for submitting a broken patch. I've been running a
> stale test prog in a VM. It seems that virtme-ng with a read+write
> overlay for rootfs played a trick on me. Changes to the host files are
> not (always?) visible to the guest.
> =

> ---8<---
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 83f8cd8aa2d1..819173807c81 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4806,7 +4806,13 @@ struct sk_buff *skb_segment(struct sk_buff *head=
_skb,
>  			goto perform_csum_check;
>  =

>  		if (!sg) {
> -			if (!csum) {
> +			/* Fall back to software checksum for segments if:
> +			 * 1) device can't checksum this network protocol, OR
> +			 * 2) we consider the packet to be not checksummable in
> +			 *    hardware, for example IPv6 extension headers are
> +			 *    present.
> +			 */
> +			if (!csum || head_skb->ip_summed !=3D CHECKSUM_PARTIAL) {
>  				if (!nskb->remcsum_offload)
>  					nskb->ip_summed =3D CHECKSUM_NONE;
>  				SKB_GSO_CB(nskb)->csum =3D
> @@ -4896,7 +4902,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_=
skb,
>  		nskb->truesize +=3D nskb->data_len;
>  =

>  perform_csum_check:
> -		if (!csum) {
> +		if (!csum || head_skb->ip_summed !=3D CHECKSUM_PARTIAL) {
>  			if (skb_has_shared_frag(nskb) &&
>  			    __skb_linearize(nskb))
>  				goto err;
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index bc8a9da750fe..0a34b418b83c 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -282,7 +282,15 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *=
gso_skb,
>  		     skb_transport_header(gso_skb)))
>  		return ERR_PTR(-EINVAL);
>  =

> -	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
> +	/* Pass-through to device for segmentation only if:
> +	 * 1) we consider the packet checksummable in hardware, that is no
> +	 *    IPv6 extension headers present, AND
> +	 * 2) device supports checksum offload for this network protocol
> +	 *    (NETIF_F_{IP,IPV6}_CSUM or NETIF_F_HW_CSUM), AND
> +	 * 3) device supports the requested GSO kind.
> +	 */
> +	if (gso_skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
> +	    skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
>  		/* Packet is from an untrusted source, reset gso_segs. */
>  		skb_shinfo(gso_skb)->gso_segs =3D DIV_ROUND_UP(gso_skb->len - sizeof=
(*uh),
>  							     mss);



