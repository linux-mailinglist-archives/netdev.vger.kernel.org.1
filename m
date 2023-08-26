Return-Path: <netdev+bounces-30821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67257892BD
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2BF281763
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 00:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A3237E;
	Sat, 26 Aug 2023 00:43:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6A18D
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 00:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB64C433C8;
	Sat, 26 Aug 2023 00:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693010580;
	bh=OHi//unu0dgaZORSb3vTVvuJD2QQpLeafSDZ4MXXcDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=shNXxyEvMBGBrO1md8O2nMpKMwt+RfNHadEdbAVsaANladXMJokyRO8MJv1N3qxJS
	 WPRBXUUCKWQRLPG2eJesmYcl0C4WcUyscx2xh/S5AQ+sXcYOORpF1B0AthATdcnLKh
	 vri0GMIrop6tA0dAiO4SbgiCHRWOHH4zWbyT3OafTFlZbgj0VqjZawF0XaxGTv4L+7
	 a7klv22wGEqQmJ9J8bXLgGzMEawqfB1S+MT7G0buRDP911i2zx3cO0xQKvSZzs0bou
	 UjJyo9sp20F6q1/b6fb83UBxUgMi5fLArTqFT5SCUH6Oz0hYxctyobViCCfd8C0llb
	 H4FwNSDQRChUQ==
Date: Fri, 25 Aug 2023 17:42:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, Ratheesh Kannoth
 <rkannoth@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Geetha sowjanya <gakula@marvell.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham
 <sgoutham@marvell.com>, Thomas Gleixner <tglx@linutronix.de>, hariprasad
 <hkelam@marvell.com>, Qingfang DENG <qingfang.deng@siflower.com.cn>
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Message-ID: <20230825174258.3db24492@kernel.org>
In-Reply-To: <2a31b2b2-cef7-f511-de2a-83ce88927033@kernel.org>
References: <20230823094757.gxvCEOBi@linutronix.de>
	<d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
	<923d74d4-3d43-8cac-9732-c55103f6dafb@intel.com>
	<044c90b6-4e38-9ae9-a462-def21649183d@kernel.org>
	<ce5627eb-5cae-7b9a-fed3-dc1ee725464a@intel.com>
	<2a31b2b2-cef7-f511-de2a-83ce88927033@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Aug 2023 19:25:42 +0200 Jesper Dangaard Brouer wrote:
> >> This WQ process is not allowed to use the page_pool_alloc() API this
> >> way (from a work-queue).  The PP alloc-side API must only be used
> >> under NAPI protection.  
> > 
> > Who did say that? If I don't set p.napi, how is Page Pool then tied to NAPI?  
> 
> *I* say that (as the PP inventor) as that was the design and intent,
> that this is tied to a NAPI instance and rely on the NAPI protection to
> make it safe to do lockless access to this cache array.

Absolutely no objection to us making the NAPI / bh context a requirement
past the startup stage, but just to be sure I understand the code -
technically if the driver never recycles direct, does not set the NAPI,
does not use xdp_return_frame_rx_napi etc. - the cache is always empty
so we good?

I wonder if we can add a check like "mark the pool as BH-only on first
BH use, and WARN() on process use afterwards". But I'm not sure what
CONFIG you'd accept that being under ;)

