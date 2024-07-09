Return-Path: <netdev+bounces-110078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A6192AE81
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 05:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C682832D1
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 03:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716DE4207A;
	Tue,  9 Jul 2024 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui4S42XF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99CA47
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494916; cv=none; b=YnsL74FxF4GFb477l2V2vnF+0oBPj11y2a55xdEIaBtlboV18kDYVPr7I636uSbzAHJse+crA8SeMPkZlVP8bnLAvN96P+G2YCq//XjSFKTuwL83SfA7h4xkaUALQ0SgR/v9BXzSjjxxMfnvTdTuTt2ZhAN7XeN0HylMt1/HgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494916; c=relaxed/simple;
	bh=mDMCNRvvawXxFEQvcntFWLX7MNhFoquI3YGEeOfb/Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raN7HcmE67QJp9JObE42BwqSAzbHITHwVdw4mf1VSVyzuN3HHpD+yb2njtOP7KjkBmJgfgjTqZkXxIqL95HiJMncQAbo1Q0H9b+YKLbB7yY+3kjVxiuaOvr836yX49kl4NO8BUgrnBv2iiR09xbLYklZWL56+CG55P4tN945nzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui4S42XF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCDBC116B1;
	Tue,  9 Jul 2024 03:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720494915;
	bh=mDMCNRvvawXxFEQvcntFWLX7MNhFoquI3YGEeOfb/Z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ui4S42XFP6gVu+By2fZxUFse6fZQAhfXo2eIlZYcRw9KMwG0lIq6MqULo0ag6KIIl
	 /XMa7gG/YUxTAVIcnrOSXFewnDjjlK8sXrKUzhC4RFP6K/RYkQOZ81c1LWowYNM8mi
	 RFBCZgS1lTOa6ZIhWLl7uIhwdwaMfjKqzwzlUBobgIavq+4augd8iwFreTwSaAaa0p
	 1k1Eo8hioTlzQLt4NQn+4jpG4DjcrLKts7V8JSDDoIJhAwVJ1xCYAqSXNhIC/ruxtM
	 3Fc5fEKw7tnfaNlBFT/CYH3S6hxWswk5MvApxQVssCMSDzoAFJWm5+cY9L1kOdwoxn
	 uiIPEcuGv0XeQ==
Date: Mon, 8 Jul 2024 20:15:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Boris Pismenny
 <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: tls: Pass union tls_crypto_context
 pointer to memzero_explicit
Message-ID: <20240708201514.567883e4@kernel.org>
In-Reply-To: <20240708-tls-memzero-v2-1-9694eaf31b79@kernel.org>
References: <20240708-tls-memzero-v2-1-9694eaf31b79@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 08 Jul 2024 08:27:19 +0100 Simon Horman wrote:
> Pass union tls_crypto_context pointer, rather than struct
> tls_crypto_info pointer, to memzero_explicit().
> 
> The address of the pointer is the same before and after.
> But the new construct means that the size of the dereferenced pointer type
> matches the size being zeroed. Which aids static analysis.
> 
> As reported by Smatch:
> 
>   .../tls_main.c:842 do_tls_setsockopt_conf() error: memzero_explicit() 'crypto_info' too small (4 vs 56)
> 
> No functional change intended.
> Compile tested only.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

