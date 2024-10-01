Return-Path: <netdev+bounces-131077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF0698C833
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC1C1C223C7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D801CEAD2;
	Tue,  1 Oct 2024 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LbDpmC7H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D53718754F;
	Tue,  1 Oct 2024 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821628; cv=none; b=DgqTFLnZmXAv0aUCBZClkDUQn5NOft0dk69y8+v9N2dy6g6ZoGtjgadhnVRGYZNzObUmnaNn57zycPSfq6BfCTaalXUTcZdHELVX9xtPgEmDmSvYITrlTZtOhuaBK4NuT7UjuxRfEwPF4x9gBoA4MOJKyvCBdjYQ8YCuHLYPCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821628; c=relaxed/simple;
	bh=51LbexFwK0YQQ28fdtqw2k7abP8+y1HUPYTPxw/ApJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvcIhpkM82RJzZ946Xsa4aDYrJfg/qeqOKT5184HVnee9CHFqj5UJn1u5UP2gMpWQWaAP+OngtsZIxDRFCrOWph+iTlHxBZ2fgS8RM0LH6ohZMg6g/N8AJeTe2URhMu8HErvBJ51yklk5tN0cs09eUtBceUM6dMpDVbF+ntWqqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LbDpmC7H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6snPD6GO4nwI7RPlOArOQJrfvNvCOC4fiwI0Wy7H1cs=; b=LbDpmC7HO3LTir3sB9GnMNnSwg
	J77S8u+RO6cTRaUKojyj4g+vyuoaoPBVsKcQ+L+tnaPoBHHy23jVElX40UXGw65h5hZ8dz2+uNZxe
	EnUNc5bBET3WdDeOHAsCCX0x9ekr4iy2XtF/z8OaYy1dBhb4DdDtA0HXKOSYkujCI3T4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svlKe-008mW7-9E; Wed, 02 Oct 2024 00:27:00 +0200
Date: Wed, 2 Oct 2024 00:27:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: Re: [PATCHv2 net-next 3/9] net: smsc911x: use devm for regulators
Message-ID: <ac48716e-484a-4d33-9f00-e793ede7ce71@lunn.ch>
References: <20241001182916.122259-1-rosenp@gmail.com>
 <20241001182916.122259-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001182916.122259-4-rosenp@gmail.com>

On Tue, Oct 01, 2024 at 11:29:10AM -0700, Rosen Penev wrote:
> Allows to get rid of freeing functions.

The commit message does not fit the code.


    Andrew

---
pw-bot: cr

