Return-Path: <netdev+bounces-280847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKJcOIBv6mlBzQIAu9opvQ
	(envelope-from <netdev+bounces-280847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:14:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 232D14568D5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 741DC30136BA
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627633033DE;
	Thu, 23 Apr 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOJDR2Ta"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E92D0C72;
	Thu, 23 Apr 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971430; cv=none; b=WN8+JDfY/lNHbEQICdxxTJgFm9hrNk82UKbEDoaOl1f1STDWvcHMuukSVaydz++PXv5b3vGaAi4aWAL5es+NRHs8cubAuYf42S6j7Brs/qaEOmdyoqwVAfBATLRgpEGsPCFO8h/c1XmoZNgCyFXRTq4nlwge99zroUNjAgp16DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971430; c=relaxed/simple;
	bh=8CQFHiiCKbq7zgsrgaz6pt31g625ZCmmS9WRYx+cFBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgbhxB4kSm+aONvPtXHzgprbE5Fo0nejnStsU3c03sdv6wlxsWNOIvb/pqa8sUTSd07YJwSd7T5ovdLFrkYkBSLheIeEfOD04i4c+wM5wPrq7Q9H8PiKgrRmrthI8FqSKWaLIbfzKqWBIwa7oKWIoN4+iDjt+Goo8WCT3+GyuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOJDR2Ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF72BC2BCAF;
	Thu, 23 Apr 2026 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971429;
	bh=8CQFHiiCKbq7zgsrgaz6pt31g625ZCmmS9WRYx+cFBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOJDR2TaSqwBPtRjWf7v5oep4qFIuGzG/g3o4tiSorBKWkdoqualqifJVh2Xuipga
	 54JWsybnIUG+2wkSl1BvzFGNRvsDiWZdwrhNaw2Hp87DQVIy9KAkrSbDBQ6S6swxqu
	 mMJgO9n6yWwnahXM065/0pl2noCHTAxnoXmCA/U7NvVQs7FEZKiv/Up84qbZLgfBAS
	 bPglJbh52xC37tjeF8wLAlifQJLrXJpjBzV4vaTFuxlH5JF9lLN86GufXthbjchz2o
	 viTN6pQvbwVROCHWzNR5A7yObVXtgwcrvMsvepgSp9FsReNlI0zi/ba92O76lm0390
	 f05ewczxvc1eg==
Date: Thu, 23 Apr 2026 20:10:25 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Tung Nguyen <tung.quang.nguyen@est.tech>
Subject: Re: [PATCH v2 1/1] tipc: fix double-free in tipc_buf_append()
Message-ID: <20260423191025.GJ900403@horms.kernel.org>
References: <20260421124528.162996-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421124528.162996-1-lee@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-280847-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 232D14568D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 01:45:26PM +0100, Lee Jones wrote:
> tipc_msg_validate() can potentially reallocate the skb it is validating,
> freeing the old one.  In tipc_buf_append(), it was being called with a
> pointer to a local variable which was a copy of the caller's skb
> pointer.
> 
> If the skb was reallocated and validation subsequently failed, the error
> handling path would free the original skb pointer, which had already
> been freed, leading to double-free.
> 
> Fix this by checking if head now points to a newly allocated reassembled
> skb.  If it does, reassign *headbuf for later freeing operations.
> 
> Fixes: d618d09a68e4 ("tipc: enforce valid ratio between skb truesize and contents")
> Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> 1v => v2: Keep the passed pointer type the same, but reassign on-change

FTR: Sashiko has generated a review of this patch which I have examined.
I do not believe that review should halt progress of this patch
as it appears that the problem flagged pre-dates this patch. Actually,
its unclear to me if it is a problem that warrants addressing at all.
But I'd appreciate if it could be looked over as a follow-up task.

