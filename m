Return-Path: <netdev+bounces-93148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCE88BA4AF
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 02:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465D2B211C4
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 00:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDB6BE4F;
	Fri,  3 May 2024 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD4+HVCK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E28F47
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697356; cv=none; b=t+Wu9bIBkG4KkMYgPTjdm5z/eLhKj9ctYxoT3MmC59zUkB7byuRGCyhMMTnuyPsdGgrHB1ldU0rfKlGoZQ55o92/YpeHbaUbVxAiBqr4z84k7oX+txQmdEFzTSP3ufyc4E/Ybt6p6nULX7kfl/nCldFU03hU2674IgfoGs648vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697356; c=relaxed/simple;
	bh=Zd1GLK0pt/tfBpdKR+mzXZu7FH1vyVIlPN6QNXNUqH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4t5r12dhqifHSXocHhc7fY9pl9Pd8DIubCBiCdrY6zSqAz6ZI7cOGeySCQdCXcoRGlLLmmhRdVGrepoPCPhcOgRW3ogoQlysEe/XTIy/lPreWu3od9aDYLMnXBmR20MK3uO554TgJTDGP3BfDfTB+oT5wdbKJJSCYpLRxLiQBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD4+HVCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4427C113CC;
	Fri,  3 May 2024 00:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714697355;
	bh=Zd1GLK0pt/tfBpdKR+mzXZu7FH1vyVIlPN6QNXNUqH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HD4+HVCKQfR625rDpxsoBk25Hfu89jY40IpHpDkKIN9WcYca+RIMGD6K3TSscJ8Z1
	 QTyDJpufGGfCzcsC4aUAV6G8wAMGThaWd1nI4ipY9MEZa1MQHEBzZZseGuQZ9p4WyO
	 sAT/lXdZqRhzMekWQJ9Ak2GpXaEdNP523JKq7Fhmm6xj5SS3JPx21LyZD5IZRGH2ss
	 9OwbbqScaQvUU+QPI1vYeLuy3uEq1qDjgikonW0YgU/c0dIP3x+ak/3yjgtP3fZlxy
	 TIHp+g8Fwex2NaR7/10IXwUnk7VnvudnoSb5AuQWo9xzMkMh7x0VUcxbn5MZNm79oz
	 yDD42rx+7JSPA==
Date: Thu, 2 May 2024 17:49:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Andy
 Gospodarek <andrew.gospodarek@broadcom.com>, Shailend Chand
 <shailend@google.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH net-next v1 3/3] netdev: add
 netdev_rx_queue_restart()
Message-ID: <20240502174913.380dcc38@kernel.org>
In-Reply-To: <20240502172241.363ba5a0@kernel.org>
References: <20240430010732.666512-1-dw@davidwei.uk>
	<20240430010732.666512-4-dw@davidwei.uk>
	<CAHS8izM-0gxGQYMOpKzr-Z-oogtzoKA9UJjqDUt2jkmh2sywig@mail.gmail.com>
	<5f81eccd-bc14-47a5-bc65-b159c79ce422@davidwei.uk>
	<CAHS8izMzakPfORQ9FX8nh0u0V7awtjUufswCc0Gf3fxxXWX0WA@mail.gmail.com>
	<20240502172241.363ba5a0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 May 2024 17:22:41 -0700 Jakub Kicinski wrote:
> On Thu, 2 May 2024 09:46:46 -0700 Mina Almasry wrote:
> > Sorry, I think if we don't need the EXPORT, then I think don't export
> > in the first place. Removing an EXPORT is, AFAIU, tricky. Because if
> > something is exported and then you unexport it could break an out of
> > tree module/driver that developed a dependency on it. Not sure how
> > much of a concern it really is.  
> 
> FWIW don't worry about out of tree code, it's not a concern.

That said (looking at the other thread), if there's no in-tree
user, it's actually incorrect to add an export.

