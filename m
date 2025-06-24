Return-Path: <netdev+bounces-200662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C5AE681F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587671777A9
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFDC2D5C80;
	Tue, 24 Jun 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h44hERDP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94472C3769
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774318; cv=none; b=ecR55dkbMnI21nEucNXODshtBZNGnF3Khc7av6mBcJVp5OylLYmU91CzE3z4r7o6tBhVWepmf5xlHPz9g+ksjmQcs3afIZpZyTchQgB2FHjHKWVzTg3Lj0Cpd7wNHUEbd5npl2ErT4yfGusSx7ZWqpicTxk+vEd31OZTdj0bQig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774318; c=relaxed/simple;
	bh=Kjpnc7jhHozdVRNxE70IeiSxCNBDm9jpLX1OIn8ZVyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6jlybBY1OI7P+6JU5ypAlWm2gSbkfZbZ5BuMUPB7lU3ZEYdCmTbcqL+H7LhOwBgngSznAL+8lvJTtnikPYVs5P2Df+MG+YrgH/jlB8BUr5Il1Un19+ObuaXaMHnZmlCCLwoPppR/iG6xT1n7Vh+y1NjiYEHu52uLPr505JsSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h44hERDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1539AC4CEEE;
	Tue, 24 Jun 2025 14:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750774318;
	bh=Kjpnc7jhHozdVRNxE70IeiSxCNBDm9jpLX1OIn8ZVyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h44hERDPosw0Q54VnPQuXSiZpMCxJWdl8XwlcMYdslKSR1KxiuV240x2n4S+JpnAB
	 3MT1+AZRKNB10v5wtlOs2/I8Bqxo6P59Xku5ClXII4SGRI2GsM4QXFBRB6kIOHvUa7
	 xP5VfTDwFSOzxgDWUjZclX5x1P/a7r3Y6mOE1TrlMEV7z/RUkLlj+l7Vp84eW+tx2f
	 VNXW9ao2nEDPXQURhrWBse+P8IsAPvW5aDX41a/9xK0cdZg5mUhsJkeVCvUO+1ChXo
	 KHiEYsDtSR8EQa4nLzR+aOluoKb9Z1RUOH49y7ciHQpIpvNeHNkORNbB64mOpEXZge
	 PN5nr2fBeKl6w==
Date: Tue, 24 Jun 2025 07:11:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: jbaron@akamai.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuniyu@google.com, netdev@vger.kernel.org, Kuniyuki
 Iwashima <kuni1840@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] netlink: Fix wraparound of
 sk->sk_rmem_alloc
Message-ID: <20250624071157.3cbb1265@kernel.org>
In-Reply-To: <93633df1-fa0c-49d8-b7e9-32ca2761e63f@redhat.com>
References: <2ead6fd79411342e29710859db0f1f8520092f1f.1750285100.git.jbaron@akamai.com>
	<20250619061427.1202690-1-kuni1840@gmail.com>
	<20250623163551.7973e198@kernel.org>
	<93633df1-fa0c-49d8-b7e9-32ca2761e63f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 09:55:15 +0200 Paolo Abeni wrote:
> > To be clear -- are you saying we should fix this differently?
> > Or perhaps that the problem doesn't exist? The change doesn't
> > seem very intrusive..  
> 
> AFAICS the race is possible even with netlink as netlink_unicast() runs
> without the socket lock, too.
> 
> The point is that for UDP the scenario with multiple threads enqueuing a
> packet into the same socket is a critical path, optimizing for
> performances and allowing some memory accounting inaccuracy makes sense.
> 
> For netlink socket, that scenario looks a patological one and I think we
> should prefer accuracy instead of optimization.

Could you ELI5 what you mean? Are you suggesting a lock around every
sk_rmem write for netlink sockets? 
If we think this is an attack vector the attacker can simply use a UDP
socket instead. Or do you think it'd lead to simpler code?

