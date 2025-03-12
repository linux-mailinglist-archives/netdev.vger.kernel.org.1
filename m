Return-Path: <netdev+bounces-174249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7DDA5DFDA
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529501891B62
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5916C2505D0;
	Wed, 12 Mar 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHRcZPLN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B424E00B
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792287; cv=none; b=hrQUOiHLp1Rf8Qr48Ck33DbKKlKm6e0kSYb/6TXIquIkUA1zQbZVjt40HACR7UyPQmno5WUhzZjhU0mQkzH9w7RweA7d57p9oaMEKp2YLtBU/qPNGEizIJ+vtQB9IlxYv2pDrYGHOe6RxQtz37zprHIpHVZRXEaOm2j54AIbXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792287; c=relaxed/simple;
	bh=ztlmegBzBKs8vJ1Sj3J75o5jqxXX3n3n98UKsP0n/bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN2zLcjMYSTT8dy3uX1nLCci0kEah6yyULlmGqayr7QQplL7EVlozXFluLNuh381x4aTCpAynvbH92jCzfv+2rX7n+HVLn9tCNyy7lzsgVxF7/x67LmDcQg2pnSJkMYBorqO04RKqMdy8c8Kr8d8juzj+YeoCcnFqBqewAnHUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHRcZPLN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741792284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3wvkUF9pbg03+vUjzzWddDimlNCCehc9tv57CFp/bk=;
	b=cHRcZPLNtv9E3ou3E/M/UVZ5jfawT54zag5dQZ3d1flStogsf3w4BbhuTJQSsMmEegVPF5
	0IJ00g4MhsWrtnTqK7uVy57UWBXOxU8qbzJ6CaGojOTzbmd46qSdqg4Eabk58o/OOR9Idq
	ACv/CLV/uzo2f0bQpO2kh+4Gm38hqNI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612--_-OP6m4OVy3wwiOT-wXMA-1; Wed, 12 Mar 2025 11:11:23 -0400
X-MC-Unique: -_-OP6m4OVy3wwiOT-wXMA-1
X-Mimecast-MFC-AGG-ID: -_-OP6m4OVy3wwiOT-wXMA_1741792282
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438da39bb69so48311895e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 08:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792282; x=1742397082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3wvkUF9pbg03+vUjzzWddDimlNCCehc9tv57CFp/bk=;
        b=ADJXXNawMYXrB1B/+2BkWEyxzAoqJYjPjs7eoClhdkKBvJqRhqLGF7Kz/fi9FD25Ef
         CNfGVujznyfyhBEoX2ebojTbcDrtrewbgBKE0Mfk4WJnnJfzJwuzovtJcfcGqIvOxZLf
         pwxcmo4AWmxo4XF3xjEIv/RgHljweaFUOy+nJ2HCJX3C6Z704dra7YQBsoXugWR+bh6V
         KRdmpIDQ1mnlHuT4iTGcMWwsPj8eJGUmol2NgXvjyQRIYbGo2skeIQ/0w530ibt7hDUB
         FhhYg8K6f84nzUOYAeQ+TB+hE4BSDdBhJKkzlDCBKKZ0jZoVbJU8sgqHWuYHwdhlhk3r
         dMkA==
X-Forwarded-Encrypted: i=1; AJvYcCX2jjFmz9uzWgjpebch8eGVm9CezCAj78km62XrPJsBQgth7/Jbj3ob4s0iSzYVjHV+GWfAvl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9lbNzwTdYA1tgX76fFcXR0nznj28ho701GqnIO3QZ2rg90rS
	30Kw1aWe/ESMgCTnsMGlZaL9wGsJhpymC7ybhBVYLolPicWY0VgOtEeM6ctR89f8OTtDO05VOzo
	i7GWVjh6DTig9ajTZZ7nfnjaOoL6Zw1sVA/s32j+s5gqwypc3SPbwbw==
X-Gm-Gg: ASbGnctdxFmTmP0DpZyFqT+4XWGuRjqwWOwjZdy3r1BKxmMZU2unDpNC4N5x5felRcH
	Ta7UB62ytS+oYOAQx1zUN8eJf3K4toyTERrnZETsXe+2ufT1kI7deJmGbmms1lotcy45UA5CsO+
	pBMAJLGYVt5cB3BSKXg33lciGjrdBBYhceqlTO5JE43SOYRDaJ56sDpF6mGisVCCmussSnA4dx9
	mOCi6wSe1crxg3xw6So4IwezWvr/rkSfTTjNhkXyKY5CRInWIOvHlr8VSf9a45lMTj7L+WYOLyB
	jBivhB/1Mw==
X-Received: by 2002:a05:600c:1c0f:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-43d0ac51609mr16259715e9.21.1741792282002;
        Wed, 12 Mar 2025 08:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5W/D3ES/M6kJRPjyEgSuPr9XA1jcGO11zxvnqEpd0Ho/mZnkNgRao4/TRivG1z/At8axlrA==
X-Received: by 2002:a05:600c:1c0f:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-43d0ac51609mr16259465e9.21.1741792281627;
        Wed, 12 Mar 2025 08:11:21 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba686sm21749973f8f.19.2025.03.12.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:11:21 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:11:19 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Harald Mommer <harald.mommer@opensynergy.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <Z9GkFxPQ54Jzn45f@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
 <Z9FicA7bHAYZWJAb@fedora>
 <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
 <Z9GL6o01fuhTbHWO@fedora>
 <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>

On Wed, Mar 12, 2025 at 02:36:05PM +0100, Marc Kleine-Budde wrote:
> On 12.03.2025 14:28:10, Matias Ezequiel Vara Larsen wrote:
> > On Wed, Mar 12, 2025 at 11:41:26AM +0100, Marc Kleine-Budde wrote:
> > > On 12.03.2025 11:31:12, Matias Ezequiel Vara Larsen wrote:
> > > > On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> > > > > Hello,
> > > > > 
> > > > > I thought there would be some more comments coming and I could address
> > > > > everything in one chunk. Not the case, besides your comments silence.
> > > > > 
> > > > > On 08.01.24 20:34, Christophe JAILLET wrote:
> > > > > > 
> > > > > > Hi,
> > > > > > a few nits below, should there be a v6.
> > > > > > 
> > > > > 
> > > > > I'm sure there will be but not so soon. Probably after acceptance of the
> > > > > virtio CAN specification or after change requests to the specification are
> > > > > received and the driver has to be adapted to an updated draft.
> > > > > 
> > > > What is the status of this series?
> > > 
> > > There has been no movement from the Linux side. The patch series is
> > > quite extensive. To get this mainline, we need not only a proper Linux
> > > CAN driver, but also a proper VirtIO specification. 
> > 
> > Thanks for your answer. AFAIK the spec has been merged (see
> > https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4). 
> 
> Yes, the spec was merged. I think it was written with a specific
> use-case (IIRC: automotive, Linux on-top of a specific hypervisor) in
> mind, in Linux we have other use cases that might not be covered.

What use-case you have in Linux?

> 
> > > This whole project is too big for me to do it as a collaborative
> > > effort.
> > 
> > What do you mean?
> 
> I mean the driver is too big to review on a non-paid community based
> effort.
> 
I think I can help reviewing it. I will try to spend some time in the next
weeks.

Matias


