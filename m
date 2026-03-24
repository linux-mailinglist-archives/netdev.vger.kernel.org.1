Return-Path: <netdev+bounces-271185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KxrC/3CwmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:59:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5173198A2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EE15305B5A3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCCF3E9F6F;
	Tue, 24 Mar 2026 16:51:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756433FEB21
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371067; cv=none; b=LC+MAA5i3DO2cK/0k8adBecXxDpDSrPWbhyLTkrKhs4m4VuLmwFhqVIv2SCDC+7YpuqCZY/rLmqLtPf+/5sBH1pLEG+cSs/PiEJUs47xhHse97rB86izHjSskcT41JaG1o1h1BG5/NVe9h6IP9X0VvcPHP3+91+f/YpjY9uJ928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371067; c=relaxed/simple;
	bh=ntUV1ZsAEl8FBR9E4P9ov0G9ZyXV20lN4BPbPTDo2d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLrw5d0nBDmjuJ0Z2yjpUW8Wcgc5cXDSPO5vADowAZBeJbbJqOtmv5/Lc1P08qQlHDH4nn8SXUn8PFIMk2iI+hJ2vGs9Ov8D82sYXoJFPjeeos040Y4ItfuSQ3i4pyE6af9jjk8bUzlgIUXNZMiBsr2mjTSrD8734PGKnU5qaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8E5EC6078E; Tue, 24 Mar 2026 17:51:03 +0100 (CET)
Date: Tue, 24 Mar 2026 17:50:42 +0100
From: Florian Westphal <fw@strlen.de>
To: David CARLIER <devnexen@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] netfilter: conntrack: clamp TCP window scale to
 TCP_MAX_WSCALE via ctnetlink
Message-ID: <acLA4vof5qlK2-wN@strlen.de>
References: <20260324163033.310087-1-devnexen@gmail.com>
 <acK9rdPQNqwejye9@strlen.de>
 <CA+XhMqwEhxCcdpOvEdczwYsfZuAFuvN+oB2rzuL3Gtic3tpNPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XhMqwEhxCcdpOvEdczwYsfZuAFuvN+oB2rzuL3Gtic3tpNPA@mail.gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271185-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: BA5173198A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David CARLIER <devnexen@gmail.com> wrote:
> Ah well :D thanks for pointing out. Cheers.

Well, if you think its a more urgent problem you could extract all
ctnetlink updates from that patch, integrate it here and submit a v2,
targeting 'nf' tree.

Because that patch targets 'nf-next', I did not consider it too urgent.

