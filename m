Return-Path: <netdev+bounces-84565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403FD897541
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 18:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AD01C220E2
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D68618C08;
	Wed,  3 Apr 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="OYvLwWHX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F16717C98
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161853; cv=none; b=u+dUu8H/QtskMK4absgOokScXv/Z5z9U8tbKVsg1IuO+0WJHNzgqI/7OcG9V4gXgp8PPBOVZC/uzGMkkC2SUUIv5ca7bkJMk36XEYSLOrCBDIUJNnpbLYdJSpE8sjlHXaUTqYd0oc3H8PLOQ2PCvLTN+Dn1JC5PHlhiK4INtbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161853; c=relaxed/simple;
	bh=aaYGODw12EF1OpO2Ckn/pDfoSwVlWDS2jr98EgU0rRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbcjkLltyz2TfF99F/vQPBnJwN5ugDKNrzM5cL/kbJia8GRvLeeyQpbAt7ndqBzelyJA02si1p++rP9zWBChgjrnL6+1D3fZm7AD8k0Q9PiLL+lupJzRcrAgmnx9VWWxV5a80v3LEdl/aCkd0MP64Z7B47uI+BxC+0Py5Gu4DTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=OYvLwWHX; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so52594a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 09:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1712161850; x=1712766650; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mutt-fcc:mutt-references:message-id:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cmRqKeWpZziYkT6GrUd1H4+z7Rx2HMV8sDRPV7T2QgQ=;
        b=OYvLwWHXkFKBanjFIEcbFUwuFJZToUeFRiyCZsp7T3vBfjRMTJVOUqZViwnARdHUuM
         mRjGjrzxidQs61gUPPIjYYNcnuXONa3uS3DZpyDYP7qAru40dnVTsiDTkcqS2RE1xj3Y
         NDRHtpl2IuNv7LWKTzmCk6VdXyfK58f1YQOuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712161850; x=1712766650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mutt-fcc:mutt-references:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmRqKeWpZziYkT6GrUd1H4+z7Rx2HMV8sDRPV7T2QgQ=;
        b=Bb0V6u6pDm/ZQS27I5fK9UqgDYezSPFEHSuQ4ibcaCyZvPcK7ZhQrM1lFaTMO752m0
         SbzqV8RDz2s+ZRZqeGnEH16AAYeNnc4p8neBKPGllQo767Us23vs03sGeNugzm1HBnsF
         a6J1PwuBk2TqWm3L4LQkuem/KqY8StBvdyAApnvKruap6xqwZWSMPGF+M1ov95mw6rn+
         y1X+5dKT/1jFqwb79RbMAUDgjReVuD/19gSqfFoc9IG0GPVEmwBTz5SOVIWJRgXfE2zk
         V/9Jez8IzDCsPhDyiLXhhe3arx7TN0D3crye41CSo4rXghgS42z5z1vbGR7hJATGxmPs
         IFfA==
X-Forwarded-Encrypted: i=1; AJvYcCUddf2SCOqMelizAkQq9w23vlp9TbSDypbsqPjazl843xmJ+LsOQr85VpE81H518UATzMTXPRiq/KtIOuqWf2ExwCiO7gDT
X-Gm-Message-State: AOJu0Yzl40Hqqy78WCGsFzr/Zt/T9WeMwi5hz0lKgMlxTCSL8yQ7FUjg
	FxjMApGIoCJd/P8W0SjiHR9PGJcxJta7sa760qj+7qezHDRupPm4s5nhSzSDHtI=
X-Google-Smtp-Source: AGHT+IEO6NhwzazLc0nIEgNHWGzT1lmbpWEu7ErijEk4wtTHsjLxX4xOrX5y9GauGr2PLIB7iHf7tQ==
X-Received: by 2002:a05:6a20:5529:b0:1a1:448f:d7b8 with SMTP id ko41-20020a056a20552900b001a1448fd7b8mr129754pzb.62.1712161849533;
        Wed, 03 Apr 2024 09:30:49 -0700 (PDT)
Received: from localhost ([2607:fb10:7302::3])
        by smtp.gmail.com with UTF8SMTPSA id v16-20020a62a510000000b006ead6e28ee6sm11885037pfm.58.2024.04.03.09.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 09:30:49 -0700 (PDT)
Date: Wed, 3 Apr 2024 09:30:48 -0700
From: Hechao Li <hli@netflix.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org,
	kernel-developers@netflix.com, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH net-next] tcp: update window_clamp together with
 scaling_ratio
Message-ID: <b3kspnkcbj2p3c5q6rbujih72n7vouafpreg5mjsrgvf4fpu52@545rpheaixni>
Mutt-References: <CANn89iLyb70E+0NcYUQ7qBJ1N3UH64D4Q8EoigXw287NNQv2sg@mail.gmail.com>
Mutt-Fcc: +[Gmail]/Sent Mail
References: <20240402215405.432863-1-hli@netflix.com>
 <CANn89iJOSUa2EvgENS=zc+TKtD6gOgfVn-6me1SNhwFrA2+CXw@mail.gmail.com>
 <CANn89iLyb70E+0NcYUQ7qBJ1N3UH64D4Q8EoigXw287NNQv2sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLyb70E+0NcYUQ7qBJ1N3UH64D4Q8EoigXw287NNQv2sg@mail.gmail.com>

