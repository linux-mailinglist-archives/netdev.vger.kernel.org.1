Return-Path: <netdev+bounces-175153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F96EA639DF
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 02:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A983A7FFC
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 01:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A77512DD95;
	Mon, 17 Mar 2025 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StI58q2v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79081F94A
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174159; cv=none; b=Bs7pJWyn6b3YblgcXTfZjVaX6vjQtd0rHK41SwyV2qYCUNZQ8KKx1CXs73VXKWyygDvGpw0fT2UwUk+nPJwQuXlSIZykTb23yC/w1dIFKQgEuMq+a8tJUZncbBE9FdTREmT/EOHrzLsVqUx4IAvcgzNHMbbU5nk54gw3myTdemw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174159; c=relaxed/simple;
	bh=Q0+PIJ88a4iRAsJs1W5fwyu0AoevhoEEr/zt+lUAKjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BavvSaFIJOoYKWEfjmIhomoMe6l7Lmw81wzFJDL/lGIdgH+JVh4/D2hS2snZHn2baIy53zmTlPQV7ecYZDCxfLGfoQh+XdXmPTWM5ceeA4rGxmBov9ffp3V1i2Txu90GZFx8hr2o2qwfwLbG+jECJVSiWCcBj5peoRI1yfo+TeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StI58q2v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742174156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqiRITvym1c0onqrnYAcV6zc/1khgZbdXRXq4ArYjQA=;
	b=StI58q2vct+iG+SF3Df3apM2OHeVnamnn35pLod47cIVA1tB9Ici/IL58Brh+H508ezoXB
	FAvSshNhctJT2pRIIViqFSByuM0DENTY9No5cmRNoifBU2ODjLcKSVU89BNkxKph4hGu5J
	E6/sKrbeWmFORmYxpJYiooNimH0W3TM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-OzhlukylMEeHY7ItC0nPFw-1; Sun, 16 Mar 2025 21:15:54 -0400
X-MC-Unique: OzhlukylMEeHY7ItC0nPFw-1
X-Mimecast-MFC-AGG-ID: OzhlukylMEeHY7ItC0nPFw_1742174153
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3010db05acfso2231245a91.3
        for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 18:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742174153; x=1742778953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqiRITvym1c0onqrnYAcV6zc/1khgZbdXRXq4ArYjQA=;
        b=OU9nuU6gAd+oBeK2NdiFDqdrRYIBgSTzd49o1WTXYihz/x6vjMW3OulxG57ZeBfAie
         c5cQbYUNPY+Ezq/rBcpSC89R6EAWJ7STSbyMiz4vqsk6EvyDMys1UySGIpuAdOuR1p3q
         E2Yy92XOfglwQK5iHu0hxmppPhmNAdUHEz2WKQpvPNMpbboi7WGNZEAOGmfwuvHb9NCN
         JHAJZUWm9q/TebbIjfTL0II2trwg1o0zU6j1gxaJpnzf1ssFdwGkQOIScZ1v8PJSVLt4
         StPjiMdvnacdgZPASjbBSQamTNw3+5z6fJRd+CuSuh6GTZ5ONK6B7p1/eiIz7380w4Qv
         L9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8qPKEjX7lDNQdSnTMu7rDe3ojh0c8IltVG5AjyGPP7cCunKIFJRrpgj6JICIXzdY/2FFpvxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDzwjziwu+lGu8W/cFrwgaeYsBy2P+jFDVphokbqert5K7+f8S
	TMrPot0T+ngIEj1/1y+szojPBMKPZzTHAeqyek9akf6KdtymXJkmkYWqQcDPFtnzcnnuma93e3n
	Pqy5VUedLX2mKXFFzyuexpYnlBFciBT5d2OXyVc0mvs8YTF3dhiyRyJuHsbjWU/ujS317Zsal0t
	CsVTUkZQOH1hLY7GKsvbgXeg0hlTHU
