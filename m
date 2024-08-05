Return-Path: <netdev+bounces-115691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25429478FA
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5874A280C22
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A311149E05;
	Mon,  5 Aug 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FZIP7MxS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32403558BC
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852263; cv=none; b=qD40Iz02gQhhSEeruvvQJxUPR3ugt19eLmcpxo+1JtEDvvDsbnBpt7+T6kf2eCoH/7suUoHFgr6U2Gbja11AK3qrY2ayyDDR9iAlo2UuDW0NwESefss6gBKAOXloBhkweXfujjH/NkvIUSVrsRpaa4AAjhNjHLGKP8gvj2vFm3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852263; c=relaxed/simple;
	bh=mP/8fCContdHkq1AWYHoCjWVS/fVD3Mv8AD8yIj5zH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gumHiWR7fdpn5yCkrZb2oAgy8yZF2h13AimDMDjDVb1KJsZAqo7QATv7JS7VkFuLmvdamgs3kaEnudXtHC3a8QPiV2hbRODV2XSw7RIES2LrtFOvOsTuXOsDi3scqUfevtHUcjt/BfU2XwKMQLheP9L0FzXYJowu9+iCpnn9UiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FZIP7MxS; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so8667169a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722852259; x=1723457059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJpmzKrVQuF15QWod2MJGSkBPng8F0SObCdeR7Bf1Fg=;
        b=FZIP7MxSN7Mn9R6+EPgf5ZyJbFKBwKrx9iNNBhNCEK7z86dRumyyYJSqYbG91aFw2X
         hzbrOhBhfhlK3JX1AbnvrD+X9vQYzhk19gwLwThasDyguEkslMhMy4WsRfBOuBReJxvK
         MlAOfCm6oGKGOU5998S5lTXxKpUHVoQer72/ereXXngf8EomvWMqxnMApsK1Q2ACWt5d
         RepP9RHySIFKJi67pN2WHZ9fZocB2pByG9hq5PZEexSGGdFrhrCt1em38WxlkoBKmA9I
         cdFRKABxCWmtQO4Q4SNauFb21goyiN+lF9Y9Vv2ifgnfxciXB8oT9AdnVaSOEJ6lUEZb
         zqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852259; x=1723457059;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tJpmzKrVQuF15QWod2MJGSkBPng8F0SObCdeR7Bf1Fg=;
        b=K6cRq5QpC5zbI+6vSkunhgXvjVPgWW8Pvms2VFuU44XdIaKwCac+W41onMdunN8bO0
         2zHgYnquY+5+EEqwPKLTwtoA0FXKwHKFK87yyKAVpVILhc7l7lavpLAx7HF9HDF607Yg
         fvb3P9T4OIP/3i9AgajaDGiIScQ44FMt1ilgY/Cyic+yXqsd2eKh2z01sy9Wxin2Npmm
         yNZ6ENUv6VPMl3CxxGjm/+CWP/nOY5xcuoesANExC64ibMpmnjNdp0vTZEklPKgOyjk1
         V0nMHWvjxf4yVobStqdRrQvI0B7DhqfpNXZLHf6E3Z5BaDWbqq0PxqMA6NXj7Z5nCYf9
         TBFw==
X-Gm-Message-State: AOJu0Yy6TPcPaBBeg2UCDXDI0eYNsGPMQDe58+MyyG63bxbB8gsOR+FS
	g5i1UfSXB6uIpDQSNCpFmfS8Ws3ZUUK5ETgLCl2EFpe+LCC/xM0AcZxhJu6vA0Q=
X-Google-Smtp-Source: AGHT+IHICPFZvQ2cy13z4zBcDQaLj6PK1JaIoG35PB9kCNQC+tpxq2BnAeaTi4IhZTYWH7Iamm5HOQ==
X-Received: by 2002:a05:6402:655:b0:5b9:fe2f:48e4 with SMTP id 4fb4d7f45d1cf-5b9fe2f490dmr5490421a12.6.1722852259221;
        Mon, 05 Aug 2024 03:04:19 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83bf3ad38sm4722146a12.84.2024.08.05.03.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 03:04:18 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,
  kernel-team@cloudflare.com,
  syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2 1/2] gso: Skip bad offload detection when device
 supports requested GSO
