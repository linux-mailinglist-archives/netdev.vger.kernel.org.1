Return-Path: <netdev+bounces-229021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEA2BD7210
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 04:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3155C4E118D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 02:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C53E3043D6;
	Tue, 14 Oct 2025 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jwm2Atyy"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C832BAF9
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410619; cv=none; b=vCUa2Al+ksAXgkz5AELR8PLHRgQWe0zQrevpDXgDH43/AfPeyiy0dq90sloSAObq9FeJOqPJ1ILDc1xDQVzycCvCW2G7OQn45r22Auj4KAyXGB2GepvlH0PWVnFOo/FPv1E6+6jD2eZQE6sphsAtPaJqSBd807kN34MOD/Xowr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410619; c=relaxed/simple;
	bh=Pv52on8Nkd7LJqHQpJ4HboPWsVPm41PcO25xLp0ziSY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=vCG1iqS47KCmd02E/erPZqNIEQkBPiOde6bgdLM8MVHGxeM8hKdHELSsKsh/NZ+r86kzXzEWDa1uzQ3aMoNLPKtsdZ4IPvDW6zTyeU3GdG1EUHwAW2iyIWShTILQZqnb3oiT6zLpE1g9Nok+truMneW1Efi1iSh8QmKVgcsJ/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jwm2Atyy; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760410609; h=Message-ID:Subject:Date:From:To;
	bh=nqssvXb52MWjZ1FRVvJDU0mo7QEl62fKjchRN3Bns2U=;
	b=Jwm2AtyyPvFxWtIoTk4WrhLGR5c+1IsOt5UCDag14jCwBGVN75QeSv81tWKWUKHhs1HxXYP8aRtTFeko42s6I4Ip1o0cXIDGt9YDaRcyXmUNXXrpnTERv2NBXOj+fylLBz0gEfeKLvGN6auMw2WPZAc9YTNX0r6fiWiQXP/Ywj0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqA-eeD_1760410608 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 10:56:48 +0800
Message-ID: <1760410511.4877663-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 0/3] fixes two virtio-net related bugs.
Date: Tue, 14 Oct 2025 10:55:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
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
 <20251013035059-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251013035059-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 13 Oct 2025 03:56:35 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Oct 13, 2025 at 10:06:26AM +0800, Xuan Zhuo wrote:
> > As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzhuo@linux.alibaba.com
> > Commit #1 Move the flags into the existing if condition; the issue is that it introduces a
> > small amount of code duplication.
>
>
> How were commits 1 and 2 tested?


These two are not troublesome. I tested #1 in big mode. #2 has no special
requirements. I tested it on qemu and observed the hdr len.

Thanks.


>
>
> > Commit #3 is new to fix the hdr len in tunnel gso feature.
> >
> > Hi @Paolo Abenchi,
> > Could you please test commit #3? I don't have a suitable test environment, as
> > QEMU doesn't currently support the tunnel GSO feature.
> >
> > Thanks.
>
>
> AFAIK host_tunnel and guest_tunnel flags enable exactly that.
>
>
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
>

