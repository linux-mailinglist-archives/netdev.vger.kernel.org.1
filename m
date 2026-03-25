Return-Path: <netdev+bounces-271686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAUBClcgxGmZwgQAu9opvQ
	(envelope-from <netdev+bounces-271686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:50:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A021E32A19A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E113300D4E0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF0A3FEB28;
	Wed, 25 Mar 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFgHWcPr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F20405ADB
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461010; cv=none; b=HRXphOQAWH9MiV0o3+AWdpGu9vFJMGJkfmELtldE0OFO1dEgb+y8YctmJKNQdju+jcgDL3kgSZW+O03BPgnNBCU7jduqzBmyX2gJDZiJQLfoJDi3bIl9UDYzr2pexg14WFYaHAKnYvVvPs7iUa+qHyQoWq+xaIwTSjneXSI0StA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461010; c=relaxed/simple;
	bh=PdQtsgCHoART94zy6tOOGgSNd87xUTXDO3pCydJI9Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b12v18ANvvkc4iT1/xU0OitlDn7EpoY7rAbMDsnMta3kcZ7w8ANGdTRqavY5JVfPvqg4PqzFWlaqQXCNCa4XyD6bXm1Qr0Q9K+Q6YqtWHcNI2GFy8gVWmoMalJKzsaTHdW/+51iGUCTQfV6OH9Hr7CLy8tlomyLRZeJIgbqzwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFgHWcPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86881C4CEF7;
	Wed, 25 Mar 2026 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774461010;
	bh=PdQtsgCHoART94zy6tOOGgSNd87xUTXDO3pCydJI9Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFgHWcPru4CtNV7YMbNxgHENmgvvrQ5T0fonkFyz9tzDx+AywhvkkM542n+rgWNaO
	 AFGFnI3rs0k0FR2tXgFud5BcMTS9UCcoI3XJrb1Qxe9wDLi5JonsXtPvjzSgDTpa5k
	 Skdr3qOQxli9NLY4FYjTG52kWeP4KceilLhbjdw4Vi723KyUrlu93NGpkDaGKPskmg
	 bV8csEaz1VRdFPd5s53r/0cn8NHjtVn9nOgDFXQVlJ3J9nO+fkpvZEslVautcQ04d/
	 2UphGg5wCFvvkS/e4bK+l3IGa7fU4qevTk4JEYwN/1GngBmDu2zmm0r1RtvN/dssl1
	 QwPVhEErGUY6w==
Date: Wed, 25 Mar 2026 17:50:06 +0000
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, yuanzhaoming <yuanzm2@lenovo.com>
Subject: Re: [PATCH net-next] net: mctp: avoid copy in fragmentation loop for
 near-MTU messages
Message-ID: <20260325175006.GK111839@horms.kernel.org>
References: <20260324-dev-mtu-copy-v1-1-7af6bd7027d3@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-dev-mtu-copy-v1-1-7af6bd7027d3@codeconstruct.com.au>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-271686-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lenovo.com:email]
X-Rspamd-Queue-Id: A021E32A19A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 03:19:56PM +0800, Jeremy Kerr wrote:
> Currently, we incorrectly send messages that are within 4 bytes (a
> struct mctp_hdr) smaller than the MTU through mctp_do_fragment_route().
> This has no effect on the actual fragmentation, as we will still send as
> one packet, but unnecessarily copies the original skb into a new
> single-fragment skb.
> 
> Instead of having the MTU comparisons in both mctp_local_output() and
> mctp_do_fragment_route(), feed all local messages through the latter,
> and add the single-packet optimisation there.
> 
> This means we can coalesce the routing path of mctp_local_output, so our
> out_release path is now solely for errors, so rename the label
> accordingly.
> 
> Include a check in the route tests for the single-packet case too.
> 
> Reported-by: yuanzhaoming <yuanzm2@lenovo.com>
> Closes: https://github.com/openbmc/linux/commit/269936db5eb3962fe290b1dc4dbf1859cd5a04dd#r175836230
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Simon Horman <horms@kernel.org>


