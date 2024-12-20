Return-Path: <netdev+bounces-153701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD73A9F93FB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9668A7A18E2
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4904215770;
	Fri, 20 Dec 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSllzu34"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB381A83FD
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734703811; cv=none; b=BN4tNe91u9iiXrtq89uQq2qw6GGuBGs9/7sYmzbgnHUx7Iy/3FKgi3nrtlKvSapoVHM+4P44yyWKms9qp+lInH5UriihvB7TJ5ihtf9kwCDvfyH51cIfR2S5RE5DzAvFL8bVcNe86JQhE/KIA+y+Qv8cY2EaAogPxoyrDqKdXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734703811; c=relaxed/simple;
	bh=CkUe+JgXwGmZ74/x0ABRa0fzcL03t7pm1wwL/X/6qxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhLdSa1Q7XGV3QbaemlmMcyF4SyJHUuc1Y5XSNbdnvf4Np4hSsIZG29fyquggY0d1IAgGCwuJ3+kdkKCawt91HW8lBkmINjV4u8GCYkZmfB6noWDylhCRCP/BXJALFJ2oHT1Ef9EKOwxEp6Z8YJwyD4pdZDsfZ0NDZQMQnBbYJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSllzu34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C698C4CECD;
	Fri, 20 Dec 2024 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734703811;
	bh=CkUe+JgXwGmZ74/x0ABRa0fzcL03t7pm1wwL/X/6qxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oSllzu34vozQwyAFWntvtfUxBfyUitkzcsDiZWG9NMNRqss3iFz77TZaN+Ylc0Qex
	 GNbUxAx4cwifpAhv/bmDeuejxBNGnAGm6uhjB62bWEcpXsx+SArszleehnjaJijpdW
	 F2CdhzimzO4eXCiwgQCxhFEZfvd1aFWzmU7ugO/QqcZQouju47Ovlaz68EXTAspSTd
	 8a9zz8u1oT3bnRKvZYBLqd71rbCWe6lJpw6XXQQQbNHSZ8/V+N2SWiWLE9ribKWm49
	 Y69hmBLXExGztu8uJSmjvP1oPTqMTPyvXKZtbYPnpdE+Gog5/oMEm9Gwq9+HEFMs/f
	 /tGlfL8DTUCVw==
Date: Fri, 20 Dec 2024 06:10:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <davem@davemloft.net>
Subject: Re: [PATCH net-next 10/10] eth: fbnic: support ring channel set
 while up
Message-ID: <20241220061010.2771d19e@kernel.org>
In-Reply-To: <6c788136-514a-429b-8a0c-db37849601a1@intel.com>
References: <20241220025241.1522781-1-kuba@kernel.org>
	<20241220025241.1522781-11-kuba@kernel.org>
	<6c788136-514a-429b-8a0c-db37849601a1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 14:49:02 +0100 Przemek Kitszel wrote:
> > +	fbnic_clone_swap_cfg(orig, clone);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(orig->napi); i++)
> > +		swap(clone->napi[i], orig->napi[i]);
> > +	for (i = 0; i < ARRAY_SIZE(orig->tx); i++)
> > +		swap(clone->tx[i], orig->tx[i]);
> > +	for (i = 0; i < ARRAY_SIZE(orig->rx); i++)
> > +		swap(clone->rx[i], orig->rx[i]);  
> 
> I would perhaps move the above 6 lines to fbnic_clone_swap_cfg()

Hm, it's here because of how we implemented ringparam changes.
They reuse some of the clone stuff but not all. Can we revisit
once that's sent?

