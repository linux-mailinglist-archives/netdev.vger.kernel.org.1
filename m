Return-Path: <netdev+bounces-163545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F12A2AA8D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A6F16852E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A801624F0;
	Thu,  6 Feb 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Egl7E3wA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3437E1EA7C6
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850494; cv=none; b=bCYh8xlyXpA/c2T19uOBRF0GFtTIKJoeavOEi95X0YqZR7nQDTLQQFOI658p9RwLXH9KqbGPFmL2GUjTJs5Vfy6hVTY1KTsxRIA24Egahz4gSHfipWIA0nTbf4780IgaGU6un+QeaP4L5JNEN+VzBgtknqMRli+RDnUJnYkRmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850494; c=relaxed/simple;
	bh=3zTlcWfoF37DhdYESayk6y+DiEbdCAjjpwW92uvqeLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fd+YxlLLjZrwB4eExtnguIYXcKKEYk70p3+ABXT2GpVInUXd9ioPrspgrOGShqiZCTxq6zz0RWax54rhQOJNu0QM+5zTOtjN5sRDQuLz2Za6cQ1YLlbYuJxztJGiTwMxEf35IXGb63iV0TytvGfgFn9TI5W7G3dHbuaXIds5g+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Egl7E3wA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f0444b478so13680995ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738850492; x=1739455292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zTlcWfoF37DhdYESayk6y+DiEbdCAjjpwW92uvqeLY=;
        b=Egl7E3wAod0G0GItvog6Dw+K//91uYGM35HEj0SR3YYP16NxteYciMiXu0rkg8DuJM
         il8m9R5ftCevNh7sKbvE4p5Oao/Ef/uJY1TQvAMDhd0MIdmgP52AsFZyMI9L7VB9/VV6
         haYh0ihzuQyAUwWnXdWYubS4a4Iul2khqLXJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738850492; x=1739455292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zTlcWfoF37DhdYESayk6y+DiEbdCAjjpwW92uvqeLY=;
        b=oT7DiuzWxgT6fUsLmw+vG68qe+Bi4atWPW+isq0ZGobAfa8lcoJSM7M0LtatM4fcnY
         +sl5SXddh3GFCxQD+RgWS/p8NvHoF+KuKZrc/mtJJkGwMAngoMSJcAWQs2WZjeZMGsLJ
         U77QC67/DAMNdMw0IIry385eALS4NUS79B48Y+dxhQJ8IOaxbzcYgMwbHxqhHTsPo4fm
         B6F24GngL6auU5iWS8+IDLCJXkroi3dy+0Gg7xCE8UsvCXnp2CPA8T8ZG7I+Vr21yVMA
         M0mTlDZGiIcBNCM8NebdsIUfvct13gBq+XjpfEbme/cGyAheu1AOO0ZCgZoEEqvHfyp/
         fdnw==
X-Forwarded-Encrypted: i=1; AJvYcCWrnX8BtAozVx4HCYqZJ9Y3lPUE4tVWl1evvHst7nkH1fejDI3T0GElZH0ahWKTycVGJSLv6BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMy+OMWDbkIamp4nGwtLnKQmkn1yuoVCRNHZaLIdT28nv4upvu
	b6s8Mn2QGRCUaHgjiq22cxrvWo5XBrNO68+Vf6bRpxSeMUjj7fv4qL/HV99mCdI=
X-Gm-Gg: ASbGncvwAnUFW3mqK9qgfxoL9nsjdgj4yKuUi3Rp9pOtErx3kLy0k5ctTjTJ7+n4v0b
	Nhai2oWrh7asqXxzbfamrjbegOhEHhEIYUR0KeKUiAzbc066bzFhvdDY2p8kLb2bfsmaeAIlNje
	FHXxOtnE4jv0nOwIO2+cMc9JjKhW1qjpnTgRPR5+o5v4xXFkoRIRseeEgnES6fNT48bL2bAU9aC
	hPAfS6tWrnQNZJ6tRLp2yjBqlCrw5j45cpZwho+TPoctZmyC0hY/h+eSwQ4Wj/cBjz8blaxrEcf
	Kpl6OBiLFPabvR+nPxWoFbJGZlXZLREWM52UMeGI+ip75841H+TCk1c3GQ==
X-Google-Smtp-Source: AGHT+IFQwzRf2ZVVTwGkkmxzXrR9YrWPorWCeaFDV9UOLaMtIyUJ+w+TMffFlqAyfQSuhpP8J881jQ==
X-Received: by 2002:a17:902:f54b:b0:215:a434:b6ad with SMTP id d9443c01a7336-21f17edf124mr121154725ad.33.1738850490568;
        Thu, 06 Feb 2025 06:01:30 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d8a7sm12843885ad.148.2025.02.06.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 06:01:30 -0800 (PST)
Date: Thu, 6 Feb 2025 06:01:27 -0800
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Dave Taht <dave.taht@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
Message-ID: <Z6TAt7HIA4Sj5uep@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Dave Taht <dave.taht@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <CAA93jw7tVyiz6Kj8B5zXMqYKxLZSnctGiwbH5hC+4_ZTWpg3fA@mail.gmail.com>
 <CAAywjhRd-tQz3ra6uUvZf_rwTT+5a04BfeA59bcG8ziW_4FLWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhRd-tQz3ra6uUvZf_rwTT+5a04BfeA59bcG8ziW_4FLWg@mail.gmail.com>

On Wed, Feb 05, 2025 at 09:49:04PM -0800, Samiullah Khawaja wrote:
> On Wed, Feb 5, 2025 at 9:36 PM Dave Taht <dave.taht@gmail.com> wrote:
> >
> > I have often wondered the effects of reducing napi poll weight from 64
> > to 16 or less.
> Yes, that is Interesting. I think higher weight would allow it to
> fetch more descriptors doing more batching but then packets are pushed
> up the stack late. A lower value would push packet up the stack
> quicker, but then if the core is being shared with the application
> processing thread then the descriptors will spend more time in the NIC
> queue.

Seems testable?

> >
> > Also your test shows an increase in max latency...
> >
> > latency_max=0.200182942
> I noticed this anomaly and my guess is that it is a packet drop and
> this is basically a retransmit timeout. Going through tcpdumps to
> confirm.

Can you call out anomalies like this more explicitly and explain why
they occur?

If it weren't for Dave's response, I would have missed this.

