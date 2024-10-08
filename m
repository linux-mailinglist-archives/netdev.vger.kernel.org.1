Return-Path: <netdev+bounces-133341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC69995B67
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4930CB20BB6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F317321644C;
	Tue,  8 Oct 2024 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Bbm7eZ0l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F8215011
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429058; cv=none; b=FSmE929lVMg8GGv/xbMW7QS9pkn/1rJW39g+rkPC+WKuqCHNnciddFJYJ7y4qHvbzvcozLqV7cJ6YpBgWO2Ev12RHSBgp3ygrDVM74tceO/TrMQf8/ajasysTFBDJpWOKU1hLEj1Txlkq8jGwHIin//gOhRLVg//l8kDyZuXNU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429058; c=relaxed/simple;
	bh=OrDfRlp1iNBH87y8hqvKBX66BOV7jtvZcKUjL2jvQ9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euVYD4J3LZOlkkclW6KmkhUpQwlLz1W7a0rHeEaekPvUwrc2Vg2x49DSMzL9KeQiAcCaJOObF51ciqrCRQYKLpVV1z8LC6+TV4UXkmwTcHS2L9xNG1z3G/JsHWyReazwq5FVYagJGiCRZm8DXujoqsMv0udQuLN+MxwyLPrJvjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Bbm7eZ0l; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e0a5088777so4758161a91.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 16:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728429057; x=1729033857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN6Cw0MLTHJuavZQ2ZdlLC7OXqpw9Yt4DNbtA6+RtoY=;
        b=Bbm7eZ0lCP2ckU779LKj5Mm0/Oa6Tw3Ah99ilshHAqoKkrufg19mGTdiBLtW90wLYv
         PS9EZNNy+AJqq5tKSE5jlXxPAuoDHRknwT55qlKiJFr6gs3YpxsjAXDxFQHfLhQqRyCl
         0A8v2W7eWL+tXNlVa5Fyr7RiCSYsNsfrYyjGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728429057; x=1729033857;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XN6Cw0MLTHJuavZQ2ZdlLC7OXqpw9Yt4DNbtA6+RtoY=;
        b=toFfGuimmk/8J0XbZOoXM0Pt4R7ND56aeLwo4H1BST2XTiy3Wlu6+ffNqYJFFSboLb
         mppgFpc6zNbzi9KF6kdh26B05WWfGR1uoDQojFRVgSdCu//GPxSD4xX/8vdjYy0Eh1In
         b6MYUBcfJ/0XWImTM0e5NAssa3DGbTSxZ2xDvJ7kHI1r9kRTyyCFxnC8rWAGMNYcxH/I
         hVu79A8b98g/27izHaF+zxqvRA3617Fjik/Q3wxaVEFE/PRdnt/CpvcdcaN4arpHJSkX
         AO92svzWLNPVX7dV54P6kH02LpxcgAFMqKlHLrp4rBE1RLDUP0Y2YwXNs7c/x3gYCG8m
         HaoA==
X-Forwarded-Encrypted: i=1; AJvYcCXYfobTh5bo/Jyh/0eAZjMJj6SI86SvREMSiD9BY9+Dx9dpOLuMT21FpExlKuX2sIdIKcv909A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6DKUr9c0TsYpsun6prqI3iY9JZ2T7Lf5KdOeB2pPdCStrPHsV
	VWpU7zubU4fw+GwQTYiIKqkaqCV84HcmoObXgnPUvp0LsSq+T+r6UTSh9oF47i8=
X-Google-Smtp-Source: AGHT+IGdEM+CgDYtUPFE0hetYr8rtz/LejORp83EfMoPgRqvDg+8LpOI5w8Z/rlAqQNLtKuj8ZnAvQ==
X-Received: by 2002:a17:90a:bf07:b0:2e2:92cf:69c with SMTP id 98e67ed59e1d1-2e2a24784b8mr685846a91.18.1728429056807;
        Tue, 08 Oct 2024 16:10:56 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c4d0c801csm19992185ad.22.2024.10.08.16.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 16:10:56 -0700 (PDT)
Date: Tue, 8 Oct 2024 16:10:53 -0700
From: Joe Damato <jdamato@fastly.com>
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH v1 00/15] io_uring zero copy rx
Message-ID: <ZwW7_cRr_UpbEC-X@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
	netdev@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007221603.1703699-1-dw@davidwei.uk>

On Mon, Oct 07, 2024 at 03:15:48PM -0700, David Wei wrote:
> This patchset adds support for zero copy rx into userspace pages using
> io_uring, eliminating a kernel to user copy.
> 
> We configure a page pool that a driver uses to fill a hw rx queue to
> hand out user pages instead of kernel pages. Any data that ends up
> hitting this hw rx queue will thus be dma'd into userspace memory
> directly, without needing to be bounced through kernel memory. 'Reading'
> data out of a socket instead becomes a _notification_ mechanism, where
> the kernel tells userspace where the data is. The overall approach is
> similar to the devmem TCP proposal.
> 
> This relies on hw header/data split, flow steering and RSS to ensure
> packet headers remain in kernel memory and only desired flows hit a hw
> rx queue configured for zero copy. Configuring this is outside of the
> scope of this patchset.

This looks super cool and very useful, thanks for doing this work.

Is there any possibility of some notes or sample pseudo code on how
userland can use this being added to Documentation/networking/ ?

