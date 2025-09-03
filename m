Return-Path: <netdev+bounces-219660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3984AB428A2
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C353AED62
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADB73629A1;
	Wed,  3 Sep 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="AQ+qKdY3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f64.google.com (mail-lf1-f64.google.com [209.85.167.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A195736298C
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923919; cv=none; b=L83LvdCAhXpJ0zZmcv1O4muxgRK4ZQ2W7NyJN/1UVCe4ojB9vDc2ECk+FimOFuEp1cCU85mNnCR5bZ75K/qCOkK8qdwWx9P872uLhspCyPp5wws1LJcEsmYvQgVabU1u0gppGwEvbwRuXSZw2Nerxjo4clxeCneer+M+DbyJE2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923919; c=relaxed/simple;
	bh=SWhLThIrZT3pSCjdhE2LXGJyrQB57TUCxodpgoCAE/Q=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EXj/vWH4ZoB//14aXQyjNwxLykzD5oXabceVaDODNVCvQZxvKxI6BmOlrKKETkZr9zjrsNdg1qRWCJOFvlHLdl3IFUnJIotYK2w5NO4D+0YjFwZWmxLktZ3El94NKyrg3RFVifnbiH+pmGJ7qa5++fGSXpJ1iaShJyGupJmfbK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=AQ+qKdY3; arc=none smtp.client-ip=209.85.167.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-lf1-f64.google.com with SMTP id 2adb3069b0e04-55f742d8515so64308e87.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756923916; x=1757528716; darn=vger.kernel.org;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1O3wFo2JxVeR5qGrGVejvSfKp2Bs/VjkYbTcah9HQE=;
        b=AQ+qKdY32GrN87OtS6u8LuKqDix6XAOBNTY38G0NH+j2+XYvaIIZOqDDNZfaqwHcQR
         wZyWDtEdpehllrh1AOWIHhQpJjtxsSDkjc6LtqCdZ0yQpoO95ZG7fKX/Z8t59lPB5jRz
         U61CARD1loOg5JAFw8Jtr0auxDtDuu/w0wKRCv67oUIaNHd9tygqTKQh8LKgOL2rdPDc
         kCRaOVMj4VAPNbHcalNSQyknUDhuLQuKSiX6+PDIaJEja1cyqJCVD0bAj7XVigGG+J6Z
         6imDEvGX5sS8YjO8LVxmoIKY6hB18apJf/CanfQGGhXrVYJaTz3XI9kW4WS/1q66eRTh
         Xw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756923916; x=1757528716;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1O3wFo2JxVeR5qGrGVejvSfKp2Bs/VjkYbTcah9HQE=;
        b=N4CeGLE3mCEeFsU6ZtCsjg+6ZzIFvA8fyTWf+yrtrAMJfSenVAX296epz7lgqCaMTJ
         fCmTal2XjX4xBhY1ws234m4lS1vTwnjWQSuaTpfClVpJygBXpkrvamZA7cunprGnJ3XQ
         nsMSxl1TAB4jiPCIn8nIZCOhe2IFadq4EEPJmmho3d9ja/e5MIs6O8axkHf01d2YEPG9
         olQwohrlc/T4ReFq40BWOmPaj9M8MRoqj78HC27ld4De8c/+zbkgfoZvAIt3X8uxdZs9
         BdCaOEQjs6VKJ/RWz3NQOp4sfms3Gne9eBAv/kItuxjc60Nht3tDxYILqSrKOyQZcUHJ
         pGsA==
X-Forwarded-Encrypted: i=1; AJvYcCW8w44DjsjUGctpd39184PKVb7q4/C+dgYM4up1iYQU/OMwScapQsGz6NlW1IOGWXQUWYMbejc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10+d/TYv7vplr8RhsdM5JDMYBRfiU4/KlAPi7AemN42H8OuS7
	tGQ4vfA6tszyYglxu4+hFQa+2Mv6WLMquy8Bfl2SDphrpX0VbcLqy3s9PF2p4JOPUTIHWjs5s3o
	0nxE7NyKBGFPfYA==
