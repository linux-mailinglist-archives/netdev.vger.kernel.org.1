Return-Path: <netdev+bounces-300661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TR0HHpMINWoEmQYAu9opvQ
	(envelope-from <netdev+bounces-300661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:14:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 319586A4E71
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:14:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AwCyqh+s;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="3sG/71lf";
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AwCyqh+s;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="3sG/71lf";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300661-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300661-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A84123056C14
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08443655CE;
	Fri, 19 Jun 2026 09:13:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336734E763
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:13:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860437; cv=none; b=rm+Tvfj+ESm/fc94oAWPZxB9kS1+pqy77zC5mmPL2YIX/6dfjB1hsZXwhhTs8M6k6nG+g7rsBB5HL2TaX+w4R+bSkmMht8RN7dPLXBCpp5J6xVTah5Ia8CDmHCwwCAPa7HDX7P0vxxw+Ho69wWAK13pL7mxFimokCrghBTRX6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860437; c=relaxed/simple;
	bh=kxf6nE8M34SUn5MqKK+6Np3MlkN7ih89lmrDmuqwcRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leuj3siiu7ahkl6AQ9kTLcFSN11LM1Hid0xvoCCMvhuXw46xGCxsrU07Hv1mKfH8diRIOeMxuAIENTpygwIqm5Q9RR6wFlOBf6ApSb3+nzODb1yRGQGzstL7mP7Zg/CpibH3EiGXiL5U7P75LA6TiMqxvBTOyQBWLePVXzJlRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AwCyqh+s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3sG/71lf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AwCyqh+s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3sG/71lf; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ADEC575ECC;
	Fri, 19 Jun 2026 09:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781860434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ebZUDOXtrRF88oo6nu1OcTDZMP1vYvjmVSuN9SvvRU=;
	b=AwCyqh+sS1flKvY5ufAuEKiY0EmYlEpeJhhklSnpy+Qgp4VGZ7S3A95e6BjdHKw2aKmn2e
	Gt3pM9N/B/FTHfy/lPLAmVwsmMgxU+UG8syN2A23Hqk9VUjeFTwZlHQL0556sDjTbd1Zs5
	1mO2RalJHqPYaYy35AuBqnGMKqthjrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781860434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ebZUDOXtrRF88oo6nu1OcTDZMP1vYvjmVSuN9SvvRU=;
	b=3sG/71lfd297OX+nD7hgQUSG54FxFPVkAVSyfyvUwjFvWQ/03UcWI5RXdsAYmCtSICKkgP
	WRiFg3H35GuoHfCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781860434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ebZUDOXtrRF88oo6nu1OcTDZMP1vYvjmVSuN9SvvRU=;
	b=AwCyqh+sS1flKvY5ufAuEKiY0EmYlEpeJhhklSnpy+Qgp4VGZ7S3A95e6BjdHKw2aKmn2e
	Gt3pM9N/B/FTHfy/lPLAmVwsmMgxU+UG8syN2A23Hqk9VUjeFTwZlHQL0556sDjTbd1Zs5
	1mO2RalJHqPYaYy35AuBqnGMKqthjrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781860434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ebZUDOXtrRF88oo6nu1OcTDZMP1vYvjmVSuN9SvvRU=;
	b=3sG/71lfd297OX+nD7hgQUSG54FxFPVkAVSyfyvUwjFvWQ/03UcWI5RXdsAYmCtSICKkgP
	WRiFg3H35GuoHfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DE10779A8;
	Fri, 19 Jun 2026 09:13:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1Z/pA1IINWo5YgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 19 Jun 2026 09:13:54 +0000
Message-ID: <942fcca4-c20d-4c34-ae85-5ee9d34503fb@suse.de>
Date: Fri, 19 Jun 2026 11:13:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
To: xmei5@asu.edu, dsahern@kernel.org, idosch@nvidia.com,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kuba@kernel.org, horms@kernel.org, bestswngs@gmail.com
References: <20260619045334.2427073-1-xmei5@asu.edu>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260619045334.2427073-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300661-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:dsahern@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:horms@kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,asu.edu:email,vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 319586A4E71

On 6/19/26 6:53 AM, xmei5@asu.edu wrote:
> From: Xiang Mei <xmei5@asu.edu>
> 
> fib6_nh_mtu_change() re-fetches idev via __in6_dev_get(arg->dev) and
> dereferences idev->cnf.mtu6 without a NULL check. addrconf_ifdown()
> clears dev->ip6_ptr with RCU_INIT_POINTER() after rt6_disable_ip() has
> released tb6_lock, so the RA-driven MTU walk can observe a NULL idev and
> oops. The caller rt6_mtu_change_route() guards its own __in6_dev_get(),
> but this re-fetch is unguarded; nexthop-backed routes survive
> addrconf_ifdown()'s flush, so the walk still reaches it after ip6_ptr is
> nulled.
> 
> Return 0 when idev is NULL, matching rt6_mtu_change_route() and the
> fib6_mtu() fix in commit 5ad509c1fdad ("ipv6: Fix null-ptr-deref in
> fib6_mtu().").
> 
>    Oops: general protection fault, ... KASAN: null-ptr-deref in range
>          [0x00000000000002a8-0x00000000000002af]
>    RIP: 0010:fib6_nh_mtu_change+0x203/0x990
>     rt6_mtu_change_route+0x141/0x1d0
>     __fib6_clean_all+0xd0/0x160
>     rt6_mtu_change+0xb4/0x100
>     ndisc_router_discovery+0x24b5/0x2cb0
>     icmpv6_rcv+0x12e9/0x1710
>     ipv6_rcv+0x39b/0x410
> 
> Fixes: c0b220cf7d80 ("ipv6: Refactor exception functions")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