X-Gm-Gg: ASbGncuQVmmgCL4sKOwDiRWLhs7TZJwVKBaz26pOb8D+/z3hasu/fu2hbpKO1Bj7NBO
	2iKTiVSYgOzOSedfBYtaX9wjISzBnyLXpmp8DkMbzpRcnqfqB6dq3K1XIIloltpwd5zb0VktxsQ
	==
X-Received: by 2002:a17:90a:d610:b0:2fe:9581:fbea with SMTP id 98e67ed59e1d1-30151d80d72mr13059895a91.29.1742174152918;
        Sun, 16 Mar 2025 18:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxpVZEUCtxPZyh7hATJuGyGFLhT6k6detJv2gwkDBKiP/VApC5tJcX/mSZDxnZ+e+OpQEJWcYXL+Lqzu0fpMQ=
X-Received: by 2002:a17:90a:d610:b0:2fe:9581:fbea with SMTP id
 98e67ed59e1d1-30151d80d72mr13059874a91.29.1742174152536; Sun, 16 Mar 2025
 18:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-6-df76624025eb@daynix.com>
 <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com>
 <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com> <CACGkMEu9tynRgTh__3p_vSqOekSirbVgS90rd5dUiJru9oV1eg@mail.gmail.com>
 <1dd2417a-3246-44b0-b4ba-feadfd6f794e@daynix.com> <CACGkMEthfj0KJvOHhnc_ww7iqtmhHUy9f9EGOoR-n0OwHOBrvQ@mail.gmail.com>
 <77c21953-b850-4962-8673-6effb593d819@daynix.com>
In-Reply-To: <77c21953-b850-4962-8673-6effb593d819@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Mar 2025 09:15:40 +0800
X-Gm-Features: AQ5f1JpR0mxXkmVnrSX1gXa2p5ktJxpo4uYjioUOGsjKMLFJ1-a0iSEE4BZ4sls
Message-ID: <CACGkMEtMghoZbMO8c+30vqtOr3daEYrU2gG-QAZjOJev8NnBhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 6/6] vhost/net: Support VIRTIO_NET_F_HASH_REPORT
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