On 24/04/03 04:49PM, Eric Dumazet wrote:
> On Wed, Apr 3, 2024 at 4:22 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Tue, Apr 2, 2024 at 11:56 PM Hechao Li <hli@netflix.com> wrote:
> > >
> > > After commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"),
> > > we noticed an application-level timeout due to reduced throughput. This
> > > can be reproduced by the following minimal client and server program.
> > >
> > > server:
> > >
> > ...
> > >
> > > Before the commit, it takes around 22 seconds to transfer 10M data.
> > > After the commit, it takes 40 seconds. Because our application has a
> > > 30-second timeout, this regression broke the application.
> > >
> > > The reason that it takes longer to transfer data is that
> > > tp->scaling_ratio is initialized to a value that results in ~0.25 of
> > > rcvbuf. In our case, SO_RCVBUF is set to 65536 by the application, which
> > > translates to 2 * 65536 = 131,072 bytes in rcvbuf and hence a ~28k
> > > initial receive window.
> >
> > What driver are you using, what MTU is set ?

The driver is AWS ENA driver. This is cross-region/internet traffic, so
the MTU is 1500.

> >
> > If you get a 0.25 ratio, that is because a driver is oversizing rx skbs.
> >
> > SO_RCVBUF 65536 would map indeed to 32768 bytes of payload.
> >

The 0.25 ratio is the initial default ratio calculated using 

#define TCP_DEFAULT_SCALING_RATIO ((1200 << TCP_RMEM_TO_WIN_SCALE) / \
                                   SKB_TRUESIZE(4096))

I think this is a constant 0.25, no?

Later with skb->len/skb->truesize, we get 0.66. However, the window
can't grow to this ratio because window_clamp stays at the initial
value, which is the initial tcp_full_space(sk), which is roughly 0.25 *
rcvbuf.

> > >
> > > Later, even though the scaling_ratio is updated to a more accurate
> > > skb->len/skb->truesize, which is ~0.66 in our environment, the window
> > > stays at ~0.25 * rcvbuf. This is because tp->window_clamp does not
> > > change together with the tp->scaling_ratio update. As a result, the
> > > window size is capped at the initial window_clamp, which is also ~0.25 *
> > > rcvbuf, and never grows bigger.
> 
> Sorry I missed this part. I understand better.
> 
> I wonder if we should at least test (sk->sk_userlocks &
> SOCK_RCVBUF_LOCK) or something...

In our case, the application does set SOCK_RCVBUF_LOCK. But meanwhile,
we also want the window_clamp to grow according to the ratio, so that
the window can grow beyond the original 0.25 * rcvbuf.

> 
> For autotuned flows (majority of the cases), tp->window_clamp is
> changed from tcp_rcv_space_adjust()
> 
> I think we need to audit a bit more all tp->window_clamp changes.
> 
> > >
> > > This patch updates window_clamp along with scaling_ratio. It changes the
> > > calculation of the initial rcv_wscale as well to make sure the scale
> > > factor is also not capped by the initial window_clamp.
> >
> > This is very suspicious.
> >
> > >
> > > A comment from Tycho Andersen <tycho@tycho.pizza> is "What happens if
> > > someone has done setsockopt(sk, TCP_WINDOW_CLAMP) explicitly; will this
> > > and the above not violate userspace's desire to clamp the window size?".
> > > This comment is not addressed in this patch because the existing code
> > > also updates window_clamp at several places without checking if
> > > TCP_WINDOW_CLAMP is set by user space. Adding this check now may break
> > > certain user space assumption (similar to how the original patch broke
> > > the assumption of buffer overhead being 50%). For example, if a user
> > > space program sets TCP_WINDOW_CLAMP but the applicaiton behavior relies
> > > on window_clamp adjusted by the kernel as of today.
> >
> > Quite frankly I would prefer we increase tcp_rmem[] sysctls, instead
> > of trying to accomodate
> > with too small SO_RCVBUF values.
> >
> > This would benefit old applications that were written 20 years ago.

The application is kafka and it has a default config of 64KB SO_RCVBUF
(https://docs.confluent.io/platform/current/installation/configuration/consumer-configs.html#receive-buffer-bytes)
so in this case it's limitted by SO_RCVBUF and not tcp_rmem. It also has
a default request timeout 30 seconds
(https://docs.confluent.io/platform/current/installation/configuration/consumer-configs.html#request-timeout-ms)
The combination of these two configs requires the certain amount of app
data (in our case 10M) to be transfer within 30 seconds. But a 32k
window size can't achieve this, causing app timeout. Our goal was to
upgrade the kernel without having to update applications if possible.

