Return-Path: <netdev+bounces-163699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A4AA2B611
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BB4166DEC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994532417D8;
	Thu,  6 Feb 2025 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xbQdjRrv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF42417C6
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882692; cv=none; b=EZJkFFxHQgGT84gZI/dXmEj0AS8/ormN91lMnG5pErdm1/VxhAs24w4kerK53nmHhPjMCs8QsC//7I/hfm5t4rhGz8I5Sl8ZEkvsEzCHzbrPLopHJCzEsJd1yroikmJYnEmdQAFoFYjxxbYIYqm1eowiu3pJgkIGlS/qjLd3XsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882692; c=relaxed/simple;
	bh=Lt7LbEWyIV5/wySk5JUmt1wRalh4QOkfUQW0QPocYZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdDZHApYEwqygn//aGyBuLfMjT/qJaxFr+CDeyziMxA3B8xKSa2KagvxBIcgmk+jBWzgSWsqx+Yr66v23sgzKIvOQ4c6ta3SbhJ3u1igpOcZPuuBbT8swyM17vMS+PIJojYUC1noLl1hNAkxsnQ6jpzxFc1bwTLZM9eaSTeGx3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xbQdjRrv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f0c4275a1so22823845ad.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 14:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738882689; x=1739487489; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lt7LbEWyIV5/wySk5JUmt1wRalh4QOkfUQW0QPocYZU=;
        b=xbQdjRrvAudwU2AFBgyEcU/JDrKOJk8MLXs2Ndg0uQ6wDDTHW+FJnkXfTdH8R3gAFw
         GbjgMKx+dJMnpOG3qa3wVWh3JJa1nOu4+UHMHMOaLSj3iPnUVB7q4nYyxfrfYsV8Kncx
         BUDVA5B0zLd4v/TnQPZViDDNhDWpZwqkUrvoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882689; x=1739487489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lt7LbEWyIV5/wySk5JUmt1wRalh4QOkfUQW0QPocYZU=;
        b=sjkBXAvpPjP2lnBlmi41vJLtdHsFsBvXBAm7u/6uwwm9bbzyTBn6Df1M+nDzfrGzXg
         NYiw8u3qmW8UKf5Cp3yNle0j7Q2ldshgqJA05Rq+TCI8Poy1H5J3AiIIeY3V13zivfTU
         BKiB2eZPoBCkS14vbeeu6Pc0vLTrfmYU6X1ub2v1p3a/wEWW6pE0BCgRBHZeC0Wh/N7S
         Ldz1Sg9qnTHjGpMPWyDnQjVdTrtsKWjAaP2inDMC7vGgN4DsBFq5bvzU+gZ7KgK5ibNk
         xgFXjuXgauGyDYoAcMtd3LlSNCpmY+cDwQKWQXsBSIW3rrUb9ubbYhkjcbE6X2uR9fZP
         hP6g==
X-Forwarded-Encrypted: i=1; AJvYcCV+bJfRblR7ySRTNK/pJ8YvkGVX0cM4CbNky2J+mRRVoZI/+/hSQhUFxmb74VnCprnkSkfqLnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDjv1i+bvkEzslZhxMOFXiTXUWFgNDIMXI0LXSMRLT6tGCF2h
	IzIkm/3ylCS+qzWiKlLwGd/VP4ZSOrSpYx/Dn68diSjpVaAatRx3xA3cdyXeMos=
X-Gm-Gg: ASbGncvjKGVpp03Bt9IWWji1Dg7NndGDVBEGlhPbroCH8s31SXzT98eFIyQiiOcNLlE
	9hH5AVfRe4YXx1XocksSXwJfwr8ZaqTzajxzaoqT5NsTx3dodrPPyMdnkCo4yedDd+qd/g8aNX5
	QU3Nw6jypyNXmfV4f1uaJ74yMf4oaWbR9xEtSKBsbGxenFNjiKSF9jjwMJ1SpnfghqIAIUz1hFo
	WT8bQ9o6hMpOr+5rV0lKCDV+3kGFDlIhl2R49PqVeC4M8StvfFXziMnRLXJjpYrOTSYMdOmiH7D
	eSXvZmuR7oIcmNJwjd6ul/w0c8V4EHdkwL6X+pni8cYe6bs64Qcjua/3OQ==
