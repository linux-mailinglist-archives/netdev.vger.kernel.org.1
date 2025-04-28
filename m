Return-Path: <netdev+bounces-186445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6F4A9F1E1
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE0C3BFF93
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5688126FDA6;
	Mon, 28 Apr 2025 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UHDq3OKX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41C26F466;
	Mon, 28 Apr 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845644; cv=none; b=HY4THS1gmqwVvUrhhmvnfMEstYERPjIYnDAGhtrj36qZnj1kzwglTn/ucKizoEL/XuzByefNkQjKzvQdxVTmSEvnL05tbP310BYaisJal6po3y4HybpMPuel2kBm2w1vWQ9DH0wIMJjtbFHX8kF0UyALglOuTje/2EMfllKKHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845644; c=relaxed/simple;
	bh=Ax891Nox1a2xec8/ZkKufmRYmTPkJZe4DC1uvxb1cAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQn5BNJhxGS62Gj42oNmG+JmYMYUACiFemNjaUk0qazCmU6n3eOob6c363t5+EZ74ycFE/E1S9fRhzvCYUqkD6grYSOxX9s59s6UiSR68qKC959F/hpg/HoLaAhYvjUA+W34XsJcXMS2SqhuH/6rAz6RydpEK6sNrdWGl3IxmWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UHDq3OKX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7Qyt7PxI9KUj05U+lBS44OxK0DlxvfZjT7Dm3aqvak0=; b=UHDq3OKXHzpa6ys65nE3S88D0j
	9eNZR0UCJWMkO4tqTOmrzicJohICgz+9CbP4r8naHbYZleQUaZflFGpOxNhuMdz5InVDGGbskznyu
	HhR+5fWTYiJjmGOKhLI9frE/Yggri3A19pIw26xZBf63aDkvKvvAx2p53UdxumRZvw7Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9OCY-00Aq7R-J8; Mon, 28 Apr 2025 15:07:14 +0200
Date: Mon, 28 Apr 2025 15:07:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: mattiasbarthel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, wei.fang@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mattias Barthel <mattias.barthel@atlascopco.com>
Subject: Re: [PATCH net] fec: Workaround for ERR007885 on
 fec_enet_txq_submit_skb()
Message-ID: <e17a1459-c388-4ad2-b79c-ba158edf340c@lunn.ch>
References: <20250428114920.3051153-1-mattiasbarthel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428114920.3051153-1-mattiasbarthel@gmail.com>

On Mon, Apr 28, 2025 at 01:49:20PM +0200, mattiasbarthel@gmail.com wrote:
> From: Mattias Barthel <mattias.barthel@atlascopco.com>
> 
> Activate workaround also in fec_enet_txq_submit_skb()
> when TSO is not enbabled.
> 
> Errata: ERR007885
> Symptoms: NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out

This is rather brief. I had to look at the reference commit to
understand what this patch is doing. Ideally the commit message should
to sufficient on its own. Please consider cut/paste some of the commit
message from 37d6017b84f7/
> 
> Fixes: 53bb20d1faba ("net: fec: add variable reg_desc_active to speed things up")
> Signed-off-by: Mattias Barthel <mattias.barthel@atlascopco.com>

Please wait at least 24 hours between posts.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

