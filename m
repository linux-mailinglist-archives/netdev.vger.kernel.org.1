Return-Path: <netdev+bounces-216227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC73B32B38
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B387AE385
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEE620FAB2;
	Sat, 23 Aug 2025 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fzQQDpCK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33633188A3A;
	Sat, 23 Aug 2025 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755969710; cv=none; b=RANMIdiaS3DNbgJUkZAmx6EhC8CFuoNk/TrwYOpFyKEtJvUZY+rR/pfCDnG1BgicSZOt+AzYw7W3VluazP6T4OMQgJwIANpmGalYObWvhJvZMxKbZc6yPvJoBS4HIy+GKo03F/3r2oC8D16iLswJ34cN59HCMGQJMNGLcTFXpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755969710; c=relaxed/simple;
	bh=yVkcujILOiEN8O+QGvLQpBvaBP5NCzO+QRafOsqTuUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMgFIw4TM4rJ1JuT+H09b4Yd0QuINs8vi3cNM+fcjMlzJy5M6uK+o1JLWodPuue5paDsMBH7MP3dLXesGAR3teJ+hPnwknLhucWf4kntdJa5qWBkLcUbx54ctnttu9qSll2PzJ8LppiuYezmCsvvGPLYcF80KoHpBWoLwP8r5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fzQQDpCK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pfDXmi1uYAi/SFUFwl00+0sDDNaHzqpzS9+MtkpgSlA=; b=fzQQDpCKD/qb2dq+6VKOXxo3HQ
	NYZ0fC8Or9iNdu02VitUp6fkdT2j1bz9HZxL+gK5Izqf61ivvP+VSB2nsTtGdVUDQxCfKlUBWDTsA
	n1rwJmbqFRHaNaTKTH3bB8sHrpLQllx0MFvpjw+o+CdRNT+pCiYTmO/K4VtLZGL0Ij78=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uprvv-005lp5-Q7; Sat, 23 Aug 2025 19:21:39 +0200
Date: Sat, 23 Aug 2025 19:21:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dlink: fix multicast stats being counted
 incorrectly
Message-ID: <72b73eef-4b12-453e-96d2-beacbdac8525@lunn.ch>
References: <20250822120246.243898-2-yyyynoom@gmail.com>
 <8f47407c-fb5b-4805-a95f-ca15d6eb7838@lunn.ch>
 <DC9Y9ZQA78BC.34TLXL2P7VT3T@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC9Y9ZQA78BC.34TLXL2P7VT3T@gmail.com>

> Regarding the Fixes: tag, I have one question. You suggested
> 1da177e4c3f4 ("Linux-2.6.12-rc2"), which is indeed the first commit in
> the current git history. However, the actual code change seems to go
> back further, and I found it in the history.git repository.
> 
> In such cases, should the Fixes: tag refer to the first commit in the
> mailine git tree, or to the actual commit in history.git where the bug
> originated?

Nobody except historians care about history.git. In practice, nobody
cares about 2.6 either. https://www.kernel.org/ shows that v5.4 is the
oldest supported kernel. But Linux-2.6.12-rc2 is a convenient
reference point, so that is what is used when it has always been
broken in the git era.

	Andrew

