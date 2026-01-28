Return-Path: <netdev+bounces-254038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KeuOObhReWkTwgEAu9opvQ
	(envelope-from <netdev+bounces-254038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 01:00:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F819B8D4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 01:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EA7F300FEF7
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 00:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E3123AB81;
	Wed, 28 Jan 2026 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/ivUrag"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065822F01;
	Wed, 28 Jan 2026 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558453; cv=none; b=AVg58dbhs/7eOFp/fyhD4P2sBrCBcw7zZOAn8mKu44y+HTn2tShzn7faSV0ipg7TM3AE3X/teOenv0Ul/nNrhWdJXD7YIIG5P0spc4qvpjANqtVtLDibg9YOBMRmyUpeSGdb7wl5YKtLIf4rLgCtqXOezvWhsrgIFbxD3Df/UQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558453; c=relaxed/simple;
	bh=MzlVfJmqYI80+vaHoVKmtERAE4++YceEhUWZ8t8fCQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueu1vaVIjLwR1GHcqU4Fi/carIEcnlWe/7DgJ227t6JUNbadWKkDhLBzoRJyXaSWzNuImh6d4WjmgfmgDGOg+TDlP29lY0rOmpv3CQEwz6VPS6t4Wo/bkE8d24qEXxJYc39TUKvt6b8HhEwjNXuJ9rvgDKj2RXATzlFyfHnWdbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/ivUrag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E73C116C6;
	Wed, 28 Jan 2026 00:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769558453;
	bh=MzlVfJmqYI80+vaHoVKmtERAE4++YceEhUWZ8t8fCQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r/ivUrag66I5Pj2mbO6AXNJMuG9Ie22ymJhLzn2kP4y4LpwqqW89R45Cb+IM8qvDY
	 6nzhsOPNXLOAxT+OFgAxyTKiJZf8KOAX+h/OUzd/+gzBxiBWDM9+tOJ+BmV69jl9uw
	 kMzz/254dOPBuBohy3lo+nK8DQXGCorKclAin+N+8bQ5EOMOIx1ewrXhWWiYo7+78n
	 oyH6FrPAj2gvCBMAtnf1Y66QfCum7qLTyd8nULKvS7XhsYpTqZK+X2lulILHH00m5N
	 /dGcDEDiI2ItraJRCQaZbME+7dS6LU0PRJyOKYAE680ty1XpnmEAwarYHidVkbkyhE
	 pvZ8eaEcdgb5A==
Date: Tue, 27 Jan 2026 16:00:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yun Lu <luyun_611@163.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: lwtunnel: Check skb->_skb_refdst in
 bpf_lwt_push_ip_encap
Message-ID: <20260127160052.5038cc7b@kernel.org>
In-Reply-To: <20260127084520.13890-1-luyun_611@163.com>
References: <20260127084520.13890-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254038-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56F819B8D4
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 16:45:20 +0800 Yun Lu wrote:
> The bpf_lwt_xmit_push_encap helper needs to access skb_dst(skb)->dev to
> calculate the needed headroom:
> 
> 	err = skb_cow_head(skb,
> 			   len + LL_RESERVED_SPACE(skb_dst(skb)->dev));
> 
> But skb->_skb_refdst may not be initialized when the skb is set up by
> bpf_prog_test_run_skb function. Executing bpf_lwt_push_ip_encap function
> in this scenario will trigger null pointer dereference, causing a kernel
> crash as Yinhao reported:

Seems a bit backwards to be adding datapath checks to make
bpf_prog_test_run_skb() happy. Also - please run checkpatch.
-- 
pw-bot: cr

