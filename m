Return-Path: <netdev+bounces-233863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E8C19820
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496E342800B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0D32FC88B;
	Wed, 29 Oct 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CX8MYJP7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D12E172D
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731512; cv=none; b=aGxtiHXrrz/fb+LV5octYPz2ghxoNr74qMVsvKjHxlux2WaUDcDt4RzUP7LQzt4YjGGCOVFtpCuT8JKAZoXBuzWgATnT7DQWZygvK5fEsFsMR2t48qqZStp4LvbBf9vzMvZ6zgiRo7UgH17c3hdnU2caphQJUPxVY21WhbXkpks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731512; c=relaxed/simple;
	bh=3ctYAHi6DJclcyE7coYuy7pWxtwy4LclfvTw5P2GL2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I70xUh9UwE8FDvPUwX9EwXgRk2EsNTrFu13mMt4b4UnpiSIyuVk3d1cb0Xm22v5Tl5sU2q3KP8WWG257RqCUhbS0zziqN1Cg6SP+cxIGi/VJwc/iciXopLbTkGo/qPl7ZmQrIWdphTxnsQjB+VwG+saeOP5WIz5VOLBWbRKtQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CX8MYJP7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761731509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSvQNycfQkKBJnPHMBo2XhC9DfYUYCzMFCZMQnQ2D1g=;
	b=CX8MYJP73goBv12Okwu0Ytc0L4sEIKbA0iBDyPGBfoRl0ad8QKOW/naQjhBTAt5cp3SJuX
	qvRNJFCGWqEHWR3GnaIBn3FKc1QfAKWbm598ujBTGGudznwPed/UeMESfXMEGuuvOD8WRm
	Bpw+nuSYY1vy0cfqIcQB52emThZtIwA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-INkdn193PjqRXNuGiQEFzQ-1; Wed, 29 Oct 2025 05:51:47 -0400
X-MC-Unique: INkdn193PjqRXNuGiQEFzQ-1
X-Mimecast-MFC-AGG-ID: INkdn193PjqRXNuGiQEFzQ_1761731507
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-785c4b8a18bso79690677b3.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 02:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731507; x=1762336307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSvQNycfQkKBJnPHMBo2XhC9DfYUYCzMFCZMQnQ2D1g=;
        b=D9unJ3ZXoy+ZwboIDXMr3uWDNzMiNdt6vNeJFOQVG5woPFLC/sV7+K51Sedgmb1xhJ
         e0G1LRUJ51Ixdneg1xbnBvlBKvsZYBXKX4bNYTJcIGwuunirt2V3FZ5rRS98TaeF/fKO
         w/tGs15F+jGegVBttLl+6zIxnxFPq3ToT3EM8jjXjnG67am76WlEKbNPh+YFqH6NvfgI
         MThVgJHz0hqbQT0jAt7kWHFHj2ALCVgweahYFp0BLyHNqQYX6YzFNjh0l0uHTZzx01jU
         HUqRfO7T+OZsjYz2zv/qiGIAQi2E0piOm2dYfYZA2Y8rU2D4dD2urx3L7uj3oAdNydeR
         y5bA==
X-Gm-Message-State: AOJu0YwJX6MBDyZBC2XvNlHwH+vQd2HeZf0xDgCeCO8TirvX3ZbQV+0e
	2Vx5ZgjBXBDy7wDrQhZ6STuJ+IXD5ajfYIEtEufbyEB1BX6deY8U0QsRqDHAb5kctBd8ex7qCxr
	8UEQbC+gxCUxfF7Mn3G37Q4gfsskUjHURYTWuAXP8ChkAqnBBUi4to7YkvQIqPtzwj2dHKxsUpI
	uv2KqDEwDIaNJQG/v5Yx/IFHdhxVQNbYUX
X-Gm-Gg: ASbGncug3XXsIBgw5wkbrfSZubkwN9NwfKS7e58J4mv+WQPZ1movh8NOhX/za6ZWaAF
	m9BlTWSh9VSjcjB05a2RloQgpZ2WbJhm8rwEbEirTK8W1wAHtZwLYgpb9qmw3QxAnpgjZpF159F
	4x6XTokpkArRDx3aUA7ob7kf5khrGEEjfOkmg26xWhC7kUBVtzlpbm2Q==
