Return-Path: <netdev+bounces-207131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD418B05E29
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883801C27F47
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C052E718B;
	Tue, 15 Jul 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMMN9a1x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4273C2D372D;
	Tue, 15 Jul 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586665; cv=none; b=dIJaN6zBbmoCcVHr615A8hP3xlSGVYaPuaJdZdLruNPRluqJQF3259LaUYKHxiP05RFMMwZx0jrXXrDTHQlgjc+sbNjvRpJS7XjwBhDkKghD2J2z/9ApuBxyNl9CWwxjoaDXhI7mgBarKKlebNwUimHqppThcgCgaHXNT8THzbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586665; c=relaxed/simple;
	bh=UZOkLJq1yQRo2joDviEQwZX005oLg/tuPJiZ4DBAWek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBRIQM3FLquArZUHn4dGd/zYJns4Z0kygailtjsSUcjz2RUFRBNCKjQRAsv8rQBCrPHUpmwnAIP/Ms3v5Yl+keL1oNWuHQqOWBzdIQvrS2IXUZt2uPHntbfOkmYRMyz4/BxV5rJ8e5LLWTF/rO67Nlod1qTkq3cPRnjdac7ZZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMMN9a1x; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32cd499007aso40345951fa.0;
        Tue, 15 Jul 2025 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752586661; x=1753191461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNrscCBPbLnulVmw8wNgBHHyDnL0sYlWPeSwnjiE1fs=;
        b=UMMN9a1xAt1xGFg+hIQy3KWiLi1vpWReL1mWlGI3C8sV0sW+fR8fO4eBYAVgr0VqEC
         nCqGXQWfSiDYWw9R4pdflNc7sqgamIC4+MDJ8KeZcnvAjhEhi90EcBm3jBUvqBn/21pI
         kXFkfw6rgVLywi69vCC29+rTiWtOjwOMChx8xdBWE0LS3v5TM3B+ULiIhhlX76A8zbJt
         4J6vo1FzzjwMg8DKU4ehwiiwnmg5yfgbHSyYsADF83/5Fk806ct3Gr54+Njyn1noY/j9
         yrGvqnMg06oHg2I09oq0VH58A37iHxPZIdq9aRP9L4O0OUj7U8ENpOtLI4fsy5UBEuUf
         uyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752586661; x=1753191461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNrscCBPbLnulVmw8wNgBHHyDnL0sYlWPeSwnjiE1fs=;
        b=v1WmQZbLzzKEgDtbT72uCU3tCy3B4kofn6tp6YMmNtinxF2P38GDi+xrs8fCxr/W+2
         M1szqez39Zak407NGiwM1Zswl8iw0NbgUnBBWrManeHIMIWi7qkn6NuJOS8n4tF2FjoH
         ESCzIY8mkwSy7Z1kjbDXIV2r/j5Tgr7UVMr1D6YXQzeLa/clRBQj22hJFC6FjCJL+tQL
         smtlAt80stJDzUvWb+o/fg1ybMmXk33l54zW3QfAZQiJIC8n6USKHQFMqhu+hkrJvBmC
         /jkKaGyL4smvOB7tTDpQDHaYYgITKDmPHziPXq+ZnmcqSpYzQWP3lb2oJgNU08PRwq0p
         6CGw==
X-Forwarded-Encrypted: i=1; AJvYcCU+7JnzK5cr7+XYbcgkyTdFcB6Jq84K1mPAE/OqqpoPXpzb27DwuNzv+srl6bdESBkauShQs6y6@vger.kernel.org, AJvYcCVv4XCyW5AKWwNJy0f1pDJ6emmef64ycSPimia1tbTHrBgw3RQIfye/YjkZK3av/Nb0/l3cuu4HK9qwDkzn@vger.kernel.org, AJvYcCXC7uxU9TY707VbJO+Q07ktRBflE9iQ7iXNi6SJjT0YPjGQ/yU9aels0pURGO1mV6a0Xdpul3E4jj7Vem4GxrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8wdDdHtLRZh3h99mx0EwyeqkRVMZtOj9hnicwrHBd82fwyVlF
	Euu2QwgShq7ZnC52xBd4jqgNaoygGDA5nb0qjXEc+pAtGMep1KJ8Zg1JURdDcc+yb+sAbDg3b4l
	kxHENKP6hc+0W6kIV7diFWyeofl631Sw=
X-Gm-Gg: ASbGncuU6STOmrhifLXneTojC1xBuPuZ5txpz13/cMhzFu772I1hH+zNlGOVI8IKMdW
	puFyvxyHjv6fdKYJoBep+dxca8JozFml+vP4Gz1LKqrBoFJoQLYqpuTNxh0cOoOdONX1DKa/GiL
	nHZesxdgUSv0rWINiTn+7htuq322fAW4ioZ+tr4FucsUwo/kcLF5omiFDOxPpTHuDPrI13+5aOy
	rgyJA==
