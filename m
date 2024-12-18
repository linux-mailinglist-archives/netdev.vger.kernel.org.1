Return-Path: <netdev+bounces-152836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51039F5E64
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 06:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF5716BB70
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 05:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA915530B;
	Wed, 18 Dec 2024 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy6wrglV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438D13F42A;
	Wed, 18 Dec 2024 05:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734501527; cv=none; b=DfIUCbJIwDeej+sQbJVWCBswnB7YdF8fLvFhOyN1WqKS+SwXAoseLe7gN7n0hPy52xZWoareAHpk1J6rh+fP9ypzfHlrGVRaOuwkDi1ok63hiI27f9hJEb0VOmcj2Yp5PZz40oyrOSQ98TuDqlbVcMkpgCkNr1WeZ38tWZeiSw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734501527; c=relaxed/simple;
	bh=ysKOGVJYbr0S6z+NbKNw3b1mmg2W8Fn+ZzUtTZaF/8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx+2tNagh6Slt8c0JKO9MrPALS73r2e24k0HAv/ZOe6/xTDKXv1dR7l0C0MlWdUc1gCqRZYsCa41BKdeljhNZq2yqwVb+yJ/XsK36uoWnZRFB4Ij67U+hQpn9lRgqjsvTrg0WFoiZymPuSocZKd2wMLM/2dS8nAMmmK9SOG5JzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy6wrglV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98805C4CECE;
	Wed, 18 Dec 2024 05:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734501526;
	bh=ysKOGVJYbr0S6z+NbKNw3b1mmg2W8Fn+ZzUtTZaF/8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xy6wrglVtm+w1nDWd8/oyjN5XcnVpEW70XbDfw/DTYBj17EcS1/pcFsPezZuZjVkA
	 KRKZDhkbQym5QMUim8nY/934C0qDeWUBgWkhC26uVDd/1m+gpqcxouKyPp1882lzU3
	 zRrb1eeo4MCpbLPstwxAz32DXuYn7qQfvLBXz647rgP5P5x+KXBs1pQSYsfnwn2LDZ
	 KZ512CxV6TUf+aK6LNg48zR1UaXx0/qNg9yvb2QQDWdfnwWtUZkvHTuT/yB7jRTxUw
	 fn9NnKCCQUsFC/V4l4d44c4OJlFrPPx1va0XRgKufdnqCszKq8sdJpuGWrKOlGs21D
	 knaP+f/WDKoYQ==
Date: Tue, 17 Dec 2024 21:58:43 -0800
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
Message-ID: <202412172155.F01961439@keescook>
References: <20241217012445.work.979-kees@kernel.org>
 <67619a5029d2c_a046929426@willemb.c.googlers.com.notmuch>
 <202412171230.824B83D@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412171230.824B83D@keescook>

On Tue, Dec 17, 2024 at 12:30:36PM -0800, Kees Cook wrote:
> On Tue, Dec 17, 2024 at 10:35:44AM -0500, Willem de Bruijn wrote:
> > Kees Cook wrote:
> > > As part of trying to clean up struct sock_addr, add comments about the
> > > sockaddr arguments of dev_[gs]et_mac_address() being actual classic "max
> > > 14 bytes in sa_data" sockaddr instances and not struct sockaddr_storage.
> > 
> > What is this assertion based on?
> > 
> > I see various non-Ethernet .ndo_set_mac_address implementations, which
> > dev_set_mac_address calls. And dev_set_mac_addr_user is called from
> > rtnetlink do_setlink. Which kmalloc's sa based on dev->addr_len.
> 
> Yeah, I was clearly missing several cases. Please ignore this patch. I
> will re-examine this.

So, I think I see what happened -- I missed the dev->addr_len in
dev_set_mac_address(), and saw that dev_get_mac_address() caps the
address to 14:

        size_t size = sizeof(sa->sa_data_min);
...
        if (!dev->addr_len)
                memset(sa->sa_data, 0, size);
        else
                memcpy(sa->sa_data, dev->dev_addr,
                       min_t(size_t, size, dev->addr_len));

It seems only tun/tap and SIOCGIFHWADDR use the "get" interface, though.

-- 
Kees Cook

