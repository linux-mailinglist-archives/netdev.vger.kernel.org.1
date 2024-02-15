Return-Path: <netdev+bounces-71891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBE4855857
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DA61C223B8
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 00:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA4639;
	Thu, 15 Feb 2024 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9vsonBp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ED1623
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707957380; cv=none; b=h0/O4rhzjgEChvBA0iWfWn9UP82IapBrFH96aFwjvT20/ZLd6LPi4EyEcyKXttS0oVkC31DXZRwPdgcicPoQCvs16UdrYo6dE/reyVV3DvNjL8n4DEidlps/F1Tl+Os6XKQ1EUfI/wZTEAn/WFUFMuGZObuki3zQIgCpiKuVZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707957380; c=relaxed/simple;
	bh=yZXNywq+jH/3EcQoyJzddecCsyCJjxBPogPn3wRz2uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jvpvvo/qzator2UtCcapKiCG0wiV4IhuD3ehH916Qr86mm5yADsVvCBGnxi023mHZH2ggZcwZwKRLZeJ6sHx9UpHlCujUYF6u6YHFU43fRwXjW9noGolFgwC0hM0F335W7JJpMLdQ0dcM5fEe0AOzbR9WzBwNUWyG1nB2ZD2W/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9vsonBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA12C433C7;
	Thu, 15 Feb 2024 00:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707957380;
	bh=yZXNywq+jH/3EcQoyJzddecCsyCJjxBPogPn3wRz2uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i9vsonBpx2wAuAlmBY9H4eDBR5bGQS/s05Nh33yEbBBlNqzqlJ9jbcBe5rjGoSWdy
	 YutQ1F7QF72ileYdBJ7xQRYdWbUq2pJY9WuY+VAg2luZR+uATMTRbJEWCapV7Mv7pB
	 kuLss72PPFr5Iodj6uOJUPj6AHsVXYCESG/J3d17e9lTJRIaQ08sw4iGJbY8DnGiFi
	 m2E8Pf40bPLfJT7vSlDNCQJec8pcHCaryZzxq4ogmaVJRJIzfksiNJf33MHKIY8dKq
	 rY05d4dOQuQB2ibY3D/pZ4zQQdDpGItuLjVhkWR1d8kQshESxlerhxwsH3DZTN0Hwk
	 yz2V3L4LcQ02Q==
Date: Wed, 14 Feb 2024 16:36:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Alan Brady <alan.brady@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, <netdev@vger.kernel.org>,
 Emil Tantilov <emil.s.tantilov@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH 1/1 iwl-net] idpf: disable local BH
 when scheduling napi for marker packets
Message-ID: <20240214163619.522486a5@kernel.org>
In-Reply-To: <2e3001f8-a079-4d44-863f-979baca3b38c@intel.com>
References: <20240208004243.1762223-1-alan.brady@intel.com>
	<2e3001f8-a079-4d44-863f-979baca3b38c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 14:16:47 +0100 Alexander Lobakin wrote:
> > Fix softirq's not being handled during napi_schedule() call when
> > receiving marker packets for queue disable by disabling local bottom
> > half.  
> 
> BTW, how exactly does this help?
> 
> __napi_schedule() already disables interrupts (local_irq_save()).
> napi_schedule_prep() only has READ_ONCE() and other atomic read/write
> helpers.
> 
> It's always been safe to call napi_schedule() with enabled BH, so I
> don't really understand how this works.

Sorry for late reply. IIRC the problem isn't a race but the fact that
local_irq_restore() does not have a hook for BH. IOW we may just set 
the bit that the BH is pending but never call into softirq.c to run it.

