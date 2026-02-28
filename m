Return-Path: <netdev+bounces-262213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J6INYNio2myBQUAu9opvQ
	(envelope-from <netdev+bounces-262213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:47:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B2D1C93FA
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB2013072640
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFABE1C8603;
	Sat, 28 Feb 2026 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukdzHTEO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02C175A86;
	Sat, 28 Feb 2026 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772310658; cv=none; b=igD+Wq89fQB8pNDkt5w+HDmkKJA5+uOLdQjX6oPf5GOf5t7t2kDhHMqgZqCk1rvnsC34LrC0yW5O+7vfpGmw2/I5PQpX1hQUfcLlV57p7A4UoIXsKza6i7KMCf1WIfT5+8p1jG4hiewBdzwJ5pwFVG4ybV2gnfuB6FXkz79kFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772310658; c=relaxed/simple;
	bh=5osuwdeoFbtAVKtAuWPRvfoorRhWrOkgKlCC1JCHjX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbuE/hEmxWEcHB0hhiPUTmnltRMnMHXpUIYQjaIKwWB1qqC8UmpOfPnfUhg6pst1LrgQQcTdty4lPygSuGo54aBt9U4wVEmCztSXSHUIQew2Bzemt9H242089qZOvbr+eU95JFL1gOOiE8aUgsxnFYz3k5Y+uCJUUwRsq40aSbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukdzHTEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEAEC116D0;
	Sat, 28 Feb 2026 20:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772310658;
	bh=5osuwdeoFbtAVKtAuWPRvfoorRhWrOkgKlCC1JCHjX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ukdzHTEO9sKeX64F965atQW/VYBfheZwuA/3E7Uj4JGWjCKt8pCAWXe+VgfntwdYK
	 TQsvsprRjBAItAb/WcHOTodq5M3gOpllVFQcJAgwmTjSBi+5HnhDmIeCFTIGioA0no
	 j1heXxnJCW8D+uXX7va59C+2WR9NTGf1h9LtQlrFTxEfE3daRtgPc/c4jN84gqerXw
	 4zj6gp5Cno8vuNkmXelrL74R4x/+G9lXWFjw52VV+gx+8u00qF8AMZeMvLStESzE1w
	 XmfryvVoKxggOAVL7HGhrLl7lRRno/gWlNkm4UCbCy8ee6RCxo+IfQrmBJEJewae+E
	 Xe/Fu4EhxHlqg==
Date: Sat, 28 Feb 2026 12:30:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 roopa@cumulusnetworks.com, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
 razor@blackwall.org
Subject: Re: [PATCH net] net: bridge: fix nd_tbl NULL dereference when IPv6
 is disabled
Message-ID: <20260228123057.14050980@kernel.org>
In-Reply-To: <20260226234059.19402-1-fmancera@suse.de>
References: <20260226234059.19402-1-fmancera@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-262213-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79B2D1C93FA
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 00:40:59 +0100 Fernando Fernandez Mancera wrote:
> Fix this by adding a check before br_is_local_ip6() or neigh_lookup()
> call. If ipv6_stub->nd_tbl is NULL, return immediately.

The problem should probably be fixed by replacing IS_ENABLED(IPV6) in
the callers with ipv6_mod_enabled(), rather than randomly sprinkling
null checks?

> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Closes: https://lore.kernel.org/netdev/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com/

I think we should also have a Reported-by: in this case?
-- 
pw-bot: cr

