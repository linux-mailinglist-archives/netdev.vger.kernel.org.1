Return-Path: <netdev+bounces-94238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4CC8BEB40
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D03BB28C46
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9254D16D317;
	Tue,  7 May 2024 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtMuGheV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637CC16C870;
	Tue,  7 May 2024 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105437; cv=none; b=AfKSKOEpPAKJRxUn+06rxmuokj8KhBG99cyoY07tOz4mglvfY240LCu8Ce4bGnOdskfqw0HJhbFNXpLWlUsLt++l+Cjw+J86nf65z8PKqrejL217hB4HiLtW6c7jGZkL78aFh4/JKkJtx4Bn9kXvqvTOLXYndv7U2h7/dk46sj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105437; c=relaxed/simple;
	bh=eUm67f/3NUamaigknr4i+sEXWIOWPMazdU/P6U0owYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAqp3DGrFJQ4YVGRpo0BwqxztKDaNrqk+7qP5WggoaYbsc39m7fI76wehVTzcNUIxH4MLYPAy0p5RjbeMiZncsVL5sso6aYT3v1EFX6bmaAF0TxekVfNWeZwrICxq8FVTYiQTo4QDmEKIq+Ua3M5fosbVWLQ+pBVtyB71rd5NCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtMuGheV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6425AC4AF18;
	Tue,  7 May 2024 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715105436;
	bh=eUm67f/3NUamaigknr4i+sEXWIOWPMazdU/P6U0owYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QtMuGheVGCufYtD87Wzqn2FmhDEjJlvUDA/0Q33KfQrtxmw/phFK5SMLDA0AsxRwx
	 wClB6sWlPqr18ll56lRuAKmK3fU01+m2q8WtltGHLg0iGwjYt5GG1OlK1WXq9IuLmy
	 vwpDiOEZQnoPvtVZVmvUCCGzLRV/JqfSAhdOs3YO9PUGWPKH2BQdRg/LGentwr8FxZ
	 4p5VBEZ4KIiMn+GWenazQFbaEqvmj/LpIGbk/DYBkKsIb9KG43ATmZZbcH7turF6u1
	 shmv/ywGM/92aGpTtQ/vMTGvfItp1jKRv276nCLciTZOhbc8hRFIbBh3YYs+6gmlNy
	 s1J4tZ/0NUU5w==
Date: Tue, 7 May 2024 11:10:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kees Cook
 <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Simon Horman <horms@kernel.org>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] netdevice: define and allocate &net_device
 _properly_
Message-ID: <20240507111035.5fa9b1eb@kernel.org>
In-Reply-To: <20240507123937.15364-1-aleksander.lobakin@intel.com>
References: <20240507123937.15364-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 May 2024 14:39:37 +0200 Alexander Lobakin wrote:
> There are several instances of the structure embedded into other
> structures, but also there's ongoing effort to remove them and we
> could in the meantime declare &net_device properly.

Is there a reason you're reposting this before that effort is completed?
The warnings this adds come from sparse and you think they should be
ignored?

TBH since Breno is doing the heavy lifting of changing the embedders 
it'd seem more fair to me if he got to send this at the end. Or at
least, you know, got a mention or a CC.

