Return-Path: <netdev+bounces-194231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A267AC7FAE
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9123A4136
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E321B191;
	Thu, 29 May 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpmlCnLo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745AB21ADDB
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748528915; cv=none; b=XR6wAqdROXHnHSZUSvSPabuAoUOcSLVakPxTuWzNbO/iU4XBOqoMvUgw7HF+zT4otCq1Fs1aa1kJFaQRxwProEExObeRNRCrvZZga3zsC2qxSLtOoF9VzOG/QiLzwGOiu3goPV4FfTLYcHQ3Id01TrA7cfsuL5NqXqyIos/A6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748528915; c=relaxed/simple;
	bh=7tFNgqY0EgruMolSX7eCoL76YsjOjK1NedaoVhFcJd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbdafgriuhrxF2U7v/nanO/KRAjQbIUcn/VdhtSOuUgKnU6c2jcOz21Hy9aEQsx4XYj7WZYokaUbWIalpXSJcISX+QoEy9mEDFC4Cb72k0qWeb1LfYx7jLpxoKw9Ry+cO0FyVMvRI/xsBVZSQLoQdK4ZYs/mZobmWV992KfCPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpmlCnLo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748528908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZdaZgonX5xT1srqXdl0K1LqCVycbW/hlNqHVqqzSqg=;
	b=MpmlCnLoNsBcj9xLa4FFFXWHUfeotLhTVUWjI8QFnW0CGFdLDpm4nTmbR2oKDsd1teFXDf
	fQx10MV/8OoWUT51VQf3/3da3W81zVOEQ2T8k6EvfYwbpHiFa/zQHQ/PwmOr00U3w83k1g
	QCZVOMIt2cA4ECUO31TwKNa5/w0iFho=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-cV1ceolhMY2O1eIkN-ReSg-1; Thu, 29 May 2025 10:28:27 -0400
X-MC-Unique: cV1ceolhMY2O1eIkN-ReSg-1
X-Mimecast-MFC-AGG-ID: cV1ceolhMY2O1eIkN-ReSg_1748528906
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442f4a3851fso8945325e9.1
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 07:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748528906; x=1749133706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZdaZgonX5xT1srqXdl0K1LqCVycbW/hlNqHVqqzSqg=;
        b=MCIFOGwztHIyUpVsgEqHxYB8EdQnNKcU+IkDGR8Bg0lo8GgA4p3kkyPMEY/81VKs7+
         rsQycZWPc45kccU2GpgY7ahToo33aTNCecX34oWv0rTWrwz9kpBkV6fEZz4fJPSr7rgm
         LZN8lmOlqL2CUXAP0f2ylnlJGbMDRMY+f2Ajd/tNxWB6tU5Ey1on+75AJ8o08v/laT/3
         6r2yL5L7KmJ5i5rKkWxvRMBBYeC7IyPNjiCT93QGi/tlFDViT1/Km5wTy/PVBhM+h0oN
         l4UMdy5jAZBNhv/TO3uGJTJzp4x1xAE0fqBZdksS1Q3ORQ0rs5YWbIlMF0RAznpF/qwl
         Vkhg==
X-Forwarded-Encrypted: i=1; AJvYcCVE8E5bja51CPUeAaSMha9iypsoEDtvhUJQvK0OmEKLRgHW4BuwimO7c5uLuH1TmNl/YRqHUas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQcoolAZrua63YT4Lpl8lGN6Ebc2+Ki9lykAjh9blsS/z5w2jo
	LQvV6PEGwul0WVexJSX+mBlWB/uF+4nBoq7SDgOfzBHxyP/gFDZ9M7Ba7k2+NJWU9xHLusmFAUM
	cU1z6JyCcmbfqcu1kG9ykiHzd2FInGLyP8Aac15n9sXKSYdu/tCt3fTkobQ==
X-Gm-Gg: ASbGncvzseWTnIlnWU9ZlUkYcCfGUKODXxl0IaS+tFWJ9xouttac+BEhSxxEY47TYiV
	5j6r09NB2/lh7EYxifwJp0ii7+kmAsCE6ASf1HylaGT3YKJxu5t6/5SFRfv8KL5SQodV0S+b2Fc
	oqpND11A2HSycG2Xlcw6OV5BsF3k0xi6uqx4ToXzB2V7c6ZAsvqD+UNuNsQIHtHxQPx8eGuBtat
	BddLXKLzB1WhZyDxmSKsNvgtsCmFdx93qir17oT3VetXsdDWhiiX4zjRAuR6bHmkc4K6lqQr3Sk
	KY3N4w==
