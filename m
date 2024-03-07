Return-Path: <netdev+bounces-78323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53730874B1E
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C501F2B514
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05E84A39;
	Thu,  7 Mar 2024 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fsAE79VR"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5B77F32
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804437; cv=none; b=Kkhu98ddFSz2Zo6Qq+itgPgl7buejV8ctxvZAXCWY35SgdUq4XiFg22VHaEv0KHpmelOkOpyqRAphGPpE8SzgOPzbiefVDQsMsr8dxqS9D2dXUZ8ULfKsebHajwDZA46j/JWwy0M+L4VYeWKNXJP3+N7tlVkzA0EtlnyePXvwXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804437; c=relaxed/simple;
	bh=sE2MgIluro/5GG8b2oMEEjpgLO/QMcuGU+5yLQuJPq8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=mrcszRZ8AL/deVGmnkxfKWb7ATsQLl716VyZiUTIXEQ5BQL5l2yQvTRWk9CWRjXBmBsuqVbxviYMxmpTOawqLZpwhB/5in+u6rDEm9U++mResmZzkVx6cxhc2WaSuUcWrFb/MX4pWmxdH0+SxiujKyL6Ui9ZRBdZxhFM+EdCtn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fsAE79VR; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709804432; h=Message-ID:Subject:Date:From:To;
	bh=sE2MgIluro/5GG8b2oMEEjpgLO/QMcuGU+5yLQuJPq8=;
	b=fsAE79VR36K0L4zrdqI6ta6nXz1OZ95uOjZCWNgACUcrqrFA6A9luiUQAJLUjA/j+Koo5sedxDHsXEqSqDKrkTvutaBHxh3XsftT9W1BsyDb3dbus3f/oFH+xHhsXwOLNSm6gu62+4Svautba7Wj+mKHXKs70OL+kyJbQVzZ7Qg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W2-KXx8_1709804430;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2-KXx8_1709804430)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 17:40:31 +0800
Message-ID: <1709804195.5639746-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 5/6] virtio_net: add the total stats field
Date: Thu, 7 Mar 2024 17:36:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason  Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric  Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-6-xuanzhuo@linux.alibaba.com>
 <20240227065424.2548eccd@kernel.org>
In-Reply-To: <20240227065424.2548eccd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 27 Feb 2024 06:54:24 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 27 Feb 2024 16:03:02 +0800 Xuan Zhuo wrote:
> > Now, we just show the stats of every queue.
> >
> > But for the user, the total values of every stat may are valuable.
>
> Please wait for this API to get merged:
> https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
> A lot of the stats you're adding here can go into the new API.
> More drivers can report things like number of LSO / GRO packets.


In this patch set, I just see two for tx, three for rx.
And what stats do you want to put into this API?

And on the other side, how should we judge whether a stat is placed in this api
or the interface of ethtool -S?

Thanks.

