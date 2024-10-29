Return-Path: <netdev+bounces-139765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ADB9B4056
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AF21C2135B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA3C12FF70;
	Tue, 29 Oct 2024 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e9SA5Afl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647B40855
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730168447; cv=none; b=WHGUFaJqY6fWXUcWFBl79FPAUwJWl4vEPL8aBXFgWpk4xWRWr4pFeW8j9V5rSq0rAcny2K8SkNDUAoJfBAm1saVOTReYxbDAdrKuKMicO5gbsbYIO4Khk+pU0amJyigVUZRc0WXEa2dJj6M1R1p7uiBtdEiKVRxtcDmV83jNvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730168447; c=relaxed/simple;
	bh=6XdSS5BtQ1UOsg90BK1P99rhGpo+WXf3iLt3yimZMMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuqPKLwZzS/l5/36sWn09S9pMCM6daQnaLl1LliSREfNAYDCRsSUsYeXs9DbwHXwqBxZP2yIVtceSGFksJ8OZ+nT4L+cqRHTYSLBmbn1YUta8Jpl1IkMSjnwuXw+Y96108JJsH0rp2tQPX3vEroIvmP5jaDqfVc8wIA3gp276x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e9SA5Afl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GRyTga+eGvUsVS4/lAWBi7iJQQEGdXza0+W/Q3vo1Go=; b=e9SA5Aflv/RTqCUT2vlixIPX3z
	u46ZR2eZ+L813Qf02xbpfykJM0kLcjeTrrbILGCiM2WcHoFIpVimkZuDbDAQzZ1MWbLatLbhfKus/
	ZUKSU7iWZr4JS0xi03+EF+/+FVUDIoRxUdcQRXQWMNoBh6P8rUmfGoNu6l2mtW8bvbiU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5bqN-00BW8Y-BR; Tue, 29 Oct 2024 03:20:27 +0100
Date: Tue, 29 Oct 2024 03:20:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Vijay Khemka <vijaykhemka@fb.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: ncsi: restrict version sizes when hardware
 doesn't nul-terminate
Message-ID: <4f56a2d0-eb1b-4952-a845-92610515082a@lunn.ch>
References: <20241028-ncsi-fixes-v1-0-f0bcfaf6eb88@codeconstruct.com.au>
 <20241028-ncsi-fixes-v1-2-f0bcfaf6eb88@codeconstruct.com.au>
 <286f2724-2810-4a07-a82e-c6668cdbf690@lunn.ch>
 <e6863bfb99c50314d83e2b8a3ab8f1fabe05e912.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6863bfb99c50314d83e2b8a3ab8f1fabe05e912.camel@codeconstruct.com.au>

On Tue, Oct 29, 2024 at 08:31:55AM +0800, Jeremy Kerr wrote:
> Hi Andrew,
> Thanks for checking this out.
> 
> 
> > Is this defined by a standard? Does the standard allow non
> > nul-terminated strings? 
> 
> 
> Yes and yes. The pertinent wording of the spec is:
> 
>    The string is null terminated if the string is smaller than the
>    field size
> 
> However, regardless of what the spec says, we still don't want the
> strlen() in nla_put_string() to continue into arbitrary memory in the
> case there was no nul in the fw_name reported by the device.

I agree with that, but i was thinking that if it was not allowed, we
should be printing a warning telling the user to upgrade their buggy
firmware.

However, its not a bug.

Are there any other strings which will need similar treatment?

	Andrew

