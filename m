Return-Path: <netdev+bounces-99920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CCA8D7032
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 15:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC391C20D98
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48614F9ED;
	Sat,  1 Jun 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuEsfF9i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5919C1D52D
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248488; cv=none; b=Ol2V5qDDzQ81ugpem0+XACVIYsI7+0QXLEe9CoFLkZj7FaoA0MKNq6a+0xJxWd0coO9GPD6IEzwm1tz8TZcNwDKOJ6CCMBydnMXwPaRQEAN3Bye94ePg4gzbC90DpkUj4mRuDSE/d1B9rVTFcajd+Y/KqHCbeWA8PL5okOf8TZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248488; c=relaxed/simple;
	bh=5VvBoWCqqhzVnySrYojqvhJST2giT+VGoRF0pn4Ktnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBvafzSDVpFFStqDfKUYRcCyzThQytTxtnKeiaMsZvc/VvobLJiAKov8gWT9mO5//rwEHym8Yknf42KsIJ50zxM/gKTtfxMmAnKwaO7zr2Ab+sGgieD4cgbdwHLBB5hWan+Ta2ZCEJrYbJAQY8neTve70lhnmADP3wbUY2Cl1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuEsfF9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C92C116B1;
	Sat,  1 Jun 2024 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717248487;
	bh=5VvBoWCqqhzVnySrYojqvhJST2giT+VGoRF0pn4Ktnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuEsfF9i2hJV9zFudlOT0d8vOFFXqVZu9a3HjBE8Pg5m7T1I/2J1+wZg5ne14o/cK
	 cdwBN773tS24YGq7tqxpz2Hii9mU/kGgO7XHDwrKDdvdW/3wA0Q5KbAMHncuBrDH4T
	 GiI/V13Lw9h1VI5ZPr9A0l2QLrioYyE2F47FG6UZ8RKOAVvZ45wUv9ot1TTyz8CNQk
	 P0CFAmOX21LsMbW1Em/CPBNnzcOove+wiiv6+eKiHM94qfF7TL9He1njHFhT9FmpHM
	 WXF94RFLvUvFcmGh45+SRWZiVwvZAvWo5BvgaGj1JQCJl/mMysJjk5BZRCopT9030W
	 ymNT9lJXcrm0Q==
Date: Sat, 1 Jun 2024 14:28:03 +0100
From: Simon Horman <horms@kernel.org>
To: Kevin Yang <yyd@google.com>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	ncardwell@google.com, ycheng@google.com, kerneljasonxing@gmail.com,
	pabeni@redhat.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH net-next v2 1/2] tcp: derive delack_max with tcp_rto_min
 helper
Message-ID: <20240601132803.GN491852@kernel.org>
References: <20240530153436.2202800-1-yyd@google.com>
 <20240530153436.2202800-2-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530153436.2202800-2-yyd@google.com>

On Thu, May 30, 2024 at 03:34:35PM +0000, Kevin Yang wrote:
> Rto_min now has multiple souces, ordered by preprecedence high to
> low: ip route option rto_min, icsk->icsk_rto_min.

Hi Kevin,

If you have to respin for some other reason: souces -> sources

Flagged by checkpatch.pl --codespell

...

