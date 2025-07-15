Return-Path: <netdev+bounces-207152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F8B06077
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC3558824B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0F2E7BB5;
	Tue, 15 Jul 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNm3tN16"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3072E3382;
	Tue, 15 Jul 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587879; cv=none; b=HCXk/D9N3ggMzooQsUam0q2osElr6H45JYLCmWnDGssgjtpfRbbCwmWBicToZqNz6AA0tK0ozZ8zf+ysNDhxu8byYqmDsv068VJhFsHZYOLup6Gih6Okx2zfGRM6yPIqLy1R/jf+Aufk7iEwKqsP2yqX2l+piC+NCbvVEJFZRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587879; c=relaxed/simple;
	bh=GDhrTQL5TCFnlFDRs1KqKPt46EOEW/acwXmtRFdmZr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhvvyzSx0IP68SmOJETNCg6CreaF9wON37bWgSleIzVGlA6U4FADFKNje3asNNa1RMHHCKy65BzV6KkZr4BOcY/Qv25SPSIe/RJQ2R77G1teYn12E54JZeI4RdJBtzS44wKuo0Ij1ncvfQ6bzX7yESjiGqtdw2iU7F2O5omGz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNm3tN16; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32ac42bb4e4so44864591fa.0;
        Tue, 15 Jul 2025 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752587875; x=1753192675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wd3vZa0hBJt2XEf+/qd/yWCD7aOef+WZtT0Xwlp5EM=;
        b=cNm3tN16nMzSp2NhYSMdPLp8v8iGOZRc/17OH8M2v3W+lcCAnTK7+hZZ0q5Q8hB44t
         5EOUbsezzX8Dv++oalbsWLCJg0GInYX746gOL/h3GkYdu+ySu10EjcIohnfdqT/MgznK
         IOXaNPfCrrdd+hBBmvuCgnpISPUdkAAW+muh0koS55GvdnsXVT+iUpFOdakdIIYl1/kF
         HhhCEy9/m7UhNU6HtjojoKPpPB8W7tO3amGp1tnI/PpKQBOg3kbILSOI41/G2jhKZJuo
         t8dM6myUsLiG1Kde/q/+xsMV+ASHnmgFm94qqCzjfprHD4yjpNfQ/VqfzKU/1BThLk2N
         jzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752587875; x=1753192675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wd3vZa0hBJt2XEf+/qd/yWCD7aOef+WZtT0Xwlp5EM=;
        b=GfTZhB/3qMtO74fl9hFybXphU9ZVBJJfSVk5V4nb2BEbWEkoxYKiTi0uuBU9UieTXl
         2JgLGjb3ItB9lH1MzSPvvDJxHQp0iQ6vKU9eHzM8TfWwBNzrTSCZ/D/faNB4lYJ/fIUW
         BpYXj1YjaKReTGGCEXdBgoUSeva90tn/5KMmOcmUSt9CPMDKqlQmY05uGS0oPW0292xJ
         BIMDuVbE6brq4l4QR+D32eHQMGugOlYOavZf4mkjzCPKKeGZpqPfuUu7gvEE1XTEoHG9
         /vlrlGCTr2W81pFtIlTRtrNRYdk7J0UaoBnHP+3LgmKvQo/sbp/dlu9ICWJzFXi997cb
         Bw9A==
X-Forwarded-Encrypted: i=1; AJvYcCUlVN6ESVGi/9BDmm0ZmrvDvRIlhOlrZsXi/Be55OXkQu7Bj6+eN2la8bpcCTP8qwFimPkVp/zfCU2hI/dWcqE=@vger.kernel.org, AJvYcCVjX6b+QlcQlnuzLlSHf0eITHCa0RCPXKjxJr3FejMAIM9m2rHT2ppO9BUox9661a87qeZjEyjuEwelYLNy@vger.kernel.org, AJvYcCWEaK7QUwVPS5JS/PptGAv0MSZ9TRjzVx7pvrhkXWUg73hX/qQf6/XdOurtBPdBwd8tZQufjDRu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb9uAWVoEzpBy2cYzdWDUgJPhhjMW/iKh/phNgTEh8366b1zoP
	4hGyR8ez8u4Tl0NTQZj9SL2yQyVacaId8K6Shi3XTflofpoUWMjAqyjqgHmIfpZ+r89X/hGkL++
	4hoz5yAOCWIZekv3zG3whkt6L4TS+KPs=
X-Gm-Gg: ASbGncsegktuFC0dvAElbfdsXemc5gEV9yfuo4CLvxaaa23ZfxDtYIyJOUl/I1824aL
	3H6DG/1VB7vwCuS2G8KW5XpgVDVA2gybvGfsG/aZnFuJ3lvi8lfGLRwvWuDGPnYyRreyoLEOtxc
	SNzD0qieZMloC0gq5qtn4BnSiC7Lgv+bHKuHETL2b1GJ/EItDyzbThjqoT0BqZjied95760DQkN
	IoTSoggunL9kY9h
X-Google-Smtp-Source: AGHT+IHrjPDlAh6yOR8TcwCHBt5GIJ+sm0Qq5QJRdLGApX1o9tf1uALm75s1vPQeoyoX4Xg8Ci6aSnoUpI9O+c49zNM=
X-Received: by 2002:a2e:a585:0:b0:32a:6a85:f294 with SMTP id
 38308e7fff4ca-3305346e497mr52038731fa.35.1752587875240; Tue, 15 Jul 2025
 06:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-iso_ts-v4-1-0f0bb162a182@amlogic.com>
 <dc9925eceb0abe78f7bafe2ed183b0f90bdb3ac5.camel@iki.fi> <CABBYNZLFnbfdXjRV0taeTNF5bsey-WFf4TFsf_ox0FNuJbEutw@mail.gmail.com>
