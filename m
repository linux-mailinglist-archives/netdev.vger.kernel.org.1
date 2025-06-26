Return-Path: <netdev+bounces-201422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4EAE96B1
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200966A00DB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A923B60E;
	Thu, 26 Jun 2025 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahvRgeK6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06FA23ABAD
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922710; cv=none; b=iSFmI1x+FK6BkSPuDTvT97NLXqTz1OGUplnqLrpvTGXbCLpff6qiQH3IFxnkdcMbOP5AiSy4W2bT8xlVNrndpNU0focszRVyyfbjTjS+efTVJ5s/E3v/kqONjBIoWSzbE7lfCizFSP0bHmMZ0ajD11ipS9aA+wamNlhYUT5x460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922710; c=relaxed/simple;
	bh=WECjwngyFzZ8Wpr/p3N81bKUD8FbeCPP7zZ91bZtVBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwuH0APVdI06JplPzl6f985sPkIts33BZx+nuW8QZP4CO4YbH4843K6VHC34GvIysJVus52c8S5H+XFfwFXnZv4W+V5sM+FUSh9OEYJyc/5w3KSUJ2F2/UShTEmy2XQeQt4meHM6SfQigQxNO/cKR4gJ1Z4aBM9bnUygOpoY9qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahvRgeK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CF8C4CEEB;
	Thu, 26 Jun 2025 07:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750922710;
	bh=WECjwngyFzZ8Wpr/p3N81bKUD8FbeCPP7zZ91bZtVBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahvRgeK6AjRhZZhMhtks2UXuIKdJfn2JFI08Aia1nCKD6O1TBydfwO+kof1mCPvXV
	 VvtS+vcgDxaFCLJXk7vawMYTFZ7ELklki/KXYegaYDitgJG/39h525uR6LKDAvxOwv
	 b1vFM9ybLC20Q66we/j+qkckQ+wv8KtlKEPDp4/VfksOIMvMWQBy+zvJaqKjHRo9H/
	 HZGm7jOoL932sbpqf2MxD+0aQwQwqeiPdxm/P/Y1amG/Bg0vlUuK7L/cIa8rn8ZIjD
	 /ff/xnDj//OIXBIAaeLJnwsb5pcWgCOArZq3U1Lng7UV9o8aAuWfAHwujdrLgzW1KA
	 O76a43cfh6nMA==
Date: Thu, 26 Jun 2025 08:25:05 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
	netdev@vger.kernel.org, Suman Ghosh <sumang@marvell.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Check for DMAC extraction before
 setting VF DMAC
Message-ID: <20250626072505.GR1562@horms.kernel.org>
References: <1750851002-19418-1-git-send-email-sbhatta@marvell.com>
 <20250625190247.GO1562@horms.kernel.org>
 <aFznYtDq9ywfk5FJ@822c91e11a5c>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFznYtDq9ywfk5FJ@822c91e11a5c>

On Thu, Jun 26, 2025 at 06:23:30AM +0000, Subbaraya Sundeep wrote:
> On 2025-06-25 at 19:02:47, Simon Horman (horms@kernel.org) wrote:
> > On Wed, Jun 25, 2025 at 05:00:02PM +0530, Subbaraya Sundeep wrote:
> > > From: Suman Ghosh <sumang@marvell.com>
> > > 
> > > Currently while setting a MAC address of a PF's VF (e.g. ip link set
> > > <pf-netdev> vf 0 mac <mac-address>), it simply tries to install a DMAC
> > > based hardware filter. But it is possible that the loaded hardware parser
> > > profile does not support DMAC extraction. Hence check for DMAC extraction
> > > before installing the filter.
> > 
> > Makes sense to me, but should this be treated as a bug fix?
> > 
> No strong opinion on whether this is a bug fix or not.
> We assumed DMAC is required always until on of our customers
> came up with profile with no DMAC extraction so that they can
> use the additional MCAM space created for other packet fields.
> I will send as bug fix if you insist.

No strong feeling on my side either.
Let's leave it for net-next unless someone else thinks otherwise.

Reviewed-by: Simon Horman <horms@kernel.org>

