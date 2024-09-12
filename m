Return-Path: <netdev+bounces-127720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2C976392
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BB01C2295B
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 07:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D960618E34A;
	Thu, 12 Sep 2024 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d17qf5CS"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177018890E;
	Thu, 12 Sep 2024 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127722; cv=none; b=Azc2sE/GCek+Wt1pCRZ7lbzpiFYSDPga/Gn34vo9iweF4EAHXJXOMRJmY3hYAw25VigxQouJwNnqLkUJVm/bUD3QNguCJTgiNstohuHJxb0g8cVXj4hLaZVAZhx/rUiZB3T0fK+Tab+9cp6+93thRuUsqybZPvkRtWxGdJkq8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127722; c=relaxed/simple;
	bh=Ol4RgDCqfyCL2pjBfkerhT1NyawG2bk1MRZt+jEbZ74=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=s0WYyCsIdHwJCsW9B2joLsUHkU1S9YiWpCfTTxaxg1lxx0A4NFvHgWdD9pnpjsRDsVDgEal5QX0EWxdPdTwSZecD/IBO9Fekx8qzasLm15Vg7QNoQacuqY+0r0IK0KkkcZO3mwhLnSB0/v1duTB8jnFcbLY3OcNKkJs60s03tZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d17qf5CS; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726127718; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=Ol4RgDCqfyCL2pjBfkerhT1NyawG2bk1MRZt+jEbZ74=;
	b=d17qf5CSI1ZzdU0c9cntbsoTuKa2CZUwbc6QwUhLQOgcXO8u2BVOtBwDXfIvO/VFwlhXXSF4oKRXjlrAtJ7nwOp/mPkYOTJPTf5dL1VOtzzGpRD/hxJcg2N50mD4X33ybUoSJRWHfkm5rHKC8Txtd8wd6nVaaDBqx8fhC5mwsHI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEqdABG_1726127717)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 15:55:18 +0800
Message-ID: <1726127706.8637953-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 11/13] virtio_net: xsk: tx: handle the transmitted xsk buffer
Date: Thu, 12 Sep 2024 15:55:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-12-xuanzhuo@linux.alibaba.com>
 <CACGkMEvvKsypiOmdhWKjNhXJ9fS5SVYQFzK=KtTr1DdyMOv8mw@mail.gmail.com>
In-Reply-To: <CACGkMEvvKsypiOmdhWKjNhXJ9fS5SVYQFzK=KtTr1DdyMOv8mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 11 Sep 2024 12:32:54 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Aug 20, 2024 at 3:34=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
> > buffer) by the last bits of the pointer.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> I suggest squashing this into the previous patch which looks more
> logical and complete.

OK.

Thanks.

>
> Thanks
>
>

