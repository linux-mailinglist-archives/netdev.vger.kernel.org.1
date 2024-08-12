Return-Path: <netdev+bounces-117845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BC694F8A9
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39BA1F219D1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8CB16DEA9;
	Mon, 12 Aug 2024 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PMfx645k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C27168492;
	Mon, 12 Aug 2024 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496319; cv=none; b=EXTIjDyoG1rruT+Bi1TBsBL5gkPX5PBVOIKkQy+vze8B8U4zxNRMJIn/wBKGkwWevnOBBHQPXs82kFvR6zdF2y93TjPp/kkELDztfEvQcuwItipt9LLR10QPT/GFm8hklJm7wlqnWJ4MEFNWFlcnRzaTXn4dklum1NEIwZFNHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496319; c=relaxed/simple;
	bh=m6uB3b8dXxVe7SvzlOGq6Avjl6gISjkwjewZ12XxR9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sl/rYxgQXI//eQKcx87jjlY4EJGBb425LlhNpVDEZFYonomOWGra2noelDtnp4C7XwC9KTAl6y4sQOuWB0JuPjcJ9AKfbNZrfQN44qTeEnwTL+bjXxSO4SGWY2Im+T/3USpY0zYdetncX7VjC057m8XVbS7Z+0m1vatT1YJ4lOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PMfx645k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=+eV/a4UVEKW9ggK78KVIpd8kPWb1ysRXIsOH546oDOY=; b=PM
	fx645komuOtTmoyYtMCVZx0hz6B6WvL7RRImRuubWSU0kNWjO+y6kMB7mhJhP/p3QiJoIsBiF6ljl
	tvJ3hL6WA5wj1ALL1QmrF7cu11mIizix4FlkOt3VX87f8FhbsIAf6kH5hlKfrzP8r74hIq0SWrWIX
	VVhNFH533F6Igp8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdc7d-004cOs-Dw; Mon, 12 Aug 2024 22:58:33 +0200
Date: Mon, 12 Aug 2024 22:58:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: Jakub Kicinski <kuba@kernel.org>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>, Frank Li <Frank.li@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v3 net-next 1/2] net: fec: Move `fec_ptp_read()` to the
 top of the file
Message-ID: <8a0c15d0-c2ac-4de6-b011-d79b579ce7c8@lunn.ch>
References: <20240812094713.2883476-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812094713.2883476-1-csokas.bence@prolan.hu>

On Mon, Aug 12, 2024 at 11:47:13AM +0200, Csókás, Bence wrote:
> This function is used in `fec_ptp_enable_pps()` through
> struct cyclecounter read(). Moving the declaration makes
> it clearer, what's happening.
> 
> Fixes: 61d5e2a251fb ("fec: Fix timer capture timing in `fec_ptp_enable_pps()`")
> Suggested-by: Frank Li <Frank.li@nxp.com>
> Link: https://lore.kernel.org/netdev/20240805144754.2384663-1-csokas.bence@prolan.hu/T/#ma6c21ad264016c24612048b1483769eaff8cdf20
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

