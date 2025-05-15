Return-Path: <netdev+bounces-190759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA25AB8A23
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7C13AC146
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD010192D6B;
	Thu, 15 May 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tStfSvTy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194F23BE;
	Thu, 15 May 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321242; cv=none; b=Maa6HP7PhG6siYAz4V9PY4p68xfinrftsK4zrElU617IaSwPlkcO4uPPOKHXyyIgiImfDoouIGYsjEhOWCTlZ1aENW68cXLJL03JLRDe6Plzla7i/lhtvIGYnH6/m27h3P+2nMP82LXFbOtFyVn6ET+180etISas68u+F+elQMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321242; c=relaxed/simple;
	bh=vWBcVEBt9dCC+O+RnjtHaHvUDgf+jw1kKI9S0BIsA4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYmxUJilWyZnY/BS98wBVX8yz364y0gjyx8i6asH52czVRBpBETr2mvAAAMA7RceGFSMqO78CYzELFnejr/OOoqHLcw9whf/jSGr8EUjJQ4aKWPZK3q//DK8WydZdfvrXgGjgfh4p6Q6312HFCACNFrvhtpDrGir8qRAlXxbza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tStfSvTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30ACC4CEEF;
	Thu, 15 May 2025 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747321241;
	bh=vWBcVEBt9dCC+O+RnjtHaHvUDgf+jw1kKI9S0BIsA4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tStfSvTyuvG16wP9HwTchyYrMdIP0W/bAjv/CihRIdkXdVOhUcUrfb9OhgWw+bM7n
	 tnAIdshCxQ4Fa73xYtSkQ+3ZLLUYfIDbOQFmnnQQH7tgBIDRlH5Am9vpdoB6LOIiFP
	 ZX6XDLFAZlpFrovV9ilFQq3k+GBwZzU+cyXvY/BURn/hXH7u3lsapQySMtvRJuE0pD
	 coMEJxBy7eiLq6HsrQF04mdkcNFEgcALAurkY3X916kH1l9O7xU3p9jO/fj18VbmSh
	 8PdtH8a9zMdNg3woQjj86S/mwHWxP1/levhVZ0lRWZnZrcDUxep6/YGE32sfG1UDfI
	 gc8fVk/ri1S1g==
Date: Thu, 15 May 2025 08:00:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marios Makassikis <mmakassikis@freebox.fr>
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com,
 linux@armlinux.org.uk, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net: mvpp2: attempt to refill rx before
 allocating skb
Message-ID: <20250515080039.12c47bd3@kernel.org>
In-Reply-To: <20250514173417.276731-1-mmakassikis@freebox.fr>
References: <20250514173417.276731-1-mmakassikis@freebox.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 19:34:17 +0200 Marios Makassikis wrote:
> Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
> Fixes: d6526926de739 ("net: mvpp2: fix memory leak in mvpp2_rx")

Please repost and CC Lorenzo who wrote the commit under Fixes.
get_maintainer would have told you to do so (if run on the patch)

nit: Signed-off-by should be last
-- 
pw-bot: cr

