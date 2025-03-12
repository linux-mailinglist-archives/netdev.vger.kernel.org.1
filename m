Return-Path: <netdev+bounces-174216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB59BA5DDC2
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21679189DEB3
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D632D2459C1;
	Wed, 12 Mar 2025 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oYTulVup"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E68226CF8
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785336; cv=none; b=F7vyoTERQsgm21D8658RDqwJCX4r/r9GB8CLlrZNJtoGeMcLEajsfEgC3s+QQdJlVbYTD/wmmoJAjoQaBKYja69h/+66P0ZSluIgnE2L36nejMT+2DZDHOWWegvfZwR/oV/2Q+Vg7ygJL7kiF83S9ywVLy20Mzi1uVlszTPzjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785336; c=relaxed/simple;
	bh=CTbJ2lPautz/t2+WGPJ5lPK7SYw1Mu/lFSUHNkzgFno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuBuJ3x6gZ5cGROvha6xaI/IEZWSm9UfzR1WlO0fmjNZcwYcBWhc5VyJeER/NIzwi2NCR+PUw/sl6BZRi/x8C0pY4uV4zHhv99SXIwnsIZTVEpt39Aep0S7c5dV6k4SSKLcK0kTf/l1ZjVSuKE0Bt64i5m7VKJhqWuhhzn1F1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oYTulVup; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w3R1Y7PnTOsubVQr+4DQ3udIBBSdZmKtjKtieh361Zs=; b=oYTulVupZS1nLdLvVWI8g5wkKW
	PkL7S+jUES7rwk4vsh6TFtm7PA8NgwuW0eq6Df3DdEdCesihXhaC7uDED4/bFEvSLSB60zXTgjLeI
	5DM++QUPOqZKFCk1TLz+qlId3xz3+rZ5a0o8c4ooWq7AtsA0kCZgPgAei3d6qU9Wv7DM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsLvk-004ffO-NN; Wed, 12 Mar 2025 14:15:28 +0100
Date: Wed, 12 Mar 2025 14:15:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pierre@stackhpc.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
	christophe.leroy@csgroup.eu, arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2 1/3] devlink: fix xa_alloc_cyclic() error handling
Message-ID: <e22659e9-e612-4053-adc9-742e564a8e3c@lunn.ch>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
 <20250312095251.2554708-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312095251.2554708-2-michal.swiatkowski@linux.intel.com>

On Wed, Mar 12, 2025 at 10:52:49AM +0100, Michal Swiatkowski wrote:
> In case of returning 1 from xa_alloc_cyclic() (wrapping) ERR_PTR(1) will
> be returned, which will cause IS_ERR() to be false. Which can lead to
> dereference not allocated pointer (rel).
> 
> Fix it by checking if err is lower than zero.
> 
> This wasn't found in real usecase, only noticed. Credit to Pierre.
> 
> Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

