Return-Path: <netdev+bounces-126692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDD19723B9
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77679B211D6
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AAA171066;
	Mon,  9 Sep 2024 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVTWYCLV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EBC18A6A8
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913901; cv=none; b=ByaoddWi+zf5SG6e2wpcRetXd4xR0s8b4pmAVfliyFDFABnyi0R4zR9acW204j51oME0votzZ1a2+zG5HBkTgc4PgdtTU0bDUNkXPja2RDmfOOFkbcu+k+HpWqBqW35FasLortudhKCmLtTa54Oz1WAyuDiiWnkzRgqky30lhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913901; c=relaxed/simple;
	bh=j50Qlhd3t7AQuVFKtZaY1sWMSjxZd7DXpB5uWWSSeks=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XnSNe7zUeYaIFDnNizIpGwhULmWbznqs+TrTv5lCT0nM+/o7oX1h2DjhW/mTsZ39YYHdo49nUj2+DNkTEw4qlheIoVBS4RABWs/TvkrVPXVKcqw08EEGTRKlkwziOixJUbrj0q/aybYxmPrGNNK6zkzqoIpVzBvZqEA1p3AMU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVTWYCLV; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c35357cdacso29939006d6.0
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725913899; x=1726518699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkHkGvvJcV+lNRQP9h4w++WXPBrBYFfxmvgwLPguxwA=;
        b=iVTWYCLV7AoLb2yt0mRCaFDkW2rsC7ljv2moLoc4Rbs1DF9dW6lbMHUIf2YKLqw1TQ
         GZOFLjZkVdyJto2cnk/pFwK1xVAEFK53eHkohX5rGClrV4ac+epP9sDcX+dnuUWja34e
         Vha+pPOBrNX76nhm3ZLbWZQx19pht7l3gnbfv8xo9T8sFaUlR+FVKcZRkxSoBB3YEEbk
         vqyC/RD6K5K6uD8wqfZROTZkXqqQ0FN3R3ZdN/yjhuRRCRaHDi2CI6tQldEmOy9opt9M
         D78U++HKGgDfNtfIq+maTw1kmGiw7/p6NNb0W9Ht8I4cD3fzFoBeWtTfYCZQ/Ldf1DyA
         PRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725913899; x=1726518699;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hkHkGvvJcV+lNRQP9h4w++WXPBrBYFfxmvgwLPguxwA=;
        b=eOqwGo2SI6JUifO1Wi+wj19f5eHZTEE/FQcwkbu5rUgP941mMDW4Q2f+jvVaV5jTm4
         KzxNKdTSdFYSsR6HPeFdnKk80UPxlNB9GJh2Zpcb6wOYfo7pyrwX2eOpjhfMBxeQ62G6
         kJadZvmpATAkAcI7ENG3WD6qnZbqNdlPf8lSVIqUxwetgHGsgWYL6FecTLiJILorVByq
         HFAP4rq2b4XdPoghDZH02PUxNyaY/bCJ51d0TSRU9ZJnrccnM3kL5FTBzYaTE7EKJjWu
         Zn5O+HzE437Hd2JC4zDnB072qTpCPbxDYzOEfoo7PhYzLh3XO+S5UssSnNQHl2t3ANVk
         9reg==
X-Gm-Message-State: AOJu0YwiAly0oFlKgJrpmSMDish90mWV/LbqX8p3+d/tzbDw0bxMyZCB
	oWWtJiLKZ+8FyUTUf4qb4P78tOYHJv21t4QqhlTxn7UJkga23GNw
X-Google-Smtp-Source: AGHT+IE/muhbycu0eBDVq9Wl9ouP+MApeMqq4P0kxIP2+mDOLiv5wa40CwfIYa7mQ4g/N3j3oqJo1w==
X-Received: by 2002:a05:6214:2c07:b0:6c3:5db2:d99d with SMTP id 6a1803df08f44-6c5283fb84amr188879126d6.21.1725913898465;
        Mon, 09 Sep 2024 13:31:38 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53432ded8sm23765186d6.5.2024.09.09.13.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 13:31:37 -0700 (PDT)
Date: Mon, 09 Sep 2024 16:31:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Message-ID: <66df5b295992c_7296f294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <5358489d-faff-4f0a-bf47-f5b45127e9e6@linux.dev>
References: <20240909165046.644417-1-vadfed@meta.com>
 <20240909165046.644417-4-vadfed@meta.com>
 <66df354bbd9e9_3d0302945@willemb.c.googlers.com.notmuch>
 <5358489d-faff-4f0a-bf47-f5b45127e9e6@linux.dev>
Subject: Re: [PATCH net-next v4 3/3] selftests: txtimestamp: add SCM_TS_OPT_ID
 test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> On 09/09/2024 18:50, Willem de Bruijn wrote:
> > Vadim Fedorenko wrote:
> >> Extend txtimestamp test to run with fixed tskey using
> >> SCM_TS_OPT_ID control message for all types of sockets.
> >>
> >> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >> Reviewed-by: Willem de Bruijn <willemb@google.com>
> >> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >> ---
> >>   tools/include/uapi/asm-generic/socket.h    |  2 +
> >>   tools/testing/selftests/net/txtimestamp.c  | 48 +++++++++++++++++-----
> >>   tools/testing/selftests/net/txtimestamp.sh | 12 +++---
> >>   3 files changed, 47 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
> >> index 54d9c8bf7c55..281df9139d2b 100644
> >> --- a/tools/include/uapi/asm-generic/socket.h
> >> +++ b/tools/include/uapi/asm-generic/socket.h
> >> @@ -124,6 +124,8 @@
> >>   #define SO_PASSPIDFD		76
> >>   #define SO_PEERPIDFD		77
> >>   
> >> +#define SCM_TS_OPT_ID		78
> >> +
> >>   #if !defined(__KERNEL__)
> >>   
> >>   #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> >> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> >> index ec60a16c9307..bdd0eb74326c 100644
> >> --- a/tools/testing/selftests/net/txtimestamp.c
> >> +++ b/tools/testing/selftests/net/txtimestamp.c
> >> @@ -54,6 +54,10 @@
> >>   #define USEC_PER_SEC	1000000L
> >>   #define NSEC_PER_SEC	1000000000LL
> >>   
> >> +#ifndef SCM_TS_OPT_ID
> >> +# define SCM_TS_OPT_ID 78
> >> +#endif
> > 
> > This should not be needed. And along with the uapi change above means
> > the test will be broken on other platforms.
> > 
> > (SO|SCM)_TXTIME ostensibly has the same issue and does not do this.
> 
> I had the same feeling, but apparently I wasn't able to build tests
> without this addition. Looks like selftests rely on system's uapi rather
> the one provided in tool/include/uapi.

Right, as they should.

make headers_install will install headers by default under $KSRC/usr

tools/testing/selftests/net/Makefile has

CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)

Haven't tried, but I assume this will pick up the right header
depending on the arch.

> With SCM_TXTIME it worked because the option was added back in 2018 in
> 80b14dee2bea ("net: Add a new socket option for a future transmit 
> time.") by Richard while tests were added in 2019 by yourself in
> af5136f95045 ("selftests/net: SO_TXTIME with ETF and FQ").
> 
> Though selftests do miss uapi for other architectures, it might be a
> good reason to respin the series, but fixing selftests infra is a bit
> different story, I believe... I may try to fix it and post another
> series.



