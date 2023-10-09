Return-Path: <netdev+bounces-39186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE607BE474
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1D42823B7
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD136B14;
	Mon,  9 Oct 2023 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSbOy7ti"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8736B09
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D296C433B7;
	Mon,  9 Oct 2023 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696864671;
	bh=IxC3QSqPVebIUIRAWD+xhWprjzDHOIt3IBTBrp48heo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QSbOy7tie+ysnc34WLh7T8qM5g5Hep59jVakIVVg7b/MLulFFJE5pGb2GEvBqMXGP
	 KnPwAWfAtpkN5ufKCIYccOCr0pHzqBOgPgWGVayiYQ3kTC8V8nhQEci7ZEfbkKpNr1
	 dWuP2ig4eXLIFQYtUdJrBCCYEzfViD6GeE8o21oy8YYoi1kUdDEe78p8H/dA684ILU
	 iqpceVibFcCNj/hVcRFLegXJWz4fcAvOEN80JOMXa+CpkPMfLyiKIjst/IFXBx6ehk
	 vqoKVr/tZVUXoOR+jWI7fUWXRUkJoPfK3ASN++C+Ec0RxBwr7+yPGQ5F8Wdllz93uT
	 mTUCc57DJgP3g==
Date: Mon, 9 Oct 2023 08:17:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: 3chas3@gmail.com, davem@davemloft.net, horms@kernel.org,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] atm: solos-pci: Fix potential deadlock on
 &cli_queue_lock
Message-ID: <20231009081750.2073013d@kernel.org>
In-Reply-To: <CAAo+4rUE=+9Kp8CvMH3w15dJotkX03h=5YMV+hu-YSobkwj1NA@mail.gmail.com>
References: <20231005074858.65082-1-dg573847474@gmail.com>
	<20231006162835.79484017@kernel.org>
	<CAAo+4rUE=+9Kp8CvMH3w15dJotkX03h=5YMV+hu-YSobkwj1NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Oct 2023 23:58:36 +0800 Chengfeng Ye wrote:
> > and irqsave here. I think you're right that it's just softirq (== bh)
> > that may deadlock, so no need to take the irqsave() version in process
> > context.  
> 
> Yes, spin_lock_bh() is enough.
> 
> I just found spin_lock_irqsave() is more frequently used in this file, so I
> also used spin_lock_irqsave() here for uniformity consideration at that time.
> 
> Should I send a new patch series to change this to spin_lock_bh()? That's
> better for performance consideration.

Yes, performance is one reason and another is that the code will 
be easier to understand if the locking matches the requirements.