X-Google-Smtp-Source: AGHT+IFdfDFj5skXYoLpoDjCjDBkGnqN+S24BriqULZw5zYqlWXgjTzrDqq0uyi330V+/F4ds+4WpNOFBA==
X-Received: by 2002:a05:6512:1093:b0:55f:4dbe:1c72 with SMTP id 2adb3069b0e04-55f7099d3c0mr4931007e87.53.1756923915544;
        Wed, 03 Sep 2025 11:25:15 -0700 (PDT)
X-Google-Already-Archived: Yes
X-Google-Already-Archived-Group-Id: 38d67f2e3d
X-Google-Doc-Id: 18126be95b8f
X-Google-Thread-Id: 7e81a9c545d8380
X-Google-Message-Url: http://groups.google.com/a/aisle.com/group/disclosure/msg/18126be95b8f
X-Google-Thread-Url: http://groups.google.com/a/aisle.com/group/disclosure/t/7e81a9c545d8380
X-Google-Web-Client: true
Date: Wed, 3 Sep 2025 11:25:10 -0700 (PDT)
From: Disclosure <disclosure@aisle.com>
To: Disclosure <disclosure@aisle.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"security@kernel.org" <security@kernel.org>,
	Stanislav Fort <disclosure@aisle.com>,
	Stanislav Fort <stanislav.fort@aisle.com>
Message-Id: <c5dc6b87-2b02-40a5-9bee-ca6059525d0dn@aisle.com>
In-Reply-To: <CANn89i+xUZ5R1jV8O8u6WpX1RDtgtdcfUHVGDrVZFuO7fuXrbg@mail.gmail.com>
References: <20250902112652.26293-1-disclosure@aisle.com>
 <CANn89i+xUZ5R1jV8O8u6WpX1RDtgtdcfUHVGDrVZFuO7fuXrbg@mail.gmail.com>
Subject: Re: [PATCH net v2] netrom: fix out-of-bounds read in nr_rx_frame()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_47698_1216814787.1756923910572"

------=_Part_47698_1216814787.1756923910572
Content-Type: multipart/alternative; 
	boundary="----=_Part_47699_1111796520.1756923910572"

------=_Part_47699_1111796520.1756923910572
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Thanks a lot for the suggestions -- that's way better. I=E2=80=99ve sent v3=
, which=20
follows your plan to linearize and add per-context length=20
checks: https://lore.kernel.org/all/20250903181915.6359-1-disclosure@aisle.=
com/T/#u

- Use skb_linearize() at the start of nr_rx_frame().
- Require skb->len >=3D NR_NETWORK_LEN + NR_TRANSPORT_LEN before reading ba=
se=20
fields (offsets 0-19).
- Existing-socket path: for NR_CONNACK, require one extra byte for the=20
window (>=3D21). Keep the BPQ ext detection for len =3D=3D 22.
- CONNREQ path: require window + user address present (>=3D 28) before=20
reading offsets 20-27. Keep the optional timeout only when len =3D=3D 37.
- IP-over-NET/ROM path unchanged.

This should avoid both OOB reads and potential UAF from earlier unvalidated=
=20
accesses, and it answers the minimal length concern by checking the exact=
=20
lengths needed at each access point.=20

Please let me know if this is good enough or if anything else should be=20
changed or improved.=20

Thanks a lot!

Best wishes,
Stanislav Fort
Aisle Research

On Tuesday, September 2, 2025 at 3:17:14=E2=80=AFPM UTC+3 Eric Dumazet wrot=
e:

> On Tue, Sep 2, 2025 at 4:27=E2=80=AFAM Stanislav Fort <stanislav.fort@ais=
le.com>=20
> wrote:
> >
> > Add early pskb_may_pull() validation in nr_rx_frame() to prevent
> > out-of-bounds reads when processing malformed NET/ROM frames.
> >
> > The vulnerability occurs when nr_route_frame() accepts frames as
> > short as NR_NETWORK_LEN (15 bytes) but nr_rx_frame() immediately
> > accesses the 5-byte transport header at bytes 15-19 without validation.
> > For CONNREQ frames, additional fields are accessed (window at byte 20,
> > user address at bytes 21-27, optional BPQ timeout at bytes 35-36).
> >
> > Attack vector: External AX.25 I-frames with PID=3D0xCF (NET/ROM) can
> > reach nr_route_frame() via the AX.25 protocol dispatch mechanism:
> > ax25_rcv() -> ax25_rx_iframe() -> ax25_protocol_function(0xCF)
> > -> nr_route_frame()
> >
> > For frames destined to local NET/ROM devices, nr_route_frame() calls
> > nr_rx_frame() which immediately dereferences unvalidated offsets,
> > causing out-of-bounds reads that can crash the kernel or leak memory.
> >
> > Fix by using pskb_may_pull() early to linearize the maximum required
> > packet size (37 bytes) before any pointer assignments. This prevents
> > use-after-free issues when pskb_may_pull() reallocates skb->head and
> > ensures all subsequent accesses are within bounds.
> >
> > Reported-by: Stanislav Fort <disclosure@aisle.com>
> > Signed-off-by: Stanislav Fort <disclosure@aisle.com>
> > ---
> > net/netrom/af_netrom.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> > diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
> > index 3331669d8e33..3056229dcd20 100644
> > --- a/net/netrom/af_netrom.c
> > +++ b/net/netrom/af_netrom.c
> > @@ -883,7 +883,11 @@ int nr_rx_frame(struct sk_buff *skb, struct=20
> net_device *dev)
> >
> > /*
> > * skb->data points to the netrom frame start
> > + * Linearize the packet early to avoid use-after-free issues
> > + * when pskb_may_pull() reallocates skb->head later
> > */
> > + if (!pskb_may_pull(skb, max(NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1 +=
=20
> AX25_ADDR_LEN, 37)))
> > + return 0;
>
> I am not sure about the minimal packet length we expect from this point.
>
> I was suggesting to use skb_linearize() here, but then add the needed
> skb->len checks
> of various sizes depending on the context (different places you had
> patched earlier)
>
> Thank you.
>

------=_Part_47699_1111796520.1756923910572
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,<br /><br />Thanks a lot for the suggestions -- that's way better. =
I=E2=80=99ve sent v3, which follows your plan to linearize and add per-cont=
ext length checks:=C2=A0https://lore.kernel.org/all/20250903181915.6359-1-d=
isclosure@aisle.com/T/#u<br /><br />- Use skb_linearize() at the start of n=
r_rx_frame().<br />- Require skb-&gt;len &gt;=3D NR_NETWORK_LEN + NR_TRANSP=
ORT_LEN before reading base fields (offsets 0-19).<br />- Existing-socket p=
ath: for NR_CONNACK, require one extra byte for the window (&gt;=3D21). Kee=
p the BPQ ext detection for len =3D=3D 22.<br />- CONNREQ path: require win=
dow + user address present (&gt;=3D 28) before reading offsets 20-27. Keep =
the optional timeout only when len =3D=3D 37.<br />- IP-over-NET/ROM path u=
nchanged.<div><br />This should avoid both OOB reads and potential UAF from=
 earlier unvalidated accesses, and it answers the minimal length concern by=
 checking the exact lengths needed at each access point.=C2=A0</div><div><b=
r /></div><div>Please let me know if this is good enough or if anything els=
e should be changed or improved.=C2=A0</div><div><br /></div><div>Thanks a =
lot!</div><div><br /></div><div>Best wishes,</div><div>Stanislav Fort</div>=
<div>Aisle Research<br /><br /></div><div class=3D"gmail_quote"><div dir=3D=
"auto" class=3D"gmail_attr">On Tuesday, September 2, 2025 at 3:17:14=E2=80=
=AFPM UTC+3 Eric Dumazet wrote:<br/></div><blockquote class=3D"gmail_quote"=
 style=3D"margin: 0 0 0 0.8ex; border-left: 1px solid rgb(204, 204, 204); p=