In-Reply-To: <CABBYNZLFnbfdXjRV0taeTNF5bsey-WFf4TFsf_ox0FNuJbEutw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Jul 2025 09:57:42 -0400
X-Gm-Features: Ac12FXz9AhULqH4a8J-A_3sZmWpMk2U8gWeHUwqOazDuZWQCCySLh9mXg6eAW-Q
Message-ID: <CABBYNZL1Aicj15eYBgug4_KARK6xcd7eVKnzcE=vUK=mugUM4w@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
To: Pauli Virtanen <pav@iki.fi>
Cc: yang.li@amlogic.com, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 15, 2025 at 9:37=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pauli,
>
> On Tue, Jul 15, 2025 at 9:30=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >
> > Hi Yang,
> >
> > ma, 2025-07-07 kello 10:38 +0800, Yang Li via B4 Relay kirjoitti:
> > > From: Yang Li <yang.li@amlogic.com>
> > >
> > > User-space applications (e.g. PipeWire) depend on
> > > ISO-formatted timestamps for precise audio sync.
> > >
> > > The ISO ts is based on the controller=E2=80=99s clock domain,
> > > so hardware timestamping (hwtimestamp) must be used.
> > >
> > > Ref: Documentation/networking/timestamping.rst,
> > > section 3.1 Hardware Timestamping.
> > >
> > > Signed-off-by: Yang Li <yang.li@amlogic.com>
> > > ---
> > > Changes in v4:
> > > - Optimizing the code
> > > - Link to v3: https://lore.kernel.org/r/20250704-iso_ts-v3-1-2328bc60=
2961@amlogic.com
> > >
> > > Changes in v3:
> > > - Change to use hwtimestamp
> > > - Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c=
8068@amlogic.com
> > >
> > > Changes in v2:
> > > - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
> > > - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30d=
e6cb@amlogic.com
> > > ---
> > >  net/bluetooth/iso.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > > index fc22782cbeeb..677144bb6b94 100644
> > > --- a/net/bluetooth/iso.c
> > > +++ b/net/bluetooth/iso.c
> > > @@ -2278,6 +2278,7 @@ static void iso_disconn_cfm(struct hci_conn *hc=
on, __u8 reason)
> > >  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> > >  {
> > >       struct iso_conn *conn =3D hcon->iso_data;
> > > +     struct skb_shared_hwtstamps *hwts;
> > >       __u16 pb, ts, len;
> > >
> > >       if (!conn)
> > > @@ -2301,13 +2302,16 @@ void iso_recv(struct hci_conn *hcon, struct s=
k_buff *skb, u16 flags)
> > >               if (ts) {
> > >                       struct hci_iso_ts_data_hdr *hdr;
> > >
> > > -                     /* TODO: add timestamp to the packet? */
> > >                       hdr =3D skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_=
SIZE);
> > >                       if (!hdr) {
> > >                               BT_ERR("Frame is too short (len %d)", s=
kb->len);
> > >                               goto drop;
> > >                       }
> > >
> > > +                     /*  Record the timestamp to skb*/
> > > +                     hwts =3D skb_hwtstamps(skb);
> > > +                     hwts->hwtstamp =3D us_to_ktime(le32_to_cpu(hdr-=
>ts));
> >
> > Several lines below there is
> >
> >         conn->rx_skb =3D bt_skb_alloc(len, GFP_KERNEL);
> >         skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb-
> > >len),
> >                                                   skb->len);
> >
> > so timestamp should be copied explicitly also into conn->rx_skb,
> > otherwise it gets lost when you have ACL-fragmented ISO packets.
>
> Yep, it is not that the code is completely wrong but it is operating
> on the original skb not in the rx_skb as you said, that said is only
> the first fragment that contains the ts header so we only have to do
> it once in case that was not clear.

I might just do a fixup myself, something like the following:

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 0a951c6514af..f48fb62e640d 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2374,6 +2374,13 @@ void iso_recv(struct hci_conn *hcon, struct
sk_buff *skb, u16 flags)
                skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->l=
en),
                                          skb->len);
                conn->rx_len =3D len - skb->len;
+
+               /* Copy timestamp from skb to rx_skb if present */
+               if (ts) {
+                       hwts =3D skb_hwtstamps(conn->rx_skb);
+                       hwts->hwtstamp =3D skb_hwtstamps(skb)->hwtstamp;
+               }
+
                break;

        case ISO_CONT:


> > It could also be useful to write a simple test case that extracts the
> > timestamp from CMSG, see for example how it was done for BT_PKT_SEQNUM:
> > https://lore.kernel.org/linux-bluetooth/b98b7691e4ba06550bb8f275cad0635=
bc9e4e8d2.1752511478.git.pav@iki.fi/
> > bthost_send_iso() can take ts=3Dtrue and some timestamp value.
> >
> > > +
> > >                       len =3D __le16_to_cpu(hdr->slen);
> > >               } else {
> > >                       struct hci_iso_data_hdr *hdr;
> > >
> > > ---
> > > base-commit: b8db3a9d4daeb7ff6a56c605ad6eca24e4da78ed
> > > change-id: 20250421-iso_ts-c82a300ae784
> > >
> > > Best regards,
> >
> > --
> > Pauli Virtanen
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

