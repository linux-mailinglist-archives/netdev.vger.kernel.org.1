Return-Path: <netdev+bounces-275211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKe+K9cj0Gmx3wYAu9opvQ
	(envelope-from <netdev+bounces-275211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:32:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 763EC3982EC
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 256DF300FEE6
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571662472A2;
	Fri,  3 Apr 2026 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYBKuBIh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3F1DED40
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248315; cv=none; b=ZUpvNmrjm3EuVxZlrPoDN+0uYdSqA2aaetcG7kxVffx8Q9yBeBkEjqOTsR8CJQZkx+wjHsiAl//0dMhv52Q8eONK7eGrq6LBgYAHqAXl0sXewb4rhGmA09HF65sjlk5wcc5J5Sg6C/l98p6zLzaX1Z7uqOTtzEJU1hkMkhYnSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248315; c=relaxed/simple;
	bh=kRSdpPftlPXpWSkQNV9eGxTo87saqeQej0kmzHourY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuRgDFu3FANYHjjkhrDgE9wiYWEvW3lfkaaAP3031EQtne2b4P5Y1IjilMa9e4o+P5iwyIwUtHCooxOZBjbVO1pSAs8jWjxM8ZqYZaQi3nndxhh/T/Y+KjLx4NDfdAn2/lvcykY/+ZEpyyXO5nPTs6rWml888nz4uCtU8h6TfYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYBKuBIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC25C4CEF7;
	Fri,  3 Apr 2026 20:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775248314;
	bh=kRSdpPftlPXpWSkQNV9eGxTo87saqeQej0kmzHourY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VYBKuBIhN3kQ0pjM3fXegX3m6QrjzZDZzi3A6/kELX5TAzD9YCG+NXcaC8/zA5tIE
	 izBVq595Ttj8SClF9uJPQZuCzhRqnCrxYPasr5F0jbY8rPanhHBDsw3sqwQcPKrt0j
	 A5GhWKLBzr2swG+X8eAyrQjiaH32aeNfmTThUr57Fx/XAegVkBxHN/GKYCb/Fj9lmh
	 2EeGEkiNh1qOeyX4q2wq/CLmH2XJHiyaB5yerLGnjRcZrsAyohJYLGOVzLHNgK6MKg
	 bG2PRTi5sZmFbwY+HRgKZHv2QOG/RvcVNn0frYDLXiqDdOVkhVeSHZV4x8yRw02jJQ
	 4JuHs8fAAZx4A==
Date: Fri, 3 Apr 2026 13:31:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org,
 Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH net] net/sched: cls_fw: fix NULL dereference of "old"
 filters before change()
Message-ID: <20260403133153.0fc66fe1@kernel.org>
In-Reply-To: <a93f97c0ad17ffd67f8a1719ff26b21d18e1020f.1775225292.git.dcaratti@redhat.com>
References: <a93f97c0ad17ffd67f8a1719ff26b21d18e1020f.1775225292.git.dcaratti@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275211-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 763EC3982EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri,  3 Apr 2026 16:13:11 +0200 Davide Caratti wrote:
> Like pointed out by Sachiko [1], TC filters are added to a shared block
> before their ->change() function is called. This is a problem for cls_fw:
> an invalid filter created with the "old" method can still classify some
> packets before it is destroyed by the validation logic added by Xiang.

One version in a 24h window, please.
-- 
pv-bot: 24h

