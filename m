Return-Path: <netdev+bounces-205432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18E0AFEA75
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0864C1C4868E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DF02DCF5B;
	Wed,  9 Jul 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5RyBXgsF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8472E0B64;
	Wed,  9 Jul 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068417; cv=none; b=msgKPGUrt8XVM4Tu5fZWX6RMPhM08pmRoioa3F949JGArqlfPGPmVXh0e3kYkWsW+Jfgm2a17me+Nzs9RvcxeMt5/sT6drA9BdH2yrC4VRzPCx+djVK6zl2X1eVIB9/OQHLrOVoPJwR6iYVqexbRI9/yoCv+Nw7jiXlvlDuqKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068417; c=relaxed/simple;
	bh=srh6upJ2BHU9tPRm6xQLW5eYZna//4RGIueZY2+PDwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWaJdJNZ+AK+3/dibB8lAhFvwQEXznbVpVKp1ayg9Leevg6LXcduJ7W7fZPU8vZSO43WAE8G8DrZuvqpycsj6OTXnTP9dvzz6xoUV/93nNeaNkyeh7KynBpdW3zic5tRDJbFoJXM+gcectnJn+Bx3HlkVCasS4EJpaMd17YMRzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5RyBXgsF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=qf1aCZkVoUR6O3+JgmfmWzoj9b305EXKr9irXfS3wU8=; b=5R
	yBXgsF4uYxmld/8KinJYPxMr4Ryx23GAFAdcgfWL6e1UAzjDdNIQPVIgmW2XL1ZS5aJmzAtzLwTSy
	GOYsho5gHQysBKTuThMed6xQFQU/eAUkpEqpH1jIblg05W/R57prs4K8x50RlarVjZ4qIXtYXwJot
	OlE1OfzZKblLAxQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZV1x-000wjE-KY; Wed, 09 Jul 2025 15:40:13 +0200
Date: Wed, 9 Jul 2025 15:40:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 1/3] net: phy: smsc: add proper reset flags for LAN8710A
Message-ID: <af824c57-0f17-4970-ab7f-75cc0b931596@lunn.ch>
References: <20250709133222.48802-1-buday.csaba@prolan.hu>
 <20250709133222.48802-2-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709133222.48802-2-buday.csaba@prolan.hu>

On Wed, Jul 09, 2025 at 03:32:20PM +0200, Buday Csaba wrote:
> According to the LAN8710A datasheet (Rev. B, section 3.8.5.1), a hardware
> reset is required after power-on, and the reference clock (REF_CLK) must be
> established before asserting reset.
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> Cc: Csókás Bence <csokas.bence@prolan.hu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

