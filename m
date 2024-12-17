Return-Path: <netdev+bounces-152706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C639F9F57CD
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DBB16F3DA
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 20:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704751F8EE4;
	Tue, 17 Dec 2024 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPpreQ3O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433911607AC;
	Tue, 17 Dec 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467440; cv=none; b=t9JBTCvvO8qgYjMU0NrJLjNWm1dHrsxBgXSkoIKE47pW9djxE6OGtiYYd2B3CowQTIkLUH/RGUUYftPm4ZgSZ7GLqRupIsOBaqZ5gLRmlFpHUHpzbBQIrH/SLBjA6wWmYaMxSlAh+jjLlVYrUB8n17dcwXdWudtKS13a40lhP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467440; c=relaxed/simple;
	bh=+Z8MagIxxUoKw0hroBmcul2wy1Et9DFwaw4LuCwEjyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5c5d3aAy0jwtENKgL0brbITw1xVc0fvCJq7yFoY7n13xvBFjnGlfk9vs0oMrwrX5/Fqx8q68/TCiVGkyT6zNPXqsVGywd7bE1nJWzXdEzokXLVLgamva6kA/EcAOX0+7/qgS/CtUQqNoNF3iT9NHRGHpTVtTFLrP7JaAQqYMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPpreQ3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D989C4CED3;
	Tue, 17 Dec 2024 20:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734467439;
	bh=+Z8MagIxxUoKw0hroBmcul2wy1Et9DFwaw4LuCwEjyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPpreQ3Of8vylmIe3GUXtSyIXeFQ+qLUqRAkxpNW8toZjK1Qbrj7ahgK3ZMABBv8i
	 lOvFXkf1qIWarnc2k4PRkUOvcXa/zivIZ4WTXyhnbGLwugM5Ku0rVfHpxzlRgkFTuR
	 hPgbGtNMo4Bk5Gee0gok9OiYVr1sQhNqWThVu6euX+mU5SxfEG1DHLP2uHRNdqsfaF
	 oRXyAFlWImNCjt69XyIX4cQTwHHSf60gFDZyDAOJyYYKKo41/J3oYwr7ql0n9Fjcb1
	 hVyTAGcS/PrFHmx8OmHgoFDYQtFHQCKBYRwZw8z8NMpPa/05AsCFRcUJ9SUCo9IWCk
	 yHo9D7zD7iMuQ==
Date: Tue, 17 Dec 2024 12:30:36 -0800
From: Kees Cook <kees@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: core: dev.c confirmed to use classic sockaddr
Message-ID: <202412171230.824B83D@keescook>
References: <20241217012445.work.979-kees@kernel.org>
 <67619a5029d2c_a046929426@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67619a5029d2c_a046929426@willemb.c.googlers.com.notmuch>

On Tue, Dec 17, 2024 at 10:35:44AM -0500, Willem de Bruijn wrote:
> Kees Cook wrote:
> > As part of trying to clean up struct sock_addr, add comments about the
> > sockaddr arguments of dev_[gs]et_mac_address() being actual classic "max
> > 14 bytes in sa_data" sockaddr instances and not struct sockaddr_storage.
> 
> What is this assertion based on?
> 
> I see various non-Ethernet .ndo_set_mac_address implementations, which
> dev_set_mac_address calls. And dev_set_mac_addr_user is called from
> rtnetlink do_setlink. Which kmalloc's sa based on dev->addr_len.

Yeah, I was clearly missing several cases. Please ignore this patch. I
will re-examine this.

-- 
Kees Cook

