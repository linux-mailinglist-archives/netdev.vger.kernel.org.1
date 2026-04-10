Return-Path: <netdev+bounces-277472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG/DLloj2WlrmggAu9opvQ
	(envelope-from <netdev+bounces-277472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:20:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD63DA4F7
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A5543063D84
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7395F3128CF;
	Fri, 10 Apr 2026 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pByExstW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YEkF5l3X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pByExstW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YEkF5l3X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A240DFB9
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836871; cv=none; b=iEr5EakYRq37n9PBkxQiIGFg0vjuK2dza/vIB9C1jBq8YqR7/5kULvbb++GBxpxcnXP6N1BuVveTJjyxieh2xg1W/X2wbQoPELeBydwWXI8D2jOO3q/VKKzeq7OaXbIgo5g4eBqwekRyFUPFFu02XrcGeBqOlFcsW9NsJUIbeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836871; c=relaxed/simple;
	bh=YA3BUcujlLgymUeAge3q9ZreZZ04ClD7XGRxRH+Sk5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j7bAvr1EwVsBg9YbpXkZvU7VzZpvgw4WDJ/KrSENP5+bWmYXfIGKXU3e+tdOCzkih3U+jAq5DpaF9H3OxgoRUBhAUmJut/qV2i9PqpuChCzn7dp9x2O9i+GGLHO/3axM+Lu7IdxNATEnZ020MnuieaMNhAs/CtwuCgDR1CdIcwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pByExstW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YEkF5l3X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pByExstW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YEkF5l3X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3FBED5BDE3;
	Fri, 10 Apr 2026 16:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775836868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXjGth6W1OOOWcN6B8kAxGZNd5/9HO3w23ZGOjOab6w=;
	b=pByExstWD4/jQopEejrWvlBnITfz4xtXutjS09IJCnjdH9RgSBgF7ETS6PYrWv8lF+P+00
	ovR+xjR/K9636tr41TSA0Z4jNAs3gIOldvAlxAady/yRz/1vkP5L3FeOpWYzVVNbt52UO6
	ANxnn1FTH2+CBJDC8zNdZKy+ZHQai1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775836868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXjGth6W1OOOWcN6B8kAxGZNd5/9HO3w23ZGOjOab6w=;
	b=YEkF5l3X343QaxA15KQTv4VMBkzFcgmXWLpwlSoy/VCDZxpWEsErEASGuK5rGdRnxQ8ej7
	gjwuQHAu+wL0uWBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pByExstW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YEkF5l3X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775836868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXjGth6W1OOOWcN6B8kAxGZNd5/9HO3w23ZGOjOab6w=;
	b=pByExstWD4/jQopEejrWvlBnITfz4xtXutjS09IJCnjdH9RgSBgF7ETS6PYrWv8lF+P+00
	ovR+xjR/K9636tr41TSA0Z4jNAs3gIOldvAlxAady/yRz/1vkP5L3FeOpWYzVVNbt52UO6
	ANxnn1FTH2+CBJDC8zNdZKy+ZHQai1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775836868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXjGth6W1OOOWcN6B8kAxGZNd5/9HO3w23ZGOjOab6w=;
	b=YEkF5l3X343QaxA15KQTv4VMBkzFcgmXWLpwlSoy/VCDZxpWEsErEASGuK5rGdRnxQ8ej7
	gjwuQHAu+wL0uWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3DB54A0B2;
	Fri, 10 Apr 2026 16:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UpxUK8Me2WkhRAAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 10 Apr 2026 16:01:07 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,  dsahern@kernel.org,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  kuniyu@google.com,
  horms@kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH] udp: Force compute_score to always inline
In-Reply-To: <willemdebruijn.kernel.242540011e53c@gmail.com> (Willem de
	Bruijn's message of "Fri, 10 Apr 2026 09:04:30 -0400")
References: <20260409221532.69090-1-krisman@suse.de>
	<willemdebruijn.kernel.242540011e53c@gmail.com>
Date: Fri, 10 Apr 2026 12:01:06 -0400
Message-ID: <87ldeuoldp.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277472-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[krisman@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,mailhost.krisman.be:mid]
X-Rspamd-Queue-Id: C4AD63DA4F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:

> Gabriel Krisman Bertazi wrote:
>
>> Back in 2024 I reported a 7-12% regression on an iperf3 UDP loopback
>> thoughput test that we traced to the extra overhead of calling
>> compute_score on two places, introduced by commit f0ea27e7bfe1 ("udp:
>> re-score reuseport groups when connected sockets are present").  At the
>> time, I pointed out the overhead was caused by the multiple calls,
>> associated with cpu-specific mitigations, and merged commit
>> 50aee97d1511 ("udp: Avoid call to compute_score on multiple sites") to
>> jump back explicitly, to force the rescore call in a single place.
>> 
>> Recently though, we got another regression report against a newer distro
>> version, which a team colleague traced back to the same root-cause.
>> Turns out that once we updated to gcc-13, the compiler got smart enough
>> to unroll the loop, undoing my previous mitigation.  Let's bite the
>> bullet and __always_inline compute_score on both ipv4 and ipv6 to
>> prevent gcc from de-optimizing it again in the future.  These functions
>> are only called in two places each, udpX_lib_lookup1 and
>> udpX_lib_lookup2, so the extra size shouldn't be a problem and it is hot
>> enough to be very visible in profilings.  In fact, with gcc13, forcing
>> the inline will prevent gcc from unrolling the fix from commit
>> 50aee97d1511, so we don't end up increasing udpX_lib_lookup2 at all.
>> 
>> I haven't recollected the results myself, as I don't have access to the
>> machine at the moment.  But the same colleague reported 4.67%
>> inprovement with this patch in the loopback benchmark, solving the
>> regression report within noise margins.
>> 
>> Fixes: 50aee97d1511 ("udp: Avoid call to compute_score on multiple sites")
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
>
> Spotted this a tad late: should the comment udp4_lib_lookup2 be
> updated: "compute_score is too long of a function to be inline .."

Thanks for noticing.  I send a v2 just with this fixed and adding
bloat-o-meter data to the commit message, but preserved your ack.
Please review the updated comment for the ack.

-- 
Gabriel Krisman Bertazi

