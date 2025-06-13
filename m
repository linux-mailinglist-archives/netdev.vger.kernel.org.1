Return-Path: <netdev+bounces-197577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52148AD93B9
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5163AE4E1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6102236FB;
	Fri, 13 Jun 2025 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEsT7eRL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEF1221D94;
	Fri, 13 Jun 2025 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749835327; cv=none; b=FWQ3zXI5/7k8s2lZN1szdV9AOSKKFsadjBLyT0pBENHVidWETOwfXoS2w7YLHgv8UXyEf9dlVEGc2rQqJVY9K/n2ZeeQrBob1SvtgwwANr03s1Tselo5wS8XHshm/GpUzSutypBwbDZqs960rJ0LIpz5DxiHPMBMuVfd3tol0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749835327; c=relaxed/simple;
	bh=vwBsTCNzuvd2dupHBYfyTfQ8bE4absbZ11K/tiCsRNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B71+T2GpOTn4rDOv2rvqX37t3ZkvhwjLFfzBPFcQHQ5vOW71H6ZhVeBAEqXXUQ19q24MYGPOnQr0G/9aGp13+La+zmLjwtzgYfp6ikeFz7TXK8q1LufMcevvFlrBarrcRdHk2s4x48C2eQWeroOM24HpsjlrhmBT6anZsjDREYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEsT7eRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C81C4CEE3;
	Fri, 13 Jun 2025 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749835327;
	bh=vwBsTCNzuvd2dupHBYfyTfQ8bE4absbZ11K/tiCsRNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEsT7eRL6JrEIuku4A0EIVBooeMAO8jrzb2HeqEXKKjOeHx8i3OVLyniOOizD0jsS
	 FZRERjS9f5/nWwQmlmGPMrjML6VUZsIuv0AHqou1jLGY2h2yGiYT7YtjPq8x9tQ2Gi
	 en9AbvEZqRGwEroqPIAYt2bdu4Uqu5A4XNebI/1ga9brxLyYHNswSYe/mt2CP4x0ST
	 043HMpkswX0cQ7GCBa2F7X53M+78goRhSQBkihJ95tRUeqXcaIGSRY8uHeMDn2GNy6
	 DgFZiLgAA3OQ4efuWYekiFK1pJC8Y/tq4PiYiwza//T3Er8we0ky6GQtQfKpQURwNU
	 juVVmcq/xKOgg==
Date: Fri, 13 Jun 2025 18:22:03 +0100
From: Simon Horman <horms@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 net-next] net: ipconfig: replace strncpy with strscpy
Message-ID: <20250613172203.GO414686@horms.kernel.org>
References: <20250612114859.2163-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612114859.2163-1-pranav.tyagi03@gmail.com>

On Thu, Jun 12, 2025 at 05:18:59PM +0530, Pranav Tyagi wrote:
> Replace the deprecated strncpy() with strscpy() as the destination
> buffer is NUL-terminated and does not require any
> trailing NUL-padding. Also increase the length to 252
> as NUL-termination is guaranteed.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

Hi Pranav,

Thanks for the updated patch.

I agree with your analysis above and that this patch is correct.

Reviewed-by: Simon Horman <horms@kernel.org>

