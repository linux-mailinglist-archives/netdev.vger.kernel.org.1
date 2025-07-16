Return-Path: <netdev+bounces-207563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15313B07D31
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C57DC7A353A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8E5285C8A;
	Wed, 16 Jul 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cX8FA7jP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7586D2AE6A;
	Wed, 16 Jul 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692040; cv=none; b=tK8S/2CrN7xmX5ZPUuYvPtEg9XB69VfPHZ/t1pG3m1gWTAIiIRggAIRhJ4hoShvt4rXSBdusWRm+VLNPRIaSBgQF3OwpXrjiZNHWvaQzMgeWQqojEvt/ZylnT5bQNhJMAYoGAqakfZaikkvl/YEUcMJ1gBejaElKM4UYmr+dSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692040; c=relaxed/simple;
	bh=5mOnNit1N35Hk5nS6VQeUoZgz0OtTIv1co2eNRp812s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bB9b8uPW098/k3ulhY02zYasZy59oNfszQj6UH07FW4iI15/JO2nDBRh27ZrQOB0Sqc+0scf/8gvFVtxQdfI20fbW1le9m9I72U1A7+VKFprEqNdl7PqNIo7jWSq1J24oN8z1cZG8oJEgk0WMbglKcvJTxpk1VepflWQx/6dDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cX8FA7jP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93EAC4CEE7;
	Wed, 16 Jul 2025 18:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752692039;
	bh=5mOnNit1N35Hk5nS6VQeUoZgz0OtTIv1co2eNRp812s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cX8FA7jPaHmvuGv2dgCGMn26JXOQKwKk3kIMfn3s1ybWX5ZQcSEwfQB7hTuXA3kgX
	 u9UN0z07gPiY6183gvS+AdKGgG9hE3B4aerfniol8wZk9wKN85b8YAesGKBuhiQaSD
	 9CXbPOzQcnPjAIMy1A3WaMiYM9myRwSLXuZXrF3cjWMBBPPC689mCQjlDbEIkEdh3r
	 YoqOtigzPVBIuPb/QN1X/W53oVrHehxzBX/yqEHInsDcQB7JACHL03vRsHs4i4b4fB
	 dr3/Hm2bTaIqiMowA+agv2CNhCIsP9qH+KAMBmVuDiyPoQnBLppfZiaRXGIEdRGHiR
	 Bees3gy9RGGQQ==
Date: Wed, 16 Jul 2025 19:53:55 +0100
From: Simon Horman <horms@kernel.org>
To: mark.einon@gmail.com
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] et131x: Add missing check after DMA map
Message-ID: <20250716185355.GQ721198@horms.kernel.org>
References: <20250716094733.28734-2-fourier.thomas@gmail.com>
 <9ba42e9ae61e8274bf5d677f8d53c84f6841ccd8.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ba42e9ae61e8274bf5d677f8d53c84f6841ccd8.camel@gmail.com>

On Wed, Jul 16, 2025 at 12:19:50PM +0100, mark.einon@gmail.com wrote:
> On Wed, 2025-07-16 at 11:47 +0200, Thomas Fourier wrote:
> > The DMA map functions can fail and should be tested for errors.
> > If the mapping fails, unmap and return an error.
> > 
> > Fixes: 38df6492eb51 ("et131x: Add PCIe gigabit ethernet driver et131x
> > to drivers/net")
> > Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> > ---
> > v1 -> v2:
> >   - Fix subject
> >   - Fix double decrement of frag
> >   - Make comment more explicit about why there are two loops
> 
> Thanks for the updates Thomas, LGTM (also CC'd Simon who provided the
> initial comments).
> 
> Acked-by: Mark Einon <mark.einon@gmail.com>

Thanks, also LGTM.

Reviewed-by: Simon Horman <horms@kernel.org>


