Return-Path: <netdev+bounces-175154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C93A639E4
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 02:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297483A9C6F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A8D84A2B;
	Mon, 17 Mar 2025 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEP+or+h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D37A13A
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174176; cv=none; b=ZKx5OhID25gwv/ChwR8R/eJA21y0PWOykcKIcss3S1DEkI71UY2NnOS9ke5GsBiQzb4tfm7Z0Ia7w4kR+Yy5E5yFzKycX28+aViXaLxaHTYWiXuXg0f2GJuv91S6N/n+RmcjAoTfOIkBGj1DrYkqhhWMq7Rpud+7zWk2C/fJ9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174176; c=relaxed/simple;
	bh=CzN21TjzvNUREJqN9yKLnuwDOxxOFD38+AvaRxQ0NjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHoSgBOi6qtGnwwm2muv76i/sR7d4Plp3yW8IBvs6/2is/54tTLXj1GapGZGFr4ZDyHFjcfG+EvbHA/Sv7g+fjdmsmaM1npbhKkGHrVPWo2AEqZD7XSbtz765ak4eHzGrt9U6Ql/gQ53S8Ns8ZoVi2oltKoOLceL37CDkvkoOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LEP+or+h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742174173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4MoEqpQnXaZ/qTz+HsMCtZlynDkQ/W55cI0ouLjhC8=;
	b=LEP+or+heed27hgVL3KbjQ29/sFGvxG2PPvEw1zKtgCBQw7nzATx2SPSl4Ny6ZQ48MjlTU
	pR9tDZ87/4d6JRzhQgGgXbsYU/KtDupL6LrKIfKbMu5oe/l6JOtDMiz50A3206Jy8vGSHv
	6T6hTU4bO4mZKNIs0PJRpYWWMp/FMpw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-m_DQ_hAUO_av0f2XZCzGbQ-1; Sun, 16 Mar 2025 21:16:12 -0400
X-MC-Unique: m_DQ_hAUO_av0f2XZCzGbQ-1
X-Mimecast-MFC-AGG-ID: m_DQ_hAUO_av0f2XZCzGbQ_1742174171
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-224347aef79so82561565ad.2
        for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 18:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742174171; x=1742778971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4MoEqpQnXaZ/qTz+HsMCtZlynDkQ/W55cI0ouLjhC8=;
        b=jLDlGlHEYR4eRwWIQE84srjXEfYgi5S7tPvU3TVxDcf+81TRFpcQOrWuI0eK50jZW8
         JUg5JP17vl5TP5Gv1kDiOBbTRvNsYjuYe7AafsFzuVNxBEcTcfjfezC69r8Cdawcq79C
         psUZLvcErKB0O10MoA+SVp7C1o/amQmgfi1H4KJVOC3gTWQF6ytXUeCQTweIbGIUEqEj
         NwL36yUokVciY+Q39Fnb78maeKsvX94RLn73JRjjDWcKpv1R/lk+ZVECH+7J2BQpdPhu
         ARGK95Rg5K3+lZX41vs5PmpnCSkwQskGtg0JrIWSIZZUERqL4p9AXoDjOhGSjBEbVrLU
         BvEw==
X-Forwarded-Encrypted: i=1; AJvYcCWa8pJl1+ccjbz4y7su8v910tgn+NjciDcJzbZBiICWE10pnOPfh+5vcQUcD9ZRQTyek9WlzF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2fY5swotnHFkc9o23R72Ue23KuKGT/ZjWe8FX0PXSICIiHy0
	hevajrJOQ0PtzDeeEEi+bh6If8rAy0cDCF6V5EYPIUslyb+2CnHm6gXnrrXhsEGC2A19y30HNEF
	Rqg+IJNSM+vnyI0MYOf8BvvtWNC4Jz3HizO/1WuawI2LOh1QUBoy9UzLtlrRGwmOoQA2mxjp3fz
	NA69K5th27i/X+Wb0TG4wsVLfESx7k
X-Gm-Gg: ASbGnculHAEUhV1rydYBC5aJ1z0Wlr0poV6asB2HBrfauSWDNA90VoIZqUC2iEVsQC7
	Ka9P3A56lnaY/p2hXluqOkSG75G5KrNpXn6rD0sUmnFTzs+OBrp+67h2BTRYKLHZwI3fWOpVHyg
	==
X-Received: by 2002:a17:902:d2ca:b0:223:f408:c3dc with SMTP id d9443c01a7336-225e0a1d1cemr128517845ad.9.1742174170881;
        Sun, 16 Mar 2025 18:16:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN9b+c9VTr3YV8Dk+KsWo3MObCZ47nhK2/agt4NwMcy5Y5Id8DI25AtbuvPnLVJMTxExA7TzYRu1FpArxEfEk=
X-Received: by 2002:a17:902:d2ca:b0:223:f408:c3dc with SMTP id
 d9443c01a7336-225e0a1d1cemr128517515ad.9.1742174170508; Sun, 16 Mar 2025
 18:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
 <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com> <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
 <5e67a0a6-f613-4b0a-b64e-67f649e45c3e@daynix.com> <CACGkMEv83iR0vU00XGOGonL1fkd=K1b-shCcNb1K8yJ9O+0BDQ@mail.gmail.com>
 <39c059c9-fe67-46e4-8c81-854a3de8d726@daynix.com>
