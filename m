Return-Path: <netdev+bounces-161644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D816BA22DF6
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 14:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A303A8020
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395091E493C;
	Thu, 30 Jan 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s6bbLY77"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E8F8462
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738244399; cv=none; b=YVb4bC3tf6ckw1xft2oQDGb7IWA4XeQ2DzyZ5NQch2Lhna/lEHa3bnYlnd9AjCv91bgXKfQoaGtM3kc51X37bqfFX3B4TJGlFBj44GpkM8fp2Bkt/shV0kNg/mHimNyRLn3oD4nczHMWW2kV3Y/S4glOHjjHBqq944UtEuVKNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738244399; c=relaxed/simple;
	bh=PYCnyy94DPSY6xalqxeWlXkdP7xelHaR6aTKQ3vWtn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9BUopg5h8NhXpwd0yzFkMUxTS2qHkY92gAKUD/nRqbUyNFAa6H4+F08FQ2uvPYd6cWsJ0/jo7TOHWHUz+FkwYZ7n0Wtb8htBhKT3nP3qATZ7J6D4LHmABSxW8PQmIhBCacTxqkQRuBzu2MSsc9cs1mNkYl6dwtpyPW98evfgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s6bbLY77; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0Fi2Zdt7XxjkPDuq0HkCt/Aj4z3c/ag5zSClCC+5Jjw=; b=s6bbLY77EDtuIhcM8w2t4uMgo/
	G+YwtlgDJQLF6lp/VAqz/W/LEBx4l4QF0ysu86qkIEJU8NEXUXqH1C1NEEj7uTF7OEvudfD1i2Hy6
	ZdIQAdQsQi9TuwVonYx75Q3n9whNOAwrc2lCe63Yy1wAKd7cY10m/Umi/ouWU7ZutQWk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tdUln-009Pzq-KA; Thu, 30 Jan 2025 14:39:47 +0100
Date: Thu, 30 Jan 2025 14:39:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Lukasz Majewski <lukma@denx.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: KSZ9477 HSR Offloading
Message-ID: <91b842e7-a7c9-49b9-8d14-486f10ea3724@lunn.ch>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
 <20250129145845.3988cf04@wsk>
 <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
 <20250129235206.125142f4@wsk>
 <d8603413-d410-4cc9-ab3a-da9c6d868eca@kontron.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8603413-d410-4cc9-ab3a-da9c6d868eca@kontron.de>

> One more information I just found out: I can leave ksz9477_hsr_join()
> untouched and only remove the feature flags from
> KSZ9477_SUPPORTED_HSR_FEATURES to make things work.
> 
> Broken:
> 
> #define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP |
> NETIF_F_HW_HSR_FWD)
> 
> Works:
> 
> #define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP)
> 
> Works:
> 
> #define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_FWD)
> 
> Works:
> 
> #define KSZ9477_SUPPORTED_HSR_FEATURES (0)

It would be good to define "works". Are the packets getting delivered
to Linux and then the software HSR bridge in Linux is emitting the
packets back out the interfaces? Or is it all happening in hardware
and Linux never sees the packet.

Ideally we want the hardware to be doing all the work, in the "Works"
condition.

	Andrew

