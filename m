Return-Path: <netdev+bounces-189739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407ACAB36E7
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED503A7743
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BFA2920A8;
	Mon, 12 May 2025 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cjsg+XTp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF873987D;
	Mon, 12 May 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747052676; cv=none; b=nVC3C56dLASmGKSYJ84X6ixQprf7WdZ2QfXIEF/VmDgVEcxSpbPACEdDeFLOSiGvne+2wC7fgknhNinr4M5OQETwYtqY4+n2Xk8SC3Op0bt5LiUd7bMixuLVyNsew/FU/mnlOKAgwTJKgAhM6CFzPKeptyrZknj35GY4r1kVoEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747052676; c=relaxed/simple;
	bh=16F2gtICs4ZIAXeRn2Kvm9BI5xd2yTzYekJDClmF35Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTeAz5EGoW4RnpdLff2BaaAnNhUDaq8fDSGpJMMV8/20f1ANAkG3TTTpjovmsHxVLMucilIWLy9tuDIXxLDIzsFoNxxRU8lA+ZePNxZXpHEOLzV4t2Noa95454ivuAQPyri2G48Z3EX+fpFmWiaRcSM6MD5hGl2eDR3yabPhvGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cjsg+XTp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9zXfnbSppYVkiqJbjpkISDfr+gejKpHcxRUUf046aNk=; b=cjsg+XTph1oymI6oio60bnKYV6
	5+ZK7uWPdA/GU7jDAsNX7NwYHWJR6IOr8V3B1p9rm1t9YFGCCSE7vNQvQuYgUY0ctp9aLboEmcQWe
	XDNPzYLQD09fKegTnAXQ3yQ9cAHpxUmOVf2WdeV0yoZ9iDx1Bv8iF4pcNt/GGGGTg20c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uESCl-00CKfj-Te; Mon, 12 May 2025 14:24:23 +0200
Date: Mon, 12 May 2025 14:24:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: zakkemble@gmail.com
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bcmgenet: tidy up stats, expose more stats in
 ethtool
Message-ID: <244e2b38-b1bf-4632-afa1-acc018bb20dc@lunn.ch>
References: <20250511214037.2805-1-zakkemble@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511214037.2805-1-zakkemble@gmail.com>

On Sun, May 11, 2025 at 10:40:36PM +0100, zakkemble@gmail.com wrote:
> From: Zak Kemble <zakkemble@gmail.com>
> 
> This patch exposes more statistics counters in ethtool and tidies up the
> counters so that they are all per-queue. The netdev counters are now only
> updated synchronously in bcmgenet_get_stats instead of a mix of sync/async
> throughout the driver. Hardware discarded packets are now counted in their
> own missed stat instead of being lumped in with general errors.

Hi Zak

That sounds like a list. When i see a list in a commit message, i
think the patch needs splitting up into smaller pieces.


    Andrew

---
pw-bot: cr

