Return-Path: <netdev+bounces-190602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF36AB7BD6
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5418C784C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B69228DB46;
	Thu, 15 May 2025 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfzSuFn3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CDC288C80
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747277990; cv=none; b=DGrbyd3vQOQvs0qyP2pwajuGdd/7E34d8FgU0sMxQ0q7+53sm+r1sFZoYYlkfj1rj8W514Sa9B04VgmNzZgp/YqFazTXLuaopkvfEAqlpV6L4z4qKR4cGfvPuI/ZngKn12LE5HUi8CfPqN0+KTwTf41Njw9Fd93ad5N7AaHLxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747277990; c=relaxed/simple;
	bh=lcopZlSUVr1HIOY0O+1mk0mCJZZ16k8ZxqxNI3gMHIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uofBUmlvIozyFZUT/6QMMvpqnQmY+IXS+hCTIavPAOZjqCwC5jil9UKeB0r/de/IyYIP0d1PdH02eF2RxGiRfhHW+9lqznMzjze7iAAzlKuzTNOWEt4RP4YUk/5F8H8UWGdNWrZNeh8GqNjJl3U5ExO+GEjAoUk7AuPBsdGO3nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfzSuFn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFDDC4CEE3;
	Thu, 15 May 2025 02:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747277989;
	bh=lcopZlSUVr1HIOY0O+1mk0mCJZZ16k8ZxqxNI3gMHIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfzSuFn3cD8rSiqqEUlZdGSZSG4+N9HCjdao/TZec4Aeh3C3gHOP7Q9yb6vaavLGW
	 SN9yjJgow9LB7yx46MExdxJL3akO0uEmXBD8LfmphzzzdIOpQ+Cmhq0Hm8NyPYGMnE
	 /BzVCd19cZ2/EbYloP/pMn9T6fiYTWfX/y3VOPqaCj7tlOcd7AIbm3DYaj3c0B9RBy
	 ZagHhCxQ2EbdLAAq+vptRAs11/Ow+Ff/4cAEZ5gXqINDm9hDvLrX1YHZATVzBBQhCm
	 plZBz3bUQ4RiYdiZU7DXbTAoI2QeK3knATympRxE9/EtQS6sK1Gpwvkvh3Expu1H7g
	 JHtQuVb5qs7Hw==
Date: Wed, 14 May 2025 19:59:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>
Subject: Re: [PATCH net-next] net/tg3: use crc32() instead of hand-rolled
 equivalent
Message-ID: <20250514195948.617b2df2@kernel.org>
In-Reply-To: <20250513041402.541527-1-ebiggers@kernel.org>
References: <20250513041402.541527-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 21:14:02 -0700 Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The calculation done by calc_crc() is equivalent to
> ~crc32(~0, buf, len), so just use that instead.

I applied this and the bmac patch, thanks!
For some reason the bot doesn't want to reply.

