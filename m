Return-Path: <netdev+bounces-281393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAv9Ge5572kmBwEAu9opvQ
	(envelope-from <netdev+bounces-281393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:59:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E96474CC8
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D247305E2DD
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CB83A7F55;
	Mon, 27 Apr 2026 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FYpZK5Qn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AglcN+tI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FYpZK5Qn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AglcN+tI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E822FE060
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301710; cv=none; b=S3AJougKLCBUybqn48cIAqIcfrSZLpO3HYl2ZgKJL6IF33UA82nIUAvf/oaJv6WX+/SSfEixDRD9jkKin9q4+u/Foyaqnmel5dom+4HPlSYskC8B910EKASC0nFk0WW74chY3cdEEDMGpuuQLy2wb4hT663oCj6uiki6b1utjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301710; c=relaxed/simple;
	bh=maiQCo2pd6oEY4KL+KoezrB8LhVhRD/jO8Z/2oZgWFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OUB8eRA0H2lODW0x1bCOLLMAER9TmBPAvoniIA42X8ApaO35vnFRhyYE8hGTP1c5B19rOTprS7RPPrp1g12zrpqWOJu6wYyi1Py3ru3CJGEDjaeicCYoCLfh5XN+yuSjxEfvNFGu0tA0hte4FV4GG9y0AyarhBAuJZQiRvqrS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FYpZK5Qn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AglcN+tI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FYpZK5Qn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AglcN+tI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 221AD6A89C;
	Mon, 27 Apr 2026 14:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777301707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtmRvUM3l7Tv+HOfvCFWieqqSlQ69RarAZQb9FX5flg=;
	b=FYpZK5Qn3V96SwofixbCfDje5Axs3aZfS7Xg7fYMVmlQuZvbR136DuAXeozLIA4TUCExOh
	7SqzZQJHQpUMqqOnWAEmAQahe2QatlVEDtieCZxKi2D01CTfiC2FXZAwBXHd7uIDJtew7W
	fwwXfK1/pmMtIF3aPyTZZ80nXUjtr/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777301707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtmRvUM3l7Tv+HOfvCFWieqqSlQ69RarAZQb9FX5flg=;
	b=AglcN+tITejzYhWTF9NBEqeRpeNTS1K63PlodMZQajDDHh30iV0jUw3DARbwNZ2buFcUbY
	6fyUU+NoSOASZkDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FYpZK5Qn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AglcN+tI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777301707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtmRvUM3l7Tv+HOfvCFWieqqSlQ69RarAZQb9FX5flg=;
	b=FYpZK5Qn3V96SwofixbCfDje5Axs3aZfS7Xg7fYMVmlQuZvbR136DuAXeozLIA4TUCExOh
	7SqzZQJHQpUMqqOnWAEmAQahe2QatlVEDtieCZxKi2D01CTfiC2FXZAwBXHd7uIDJtew7W
	fwwXfK1/pmMtIF3aPyTZZ80nXUjtr/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777301707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtmRvUM3l7Tv+HOfvCFWieqqSlQ69RarAZQb9FX5flg=;
	b=AglcN+tITejzYhWTF9NBEqeRpeNTS1K63PlodMZQajDDHh30iV0jUw3DARbwNZ2buFcUbY
	6fyUU+NoSOASZkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE038593B0;
	Mon, 27 Apr 2026 14:55:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oTw+N8p472mGMQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 27 Apr 2026 14:55:06 +0000
Message-ID: <8d648645-0352-4657-9cf0-c39a5cdc13ee@suse.de>
Date: Mon, 27 Apr 2026 16:55:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] some temporary IPv6 address don't get regenerated
To: =?UTF-8?Q?=C5=81ukasz_Stelmach?= <steelman@post.pl>,
 netdev@vger.kernel.org
References: <87340td30q.fsf%steelman@post.pl>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <87340td30q.fsf%steelman@post.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: C0E96474CC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281393-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/17/26 5:23 PM, Łukasz Stelmach wrote:
> Hi,
> 
> Apparently, something in addrconf.c can go wrong and a temporary
> addresses may not get regenerated leaving users who wish to use them
> with only the stable ones. Below, 2a01:110f:4321:1002:abcc:78d7:2055:94ec
> while still valid is not preferred anymore. Even if it's not the only
> global temporary address it is the only usable to contact hosts on the
> Internet because the other temporary addresses are ULA.
> 

Hi,

I managed to reproduce this, it took me quite some time. It looks like a 
race condition somewhere. I am working on a fix and I will add a 
selftest covering this too.

Ideally, I will send a fix this week. I am now checking if this was 
introduced recently or was always broken.

> Neither received RAs nor adding and removing an address manually (one
> with a different prefix unrelated to these below) which as far as I
> understand, should trigger address maintenance code.
> 

Yup, same situation here.

Thanks,
Fernando.

> I noticed this phenomenon once or twice before. It seems to be very
> rare, yet quite undesirable I'd say. What might have triggered it today
> is a reboot of my router and (possible?) change in lifetime values it
> announced.
> 
> Even stranger is that there is a preferred fd89:: (ULA), but not 2a01::.
> 
> accept_ra as well as use_tempaddr are set to 2.
> 
> Of course, this ma be get fixed by a suspend/resume (no, it may not) or
> manual ifdown/ifup (of course it helped), but nevertheless I thought it
> was worth reporting.
> 
> --8<---------------cut here---------------start------------->8---
> 107: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>      link/ether b8:ca:3a:d4:1e:97 brd ff:ff:ff:ff:ff:ff
>      inet 192.168.2.122/24 brd 192.168.2.255 scope global dynamic bond0
>         valid_lft 165585sec preferred_lft 165585sec
> 
>      inet6 fd89:82bb:420:2:cab3:d2d6:aeeb:e250/64 scope global temporary dynamic
>         valid_lft 597079sec preferred_lft 78177sec
> 
>      inet6 2a01:110f:4321:1002:abcc:78d7:2055:94ec/64 scope global temporary deprecated dynamic
>         valid_lft 60815sec preferred_lft 0sec
> 
>      inet6 2a01:110f:4321:1002:abac:3aff:fed4:beef/64 scope global dynamic mngtmpaddr proto kernel_ra
>         valid_lft 60815sec preferred_lft 60815sec
> 
>      inet6 fd89:82bb:420:2:24bf:fe8f:5c9c:c753/64 scope global temporary deprecated dynamic
>         valid_lft 511186sec preferred_lft 0sec
> 
>      inet6 fd89:82bb:420:2:abac:3aff:fed4:beef/64 scope global dynamic mngtmpaddr proto kernel_ra
>         valid_lft 2591805sec preferred_lft 604605sec
> 
>      inet6 fe80::abac:3aff:fed4:beef/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
> --8<---------------cut here---------------end--------------->8---
> 


