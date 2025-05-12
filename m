Return-Path: <netdev+bounces-189779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA6AB3AB5
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B03E3AB844
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD2227B87;
	Mon, 12 May 2025 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rk472oJ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EC218DB14;
	Mon, 12 May 2025 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060438; cv=none; b=RDHbz9G+O6KkgyNXEsV2QhsmwfqyLSneiWGESzy36tsqETSCT01VHrDzHRenjOedz6el9JrltU9oF3AQg9KO8Rm0i6j9ysTCLPO3wXyUxk0JkWKqveiFoqzJ7gu5ZpuhgnxQsrajVQGNscsB2XCAAV1Zp9Mb4yuH2chHe5VzKzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060438; c=relaxed/simple;
	bh=SM5ws4ovbFbl7zpgNkhJX1rZV9ZeYr+OVrKe2Az+Zy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aijGM5TPNjpDw85H0siONyvsKaxatFnWReWi3b2qI0ETYGDkEkUkb1BhwUPoNyPLuv1OVFDRGrZkdbIQPEVsT+WiGxakz5IG5RGJbDWR9B8UBwhqQuDUcfHWvFF97GdvM9AVT4Ck/4PIfTTngjahugKRTOH/l1saEid/wjcMODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rk472oJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427EEC4CEE7;
	Mon, 12 May 2025 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747060437;
	bh=SM5ws4ovbFbl7zpgNkhJX1rZV9ZeYr+OVrKe2Az+Zy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rk472oJ7p0vwEYNy3HkW2ULiS07gTjP1PKHt9SaDjQiWIwEVmHWI8su+1k5Smud+f
	 ViXuexdDXyVv+IPu/vMbQTtdcSiLIePpFoWzjq4VQgbBVEVYmun45It9hrEDeoNlX9
	 OjROaJxVr8llW5qk+2calrFGtVfs5jZDNnGJoUCegwS31PG+7hwQjaIktR7CXi35/o
	 4wtCWHcWG7yP9QqoJNRR2Ej0nrYNr0TlbQFvW63TUvUFUsGYuJCvEV5f9YWUMRLwOW
	 8w7ZagGaKqTiN+oDcqSnssqzQ4hiXpnXL3nS2KkLwxTrKef+sE1E3Vkvm4lX5iCED3
	 ygLs8ZXfZTSuw==
Date: Mon, 12 May 2025 15:33:52 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Su Hui <suhui@nfschina.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/5] eth: fbnic: Add support for multiple
 concurrent completion messages
Message-ID: <20250512143352.GM3339421@horms.kernel.org>
References: <20250510002851.3247880-1-lee@trager.us>
 <20250510002851.3247880-4-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510002851.3247880-4-lee@trager.us>

On Fri, May 09, 2025 at 05:21:15PM -0700, Lee Trager wrote:
> Extend fbnic mailbox to support multiple concurrent completion messages at
> once. This enables fbnic to support running multiple operations at once
> which depend on a response from firmware via the mailbox.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


