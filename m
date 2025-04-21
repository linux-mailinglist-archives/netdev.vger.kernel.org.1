Return-Path: <netdev+bounces-184392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE09A952DC
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 16:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79565163EC7
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267DC1519A6;
	Mon, 21 Apr 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R02evO0w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28AC2905;
	Mon, 21 Apr 2025 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745246024; cv=none; b=u/16snqsqwPeEXMLlwHywGXypc2W6iHP24GIBYKhZrZknKHy+pgDWBhnxvuYQmGyOibMvv0kuEbIYx1W2ZVGTe+s3aFWFtdKil6pCGhPejZcWZ/SRduzjz1xuFKmJSmmBpVO3F/COLYfUG/o5tiwA5NujX08tGFm20T3OcSqrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745246024; c=relaxed/simple;
	bh=HDiJ5++BlTpb9ffvdGCvbFkbwYTqfZQchwWl5txUwxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxknrxEM1Tbg/XkjE3ZVkaKsb+Tge1P5UN3zv+zsAnzE1nAumDoQnaCLmKShL8RLbpWtRtdrmdDLAigMlTNEiiCPcCyDyBdPsV/H8nGjPFfbtu7ZCktyHsSaPkwTkAQVnmAaYppaWbLJ5fC650SSz1JWDg3DM7NHy73dIwnKVF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R02evO0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC5DC4CEE4;
	Mon, 21 Apr 2025 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745246023;
	bh=HDiJ5++BlTpb9ffvdGCvbFkbwYTqfZQchwWl5txUwxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R02evO0wwe+ndwHFx/F53RCPQ8ueouBxESVL4SQzl4CADqPwl5W+BMA6dXNzZaoq7
	 NoCT1FBnUQChesDzBgwxcW4Y1FOdB45EVfUDOonEypYzfW1UZ29zUciENdtkP8VJRP
	 eHdblRTwIQ+QS9uksRiHr+K5jfQCtK0ghqgi+HuApeIu+bEYYFumvyVgoXu8l5YWMW
	 PPVl7UEhbMgE79LW5n8RR8slvaEmzpTOslvgtbWfD8+3ZW2KeSRoiSGZPstNJBk3Aa
	 A/UAN8C+2Yqv4OeH/9e9yot/Rli5h+39NBLB8HgytyZf+gKnIJ21LIea50D8AeSMLV
	 oRmhARR0161LQ==
Date: Mon, 21 Apr 2025 15:33:39 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v1 2/4] net: selftest: prepare for detailed
 error handling in net_test_get_skb()
Message-ID: <20250421143339.GN2789685@horms.kernel.org>
References: <20250416161439.2922994-1-o.rempel@pengutronix.de>
 <20250416161439.2922994-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416161439.2922994-3-o.rempel@pengutronix.de>

On Wed, Apr 16, 2025 at 06:14:37PM +0200, Oleksij Rempel wrote:
> Replace NULL return with ERR_PTR(-ENOMEM) in net_test_get_skb() and
> update the caller to use IS_ERR/PTR_ERR.
> 
> This prepares the code for follow-up changes that will return more
> specific error codes from net_test_get_skb().
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


