Return-Path: <netdev+bounces-194232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF1BAC7FB0
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3DA27A428C
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FF721B9F0;
	Thu, 29 May 2025 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyZ2Sesc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D7D1DC99C
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748528943; cv=none; b=VgESIB1QOI7Uc7DfH/+zMM6oT0TQmDMMkjPoX2p2yFkMgUMmdrwbsHkHbrpPNyhMZwixgAqWteCAgEwi4CtovEwoYpHqqlZ3VT7OJyJJ7Ja7ZN6YcoKqR5qml2eCjA5UiwoOrU+AQKSMRQabkgmdnLNu0FywjjuS7E+qbl6YgFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748528943; c=relaxed/simple;
	bh=5UV9jbJVsLeWqvVsJzcYYdHSp8793JCw3qBnNgCl7j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JW4oejtfaW+5GZZPplb4p2naonWAriz8dk/fYpn0yJ1tj78UzxqWxn9ziiNZBZcnhvVYtpKvbSdkLkinilZ79LVTpswg434QwhSCi4dgUbnpv/euRTKwPBaIMaFobMFdzbJu/FSl5Xx5JwGjkznE4O+HN3jUBsh/mTxR4dKufdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyZ2Sesc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748528940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/41Wm2DzLkUpZsgGtzlfHzGC7DR83qMjDoiHBoLIaPc=;
	b=IyZ2SescE61QezshXz8jxxY1y255pnmfK4FPlVtUW10xJkZvxS7j8pJrnDPd1N7fqCng0v
	nxI3qfXODo/5biayAzsiEs3DON2+iP7EF5q4COWOwDHnNYlBftkrV0KuPmVwRcTM4Z0Hdl
	C59P41CDxT1kmNLN7OULFT07EGScjI8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-eZ9AKEnHNgaXtxAa5MomuA-1; Thu, 29 May 2025 10:28:57 -0400
X-MC-Unique: eZ9AKEnHNgaXtxAa5MomuA-1
X-Mimecast-MFC-AGG-ID: eZ9AKEnHNgaXtxAa5MomuA_1748528936
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43efa869b19so8678455e9.2
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 07:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748528936; x=1749133736;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/41Wm2DzLkUpZsgGtzlfHzGC7DR83qMjDoiHBoLIaPc=;
        b=KZi77xBqef1iu79ju5MSrHuIy8mgF5pSIOnsGGiyUPsp1a6rbIMMlYvB+Fpzv5IEba
         d9bxxiKO2a3/gEPhLqcmYClL/47lg2CaOIUuvs21SLVXDCILlaxjGx84E/lVmdw8jpkY
         U9PrDBVDMlp/ccO0RF+tBKU2xHb70XCJEMFmlb4RG8IsGv61mtUZjPTOx4ZEx9Ln/MYj
         QldN45cJnqUzt/Y1IaGjVl4MkeNFyvtDAWQiBCDMe8hPC0bX4kpo6y37DqUaVmODQ0/1
         E9BBRUG5Bew8OYNfpmfr5O+xoj4bnkoESgQ2clMrBIKl1t2dM0mGoelyEbXkNbnw+Ait
         JVeA==
X-Forwarded-Encrypted: i=1; AJvYcCWh8lujRrD6HWxeaKutrRW8isSUKvyMaNr8/xIW5QNhxdf8NZPXHGNpzH515k0Hks9jXxiOZ+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBC/IzFMq7uhSdSlYcOYUlR0qLqJ9Vv2n54Z+Tp5fkFUMV4Ee
	zZSUtIE1auuUILZpQurneu5ktpyUIQ10jS2CDRKpi8uBUc3k6gFiPL/c5/zHaU434BDGmBhwivs
	sAEptVhpVJAuyFzqq9suF1fuHq3ld8P9t6x+oEBtp2xR6lAlsO/JCkwqrsw==
X-Gm-Gg: ASbGncu2t87HCClW3JT8W4AEnl93QzdUWMg18kBqc0ZcSn03f2ASdcEG7PMzmPMHwJg
	+iuOqoMmLEYh7Gs2AFEkwB21bMOb/p8z9I0hwToXPiEzusjDzCPyatmbYjnGkSEMEcqGKxQiY1e
	EZvICJWg8AavEDA6vA9tVHINgMOmDtpgPb1Wy9sjqn78fvVK7yJUvj4Ot2OYmf6kv54ZqjHeOgN
	wIOi2ikbj+PlkNywx1xgl37bmbj6EkikXBJ2gfIMb1JbBV/m8pEnytd7FB3mWDdCQSvyKgWSD4o
	sPi1CA==
X-Received: by 2002:a05:600c:1d07:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-44c93da6158mr163881925e9.5.1748528935643;
        Thu, 29 May 2025 07:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZclBFU4TgVYDwxYQ5+HxmMCjQfOKor0eAjS8j5ZYquz6b6PxmlErRbxnZdD3KtyDXB+7kXA==
