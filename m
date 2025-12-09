Return-Path: <netdev+bounces-244160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFABCB0E98
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 20:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26C9930B79EA
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 19:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D68C3043D5;
	Tue,  9 Dec 2025 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM5g1Lpx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226FE3009D2;
	Tue,  9 Dec 2025 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765307618; cv=none; b=O5Fwc1Bi7WOdY+tlX0JGroYa2wbS9bNzIkHGq/K6KytnMvb+HyjIWB5eWB2gPjCLgVBP4voLjF8QF5hwkilfBX3ezpssUCygZErwrSizaMA5aSLLSfLo4gGJrBwou0Z/Wq4QsBFPG/ZgCVMZjvvC0TN6bAjN2/K/QsdI+e1wORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765307618; c=relaxed/simple;
	bh=olGfUEI3Fa7JIAWCZLtXgnoKxFiqN61NhWr+XEudZR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udmzhpprqFySo7uKOo/xJNDwgQEVHj9tuu/vFzAvGawiJgrYPftuh8lYangGSfrwDozbeZZqglhrY9RneQK9qqDbGRUHnkS+IW7YT6pE2jMNa3c7YLjTTQok77ljRLD6zMlMIshY7uN/9iPkot4mxPlyKzU9KteZCTrGlmuUwVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM5g1Lpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD555C4CEFB;
	Tue,  9 Dec 2025 19:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765307617;
	bh=olGfUEI3Fa7JIAWCZLtXgnoKxFiqN61NhWr+XEudZR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XM5g1LpxA3Gxy4Q56brBe/n78CHou/m8QCebgbGqeVYDxaEGwFagB9nfAOqDBWUay
	 46YfAlv37WDCqqsRaPsZNvT5FxTiWRQ9OmgbrdQ0Vcd4BJkOamNQagDh8NdIhOZYJC
	 86iKlwL38gbEvunIkbW9aYfQrvirqY9bQ4GYA9pX+5X+Dlw6b36J05eCweGKsb3u0C
	 6Lg42jMbgbgTUwFct/ka+MynF3ZVi5mpT0o2v6WxcaNLDLBS38cfsYmZTikIdseNCC
	 idDNtFIIWR+S6Dd6k7Qx5VrjgggyWzBOHvWJ0cTlzQ7XifObZlK1HI+vqlILPG3dKj
	 KXnoU/S7lGg+w==
Date: Tue, 9 Dec 2025 19:13:33 +0000
From: Simon Horman <horms@kernel.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] caif: fix integer underflow in cffrml_receive()
Message-ID: <aTh03SMwEsCB_fh3@horms.kernel.org>
References: <SYBPR01MB7881511122BAFEA8212A1608AFA6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881511122BAFEA8212A1608AFA6A@SYBPR01MB7881.ausprd01.prod.outlook.com>

On Thu, Dec 04, 2025 at 09:30:47PM +0800, Junrui Luo wrote:
> The cffrml_receive() function extracts a length field from the packet
> header and, when FCS is disabled, subtracts 2 from this length without
> validating that len >= 2.
> 
> If an attacker sends a malicious packet with a length field of 0 or 1
> to an interface with FCS disabled, the subtraction causes an integer
> underflow.
> 
> This can lead to memory exhaustion and kernel instability, potential
> information disclosure if padding contains uninitialized kernel memory.
> 
> Fix this by validating that len >= 2 before performing the subtraction.
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Fixes: b482cd2053e3 ("net-caif: add CAIF core protocol stack")
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Hi Junrui,

I agree with your analysis and that the problem was introduced
by the cited commit.

I think that this function could benefit with a goto label that is jumped
to by all of the cases that follow the same error handling logic as this
one - I count 4 including this one.  But as a minimal bug fix I agree this
is a good approach.

No need to repost, but in future please consider targeting networking
bug fixes at the net tree like this:

Subject: [PATCH net] ...

Reviewed-by: Simon Horman <horms@kernel.org>

...

