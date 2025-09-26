Return-Path: <netdev+bounces-226694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E49BBA404A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AE5621CBD
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7212F745D;
	Fri, 26 Sep 2025 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emx37HY6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59532F6581
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895387; cv=none; b=tRqj2u2Kx7LYmhb9uTOd8n0BjP+QIUea3Au6q52MMkT/xRKxv6SeKC9eIJXm3remzwQasrDMbN21QDOAMf8qVJ9udQvfI1ZQvJSxWZFgwdwFKIOPLpkOr7cgRi48Gy1O0ogOZsVoGzcVckbccRLc52ucP3l87vm6RWvLYgn99Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895387; c=relaxed/simple;
	bh=D3yE3RXNEe3cKems2Eep6LHdH9Tp4ND0Hi86D8+zqg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iuj/iihYfSOjX+MijTrZuCpSiCbDQZ+IxEmG7u0562HKP1npIODp+a9jXeM/N/8l3l3yASvZ5mrn5cygdJvrqxz9gGs0quk2HQjSpIqdo1gwXLd6X8q/Qqb1Eet+byXaHEBzaKJ2JfCvpIKSDk8Bn4K+2zRi4L5IFw9EYKBl7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emx37HY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC41C116B1;
	Fri, 26 Sep 2025 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758895387;
	bh=D3yE3RXNEe3cKems2Eep6LHdH9Tp4ND0Hi86D8+zqg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Emx37HY6kV5btgt/bVj4p0MF1pzRlLsLTN5KUiolsRdR5lWEp/TBjfaeHMirjddSP
	 WERu8ARGLRf3HwTEPMPMFDF4i+qcLs2cQqhi2yc3ROA36X4QTb41hMXz7Kk6KLg0Pd
	 wpzcNwZwZkBJFkMr2CiMVdQWllRPN+k4N8Defj0cP4/ht0lErovLE/gYOieUnH/Kvn
	 RsCQbGSXU3bm8yDFoc8bwfUdr8iB0SR8GMh8wrY7mTswXlKikZX6Q9/uah2BD3eBr+
	 DpV10Dzr8R35ESzNQY5v6N24OWal6YjEoi3yHBzd3KdxPzuM59DTwBn+Zpn9CzZZgL
	 p/0uFxG9wklGg==
Date: Fri, 26 Sep 2025 15:03:03 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: krishneil.k.singh@intel.com, alan.brady@intel.com,
	aleksander.lobakin@intel.com, andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net] idpf: fix mismatched free function for
 dma_alloc_coherent
Message-ID: <aNadF8lvpXa5beZJ@horms.kernel.org>
References: <20250925180212.415093-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925180212.415093-1-alok.a.tiwari@oracle.com>

On Thu, Sep 25, 2025 at 11:02:10AM -0700, Alok Tiwari wrote:
> The mailbox receive path allocates coherent DMA memory with
> dma_alloc_coherent(), but frees it with dmam_free_coherent().
> This is incorrect since dmam_free_coherent() is only valid for
> buffers allocated with dmam_alloc_coherent().
> 
> Fix the mismatch by using dma_free_coherent() instead of
> dmam_free_coherent
> 
> Fixes: e54232da1238 ("idpf: refactor idpf_recv_mb_msg")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>


