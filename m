Return-Path: <netdev+bounces-143815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271F9C44E5
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171422807B0
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8DE1AB53F;
	Mon, 11 Nov 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdyrfDyI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C111AA79E
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349340; cv=none; b=hid0A+EBPqzDbMzqnR8dQjchvOA/oy2bdhyCb3xspSCvRXZeLoUUBWIVEfKxTJcgHsFIe6L+yRITgegJCMTgYvRe3dkRfWCAsCjwYRp9KA1vysEF+DmAIfiTu7SHL7rskfDuQKNhaGiQ4CcBXkvmLm6SsCqt4p3gJ45OVNOl14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349340; c=relaxed/simple;
	bh=VkktJLgaO9qR/Rqii5seF0L8dojiB7qSWRFJU/PoWjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKO4DVYpT1G/354VFXp1jTi5KraAdeuR1YuLlgSwDg6zGnNBv1VxYRRqzMYM5vDjcFNSbxrrmEIv8aibnel+B7LYuzD4rpga88gBMLsNK9e+iBLV41BYNtGFJGFmYOPny3XIx04qItJhpATN0SH/RSTFfMjRQ++8+9SfuhAReQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdyrfDyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837DEC4CECF;
	Mon, 11 Nov 2024 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731349339;
	bh=VkktJLgaO9qR/Rqii5seF0L8dojiB7qSWRFJU/PoWjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SdyrfDyIeSa1Mw+eFjxN8SpLmuS5UVeQhw1OX+k2Y5BFOF0CY1x5WGUpTWsgeWwof
	 M9TzV1p/iSRm19pihFjNQaXALe9evZg5S2PFmlrQLQgl7bc0u+UHmB98Ya4eBwRzcU
	 7cGBjUxYUdUmCWi2mP74QCvIdcXaYB5V6x8oRQugZ32Vsi10Gq/l8UzOwFZ4VJiA6g
	 Dz0dOqRX0fXP1JmBFpAZzAk76CoipPM+CMftUtmEQP2/v6wW+1IU2BqGkE3hw/7kG/
	 tpcK3gM4hDXshOaLVsIsqi/7e++99G6KwMleuyhdjFfPYUt/o5DgrbbpsNm1cxGl+W
	 AS1Ij1ng6I7FA==
Date: Mon, 11 Nov 2024 10:22:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, Daniel Xu <dxu@dxuuu.xyz>,
 davem@davemloft.net, mkubecek@suse.cz, martin.lau@linux.dev,
 netdev@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context
 action explicit
Message-ID: <20241111102218.0e1b3ac9@kernel.org>
In-Reply-To: <7724370d-5e8a-bf98-421a-3a69294daa8c@gmail.com>
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
	<ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
	<Zy516d25BMTUWEo4@LQ3V64L9R2>
	<58302551-352b-2d9e-1914-b9032942cfa3@gmail.com>
	<20241109094209.7e2e63db@kernel.org>
	<7724370d-5e8a-bf98-421a-3a69294daa8c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 10:47:47 +0000 Edward Cree wrote:
> On 09/11/2024 17:42, Jakub Kicinski wrote:
> > I'd suggest we merge Daniel's patch (almost) as is, and you can
> > (re)establish the behavior sfc wants but you owe us:
> >  - fixes for helpers used in "is the queue in use" checks like
> >    ethtool_get_max_rss_ctx_channel()
> >  - "opt in" flag for drivers which actually support this rather 
> >    than silently ignoring ring_cookie if rss ctx is set
> >  - selftest  
> 
> Sure, I'll get to work on those.
> But I don't think Daniel's patch should be merged; the old output
>  is confusing or misleading, but the new output is incorrect (when
>  run against a current kernel and sfc, or a future fixed kernel and
>  any driver that opts in to allow nonzero ring_cookie).
> If ring_cookie is nonzero then it *must* be printed, unless ethtool
>  has some way to *know* it's ignored.  Regressions are worse than
>  existing bugs, after all.

If you promise sending patches for the kernel side validation soon -
printing when non-zero makes sense :)

