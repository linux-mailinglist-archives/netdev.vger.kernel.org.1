Return-Path: <netdev+bounces-205111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E99EAFD6CF
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5605631E2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73BB22069A;
	Tue,  8 Jul 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZaZWLDH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E334801;
	Tue,  8 Jul 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001418; cv=none; b=XbOnS03CkTi6vyE4TH8Mx8lg6HgVdjeil2IH0DRYkQ+rfwNZ8U+4vzyRSNX2sbkDEevvfawHZ/0msuaH5Jb6/mFw+2ld3tiAi9Llq0x+7tmf+t7ojmtiyk5PR/nm5j4G+JQ2CixXvX11HUlzgusP7yO8fz5VsCeA5giRAoymu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001418; c=relaxed/simple;
	bh=GHcZnk2bIg2LnEuxbdd9Nbxx/LOWDNPMl+Rh13K5rGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZ5oX151xLJmW9W7EDnAt01NKb+1pUqAbR7V2i2u2dbF4GAOShxRg7XLXHPWfOIw0XumBg7VIcWCZKphNHgXG8R7xew9ngHtZ2HSZIHN9El1dPj3RqpAywgg0zi4tm5eleSQfsmwK6hCsM8C+V7bW1Ro/rnlXOJPsh/nFHZ+0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZaZWLDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81176C4CEED;
	Tue,  8 Jul 2025 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752001418;
	bh=GHcZnk2bIg2LnEuxbdd9Nbxx/LOWDNPMl+Rh13K5rGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EZaZWLDHIls3zFiL6RkrOHXTN2RdqBsCrNWrk1rq2edSY9SYL2XUWZM/xK6qTXakv
	 BbxzRJOTtCmGRBYPbdPAZV3NYxWBvxRJ8b1bDkbY7rIwWeAVd3WfMK1LwSYs1Mjyfw
	 haUHBdpZuSVlJTMs63KMC8CsowiLEUYoK07+0GF72EHqgz9ACvM3w2HcQYr3BQsDAi
	 WaFi3h3QogaK82PqX24TrW7L0lvV3j7EegCmADT+ZjfOKpdO47G+VVkARdIKM045oN
	 G0aQVo7EBPJ5/xpNlHcox2tTFk6szhMwelkdjqz9uTUcgJV8ll9GWLC8WdKWhMdKA0
	 vhbXCKoU2BNNw==
Date: Tue, 8 Jul 2025 12:03:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Junvyyang, Tencent Zhuque Lab"
 <zhuque@tencent.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net 2/2] rxrpc: Fix bug due to prealloc collision
Message-ID: <20250708120336.03383758@kernel.org>
In-Reply-To: <20250707102435.2381045-3-dhowells@redhat.com>
References: <20250707102435.2381045-1-dhowells@redhat.com>
	<20250707102435.2381045-3-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Jul 2025 11:24:34 +0100 David Howells wrote:
> +	rxrpc_prefail_call(call, RXRPC_CALL_LOCAL_ERROR, -EBADSLT);
> +	__set_bit(RXRPC_CALL_RELEASED, &call->flags);

is the __set_bit() needed / intentional here?
Looks like rxrpc_prefail_call() does:

	WARN_ON_ONCE(__test_and_set_bit(RXRPC_CALL_RELEASED, &call->flags));

