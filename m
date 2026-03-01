Return-Path: <netdev+bounces-262445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI7xNZmFpGnajAUAu9opvQ
	(envelope-from <netdev+bounces-262445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:29:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 871DF1D117E
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A116430158B3
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 18:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C9C337BB8;
	Sun,  1 Mar 2026 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PLJUbMd2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NA1OOFEd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l+W0Tv5n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ONsUcLde"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABA62E7F11
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772389780; cv=none; b=GQbSEFbkhtROf1nMHOmU9gWgZCj79cErenbFNvzTEzmdE69qvHOvqeNT4iEX5Vwx+9IQWwZBItCHVb7q/Kb6MoMFuQYHDeCzigJJpgtyfCEWqXnuNju0i4WEnGhTGUQhmqVQFU8mKVIM/qV3ujwduXQWiQpGpUikuza2hN2DbEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772389780; c=relaxed/simple;
	bh=FgPbbBcSM4lEV0NiVOq9t96d1nVWn65rLImgX3D41K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D952Lmg4gy+HeMyEWcUIvtaRspCht+ZrpAe4kmRIy91ozZN26/LaL3QjBdL8dzlvHoYZjLStwOSvImieffDMKVpn7FGSiJzG/o29sXfn4qZ9ZrlMTYWrEMslLqSphBDFgpf7ufgtjMm4UT4wBfSNrswlNBQgQ1SOVtJp/xOQXY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PLJUbMd2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NA1OOFEd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l+W0Tv5n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ONsUcLde; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2FC213E772;
	Sun,  1 Mar 2026 18:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772389776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXs1JgTTVr9rJVaJhuPxysezi0SuGZ4SajJ4SJVSrX8=;
	b=PLJUbMd2S8YCQK1kdCpa6+6nJ6fbg+6XDzfZyUw/9iREaU5U22YrC+M23piOdrl38Dy1Kg
	FzJIcjPghVSNKq6RfLLPWdJuHrWFSvLnIEbBBnJDMcDjaJEV6l/0a9/y3fD5KceUb+Vw0V
	mWIGIDEhSOXutSx1i37ly3gmu2lAn6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772389776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXs1JgTTVr9rJVaJhuPxysezi0SuGZ4SajJ4SJVSrX8=;
	b=NA1OOFEdk0nuMWPv1D+y5TJz91RJ9VE6QYW4TjOEvPDNY0pUWWJGyrto3KUlE8RF09/Wa5
	AJNsnRf3CiUT91Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l+W0Tv5n;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ONsUcLde
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772389775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXs1JgTTVr9rJVaJhuPxysezi0SuGZ4SajJ4SJVSrX8=;
	b=l+W0Tv5nf0INOeMPpg58Fx07ys9EizjoRfDmwqWSGo7OIjduQRIf2CQXkJmruf7DNVyiyR
	IH3y1n7JHX97w2ek9I1zrueZTu1hIieeyRc1MCiay/DOjo0T5TNokSo+Elf5mCTcIz/a9o
	TPr43N/yThyrQPBf/Es0Xf72EgacTsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772389775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXs1JgTTVr9rJVaJhuPxysezi0SuGZ4SajJ4SJVSrX8=;
	b=ONsUcLdevCxe5sSS/PQn66m6nTCej1s6JYXibL39/+6RUAspjL+U4ntgMMZIMthtBD8olj
	+AHu7N6dybiqCKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC8773EA69;
	Sun,  1 Mar 2026 18:29:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5831Lo2FpGnzEQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 01 Mar 2026 18:29:33 +0000
Message-ID: <2a2afbf1-acc5-449a-a4d8-83badd49fbab@suse.de>
Date: Sun, 1 Mar 2026 19:29:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] {net,bpf}: nd_tbl fixes for when ipv6.disable=1
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262445-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[suse.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 871DF1D117E
X-Rspamd-Action: no action

On 2/28/26 6:46 PM, Ricardo B. Marlière wrote:
> Hi,
> 
> In line with [1] [2], I'm sending these small fixes for similar crashes.
> 
> Thanks,
> -	Ricardo.
> 
> [1] https://lore.kernel.org/netdev/20260227112701.3990-1-fmancera@suse.de
> [2] https://lore.kernel.org/netdev/20260226234059.19402-1-fmancera@suse.de
>
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
> Ricardo B. Marlière (3):
>        bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is disabled
>        bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is disabled
>        net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled
> 
>   drivers/net/bonding/bond_main.c | 4 ++++
>   net/core/filter.c               | 7 +++++++
>   2 files changed, 11 insertions(+)
> ---

Saving some time here for reviews: 
https://lore.kernel.org/netdev/20260301155413.GA755501@shredder/ I guess 
this feedback applies here too.