In-Reply-To: <39c059c9-fe67-46e4-8c81-854a3de8d726@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Mar 2025 09:15:58 +0800
X-Gm-Features: AQ5f1Jo1HQmsqCW0nkMN-ULCPgpB7WbDQ5yVDZ3MduwtLyN84hDroQoIwznFchs
Message-ID: <CACGkMEtRhJnnPJDASb8WwW=dO1HzL9aRo4YT9csWSxXCTsu_Tg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/6] tun: Introduce virtio-net hash feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:55=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/12 11:59, Jason Wang wrote:
> > On Tue, Mar 11, 2025 at 2:17=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/03/11 9:38, Jason Wang wrote:
> >>> On Mon, Mar 10, 2025 at 3:45=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> On 2025/03/10 12:55, Jason Wang wrote:
> >>>>> On Fri, Mar 7, 2025 at 7:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>>>
> >>>>>> Hash reporting
> >>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>
> >>>>>> Allow the guest to reuse the hash value to make receive steering
> >>>>>> consistent between the host and guest, and to save hash computatio=
n.
> >>>>>>
> >>>>>> RSS
> >>>>>> =3D=3D=3D
> >>>>>>
> >>>>>> RSS is a receive steering algorithm that can be negotiated to use =
with
> >>>>>> virtio_net. Conventionally the hash calculation was done by the VM=
M.
> >>>>>> However, computing the hash after the queue was chosen defeats the
> >>>>>> purpose of RSS.
> >>>>>>
> >>>>>> Another approach is to use eBPF steering program. This approach ha=
s
> >>>>>> another downside: it cannot report the calculated hash due to the
> >>>>>> restrictive nature of eBPF steering program.
> >>>>>>
> >>>>>> Introduce the code to perform RSS to the kernel in order to overco=
me
> >>>>>> thse challenges. An alternative solution is to extend the eBPF ste=
ering
> >>>>>> program so that it will be able to report to the userspace, but I =
didn't
> >>>>>> opt for it because extending the current mechanism of eBPF steerin=
g
> >>>>>> program as is because it relies on legacy context rewriting, and
> >>>>>> introducing kfunc-based eBPF will result in non-UAPI dependency wh=
ile
> >>>>>> the other relevant virtualization APIs such as KVM and vhost_net a=
re
> >>>>>> UAPIs.
> >>>>>>
> >>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>>>> ---
> >>>>>>     Documentation/networking/tuntap.rst |   7 ++
> >>>>>>     drivers/net/Kconfig                 |   1 +
> >>>>>>     drivers/net/tap.c                   |  68 ++++++++++++++-
> >>>>>>     drivers/net/tun.c                   |  98 +++++++++++++++++---=
--
> >>>>>>     drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++=
++++++++++++++--
> >>>>>>     include/linux/if_tap.h              |   2 +
> >>>>>>     include/linux/skbuff.h              |   3 +
> >>>>>>     include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
> >>>>>>     net/core/skbuff.c                   |   4 +
> >>>>>>     9 files changed, 386 insertions(+), 31 deletions(-)
> >>>>>>
> >
> > [...]
> >
> >>>>> Let's has a consistent name for this and the uapi to be consistent
> >>>>> with TUNSETIFF/TUNGETIFF. Probably TUNSETVNETHASH and
> >>>>> tun_vnet_ioctl_gethash().
> >>>>
> >>>> They have different semantics so they should have different names.
> >>>> TUNGETIFF reports the value currently set while TUNGETVNETHASHCAP
> >>>> reports the value that can be set later.
> >>>
> >>> I'm not sure I will get here. I meant a symmetric name
> >>>
> >>> TUNSETVNETHASH and TUNVETVNETHASH.
> >>
> >> TUNGETVNETHASHCAP does not correspond to TUNGETIFF. The correspondence
> >> of ioctl names is as follows:
> >> TUNGETFEATURES - TUNGETVNETHASHCAP
> >
> > TUNGETFEATURES returns the value set from TUNSETIFF. This differs from
> > TUNGETVNETHASHCAP semantic which just return the capabilities.
> >
> > +static inline long tun_vnet_ioctl_gethashcap(void __user *argp)
> > +{
> > +       static const struct tun_vnet_hash cap =3D {
> > +               .flags =3D TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
> > +               .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
> > +       };
> > +
> > +       return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
> > +}
> >
> > TUNGETFEATURES doesn't' help too much for non-persist TAP as userspace
> > knows what value it set before.
> >
> >> TUNSETIFF - TUNSETVNETHASH
> >> TUNGETIFF - no corresponding ioctl for the virtio-net hash features
> >
> > And this sounds odd and a hint for a incomplete uAPI as userspace
> > needs to know knowing what can set before doing TUNSETVNETHASH.
>
> You are confused with TUNGETFEATURES and TUNGETIFF. Below is the code
> that implements TUNGETFEATURES:
> if (cmd =3D=3D TUNGETFEATURES) {
>         /* Currently this just means: "what IFF flags are valid?".
>          * This is needed because we never checked for invalid flags on
>          * TUNSETIFF.
>          */
>         return put_user(IFF_TUN | IFF_TAP | IFF_NO_CARRIER |
>                         TUN_FEATURES, (unsigned int __user*)argp);
> } else if (cmd =3D=3D TUNSETQUEUE) {

Right.

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >
> > Thanks
> >
>


