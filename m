Return-Path: <netdev+bounces-92221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB2D8B601E
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 19:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF851F219DE
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 17:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F88128386;
	Mon, 29 Apr 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCSvPhhr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4B128379
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411814; cv=none; b=JcGWr9NbpoRjhSthMMRGj4vm/lzPpRwmxNhivoC+zhgxnLeUW91Y5+P9zHDOxdpYVC9P1hsmuzOGoMIiljhQLX1lOlb8uxgDZIkbomWS0wm7kLsgAoHX7P6+7LH+gDlvG0SasfGnOeZysA/41IOzQ5o+cPrqOx4BncFu/A9AbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411814; c=relaxed/simple;
	bh=lgOHZB+LN+xk8nxHegeWJmuwA3L9AVKxB/QzY3NDfsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRC8Bf/6K3Alp3hO1EyPglkN20ZaCZqYf2iWSXX1GHimJHzmUecti0AkyKRGzE73ruy4xe64jJc115ysx6K+4n33ABXYMMJfUPVK4DEHkH7P6Mk8X4L3H/QleReBoXzaFsN8aksBNnnN8/2SlieBSlkgD0ePHR3OcI54r2VErc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCSvPhhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0341C4AF50;
	Mon, 29 Apr 2024 17:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714411813;
	bh=lgOHZB+LN+xk8nxHegeWJmuwA3L9AVKxB/QzY3NDfsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCSvPhhrhcm7JPLMYknTd/wy9uAv/Ke/cVFsR6wEizKNkzJ32Ewid5kvF2gB0m058
	 fh5xV6/eh9I0U6LHvxNAg11db3gMdQYsHUDwGJ8zApevSgDNZiQpEW+ndsYkUpV8cU
	 fsErxCz86BZSmVRBPzGEWhSKJ9+wSkHw3FARbddWX1LPBDW2oRXCPENlo0ARFQlm5Z
	 Z62ttuVJ48J+d+8uzGyB+hTVOurkb5CN2Mv9Lj1Z2gLzyuyLqrPEN/xMhWmMbHdJWx
	 iteeumUbZ7CO3aMgHNLillLy0kTYuZ4lpsXz7W1qs1gRDBLOTvY3pd9SQkO1VQkmvW
	 ok7nBVNGrdFsg==
Date: Mon, 29 Apr 2024 18:30:09 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Taras Chornyi <taras.chornyi@plvision.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: prestera: use phylink_pcs_change() to
 report PCS link change events
Message-ID: <20240429173009.GE516117@kernel.org>
References: <E1s0OGx-009hgr-NP@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1s0OGx-009hgr-NP@rmk-PC.armlinux.org.uk>

On Fri, Apr 26, 2024 at 05:18:03PM +0100, Russell King (Oracle) wrote:
> Use phylink_pcs_change() when reporting changes in PCS link state to
> phylink as the interrupts are informing us about changes to the PCS
> state.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


