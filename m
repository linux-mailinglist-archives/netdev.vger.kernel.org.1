Return-Path: <netdev+bounces-254784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPG5F6JTe2nRDwIAu9opvQ
	(envelope-from <netdev+bounces-254784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:33:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D916EB015D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 028D63026151
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B420A3876D6;
	Thu, 29 Jan 2026 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppARvoiF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD2C37FF72;
	Thu, 29 Jan 2026 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769690001; cv=none; b=BAwCKAAveHQu0NFtlqxbLPJKx91sz4saFlfFnNpqC8toZIqE78BoCLoGwKG2kl3tM3pa6V7cVMXkeGLYlqxvW2YrxkxsRHgBItiOe6bNEa67+CbutKsWQeWpNyGBJ3NMgS4rkUBsvQzp3h3zMvgGG1NzZa+T+Bko/NMDoB6kYHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769690001; c=relaxed/simple;
	bh=oGx8/tdeKK63GRmFUFehx4QDcQgKP+Jbv0FgzLKcoQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP8x1WzNdF87cYFTegdBKReirPNVWA9LkmZ8gxaahNDfT82ZgC1Nr7esIURgo7p6zJwzh5WrGcp3t7tVkYnZlLCjf8EN4pWn9y+ocq/SpIvmYGge81QGV7tp0ZpYBJDicyBz13PryH3JV/kYzD2nIt9zFnbMPrwJNEmyuEI5CGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppARvoiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F77C19421;
	Thu, 29 Jan 2026 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769690001;
	bh=oGx8/tdeKK63GRmFUFehx4QDcQgKP+Jbv0FgzLKcoQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppARvoiFxII0SmxqpUvLYTKOCU39fjUYxLb7J8y0s0tfuyf2b11NBKykIQVSkrP8n
	 Ftc4E9vCPyiaEJAAra5CLOEYX5Fi7NZxw/BQ8ZeFcepQGpfMsmZ/XAI6H27BcxxIUA
	 EBE3jdvq7+CHHX4vjAMotVCSm1HIy64vC+eT7hGMLxQjEddsD6/vO5QH+tKJ09Se1P
	 YeGV8MLQ4OIbMUAZMbD5lFr1MLRlCRbpP0u6lloAbL2rCmu0FC9yEc9KNxyh25SxSO
	 xovoBgCUzHXyCMXCGXzyP3PZo1UJsw9s72dwzy0KbPMcze80Gs2WQ4oj7E4o3r6GR3
	 TyfRgPq6npHcA==
Date: Thu, 29 Jan 2026 12:33:16 +0000
From: Simon Horman <horms@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+e136d86d34b42399a8b1@syzkaller.appspotmail.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] xfrm6: fix uninitialized saddr in
 xfrm6_get_saddr()
Message-ID: <aXtTjH1bo31NM7L0@horms.kernel.org>
References: <20260127113845.219468-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127113845.219468-1-jiayuan.chen@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e136d86d34b42399a8b1];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,shopee.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: D916EB015D
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 07:38:44PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> xfrm6_get_saddr() does not check the return value of
> ipv6_dev_get_saddr(). When ipv6_dev_get_saddr() fails to find a suitable
> source address (returns -EADDRNOTAVAIL), saddr->in6 is left
> uninitialized, but xfrm6_get_saddr() still returns 0 (success).
> 
> This causes the caller xfrm_tmpl_resolve_one() to use the uninitialized
> address in xfrm_state_find(), triggering KMSAN warning:
> 
> =====================================================
> BUG: KMSAN: uninit-value in xfrm_state_find+0x2424/0xa940
>  xfrm_state_find+0x2424/0xa940
>  xfrm_resolve_and_create_bundle+0x906/0x5a20
>  xfrm_lookup_with_ifid+0xcc0/0x3770
>  xfrm_lookup_route+0x63/0x2b0
>  ip_route_output_flow+0x1ce/0x270
>  udp_sendmsg+0x2ce1/0x3400
>  inet_sendmsg+0x1ef/0x2a0
>  __sock_sendmsg+0x278/0x3d0
>  __sys_sendto+0x593/0x720
>  __x64_sys_sendto+0x130/0x200
>  x64_sys_call+0x332b/0x3e70
>  do_syscall_64+0xd3/0xf80
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Local variable tmp.i.i created at:
>  xfrm_resolve_and_create_bundle+0x3e3/0x5a20
>  xfrm_lookup_with_ifid+0xcc0/0x3770
> =====================================================
> 
> Fix by checking the return value of ipv6_dev_get_saddr() and propagating
> the error.
> 
> Fixes: a1e59abf8249 ("[XFRM]: Fix wildcard as tunnel source")
> Reported-by: syzbot+e136d86d34b42399a8b1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68bf1024.a70a0220.7a912.02c2.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


