Return-Path: <netdev+bounces-140404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44529B65B0
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 15:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26ED728229B
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1001E411D;
	Wed, 30 Oct 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/vSw2VI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89332C13C
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298273; cv=none; b=mSWT/MVdFNWNzAYQkGuGozmciwKxVTp6KXGIjmH9foyOfvR4pk60lQLxsPugJB4nTPvIvJmEKTX5SCJD8+0cXaR1puEruL+JNSPXd48pMSWN2f0vqUgCr6MCbnum08W1N1dFqwMjtc67VuimMg/KI0/xyMNSA8G0qTJ9JnPLNmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298273; c=relaxed/simple;
	bh=tOvGT5WRdfdgV4pja6W+wIxG0IP3s9fWu9mdLiWmXsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBaeXDaiB68myy90ljnE3cUoUupPQc/mxejISbrbujuq37lRQAME6f273SvDJkTsE/OI4phCjxMWmjkdWSTl+it+3c3uH1G83RSNlDOPPmuAL/OogboYmg0KGw6MXxltN4RWUPuru7FTliTdj+pIq2nKDtoU/wOQrymz++mFwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/vSw2VI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34E1C4CECE;
	Wed, 30 Oct 2024 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730298273;
	bh=tOvGT5WRdfdgV4pja6W+wIxG0IP3s9fWu9mdLiWmXsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K/vSw2VIeMsLa7uPOKie+CmczNq0PHt8wuuA513gMSZ/XvdludsiiwJuE4CiBqiqt
	 iTBchqNa4WIhhmdS96pb/369+fqyrwxOPSead69OKBPTkphcXwGwrVzVyGwitZBDlC
	 YC/bkmMdl+6poLCIjLdzMqGOjfg2v0X91JE/K58MYXwO1Sn2y2sp0sTLGdjaA8j34q
	 OXyzE4aug215fgmckRZLcy2hLA42dC922fOhzBcqkiRBxc2E5EhhvPKa46edm+3tY8
	 9Jnp4nudsrOk7N5xaObQpSjOvF6gJRVh/70lEdH/9r5vGmdwNr41BKOkFwFApO9VOq
	 iUV8qa9IddLoQ==
Message-ID: <58253e33-1867-479d-a313-68110465f2b0@kernel.org>
Date: Wed, 30 Oct 2024 08:24:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vrf: Prepare vrf_process_v4_outbound() to future
 .flowi4_tos conversion.
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>
References: <6be084229008dcfa7a4e2758befccfd2217a331e.1730294788.git.gnault@redhat.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <6be084229008dcfa7a4e2758befccfd2217a331e.1730294788.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 7:27 AM, Guillaume Nault wrote:
> Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
> dscp_t value to __u8 with inet_dscp_to_dsfield().
> 
> Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
> the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  drivers/net/vrf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


