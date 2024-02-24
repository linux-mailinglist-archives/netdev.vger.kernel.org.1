Return-Path: <netdev+bounces-74653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110C86213F
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 01:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1AB72891DC
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 00:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330210F2;
	Sat, 24 Feb 2024 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUvLoG54"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2CE4A03
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734772; cv=none; b=OtA99+sSxa5dqk705EnwUXFwbC5nK89CmqPb4nh73c+urxkY84XBOZSfjzCB0n87HI4IBZcbq72lIOn0ybJymKOlDQxYJLI3vSTvkX7Y7CfLgEiHCsaLL8GeTT4GD3nA/0Ic0iZ21ht8EnHqyowoep20KKra/yJCd8nHHZlEhWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734772; c=relaxed/simple;
	bh=ub7UBmnVM6+Ps05PvuNsCPXzko8biV2GdODZ+hTnX50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3jL5/geSz2lPXduZFKPR8/IKOLoxbHJReJXYohnupbn1rogXws+rrOutyIqfbaaqGto+5dtLB3kETJcYjPGnIxl/qbd5yAtymWefEGyuojs4iO3FAQynu1Y8Dp8ChS65Z+dH90Iy/7rl0pFZ3DYo0VWnDwerwf3jWT9E2LOYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUvLoG54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF04C433F1;
	Sat, 24 Feb 2024 00:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708734772;
	bh=ub7UBmnVM6+Ps05PvuNsCPXzko8biV2GdODZ+hTnX50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SUvLoG54Q2693dozw010f0TALFtoeKI3eWI4gxt1Y2P7QxrtRBAZm8oAqLSAfglFn
	 fAb05UIwtakOGmDW+gqF6AlOhLtqf3oXRfHVuqJxlFPfLQ/x+KbEn8WpjiE++JUDf4
	 40pUEmzEu0U3GMrPU/7hhiUoqyJBRLNQvWkCWA4x/l96yvF4i4CIQ3kBjPTy6KeCjU
	 LvJWWT8Qhw++eEKWl+mc1MyyVemWXr7D0CtmvUNLUMR6gMnRQyLTbjYJoNkhxCYCMH
	 cgSD3ywCbFMq3brmE0mJfMQuoIeEr56DYOshEqm9dWwC+GvU8a/WRk1IpX1gjers5h
	 SBM8Ia7qzm8gQ==
Date: Fri, 23 Feb 2024 16:32:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com
Subject: Re: [PATCH] stmmac: Clear variable when destroying workqueue
Message-ID: <20240223163251.49bd1870@kernel.org>
In-Reply-To: <20240221143233.54350-1-j.raczynski@samsung.com>
References: <CGME20240221143239eucas1p259ca215d24490cd7fc073a6c3c35693b@eucas1p2.samsung.com>
	<20240221143233.54350-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 15:32:33 +0100 Jakub Raczynski wrote:
> Currently when suspending driver and stopping workqueue it is checked whether
> workqueue is not NULL and if so, it is destroyed.
> Function destroy_workqueue() does drain queue and does clear variable, but
> it does not set workqueue variable to NULL. This can cause kernel/module
> panic if code attempts to clear workqueue that was not initialized.

Is there no risk that we'll try to queue_work() on the uninitialized
workqueue?  I wonder if we should also set __FPE_REMOVING when the
queue allocation fails, just to make sure we never try to queue?

Please repost with a Fixes tag added (pointing to oldest commit where
the problem may happen), and with [PATCH net v2] as the subject tag.
-- 
pw-bot: cr

