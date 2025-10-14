Return-Path: <netdev+bounces-229022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA14BD7219
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 04:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8A33E7D90
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 02:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEEC30749B;
	Tue, 14 Oct 2025 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rkfPwR6+"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18411E9B12
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410631; cv=none; b=MRVwK2J3J9Za7WcHzXvKByr/1nmCkDaGplST4JMMh09zDvO+3Ravxiqjlc89OHqAuDrh9EuwDvjRmBkBi6r7Iye3lgGRg75IIGAIgxHMontWqVXHp73LpiU2niL+ktXchure3+bIu0ksrslZcqaZybz+Em7ahmvVH0ydRla/c98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410631; c=relaxed/simple;
	bh=cR3HCkIFNdf5Gn32epuL4lJ22BcY6hMgtll801wHEWo=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=O+yHfXX5wKYL9CC4jwvrU5KSQ/PW9jXejbfOsX10fy+IzsmATF3x8kdvuaBWyvYy7rq+Pj8l1JvmpABLBX+/9XSdtOg6vLuXVobSnR8p6W+TnPISAdjDfCihcjuvZUVsyZd/syWr95D2en6XH1Ay7LXsxmnJvGx9O/AMovkhQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rkfPwR6+; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760410624; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=i0jVK9tDIg9IsxCsaGFsBAUEMszAXfkKjs3QSzbgtoM=;
	b=rkfPwR6+bUH8xDIRTbhN9UKTUo+jA+emCXdmbYpoPG5hCshHbeFjdOWSb37AyglMVK89r1lShIZxFMBmfU9TT6XJRTOWFtH5e5XucSjRMv6yJzYbzLd5oc4GlK2ln1a500jPOaGpiTgv1fWrnIgbqt0+yB9/SU3z2J9mZjeNW2c=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wq9ucfr_1760410623 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 10:57:03 +0800
Message-ID: <1760410611.871382-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 0/3] fixes two virtio-net related bugs.
Date: Tue, 14 Oct 2025 10:56:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 Heng Qi <hengqi@linux.alibaba.com>,
 virtualization@lists.linux.dev
References: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEugrT0K3LcJsPaN6FDncvBgXRLkG6By8scm8PyABF2BUA@mail.gmail.com>
In-Reply-To: <CACGkMEugrT0K3LcJsPaN6FDncvBgXRLkG6By8scm8PyABF2BUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 13 Oct 2025 13:56:58 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Oct 13, 2025 at 10:06=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuan=
zhuo@linux.alibaba.com
> > Commit #1 Move the flags into the existing if condition; the issue is t=
hat it introduces a
> > small amount of code duplication.
> >
> > Commit #3 is new to fix the hdr len in tunnel gso feature.
> >
> > Hi @Paolo Abenchi,
> > Could you please test commit #3? I don't have a suitable test environme=
nt, as
> > QEMU doesn't currently support the tunnel GSO feature.
>
> It has been there.

Maybe I missed it.

Thanks.


>
> Thanks
>
> >
> > Thanks.
> >
> > Xuan Zhuo (3):
> >   virtio-net: fix incorrect flags recording in big mode
> >   virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
> >   virtio-net: correct hdr_len handling for tunnel gso
> >
> >  drivers/net/virtio_net.c   | 16 ++++++++-----
> >  include/linux/virtio_net.h | 46 ++++++++++++++++++++++++++++++++------
> >  2 files changed, 50 insertions(+), 12 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
>

