Return-Path: <netdev+bounces-181004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C52DBA8362D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141163AA444
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D54318C004;
	Thu, 10 Apr 2025 02:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip0/rz72"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743FE46B5;
	Thu, 10 Apr 2025 02:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744250762; cv=none; b=KPsxTd+KE9BVk/694i1wtNFC1uJTrPet915gv3CPv2NDlksRX6Hxjv5lf27o0xR3kUG/QlZZmhatH2Ny9ohXbpW3DFXUzD53WFOuiyePa9ndSfW1BOKONOTPjiYHPwK97RBh88SysHBch5apALp2ixHOAbUaDyBOB5kC6o+zoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744250762; c=relaxed/simple;
	bh=7Mbv1bNw5gLeYJ3wHT0y1nSzv0qxak+jqodzaiPP5eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8GBYNRbfC5CbpHE8FT5ZxhpnxGf4/+hR6Cmp9KUWS9iTde3Fh+TTK8vyF1EwTndIdMdXi9YfhP0ii4dQYbJSxPaIT3LZbEioFnDRmbUCkD1iuaLH6QOMld/SDTD8rioUgVXNA8v84uVyPqVZLsU2gVTr6KFoPTPrA/532kYsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip0/rz72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E54C4CEE7;
	Thu, 10 Apr 2025 02:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744250762;
	bh=7Mbv1bNw5gLeYJ3wHT0y1nSzv0qxak+jqodzaiPP5eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ip0/rz72VznJlaa3ejEo98cZy9CI4WxnSopdR9mVl6tniVkX5Cg9/q7StsO0Tm7cl
	 U4jti62C6CtuV/O8LLH1Ld1WwzFb8ef8rUuzI23IIem0Pu6kG5OjE+M6R42a+zcnSL
	 Mpv7cpHgPu0UmmYNDwCBnmJnGqO30zCOY234XOzlKwrqlsgE5XX9aQ8k66SaxLytff
	 OzVkVhiDqxt/7EOsEiBx4t8NWLvBAjoKFEEaZx+JcBaQTVkOVAHsKsW2by7M51RoQy
	 VwGmM1G5SAauw7dGOW5PvWsiBBRBX85BIKEqZAFONgTBF0bF0/lOtc8wLJ7ttnsU2/
	 qUNDPeatonw3Q==
Date: Wed, 9 Apr 2025 19:06:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Christian
 Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 03/13] rxrpc: Allow CHALLENGEs to the passed
 to the app for a RESPONSE
Message-ID: <20250409190601.2e47f43b@kernel.org>
In-Reply-To: <20250407161130.1349147-4-dhowells@redhat.com>
References: <20250407161130.1349147-1-dhowells@redhat.com>
	<20250407161130.1349147-4-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Apr 2025 17:11:16 +0100 David Howells wrote:
> +static int rxrpc_respond_to_oob(struct rxrpc_sock *rx,
> +				struct rxrpc_oob_params *p,
> +				struct msghdr *msg)
> +	__releases(&rx->sk.sk_lock.slock)

sparse still complains (or maybe in fact it complains because it sees
the annotation?):

net/rxrpc/oob.c:173:12: warning: context imbalance in 'rxrpc_respond_to_oob' - wrong count at exit
net/rxrpc/oob.c:223:5: warning: context imbalance in 'rxrpc_sendmsg_oob' - wrong count at exit

Not a deal breaker, just wanted to mention it.

