Return-Path: <netdev+bounces-218508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397ACB3CF06
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 21:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E717C50E3
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C1E2DAFC6;
	Sat, 30 Aug 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FAijQTyN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09A201266
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756582062; cv=none; b=cw5xLC0KTS/G+b2azichMA9k1DbMnRgb/fcLezsr7QyLsA1qTnWKuN64vKYmG/dNJMb0dWVJJ6H1f53mcVqEkihZAxrW1e804wYnL9FipsziVOItewNvpnJgB2Fpq2BLQG31aH9Ky/8GjaGtocOfPvbPkPqwzMp0f6nv3uk/Ylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756582062; c=relaxed/simple;
	bh=UcDxFYjXWhCMwKpdwLJxzZdxmwSU1ORFXGgzZkHvOac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUp37rxKxVGgQNbx012dCzWN23KHeG5jPLAYTso+SQc3ifJPGHmbHQvJicxEcSdOPXSPp29oAqrEIWIJW6Xdi5/aFbcJIbLtxhC7C2gJK4bKkE5lHYb85F0L59NyEcqJvSasepmXHR21Lun3WNBhIl869XCYHi2WRGo300/DwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FAijQTyN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Uvt2mpGdym0IZb0wC2fj1aXTNIQyGOS/5/SVOX0Crmg=; b=FAijQTyNJ0gvNeBAA8ihuJuDSN
	UNazGSj9A3BGhfC9PhwSz5NzHvR4XjXU0PoJVoSB27DPbvU0sBGn1yRbok8l2XE564poqKv4Fj217
	RsYLVA+vvOlrhh5cbgQzUa500CnnhMLMKMe1hSxhCzsX0rlHFmF2t9LY0Jx0Uyod3pc4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1usREb-006bFV-PD; Sat, 30 Aug 2025 21:27:33 +0200
Date: Sat, 30 Aug 2025 21:27:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>, kohei.enju@gmail.com
Subject: Re: [PATCH v1 iwl-net] igc: power up PHY before link test
Message-ID: <7607d394-9659-4bb0-af14-8a3633cfc89c@lunn.ch>
References: <20250830170656.61496-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830170656.61496-1-enjuk@amazon.com>

On Sun, Aug 31, 2025 at 02:06:19AM +0900, Kohei Enju wrote:
> The current implementation of igc driver doesn't power up PHY before
> link test in igc_ethtool_diag_test(), causing the link test to always
> report FAIL when admin state is down and PHY is consequently powered
> down.
> 
> To test the link state regardless of admin state, let's power up PHY in
> case of PHY down before link test.

Maybe you should power the PHY down again after the test?

Alternatively, just return -ENOTDOWN is the network is admin down.

	Andrew

