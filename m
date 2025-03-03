Return-Path: <netdev+bounces-171350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C8AA4C9F5
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94883B7F89
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DD42376EC;
	Mon,  3 Mar 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oF4Rr2fb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77334215F7C;
	Mon,  3 Mar 2025 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022458; cv=none; b=pu9oi/B2VkZ5EPq+7rvn/dYhrrgw39LRNH5/B6/N6jBnBIhpjJmU5ls5HVliWp5rn4m/FTeVHoCai1UFfu9Ngg9egARUzqVL8NDJl7HYbK0A4qYS4D8nw2jiTd6rxe4EeAz2hyyJJ3MsUaDRFC4WKaE5SqKgPB0r13Je2sQ01Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022458; c=relaxed/simple;
	bh=rZrITLuqk236CJ6Fx5KURSt5qlvDhoqjPPOJPOYr1bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj14b7l+yy8u1y6+iFfDKnDMO3/Oik93eUTVFStZC3zlm6xWDsRVT7UsvrnGEg9TwTLVwS1RdYpw4ff9Km0KUsuozupXHinNucLFnCcEhh4w+j3+SnJi0ELpZYlrOiGQi0Kkj6X+zTLsSrOS59IuXAhRjCfMLR4EjEm6slwED3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oF4Rr2fb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DEzZ4I9i+rAzUmDhMOQ9Bx2T7VvevKaFXkvxEnNO4ao=; b=oF4Rr2fbPPKNt+oqxSHJhmpvbD
	mwKn5WFE74yvNXSHtCUM0UVmOaYGUwbKK+XZmOnlLKTiS0F9cJCAsw2UrmEh1HzfglkwL97wbqez4
	tDMW3f1z+dhEYutVeAUJabQE1Lyju+zPoZC7WSnTJheys0d3lgQ69T32b/aPycWG34rg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tp9TD-001sKF-PN; Mon, 03 Mar 2025 18:20:47 +0100
Date: Mon, 3 Mar 2025 18:20:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: dp83826: Add support for straps reading
Message-ID: <fcc25495-5453-4b15-aece-b01bca3a00ba@lunn.ch>
References: <20250303-dp83826-fixes-v1-0-6901a04f262d@yoseli.org>
 <20250303-dp83826-fixes-v1-2-6901a04f262d@yoseli.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-dp83826-fixes-v1-2-6901a04f262d@yoseli.org>

On Mon, Mar 03, 2025 at 06:05:52PM +0100, Jean-Michel Hautbois wrote:
> When the DP83826 is probed, read the straps, and apply the default
> settings expected. The MDI-X is not yet supported, but still read the
> strap.

What about backwards compatibility? I expect this changes the
behaviour of the device, potentially introducing regressions?  Please
add an explanation of why this is safe.

    Andrew

---
pw-bot: cr

