Return-Path: <netdev+bounces-135378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E899DA9C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 02:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4783B21EFA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 00:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3524EC5;
	Tue, 15 Oct 2024 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEYqyLZ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC04A23;
	Tue, 15 Oct 2024 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728951398; cv=none; b=rwwEwl/7ktG3PMqhDtiJ3hXMuGXtx5z+kD34TBL6CXUZ0vgajoZHkfs+vZTQAcF36sqmRiZ6bIUfoUnF5hic9A256KDcSO0Z5hPGrgVP8F3wChBErDE62yg9Uwhh6XqoAXWn9RTm2La+HYyfBjDxz+3JonXG7LMRr4sil2Vc7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728951398; c=relaxed/simple;
	bh=4zpYAawqxdZUEk9xwOfLz2iarKQKDbVOEKBFVDtujkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T68iTjPjlrDx2FjsClfbmqH9KMFvqINu4LCpdTW4Gvhseei38fqkR8sVRpeQwbGPCCq3XS8Sfo06DTG3d1hsYvohFtFb4K9P2S2Sq29hAlNdd6MbUg+icLOpvnzVzyqgL9Z33+gWljk6BZgzeaCTR3POveRCO2014ToImcxeaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEYqyLZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EBEC4CEC3;
	Tue, 15 Oct 2024 00:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728951398;
	bh=4zpYAawqxdZUEk9xwOfLz2iarKQKDbVOEKBFVDtujkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CEYqyLZ18f5xEc5QFWaKzkixuFeLEfyihg6riilqDKRkZkQQw2HFrjf/llZhPh89g
	 Z5gl9tsWr1RskZblQjXDv8OaHZI6C7I+wZhmoH1PgH7o3JA+Meszadp6Fp2lw0/wVS
	 /KHdkyNS48n/9HgQr6GOtKr3DfWIzEetxH85yE0IWS+POo5oq+ZqNw4Q3uX4OQ3tk+
	 mkf099a5xXYbuHxXf/g5x2c2JIgG0qa2hpUGr62L41iheQ42KHZV/YNikn6DHDrTKI
	 4jgNDQ3mFNY0QqEotb6zDLT4Ro/VGLDlLtlsqINRr/MKOXuF8cn5yBn4CnF7tgjIey
	 5czTw54Nnxjng==
Date: Mon, 14 Oct 2024 17:16:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leonro@nvidia.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Samiullah
 Khawaja <skhawaja@google.com>, Taehee Yoo <ap420073@gmail.com>,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, donald.hunter@gmail.com,
 corbet@lwn.net, michael.chan@broadcom.com, kory.maincent@bootlin.com,
 andrew@lunn.ch, maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com,
 bcreeley@amd.com
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory
 tcp
Message-ID: <20241014171636.3b5b7383@kernel.org>
In-Reply-To: <CAHS8izNzK4=6AMdACfn9LWqH9GifCL1vVxH1y2DmF9mFZbB72g@mail.gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-8-ap420073@gmail.com>
	<CAHS8izO-7pPk7xyY4JdyaY4hZpd7zerbjhGanRvaTk+OOsvY0A@mail.gmail.com>
	<CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com>
	<20241008125023.7fbc1f64@kernel.org>
	<CAMArcTWVrQ7KWPt+c0u7X=jvBd2VZGVLwjWYCjMYhWZTymMRTg@mail.gmail.com>
	<20241009170102.1980ed1d@kernel.org>
	<CAHS8izMwd__+RkW-Nj3r3uG4gmocJa6QEqeHChzNXux1cbSS=w@mail.gmail.com>
	<20241010183440.29751370@kernel.org>
	<CAHS8izPuWkSmp4VCTYm93JB9fEJyUTztcT5u3UMX4b8ADWZGrA@mail.gmail.com>
	<20241011234227.GB1825128@ziepe.ca>
	<CAHS8izNzK4=6AMdACfn9LWqH9GifCL1vVxH1y2DmF9mFZbB72g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 01:38:20 +0300 Mina Almasry wrote:
> Thanks Jason. In that case I agree with Jakub we should take in his change here:
> 
> https://lore.kernel.org/netdev/20241009170102.1980ed1d@kernel.org/
> 
> With this change the driver would delegate dma_sync_for_device to the
> page_pool, and the page_pool will skip it altogether for the dma-buf
> memory provider.

And we need a wrapper for a sync for CPU which will skip if the page
comes from an unreadable pool?

