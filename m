Return-Path: <netdev+bounces-279848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFWwMjda5mmtvAEAu9opvQ
	(envelope-from <netdev+bounces-279848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:54:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD658430323
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A0C13027146
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F73238C16;
	Mon, 20 Apr 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT+QsVhi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1126192B90;
	Mon, 20 Apr 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697847; cv=none; b=E+6njXbZBc7QTrjOPyXPR1XLsA6YO+LnQDZCyLFJt7uStZ7VbwssfutOVtqDP090dkqE0WeEp6lKHMM+TzKMfQR/wg+QTznq9YC6rzAu5tqXKjmGRnCwfSjw44cTLG/97nCpPPnKVko7Bg3ajpvxa4kWgBf8euE6ON7gtLo1DFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697847; c=relaxed/simple;
	bh=Gq8V6Gavz28SXbmtLUZgwlaXcHxiOpo6jsxmlaqXFx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bARVnsKFQhWNTArJrtFrA+evFiqjN8znrRSDOauPSLOCqDqgh/rGdfrWl/CuOOkq3aUNqBu4N6iowpetSEoni60G20eGMczm67GQtwomY0qwJPu7VzTqlUpdCTfXJjtQ2j+4lugDNDI8WU+RB0xNY3ZCYitw6EalTJvZ11elGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT+QsVhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1DCC19425;
	Mon, 20 Apr 2026 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776697847;
	bh=Gq8V6Gavz28SXbmtLUZgwlaXcHxiOpo6jsxmlaqXFx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CT+QsVhi3u66CIymCWsItF+xHphCD4o8p7jdDq1Wu2sHgDCZrW1/UiqRXvXZAQn18
	 /B/1XWHPDDs8WZmF5+cpXk0g1u9ejrQn/5BbJaMpOJjw03+kHmoXTFnROpYJSOEyMr
	 wePFE4p0SOSD2njWpb3bLeN2Dt4wWBdrFjzihC3EI55MIW/3xKNrLj6cldpBvf8AYP
	 xhYoBkXH6j5vyZk4Gor4RF1YQcC+FkjTDb4iTQFMgUADa4Rvsju5dKkp2KwPLMxrjs
	 YPD37Glh1FvICXI6k0BTP4KkC/OGplSzCfXZQg6L3e1G6ZYd6+3fEERQO6qc1YJ4IY
	 1gb7GiSCT8AmA==
Date: Mon, 20 Apr 2026 16:10:40 +0100
From: Lee Jones <lee@kernel.org>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tipc: fix double-free in tipc_buf_append()
Message-ID: <20260420151040.GF3202366@google.com>
References: <20260420130524.3527420-1-lee@kernel.org>
 <GV1P189MB19886E03BDD0F407B757E5ABC62F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20260420143309.GD3202366@google.com>
 <GV1P189MB198853F316580DDA547F4925C62F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <GV1P189MB198853F316580DDA547F4925C62F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279848-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD658430323
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026, Tung Quang Nguyen wrote:

> >> Subject: [PATCH 1/1] tipc: fix double-free in tipc_buf_append()
> >> >
> >> >The tipc_msg_validate() function can potentially reallocate the skb
> >> >it is validating, freeing the old one.  In tipc_buf_append(), it was
> >> >being called with a pointer to a local variable which was a copy of the
> >caller's skb pointer.
> >> >
> >> >If the skb was reallocated and validation subsequently failed, the
> >> >error handling path would free the original skb pointer, which had
> >> >already been freed, leading to double-free.
> >> >
> >> >Fix this by passing the caller's skb pointer-pointer directly to
> >> >tipc_msg_validate(), ensuring any modification is reflected correctly.
> >> >The local skb pointer is then updated from the (possibly modified)
> >> >caller's pointer.
> >> >
> >> >Fixes: d618d09a68e4 ("tipc: enforce valid ratio between skb truesize
> >> >and
> >> >contents")
> >> >Assisted-by: Gemini:gemini-3.1-pro-preview
> >> >Signed-off-by: Lee Jones <lee@kernel.org>
> >> >---
> >> > net/tipc/msg.c | 3 ++-
> >> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >> >
> >> >diff --git a/net/tipc/msg.c b/net/tipc/msg.c index
> >> >76284fc538eb..9f4f612ee027
> >> >100644
> >> >--- a/net/tipc/msg.c
> >> >+++ b/net/tipc/msg.c
> >> >@@ -177,8 +177,9 @@ int tipc_buf_append(struct sk_buff **headbuf,
> >> >struct sk_buff **buf)
> >> >
> >> > 	if (fragid == LAST_FRAGMENT) {
> >> > 		TIPC_SKB_CB(head)->validated = 0;
> >> >-		if (unlikely(!tipc_msg_validate(&head)))
> >> >+		if (unlikely(!tipc_msg_validate(headbuf)))
> >> > 			goto err;
> >> >+		head = *headbuf;
> >> This is a known issue and was reported via
> >> https://patchwork.kernel.org/project/netdevbpf/patch/20260330205313.24
> >> 33372-1-nicholas@carlini.com/ The author did not respond to my
> >> comment.
> >> Can you improve the fix by applying my patch?
> >
> >I'd be happy to make any required changes.
> >
> >However, is this approach superior to simply passing a reference?
> >
> >v1 appears to be simpler, easier to read and avoids the explanation.
> >
> As I explained, your fix adds extra overhead to normal path while the error path is corner case and it rarely happens.
> Whatever approach is applied, we need to add explanation to understand more easily the logic and hidden trick in tipc_msg_validate().

Very well.  I have made the recommended changes.

The patch is currently in my build-test environment.

I will post v2, when everything has been satisfied.

-- 
Lee Jones [李琼斯]

