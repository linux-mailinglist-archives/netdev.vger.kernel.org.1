Return-Path: <netdev+bounces-134443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4524A999974
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 03:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B6A1C21EE2
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 01:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7D78831;
	Fri, 11 Oct 2024 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5c/SGex"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129F23CE;
	Fri, 11 Oct 2024 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610483; cv=none; b=OmifDXtL/U7j+FvIwKwm6Cj6cdNLvJgWyofLc96fOar3aGh/FYwuQF+77JwUq2sq3fX5ZRbye++5HRDC3Btx+et0ACJwRsZR9KsRvlqqgyH2M5qTGirshptiaIO8cTlqeYfJS5ryA9Pt7ZVqCBThd/uW1mmWKLk6jzVt/fDKG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610483; c=relaxed/simple;
	bh=D3EbsXsKzJCQNw6H3MKViPEJwbUULPKmCG7SufDta+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftwUpQAyVp25bydrHX7L82kwaludbBtrnbNFfUJ2Puh9tSQaleVCkuBr8NiDJEVOXR7rhynTR3UlOqBr8pMTkTonQDxLZuLKS+EoovkCASKg7QlO4DrRcxsunlP1F7PKReu7kKihE2evQXpoF7X9RIL/bTfKW/VFKwMWZLqCRFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5c/SGex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8973FC4CEC5;
	Fri, 11 Oct 2024 01:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728610482;
	bh=D3EbsXsKzJCQNw6H3MKViPEJwbUULPKmCG7SufDta+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z5c/SGexv+xUKE51YG8fPzzdsu2NjOkjK1G0fSTDlM8Ze8V4WYAWkDzBQZOSovBL/
	 cv0m/xmz1yaFIKDpx2iAqBNM1YwjTuEOSFJkQQFIJc3dCp3Y7wIE7rEY9Qr5/pWm0u
	 FGoxz3P4nIE4mcJokpZ3p3ujMySDbqywRechLl8ZfXJMLcwl8SVYOhqU5T3U+7bgyA
	 QJhAbg3HEw7RZIUziAOaai01v485GNlNUXnLXeuNJ0GH1zO8eozpcnLB8v8+W/MniI
	 uvviPg73/YgeT9dBHCG6YuuKmgBdwwJUfovrRb/R5deEKqrfkL1CAa6amM5H8mcbRs
	 Z/ou1Ben81e7w==
Date: Thu, 10 Oct 2024 18:34:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
 kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com,
 bcreeley@amd.com
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory
 tcp
Message-ID: <20241010183440.29751370@kernel.org>
In-Reply-To: <CAHS8izMwd__+RkW-Nj3r3uG4gmocJa6QEqeHChzNXux1cbSS=w@mail.gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-8-ap420073@gmail.com>
	<CAHS8izO-7pPk7xyY4JdyaY4hZpd7zerbjhGanRvaTk+OOsvY0A@mail.gmail.com>
	<CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com>
	<20241008125023.7fbc1f64@kernel.org>
	<CAMArcTWVrQ7KWPt+c0u7X=jvBd2VZGVLwjWYCjMYhWZTymMRTg@mail.gmail.com>
	<20241009170102.1980ed1d@kernel.org>
	<CAHS8izMwd__+RkW-Nj3r3uG4gmocJa6QEqeHChzNXux1cbSS=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 10:44:38 -0700 Mina Almasry wrote:
> > > I haven't thought the failure of PP_FLAG_DMA_SYNC_DEV
> > > for dmabuf may be wrong.
> > > I think device memory TCP is not related to this flag.
> > > So device memory TCP core API should not return failure when
> > > PP_FLAG_DMA_SYNC_DEV flag is set.
> > > How about removing this condition check code in device memory TCP core?  
> >
> > I think we need to invert the check..
> > Mina, WDYT?
> 
> On a closer look, my feeling is similar to Taehee,
> PP_FLAG_DMA_SYNC_DEV should be orthogonal to memory providers. The
> memory providers allocate the memory and provide the dma-addr, but
> need not dma-sync the dma-addr, right? The driver can sync the
> dma-addr if it wants and the driver can delegate the syncing to the pp
> via PP_FLAG_DMA_SYNC_DEV if it wants. AFAICT I think the check should
> be removed, not inverted, but I could be missing something.

I don't know much about dmabuf but it hinges on the question whether
doing DMA sync for device on a dmabuf address is :
 - a good thing
 - a noop
 - a bad thing

If it's a good thing or a noop - agreed.

Similar question for the sync for CPU.

I agree that intuitively it should be all fine. But the fact that dmabuf
has a bespoke API for accessing the memory by the CPU makes me worried
that there may be assumptions about these addresses not getting
randomly fed into the normal DMA API..

