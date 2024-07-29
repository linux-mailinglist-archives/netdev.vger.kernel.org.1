Return-Path: <netdev+bounces-113829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD189400E9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 00:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFA61F22E8E
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70B18E75C;
	Mon, 29 Jul 2024 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YxkHy1az"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1F18757E
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722291037; cv=none; b=lB1h8J8XR6wg+SUy3luMnBPI+Zp6zdBkFiE5CaIagrFdQcKJCN73WcpTzyv09/HUBloGW1C9WEBvETyadoLPHuHR5I3kwZ8d4weHqRSGmzqQMKHKTJWxZYyh9BkoIUNhXbPoUz1vt2c5CQRvzMB8MMW8uZcS1sM43+bA0piumLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722291037; c=relaxed/simple;
	bh=L4eyB9Mpq4i73EKwGnp3jn5W5V6+QABDHeV4aE9rIBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ut3Mmn3AjHfNo4XAi5pxlnfZKj20/M690ptKN0oYdTDeCTbMZ9EE04gDNSNa3Fg7lB3fqynvuhoa7FxDY8T9Rm86WS99LyUQzXtNAU7Nf/dMfk27bkQuRVP6VZ9qJwH3Tedi9mzUmwq2G0ugcU136ZbRqlVcj6GMLExnTComhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YxkHy1az; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so515310366b.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722291034; x=1722895834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AN7vpHTUuAncG8ovvSzomyesiZaO680b8/gZISUbo0=;
        b=YxkHy1az2Br/W/ajIoXAfLPaa6sBoIjOLjyt/3TMc2flgnIznBI8QNucDyCdns9v25
         Ldl+buRQxuGmi/VjNt5qIOrAnwJ6FfvNdaGQpyHqtkx/GtdWyxHi9LLtFOmvUIH0qFx8
         RQWmdJBB82qEkbo6ouEXNMlqbM7641vPyOag8/ctBdURTq7luOqCj4f5Mp8k9w/SGGj9
         mkA+dUmctW8NOTaHa1pnkUe+TXWTuERb1eqvEvWTmEwZYS0caR0k1WTGE2jNaQLjkDqN
         avYrGalFktE7ct0XteV6vxGz3RmIPj/yGY4ZyjE6fstTxnLAMi8+yljoFVKJCdzez75u
         L/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722291034; x=1722895834;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5AN7vpHTUuAncG8ovvSzomyesiZaO680b8/gZISUbo0=;
        b=jLFNhnmKWyrO/x6T8UBIgE3snSbZjWJe1L5WSU7QJ+dJANCjU1WSzP745YLDCcjNFT
         56azrGH8WL+dB9KP/mss4u3W3I4Woj03R3MR+VlS9hQZUm9A+S3hbuNiQaeXWdwFbYdo
         b7qymaZvQI8DjiQAXaLQc5ts9kfmOefNbUbN34aLBOHE9qc9lHvsFZ/l6VOSL9fUkjnZ
         kpvARVjF0Ja7KUdK0za43su2+V/NHJrYxRUMJxMx+hHRaJXEKnT2bQ94iQmQnb6Kx3Gk
         UQfyVZd5UrEMoaCepX05PzBX9u4m9MqJbnYwOC1XjMnSq/04dshwDDGe2EvV3rRrhGno
         7afA==
X-Gm-Message-State: AOJu0YzSRSoPMuO71zmBF4kN0DYtL+3gkjq2qCtJLSZqpjEh5kCl2nF7
	IO1S4VYXD/wnBaT4/IrD9XSX37B1RCnHKIsWOVHQZ8GgFZ5cY2UNgXxvkxCpEMc=
X-Google-Smtp-Source: AGHT+IFuD/GdjYNlqNlcUh86h+1grc6tT21KgTi5sT7FCAvKDEq+J8uPhwSrcbcbAhIgIFGl5VNjyA==
X-Received: by 2002:a17:907:94cb:b0:a77:cacf:58b5 with SMTP id a640c23a62f3a-a7d3ffc0597mr702427266b.1.1722291034401;
        Mon, 29 Jul 2024 15:10:34 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de9fsm558188966b.68.2024.07.29.15.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 15:10:33 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,
  kernel-team@cloudflare.com,
  syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Subject: Re: [PATCH net 1/2] udp: Mark GSO packets as CHECKSUM_UNNECESSARY
 early on on output
