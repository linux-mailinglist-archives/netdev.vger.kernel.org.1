Return-Path: <netdev+bounces-120322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006C7958F27
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314241C20DFD
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664FD1B8E8A;
	Tue, 20 Aug 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FzZsSiNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9815B999
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724185375; cv=none; b=hXPW1b7ApsRllNAMdTYguk01tMLi0sd76n22y0fw2dvkID6rHvnhDnuatcr+3MzcUcYTbFEN0Nes1AnwhIwLi/YmT8QlXOcp2CH2Nz5qpK/n7pLLBTRJ1h7he/jTCkl9Bo6r3P9rf/AG+NV6K4p9NNpcC42hMOEnY3LUxxBcQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724185375; c=relaxed/simple;
	bh=E+kXUwICZYj2HydsIt5fBb+0o9o/27hUbjZYZRkzVD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFA0XBG7PrOt8qBbUiFRoqhDKRhB8OmKjxu4YwH3krpZ1Hm1bLwZmywIcEnnhOD9yVmklNiOw9LIPYh3NwmhetTQzFNKXM54VUBRoP6rLhSRvhkhXzX7SYaG4+sf+xAP5Guc2YQGxJFEFddnCNJxxOH1U1UGj7l4mkf32Jl8rSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=FzZsSiNi; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3da94f059so3459249a91.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1724185372; x=1724790172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LF1xGAzBc+XfrnIu1OYyumZPOyMqmVIc0vNTJwylp/c=;
        b=FzZsSiNiiHRJb6SBmzZcPb/FCH5SuK9YvBKiirHPKah8fL+0eXbpZKe4gB3f/h1L2j
         GWo2VfvBb+2qmTY1No3ActH5q//Z+b//6YxOJc/bFZld+hvIT3/E4USX5tkCugBQ4x+z
         Ju1uHaXHvdiWYhv5yVArgCow0GbuwRp9bQ5EEytL5Tb2oj0OHwl7uobw9NSrvysF5glJ
         Gf2x1jdhxjxQLpaSDZfIeH0Bj2YXaazMtU/zDr/jwevjm0nkWd9riFZtaUPJrMT3/9nJ
         7Xzah2A8FoLqYPI0fZE7BCfhEC1veY03C9CTeJAgtCQbjsG7SukLC60U/jtPQayuY5de
         /nqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724185372; x=1724790172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LF1xGAzBc+XfrnIu1OYyumZPOyMqmVIc0vNTJwylp/c=;
        b=ITVoy/jPFERpQKoNEmIx5b1WtepyOWYdRZGQ52ji0DHHQ+jS+cjRF01psK3ayVZnsO
         T7qt9Rmbj4lazKtRd8iGz0j8uItESW2pcsV8T7Qf2K+EVozOQ0Z0MVpJG1WhbESRJFcL
         ypbNllxnihXImcgS1hhrH1tNUHNiWM254vypwvrmLjStWi5uAJZFfjMj7zq8Rsf1Uf+V
         i0ULKSaK4oq77/h2cdx712zetg0zIkR9orZC7RduWp6h7f/B6cFJrV8lOFsYloc6DjXI
         CIhe2+FkmrCvquNUmtIQCKhHMa44G0f9I8n95IDiBPZc9P1KjhAr+EXEw7Ma+J6VgtUO
         HERA==
X-Gm-Message-State: AOJu0Ywq1K6/vDmRojQEyhKiWvXsRig8yRirbyTJfmGGhR1hzUtsB2A1
	v8T7pVYpFHI36SIoQHG+hN+pV8ktGVVPb2dO0HP2ChqHvoxOVkjeebZeteZw/DA=
X-Google-Smtp-Source: AGHT+IFKLaWCI6pTbg4pWG94rAcL0fmef+3g+t3F0g+/j22778SV3QfJxKbW/f6NTPaLJkCpG2fINw==
X-Received: by 2002:a17:90a:e147:b0:2c9:7a8d:43f7 with SMTP id 98e67ed59e1d1-2d5e9a43943mr115861a91.23.1724185372511;
        Tue, 20 Aug 2024 13:22:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5c2e163a8sm1371608a91.1.2024.08.20.13.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 13:22:52 -0700 (PDT)
Date: Tue, 20 Aug 2024 13:22:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Budimir Markovic <markovicbudimir@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Sheng Lan <lansheng@huawei.com>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netem: fix return value if duplicate enqueue fails
Message-ID: <20240820132250.28bd507b@hermes.local>
In-Reply-To: <20240820154213.GA1962@kernel.org>
References: <20240819175753.5151-1-stephen@networkplumber.org>
	<20240820154213.GA1962@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 16:42:13 +0100
Simon Horman <horms@kernel.org> wrote:

> On Mon, Aug 19, 2024 at 10:56:45AM -0700, Stephen Hemminger wrote:
> > There is a bug in netem_enqueue() introduced by
> > commit 5845f706388a ("net: netem: fix skb length BUG_ON in __skb_to_sgvec")
> > that can lead to a use-after-free.
> > 
> > This commit made netem_enqueue() always return NET_XMIT_SUCCESS
> > when a packet is duplicated, which can cause the parent qdisc's q.qlen to be
> > mistakenly incremented. When this happens qlen_notify() may be skipped on the
> > parent during destruction, leaving a dangling pointer for some classful qdiscs
> > like DRR.
> > 
> > There are two ways for the bug happen:
> > 
> > - If the duplicated packet is dropped by rootq->enqueue() and then the original
> >   packet is also dropped.
> > - If rootq->enqueue() sends the duplicated packet to a different qdisc and the
> >   original packet is dropped.
> > 
> > In both cases NET_XMIT_SUCCESS is returned even though no packets are enqueued
> > at the netem qdisc.
> > 
> > The fix is to defer the enqueue of the duplicate packet until after the
> > original packet has been guaranteed to return NET_XMIT_SUCCESS.
> > 
> > Fixes: 5845f706388a ("net: netem: fix skb length BUG_ON in __skb_to_sgvec")
> > Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> 
> Thanks Stephen,
> 
> The code changes all make sense to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Reported by doesn't really do enough credit here. The commit log is from
the original bug report which had more detail. Fixing it was the easy part.

