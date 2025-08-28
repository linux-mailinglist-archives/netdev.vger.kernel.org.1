Return-Path: <netdev+bounces-217940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C901B3A751
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4381980917
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944F6334720;
	Thu, 28 Aug 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d7GPMDya"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E936232C302;
	Thu, 28 Aug 2025 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400830; cv=none; b=HBr06NXZntugvtSji+Ywtn+Al7ytNrGf5FHitLFLeGTMoZw3wN0avTYfdYmD2AGdW6HbRuVNMfFSWgeBZfhpoEH/mxvjsclrnv/RhZ10MFuQZ80RALbDgKK2olrUfJC7kdaVGB4ELDizfuUq30eEpS8/imOAUQKOMsMtw7DRlQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400830; c=relaxed/simple;
	bh=kE8RjZBkM6Uryl5yEmHVladAIfVXfO8evEUiDa2e4Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVbM93Sf4ZPJsIhbePrHhzA4F+yNE+YDmGYyL8lLhjUFWv1w3XQm/JgKI4PS4KhXchBAGDIPaK/cpW87PqS1beACVdjetjKUawOlP6co4CwdHoz242vUpMDAceCdQOvw5wiuFYkTmRT5DtrSbzyN6fR3jM8iz3GI8GKubmXZxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d7GPMDya; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OvXV0aoXbSw/DhaHwzMZIvHkpdlUIBQo0SQJA3MINc4=; b=d7GPMDyacaIs77+63ehM2z0Eu2
	tUYhUDUf95yDD+w92h1ikQDjtG2N6NfGaOO0RvOSroTindthnKxeJ8QcdQhnOVKmjuNCgU9us7JLG
	TRS0nhNE1gTXFP3sPsqYYu4UB6/KTsz94CnsHHauTtUGa29ENlO5V4tkziBSCXSSdxxQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urg5H-006NEb-Je; Thu, 28 Aug 2025 19:06:47 +0200
Date: Thu, 28 Aug 2025 19:06:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	sdf@fomichev.me, almasrymina@google.com, asml.silence@gmail.com,
	leitao@debian.org, kuniyu@google.com, jiri@resnulli.us,
	aleksandr.loktionov@intel.com, ivecera@redhat.com,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
Message-ID: <013d723e-ac62-4207-ae66-31126f890429@lunn.ch>
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>

> - use netlink instead of sysfs

ethtool is netlink. Why is this not part of the ethtool API?

	Andrew

