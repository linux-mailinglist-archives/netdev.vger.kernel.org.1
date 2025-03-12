Return-Path: <netdev+bounces-174066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD225A5D46C
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 03:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA281783D4
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 02:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C960D18E025;
	Wed, 12 Mar 2025 02:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5WhrWUc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E918991E
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741746966; cv=none; b=E5Fz/MWFa6LKDqA6AXjDH/e1fs/OGjU2vOxWPUemte8JfAzYUjbBngLoayjDo1OzIufCftCWEwuXLRQrrFr/2+qDyyaJvIQlpaVS6MQo4PskTjdl6xOnIZ3UtfAQn4HcmTxesIvqqQky4IAQUxkgQcsBBTZCwkjt22hTUhy2Rrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741746966; c=relaxed/simple;
	bh=/Y6ryLM9U1SmUsI7JJnD4HP0YRU2PkTH5Sg0867JL9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfnfvG3I/+JodbJVFD5aE41MHW0hVWTRzO2DU4PeT4gnjkuJ0xpSAghoVIld9g5DWdfu/lXQFpEhVDvf4ooSxmN+zx/wQnHWDsiTUM9ZeP5gfm0zzfyLj4jyNj0rLzqlkB/pWdghhg6MqajV2Cv3MNUdOQuP+NGXSzxP/HKNgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5WhrWUc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741746963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0Qdf6BCD5X+PG4UHFD0dZOYm8Xo5mFSwYaydb7HeOw=;
	b=Q5WhrWUcd9GrNDygJfzlSbx5txE9KCB1sgeXVTw8nnG02FedgTN+GaKESAF+BzEG26pmpK
	PTe4ibiKEMWwkxgHAiKInktCd8cvAupATbnMZ/ONuwcUVrB3AbT2N/3fwzVc2sO9pUnqmO
	zpxprwcgrAtbK6SLeDiITjltdG0Ch0Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-l9ctJDOSPfKtuctcPX9xFg-1; Tue, 11 Mar 2025 22:36:01 -0400
X-MC-Unique: l9ctJDOSPfKtuctcPX9xFg-1
X-Mimecast-MFC-AGG-ID: l9ctJDOSPfKtuctcPX9xFg_1741746961
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so17298492a91.3
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 19:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741746961; x=1742351761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0Qdf6BCD5X+PG4UHFD0dZOYm8Xo5mFSwYaydb7HeOw=;
        b=DsstLY4u/xe31fQjJu7RB3fkJ0qugP74Vsb29HD4ZQHKlZYyskFhRbuNw+cIJ2gqm8
         feNuuZAmCRE2oSAlt/7eRK22IGTO7ovbClEMvkRPUtw54dn292RR+40nCCxv8bshv/cV
         kuqLpB0bV/J/BYuSEYrTedZwt7oHKz0OfpnHvWUWSVNUCWVpxOqdeTUTD/oEiiTcFZAf
         6FcATk5He7FR2dFL5MbEpkMApmwjHwEzMB414jpytSyhFyT620ewqMG8F1MPUOGHHYtB
         5yn7XGDCzfdlNu9iUZX7tyKio+LXZDcgU2Kxx1pKeFv9pu914PiN3ml15NHrf9+uESbb
         PqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM+JrO9fYDRoAxT4ph7htokrLzxMRm1VgmFNFVlp7d8QrN3z7Z4O2PuurxaBunZY8ZPGCqhpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypGlyFBiEPAZEOe1SB/f16yz3RoRAwK2X/LN4E3/YNLrEV+vYE
	ZlnGmBru+3r+jWkjRjKphF5W49jEP08/gkdPpbA4S/7ySMpoePyjsLjckNPlDk63PsxzNW6A0Ro
	qiACm34hTsBHCYYAjRkPoCDDTSQKSgQFptzSAIBbJN3xpRZ5buD5s7nBnVHi5+pyt2Obur/PpOl
	EejzY/F1lCv3BtJysWgn2Y49O4+LoA