X-Received: by 2002:a05:690c:fd6:b0:781:f505:ed4e with SMTP id 00721157ae682-78628e4f46amr21479587b3.15.1761731506773;
        Wed, 29 Oct 2025 02:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEzWJM9jea1p2fAq8glt00SwBhMSy2nwCLKOKfOguoWCKNhGzVQbjIFRn8wy4aWQMHyerELZoelpivUDfKJNA=
X-Received: by 2002:a05:690c:fd6:b0:781:f505:ed4e with SMTP id
 00721157ae682-78628e4f46amr21479437b3.15.1761731506436; Wed, 29 Oct 2025
 02:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com> <20251029030913.20423-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20251029030913.20423-5-xuanzhuo@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 29 Oct 2025 10:51:34 +0100
X-Gm-Features: AWmQ_blOtBS1xkDDvOPVhShD5k6_MMXBlNHRXnEXktvcG2KGbdWIECDRKNwCopg
Message-ID: <CAF6piCLkv6kFqoq7OQfJ=Su9AVHSQ9J7DzaumOSf5xuf9w-kyA@mail.gmail.com>
Subject: Re: [PATCH net v4 4/4] virtio-net: correct hdr_len handling for
 tunnel gso
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Heng Qi <hengqi@linux.alibaba.com>, Willem de Bruijn <willemb@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
Content-Type: multipart/mixed; boundary="000000000000a1ea1506424914b7"

--000000000000a1ea1506424914b7
Content-Type: multipart/alternative; boundary="000000000000a1ea1406424914b5"

--000000000000a1ea1406424914b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:09=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om>
wrote:
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 6ef0b737d548..46b04816d333 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -207,6 +207,14 @@ static inline int virtio_net_hdr_to_skb(struct
sk_buff *skb,
>         return __virtio_net_hdr_to_skb(skb, hdr, little_endian,
hdr->gso_type);
>  }
>
> +static inline int virtio_net_tcp_hdrlen(const struct sk_buff *skb, bool
tnl)
> +{
> +       if (tnl)
> +               return inner_tcp_hdrlen(skb);
> +
> +       return tcp_hdrlen(skb);
> +}
> +
>  static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>                                           struct virtio_net_hdr *hdr,
>                                           bool little_endian,
> @@ -217,25 +225,33 @@ static inline int virtio_net_hdr_from_skb(const
struct sk_buff *skb,
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> +               bool tnl =3D false;
>                 u16 hdr_len =3D 0;
>
> -               /* In certain code paths (such as the af_packet.c receive
path),
> -                * this function may be called without a transport header=
.
> -                * In this case, we do not need to set the hdr_len.
> -                */
> -               if (skb_transport_header_was_set(skb))
> -                       hdr_len =3D skb_transport_offset(skb);
> +               if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +                                      SKB_GSO_UDP_TUNNEL_CSUM)) {
> +                       tnl =3D true;
> +                       hdr_len =3D skb_inner_transport_offset(skb);
> +
> +               } else {
> +                       /* In certain code paths (such as the af_packet.c
receive path),
> +                        * this function may be called without a
transport header.
> +                        * In this case, we do not need to set the
hdr_len.
> +                        */
> +                       if (skb_transport_header_was_set(skb))
> +                               hdr_len =3D skb_transport_offset(skb);
> +               }
>
>                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
>                                                   sinfo->gso_size);
>                 if (sinfo->gso_type & SKB_GSO_TCPV4) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
>                         if (hdr_len)
> -                               hdr_len +=3D tcp_hdrlen(skb);
> +                               hdr_len +=3D virtio_net_tcp_hdrlen(skb,
tnl);
>                 } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
>                         if (hdr_len)
> -                               hdr_len +=3D tcp_hdrlen(skb);
> +                               hdr_len +=3D virtio_net_tcp_hdrlen(skb,
tnl);
>                 } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
>                         if (hdr_len)

I think it's a bit of a pity that the non-UDP tunnel path had to do all the
additional conditionals.

The (completely untested) alternative attached here would reduce them a bit=
.

Still I'm a bit concerned by all the 'if (hdr_len)' unconditionally
sprinkled around by the previous patch. The virtio spec says that hdr_len
is valid if and only if the VIRTIO_NET_F_GUEST_HDRLEN feature has been
negotiated.

What about moving hdr->hdr_len initialization in a separate helper and
calling it only when the relevant feature has been negotiated?

