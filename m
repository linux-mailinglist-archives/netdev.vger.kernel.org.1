Return-Path: <netdev+bounces-195518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B84AD0E9B
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 18:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AD2188F8DB
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96D11E9919;
	Sat,  7 Jun 2025 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtKPYI0j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA845145B25;
	Sat,  7 Jun 2025 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749314524; cv=none; b=Gs3Elunwwgr3ezFnmPxo4OAwt68Mdtn9Ti+Qzs5yPhMq8aAdsN0E8LijOIEjR3vAHWY7mthwqsfJkSUmH0YKq1lbXWWm1+wj9PHbS7medjiPqBnkb36NlJqz9irtHMyixMxQGaD6/hPAB+EMw06ZS/hzX7uZybuKqBGMGZywcVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749314524; c=relaxed/simple;
	bh=ynZCJ1nrnV+rqeUBozQ8goCbs+CWDGu+UF9J+xSskyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2vlaSy+qJxV5h1fbRbF3Q2O2a8/XnTFvwTV8Gp3c9jHZrtdDCM5wNL5TEhPRsfaqMY1SRGNavrYC+7aM/7q3T3fhA360jWvAYTzaFPEqxnQ96G/ETfbGQgQ603JAzy2/3343CwBL8cK9R+1Qk0N/sacBjk9CwCjXOFgjkdq0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtKPYI0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EAEC4CEE4;
	Sat,  7 Jun 2025 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749314524;
	bh=ynZCJ1nrnV+rqeUBozQ8goCbs+CWDGu+UF9J+xSskyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtKPYI0j2A4gqO1XlOgHs7q/kavjHboz9CV1oHxJfP2wropbXFtSlNJG6fs0sdsxe
	 2PHXT/hsnqR0H85KlRREkY8uxLkWmlp8e6o9HtAk5uKy0F4zgTCDGDqmRFaLgkPrXc
	 5bR2m4CKWDFGiMmph7g7u1N9rwq2tuV2TUjjXzI1j3pD9u+FOSlhAS9csY9/oY9WOo
	 HpzRTXlcKHN4EAGJvOon0lz03qPtVhy0myLL6D47rN2LKme/r2hdMlHAhuT5GonxcY
	 +aq5HkFoWaWbGtZ6opDS64CCaLw9qtbCNBwq3MEadkiTkgYuThsdtogNezjbLBP8Km
	 HxvmXLOvunhAw==
Date: Sat, 7 Jun 2025 17:42:00 +0100
From: Simon Horman <horms@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] net: ipconfig: replace strncpy with strscpy
Message-ID: <20250607164200.GC197663@horms.kernel.org>
References: <20250607152830.26597-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607152830.26597-1-pranav.tyagi03@gmail.com>

On Sat, Jun 07, 2025 at 08:58:30PM +0530, Pranav Tyagi wrote:
> Replace the deprecated strncpy() with strscpy() as the destination
> buffer is NUL-terminated and does not require any
> trailing NUL-padding. Also increase the length to 252
> as NUL-termination is guaranteed.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

Hi Pranav,

As a non-bug fix for Networking code this should be targeted
at net-next. And it's helpful to do so explicitly in the patch subject,
like this:

	[PATCH v2 net-next] ...

Also, unfortunately the timing of this patch is not good
as net-next is currently closed for the merge window.

You can find more information about the above,
and other aspects of the workflow for the Networking subsystem
in https://docs.kernel.org/process/maintainer-netdev.html


## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.

-- 
pw-bot: defer

