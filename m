Return-Path: <netdev+bounces-82764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DA988F9FF
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 09:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBB31C230FE
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5585548F8;
	Thu, 28 Mar 2024 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pPEP70On"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366F26AD8
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614435; cv=none; b=R+QgCxZ3JU5MYJ23cdHIpt/e52/ujcM/VEmZvyb41pPjLoyBfR7n668JBAc79+9s+lOpITz5dSO/OQap/CQPJhlrFxu55sI0aOZfKTirWHQvbfGtZoTFAZQZvnMQq2Cb7dxVXbBVCfOjSkxGjEA9hdlX95bq9NdAhG8HKq3U9to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614435; c=relaxed/simple;
	bh=154NNC38xSFg55WCV2iA+69UZou8k05HbUXMIxiDnu0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=C2sf+d5RqHLigLj0N+NT5LqDJqfEVKv1Wv196xfRAMPPGIbImc72h1EgPDRMtbogVJ7l/qF4WBTeHl819E7oSY1Fp1uWkRemkENjK/zn9N3inZ+PcenErqJhTx5TmmrZTQvRGpm5AEA0iIMaZzhIGJiP1q8jipUQJcpU4aS/QvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pPEP70On; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711614431; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=154NNC38xSFg55WCV2iA+69UZou8k05HbUXMIxiDnu0=;
	b=pPEP70OnQKU4dlBqSHUPm6dv74O3YT+7fbtF7MHtqeM+qtCjsrn7nmhGdhW89Lv0cVtbpSPROeD/oOTLyWoABWUEIAEfBqIXX9de3tjFsL56JXvKMGjK4FhjQBfbUtQLaSY5VTIa8Y5KyyZVWb7A7+77tLVLOpK7+QHc8CmaEGE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3SeOCW_1711614430;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3SeOCW_1711614430)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 16:27:10 +0800
Message-ID: <1711614157.5913072-7-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
Date: Thu, 28 Mar 2024 16:22:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-10-xuanzhuo@linux.alibaba.com>
 <CACGkMEs=NZGkkA7ye0wY7YcPBPfbKkYq84KCRX1gS0e=bZDX-w@mail.gmail.com>
In-Reply-To: <CACGkMEs=NZGkkA7ye0wY7YcPBPfbKkYq84KCRX1gS0e=bZDX-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 28 Mar 2024 16:05:02 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Now, the virtio core can set the premapped mode by find_vqs().
> > If the premapped can be enabled, the dma array will not be
> > allocated. So virtio-net use the api of find_vqs to enable the
> > premapped.
> >
> > Judge the premapped mode by the vq->premapped instead of saving
> > local variable.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
>
> I wonder what's the reason to keep a fallback when premapped is not enabl=
ed?

Rethink this.

I think you are right. We can remove the fallback.

Because we have the virtio dma apis that wrap all the cases.
So I will remove the fallback from the virtio-net in next version.

But we still need to export the premapped to the drivers.
Because we can enable the AF_XDP only when premapped is true.

Thanks


>
> Thanks
>

