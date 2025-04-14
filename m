Return-Path: <netdev+bounces-182512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474EAA88FA7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67273B71BA
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003E91F153A;
	Mon, 14 Apr 2025 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dus0cKp2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754ABDDDC;
	Mon, 14 Apr 2025 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744671238; cv=none; b=peHbTbmyWNjAC80iNVQYDMDGMF725GZfouLwmekOXtgrexdeB8oduKjRGovbEcLQhAvgTxtDG1ARtNtCcxRyOqN3gL2FkZFBsw8Vf7JT60U9GHXJpjpkE9H/pAmuwUQ+blCi3hzvDaSwJu+8GxFf1jhUtOifNWR61C3VbX6/1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744671238; c=relaxed/simple;
	bh=JVMXn97GxdaMr6RHqbaunzKPHcy581qfuxnlMLrdp9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGPzpETyhfHBlTsqik/lbWPaUx8y+uCyd17YfoSBOWwjjaq0izuAHxNsI056P5ZMQN2URhozjd36pQ10qB1bNJC9/lqSzGfRgtFIg0GZ8OI2BzfXtpqOK6dkAs9v+c4/DPzi9p4hsZMFF0AhII5ge9XpFclze+Vfw2PL7nEiaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dus0cKp2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7qTOlcr54d6Rr7oJUuR/4UuPtDfEfksvjWOLomJL1a4=; b=Dus0cKp2VbvKBzND7pcL+qMVlz
	FdYsssE3fuWsxNfxn+JtNLkHlHThogFb+yLRYb5GAIzj4i5CjJssbAgRU+gvSMkOaxLRCLh/zpoMv
	0romnCkZlNxS5oDCH+25B/+Jc/Ypy+yUd7Hqz1H8LaRcS9kUniNWDmJNKLWMWsMm9+to=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4SgX-009IFv-2A; Tue, 15 Apr 2025 00:53:49 +0200
Date: Tue, 15 Apr 2025 00:53:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Qasim Ijaz <qasdev00@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] ref_tracker: add ability to register a file in
 debugfs for a ref_tracker_dir
Message-ID: <8f06b845-2216-4b20-b7ac-c72fb1c29e3e@lunn.ch>
References: <20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org>
 <20250414-reftrack-dbgfs-v1-2-f03585832203@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414-reftrack-dbgfs-v1-2-f03585832203@kernel.org>

> -static int __init ref_tracker_debug_init(void)

[snip]

> +static int __init ref_tracker_debugfs_init(void)
>  {
>  	ref_tracker_debug_dir = debugfs_create_dir("ref_tracker", NULL);
>  	if (IS_ERR(ref_tracker_debug_dir)) {
> @@ -289,5 +367,5 @@ static int __init ref_tracker_debug_init(void)
>  	}
>  	return 0;
>  }
> -late_initcall(ref_tracker_debug_init);
> +late_initcall(ref_tracker_debugfs_init);

You just added this in the previous patch. Please give it the correct
name from the start.

	Andrew

