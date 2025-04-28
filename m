Return-Path: <netdev+bounces-186506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B35CA9F78E
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B29A7ABAD6
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A392951A9;
	Mon, 28 Apr 2025 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rPJUCXhy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09B25D90F
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745861999; cv=none; b=o71cLqWqI6W+LKQHFa3LR1VxbHKdBJf1REd3s8LoUnQOKcr/An0a71uF1mW+0PWVdyrKju+ATLpzc4Cc6rmDVc4BfklAA1m1uuFf1OKasXv3lWFKMr4Ts//I4ksQu0qt/VgUfMk7tVeN4dr6MY3YmMgP6D7ysmhcpr9aAyKZO7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745861999; c=relaxed/simple;
	bh=NYz2itbSwekwu/LchEZp7yqkeh2PRz+a4UFgb+Trfyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iedn9j8B/hGF+rG/bKLt3krezZQunFd+vyyq79fB/40RF1lneN0GM8DitMuTc3mcACPH4zUkwcEWNgMSlv5F3fxgPE+V3PAtZOT1+hno3XekQboYC5hlZKfJv2xmQPwIDtB/n4XA7vD9wsO3hDOku8JKIRMQTx2+1U1CfBIuQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rPJUCXhy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30332dfc820so6274683a91.2
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745861996; x=1746466796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYz2itbSwekwu/LchEZp7yqkeh2PRz+a4UFgb+Trfyo=;
        b=rPJUCXhyS3RH7zMCn615ZS0TjRWkBKURA0zVFnWo80Vl0DJe+GX3vTLYWa+ca3qDba
         FHPhHdaZQ+xudBq9E5rl6V2E2pnu6cpmv0TfUZQQwwvBusH0WONYm+ZeChyGKIwq//sy
         7wY8FPybWSuxyIJomFZ8VvLklf3PvCJlYCQuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745861996; x=1746466796;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYz2itbSwekwu/LchEZp7yqkeh2PRz+a4UFgb+Trfyo=;
        b=S3V3Q0KWC8kvN/IMIUjLUT891emql1e+EWWJiDrLqSg7V1xbjUQ9JJrkPoKDsA6bss
         Q5or6jsdMfHTnhePMSeNpCvrJCbsaxB6IUWw9VZ92CUKr8yumIPUygIKZKftr6Vi/ocM
         FUiM1NCcEdfIaHU52gqWAmB6GdtL995wTjjmt/t1xIwRO8TwFY0y1ljWIxqLs11X5+rZ
         /0UGYTLcPorKKRTiQc40uTsaBivJ7+7g42sHaBrkFhe1s310TIO3MhZKTicessj7oGuK
         Osyh87J0RC7fRvYELA2eXx8AL7LrQuK/jPcEUjqi8ChhWZ/RjxIe4Rx3x2tUZ/oMfkAX
         Sddg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Dd/7oopuBwYa0G1BOOCvfKU7Rs5nrAguhnorNLUBXKHJdW69WAGpnahlt/f9rEOVgul3sZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl7fZlawBCzc91789IuvAu939MYCRq6PzDVXrLklpSBdbMHhzY
	kJEr376NgDWoyClm5LSIWxxtJKWoFber1QvbwRraplzwahRVSqkhPNl3SybQIA4=
X-Gm-Gg: ASbGnctoI2vrnBwTrX+JUvVRLN3/mkNvnx89XNYdlANu2DsCpFMlHgXcPKPch5K2ZCk
	8A/fTa/7dyj710PjGkVvhx8Aj3JPRUGAAyjuVNce+vSZEfnTCYSKiLDkOQgw0+rvQU5/zso7JRw
	bfOFsNWqj1rcZrgv5GTrAcW7+Xqb5JjTTjMHWA4jPmwh5h5J6fMpehDRCXnlnj/EJwf5jBnLlNL
	f4JBPkK7/ca0md4rW8IjLjZlssKJLUfMnITvRCKhS+GA6eI21xIjosRvC9Bv55yCLd3BoI+hGSP
	YJuyXteUofMkQiGder4+psfbj/hjkaV3clM3VDFk7Lw5mBOCmY+l8wUM7Aeb19ReiDdjr5oVPUs
	TZQ6dBAk=
X-Google-Smtp-Source: AGHT+IEfnxoLniP7ETR0MqplRE0pz+8Pe03rgmilaE8Rr6NyHip77Cn/yZkx56q/G692xuIjeqa2Ng==
X-Received: by 2002:a17:90a:d888:b0:309:eb54:9ea2 with SMTP id 98e67ed59e1d1-309f7e00a65mr17970892a91.20.1745861995585;
        Mon, 28 Apr 2025 10:39:55 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f782d07dsm7503407a91.32.2025.04.28.10.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 10:39:54 -0700 (PDT)
Date: Mon, 28 Apr 2025 10:39:52 -0700
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
Message-ID: <aA-9aEokobuckLtV@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org
References: <20250424200222.2602990-1-skhawaja@google.com>
 <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
 <680fb23bb1953_23f881294d9@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680fb23bb1953_23f881294d9@willemb.c.googlers.com.notmuch>

On Mon, Apr 28, 2025 at 12:52:11PM -0400, Willem de Bruijn wrote:
> Martin Karsten wrote:
> > On 2025-04-24 16:02, Samiullah Khawaja wrote:

> Ack on documentation of the pros/cons.

In my mind this includes documenting CPU usage which I know is
considered as "non-goal" of this series. It can be a "non-goal" but
it is still very relevant to the conversation and documentation.

> There is also a functional argument for this feature. It brings
> parity with userspace network stacks like DPDK and Google's SNAP [1].
> These also run packet (and L4+) network processing on dedicated cores,
> and by default do so in polling mode. An XDP plane currently lacks
> this well understood configuration. This brings it closer to parity.

It would be good if this could also be included in the cover letter,
I think, possibly with example use cases.

> Users of such advanced environments can be expected to be well
> familiar with the cost of polling. The cost/benefit can be debated
> and benchmarked for individual applications. But there clearly are
> active uses for polling, so I think it should be an operating system
> facility.

You mention users of advanced environments, but I think it's
important to consider the average user who is not necessarily a
kernel programmer.

Will that user understand that not all apps support this? Or will
they think that they can simply run a few YNL commands burning CPUs at
100% for apps that don't even support this thinking they are making
their networking faster?

I think providing a mechanism to burn CPU cores at 100% CPU by
enabling threaded busy poll has serious consequences on power
consumption, cooling requirements, and, errr, earth. I don't think
it's a decision to be taken lightly.

