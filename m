Return-Path: <netdev+bounces-81865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A175D88B6E9
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9321F3AAB5
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED7D208A5;
	Tue, 26 Mar 2024 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V3q4iwt7"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16D1CFB2
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416840; cv=none; b=RAj5/LsPd4mV8DC4Sk5uKjpy/lX6KXZ11BJS36N7aMWmJGNNNpJMJdh+xWcgCIEWkOM819KDSy+lDhvf206meT+4vCIoqTF4NDSfjQoB6qqiTwLv8LaJtnP8w3Hg6gu3Oi6EvinkF66DMFisVBbhkt8WmcnyQn/EF1UJyYX5EVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416840; c=relaxed/simple;
	bh=BixFEykapZwVNVEYPFjYThzYjKiAkONn3vmz/qgv0gc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=vDyIlaHdJ/itxgFndCj+3Nqp7RU54X36xcSg+aBqe6wJaDP6ijReX6apAO8z/kvlZSfiMoCtrUYFW/4TJoeOovQ70nBylugb8nczxYWgtvK6YE/zJmXqm4FibpVV9K0VAbOZHemlV0jswtJqM1lEToN0PZptB6dr5FKwvRJD63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V3q4iwt7; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711416830; h=Message-ID:Subject:Date:From:To;
	bh=OtDyvDpEmkA9ncX8H7rdwsGH2Mc+/yUbMhqgfXQ4gjU=;
	b=V3q4iwt7tGGxfTOhepPhryVatpCz/qcwXINy5NL0UmLXitpFKxy1jFh3TYEQRV1//7aGwndXi3cCrhZybiEBgAkoRhD+//KD2NDzhMm6+6T//gh2IX9UKYblUrtb0Dv/ZvQT/HJJ3VOiJRRPe1iu7jr4O5scMPqCzInfaoiZx9w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3J8F6j_1711416828;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3J8F6j_1711416828)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 09:33:49 +0800
Message-ID: <1711416803.443376-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/4] Remove RTNL lock protection of CVQ
Date: Tue, 26 Mar 2024 09:33:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <mst@redhat.com>,
 <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>,
 <virtualization@lists.linux.dev>,
 <davem@davemloft.net>,
 <edumazet@google.com>,
 <kuba@kernel.org>,
 <pabeni@redhat.com>,
 <jiri@nvidia.com>,
 Daniel Jurgens <danielj@nvidia.com>,
 <netdev@vger.kernel.org>
References: <20240325214912.323749-1-danielj@nvidia.com>
In-Reply-To: <20240325214912.323749-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

For series:

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

On Mon, 25 Mar 2024 16:49:07 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> Currently the buffer used for control VQ commands is protected by the
> RTNL lock. Previously this wasn't a major concern because the control
> VQ was only used during device setup and user interaction. With the
> recent addition of dynamic interrupt moderation the control VQ may be
> used frequently during normal operation.
>
> This series removes the RNTL lock dependancy by introducing a spin lock
> to protect the control buffer and writing SGs to the control VQ.
>
> Daniel Jurgens (4):
>   virtio_net: Store RSS setting in virtnet_info
>   virtio_net: Remove command data from control_buf
>   virtio_net: Add a lock for the command VQ.
>   virtio_net: Remove rtnl lock protection of command buffers
>
>  drivers/net/virtio_net.c | 185 ++++++++++++++++++++++-----------------
>  1 file changed, 104 insertions(+), 81 deletions(-)
>
> --
> 2.42.0
>

