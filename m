Return-Path: <netdev+bounces-222677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E116B5568A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96215674E6
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A2D2874E0;
	Fri, 12 Sep 2025 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+t+UR+D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF172613;
	Fri, 12 Sep 2025 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702885; cv=none; b=gkigWwXLwkIUSGCMSuolit2GF+1POP0m8/XPNlbwtKpDiQ8dCSyDBoX1+INq4KeMK6LGMeHdsX0tcIMNxbKQB05pgfjNVXTwsfonz5ysgP3QbVC/ZIa0Z8p4/m8KqkjBMPemkwZUalRJ8r/S3lDk7HH3bUG77bkHFVhqL/8VmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702885; c=relaxed/simple;
	bh=TF01d6JbBn3mSJtfnI0NvV2969+tVdaRFTz0N3Bel8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXM50KrH95KbtmKta3PLmENQ1pY5FrvAumrMmY5i6TFNNZGdwn77s5YuufqIK7R2QQk4sXIBhrhsNjAb7KWrEn69MDaQd8spIGW/NXRMtOrnPG23S7fl+sRcNci6hd3q4Zg1Qz2P/jYWTeqvvaDU8iR+o9m5307kJowmP9RProc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+t+UR+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40969C4CEF1;
	Fri, 12 Sep 2025 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757702885;
	bh=TF01d6JbBn3mSJtfnI0NvV2969+tVdaRFTz0N3Bel8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+t+UR+Dccu0XRqNfIh4sY7nzLNeE95dgylO+aNAkRZT5QR0IovaGLty4n1mUr3F8
	 ShSIf4mlJPxxBcsPP0wDYV0opS+Rp39D1ZOpLIOEtt9D3ODxwzwLfVX7ao0WUENCva
	 /7tpu3wCETlqCYtd3O4K7SWjwKJ9Ker0akJd/hTdpFLDqmYZwP9tftcOK/cOABruxl
	 ZpmDY7nMQi5i3e6hQaxc69df4abBEhsViH7+817XA2ITBFKJ2+da27r0Kq7YSGnIOk
	 Npw1XPocB8ikFNtPHILyFVp9HfXr2PQbY5Pbyi09iQnOAcaNc4j2W6xX6JdS4u/5ia
	 OhYDa8tAvPVOQ==
Date: Fri, 12 Sep 2025 19:48:01 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix untrusted unsigned subtract
Message-ID: <20250912184801.GD224143@horms.kernel.org>
References: <2039268.1757631977@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2039268.1757631977@warthog.procyon.org.uk>

On Fri, Sep 12, 2025 at 12:06:17AM +0100, David Howells wrote:
> Fix the following Smatch Smatch static checker warning:

nit: Smatch Smatch -> Smatch

> 
>    net/rxrpc/rxgk_app.c:65 rxgk_yfs_decode_ticket()
>    warn: untrusted unsigned subtract. 'ticket_len - 10 * 4'
> 
> by prechecking the length of what we're trying to extract in two places in
> the token and decoding for a response packet.
> 
> Also use sizeof() on the struct we're extracting rather specifying the size
> numerically to be consistent with the other related statements.
> 
> Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lists.infradead.org/pipermail/linux-afs/2025-September/010135.html
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org
> ---
>  net/rxrpc/rxgk_app.c |   19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>


