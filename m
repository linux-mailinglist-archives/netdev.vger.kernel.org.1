Return-Path: <netdev+bounces-275638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP6CJljX02nUnAcAu9opvQ
	(envelope-from <netdev+bounces-275638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:55:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E36E83A4F38
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87377301185B
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACDE30C61B;
	Mon,  6 Apr 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seNtVtwi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B66274FDC;
	Mon,  6 Apr 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490901; cv=none; b=NTsV+5pPBo1gcLpsG13VKPvp8KY8Jlv596efo1HnprculrXn15djyqrV5Xji8z70Ukbcwc+XmLLycKZKehDPTIkBBvopS0Gm2yfjXMYmchf6EzYNerCfwez/zx6OePbndXf+sQRtyFKqhPBJJm7ZJlfaJlBR00nt6unVYa9tej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490901; c=relaxed/simple;
	bh=yhQVx5lGxrNjOz+qJC4x+VCwzUXhDOiL1OJSFE+OS3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peW1TlyquDYG7BLBbpuhK//QfSC80/DnQ49T0I8PWaGULEhI3PWIqqdYh8Y0wnTnBcxHFx0E8aiUHX/tsNOlv6E2drIQTejmXTflqbCkjwjpOuKgaBka20vovP2NjiOPWHDy1GmarhlxUH4aA6gyKb0YnicdAsE/KYQzHLBPtts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seNtVtwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4116C19421;
	Mon,  6 Apr 2026 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775490901;
	bh=yhQVx5lGxrNjOz+qJC4x+VCwzUXhDOiL1OJSFE+OS3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=seNtVtwircGY/V5AcTAx61qjZW2NQAWjSt4CMJrThWS3vX8fmSaNuxc+ReJnITYqB
	 1YrMgxaKgb0CbXEOxZs1XSOMC7CgT5yHmnyqV6KchRnln/p7CFjHo1VRv/lRCyim9G
	 4btoE4KqiJX+1y+K4BkpoYwuARdOO8kJfjNWFOy4zJbtg3pU1MluQ92TxT1IwZHlED
	 9rk/NhvcgBdjviVgtheV4dYNXbgrxrHRecOdQ0z78WzMG7ZPLEuXSvwyOlrFyul4N9
	 /14OMAt7DBfI3mf1qQk6BKaMcxFjyH4fBIMjPWnT7z0Nr4uPc2mDOCL9flYynvrmJq
	 CLJcGrcvTHBXg==
Date: Mon, 6 Apr 2026 08:54:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net] xfrm_user: fix info leak in build_mapping()
Message-ID: <20260406085449.266466ae@kernel.org>
In-Reply-To: <2026040602-shack-tamale-d8c3@gregkh>
References: <2026040602-shack-tamale-d8c3@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275638-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,apana.org.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:email]
X-Rspamd-Queue-Id: E36E83A4F38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon,  6 Apr 2026 17:33:03 +0200 Greg Kroah-Hartman wrote:
> struct xfrm_usersa_id has a one-byte padding hole after the proto
> field, which ends up never getting set to zero before copying out to
> userspace.  Fix that up by zeroing out the whole structure before
> setting individual variables.
> 
> Fixes: 3a2dfbe8acb1 ("xfrm: Notify changes in UDP encapsulation via netlink")
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, I think this is correct, as I don't think a new skb has it's
> fields pre-zeroed out, or am I totally wrong here?

You're right, skb owner is responsible for clearing after put.
Tho, Netlink is not as perf critical as real networking, I wish
we at least had a helper which reserves the space and clears it :/
This is not the first or the second time we hit this sort of a bug.

> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 8a854fa9567d..1bb8d05561df 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -4165,6 +4165,7 @@ static int build_mapping(struct sk_buff *skb, struct xfrm_state *x,
>  
>  	um = nlmsg_data(nlh);
>  
> +	memset(&um->id, 0, sizeof(um->id));
>  	memcpy(&um->id.daddr, &x->id.daddr, sizeof(um->id.daddr));
>  	um->id.spi = x->id.spi;
>  	um->id.family = x->props.family;