Thanks,

Paolo

--000000000000a1ea1406424914b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+T24gV2VkLCBPY3QgMjksIDIwMjUgYXQgNDow
OeKAr0FNIFh1YW4gWmh1byAmbHQ7PGEgaHJlZj0ibWFpbHRvOnh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tIiB0YXJnZXQ9Il9ibGFuayI+eHVhbnpodW9AbGludXguYWxpYmFiYS5jb208L2E+Jmd0
OyB3cm90ZTo8YnI+Jmd0OyBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0Lmgg
Yi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQuaDxicj4mZ3Q7IGluZGV4IDZlZjBiNzM3ZDU0OC4u
NDZiMDQ4MTZkMzMzIDEwMDY0NDxicj4mZ3Q7IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX25l
dC5oPGJyPiZndDsgKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0Lmg8YnI+Jmd0OyBAQCAt
MjA3LDYgKzIwNywxNCBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0aW9fbmV0X2hkcl90b19za2Io
c3RydWN0IHNrX2J1ZmYgKnNrYiw8YnI+Jmd0OyDCoCDCoCDCoCDCoCByZXR1cm4gX192aXJ0aW9f
bmV0X2hkcl90b19za2Ioc2tiLCBoZHIsIGxpdHRsZV9lbmRpYW4sIGhkci0mZ3Q7Z3NvX3R5cGUp
Ozxicj4mZ3Q7IMKgfTxicj4mZ3Q7PGJyPiZndDsgK3N0YXRpYyBpbmxpbmUgaW50IHZpcnRpb19u
ZXRfdGNwX2hkcmxlbihjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBib29sIHRubCk8YnI+Jmd0
OyArezxicj4mZ3Q7ICsgwqAgwqAgwqAgaWYgKHRubCk8YnI+Jmd0OyArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHJldHVybiBpbm5lcl90Y3BfaGRybGVuKHNrYik7PGJyPiZndDsgKzxicj4mZ3Q7ICsg
wqAgwqAgwqAgcmV0dXJuIHRjcF9oZHJsZW4oc2tiKTs8YnI+Jmd0OyArfTxicj4mZ3Q7ICs8YnI+
Jmd0OyDCoHN0YXRpYyBpbmxpbmUgaW50IHZpcnRpb19uZXRfaGRyX2Zyb21fc2tiKGNvbnN0IHN0
cnVjdCBza19idWZmICpza2IsPGJyPiZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IHZpcnRpb19uZXRfaGRyICpo
ZHIsPGJyPiZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgYm9vbCBsaXR0bGVfZW5kaWFuLDxicj4mZ3Q7IEBAIC0yMTcsMjUg
KzIyNSwzMyBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0aW9fbmV0X2hkcl9mcm9tX3NrYihjb25z
dCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLDxicj4mZ3Q7PGJyPiZndDsgwqAgwqAgwqAgwqAgaWYgKHNr
Yl9pc19nc28oc2tiKSkgezxicj4mZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBz
a2Jfc2hhcmVkX2luZm8gKnNpbmZvID0gc2tiX3NoaW5mbyhza2IpOzxicj4mZ3Q7ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgYm9vbCB0bmwgPSBmYWxzZTs8YnI+Jmd0OyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB1MTYgaGRyX2xlbiA9IDA7PGJyPiZndDs8YnI+Jmd0OyAtIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIC8qIEluIGNlcnRhaW4gY29kZSBwYXRocyAoc3VjaCBhcyB0aGUgYWZfcGFja2V0LmMg
cmVjZWl2ZSBwYXRoKSw8YnI+Jmd0OyAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiB0aGlzIGZ1
bmN0aW9uIG1heSBiZSBjYWxsZWQgd2l0aG91dCBhIHRyYW5zcG9ydCBoZWFkZXIuPGJyPiZndDsg
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCogSW4gdGhpcyBjYXNlLCB3ZSBkbyBub3QgbmVlZCB0
byBzZXQgdGhlIGhkcl9sZW4uPGJyPiZndDsgLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCovPGJy
PiZndDsgLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoc2tiX3RyYW5zcG9ydF9oZWFkZXJfd2Fz
X3NldChza2IpKTxicj4mZ3Q7IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGRy
X2xlbiA9IHNrYl90cmFuc3BvcnRfb2Zmc2V0KHNrYik7PGJyPiZndDsgKyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBpZiAoc2luZm8tJmd0O2dzb190eXBlICZhbXA7IChTS0JfR1NPX1VEUF9UVU5ORUwg
fDxicj4mZ3Q7ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBTS0JfR1NPX1VEUF9UVU5ORUxfQ1NVTSkpIHs8YnI+Jmd0OyArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRubCA9IHRydWU7PGJyPiZndDsgKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBoZHJfbGVuID0gc2tiX2lubmVyX3RyYW5zcG9ydF9vZmZz
ZXQoc2tiKTs8YnI+Jmd0OyArPGJyPiZndDsgKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9IGVsc2Ug
ezxicj4mZ3Q7ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogSW4gY2VydGFp
biBjb2RlIHBhdGhzIChzdWNoIGFzIHRoZSBhZl9wYWNrZXQuYyByZWNlaXZlIHBhdGgpLDxicj4m
Z3Q7ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIHRoaXMgZnVuY3Rpb24g
bWF5IGJlIGNhbGxlZCB3aXRob3V0IGEgdHJhbnNwb3J0IGhlYWRlci48YnI+Jmd0OyArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiBJbiB0aGlzIGNhc2UsIHdlIGRvIG5vdCBu
ZWVkIHRvIHNldCB0aGUgaGRyX2xlbi48YnI+Jmd0OyArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgKi88YnI+Jmd0OyArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGlmIChza2JfdHJhbnNwb3J0X2hlYWRlcl93YXNfc2V0KHNrYikpPGJyPiZndDsgKyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBoZHJfbGVuID0gc2tiX3RyYW5z
cG9ydF9vZmZzZXQoc2tiKTs8YnI+Jmd0OyArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+Jmd0
Ozxicj4mZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGhkci0mZ3Q7Z3NvX3NpemUgPSBfX2Nw
dV90b192aXJ0aW8xNihsaXR0bGVfZW5kaWFuLDxicj4mZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNp
bmZvLSZndDtnc29fc2l6ZSk7PGJyPiZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHNp
bmZvLSZndDtnc29fdHlwZSAmYW1wOyBTS0JfR1NPX1RDUFY0KSB7PGJyPiZndDsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGRyLSZndDtnc29fdHlwZSA9IFZJUlRJT19ORVRf
SERSX0dTT19UQ1BWNDs8YnI+Jmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBpZiAoaGRyX2xlbik8YnI+Jmd0OyAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGhkcl9sZW4gKz0gdGNwX2hkcmxlbihza2IpOzxicj4mZ3Q7ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGRyX2xlbiArPSB2aXJ0aW9f
bmV0X3RjcF9oZHJsZW4oc2tiLCB0bmwpOzxicj4mZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IH0gZWxzZSBpZiAoc2luZm8tJmd0O2dzb190eXBlICZhbXA7IFNLQl9HU09fVENQVjYpIHs8YnI+
Jmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBoZHItJmd0O2dzb190eXBl
ID0gVklSVElPX05FVF9IRFJfR1NPX1RDUFY2Ozxicj4mZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGlmIChoZHJfbGVuKTxicj4mZ3Q7IC0gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGRyX2xlbiArPSB0Y3BfaGRybGVuKHNrYik7PGJy
PiZndDsgKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBoZHJf
bGVuICs9IHZpcnRpb19uZXRfdGNwX2hkcmxlbihza2IsIHRubCk7PGJyPiZndDsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfSBlbHNlIGlmIChzaW5mby0mZ3Q7Z3NvX3R5cGUgJmFtcDsgU0tCX0dT
T19VRFBfTDQpIHs8YnI+Jmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBo
ZHItJmd0O2dzb190eXBlID0gVklSVElPX05FVF9IRFJfR1NPX1VEUF9MNDs8YnI+PGRpdj4mZ3Q7
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChoZHJfbGVuKTwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+SSB0aGluayBpdCYjMzk7cyBhIGJpdCBvZiBhIHBpdHkgdGhhdCB0
aGUgbm9uLVVEUCB0dW5uZWwgcGF0aCBoYWQgdG8gZG8gYWxsIHRoZSBhZGRpdGlvbmFsIGNvbmRp
dGlvbmFscy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSAoY29tcGxldGVseSB1bnRlc3Rl
ZCkgYWx0ZXJuYXRpdmUgYXR0YWNoZWQgaGVyZSB3b3VsZCByZWR1Y2UgdGhlbSBhIGJpdC48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PlN0aWxsIEkmIzM5O20gYSBiaXQgY29uY2VybmVkIGJ5IGFs
bCB0aGUgJiMzOTtpZsKgKGhkcl9sZW4pJiMzOTsgdW5jb25kaXRpb25hbGx5IHNwcmlua2xlZCBh
cm91bmQgYnkgdGhlIHByZXZpb3VzIHBhdGNoLiBUaGUgdmlydGlvIHNwZWMgc2F5cyB0aGF0IGhk
cl9sZW4gaXMgdmFsaWQgaWYgYW5kIG9ubHkgaWYgdGhlIFZJUlRJT19ORVRfRl9HVUVTVF9IRFJM
RU4gZmVhdHVyZSBoYXMgYmVlbiBuZWdvdGlhdGVkLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
V2hhdCBhYm91dCBtb3ZpbmcgaGRyLSZndDtoZHJfbGVuIGluaXRpYWxpemF0aW9uIGluIGEgc2Vw
YXJhdGUgaGVscGVyIGFuZCBjYWxsaW5nIGl0IG9ubHkgd2hlbiB0aGUgcmVsZXZhbnQgZmVhdHVy
ZSBoYXMgYmVlbiBuZWdvdGlhdGVkPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzLDwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UGFvbG88L2Rpdj48L2Rpdj4NCjwvZGl2Pg0K
--000000000000a1ea1406424914b5--
--000000000000a1ea1506424914b7
Content-Type: application/octet-stream; name=diffs
Content-Disposition: attachment; filename=diffs
Content-Transfer-Encoding: base64
Content-ID: <f_mhbst4ow0>
X-Attachment-Id: f_mhbst4ow0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX25ldC5oIGIvaW5jbHVkZS9saW51eC92
aXJ0aW9fbmV0LmgKaW5kZXggNmVmMGI3MzdkNTQ4Li42NzI0OTJiOTQ1OGYgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvbGludXgvdmlydGlvX25ldC5oCisrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX25l
dC5oCkBAIC00MjAsMTAgKzQyMCwxMyBAQCB2aXJ0aW9fbmV0X2hkcl90bmxfZnJvbV9za2IoY29u
c3Qgc3RydWN0IHNrX2J1ZmYgKnNrYiwKICAgICAgICAgdmhkci0+aGFzaF9oZHIuaGFzaF9yZXBv
cnQgPSAwOwogICAgICAgICB2aGRyLT5oYXNoX2hkci5wYWRkaW5nID0gMDsKIAotCS8qIExldCB0
aGUgYmFzaWMgcGFyc2luZyBkZWFsIHdpdGggcGxhaW4gR1NPIGZlYXR1cmVzLiAqLwotCXNrYl9z
aGluZm8oc2tiKS0+Z3NvX3R5cGUgJj0gfnRubF9nc29fdHlwZTsKKwkvKiBUaGUgYmFzaWMgcGFy
c2luZyB3aWxsIGxvb2sgb25seSBmb3IgdGhlIHRyYW5zcG9ydCBoZWFkZXIsCisJICogbGV0IGl0
IHJlZmVyIHRvIHRoZSByZWxldmFudCBvbmUKKwkgKi8KKwlvdXRlcl90aCA9IHNrYi0+dHJhbnNw
b3J0X2hlYWRlciAtIHNrYl9oZWFkcm9vbShza2IpOworCXNrYi0+dHJhbnNwb3J0X2hlYWRlciA9
IHNrYi0+aW5uZXJfdHJhbnNwb3J0X2hlYWRlcjsKIAlyZXQgPSB2aXJ0aW9fbmV0X2hkcl9mcm9t
X3NrYihza2IsIGhkciwgdHJ1ZSwgZmFsc2UsIHZsYW5faGxlbik7Ci0Jc2tiX3NoaW5mbyhza2Ip
LT5nc29fdHlwZSB8PSB0bmxfZ3NvX3R5cGU7CisJc2tiLT50cmFuc3BvcnRfaGVhZGVyID0gb3V0
ZXJfdGggKyBza2JfaGVhZHJvb20oc2tiKTsKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwogCg==
--000000000000a1ea1506424914b7--


