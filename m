Return-Path: <netdev+bounces-181438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9753EA85006
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 01:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14283B826E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B0520DD49;
	Thu, 10 Apr 2025 23:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuxbdSrA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5F1EBFFD;
	Thu, 10 Apr 2025 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744327066; cv=none; b=QpDV7AZkEKoEOobo+ctUPq8+6fkHjJSxBEDqlFblf5gTJONYVX1PXzZenrxaG5dEnCDrBSoPRSKlDW+Xz95kpV7M0TGD0kXRI3PBQd6hQULeMOTLnbgwPQaBS59GlKyu6EewZV99hhO3bHmRAcj6JZQAVimP/8XFxPf4sAqUKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744327066; c=relaxed/simple;
	bh=qfMrayvGJIhryGp/xUeJdvKnrRBXrRWT4flU39TArHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyBh7qAviORdSY7OCqWpV0FDGNKTvLzrfkX2ALrjtTXvU5de1NSZdsgEsMZQGosNMekcuYO527+BR6KXwBsaNc3Ah6yGIt1KM5xQhto9Adt90SBhv3wf/ZcAEirW8JshkrF9+nKDDVsDjuWeJFSQXVOjnr/2LH94bm4iuSjaLTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuxbdSrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199ABC4CEDD;
	Thu, 10 Apr 2025 23:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744327065;
	bh=qfMrayvGJIhryGp/xUeJdvKnrRBXrRWT4flU39TArHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kuxbdSrAlJm/EBxN+X0fc2hgNP0xLFcxNRnvkRRxYaPq51U0tyVvElg3RFk2WavKi
	 rI22ed7xqEf7f7c4qpC5Be+xeoTBmCiarKJOsarczbo9TK3fV38s+S1g4ONm2niIcW
	 23stLJCpLnwsjQHvCo/35wuOSZMU6pN/oFm1ZETIwxd+KRlegMB/fWGZeab+RrYClg
	 H5cD8gfWm5viQFnuqUpXy3d4VG22I6ALwiuZ4ahn4qL8yNipu3GjmRJ0SpzW94xh+q
	 GA2+sLlQnamO99P4mNOiQB9MpVi/FcDHmxRGgZKZEtbAO9hD0F4KQ2ELhUgqUNYriG
	 11l8+6HkqBfFA==
Date: Thu, 10 Apr 2025 16:17:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot
 <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/4] net: fix uninitialised access in mii_nway_restart()
Message-ID: <20250410161744.1e0562eb@kernel.org>
In-Reply-To: <Z_hC-9C7Bc2lPrig@qasdev.system>
References: <20250319112156.48312-1-qasdev00@gmail.com>
	<20250319112156.48312-2-qasdev00@gmail.com>
	<20250325063307.15336182@kernel.org>
	<Z_hC-9C7Bc2lPrig@qasdev.system>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 23:15:23 +0100 Qasim Ijaz wrote:
> Apologies for my delayed response, I had another look at this and I
> think my patch may be off a bit. You are correct that there are multiple
> mdio_read() calls and looking at the mii.c file we can see that calls to
> functions like mdio_read (and a lot of others) dont check return values.
>   
> So in light of this I think a better patch would be to not edit the 
> mii.c file at all and just make ch9200_mdio_read return 0 on     
> error. This way if mdio_read fails and 0 is returned, the         
> check for "bmcr & BMCR_ANENABLE" won't be triggered and mii_nway_restart
> will just return 0 and end. If we return a negative on error it may
> contain the exact bit the function checks.
> 
> Similiar to this patch:
> <https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=c68b2c9eba38>
> 
> If this sounds good, should i send another patch series with all the
> changes? 

SG

