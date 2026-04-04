Return-Path: <netdev+bounces-275342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDmVNRnf0GklBgcAu9opvQ
	(envelope-from <netdev+bounces-275342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:51:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF2B39A985
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BA523017C0A
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F03B3A5427;
	Sat,  4 Apr 2026 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAp0SPo1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0688396D28;
	Sat,  4 Apr 2026 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296230; cv=none; b=NcHmdkTuf8AR0mfKSPX8vrIlN2nLEzHj9cqiN7ANW0CCwsbJ9jmUKzktmY44d1bBdVRI7o+wStoW0kPrMUNxnILsP1H/R6k6sCInLQ0YeY1YrSGil6tMaf7eEHzusth0+EtMcEKk0KNBrG2yt2LtOSLihL8e5qs9LOwnd/zHl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296230; c=relaxed/simple;
	bh=yWI5JomHHzvxtJ/Mwk/xCtfGhnNhMAcHtdonhondQAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA+zfKZpJO3PVbWszGp+8tALBpzaTsdoWx+VijWu7v2LwswGrHzjG4LdcbK/suseeDKKO2L/KnTU6O1/Rcj+JiDe4ulv8yZhq6WI3uxqhziRaWDSxiWfokMwo/E/aeHZb9dYlgoY0iqjZezue6OpPiffN50ej3rsrOqNNON2TU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAp0SPo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C2BC19421;
	Sat,  4 Apr 2026 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775296229;
	bh=yWI5JomHHzvxtJ/Mwk/xCtfGhnNhMAcHtdonhondQAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAp0SPo1ChUJ6IK+nXmhC0HHtTEPg75jSsLLw4skhF85jhxSwpBhPoWz5oI73bppL
	 Itl/7zwlJ214lyuzEVLCKmHEd2CqQEbmbguJmPCzTW2n7h6d515KgrxnH8ZXRmluhe
	 6oN+vw57vQKgHqqmbh4QpQmKTZ2HERlnbYUGZhL26/U+1lQvjcruWC02Y5cJGrfnqP
	 yk9NysoFeI3qUodR2FuQ8zl+QwclvwUhmGftEOqMh22AdjM8298+Po6Isb8FcCVm1L
	 7LpH5T4uJeR21nCcYxy16qmp4MhanTtb9B7D6eChiuBEgPpb2UaE3cJtlg61Lm+uH0
	 FcuLfsKz+Q8xQ==
Date: Sat, 4 Apr 2026 10:50:25 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 2/7] net/sched: netem: fix queue limit check to
 include reordered packets
Message-ID: <20260404095025.GW113102@horms.kernel.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
 <20260402202037.176299-3-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402202037.176299-3-stephen@networkplumber.org>
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
	TAGGED_FROM(0.00)[bounces-275342-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,networkplumber.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CF2B39A985
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:19:30PM -0700, Stephen Hemminger wrote:
> The queue limit check in netem_enqueue() uses q->t_len which only
> counts packets in the internal tfifo. Packets placed in sch->q by
> the reorder path (__qdisc_enqueue_head) are not counted, allowing
> the total queue occupancy to exceed sch->limit under reordering.
> 
> Include sch->q.qlen in the limit check.
> 
> Fixes: 50612537e9ab ("netem: fix classful handling")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Simon Horman <horms@kernel.org>


