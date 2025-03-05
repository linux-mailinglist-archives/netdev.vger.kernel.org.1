Return-Path: <netdev+bounces-172135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367D9A5050A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26BF16680E
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EDA157A6C;
	Wed,  5 Mar 2025 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AP3SOuko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14E82E336E
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192486; cv=none; b=pdGMNL4nIomT4AdNXHnw9tTc/47OeygsBXPglr41N7KxRMKOP+CB5LIyPs2ZidUuIpLsIcrUqtQt+bVWUl41HLZuEseEu9CwFoU7DVjqavaniubszpfyTz3CBEApU3t1uCO8B+I2hLPUIFIXABIhONzJWmWeGn9Zm3EvZ3ntOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192486; c=relaxed/simple;
	bh=F16pw37MzKbIYdgjWhyi5x7YhfEMC6EULpZEwLqrfZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDW7DnXoRIEkHOyfWIvOQu/VasIFytaelVC3GNv1MAvwpmzg7z4RamqpoUxJjZkqgc5FUzGgJyszExRCsmKKh9t9zs30jI8Gnle81Fi3uak8Y8KE3s6nTPXQ4xIY/2D9vqkXbT4tcVe+Z3EY2lIVMCUVQ/FFI2qcJbiJlXIVBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AP3SOuko; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2238e884f72so77051395ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741192484; x=1741797284; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oj8IVT+RqMLY39cee6JwSmbfQ9wBQwtZAQ90NgyAiPk=;
        b=AP3SOukoZMkUK35fZRglHU9Im/hlJ1nhytXEFPHUjsvlq5lNBf+Chxv4+zBJFonekd
         1PrytuKvYYdR0zM+49Cxte8lpMl67OW5euDfXWQ2WVxKmujIGgZfjmSNJgCIySIfn8Ce
         7IsrnwTxKjnN8xTOu2t9lGmn2QvYvUKTa//ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192484; x=1741797284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oj8IVT+RqMLY39cee6JwSmbfQ9wBQwtZAQ90NgyAiPk=;
        b=vML5QWnLjVAqlg54+Do/a8Vlp8T6Jo3pL1GS8tKjbuGRu/1RMJZeeVHAkUP+OGuvcA
         nm+mCepebmprgrLwrIo6xM6DGfcsG+IB0gkvdR4sezI0hCaphOXS/rFGBKYIiSJU1Rp2
         wSrED9xJc8VswNZR7SYcVNfuTbNOwN1f/qvYsuw/0/Xy2wbUXFK5yUsOTl16zvp67CIw
         r1AXo8/OvTxsK+h3H5zB1lI+tKPi3Mh08mALr9t4WN7TJW/mZnAT6wSbMm8xs36ovh0Z
         /MqK155+ordltZ0lWJHeObTeMJRv82WH7TN8bMmP9f3uEN21/bkifNDvT06K/EwgIdBn
         VMKw==
X-Forwarded-Encrypted: i=1; AJvYcCWpOsJ2jdcnIExDHpu3vY8BtOlwfXQqYZ2pTv69L24O/UH9w//1itzkprXfxNlvIrXYB37zHT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaR51wm1/NqrThkUgMma+4OcF0Jkba+Oik9dYkYRPW5KU/tObC
	M8qXsNzTUDp2NUuy9FJqQTXq3jFo1/2CGGLPXCvMaDk2cDt1jJGt4lRUgE534n0=
X-Gm-Gg: ASbGnctgorLL+AAcGRLcNN5El3eslEQ4wdifK0N0UUdjRB3yhDEsB5auorZvFJDhUga
	P8G1d6FcEyJ0tjyMWaIg7ORbhjlnyptxnYgPSdjbgKuSJ8HO4Ndx+QvjOGbURAp90UYU47yV9nc
	O0H8I0W79FXFpq339wzx0zmx3LJWbgnstOB/MBZPTwcBU/Hx6w8suGeeIZlQn4kwwXyknB7bWCm
	qJLvqvgXC1Jope+0Q0tYSJ0NPeWYB9666Ab76vSo3LsvfdZFepowrygH3aGL4uuHf0pJ/oRUE2e
	rFgNh+LhflWOCj9t+vBOLl+ZEGHjZrc3o8/RDv27YKGgQ/mTblsk1QGuWYhoY7Uy6B1EDxYYrPy
	AL3J/B4qAUmE=
X-Google-Smtp-Source: AGHT+IEftC9eWQqraTxiAa+hjmeMT1GN59eEFcCvKCUxzOWXFqKmPKYERLKg+VujKszgU0HOvaMZMw==
X-Received: by 2002:a05:6a00:2e9f:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-73682c8c058mr6003956b3a.16.1741192484001;
        Wed, 05 Mar 2025 08:34:44 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734ec1da824sm11266744b3a.170.2025.03.05.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:34:43 -0800 (PST)
Date: Wed, 5 Mar 2025 08:34:40 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8h9IKvGh4z8h35Y@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com,
	mst@redhat.com, leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250227185017.206785-1-jdamato@fastly.com>
 <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org>
 <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
 <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
 <20250303160355.5f8d82d8@kernel.org>
 <Z8cXh43GJq2lolxE@LQ3V64L9R2>
 <CACGkMEug5+zjTjEiaUtvU6XtTe+tc7MEBaQSFbXG5YP_7tcPiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEug5+zjTjEiaUtvU6XtTe+tc7MEBaQSFbXG5YP_7tcPiQ@mail.gmail.com>

On Wed, Mar 05, 2025 at 01:11:55PM +0800, Jason Wang wrote:
> On Tue, Mar 4, 2025 at 11:09 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Mon, Mar 03, 2025 at 04:03:55PM -0800, Jakub Kicinski wrote:
> > > On Mon, 3 Mar 2025 13:33:10 -0500 Joe Damato wrote:

[...]

> > > Middle ground would be to do what you suggested above and just leave
> > > a well worded comment somewhere that will show up in diffs adding queue
> > > API support?
> >
> > Jason, Michael, et. al.:  what do you think ? I don't want to spin
> > up a v6 if you are opposed to proceeding this way. Please let me
> > know.
> >
> 
> Maybe, but need to make sure there's no use-after-free (etc.
> virtnet_close() has several callers).

Sorry, I think I am missing something. Can you say more?

I was asking: if I add the following diff below to patch 3, will
that be acceptable for you as a middle ground until a more idiomatic
implementation can be done ?

Since this diff leaves refill_work as it functioned before, it
avoids the problem Jakub pointed out and shouldn't introduce any
bugs since refill_work isn't changing from the original
implementation ?

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 76dcd65ec0f2..d6c8fe670005 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2883,15 +2883,9 @@ static void refill_work(struct work_struct *work)
        for (i = 0; i < vi->curr_queue_pairs; i++) {
                struct receive_queue *rq = &vi->rq[i];

-               rtnl_lock();
-               virtnet_napi_disable(rq);
-               rtnl_unlock();
-
+               napi_disable(&rq->napi);
                still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-
-               rtnl_lock();
-               virtnet_napi_enable(rq);
-               rtnl_unlock();
+               virtnet_napi_do_enable(rq->vq, &rq->napi);

                /* In theory, this can happen: if we don't get any buffers in
                 * we will *never* try to fill again.