In-Reply-To: <CAF=yD-JK+Jnjb5_r3rk+PMwV3cWHTHQHau8CQJ27aSaEQLZxQQ@mail.gmail.com>
	(Willem de Bruijn's message of "Fri, 26 Jul 2024 09:58:38 -0400")
References: <20240725-udp-gso-egress-from-tunnel-v1-0-5e5530ead524@cloudflare.com>
	<20240725-udp-gso-egress-from-tunnel-v1-1-5e5530ead524@cloudflare.com>
	<CAF=yD-LLPPg77MUhdXrHUVJj4o2+rnOC_qsHc_8tKurTsAGkYw@mail.gmail.com>
	<87h6ccl7mm.fsf@cloudflare.com>
	<CAF=yD-JK+Jnjb5_r3rk+PMwV3cWHTHQHau8CQJ27aSaEQLZxQQ@mail.gmail.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 30 Jul 2024 00:10:32 +0200
Message-ID: <87r0bbzw6f.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 09:58 AM -04, Willem de Bruijn wrote:
> On Fri, Jul 26, 2024 at 7:23=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> On Thu, Jul 25, 2024 at 10:21 AM -04, Willem de Bruijn wrote:
>> > On Thu, Jul 25, 2024 at 5:56=E2=80=AFAM Jakub Sitnicki <jakub@cloudfla=
re.com> wrote:
>> >>
>> >> In commit 10154dbded6d ("udp: Allow GSO transmit from devices with no
>> >> checksum offload") we have added a tweak in the UDP GSO code to mark =
GSO
>> >> packets being sent out as CHECKSUM_UNNECESSARY when the egress device
>> >> doesn't support checksum offload. This was done to satisfy the offload
>> >> checks in the gso stack.
>> >>
>> >> However, when sending a UDP GSO packet from a tunnel device, we will =
go
>> >> through the TX path and the GSO offload twice. Once for the tunnel de=
vice,
>> >> which acts as a passthru for GSO packets, and once for the underlying
>> >> egress device.
>> >>
>> >> Even though a tunnel device acts as a passthru for a UDP GSO packet, =
GSO
>> >> offload checks still happen on transmit from a tunnel device. So if t=
he skb
>> >> is not marked as CHECKSUM_UNNECESSARY or CHECKSUM_PARTIAL, we will ge=
t a
>> >> warning from the gso stack.
>> >
>> > I don't entirely understand. The check should not hit on pass through,
>> > where segs =3D=3D skb:
>> >
>> >         if (segs !=3D skb && unlikely(skb_needs_check(skb, tx_path) &&
>> > !IS_ERR(segs)))
>> >                 skb_warn_bad_offload(skb);
>> >
>>
>> That's something I should have explained better. Let me try to shed some
>> light on it now. We're hitting the skb_warn_bad_offload warning because
>> skb_mac_gso_segment doesn't return any segments (segs =3D=3D NULL).
>>
>> And that's because we bail out early out of __udp_gso_segment when we
>> detect that the tunnel device is capable of tx-udp-segmentation
>> (GSO_UDP_L4):
>>
>>         if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
>>                 /* Packet is from an untrusted source, reset gso_segs. */
>>                 skb_shinfo(gso_skb)->gso_segs =3D DIV_ROUND_UP(gso_skb->=
len - sizeof(*uh),
>>                                                              mss);
>>                 return NULL;
>>         }
>
> Oh I see. Thanks.
>
>> It has not occurred to me before, but in the spirit of commit
>> 8d74e9f88d65 "net: avoid skb_warn_bad_offload on IS_ERR" [1], we could
>> tighten the check to exclude cases when segs =3D=3D NULL. I'm thinking o=
f:
>>
>>         if (segs !=3D skb && !IS_ERR_OR_NULL(segs) && unlikely(skb_needs=
_check(skb, tx_path)))
>>                 skb_warn_bad_offload(skb);
>
> That looks sensible to me. And nicer than the ip_summed conversion in
> udp_send_skb.

I've audited all existing ->gso_segment callbacks. skb_mac_gso_segment()
returns no segments, that is segs =3D=3D NULL, if the callback chain ends
with either of these:

=E2=80=A6 =E2=86=92 udp[46]_ufo_fragment =E2=86=92 __udp_gso_segment =E2=86=
=92 skb_gso_ok =3D=3D true
=E2=80=A6 =E2=86=92 tcp[46]_gso_segment =E2=86=92 tcp_gso_segment =E2=86=92=
 skb_gso_ok =3D=3D true
=E2=80=A6 =E2=86=92 sctp_gso_segment =E2=86=92 skb_gso_ok =3D=3D true

IOW when the device advertises that it can handle the desired GSO kind
(skb_gso_ok() returns true).

Considering that a device offering HW GSO and no checksum offload at the
same time makes no sense, I also think that tweaking the bad offload
detection to exclude the !segs case doesn't deprive us of diagnostics.

I will change to that in v2.