X-Google-Smtp-Source: AGHT+IEYoIdB7SpMDQtgK6h7mjj0Npy76l8HAI04oMpAMcL/afaD/sPofxV5uFNIL2k7U7egiyFrLg==
X-Received: by 2002:a05:6a00:1953:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-7305d4ec7d8mr1704540b3a.18.1738882689110;
        Thu, 06 Feb 2025 14:58:09 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c15c73sm1799371b3a.123.2025.02.06.14.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:58:08 -0800 (PST)
Date: Thu, 6 Feb 2025 14:58:06 -0800
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
Message-ID: <Z6U-fubUytqdxRds@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
 <CAAywjhQM4BLXX55Kh0XQ_NqYv8sJVWBfPfSZMb7724_3DrsjjA@mail.gmail.com>
 <Z6Pg6Ye5ZbzMlBeP@LQ3V64L9R2>
 <CAAywjhTYF3YXM0hKbSwnrV02dXXTO6Eeq=iX0UFRO9p0FGSFVQ@mail.gmail.com>
 <Z6S8Q0ZLfjxrzh7m@LQ3V64L9R2>
 <CAAywjhR3BCJx6DuH2NTgm_66ZkBXYTyKoMBx5k-J-UkCsh6_iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhR3BCJx6DuH2NTgm_66ZkBXYTyKoMBx5k-J-UkCsh6_iQ@mail.gmail.com>

On Thu, Feb 06, 2025 at 02:49:08PM -0800, Samiullah Khawaja wrote:
> On Thu, Feb 6, 2025 at 5:42 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Wed, Feb 05, 2025 at 04:45:59PM -0800, Samiullah Khawaja wrote:
> > > On Wed, Feb 5, 2025 at 2:06 PM Joe Damato <jdamato@fastly.com> wrote:
> > > >
> > > > On Wed, Feb 05, 2025 at 12:35:00PM -0800, Samiullah Khawaja wrote:
> > > > > On Tue, Feb 4, 2025 at 5:32 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
> > > > > >
> > > > > > On 2025-02-04 19:10, Samiullah Khawaja wrote:

[...]

> > > > > The processing of packets on a core and
> > > > > then going back to userspace to do application work (or protocol
> > > > > processing in case of onload) is not ok for this use case.
> > > >
> > > > Why is it not OK? I assume because there is too much latency? If
> > > > so... the data for that configuration should be provided so it can
> > > > be examined and compared.
> > > The time taken to do the application processing of the packets on the
> > > same core would take time away from the napi processing, introducing
> > > latency difference at tail with packets getting queued. Now for some
> > > use cases this would be acceptable, they can certainly set affinity of
> > > this napi thread equal to the userspace thread or maybe use
> > > epoll/recvmsg to drive it. For my use case, I want it to have a solid
> > > P90+ in sub 16us. A couple of microseconds spent doing application
> > > processing pushes it to 17-18us and that is unacceptable for my use
> > > case.
> >
> > Right, so the issue is that sharing a core induces latency which you
> > want to avoid.
> >
> > It seems like this data should be provided to highlight the concern?
> The 2 data points I provided are exactly that, Basically I am
> comparing 2 mechanisms of enabling busy polling with one (socket/epoll
> based) sharing a core (or doing work in sequence because of API
> design) and the other that drives napi in a separate thread (in my
> case also a separate core) independent of application. Different
> message sizes, number of sockets, hops between clients/server etc that
> would magnify the problem are all orthogonal issues that are
> irrelevant to this comparison I am trying to do here. Some of the
> points that you raised are certainly important, like the small value
> of interrupts being deferred and that maybe causes some interference
> with the socket/epoll based busypolling approach. But beyond that, I
> think the variety of experiments and results you are asking for might
> be interesting but are irrelevant to the scope of what I am proposing
> here,

With the utmost respect for the work, effort, and time you've put
into this in mind: I respectfully disagree in the strongest possible
terms.

Two data points (which lack significant documentation in the current
iteration of the cover letter) are not sufficient evidence of the
claim, especially when the claim is a >100x improvement.

