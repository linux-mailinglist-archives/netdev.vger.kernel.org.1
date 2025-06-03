Return-Path: <netdev+bounces-194719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9553DACC220
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E281F1890988
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8945A26980B;
	Tue,  3 Jun 2025 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVCmMbkT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F231148827;
	Tue,  3 Jun 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939112; cv=none; b=kYtoIkUaAJdAAZWsE23ioiF3vY2Uvh+U2msg0Umpm0WaRc+WNgQETrD5pfBAn2sxjaOg+ZG1ktHNyrkmgm1hGJyfTIZfjZVy1wdGW9DhnYJ7fKa4UoWfjs/+aAS9D3pdnaiNBwzNX/bwhaXezm/ew78UQ5agb/pqrp0I7caXP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939112; c=relaxed/simple;
	bh=aoAe8iVedapS040lkFw85Rv1newQKC2OtLWJSUQlwc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPNbD6Ug4mj7gUNq9hwDhqa+j8GlzOTIdwxxKqLILlSwW2LOpBZyBUvf5OCZ8cp3/bA3ZsVTNdXCve7if76idIbkzxhKr6JDUuyRQXy9J2uGHF0fxdAEivj9jnfOfjcs8k9HTAcDNTQ1WcOTZoricUzUXNDFZPENXjY/FXR5/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVCmMbkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF220C4CEF2;
	Tue,  3 Jun 2025 08:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748939111;
	bh=aoAe8iVedapS040lkFw85Rv1newQKC2OtLWJSUQlwc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pVCmMbkT169eMBuY52YmR+1Z5raDRrunMZuxo6HHGMSe+Jmex6MAAVBv2Ms7F8YYE
	 +GGkELyrnDUJswN2YFcg8qijaIHxXUfqFQ1zkd2MWMT9lP4t/tBLHggLoGWEF2Cj+8
	 LKmrN4uBjGo9NJ8+ZpPCib58kpm1ttKkL6cQMSuMVL6e0M6nn8PzndbXsKGti0JSaY
	 j2mTsj/CLTmF/G9Of1m7rXAdiUojidt8RXLGNAC26SutgdEeSOZ6A6ibb8AD3eeNrj
	 KG2z+vfOGfcNIi7bK9BpaJZE0YyhCAhRdpiOhal3UIzBakCf3eaH2xV9cihHtrUaof
	 NjU8HmvItHWlg==
Date: Tue, 3 Jun 2025 09:25:06 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: almasrymina@google.com, bcf@google.com, joshwash@google.com,
	willemb@google.com, pkaligineedi@google.com, pabeni@redhat.com,
	kuba@kernel.org, jeroendb@google.com, hramamurthy@google.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	darren.kenny@oracle.com
Subject: Re: [PATCH net v2] gve: add missing NULL check for
 gve_alloc_pending_packet() in TX DQO
Message-ID: <20250603082506.GZ1484967@horms.kernel.org>
References: <20250602103450.3472509-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602103450.3472509-1-alok.a.tiwari@oracle.com>

On Mon, Jun 02, 2025 at 03:34:29AM -0700, Alok Tiwari wrote:
> gve_alloc_pending_packet() can return NULL, but gve_tx_add_skb_dqo()
> did not check for this case before dereferencing the returned pointer.
> 
> Add a missing NULL check to prevent a potential NULL pointer
> dereference when allocation fails.
> 
> This improves robustness in low-memory scenarios.
> 
> Fixes: a57e5de476be ("gve: DQO: Add TX path")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> ---
> v1->v2
> added Fixes tag and [PATCH net v2]

This patch is marked as Rejected in patchwork, but it's unclear to me why.
The patch does look good to me, there was positive review to v1 which
is addressed in v2, and i see no prior comment on v2. I'm updating it's
status accordingly. Apologies if I missed something.

Reviewed-by: Simon Horman <horms@kernel.org>

-- 
pw-bot: under-review