On Wed, Mar 12, 2025 at 1:59=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/12 12:36, Jason Wang wrote:
> > On Tue, Mar 11, 2025 at 2:24=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/03/11 9:42, Jason Wang wrote:
> >>> On Mon, Mar 10, 2025 at 3:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> On 2025/03/10 13:43, Jason Wang wrote:
> >>>>> On Fri, Mar 7, 2025 at 7:02=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>>>
> >>>>>> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated o=
n the
> >>>>>> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report =
no
> >>>>>> hash values (i.e., the hash_report member is always set to
> >>>>>> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by th=
e
> >>>>>> underlying socket will be reported.
> >>>>>>
> >>>>>> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
> >>>>>>
> >>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>>>> ---
> >>>>>>     drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------=
------------
> >>>>>>     1 file changed, 29 insertions(+), 20 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >>>>>> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42=
c302f3586ea6bb5e0d4289 100644
> >>>>>> --- a/drivers/vhost/net.c
> >>>>>> +++ b/drivers/vhost/net.c
> >>>>>> @@ -73,6 +73,7 @@ enum {
> >>>>>>            VHOST_NET_FEATURES =3D VHOST_FEATURES |
> >>>>>>                             (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
> >>>>>>                             (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> >>>>>> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
> >>>>>>                             (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> >>>>>>                             (1ULL << VIRTIO_F_RING_RESET)
> >>>>>>     };
> >>>>>> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net=
)
> >>>>>>                    .msg_controllen =3D 0,
> >>>>>>                    .msg_flags =3D MSG_DONTWAIT,
> >>>>>>            };
> >>>>>> -       struct virtio_net_hdr hdr =3D {
> >>>>>> -               .flags =3D 0,
> >>>>>> -               .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> >>>>>> +       struct virtio_net_hdr_v1_hash hdr =3D {
> >>>>>> +               .hdr =3D {
> >>>>>> +                       .flags =3D 0,
> >>>>>> +                       .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> >>>>>> +               }
> >>>>>>            };
> >>>>>>            size_t total_len =3D 0;
> >>>>>>            int err, mergeable;
> >>>>>> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
> >>>>>>            bool set_num_buffers;
> >>>>>>            struct socket *sock;
> >>>>>>            struct iov_iter fixup;
> >>>>>> -       __virtio16 num_buffers;
> >>>>>>            int recv_pkts =3D 0;
> >>>>>>
> >>>>>>            mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> >>>>>> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *ne=
t)
> >>>>>>                            vhost_discard_vq_desc(vq, headcount);
> >>>>>>                            continue;
> >>>>>>                    }
> >>>>>> +               hdr.hdr.num_buffers =3D cpu_to_vhost16(vq, headcou=
nt);
> >>>>>>                    /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_=
NET_HDR */
> >>>>>>                    if (unlikely(vhost_hlen)) {
> >>>>>> -                       if (copy_to_iter(&hdr, sizeof(hdr),
> >>>>>> -                                        &fixup) !=3D sizeof(hdr))=
 {
> >>>>>> +                       if (copy_to_iter(&hdr, vhost_hlen,
> >>>>>> +                                        &fixup) !=3D vhost_hlen) =
{
> >>>>>>                                    vq_err(vq, "Unable to write vne=
t_hdr "
> >>>>>>                                           "at addr %p\n", vq->iov-=
>iov_base);
> >>>>>>                                    goto out;
> >>>>>
> >>>>> Is this an "issue" specific to RSS/HASH? If it's not, we need a sep=
arate patch.
> >>>>>
> >>>>> Honestly, I'm not sure if it's too late to fix this.
> >>>>
> >>>> There is nothing wrong with the current implementation.
> >>>
> >>> Note that I meant the vhost_hlen part, and the current code is tricky=
.
> >>>
> >>> The comment said:
> >>>
> >>> """
> >>> /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
> >>> """
> >>>
> >>> So it tries to only offer virtio_net_hdr even if vhost_hlen is the se=
t
> >>> to mrg_rxbuf len.
> >>>
> >>> And this patch changes this behaviour.
> >>
> >> mrg_rxbuf only adds the num_buffers field, which is always set for
> >> mrg_rxbuf.
> >>
> >> The num_buffers was not set for VIRTIO_F_VERSION_1 in the past, but th=
is
> >> was also fixed with commit a3b9c053d82a ("vhost/net: Set num_buffers f=
or
> >> virtio 1.0")
> >>
> >> So there is no behavioral change for existing features with this patch=
.
> >
> > I meant this part.
> >
> >>>>> +                       if (copy_to_iter(&hdr, vhost_hlen,
> >>>>> +                                        &fixup) !=3D vhost_hlen) {
> >
> > We should copy only sizeof(hdr) instead of vhost_hlen.> > Anything I mi=
ss?
>
> sizeof(hdr) will be greater than vhost_hlen when neither
> VIRTIO_NET_F_MRG_RXBUF or VIRTIO_F_VERSION_1 is negotiated.

Just to make sure we are on the same page I meant we should only
advance sizeof(struct virtio_net_hdr) here to make sure we can set the
num_buffers correctly.

But this is not what the code did here.

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> > Thanks
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>> Thanks
> >>>
> >>>> The current
> >>>> implementation fills the header with zero except num_buffers, which =
it
> >>>> fills some real value. This functionality is working fine with
> >>>> VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1, which change the head=
er size.
> >>>>
> >>>> Now I'm adding VIRTIO_NET_F_HASH_REPORT and it adds the hash_report
> >>>> field, which also needs to be initialized with zero, so I'm making s=
ure
> >>>> vhost_net will also initialize it.
> >>>>
> >>>> Regards,
> >>>> Akihiko Odaki
> >>>>
> >>>>>
> >>>>> Others look fine.
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>
> >>>
> >>
> >
>