X-Received: by 2002:a7b:c7c7:0:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-450cabdb586mr42378845e9.29.1748528906384;
        Thu, 29 May 2025 07:28:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9sv6Utf82CNJhYCS4Dd2QIfkBFbUbbknPz8CmPxaotD8VbmCmUBy7+SmkY/vqIXAcZ299Sg==
X-Received: by 2002:a7b:c7c7:0:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-450cabdb586mr42378685e9.29.1748528905934;
        Thu, 29 May 2025 07:28:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d620c544sm878765e9.2.2025.05.29.07.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 07:28:25 -0700 (PDT)
Date: Thu, 29 May 2025 10:28:22 -0400
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
Message-ID: <20250529102623-mutt-send-email-mst@kernel.org>
References: <cover.1747822866.git.pabeni@redhat.com>
 <f85bc2d08dfd1a686b1cd102977f615aa07b3190.1747822866.git.pabeni@redhat.com>
 <CACGkMEv=XnqKDXCEitEOs-AL1g=H=7WiHEaHrMUN-RfKN1JCRg@mail.gmail.com>
 <53242a04-ef11-4d5b-9c7e-7a34f7ad4274@redhat.com>
 <CACGkMEtZZbN8vj-V-PSwAmQKCP=gDN5sDz4TOXcOhNXGPLp_yQ@mail.gmail.com>
 <3d5c65e0-d458-4a56-8c93-c0b5d37420b5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d5c65e0-d458-4a56-8c93-c0b5d37420b5@redhat.com>

On Wed, May 28, 2025 at 06:02:43PM +0200, Paolo Abeni wrote:
> On 5/27/25 5:04 AM, Jason Wang wrote:
> > On Mon, May 26, 2025 at 6:53 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >> On 5/26/25 2:49 AM, Jason Wang wrote:
> >>> On Wed, May 21, 2025 at 6:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >>>>
> >>>> The virtio specifications allows for up to 128 bits for the
> >>>> device features. Soon we are going to use some of the 'extended'
> >>>> bits features (above 64) for the virtio_net driver.
> >>>>
> >>>> Extend the virtio pci modern driver to support configuring the full
> >>>> virtio features range, replacing the unrolled loops reading and
> >>>> writing the features space with explicit one bounded to the actual
> >>>> features space size in word.
> >>>>
> >>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >>>> ---
> >>>>  drivers/virtio/virtio_pci_modern_dev.c | 39 +++++++++++++++++---------
> >>>>  1 file changed, 25 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> >>>> index 1d34655f6b658..e3025b6fa8540 100644
> >>>> --- a/drivers/virtio/virtio_pci_modern_dev.c
> >>>> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> >>>> @@ -396,12 +396,16 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
> >>>>  virtio_features_t vp_modern_get_features(struct virtio_pci_modern_device *mdev)
> >>>>  {
> >>>>         struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> >>>> -       virtio_features_t features;
> >>>> +       virtio_features_t features = 0;
> >>>> +       int i;
> >>>>
> >>>> -       vp_iowrite32(0, &cfg->device_feature_select);
> >>>> -       features = vp_ioread32(&cfg->device_feature);
> >>>> -       vp_iowrite32(1, &cfg->device_feature_select);
> >>>> -       features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
> >>>> +       for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
> >>>> +               virtio_features_t cur;
> >>>> +
> >>>> +               vp_iowrite32(i, &cfg->device_feature_select);
> >>>> +               cur = vp_ioread32(&cfg->device_feature);
> >>>> +               features |= cur << (32 * i);
> >>>> +       }
> >>>
> >>> No matter if we decide to go with 128bit or not. I think at the lower
> >>> layer like this, it's time to allow arbitrary length of the features
> >>> as the spec supports.
> >>
> >> Is that useful if the vhost interface is not going to support it?
> > 
> > I think so, as there are hardware virtio devices that can benefit from this.
> 
> Let me look at the question from another perspective. Let's suppose that
> the virtio device supports an arbitrary wide features space, and the
> uAPI allows passing to/from the kernel an arbitrary high number of features.
> 
> How could the kernel stop the above loop? AFAICS the virtio spec does
> not define any way to detect the end of the features space. An arbitrary
> bound is actually needed.

Well, no. Let me explain.

Only the features that are negotiated matter.

Thus, as long as the driver only knows how to handle the low 128 bits,
it has no reason at all to ever look at other bits.
Not read them, nor write them, nor store them.

Hope that helps.








> If 128 looks too low (why?) it can be raised to say 256 (why?). But
> AFAICS the only visible effect would be slower configuration due to
> larger number of unneeded I/O operations.
> 
> /P


