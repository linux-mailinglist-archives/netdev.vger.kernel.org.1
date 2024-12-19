Return-Path: <netdev+bounces-153254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BCF9F7738
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889F17A20E9
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347C721C9F7;
	Thu, 19 Dec 2024 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CWkcSZ9z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5F78F34
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734596749; cv=none; b=qrF4T2j3cEBoNls/LB3cAOVRb9EZmjJfdc5dwan9gG+eDHYz00lkoOuO1Y2NakejWwA0APy6sWPsqI4JvKR7EWg9vZ4BEevdP1B9M2irxGquJ2fG2ziIACIfs3Q/9pS0BiGMmlvEUuefnlKrt4mImX6p++iaQzsyhJI1V+L3oVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734596749; c=relaxed/simple;
	bh=+IV1YM0zj+IizMIL92Foi//61pkoKgRLJjO0jsxg1BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCut+T9UqX+PHKY/hRuRrjZd21a4If9TitXC/Fkpfa7wxFrb99/ARlx/UmidHNk2QYl40EFyCPOWg6Gak/w5K1kDJwc4/Ofznmj0U0EY8s6hvlIZblTCJK6SUMRyku+9mDELpy34iQu/oeesjzySPTTNLSwsZCXyyektlSY7jm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CWkcSZ9z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L6C74ZNxb25ty4+r4Sn4DchfdKRS/Uy4sn5pI0fqDkc=; b=CWkcSZ9zjHyf6JQZVMlvMn5mD3
	mV2MKEvIC/PpGrbNkqArXCmjibhOREFme3ZHtVV0Dac9ykD9mubifdtqehBBqSWHyxHPu0cqlotwN
	oqVbir8JmbP2YrfSpwLZJBlXyPq7wMCeLZVWyzmrS94xxuepzit1CQHMjnz/Cjvf3ydY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOBqn-001Xrt-3Q; Thu, 19 Dec 2024 09:25:41 +0100
Date: Thu, 19 Dec 2024 09:25:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH net-next] eth: fbnic: fix csr boundary for RPM RAM section
Message-ID: <2a375625-5016-4f4a-a5fa-5a73dc536651@lunn.ch>
References: <20241218232614.439329-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218232614.439329-1-mohsin.bashr@gmail.com>

On Wed, Dec 18, 2024 at 03:25:58PM -0800, Mohsin Bashir wrote:
> The CSR dump support leverages the FBNIC_BOUNDS macro, which pads the end
> condition for each section by adding an offset of 1. However, the RPC RAM
> section, which is dumped differently from other sections, does not rely
> on this macro and instead directly uses end boundary address. Hence,
> subtracting 1 from the end address results in skipping a register.

Maybe it would be better to actually use FBNIC_BOUNDS macro, to make
it the same as all the others, and so avoid errors like this because
it is special?

	Andrew