X-Gm-Gg: ASbGncs+CWOj1m/hgVv4i7Zjiw6F0JgbiwbEAOCM496ucWCl7AdEbSEcSiC3fHqw9un
	L2NXNFnssLZm+6P6LtLdYhHdIlxYw3SSFC54kFVL9Qol/xm8fUUpWK8eENnqFTEaWGeCiFQ==
X-Received: by 2002:a17:90b:3c8d:b0:2ee:7411:ca99 with SMTP id 98e67ed59e1d1-2ff7ce7b230mr27082202a91.1.1741746960594;
        Tue, 11 Mar 2025 19:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlLyYz8YJAVDNTXvlrIkZ+ah2U7LaY6qVBnKj82yTIAhQAQGr7mchFwjJakUBUDLzrmHkg5nzqFWCWqq/bzbU=
X-Received: by 2002:a17:90b:3c8d:b0:2ee:7411:ca99 with SMTP id
 98e67ed59e1d1-2ff7ce7b230mr27082162a91.1.1741746960104; Tue, 11 Mar 2025
 19:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
 <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com> <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
 <edf41317-2191-458f-a315-87d5af42a264@daynix.com>
In-Reply-To: <edf41317-2191-458f-a315-87d5af42a264@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Mar 2025 10:35:45 +0800
X-Gm-Features: AQ5f1JpYZL86COIp0eU_jp91g3-ub-snbz3KyBvB3RDdU7-3JlIdfCetReW4Pdg
Message-ID: <CACGkMEta3k_JOhKv44XiBXZb=WuS=KbSeJNpYxCdeiAgRY2azg@mail.gmail.com>
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

On Tue, Mar 11, 2025 at 2:11=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/11 9:38, Jason Wang wrote:
> > On Mon, Mar 10, 2025 at 3:45=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/03/10 12:55, Jason Wang wrote:
> >>> On Fri, Mar 7, 2025 at 7:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> Hash reporting
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> Allow the guest to reuse the hash value to make receive steering
> >>>> consistent between the host and guest, and to save hash computation.
> >>>>
> >>>> RSS
> >>>> =3D=3D=3D
> >>>>
> >>>> RSS is a receive steering algorithm that can be negotiated to use wi=
th
> >>>> virtio_net. Conventionally the hash calculation was done by the VMM.
> >>>> However, computing the hash after the queue was chosen defeats the
> >>>> purpose of RSS.
> >>>>
> >>>> Another approach is to use eBPF steering program. This approach has
> >>>> another downside: it cannot report the calculated hash due to the
> >>>> restrictive nature of eBPF steering program.
> >>>>
> >>>> Introduce the code to perform RSS to the kernel in order to overcome
> >>>> thse challenges. An alternative solution is to extend the eBPF steer=
ing
> >>>> program so that it will be able to report to the userspace, but I di=
dn't
> >>>> opt for it because extending the current mechanism of eBPF steering
> >>>> program as is because it relies on legacy context rewriting, and
> >>>> introducing kfunc-based eBPF will result in non-UAPI dependency whil=
e
> >>>> the other relevant virtualization APIs such as KVM and vhost_net are
> >>>> UAPIs.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>> ---
> >>>>    Documentation/networking/tuntap.rst |   7 ++
> >>>>    drivers/net/Kconfig                 |   1 +
> >>>>    drivers/net/tap.c                   |  68 ++++++++++++++-
> >>>>    drivers/net/tun.c                   |  98 +++++++++++++++++-----
> >>>>    drivers/net/tun_vnet.h              | 159 +++++++++++++++++++++++=
+++++++++++--
> >>>>    include/linux/if_tap.h              |   2 +
> >>>>    include/linux/skbuff.h              |   3 +
> >>>>    include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
> >>>>    net/core/skbuff.c                   |   4 +
> >>>>    9 files changed, 386 insertions(+), 31 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/networking/tuntap.rst b/Documentation/net=
working/tuntap.rst
> >>>> index 4d7087f727be5e37dfbf5066a9e9c872cc98898d..86b4ae8caa8ad062c1e5=
58920be42ce0d4217465 100644
> >>>> --- a/Documentation/networking/tuntap.rst
> >>>> +++ b/Documentation/networking/tuntap.rst
> >>>> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disab=
le it::
> >>>>          return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
> >>>>      }
> >>>>

