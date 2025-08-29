Return-Path: <netdev+bounces-218353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40437B3C22F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D781CC1548
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439B72E7BD7;
	Fri, 29 Aug 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIXsUWqE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA930CD95;
	Fri, 29 Aug 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490479; cv=none; b=c7SvQiE6HY4VPiHWKRUcCM9SunSOY/BYlJ1DhgnAvou0LumU53uZUR/LBWZrt4zaY4tcGirTeMZf2b4Gil0MVKJvc0BQXmFx7M9g7V9u5bpQ+XrtVoPDYOU7B3y9Bchfqo9ZrJR0vlYuudL6l+Psp8ydSW5uMjHE3SyKyUCnn+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490479; c=relaxed/simple;
	bh=TWZy/h2VNSXjDtH4jRU9iT/+lnE+LboBfDRkfHC/wVQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=q1XWdNJ2mEtZkp8aqmx6P6L1hE2qZ2pDX7+Y5bRZcJL2kXichq6P/i3aiFr9d8zjQK33YTyKSWPexZnjqpGkXu19/b/MyxnkFo1zn4NR1ZfP+/rQ8CD7o4A4FHMuRokUvW7QJicHIWXq/UW0aHXOWRQMHNZELRoRL3ibHWwprY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIXsUWqE; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109a95f09so16673591cf.1;
        Fri, 29 Aug 2025 11:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756490476; x=1757095276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F22kmYX9a04LACxXZTogKefP5cHNqzMHaRxMxu2nzMU=;
        b=dIXsUWqEwkl7VEfvjyp7LGHfCYJGyXqoHZ9P+8qoiZHORW0/+XUBnBDlKcrKj8bzF8
         DhPq3nV7aQ0NQaPgYBsCKzf78RS+oHitDvN0qQtE1jBVk/avKAggNoQ9tZuxbKl5Uc8N
         zYRUPrXMNkq7ocfZkC/IAwIoIlOZdcAabz6V0zfG0yVBUFd65gyE2fqbyDVZBgh8jne6
         C4QkDHhhgqjmyNcGOoTMBhAJ0a/82ldgmck2xLzs3RZAMhNMjOC+LFUy4HDujE8SrvPp
         OFeM43Vl+pHRFd+ywyzzHfDjkJFYau3w7OH9/HzlnYE747nodKFYM+Xg7lBBTYGogATM
         +5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756490476; x=1757095276;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F22kmYX9a04LACxXZTogKefP5cHNqzMHaRxMxu2nzMU=;
        b=Rk82F9xgqBe0eYaXkghdga3iKzWMO+D/032ejoV2Whe+TDVtZ51TcIPKF7B+vluxWo
         RGFlw6KVDbCM47LLbs7WE0YVXclTlnZY3pMXk1of2Qzo4aIs6DANO7r+stcbwZHFET3p
         pmmTeeIMGPSOsEfVdMwnMuT2SScfpViz5mPusBCVBcL+P3Vmu5qvjsg8ugQWHffb2P3V
         6GSqqCJk5p6o7+6mLT5lbAEygWBl+RbXV6edRegW0rNpEgoDvAxiJiGMeuv8lm8cxHp0
         xT40UH+NI0vdpdx/0LomJaQk/mO35FY1TouAiyGtPU3f372L+t3arlffPnD6Ssr2+DGl
         zm+w==
X-Forwarded-Encrypted: i=1; AJvYcCWBvH/q7JLJrZiWF3XkMU2imtZ7lWjoi+qkf4hk4LL9PaRSYsKqmeSt6RQQnNF6YvzWfc+h+Y3i@vger.kernel.org, AJvYcCXd0/rFfikWRv3VtyVgRy/Xazi/JV6m9PUqlBhDl2wcbEEv6vJYqon16KSTpGkxk8Y6lJtFrmAxoITGufc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbCMCzd7YY3l848xFgc/wc/qoZv8Q2zGIVbKDHrNaBMtoEzSzD
	oKtNoBXOEv6fRa8gBL8GO/Lm8vfBoqA0qbqrBOKMT3ugCFgCweqSgfoV
