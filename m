Return-Path: <netdev+bounces-120403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A19795925C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 03:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243F61F231B1
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF80482DB;
	Wed, 21 Aug 2024 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH1eg+H5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D2EAC0
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205140; cv=none; b=RIn59h82yrq2VpGKugvOnS/NMKf3UVSUq8wLlmPom5P0iN2d/sXhv15RlSBtbVM9gp57NE4dED7OoAG/ryjOYY4Gm+X53RQ6EtkWSEnrsV3CBAvmRFBuUhsDsRyd6GBOfMNevRHLH5gnusiC2MgquV4RFwDFAeiBp+kBCxRNWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205140; c=relaxed/simple;
	bh=kRicnRXOnJzSKvgUdLMpZcyzY1Sdu5s+WlloWUysjEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxfdyAcnEnHdDlECLCfXRDgAg8qxurWSaTML3Z6nfFuwHsIYEeeUYtGTZQ9stKVRRjJ10lKWJdZKqzFM7UQoeWbYGCA7XSULBQezXwic8gcYz9Q6Lpuf/hRSe6vFtPKM5U/BU9zVnjjKHUAhXiXIG0uOdXOxK7ILAXMPJSKdaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH1eg+H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ADCC4AF0B;
	Wed, 21 Aug 2024 01:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724205140;
	bh=kRicnRXOnJzSKvgUdLMpZcyzY1Sdu5s+WlloWUysjEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZH1eg+H5I4dXbnsv14JKdznVrp4g4PXKk021yw/aNRvgaOAokYBZQUTZ/jaLaSSya
	 E/wGzCdw9VjzBobDwP2cnT26pWbAcQoOF2QVKIPxE46gOI5GjldwnoBC99MBEUTJat
	 t83bawHMhkZvxmebi6LPcyJMC/iHx3lKbMx4fS8nE+jTRWH1Qeq7j0VOVbWm9+6k+s
	 xADHKw+bg4cmlE1qkqPDn7HvQcYM9hLxpKrRxYfEnS6xjgdsSnpIKfvq4ariYbFGJm
	 sbGqKYdFow4E3LKqveAAvX+E78yqs2Qhy/CBuWZvxcr4NkmRFPl4+k2tMlBrAkvX0d
	 fBcBPP3gm04LQ==
Date: Tue, 20 Aug 2024 18:52:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin Whitaker <foss@martin-whitaker.me.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, Woojung.Huh@microchip.com, ceggers@arri.de,
 arun.ramadoss@microchip.com
Subject: Re: [PATCH net v2] net: dsa: microchip: fix PTP config failure when
 using multiple ports
Message-ID: <20240820185219.60f166d5@kernel.org>
In-Reply-To: <45a00063-b3a4-470a-bfd3-d14bdec6a48f@martin-whitaker.me.uk>
References: <20240817094141.3332-1-foss@martin-whitaker.me.uk>
	<ab474f83-aaba-4fe9-b6b7-17be2b075391@lunn.ch>
	<45a00063-b3a4-470a-bfd3-d14bdec6a48f@martin-whitaker.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Aug 2024 11:21:54 +0100 Martin Whitaker wrote:
> > One stable@ is sufficient. Did i mess that up when i asked you to add
> > it?  
> 
> Yes. Annoyingly I noticed it when I first read your reply, but forgot
> when I later copy/pasted it into the commit message.

Fixed and applied, thanks!