[...]

> >>>> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash_cont=
ainer __rcu **hashp,
> >>>> +                                         bool can_rss, void __user =
*argp)
> >>>
> >>> So again, can_rss seems to be tricky. Looking at its caller, it tires
> >>> to make eBPF and RSS mutually exclusive. I still don't understand why
> >>> we need this. Allow eBPF program to override some of the path seems t=
o
> >>> be common practice.
> >>>
> >>> What's more, we didn't try (or even can't) to make automq and eBPF to
> >>> be mutually exclusive. So I still didn't see what we gain from this
> >>> and it complicates the codes and may lead to ambiguous uAPI/behaviour=
.
> >>
> >> automq and eBPF are mutually exclusive; automq is disabled when an eBP=
F
> >> steering program is set so I followed the example here.
> >
> > I meant from the view of uAPI, the kernel doesn't or can't reject eBPF
> > while using automq.
>  > >>
> >> We don't even have an interface for eBPF to let it fall back to anothe=
r
> >> alogirhtm.
> >
> > It doesn't even need this, e.g XDP overrides the default receiving path=
.
> >
> >> I could make it fall back to RSS if the eBPF steeering
> >> program is designed to fall back to automq when it returns e.g., -1. B=
ut
> >> such an interface is currently not defined and defining one is out of
> >> scope of this patch series.
> >
> > Just to make sure we are on the same page, I meant we just need to
> > make the behaviour consistent: allow eBPF to override the behaviour of
> > both automq and rss.
>
> That assumes eBPF takes precedence over RSS, which is not obvious to me.

Well, it's kind of obvious. Not speaking the eBPF selector, we have
other eBPF stuffs like skbedit etc.

>
> Let's add an interface for the eBPF steering program to fall back to
> another steering algorithm. I said it is out of scope before, but it
> makes clear that the eBPF steering program takes precedence over other
> algorithms and allows us to delete the code for the configuration
> validation in this patch.

Fallback is out of scope but it's not what I meant.

I meant in the current uAPI take eBPF precedence over automq. It's
much more simpler to stick this precedence unless we see obvious
advanatge.

>
> >
> >>
> >>>

[...]

> >>> Is there a chance that we can reach here without TUN_VNET_HASH_REPORT=
?
> >>> If yes, it should be a bug.
> >>
> >> It is possible to use RSS without TUN_VNET_HASH_REPORT.
> >
> > Another call to separate the ioctls then.
>
> RSS and hash reporting are not completely independent though.

Spec said:

"""
VIRTIO_NET_F_RSSRequires VIRTIO_NET_F_CTRL_VQ.
"""

>
> A plot twist is the "types" parameter; it is a parameter that is
> "common" for RSS and hash reporting.

So we can share part of the structure through the uAPI.

> RSS and hash reporting must share
> this parameter when both are enabled at the same time; otherwise RSS may
> compute hash values that are not suited for hash reporting.

Is this mandated by the spec? If yes, we can add a check. If not,
userspace risk themselves as a mis-configuration which we don't need
to bother.

Note that spec use different commands for hash_report and rss.

>
> The paramter will be duplicated if we have separate ioctls for RSS and
> hash reporting, and the kernel will have a chiken-egg problem when
> ensuring they are synchronized; when the ioctl for RSS is issued, should
> the kernel ensure the "types" parameter is identical with one specified
> for hash reporting? It will not work if the userspace may decide to
> configure hash reporting after RSS.
>

See my reply above.

Thanks


