Return-Path: <netdev+bounces-227734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B22BB6643
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 11:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6A9C4E8FD7
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64A32C08A2;
	Fri,  3 Oct 2025 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejrUzvIH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB30219309C;
	Fri,  3 Oct 2025 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484451; cv=none; b=s/g65nJ6dRtrp0t9tRuU7S4yNF63BOlbowBhNbWNfMz8bsSlGLqPfVa/mUGE3Xv0LK1D+nO9UvdD08p9EC5KV3YoHK7Eq1ocdgOwTRBrAzF1bqDOCrYPwJwZR/nAnH85o+B0x/TSrIXRjfm6fzecl2m5IoeXzqeqDBINkw4ERyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484451; c=relaxed/simple;
	bh=xYS7ueSgv/ypF2IM289RgL4t+AIcFcxwlcqRZhQR5O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uve0QHgITHpEE9JD/PzFoJrA7iRty298WTHvDl6uMtzrdj1CuWB2ezwRlNn+Zdw+09Hb0VTWEFY2lQKnih6f/hDQJFQRRqvpKtaRCMrKdlFMtLaM2f2Sgk6UmhtfMor+eSiFzZHPDbnnDwnfC/dm5tTHVNpJB2WUyBNyXusJwLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejrUzvIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7666C4CEF5;
	Fri,  3 Oct 2025 09:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759484451;
	bh=xYS7ueSgv/ypF2IM289RgL4t+AIcFcxwlcqRZhQR5O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejrUzvIH70X6vDVLLjQfTpJ8s9SkyxmGgK/9xD7P8bxYHgVM3+UgBRyw389jACa/B
	 +WTY2U3bjWSLKzguhd1sOIXiByXec83eAPsaI7fLnf/3bFW6ZXXO7V9eDTUHG7gkpx
	 UWZDGzfPxojYPyUD9QnOUvUSg34wj8ffNuA2HyOJXi39t3MHj/opM5sCArTZXlAeYB
	 WVjfhfuf562yIfqwBVQzDG1hO0UD778UnG7MutAExDArl4TOKDXi+FBdm1yczgIxN+
	 02XOtGkMWq0j6ftEwI0/VlpS8ImiOVn68IoIsWjxHzegxBIDMcfb9IIRJdCx08LRao
	 p6Oap2MpdtUaw==
Date: Fri, 3 Oct 2025 10:40:47 +0100
From: Simon Horman <horms@kernel.org>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
Message-ID: <20251003094047.GD2878334@horms.kernel.org>
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
 <20251003083312.GC2878334@horms.kernel.org>
 <CAL4kbRN=ktZc8fkcjo90GM2EBgCVt_xVmSGVQuM8gE2qV3ZJKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4kbRN=ktZc8fkcjo90GM2EBgCVt_xVmSGVQuM8gE2qV3ZJKw@mail.gmail.com>

On Fri, Oct 03, 2025 at 02:32:02PM +0530, Kriish Sharma wrote:
> Hi Simon,
> 
> Thanks for the review and guidance.
> I’ll prepare a v2 targeting the net tree, updating the patch subject
> and incorporating the suggested changes.

Thanks!

