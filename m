Return-Path: <netdev+bounces-134519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4BC999F79
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1171F21552
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4239620B219;
	Fri, 11 Oct 2024 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1SmeN0t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E64620B216
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637073; cv=none; b=XQ+xb+Lwzla8tqR+sfNhTW/RyptPJuXy+BBLISRiWQQAMJbGV3UHQ/uRkhPqZeK3uVIVi+K/8FSGeSR3kHMXqTMd+02KAvLmuYETq2SyvH0W3ObviwDdVXhkNjdnQENqm2D5rQxSwrG9JjzwlC7VTXnFZhU5HX2YnuWebEEkjZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637073; c=relaxed/simple;
	bh=QsW6eVk7BOiCDS8Nh1heJzIAyUHN9cQ/N2KP+r6/tt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1f/xPPqhVGo8lMDDYdw3aen75XYoBvOw7Barim5zvtY97U9MqZwDX4N991SQ9N+R2k7eBeYfbf2wnKnvAkIKn+di8QT42Pe8JTZt+hoGgg58nN0w3aLjhw7ymrQMCP0Ax/IIu6kRAaOE948/VBjWSr2vUK/Fd4J612oXZnaYjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1SmeN0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159D9C4CECC;
	Fri, 11 Oct 2024 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728637072;
	bh=QsW6eVk7BOiCDS8Nh1heJzIAyUHN9cQ/N2KP+r6/tt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1SmeN0tPKISH69/Z43TYksfw+j8+/mkI3g0CuJCJVCCX+2Cg+AKTwQ/lItyFrD0f
	 itD1X1PSw9WjPg1bYd9c4qo7hO+2O8tD1KOEdPNNWQgGnOtReIgcauoLqnF2n7sgqT
	 SxifeZ6UIc9qJFHBaRCofBfU9wgFGsxIzGsG2pXQ3nIaOV+sMm1bVmf+foOYC99hG8
	 DgPjfGUuUDBsFes32HYQYdJFrbFbXsmh39qmPjme1zqFbWJFPhzhIokY6B694RPCe9
	 ANPHHgwpjwQIwWV6c9ZQoZRyTGzRCv6FXgtn/5VyAAFdipj1KxCKoHSaxaV8AWG9ki
	 i3ljPjSeUlCrQ==
Date: Fri, 11 Oct 2024 09:57:48 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: enable SG/TSO on selected chip versions
 per default
Message-ID: <20241011085748.GC66815@kernel.org>
References: <5daec1ce-1956-4ed2-b2ad-9ac05627ae8f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5daec1ce-1956-4ed2-b2ad-9ac05627ae8f@gmail.com>

On Thu, Oct 10, 2024 at 12:58:02PM +0200, Heiner Kallweit wrote:
> Due to problem reports in the past SG and TSO/TSO6 are disabled per
> default. It's not fully clear which chip versions are affected, so we
> may impact also users of unaffected chip versions, unless they know
> how to use ethtool for enabling SG/TSO/TSO6.
> Vendor drivers r8168/r8125 enable SG/TSO/TSO6 for selected chip
> versions per default, I'd interpret this as confirmation that these
> chip versions are unaffected. So let's do the same here.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


