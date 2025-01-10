Return-Path: <netdev+bounces-156978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F1AA08840
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 07:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091393A2C55
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 06:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB32063ED;
	Fri, 10 Jan 2025 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQOk15k2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216A1A4F1F
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736489920; cv=none; b=JSRSsdxxlj80IyqaaxN1AHOQA5kYafy0cVUAHKv0S3DFvJZhU9e6XXoNeok9Tjls0Pfn9rl/V96hTJRHvIrlb6VaHpBvSAS+APhCoWivqCG1AnZ5LtxBVzLgHpmoB80fvEcOpkKU7LhyXQYFNoqcmExd6ocAVcF72UiunX0gkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736489920; c=relaxed/simple;
	bh=k8iw9+kciIECw/ctmne1alKhyO7yDWLOtGLrwdrz43s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojnYAxDYIxto7vxo+SReSM4m7nI7lppwh2xEihyww0o/uFS4YXcFgeuHMEQirS68CaIsOhRh7dz4h6on05dOjl8wu1mZREjud13d90d+57MNf26SqoHZ2JqZA9JfKv0Tg2WhM+eDB84ZG2Vol9dxB4XHD1ita3b+MkRujHaSqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQOk15k2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736489917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISxfKzVoXDOr34Y5KsabwaYvJOoTxc4gV0y3MMcBA0A=;
	b=GQOk15k2V8gcHO2AnLz230RkKVKYjd8dNG1kBN3uqnuUkSVBnLW0CepRICY81BMJbL+wpA
	48hRnqgmqJugaW1/k1stliI6EHceyWoLwFNVHCDY8rzATD6grCMRQ+mCZZ6YVVvrWs3xw2
	zs3MsmXMa0Fc8smBxtihosTlDNgc9w8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-F3BqOYMjNxKGColL2R19_w-1; Fri, 10 Jan 2025 01:18:35 -0500
X-MC-Unique: F3BqOYMjNxKGColL2R19_w-1
X-Mimecast-MFC-AGG-ID: F3BqOYMjNxKGColL2R19_w
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3f4cbbbbcso1722585a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 22:18:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736489914; x=1737094714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISxfKzVoXDOr34Y5KsabwaYvJOoTxc4gV0y3MMcBA0A=;
        b=LUJMELHBJPuISYlQ32tm74taGFcouNvYa57N0XQLo95djvWbgjJzxpit3D1e0kDAcT
         9R+3owFjXDjSoxOyrIu/73Ys2yJH8MCw3cGcsruqB1FG4Ng+xRDBKsMHONN+L7TmhGj8
         htNV5t6cXfeLS/WPDZe7i9QyrRSsuo7GmgzWV2mLY8QLHD2IuRqxDjsmG3F+xUtjAJwg
         mSQfp3ow2bVAJfHQCeYGYg+5y+AfKGYXzdRZVDPHxIw3ZGqvjrSTZmfircIjlQfH9fZP
         sycoQ6Bn3oPqtnwePF65e5FNYP0zmgsxUHIiM2nzBPYctLy53aejQOV6AYDJFrj25tNS
         lkGg==
X-Forwarded-Encrypted: i=1; AJvYcCWv0W6+mYKPm04aoEC/qAxXfKZSRKpoxxCJ7OnRmBkUQrY4NzeDOaluet0uACef69bcwJvVS4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwV28yMBuX0xng+bERfsvZR1mrPJtyHJtIfhIvW1IuJcjhyAcV
	YS3LKWM+vLPs6Vp4K/z5FqOJ1nOCjPYBf57Kl18sasRug6GXaGdVPHlIp3kuWXXvyRilViCqWQI
	oLf0VtDKJr56tVHioJQugLWih+/pXatd71NOwmnqy7KRKEcUflH+rzOZkNAo/hg7aU6Tk1VHdd9
	8Lx0VCH4fcEe/1dk2texbylBT880gU
X-Gm-Gg: ASbGncsynqAJi3XtDsETY6eICnSxmLq4zByMgXlcXPqp5GCfh6F1vXFYHCMVRLJdo0x
	HkQj6LnSr9MTYLIEphP0+fo7ROJT4fePZhgOpEGM=
X-Received: by 2002:a05:6402:3888:b0:5d1:2377:5ae2 with SMTP id 4fb4d7f45d1cf-5d972dfb857mr8721749a12.7.1736489914355;
        Thu, 09 Jan 2025 22:18:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiAdihQyFMz0O5tj3Ue3EozuwVp0j8wLiDgLZq4DzNClh5miAT01uxp0Lj3n+X60xlkcwlDVJx2hp/x1jcaIw=
X-Received: by 2002:a05:6402:3888:b0:5d1:2377:5ae2 with SMTP id
 4fb4d7f45d1cf-5d972dfb857mr8721718a12.7.1736489914008; Thu, 09 Jan 2025
 22:18:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241227191211.12485-1-chia-yu.chang@nokia-bell-labs.com>
 <20241227191211.12485-12-chia-yu.chang@nokia-bell-labs.com>
 <CACGkMEu990O+2Sedj+ASv0P5TnZR9THiOdHmx=L0hOxQRXPcsg@mail.gmail.com>
 <PAXPR07MB79849952690901A50688EFEDA3092@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20250108072548-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250108072548-mutt-send-email-mst@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 10 Jan 2025 14:17:57 +0800
