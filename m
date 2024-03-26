Return-Path: <netdev+bounces-82010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC0188C15A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169B12E7B1D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627BE7173C;
	Tue, 26 Mar 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REarfCYF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EECD71B27
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454341; cv=none; b=jCQQbhooPb4yA98BL2A9M+HmcJSxmZvmnxe5JTlqs18qJi1etXqt8gYPArcaNmvKS6eczsqFsB9iIZxZOz1L1dRuC96JIs8iXjS/yro3tQKRvXdqbnwoyxZCjd7dD+UIHvOxVShbVS5dp9NMXyjlFXeIXq3a2NYrPM6n9S9X9xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454341; c=relaxed/simple;
	bh=ubEV1v/2Y5vjP6OqKDL4HCqW+g86KH2Ynx1RQyJtvDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVLFtvvLkHVFJ9/AoRi/ZdBeypufsV57WDJwgiE0wnKCxgryUBWf1ggT4aqKK/94KAszfd0OYWUCk8IUilR/uyDkJe/TeuSLm5CxpssJddfhp1Msbt1BuLw3kmAivMs5iNw4v4Ry7TNrqMV/cWEHaGjdAyI7aECHBjZpaEwtX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REarfCYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1855C433F1;
	Tue, 26 Mar 2024 11:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711454340;
	bh=ubEV1v/2Y5vjP6OqKDL4HCqW+g86KH2Ynx1RQyJtvDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REarfCYF5/43F1pFuXH2IPbFbYn/KhXE2zn4naMZwr0QF86Q28NuEepVj9I7Ek88/
	 jsFtSAWaiKomazyQTeTchIwKnhgqPx4TffvO3vTeS3ciqIW90KVQxyAhJ1aI+ME+nP
	 B7KsT7ijdMadD8pRPUx4knlI/JhA+yGnzr0g73yGn0Md6k+HiF8IuQJI1AiA/gu71u
	 u8w/oWaeHyzpoTL6UdtfLxS7OH8Ay1r6FoKJoT8h3qOwoqb6I2/Sxh84MG8l5xO8hI
	 WS5zNiw4vqbU7O4Ttggklq/0wKavsUQoW0sQYwInjsY9bgCRYMSEe+2YbNyXPO1zRc
	 cDbEQstyyru+A==
Date: Tue, 26 Mar 2024 11:58:56 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 1/4] tls: recv: process_rx_list shouldn't use an
 offset with kvec
Message-ID: <20240326115856.GP403975@kernel.org>
References: <cover.1711120964.git.sd@queasysnail.net>
 <e5487514f828e0347d2b92ca40002c62b58af73d.1711120964.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5487514f828e0347d2b92ca40002c62b58af73d.1711120964.git.sd@queasysnail.net>

On Mon, Mar 25, 2024 at 04:56:45PM +0100, Sabrina Dubroca wrote:
> Only MSG_PEEK needs to copy from an offset during the final
> process_rx_list call, because the bytes we copied at the beginning of
> tls_sw_recvmsg were left on the rx_list. In the KVEC case, we removed
> data from the rx_list as we were copying it, so there's no need to use
> an offset, just like in the normal case.
> 
> Fixes: 692d7b5d1f91 ("tls: Fix recvmsg() to be able to peek across multiple records")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


