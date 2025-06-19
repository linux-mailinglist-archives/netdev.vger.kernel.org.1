Return-Path: <netdev+bounces-199400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C668AE0282
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 175887A2360
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A562221725;
	Thu, 19 Jun 2025 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaBKFgO5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082C2045B1;
	Thu, 19 Jun 2025 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328360; cv=none; b=iyBqZg1lyKBCCAtuhF/Ok6grXxdLS2h9biy+tKaBTHNiZ6DsBr+4Z4YW6BhbNAXRd/tkTUsbdBh1oLelS+8y0xzBKu7L0+lPyNFRwqC90Y19iRBCRrLOvWyej4vmCSA95Q6tsrtbChre9C7omnRHmDQjq3j8WBPOeUUsYpzRmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328360; c=relaxed/simple;
	bh=nc5Z03ifL8Bw2B3MIIq3m99HTuGpRtqrJ0KIBEz/CLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUs/1ZBmqUWmdlXwfr3s827L4zelPGyKmrT/kxrm0+HfAkQ5z6JHCe0e7PhsfNwX0LscKn8hUncn+yFrXB9ro0wnieCcPyYBxgG+GPbrPp86SCJVRgiRZ499ERL+p2C41pHA2UNM6KaHZU6tjs9VDWDAKQFVtXl5AlxDWT447N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaBKFgO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1346C4CEEA;
	Thu, 19 Jun 2025 10:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750328356;
	bh=nc5Z03ifL8Bw2B3MIIq3m99HTuGpRtqrJ0KIBEz/CLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MaBKFgO5UkZSTLUqNHefuZp+ZXrkFegKRWJ528A/8OvuYxpZsGXVt0aIcQy8G+00Q
	 /6Xdd+l0uv9+rBjNT9BEcDZLzjXUp6+3JN11SvJvalJ78dk4VMI4Bi02RL4TJ9FSuk
	 +ldFW4rxFQiZvg3+oR+Vg7LGTQFGFtDBgoG8ijv3o9PYiD6nvDShT2xofNFtPUoXEC
	 x4onhSIO81e9ysk+/je+4qjRPnFtN0mJb3eWCxqt7EexkDlaibwbF/Rbyfmnyt8cAT
	 bQUpr2s598jNKNm4txg+7bHPLBrW8nxGAJd8VTpFrKba2NEkcoaxxnDPJLWj5Bqs1F
	 zKWXm40fXOQDw==
Date: Thu, 19 Jun 2025 11:19:12 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	jv@jvosburgh.ne, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH 1/3] netpoll: Extract carrier wait function
Message-ID: <20250619101912.GE1699@horms.kernel.org>
References: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
 <20250618-netpoll_ip_ref-v1-1-c2ac00fe558f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-netpoll_ip_ref-v1-1-c2ac00fe558f@debian.org>

On Wed, Jun 18, 2025 at 02:32:45AM -0700, Breno Leitao wrote:
> Extract the carrier waiting logic into a dedicated helper function
> netpoll_wait_carrier() to improve code readability and reduce
> duplication in netpoll_setup().
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