X-Gm-Features: AbW1kvb8ubWeXgB-U6M0XsqnjiyDPikXOh18Gs0pZOWli8Sl1qeTWevc3-CPVnA
Message-ID: <CAPpAL=xcWrbDMnqd5X6QfSMi1Mz-VOm0k-07kR5wsB8d0LU_pA@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 11/14] virtio_net: Accurate ECN flag in virtio_net_hdr
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Jason Wang <jasowang@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"dsahern@gmail.com" <dsahern@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "joel.granados@kernel.org" <joel.granados@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"horms@kernel.org" <horms@kernel.org>, "pablo@netfilter.org" <pablo@netfilter.org>, 
	"kadlec@netfilter.org" <kadlec@netfilter.org>, 
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"coreteam@netfilter.org" <coreteam@netfilter.org>, "shenjian15@huawei.com" <shenjian15@huawei.com>, 
	"salil.mehta@huawei.com" <salil.mehta@huawei.com>, "shaojijie@huawei.com" <shaojijie@huawei.com>, 
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "tariqt@nvidia.com" <tariqt@nvidia.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "ij@kernel.org" <ij@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series of patches v6 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Jan 8, 2025 at 8:33=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Dec 30, 2024 at 09:50:59AM +0000, Chia-Yu Chang (Nokia) wrote:
> > >From: Jason Wang <jasowang@redhat.com>
> > >Sent: Monday, December 30, 2024 8:52 AM
> > >To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > >Cc: netdev@vger.kernel.org; dsahern@gmail.com; davem@davemloft.net; ed=
umazet@google.com; dsahern@kernel.org; pabeni@redhat.com; joel.granados@ker=
nel.org; kuba@kernel.org; andrew+netdev@lunn.ch; horms@kernel.org; pablo@ne=
tfilter.org; kadlec@netfilter.org; netfilter-devel@vger.kernel.org; coretea=
m@netfilter.org; shenjian15@huawei.com; salil.mehta@huawei.com; shaojijie@h=
uawei.com; saeedm@nvidia.com; tariqt@nvidia.com; mst@redhat.com; xuanzhuo@l=
inux.alibaba.com; eperezma@redhat.com; virtualization@lists.linux.dev; ij@k=
ernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper=
@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.=
com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jas=
on_Livingood@comcast.com; vidhi_goel@apple.com
> > >Subject: Re: [PATCH v6 net-next 11/14] virtio_net: Accurate ECN flag i=
n virtio_net_hdr
> > >
> > >[You don't often get email from jasowang@redhat.com. Learn why this is=
 important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > >CAUTION: This is an external email. Please be very careful when clicki=
ng links or opening attachments. See the URL nok.it/ext for additional info=
rmation.
> > >
> > >
> > >
> > >On Sat, Dec 28, 2024 at 3:13=E2=80=AFAM <chia-yu.chang@nokia-bell-labs=
.com> wrote:
> > >>
> > >> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >>
> > >> Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of the A=
CE
> > >> field to count new packets with CE mark; however, it will be corrupt=
ed
> > >> by the RFC 3168 ECN-aware TSO. Therefore, fallback shall be applied =
by
> > >> seting NETIF_F_GSO_ACCECN to ensure that the CWR flag should not be
> > >> changed within a super-skb.
> > >>
> > >> To apply the aforementieond new AccECN GSO for virtio, new featue bi=
ts
> > >> for host and guest are added for feature negotiation between driver
> > >> and device. And the translation of Accurate ECN GSO flag between
> > >> virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is also added t=
o
> > >> avoid CWR flag corruption due to RFC3168 ECN TSO.
> > >>
> > >> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >> ---
> > >>  drivers/net/virtio_net.c        | 14 +++++++++++---
> > >>  drivers/vdpa/pds/debugfs.c      |  6 ++++++
> > >>  include/linux/virtio_net.h      | 16 ++++++++++------
> > >>  include/uapi/linux/virtio_net.h |  5 +++++
> > >>  4 files changed, 32 insertions(+), 9 deletions(-)
> > >
> > >Is there a link to the spec patch? It needs to be accepted first.
> > >
> > >Thanks
> >
> > Hi Jason,
> >
> > Thanks for the feedback, I found the virtio-spec in github: https://git=
hub.com/oasis-tcs/virtio-spec but not able to find the procedure to propose=
.
> > Could you help to share the procedure to propose spec patch? Thanks.
>
>
> You post it on virtio-comment for discussion. Github issues are then used
> for voting and to track acceptance.
> https://github.com/oasis-tcs/virtio-spec/blob/master/README.md#use-of-git=
hub-issues
>
>
> > --
> > Chia-Yu
>
>


