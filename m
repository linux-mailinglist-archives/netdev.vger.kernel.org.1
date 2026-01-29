Return-Path: <netdev+bounces-254951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCRxOE3ze2lnJgIAu9opvQ
	(envelope-from <netdev+bounces-254951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:54:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BC3B5C6B
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D9F53004DA6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52BF3502B8;
	Thu, 29 Jan 2026 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbIRht2z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2D1C5D5E;
	Thu, 29 Jan 2026 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769730888; cv=none; b=n9yK959KjseQ9O7SuXMDdREuwuSGP4TF5KzNTXPC8HsmdHtXUIDyoZsVKm1wN6wChftVaV68hHk0QGlczlG44MZbSNJ/s4fTJI67tNjIcTHmJLbM1tKAU0cb42ApfDMfwOzgzhFQHuDy5PnI/Hya1arZNmQ7r11jZp0MkOenuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769730888; c=relaxed/simple;
	bh=IH4KZ4/IHTiqZnYNO5l+RgXhtcuGPAcrBHmuecttj9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJALB/9VAKxS4MJXc6WRi+K8v45Yqb3eS5LJD0k2roGbIxk94DnYipODee8IWJKme/a1XLaDf6svOA4Umuj03A8ocqqXhUqFDOiOi7wtulcdwaxChphXr7CrnOCFy/DZ5gpHFwx7UHQqTYKiAkyXeYSbk2y6rJPNefJacCxGyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbIRht2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073B7C4CEF7;
	Thu, 29 Jan 2026 23:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769730888;
	bh=IH4KZ4/IHTiqZnYNO5l+RgXhtcuGPAcrBHmuecttj9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RbIRht2zOmglKM95qYpF5gN9+0Ch5YImdhKoD6XuuPr3QAq+LhTlWc46pnSWkw0r9
	 goC3XYpamMTukJIOPDD68xx7nh8jekRTT44JmxDuDOoTZjo5TI8pRiC7jNZu6N58wy
	 B/m0igaFhNGYmUZgAhjMQjB77nhxVdWOj/TW0XRbgGfGEwHiAOf8mwBaw7K46svLJf
	 zIAA/jVj6Vev4leoHVZrIAzaiDq+Ht1lntkGhUlfUCmNIiarnZuaFJWVpMJ5FsJH67
	 ux5ZB4Sok1htI1umkqRnsnp88nWjgYyjdmbAjvYHnDgV3aeNZNPwlLimBKksVdXXCK
	 /UxsIKSOIae8w==
Date: Thu, 29 Jan 2026 15:54:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, dsahern@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: don't touch dev->stats in BPF redirect paths
Message-ID: <20260129155446.4ad21f1e@kernel.org>
In-Reply-To: <9dfdd7ce-ad1c-4845-95ee-d8ac5b5802e7@nvidia.com>
References: <20260128161030.39870-1-kuba@kernel.org>
	<9dfdd7ce-ad1c-4845-95ee-d8ac5b5802e7@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254951-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13BC3B5C6B
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 09:45:10 +0200 Gal Pressman wrote:
> On 28/01/2026 18:10, Jakub Kicinski wrote:
> > Gal reports that BPF redirect increments dev->stats.tx_errors
> > on failure. This is not correct, most modern drivers completely
> > ignore dev->stats so these drops will be invisible to the user.
> > Core code should use the dedicated core stats which are folded
> > into device stats in dev_get_stats().
> > 
> > Reported-by: Gal Pressman <gal@nvidia.com>
> > Link: https://lore.kernel.org/c5df3b60-246a-4030-9c9a-0a35cd1ca924@nvidia.com
> > Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Aha, this kinda makes my mlx5 fix redundant.
> I'm debating whether I should send a revert?

Up to you, it doesn't hurt.
I guess the main reason to revert would be to catch similar bugs 
in the future, given the popularity of mlx5, but up to you if
you want to be exposed to such bugs :)

> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 616e0520a0bb..2c21735798a5 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2289,12 +2289,12 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
> >  
> >  	err = bpf_out_neigh_v6(net, skb, dev, nh);
> >  	if (unlikely(net_xmit_eval(err)))
> > -		DEV_STATS_INC(dev, tx_errors);
> > +		dev_core_stats_tx_dropped_inc(dev);  
> 
> The commit message didn't mention anything about changing tx_errors to
> tx_dropped.

Fair, let me respin with a note.