X-Google-Smtp-Source: AGHT+IHmsGoXd7Dae9wkOiRS1DoObc9wHLvD4xc7v2A7uvkRowpUm8thuvki77DBD41ammVrV6P0k/llYbUfcilRlSY=
X-Received: by 2002:a2e:bc18:0:b0:32b:533a:f4d6 with SMTP id
 38308e7fff4ca-33084ba8ce4mr8628211fa.34.1752586660925; Tue, 15 Jul 2025
 06:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-iso_ts-v4-1-0f0bb162a182@amlogic.com> <dc9925eceb0abe78f7bafe2ed183b0f90bdb3ac5.camel@iki.fi>
In-Reply-To: <dc9925eceb0abe78f7bafe2ed183b0f90bdb3ac5.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Jul 2025 09:37:28 -0400
X-Gm-Features: Ac12FXwwTGnWfGjAAFG5KTyUcf5d9lL8tUe6GdE0JoCkHFlYfE5ZmLnseeivXfs
Message-ID: <CABBYNZLFnbfdXjRV0taeTNF5bsey-WFf4TFsf_ox0FNuJbEutw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
To: Pauli Virtanen <pav@iki.fi>
Cc: yang.li@amlogic.com, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Jul 15, 2025 at 9:30=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Yang,
>
> ma, 2025-07-07 kello 10:38 +0800, Yang Li via B4 Relay kirjoitti:
> > From: Yang Li <yang.li@amlogic.com>
> >
> > User-space applications (e.g. PipeWire) depend on
> > ISO-formatted timestamps for precise audio sync.
> >
> > The ISO ts is based on the controller=E2=80=99s clock domain,
> > so hardware timestamping (hwtimestamp) must be used.
> >
> > Ref: Documentation/networking/timestamping.rst,
> > section 3.1 Hardware Timestamping.
> >
> > Signed-off-by: Yang Li <yang.li@amlogic.com>
> > ---
> > Changes in v4:
> > - Optimizing the code
> > - Link to v3: https://lore.kernel.org/r/20250704-iso_ts-v3-1-2328bc6029=
61@amlogic.com
> >
> > Changes in v3:
> > - Change to use hwtimestamp
> > - Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c80=
68@amlogic.com
> >
> > Changes in v2:
> > - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
> > - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6=
cb@amlogic.com
> > ---
> >  net/bluetooth/iso.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index fc22782cbeeb..677144bb6b94 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -2278,6 +2278,7 @@ static void iso_disconn_cfm(struct hci_conn *hcon=
, __u8 reason)
> >  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> >  {
> >       struct iso_conn *conn =3D hcon->iso_data;
> > +     struct skb_shared_hwtstamps *hwts;
> >       __u16 pb, ts, len;
> >
> >       if (!conn)
> > @@ -2301,13 +2302,16 @@ void iso_recv(struct hci_conn *hcon, struct sk_=
buff *skb, u16 flags)
> >               if (ts) {
> >                       struct hci_iso_ts_data_hdr *hdr;
> >
> > -                     /* TODO: add timestamp to the packet? */
> >                       hdr =3D skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SI=
ZE);
> >                       if (!hdr) {
> >                               BT_ERR("Frame is too short (len %d)", skb=
->len);
> >                               goto drop;
> >                       }
> >
> > +                     /*  Record the timestamp to skb*/
> > +                     hwts =3D skb_hwtstamps(skb);
> > +                     hwts->hwtstamp =3D us_to_ktime(le32_to_cpu(hdr->t=
s));
>
> Several lines below there is
>
>         conn->rx_skb =3D bt_skb_alloc(len, GFP_KERNEL);
>         skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb-
> >len),
>                                                   skb->len);
>
> so timestamp should be copied explicitly also into conn->rx_skb,
> otherwise it gets lost when you have ACL-fragmented ISO packets.

Yep, it is not that the code is completely wrong but it is operating
on the original skb not in the rx_skb as you said, that said is only
the first fragment that contains the ts header so we only have to do
it once in case that was not clear.

> It could also be useful to write a simple test case that extracts the
> timestamp from CMSG, see for example how it was done for BT_PKT_SEQNUM:
> https://lore.kernel.org/linux-bluetooth/b98b7691e4ba06550bb8f275cad0635bc=
9e4e8d2.1752511478.git.pav@iki.fi/
> bthost_send_iso() can take ts=3Dtrue and some timestamp value.
>
> > +
> >                       len =3D __le16_to_cpu(hdr->slen);
> >               } else {
> >                       struct hci_iso_data_hdr *hdr;
> >
> > ---
> > base-commit: b8db3a9d4daeb7ff6a56c605ad6eca24e4da78ed
> > change-id: 20250421-iso_ts-c82a300ae784
> >
> > Best regards,
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz

