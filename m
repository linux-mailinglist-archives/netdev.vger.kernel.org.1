Return-Path: <netdev+bounces-145664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FE29D05A0
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF15B21796
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 20:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC09C1DB95E;
	Sun, 17 Nov 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mC18zsML"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C31DA60F;
	Sun, 17 Nov 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731873984; cv=none; b=r65j9Qt987F0Rp0qJG1G6x02BpVcuZ0UVoYKnbLtfjVjnzgAIhgeYBCMkj9/2Avgek0F8LcxIML9ctDJrjw0FgSNdKQDrNL5x1Q28nC/Hti7JW94b8oHQuihu4NrfmBV4JW553lTaqvB9tclgU6/XTFai6UNyABHb5G73UVO71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731873984; c=relaxed/simple;
	bh=OyxAN4YgaXUp4x+XaG2iuK6SIMvKnOiGTkjdOlJAyrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuym9p83yf1xU9wZ8sWaGAe3hw/01ZgipyskzeSokVR5BsDJFeFeNwllh+1N1IszpdHXphlK7/mNmbsjjq8qXtlmCCXKm0r8TU01elbMJ55EQgcuyoLGskIC1/BuqyW+Q7OOxcZUA5emtpEBoTAwWMgGrz3wv8r6tuGoXAtAVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mC18zsML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71351C4CECD;
	Sun, 17 Nov 2024 20:06:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mC18zsML"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1731873981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OyxAN4YgaXUp4x+XaG2iuK6SIMvKnOiGTkjdOlJAyrU=;
	b=mC18zsML78oK44vTAGfzIlRcbHSABMcqxb1jceIME38nVDjL//ZsQKeO/rOwTefJ1cSgMT
	eWm1DsiL/dNk4Uh6mN5Yb8wX0Jl0J+Xh1WhnqQ86Ap2W1j0c5+tptSZhWaGkM/a6pqDZe5
	d6KQzjvXosYx+b2MXTGqpA3TPd0KzWo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 01568eab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 17 Nov 2024 20:06:20 +0000 (UTC)
Date: Sun, 17 Nov 2024 21:06:18 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: wireguard@lists.zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] wireguard: allowedips: Fix useless call issue
Message-ID: <ZzpMumfYVgV8fTFH@zx2c4.com>
References: <20241115110721.22932-1-dheeraj.linuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115110721.22932-1-dheeraj.linuxdev@gmail.com>

On Fri, Nov 15, 2024 at 04:37:21PM +0530, Dheeraj Reddy Jonnalagadda wrote:
> This commit fixes a useless call issue detected
> by Coverity (CID 1508092). The call to
> horrible_allowedips_lookup_v4 is unnecessary as
> its return value is never checked.

Applied to the wireguard tree, thanks.

