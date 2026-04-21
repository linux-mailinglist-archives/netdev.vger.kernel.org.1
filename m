Return-Path: <netdev+bounces-280073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMQnJDZT52mn6gEAu9opvQ
	(envelope-from <netdev+bounces-280073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:36:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 228844399E1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF452302BE9D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EAC3806D2;
	Tue, 21 Apr 2026 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivqx9ZTh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD863F9FB;
	Tue, 21 Apr 2026 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767749; cv=none; b=FiyCqsWYn1Tv6KNmCyJ0LN50ZWVFlXVPM0jRLoP5lL/acu/S0sobvRbX/nIq9L87Lh/BQks9VoKV0GikXfFthexQkn3BF3rmF1lvosPoZ/aVXLPUSdh61hYwDh5wzVHgNV527jmxuGvCyL6F/Ys1eZIK9guxSR8AxfNEtSHChMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767749; c=relaxed/simple;
	bh=2v5RjBdg5K6+6WC871x1utW9FD7rW+Nbeeo10DLDHy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgNM+aVjLRzSDfWXLMiHc4c34UyFM8oNadUyNKG6cJZuX/D9ci5mOzjYrlollz8jPsQWbXqj0LmyVp0ZNTLo7N5MiEDRbD9GqHn7NblcZ+fPbgrCQT3PCPKlUKiQAg35wi8hhnqQDNAB8fvL4Sp2mnnIgnfSPHbU+6JLOZRVsmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivqx9ZTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF659C2BCB0;
	Tue, 21 Apr 2026 10:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776767749;
	bh=2v5RjBdg5K6+6WC871x1utW9FD7rW+Nbeeo10DLDHy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ivqx9ZThd3qt3E6AfApnNapOC1PDgTiqhWIC1G4VepqXlP65BwlM/zDz+OocMPnwE
	 p0+6O8k99Zic/A/5MJ1PlDJr/rbHHN524t0GGXRFBzxmDfr8Q/uCyesveRf6RYkbh/
	 Z4/05SK0q7XPRah989uSdNdz1cqbyiH3+mPwPSt+29BqP2lDEjJj3hk4tIbYwknERX
	 zfYT5EmGocSIeZSNrjOXT0Dr6Mld1SLoasGc40QPdQaHgkcla95oTJ7RNE5ysPeYXE
	 ey8Zuw/K8JF8gFCF/XSH9xg8+1vZ8afCt2LqnHo8pOO7S/W/Ws/SC8oUmXKaCl0lc8
	 60DF7glidn4OQ==
Date: Tue, 21 Apr 2026 11:35:43 +0100
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
Message-ID: <20260421103543.GH3202366@google.com>
References: <20260420130524.3527420-1-lee@kernel.org>
 <GV1P189MB19886E03BDD0F407B757E5ABC62F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20260420143309.GD3202366@google.com>
 <GV1P189MB198853F316580DDA547F4925C62F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20260420151040.GF3202366@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260420151040.GF3202366@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280073-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 228844399E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026, Lee Jones wrote:

> On Mon, 20 Apr 2026, Tung Quang Nguyen wrote:
> 
> > >> Subject: [PATCH 1/1] tipc: fix double-free in tipc_buf_append()
> > >> >
> > >> >The tipc_msg_validate() function can potentially reallocate the skb
> > >> >it is validating, freeing the old one.  In tipc_buf_append(), it was
> > >> >being called with a pointer to a local variable which was a copy of the
> > >caller's skb pointer.
> > >> >
> > >> >If the skb was reallocated and validation subsequently failed, the
> > >> >error handling path would free the original skb pointer, which had
> > >> >already been freed, leading to double-free.
> > >> >
> > >> >Fix this by passing the caller's skb pointer-pointer directly to
> > >> >tipc_msg_validate(), ensuring any modification is reflected correctly.
> > >> >The local skb pointer is then updated from the (possibly modified)
> > >> >caller's pointer.
> > >> >
> > >> >Fixes: d618d09a68e4 ("tipc: enforce valid ratio between skb truesize
> > >> >and
> > >> >contents")
> > >> >Assisted-by: Gemini:gemini-3.1-pro-preview
> > >> >Signed-off-by: Lee Jones <lee@kernel.org>
> > >> >---
> > >> > net/tipc/msg.c | 3 ++-
> > >> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > >> >
> > >> >diff --git a/net/tipc/msg.c b/net/tipc/msg.c index
> > >> >76284fc538eb..9f4f612ee027
> > >> >100644
> > >> >--- a/net/tipc/msg.c
> > >> >+++ b/net/tipc/msg.c
> > >> >@@ -177,8 +177,9 @@ int tipc_buf_append(struct sk_buff **headbuf,
> > >> >struct sk_buff **buf)
> > >> >
> > >> > 	if (fragid == LAST_FRAGMENT) {
> > >> > 		TIPC_SKB_CB(head)->validated = 0;
> > >> >-		if (unlikely(!tipc_msg_validate(&head)))
> > >> >+		if (unlikely(!tipc_msg_validate(headbuf)))
> > >> > 			goto err;
> > >> >+		head = *headbuf;
> > >> This is a known issue and was reported via
> > >> https://patchwork.kernel.org/project/netdevbpf/patch/20260330205313.24
> > >> 33372-1-nicholas@carlini.com/ The author did not respond to my
> > >> comment.
> > >> Can you improve the fix by applying my patch?
> > >
> > >I'd be happy to make any required changes.
> > >
> > >However, is this approach superior to simply passing a reference?
> > >
> > >v1 appears to be simpler, easier to read and avoids the explanation.
> > >
> > As I explained, your fix adds extra overhead to normal path while the error path is corner case and it rarely happens.
> > Whatever approach is applied, we need to add explanation to understand more easily the logic and hidden trick in tipc_msg_validate().
> 
> Very well.  I have made the recommended changes.
> 
> The patch is currently in my build-test environment.
> 
> I will post v2, when everything has been satisfied.

Okay, I genuinely tried to apply your patch.  It builds just fine, but
Gemini (the AI I use to pre-review patches before submission) has some
doubts that this is the correct approach:

> @@ -177,8 +177,20 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
>
>       if (fragid == LAST_FRAGMENT) {
>               TIPC_SKB_CB(head)->validated = 0;
> -             if (unlikely(!tipc_msg_validate(&head)))
> +
> +             /* If the reassembled skb has been freed in
> +              * tipc_msg_validate() because of an invalid truesize,
> +              * then head will point to a newly allocated reassembled
> +              * skb, while *headbuf points to freed reassembled skb.
> +              * In such cases, correct *headbuf for freeing the newly
> +              * allocated reassembled skb later.
> +              *
> +              * Note: It's done this way instead of passing &head          // I added this part to give
> +              * to avoid slowing down the happy path since this failure    // the reviewer some additoinal
> +              * is a rare event.                                           // context
> +              */
> +             if (unlikely(!tipc_msg_validate(headbuf))) {
> +                     if (head != *headbuf)
> +                             *headbuf = head;
>                       goto err;
> +             }
> +

  "It looks like this logic might re-introduce the double-free bug.
   The call to `tipc_msg_validate(headbuf)` is correct, as it passes the
   pointer-to-pointer and allows the callee to update `*headbuf` if the skb
   is reallocated.

   However, the subsequent check seems to undo this. If a reallocation
   happens, `head` will hold the pointer to the old, freed skb, while
   `*headbuf` will hold the new one. The condition `head != *headbuf` will
   be true, and the assignment `*headbuf = head` will restore the stale
   pointer, leading to a double-free on the `err` path.

   The preceding comment also appears to have the pointer roles reversed.

   Would it be simpler and more correct to remove the `if (head != *headbuf)`
   check and the large comment block? The change from `&head` to `headbuf`
   in the function call seems to be the only change required to fix the bug.
   Also, please update the commit message to reflect the corrected logic."

I suggest that we go with the original patch.  Although I find it admirable
that you are thinking about and attempting to protect the more common
happy-path, I think the resultant single additional variable assignment
is negligible and that the simplicity of the previous fix has greater
benefits in terms of code readability and maintainability.

If you like, I can add a small comment, but I doubt even that is necessary.

-- 
Lee Jones [李琼斯]