adding-left: 1ex;">On Tue, Sep 2, 2025 at 4:27=E2=80=AFAM Stanislav Fort &l=
t;<a href=3D"mailto:stanislav.fort@aisle.com" target=3D"_blank" rel=3D"nofo=
llow">stanislav.fort@aisle.com</a>&gt; wrote:
<br>&gt;
<br>&gt; Add early pskb_may_pull() validation in nr_rx_frame() to prevent
<br>&gt; out-of-bounds reads when processing malformed NET/ROM frames.
<br>&gt;
<br>&gt; The vulnerability occurs when nr_route_frame() accepts frames as
<br>&gt; short as NR_NETWORK_LEN (15 bytes) but nr_rx_frame() immediately
<br>&gt; accesses the 5-byte transport header at bytes 15-19 without valida=
tion.
<br>&gt; For CONNREQ frames, additional fields are accessed (window at byte=
 20,
<br>&gt; user address at bytes 21-27, optional BPQ timeout at bytes 35-36).
<br>&gt;
<br>&gt; Attack vector: External AX.25 I-frames with PID=3D0xCF (NET/ROM) c=
an
<br>&gt; reach nr_route_frame() via the AX.25 protocol dispatch mechanism:
<br>&gt;   ax25_rcv() -&gt; ax25_rx_iframe() -&gt; ax25_protocol_function(0=
xCF)
<br>&gt;   -&gt; nr_route_frame()
<br>&gt;
<br>&gt; For frames destined to local NET/ROM devices, nr_route_frame() cal=
ls
<br>&gt; nr_rx_frame() which immediately dereferences unvalidated offsets,
<br>&gt; causing out-of-bounds reads that can crash the kernel or leak memo=
ry.
<br>&gt;
<br>&gt; Fix by using pskb_may_pull() early to linearize the maximum requir=
ed
<br>&gt; packet size (37 bytes) before any pointer assignments. This preven=
ts
<br>&gt; use-after-free issues when pskb_may_pull() reallocates skb-&gt;hea=
d and
<br>&gt; ensures all subsequent accesses are within bounds.
<br>&gt;
<br>&gt; Reported-by: Stanislav Fort &lt;<a href=3D"mailto:disclosure@aisle=
.com" target=3D"_blank" rel=3D"nofollow">disclosure@aisle.com</a>&gt;
<br>&gt; Signed-off-by: Stanislav Fort &lt;<a href=3D"mailto:disclosure@ais=
le.com" target=3D"_blank" rel=3D"nofollow">disclosure@aisle.com</a>&gt;
<br>&gt; ---
<br>&gt;  net/netrom/af_netrom.c | 4 ++++
<br>&gt;  1 file changed, 4 insertions(+)
<br>&gt;
<br>&gt; diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
<br>&gt; index 3331669d8e33..3056229dcd20 100644
<br>&gt; --- a/net/netrom/af_netrom.c
<br>&gt; +++ b/net/netrom/af_netrom.c
<br>&gt; @@ -883,7 +883,11 @@ int nr_rx_frame(struct sk_buff *skb, struct n=
et_device *dev)
<br>&gt;
<br>&gt;         /*
<br>&gt;          *      skb-&gt;data points to the netrom frame start
<br>&gt; +        *      Linearize the packet early to avoid use-after-free=
 issues
<br>&gt; +        *      when pskb_may_pull() reallocates skb-&gt;head late=
r
<br>&gt;          */
<br>&gt; +       if (!pskb_may_pull(skb, max(NR_NETWORK_LEN + NR_TRANSPORT_=
LEN + 1 + AX25_ADDR_LEN, 37)))
<br>&gt; +               return 0;
<br>
<br>I am not sure about the minimal packet length we expect from this point=
.
<br>
<br>I was suggesting to use skb_linearize() here, but then add the needed
<br>skb-&gt;len checks
<br>of various sizes depending on the context (different places you had
<br>patched earlier)
<br>
<br>Thank you.
<br></blockquote></div>
------=_Part_47699_1111796520.1756923910572--

------=_Part_47698_1216814787.1756923910572--

