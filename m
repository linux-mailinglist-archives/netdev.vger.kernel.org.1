Return-Path: <netdev+bounces-262960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHyGAtUopmk+LQAAu9opvQ
	(envelope-from <netdev+bounces-262960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 01:18:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5041E70C4
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 01:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17695304AAD6
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 00:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493541DEFE8;
	Tue,  3 Mar 2026 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9kyyFtT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655E19C540
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 00:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772497106; cv=none; b=MGaYce9vP73DSf+JACxZ0OQAi5pepcwT+79X3JjRYX3MwU0qY+kKXShrb9hUCEOJw0gtfntLPLodpYNclM0Algmezjx5vlHeYQUBixZcA6BynglRmjr4o3RspegXRf+rqHI9jeHHzbGTsRyHPNsmW/u2eANin1o6CkwJtAKWt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772497106; c=relaxed/simple;
	bh=8K7/BkUg2r5dGgqNFCyMIvU3bfkt2gwa1OJg3cuAtcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L965EWJXQ39fdNO+5/VLC0UN1H0uyUsav+pvmeGwtc0KipKK3v5hWsG4dCfN7tqbqXT1pbkmcFiVLBTEMnaCf4nJ8zQGpSaXoGQNmWN+yTObvEu2hRxRrAa3vklAL0LQ2DpgWp43TZKN+6HCq8EvLmx9Tbu0rkdtWjVslNEOMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9kyyFtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743E9C19423;
	Tue,  3 Mar 2026 00:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772497105;
	bh=8K7/BkUg2r5dGgqNFCyMIvU3bfkt2gwa1OJg3cuAtcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l9kyyFtTAQDmRBmLqwst/tx0GxiWWxM9tJU92RYf/8FJBOAK8ATHF7dMyZY0lrfBG
	 9diSG0LVZriUQbuAEDVqzxAbVfVZ58BJfNRrw5lUNCeOn+l8RdRWke6gj/WMPnBfBX
	 HXgJWuSAqQ8OUQ4Nr9yt7s3ujyIdGAUl1Epe642yA4oQmEAVSXNpsNPz3iP39nigcR
	 K/m2BIpCvu5gI+gKL/L4i+6WWqpPhcCbWXiYRJ83roE0pmfQAi/NuVirzbowSMsRhs
	 69rMPvzFdPd56PZkS2CTzjn4XlOhx8N6CDnijZ6ROCMyylKOT6QWLXRYs2dfqqecjM
	 2LHUN+9eRawSA==
Date: Mon, 2 Mar 2026 16:18:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
Subject: Re: [PATCH 1/2 net-next v2] ipv4: validate IPV4_DEVCONF attributes
 properly
Message-ID: <20260302161824.0cb19417@kernel.org>
In-Reply-To: <a038563b-05f2-4e11-9cd4-ad6374d379aa@suse.de>
References: <20260226133949.17070-1-fmancera@suse.de>
	<20260228104328.260172d2@kernel.org>
	<a038563b-05f2-4e11-9cd4-ad6374d379aa@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5E5041E70C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-262960-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 09:35:06 +0100 Fernando Fernandez Mancera wrote:
> >> Please note that MEDIUM_ID is defined as NLA_U32 too because currently
> >> its usage through netlink is broken for its valid value -1. Modifying
> >> the type to NLA_S32 would break existing users of set/get netlink
> >> operation.  
> > 
> > Say more? The policy type not matching the accessor used by the kernel
> > is probably fine in this case (since there's a common accessor used for
> > all attrs). If it helps the policy, we can use a different type.
> 
> The problem is not only not matching the accessor.. the problem is that 
> while it was not validated if users were using NLA_U32 as indicated by 
> the original implementation (see blamed commit), this would break them.
> 
> Is it one option to set the type to NLA_S32 and wait to see if someone 
> complains? I am not sure how many people might be using it considering 
> the type is wrong.

Sorry, I'm not connecting the dots.

	[IPV4_DEVCONF_MEDIUM_ID]	= { .type = NLA_U32 },
vs 
	[IPV4_DEVCONF_MEDIUM_ID]	= { .type = NLA_S32 },

makes absolutely _no_ difference. For bare types with no ranges 
the validation will only check the attr is 4B which is identical 
for both. 

For S32 you can add a range, however, the NLA_POLICY_RANGE() takes 
two signed 16b values. So a range of -1 .. x is completely fine.

