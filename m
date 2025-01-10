Return-Path: <netdev+bounces-157236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01605A0990B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69EB188A436
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F374A2135AA;
	Fri, 10 Jan 2025 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ca9Px4lq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E59224D7;
	Fri, 10 Jan 2025 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532236; cv=none; b=uoOFROhbg8ms5LvWHe9EhhT6nYfrBMh/NorXldycZxAs/PuHh3y3fbmNr7mg7iIrJQqnX++LRNZpSWs7yX3USysEJ7+8RsPjLukHo4jRC0klb9zFekrMKo033Yh4xIn9ukp7x2eyC65kB0rkZNpu7tg4dqYDSz9ackkiIBTf5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532236; c=relaxed/simple;
	bh=iy1p6LIprk/shvVzcnEMX7IkmvlRWP9CStJeJHkcz9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+Eh8BDFv59bt0+fNwYZ6cnVvR0fS9uvDAMXex31wWtlEWUNd4njbY1m5bTTy/MwgTgPE7M5lQvNgAf0ohK26ygqu6K1Su976a5dCLJGSHp0/c9f2bLjD4Sdz9NrP6GhfVuB3WTEPg2GhOnXKD+Em0nSyj0F2I7hwhLZwOWeMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ca9Px4lq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m8BUNncu11HwpewbmhcHwZpOIg5eztJg2l5h1Hs/aKo=; b=ca9Px4lqoqe/cz4SzFDcU4KyCI
	skqH/aGO8BINyeLCJb8r/9cH/A44AVEzDm96uibUyRFndz8Hx8sHzLtxxDmHYi/ELLxTTPBuc6VTZ
	FA3OVECTBjLYYlj0uUDv2uzjulBr0afTgDf+/lZsOJtrNg04XSOfxytkYp8qhCp6ffcg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWJMI-003JQJ-UM; Fri, 10 Jan 2025 19:03:46 +0100
Date: Fri, 10 Jan 2025 19:03:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] net: mii: Fix the Speed display when the network
 cable is not connected
Message-ID: <b80d02e7-3eae-4485-bf54-84720dbb6a5d@lunn.ch>
References: <20250110092302.2717512-1-zhangxiangqian@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110092302.2717512-1-zhangxiangqian@kylinos.cn>

On Fri, Jan 10, 2025 at 05:23:02PM +0800, Xiangqian Zhang wrote:
> Speed should be SPEED_UNKNOWN when the network cable is not connected

What driver is actually using this? Have you really experienced this
problem? The mii_ code is really old, i doubt there are too many
drivers in use today which use it. So a bit more explanation would be
good.

    Andrew

---
pw-bot: cr

