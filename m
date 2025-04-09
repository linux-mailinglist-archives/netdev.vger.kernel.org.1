Return-Path: <netdev+bounces-180884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B45FDA82CD6
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3AA7AAC66
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1054A26FDBD;
	Wed,  9 Apr 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9QaJfZn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81B26FDB7;
	Wed,  9 Apr 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217449; cv=none; b=GGlMIoOgg9SIzpRq4Gn1p/3tG/GpoqbRaQZ6xf77IYTTlSUxWmZ88tZ+ep+Q2gdXIWAI4Q2mJz6Ye3qRCKzJerIXYBHyfOKR3g4dwHd0rRE/1XGT7wdrBWSkGEpIJi2b/3WC1u3sw7nC5aYGFQhkg4yANypkIZ/yVtZu4hgPVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217449; c=relaxed/simple;
	bh=L2zhW57W2bSVr2kyXSmjFw+geDGQYlYeUYJjKoNr4Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs9upNlN0Hy0RFnGiTZvNiNe/h/cuQ3U5t0LnEdbvPROoh+HdbhEMUTAMjW8HWhA8OknK2d68QjMKomKVeEIZfwIkONKVMrjVHMinbkQTBMzDRqCeDzwMTb5PVRgrtc/rWmKPoFaT+NsaI8nnste2+p1zAS45it5h2tOqZ5qM0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9QaJfZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F987C4CEE2;
	Wed,  9 Apr 2025 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744217448;
	bh=L2zhW57W2bSVr2kyXSmjFw+geDGQYlYeUYJjKoNr4Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9QaJfZnBnQSIR5M8enh8sBaeR/0/sBui2ciV2j+k7aKoL0w6ouJJaa5nTzoPPFiq
	 DUdctyOAAlYFd4OzTv8VXYWA3iOIegghBb+D+hyWOboVVwMcK8AhaKVc7KwnVQo8y4
	 0IsIxkK46urKYYpRrA+cwRH1J7KB8oq9Zb9vx4pa85BJije+5UqINIhrkF6+Fk9AOS
	 6UFPU2VmFDNZ4l0gU0TzqkkZBBxd9jJE8x7cXY1EXa7kyAwMr/8EP75PUpuITHFiAy
	 FmB9+P10ITDK0k+iiI0K5OmqNaJFwOxx1f1S5s18W7zbfOSnNADvpaQOwqFwsmTS7z
	 MHKbMEeJqBkWw==
Date: Wed, 9 Apr 2025 17:50:44 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 5/6] pds_core: smaller adminq poll starting interval
Message-ID: <20250409165044.GM395307@horms.kernel.org>
References: <20250407225113.51850-1-shannon.nelson@amd.com>
 <20250407225113.51850-6-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407225113.51850-6-shannon.nelson@amd.com>

On Mon, Apr 07, 2025 at 03:51:12PM -0700, Shannon Nelson wrote:
> Shorten the adminq poll starting interval in order to speed
> up the transaction response time.

Hi Shannon,

I think this warrants some further explanation as to why this is a bug fix.

> 
> Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

...