X-Gm-Gg: ASbGncsNkqTXkEMByZJISUkXMMeYwKfCz+TVHQ1Kis2pVV69nmgvmCLTyI/4vtUySF5
	uE0ZD22vJCfR25OgsYRARLJllYvRaaZVDShFTC+GKJSYfLTRSNjrq/xH46MfzoWnCJlWoQmgAcs
	EGnitFidDAmD8yA61yRc/tK58xlj9gyN1ZGrlkr7WCK8lWKpEIWS50jT1JeG9b45ftwoNJzGlNF
	VjmsBCXaSeNFz08mnyGb786jqcYns3iYVG3CxQ8qrM7+ph1rISj01YXuLhJDivWxjqKNAJgOda2
	9wLBDzVeQ/YDw+uPC5C3zxGd4iCXa3I/P/kq5urSU/3G0Y21Qg/Y91yqDqZw7UUUOdkMZYuuKik
	hD6Z9AgXpPPMrPU5wmQRJaWYC4IHIv2bRE/GlWYOT7GWbBfWnyHsvTk8bTpa+SjBh7MODVufes3
	3M+Q==
X-Google-Smtp-Source: AGHT+IG5td8MwqiIDXhqwAG2SxHmyf6KByScIG5q5VIes3g284/hiDfP7+mEvLtGwsoMumgANK2NPg==
X-Received: by 2002:ac8:5813:0:b0:4b2:ed1b:c4ef with SMTP id d75a77b69052e-4b2ed1bc5dfmr140077381cf.82.1756490476108;
        Fri, 29 Aug 2025 11:01:16 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7fc153de18asm209844085a.54.2025.08.29.11.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:01:15 -0700 (PDT)
Date: Fri, 29 Aug 2025 14:01:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3427046386018@gmail.com>
In-Reply-To: <20250829140539.3840337-1-jackzxcui1989@163.com>
References: <20250829140539.3840337-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v9] net: af_packet: Use hrtimer to do the retire
 operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> On Fri, 2025-08-29 at 7:16 +0800, Willem wrote:
> 
> > Overall I'm on-board with this version.
> > 
> > 
> > One remaining question is the intended behavior of kactive_blk_num (K)
> > and last_kactive_blk_num (L).
> > 
> > K is incremented on block close. L is set to match K on block open and
> > each timer. So the only time that they differ is if a block is closed
> > in tpacket_rcv and no new block could be opened.
> > 
> > The only use of L is that the core of the timer callback is skipped if
> > L != K. Based on the above that can only happen if a block was closed
> > in tpacket_rcv and no new block could be opened (because the ring is
> > full), so the ring is frozen. So it only skips the frozen part of the
> > timer callback. Until the next timeout. But why? If the queue is
> > frozen and the next block is no longer in use, just call
> > prb_open_block right away?
> > 
> > Unless I'm missing something, I think we can make that simplification.
> > Then we won't have to worry that the behavior changes after this
> > patch. It should be a separate precursor patch though.
> 
> 
> I followed what you said, I think we can directly remove the
> last_kactive_blk_num variable and all related logic. I have run the
> optimized code in our project and haven't encountered any issues.
> The only impact I can think of is that in tpacket_rcv, when discovering
> that the next block is still in use and cannot be opened, we originally
> needed to wait for interval time in the timer callback before checking
> again. Now, we will make that check earlier,

At the next timer callback, which might run immediately.

But importantly averaged it is at half the timer latency, which
is in the same ballpark.

> which may allow us to
> discover that the user has finished using the block sooner and open the
> block earlier. So it seems that the optimization does not cause any issues.
> 
> 
> 
> So what should I do next?
> 
> I submit a patch that removes last_kactive_blk_num, then wait the patch
> merged, and after that rebase to submit the current hrtimer patch?
> 
> or
> 
> I wait for you to submit the patch that removes last_kactive_blk_num, and
> then rebase to submit the new hrtimer patch?
> 
> or
> 
> I directly include this modification in the hrtimer patch in version 10?

My idea was 4: you send a patch series with both patches.

But either 1 or 2 are fine too.

