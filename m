Return-Path: <netdev+bounces-66733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DADB8406F6
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 14:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288911C254C4
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A7E63414;
	Mon, 29 Jan 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D4zLk5ua"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF967728;
	Mon, 29 Jan 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534934; cv=none; b=tH+0w+upEJKX1conKmgYDcFZXJF7xACQDTJqJoJZ4WOdtFOn+eWgH4xdtUSFzNHy1nxHyGLxgMR0/OWTTFNuZgPTP5UePRRT3jY8o0f41q3CgHjqb2LERTuKnmZW6OPJFvKP9fPwvD4VgYMMEItQiBaqjHVEOnH7tmlVkqFtOxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534934; c=relaxed/simple;
	bh=3cA1d7sqoYTq//YITLKc5M3uzrGMgLau5aIIxV+r8Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rt247L+EKr7tG4Z4BxofHr9d3optKIKwP9aNQJ/NNDBMz06ilSKTbJ0EKsTRCWA9SF9AbnNeMBc2cUpbMHLroTzMVu91HAxYGHGjMkIs/w7ov2LDU0LCtfn+1M7bi03pAGk2eRlB1EIk193PNH+svZOfNRE7utV07hkE4MS+cCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D4zLk5ua; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=49MW0QqssqXxnSvUWe+YBez2Z39weLYefJNaCkLY3n8=; b=D4zLk5uaIX47NHD7O5QcZzRTZU
	p7BHDhIj9f05TSr6he+HzLaMRQA/fq9GgTCDcCYREGWmCRbbwxMkSJ9am9fekkfdmmqXONj+N7ytm
	R3ZVxD6gHERqYjOXEM8SlBNuxk3s6Ex7tenklt7pPbh7jogb7sVfnMSUIZwMzv/lEVm0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rURgi-006NhI-CC; Mon, 29 Jan 2024 14:28:36 +0100
Date: Mon, 29 Jan 2024 14:28:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v4 2/2] net: phy: adin1100: Add interrupt support
 for link change
Message-ID: <f44a170c-a3bb-4013-aad0-9f88de5efcbf@lunn.ch>
References: <20240121201511.8997-1-andre.werner@systec-electronic.com>
 <20240121201511.8997-3-andre.werner@systec-electronic.com>
 <20240122074258.zmbzngrl7dzhkvwo@DEN-DL-M31836.microchip.com>
 <e8a14edd-0879-a6f8-0e7a-edf09998f6e9@systec-electronic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a14edd-0879-a6f8-0e7a-edf09998f6e9@systec-electronic.com>

On Mon, Jan 29, 2024 at 01:51:11PM +0100, Andre Werner wrote:
> Dear Maintainers,
> 
> I'm a bit confused about the patch submitting process for net-next.
> Do I need to send the patchset again, if the merge window is opened again and
> the patchset was previously submitted as RFC?

RFC patches should in theory never be merged. So that alone is
sufficient to require a resend. Anything sent during the merge window
is also not eligible for merging.

So please rebase on net-next, collect and add any Acked-by:
Reviewed-by: etc and resend.

	Andrew