In-Reply-To: <CAF=yD-JaeHASZacOPk=k2gzpfY7OzMwDPr99FMfthMS0w9S7bA@mail.gmail.com>
	(Willem de Bruijn's message of "Thu, 1 Aug 2024 15:13:51 -0400")
References: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
	<20240801-udp-gso-egress-from-tunnel-v2-1-9a2af2f15d8d@cloudflare.com>
	<CAF=yD-JaeHASZacOPk=k2gzpfY7OzMwDPr99FMfthMS0w9S7bA@mail.gmail.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 05 Aug 2024 12:04:17 +0200
Message-ID: <87ed73z3oe.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 03:13 PM -04, Willem de Bruijn wrote:
> On Thu, Aug 1, 2024 at 10:09=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> In commit 10154dbded6d ("udp: Allow GSO transmit from devices with no
>> checksum offload") we have intentionally allowed UDP GSO packets marked
>> CHECKSUM_NONE to pass to the GSO stack, so that they can be segmented and
>> checksummed by a software fallback when the egress device lacks these
>> features.
>>
>> What was not taken into consideration is that a CHECKSUM_NONE skb can be
>> handed over to the GSO stack also when the egress device advertises the
>> tx-udp-segmentation / NETIF_F_GSO_UDP_L4 feature.
>>
>> This can happen in two situations, which we detect in __ip_append_data()
>> and __ip6_append_data():
>>
>> 1) when there are IPv6 extension headers present, or
>> 2) when the tunnel device does not advertise checksum offload.
>>
>> Note that in the latter case we have a nonsensical device configuration.
>> Device support for UDP segmentation offload requires checksum offload in
>> hardware as well.
>>
>> Syzbot has discovered the first case, producing a warning as below:
>>
>>   ip6tnl0: caps=3D(0x00000006401d7869, 0x00000006401d7869)
>>   WARNING: CPU: 0 PID: 5112 at net/core/dev.c:3293 skb_warn_bad_offload+=
0x166/0x1a0 net/core/dev.c:3291
>>   Modules linked in:
>>   CPU: 0 PID: 5112 Comm: syz-executor391 Not tainted 6.10.0-rc7-syzkalle=
r-01603-g80ab5445da62 #0
>>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 06/07/2024
>>   RIP: 0010:skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
>>   [...]
>>   Call Trace:
>>    <TASK>
>>    __skb_gso_segment+0x3be/0x4c0 net/core/gso.c:127
>>    skb_gso_segment include/net/gso.h:83 [inline]
>>    validate_xmit_skb+0x585/0x1120 net/core/dev.c:3661
>>    __dev_queue_xmit+0x17a4/0x3e90 net/core/dev.c:4415
>>    neigh_output include/net/neighbour.h:542 [inline]
>>    ip6_finish_output2+0xffa/0x1680 net/ipv6/ip6_output.c:137
>>    ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
>>    ip6_send_skb+0x112/0x230 net/ipv6/ip6_output.c:1958
>>    udp_v6_send_skb+0xbf5/0x1870 net/ipv6/udp.c:1292
>>    udpv6_sendmsg+0x23b3/0x3270 net/ipv6/udp.c:1588
>>    sock_sendmsg_nosec net/socket.c:730 [inline]
>>    __sock_sendmsg+0xef/0x270 net/socket.c:745
>>    ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
>>    ___sys_sendmsg net/socket.c:2639 [inline]
>>    __sys_sendmmsg+0x3b2/0x740 net/socket.c:2725
>>    __do_sys_sendmmsg net/socket.c:2754 [inline]
>>    __se_sys_sendmmsg net/socket.c:2751 [inline]
>>    __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2751
>>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>    [...]
>>    </TASK>
>>
>> We are hitting the bad offload warning because when an egress device is
>> capable of handling segmentation offload requested by
>> skb_shinfo(skb)->gso_type, the chain of gso_segment callbacks won't prod=
uce
>> any segment skbs and return NULL. See the skb_gso_ok() branch in
>> {__udp,tcp,sctp}_gso_segment helpers.
>>
>> To fix it, skip bad offload detection when gso_segment has returned
>> nothing. We know that in such case the egress device supports the desired
>> GSO offload, which implies that it can fill in L4 checksums. Hence we do=
n't
>> need to check the skb->ip_summed value, which reflects the egress device
>> checksum capabilities.
>>
>> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no check=
sum offload")
>> Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/000000000000e1609a061d5330ce@google.=
com/
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> It's a bit odd, in that the ip_summed =3D=3D CHECKSUM_NONE ends up just
> being ignored and devices are trusted to always be able to checksum
> offload when they can segment offload -- even when the device does not
> advertise checksum offload.
>
> I think we should have a follow-on that makes advertising
> NETIF_F_GSO_UDP_L4 dependent on having at least one of the
> NETIF_F_*_CSUM bits set (handwaving over what happens when only
> advertising NETIF_F_IP_CSUM or NETIF_F_IPV6_CSUM).

