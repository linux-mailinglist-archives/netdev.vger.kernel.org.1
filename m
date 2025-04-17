Return-Path: <netdev+bounces-183897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0704A92BCE
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EED4A195D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35ED1FCF7C;
	Thu, 17 Apr 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CzdYcVrO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344381FE469;
	Thu, 17 Apr 2025 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918249; cv=none; b=WZAjcMvwcfrEknsOgv3VTxkE/K5AHPKuV53vHod6dcjS5mmjTIcm2vs/19LoQ0zPc1ntVgDU3HE7ympxWe4pwMZ/xmRHstSYxDEh6wAxj7Xop4ay3834GPmakucNeAhMi36rca7Y6mTYTiMIaDiiLqbKfhRVJO1yKGii1J44wro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918249; c=relaxed/simple;
	bh=REmcHxXXU5+5hilcctST6LtwCBBCuJS8ASNwe2WwSTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzkY2dJ34oBHymvuX28Qg7GqwAge4ZeL4dP6EQn1IfQzvv/9hqnH1diOEXOMAnoJXXA/EhL+6ciIzAz82050arkJhbZQYIwq9zMR0cK7BXlHG2U8xrtsjsvggvKvHlZlWwlyJDAaSCctBJ4aI0Y2mXAq5MnoC2rBpOz1J6Ol4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CzdYcVrO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZTs5g6G9WbUbzhzliHd7tnfQ2m0a2XtS9zhb4HobkM4=; b=CzdYcVrOdf08e9EjeLBfQKsga5
	KzKVztc38ZKwBuLUaTCHHV08c8ClMnXYU7FagIoK3EDQzgY38YK4hm37xIBapszl3AM1vd/l5j1p5
	0OmtSUaxzjAgVHSsNQC3wvTrGFd7LFlFwhboYZHH39+Lp5vCdVfOwOMe7vDy7tZ5w4CU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5Uwa-009pAs-Eb; Thu, 17 Apr 2025 21:30:40 +0200
Date: Thu, 17 Apr 2025 21:30:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 7/8] net: add ref_tracker_dir_debugfs() calls for
 netns refcount tracking
Message-ID: <7bd4ce9b-7b92-4311-b3e0-525cd1f52227@lunn.ch>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
 <20250417-reftrack-dbgfs-v3-7-c3159428c8fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-reftrack-dbgfs-v3-7-c3159428c8fb@kernel.org>

On Thu, Apr 17, 2025 at 09:11:10AM -0400, Jeff Layton wrote:
> After assigning the inode number to the namespace, use it to create a
> unique name for each netns refcount tracker and register the debugfs
> files for them.
> 
> init_net is registered before the ref_tracker dir is created, so add a
> late_initcall() to register its files.
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

