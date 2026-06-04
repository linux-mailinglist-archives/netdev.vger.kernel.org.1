Return-Path: <netdev+bounces-295400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sbVSIUPOIWpGOQEAu9opvQ
	(envelope-from <netdev+bounces-295400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:13:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6900642D23
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:13:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l0J0D4oR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+oyJtAd3;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l0J0D4oR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+oyJtAd3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295400-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295400-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CA84300A63C
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB6D37E2F9;
	Thu,  4 Jun 2026 19:12:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CBF350D74
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 19:12:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600359; cv=none; b=ff6aJtDRn+MvTwRr38KVOU/bPK6TQDTy4ePmYj0phzt+JRovYvmJTM0SN9Psz+oSRkgDoNoDZ7u9dV7kSIOqAlPh51JHjXhaAXZ6d+dkmaQOOKvqsLEmlM7SujIXguOemGzJz2udxzUuWbpcXlYpxJtevRjv1xccujU/yHWaK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600359; c=relaxed/simple;
	bh=fj8ubZHRmMFKNsqYq9mUlXMLbL+nrDhZSSkGrPU7usk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q53b998jwsY7rM2L47tQ87ijRbkyP4wFUKPq1xnNui0YnWELq43lWnmGUGDZk4ycSXHwRlH4ilmf7xK1ncuTMHaGtBHFpXBNHU5FxoQxXwUNCFN02hW/yvuPNeDt0EhUdol63kgn720hUy2JX2iwecLY0i3lpHYgTZWWFbpa8R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l0J0D4oR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+oyJtAd3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l0J0D4oR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+oyJtAd3; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1270683AB;
	Thu,  4 Jun 2026 19:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780600356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVccA4ceReq1NsSUiW4BvISRJkHdxqfqmTVLliJp0pA=;
	b=l0J0D4oRlwzvwXiFyeQgd7lUB2NIqPON3UN9nyqyuKJRVUwcQ5y8Ex74IWYO8Oa9B5/ZoH
	FFwZpCO72xfZqgFKZurNNMPR1/rzPM9Q5EzVfxWXt3bXp3aKTfdn4k0Yoz222HhjD5ASIC
	liazCw6uqwUjJ5BSFXxkxAZNHpoz+zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780600356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVccA4ceReq1NsSUiW4BvISRJkHdxqfqmTVLliJp0pA=;
	b=+oyJtAd3Qb2ZMrrAhMaZyEyPWADlPH8EdOy8o/3C7B+euZY4GgIje0HDPQwu3yk10s5yml
	j1lRlfg68lTEhNAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780600356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVccA4ceReq1NsSUiW4BvISRJkHdxqfqmTVLliJp0pA=;
	b=l0J0D4oRlwzvwXiFyeQgd7lUB2NIqPON3UN9nyqyuKJRVUwcQ5y8Ex74IWYO8Oa9B5/ZoH
	FFwZpCO72xfZqgFKZurNNMPR1/rzPM9Q5EzVfxWXt3bXp3aKTfdn4k0Yoz222HhjD5ASIC
	liazCw6uqwUjJ5BSFXxkxAZNHpoz+zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780600356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVccA4ceReq1NsSUiW4BvISRJkHdxqfqmTVLliJp0pA=;
	b=+oyJtAd3Qb2ZMrrAhMaZyEyPWADlPH8EdOy8o/3C7B+euZY4GgIje0HDPQwu3yk10s5yml
	j1lRlfg68lTEhNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18C8F779A8;
	Thu,  4 Jun 2026 19:12:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id drW3ASPOIWpQfgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 04 Jun 2026 19:12:35 +0000
Date: Thu, 4 Jun 2026 20:12:25 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Harry Yoo <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH 1/2] mm/slab: add a node-track-caller variant for kmem
 buckets allocation
Message-ID: <aiHODMbciRELKGbR@pedro-suse>
References: <20260602183122.747759-1-pfalcato@suse.de>
 <20260602183122.747759-2-pfalcato@suse.de>
 <ed9e834d-e3a0-40c2-9407-252f7ac7f00b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9e834d-e3a0-40c2-9407-252f7ac7f00b@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295400-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:vbabka@kernel.org,m:akpm@linux-foundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-hardening@vger.kernel.org,m:linux-mm@kvack.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,pedro-suse:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6900642D23

On Thu, Jun 04, 2026 at 02:19:30PM +0900, Harry Yoo wrote:
> 
> 
> On 6/3/26 3:31 AM, Pedro Falcato wrote:
> > This is required by users that want to use kmem buckets, but still
> > desire specifying the NUMA node.
> > 
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > ---
> 
> Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

Thanks for the review!

-- 
Pedro