I agree. I've also gained some clarity as to how the fix should
look. Let's circle back to it, if we still think it's relevant once we
hash out the fix.

After spending some quality time debugging the addded regression test
[1], I've realized this fix is wrong.

You see, with commit 10154dbded6d ("udp: Allow GSO transmit from devices
with no checksum offload"), I've opened up the UDP_SEGMENT API to two
uses, which I think should not be allowed:

1. Hardware USO for IPv6 dgrams with extension headers

Previously that led to -EIO, because __ip6_append_data won't annotate
such packets as CHECKSUM_PARTIAL.

I'm guessing that we do this because some drivers that advertise csum
offload can't actually handle checksumming when extension headers are
present.

Extension headers are not part of IPv6 pseudo header, but who knows what
limitations NIC firmwares have.

Either way, changing it just like that sounds risky, so I think we need
to fall back to software USO with software checksum in this case.

Alternatively, we could catch it in the udp layer and error out with EIO
as ealier. But that shifts some burden onto the user space (detect and
segment before sendmsg()).

2. Hardware USO when hardware csum is unsupported / disabled

That sounds like a pathological device configuration case, but since it
is possible today with some drivers to disable csum offload for one IP
version and not the other, it seems safest to just handle that
gracefully.

I don't know why one might want to do that. Perhaps as a workaround for
some firmware bug while waiting for a fix?

In this scenario I think we also need to fall back to software USO and
checksum.

Code-wise that could look like below. WDYT?

[1] I feel silly for submitting a broken patch. I've been running a
stale test prog in a VM. It seems that virtme-ng with a read+write
overlay for rootfs played a trick on me. Changes to the host files are
not (always?) visible to the guest.

---8<---
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8aa2d1..819173807c81 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4806,7 +4806,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			goto perform_csum_check;
=20
 		if (!sg) {
-			if (!csum) {
+			/* Fall back to software checksum for segments if:
+			 * 1) device can't checksum this network protocol, OR
+			 * 2) we consider the packet to be not checksummable in
+			 *    hardware, for example IPv6 extension headers are
+			 *    present.
+			 */
+			if (!csum || head_skb->ip_summed !=3D CHECKSUM_PARTIAL) {
 				if (!nskb->remcsum_offload)
 					nskb->ip_summed =3D CHECKSUM_NONE;
 				SKB_GSO_CB(nskb)->csum =3D
@@ -4896,7 +4902,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		nskb->truesize +=3D nskb->data_len;
=20
 perform_csum_check:
-		if (!csum) {
+		if (!csum || head_skb->ip_summed !=3D CHECKSUM_PARTIAL) {
 			if (skb_has_shared_frag(nskb) &&
 			    __skb_linearize(nskb))
 				goto err;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index bc8a9da750fe..0a34b418b83c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -282,7 +282,15 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_=
skb,
 		     skb_transport_header(gso_skb)))
 		return ERR_PTR(-EINVAL);
=20
-	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
+	/* Pass-through to device for segmentation only if:
+	 * 1) we consider the packet checksummable in hardware, that is no
+	 *    IPv6 extension headers present, AND
+	 * 2) device supports checksum offload for this network protocol
+	 *    (NETIF_F_{IP,IPV6}_CSUM or NETIF_F_HW_CSUM), AND
+	 * 3) device supports the requested GSO kind.
+	 */
+	if (gso_skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
+	    skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
 		/* Packet is from an untrusted source, reset gso_segs. */
 		skb_shinfo(gso_skb)->gso_segs =3D DIV_ROUND_UP(gso_skb->len - sizeof(*uh=
),
 							     mss);

