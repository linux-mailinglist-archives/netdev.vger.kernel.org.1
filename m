Return-Path: <netdev+bounces-83769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED944893C86
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD4B1F22414
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B94502B;
	Mon,  1 Apr 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu30xVjt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9F4501C
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983797; cv=none; b=WPkeIVwJSNGOoDtfGkRlavxtSxejETyjG8HcfVtI/iqoMA1nsx7huoK9g54xVMUpeMlpDUZEE0tlzymUPd9m2rPDiYO2LM7ihockpsMUkd34gjtEAKdIg0pp9o9VuZtX0MfKs6FwceY1REALOBKSnoUHjfpT8DsCC4Ja7CODTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983797; c=relaxed/simple;
	bh=kiOJAYp7gp5kQYKKLzbkNIKsend0a8KCs6fakv2C1ug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mko/CJ1xWJP2nXuQfiMmsDzcnVZM2dLkXZzvgDNjRJqOK57myWBfXEd7wINjslL/31iXHZLyt5se9Qf+dM3/36hzCG1I5hOdEGzzJIdGBx1Qw02FCvOJnYaFSD/OclwNzKoAhcrO5gC0ASbvLEcrClzJHaeG1i9Js57GNCSkVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu30xVjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592CFC433F1;
	Mon,  1 Apr 2024 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711983796;
	bh=kiOJAYp7gp5kQYKKLzbkNIKsend0a8KCs6fakv2C1ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nu30xVjttwvQBfIXgabyWStlopbuNZ9J1HpEmeE4GHr4fUqhM74jMBE9SDD+B3JN5
	 vutrnClFHz8QvDWpwboAn4teOyDPBtvk3RrI7t1GhnDjzmALyRspT2/8Bh/4S5Ao8T
	 e0cH1SifVthCpdmS4zvg+PiGGYBUCB7rGBINMRFouVxQJSAQKSHovu0nacXX7qy/cG
	 dRwIEoQ1i9x9y+IwyqilDnCCb2eWADuSQuZAaLS94XXQAgwJJYxJ8Cdef2a5j1voj2
	 qPLBKZ/NX6T7gN3+Dos9gDsKLzc4oWuB2Sf+dth6intY+I9ULjuZtmnbUBLmLDv9BT
	 w5+BmCWh550Cg==
Date: Mon, 1 Apr 2024 08:03:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Aya Levin
 <ayal@nvidia.com>
Subject: Re: [PATCH net-next 5/8] net/mlx5e: Expose the VF/SF RX drop
 counter on the representor
Message-ID: <20240401080315.0e96850e@kernel.org>
In-Reply-To: <e32e34b7-df22-4ff8-a2e4-04e2caaf489f@gmail.com>
References: <20240326222022.27926-1-tariqt@nvidia.com>
	<20240326222022.27926-6-tariqt@nvidia.com>
	<20240328111831.GA403975@kernel.org>
	<20240328092132.47877242@kernel.org>
	<e32e34b7-df22-4ff8-a2e4-04e2caaf489f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Mar 2024 21:52:06 +0300 Tariq Toukan wrote:
> >> Hi Carolina and Tariq,
> >>
> >> I am wondering if any consideration was given to making this
> >> a generic counter. Buffer exhaustion sounds like something that
> >> other NICs may report too.  
> > 
> > I think it's basically rx_missed_errors from rtnl_link_stats64.
> > mlx5 doesn't currently report it at all, AFAICT.
> 
> We expose it in ethtool stats.
> Note that the "local" RX buffer exhaustion counter exists for a long time.
> 
> Here we introduce in the representor kind of a "remote" version of the 
> counter, to help providers monitor RX drops that occur in the customers' 
> side.
> 
> It follows the local counter hence currently it is not generic.

I thought you'd say that, but we can't apply the rules selectively.
Everyone has "local" counters already when we add the generic ones.
Especially when we start broadening the "have" to encompass other
generations of HW / netdev instance types.

