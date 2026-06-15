Return-Path: <netdev+bounces-299388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A1M2HPDOL2ocHAUAu9opvQ
	(envelope-from <netdev+bounces-299388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:07:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6591C685434
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:07:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lIWfMw4+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t7GE2tcE;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lIWfMw4+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t7GE2tcE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299388-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299388-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75AA93002B58
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5DA3DC4A4;
	Mon, 15 Jun 2026 10:07:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA23DBD57
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 10:07:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781518058; cv=none; b=FMzXsyaj4ZQnZHdGvoTZB/PJzZQNk4kMI4gjc8coaSBk2JbZIEaTs5TnkFP0F6OARcSkXMdPk3OhB00tcOt2a6wKQit2bh01QNdpDGGxQE4kx8ZrNOhb+rcaxVxUkQTHnUf0uZA53kBvo1Y5EdKoIy1NirpQBYbyiy8gh2mRmS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781518058; c=relaxed/simple;
	bh=j9X6Hjl1sRhGXewzKI16SQPqKyAERgQ7g9NdkcyEkZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fo9ozh0OptuE1qZGzWaH4Tdda1kqpomCGZEqGuAcVfe/uocqAUQcg7vQJWLRnb5HnWU+L0C2gkhGb/dC2REBa4e3UElI4GezHf8BRh6P2wOV/FwXdV4kk3VfB95tIzczmFOAUzXvEaeQY/6zcGpfOTpL3Nj5Tp3n6eYk3hEYD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lIWfMw4+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t7GE2tcE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lIWfMw4+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t7GE2tcE; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05D8F75938;
	Mon, 15 Jun 2026 10:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781518055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bcwcuid5G9Jv1yAJ2BEQE/cLseUTL/2R5NAEuMMhL8s=;
	b=lIWfMw4+rNTJWFvjKaMg19WvN7uXYaEL/vc9yYUWlX3NTQiwVXNqsO4Yag5WnpDkDGWN1u
	FCNRj/ypXIisZylFFLwG4qDxMD9EZSd9+vBmHD5XQhE3yx6oTR2bhoM+1WC8bLrpiLLELc
	nqLtRgTBmJmPn73fZ8TQ7ii60F9oxTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781518055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bcwcuid5G9Jv1yAJ2BEQE/cLseUTL/2R5NAEuMMhL8s=;
	b=t7GE2tcEHcCkbYQInDvZT+SaB70th4oyF0Wlm6kqpMdYvUz/tgyXUOBnNKnZR3Pxrjy2HY
	DOwTWKUzN0fOs+CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781518055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bcwcuid5G9Jv1yAJ2BEQE/cLseUTL/2R5NAEuMMhL8s=;
	b=lIWfMw4+rNTJWFvjKaMg19WvN7uXYaEL/vc9yYUWlX3NTQiwVXNqsO4Yag5WnpDkDGWN1u
	FCNRj/ypXIisZylFFLwG4qDxMD9EZSd9+vBmHD5XQhE3yx6oTR2bhoM+1WC8bLrpiLLELc
	nqLtRgTBmJmPn73fZ8TQ7ii60F9oxTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781518055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bcwcuid5G9Jv1yAJ2BEQE/cLseUTL/2R5NAEuMMhL8s=;
	b=t7GE2tcEHcCkbYQInDvZT+SaB70th4oyF0Wlm6kqpMdYvUz/tgyXUOBnNKnZR3Pxrjy2HY
	DOwTWKUzN0fOs+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB0E0779A7;
	Mon, 15 Jun 2026 10:07:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hHJGKuXOL2qLZgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 15 Jun 2026 10:07:33 +0000
Date: Mon, 15 Jun 2026 11:07:31 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net-next v2 0/2] net: isolate SKB data area allocations
Message-ID: <ai_ObgbjlahfXs37@pedro-suse>
References: <20260611124642.345400-1-pfalcato@suse.de>
 <20260613113303.7562bc59@kernel.org>
 <ad862f5c-34e4-48d6-8d8b-f02bdc02d7d6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad862f5c-34e4-48d6-8d8b-f02bdc02d7d6@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299388-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:kuba@kernel.org,m:harry@kernel.org,m:akpm@linux-foundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-hardening@vger.kernel.org,m:linux-mm@kvack.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,m:kees@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,davemloft.net,google.com,redhat.com,vger.kernel.org,kvack.org,linux.dev,gentwo.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:dkim,suse.de:from_mime,pedro-suse:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6591C685434

On Mon, Jun 15, 2026 at 09:28:39AM +0200, Vlastimil Babka (SUSE) wrote:
> On 6/13/26 20:33, Jakub Kicinski wrote:
> > On Thu, 11 Jun 2026 13:46:40 +0100 Pedro Falcato wrote:
> >> Subject: [PATCH net-next v2 0/2] net: isolate SKB data area allocations
> > 
> > This doesn't apply to net-next, does patch 2 not apply to mm?

Ugh, annoying - really should have rebased on net-next precisely
(vs just linux-next).

> > If neither tree can take both - maybe MM can take the first patch by
> 
> OK I'll take the first patch through the slab tree in the planned second
> next week's PR.

Thanks!

> 
> > itself and we will queue patch 2 after the changes propagate during 
> > the merge window?
> 

It's all the same to me, I'll have to resubmit the patches when the merge
window closes. So whatever is easier on the maintainers side sounds good to
me :)

-- 
Pedro

