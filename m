Return-Path: <netdev+bounces-39149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A04AA7BE3A9
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7AD2815AC
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B11A261;
	Mon,  9 Oct 2023 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWOqcytI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906A7493
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 14:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50892C433C8;
	Mon,  9 Oct 2023 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696863355;
	bh=b4xb+NjV8HwpVkf8km8Vp0zN8pTTrOozJrKIMoJyLcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWOqcytI+XckEtep8gcLcnVxKUZPsQKKDxNfus6FUyAOCrvufvZYWBcVrZPP5W2r2
	 O8ZGaelEHzyp1zF6zwkfSJaOev5td/25Kt7raz/GgCo3qjdZknpJBgz1AbzkcX0RdN
	 64GzL5ANpwg216deDrETDk+qX6so+f+Xmmd71DxI0jnPX9h/qayFTBdZcjh/lAnD+v
	 pTmBxpSLfebiXyxinwVZ0g85L/WkfedPrSH4IsIDxJnxRB7WIXUscXysVK0vTMCiKN
	 0OynMnvemuSieXrdqlZEx95o6ZmLQvAqNaT1L86LcrQrUsIRlrD8V33mU2BqdlMAvD
	 idw1DnDLWNCbg==
Date: Mon, 9 Oct 2023 16:55:50 +0200
From: Simon Horman <horms@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: jreuter@yaina.de, ralf@linux-mips.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ax25: Fix potential deadlock on &ax25_list_lock
Message-ID: <ZSQUdhzSDpAlaeXK@kernel.org>
References: <20231005072349.52602-1-dg573847474@gmail.com>
 <20231007151021.GC831234@kernel.org>
 <CAAo+4rWTq33LWgVonaK+AtZ0o_UYFLrM=ODW=hSX_VtgLvYHNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAo+4rWTq33LWgVonaK+AtZ0o_UYFLrM=ODW=hSX_VtgLvYHNw@mail.gmail.com>

On Sat, Oct 07, 2023 at 11:43:59PM +0800, Chengfeng Ye wrote:
> Hi Simon Horman,
> 
> I think maybe not. My static analysis tool only reported this function, I
> also just manually checked the spin_lock(&ax25_list_lock) in other
> functions, and it looks like they are basically under rcv callback or timer,
> which already have BH disabled. I think the developers who wrote
> the code should be aware of this so they used spin_lock() instead of
> spin_lock_bh().
> 
> But the fixed function is a bit different, as it could be called from .ioctl(),
> which is from userland syscall and executes under the process
> context, and along the call chain BH is also not disabled explicitly. That's
> the reason why only at this place I change to spin_lock_bh().

Thanks,

I agree that seems to be the case.

Reviewed-by: Simon Horman <horms@kernel.org>