X-Received: by 2002:a05:600c:1d07:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-44c93da6158mr163881705e9.5.1748528935243;
        Thu, 29 May 2025 07:28:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44fcbd61553sm71966565e9.0.2025.05.29.07.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 07:28:54 -0700 (PDT)
Date: Thu, 29 May 2025 10:28:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net-next 2/8] virtio_pci_modern: allow setting
 configuring extended features
Message-ID: <20250529102840-mutt-send-email-mst@kernel.org>
References: <cover.1747822866.git.pabeni@redhat.com>
 <f85bc2d08dfd1a686b1cd102977f615aa07b3190.1747822866.git.pabeni@redhat.com>
 <CACGkMEv=XnqKDXCEitEOs-AL1g=H=7WiHEaHrMUN-RfKN1JCRg@mail.gmail.com>
 <53242a04-ef11-4d5b-9c7e-7a34f7ad4274@redhat.com>
 <CACGkMEtZZbN8vj-V-PSwAmQKCP=gDN5sDz4TOXcOhNXGPLp_yQ@mail.gmail.com>
 <3d5c65e0-d458-4a56-8c93-c0b5d37420b5@redhat.com>
 <CACGkMEuBrzozRYqrgu8pM-+Ke2-NhCbFRHr8NeVpP15Qo0RZGg@mail.gmail.com>
 <f0a36685-45d0-4c4a-a256-74f3d4a31bd5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0a36685-45d0-4c4a-a256-74f3d4a31bd5@redhat.com>

On Thu, May 29, 2025 at 01:07:30PM +0200, Paolo Abeni wrote:
> On 5/29/25 4:22 AM, Jason Wang wrote:
> > On Thu, May 29, 2025 at 12:02 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >> On 5/27/25 5:04 AM, Jason Wang wrote:
> >>> On Mon, May 26, 2025 at 6:53 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >>>> On 5/26/25 2:49 AM, Jason Wang wrote:
> >>>>> On Wed, May 21, 2025 at 6:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >>>>>>
> >>>>>> The virtio specifications allows for up to 128 bits for the
> >>>>>> device features. Soon we are going to use some of the 'extended'
> >>>>>> bits features (above 64) for the virtio_net driver.
> >>>>>>
> >>>>>> Extend the virtio pci modern driver to support configuring the full
> >>>>>> virtio features range, replacing the unrolled loops reading and
> >>>>>> writing the features space with explicit one bounded to the actual
> >>>>>> features space size in word.
> >>>>>>
> >>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >>>>>> ---
> >>>>>>  drivers/virtio/virtio_pci_modern_dev.c | 39 +++++++++++++++++---------
> >>>>>>  1 file changed, 25 insertions(+), 14 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> >>>>>> index 1d34655f6b658..e3025b6fa8540 100644
> >>>>>> --- a/drivers/virtio/virtio_pci_modern_dev.c
> >>>>>> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> >>>>>> @@ -396,12 +396,16 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
> >>>>>>  virtio_features_t vp_modern_get_features(struct virtio_pci_modern_device *mdev)
> >>>>>>  {
> >>>>>>         struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> >>>>>> -       virtio_features_t features;
> >>>>>> +       virtio_features_t features = 0;
> >>>>>> +       int i;
> >>>>>>
> >>>>>> -       vp_iowrite32(0, &cfg->device_feature_select);
> >>>>>> -       features = vp_ioread32(&cfg->device_feature);
> >>>>>> -       vp_iowrite32(1, &cfg->device_feature_select);
> >>>>>> -       features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
> >>>>>> +       for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
> >>>>>> +               virtio_features_t cur;
> >>>>>> +
> >>>>>> +               vp_iowrite32(i, &cfg->device_feature_select);
> >>>>>> +               cur = vp_ioread32(&cfg->device_feature);
> >>>>>> +               features |= cur << (32 * i);
> >>>>>> +       }
> >>>>>
> >>>>> No matter if we decide to go with 128bit or not. I think at the lower
> >>>>> layer like this, it's time to allow arbitrary length of the features
> >>>>> as the spec supports.
> >>>>
> >>>> Is that useful if the vhost interface is not going to support it?
> >>>
> >>> I think so, as there are hardware virtio devices that can benefit from this.
> >>
> >> Let me look at the question from another perspective. Let's suppose that
> >> the virtio device supports an arbitrary wide features space, and the
> >> uAPI allows passing to/from the kernel an arbitrary high number of features.
> >>
> >> How could the kernel stop the above loop? AFAICS the virtio spec does
> >> not define any way to detect the end of the features space. An arbitrary
> >> bound is actually needed.
> > 
> > I think this is a good question ad we have something that could work:
> > 
> > 1) current driver has drv->feature_table_size, so the driver knows
> > it's meaningless to read above the size
> > 
> > and
> > 
> > 2) we can extend the spec, e.g add a transport specific field to let
> > the driver to know the feature size
> 
> So I guess we can postpone any additional change here until we have some
> spec in place, right?
> 
> /P

Agree on this.


