Return-Path: <netdev+bounces-222876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA0EB56BFA
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 22:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928731893F79
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E2828A1ED;
	Sun, 14 Sep 2025 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQFNmNyn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3EEEAB;
	Sun, 14 Sep 2025 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757880287; cv=none; b=EdPk4jLwyU3O13hWhjR4wZDYhzEDEhepZpMIIIIju3n5C4+CIDwVCAfMJ3idychIqPrcFSr6z3I6p4xwLXX/zOHjwJH6kc8AjtPeV6t8acny2OvHm3fwGWBqDe1s+yOz46Zp/bNfiPqcLZdEfstyMCYpeDRkPK+/cYT+hgnfN4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757880287; c=relaxed/simple;
	bh=UTyZggsg7HBc19OwkHtJCZhRrlBf+Nr74MG4ywsFY/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGwCxUfaY5/iLVmXZwmp8k+YBNTl/kmfc1d2JIh6OChz0HX1xKaeqDExUxQwBMJjIF9PIwgbGz35PyW+o+un6HCe3hkZ7BU5kTXyJyvi0PirsEUA3ecuW0yoKKG5FUzfzA0h7EAifbRVid/J2xPSvxrOH72vils5ZrZHrftgmGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQFNmNyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36964C4CEF0;
	Sun, 14 Sep 2025 20:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757880286;
	bh=UTyZggsg7HBc19OwkHtJCZhRrlBf+Nr74MG4ywsFY/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hQFNmNynFXH74hZuRUeLHm2InlgRMBTqH7bvsGX1rvc6gPvAfBNxHCE7GhROAGbtD
	 sx1n/LZ+DLizJa53m0DUzdrqKVGPUgGz6onXCM8586fiXg3DFUEFSOYAUXgC+Cvtsg
	 pVHoQQH4iszLEbP4ovIz+QUbS2Eo7l9hMD/bjbn2kGvG3vOEHX300/K7Wpn9ifDs9I
	 bTanhqDG7AvvwU01jM5ilMpHcLU1O3WHcf3htTWHfvGDdVhCkZYJQiu7fMO6IETlN6
	 mlrPV2yhCekUdxSpRXMpLo7eUECIHVXxtp0ln9zzhQg8ATunPO7GLr+D6VnupeY/Yh
	 AenbyV/NA6lNw==
Date: Sun, 14 Sep 2025 13:04:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, netdev@vger.kernel.org, Marc Dionne
 <marc.dionne@auristor.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix untrusted unsigned subtract
Message-ID: <20250914130445.44e81ed9@kernel.org>
In-Reply-To: <2331700.1757706238@warthog.procyon.org.uk>
References: <20250912184801.GD224143@horms.kernel.org>
	<2039268.1757631977@warthog.procyon.org.uk>
	<2331700.1757706238@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 20:43:58 +0100 David Howells wrote:
> Simon Horman <horms@kernel.org> wrote:
> 
> > > Fix the following Smatch Smatch static checker warning:  
> > 
> > nit: Smatch Smatch -> Smatch  
> 
> Yeah.  Can that be fixed up at time of application?

Done!

