Return-Path: <netdev+bounces-263917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFBFAk9eqGmZtgAAu9opvQ
	(envelope-from <netdev+bounces-263917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:31:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 923A22044B0
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD21730479C8
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45866358390;
	Wed,  4 Mar 2026 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s1QZQ+nk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p71z4Fsc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s1QZQ+nk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p71z4Fsc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1119B353EC8
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640864; cv=none; b=qbPHU6J6G/ayAaULE09SbZjNDQSXIQp9WcUI2XO52TI/S5Yvan9MAGgRw0ssIybQO7FJwS+8ZTC/MBSLk27g2Cq5XdXnAFjvS7knfccBTeUg7hTcsIZYjX5z/9v8DWaLebtZNg9CnF9vlnNkOJqnh7XJc9742eHMLyrZWWca9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640864; c=relaxed/simple;
	bh=BJhSI8YyDnYwG/YSLyeauMxJaBwN/UIwFp9AQDNBSvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrA5803QVbv2Vr1flqUVazWY7I/5aB32AAy+vV8g4BHt0UmtWOS18df8qkWc1+jGFl2NK7OT7RrfrR9+4hMmQkKNcEfkefoX5vPTNQ5kyiaConW4Wt7VT85oOPCviVnhU9V5PSZTP6+OR+6230QopV4fgch3vwanl83s/+mG5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s1QZQ+nk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p71z4Fsc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s1QZQ+nk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p71z4Fsc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E23F3F7D0;
	Wed,  4 Mar 2026 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772640861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajoRZChLFPs1F0mUpZ7Ecdp8r2zvsyEaG9QiHQzGOr0=;
	b=s1QZQ+nk9hFzpc+Lca+K8Qd1w6YLC8vbOxhNVMIjZD3R87/3Kz/Qm/U/Ud1bPZ5DxJzf5Z
	yU/+1RmTBPYZ8SOnI6pzXIGHQFU9MOuWo4B5gc0hwEJrjGULtKPsftf2bSpX20tnG4HyDI
	8BBwLt0r6cg/lPYyFjC3581P9jFAPj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772640861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajoRZChLFPs1F0mUpZ7Ecdp8r2zvsyEaG9QiHQzGOr0=;
	b=p71z4Fscn/K0+ATuwvNB4jyZPi+cUNzE3GwJjR2Izh728CuNUs/j6YzXuJG0A9OB+IhDyt
	z9nrYqji6fH84vAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772640861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajoRZChLFPs1F0mUpZ7Ecdp8r2zvsyEaG9QiHQzGOr0=;
	b=s1QZQ+nk9hFzpc+Lca+K8Qd1w6YLC8vbOxhNVMIjZD3R87/3Kz/Qm/U/Ud1bPZ5DxJzf5Z
	yU/+1RmTBPYZ8SOnI6pzXIGHQFU9MOuWo4B5gc0hwEJrjGULtKPsftf2bSpX20tnG4HyDI
	8BBwLt0r6cg/lPYyFjC3581P9jFAPj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772640861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajoRZChLFPs1F0mUpZ7Ecdp8r2zvsyEaG9QiHQzGOr0=;
	b=p71z4Fscn/K0+ATuwvNB4jyZPi+cUNzE3GwJjR2Izh728CuNUs/j6YzXuJG0A9OB+IhDyt
	z9nrYqji6fH84vAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD7D13EA69;
	Wed,  4 Mar 2026 16:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /veKKltaqGkoBQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 04 Mar 2026 16:14:19 +0000
Message-ID: <ba35fa2c-0085-43c9-afe0-3b2e0351ca3c@suse.de>
Date: Wed, 4 Mar 2026 17:13:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
To: David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
 <20260228-net-nd_tbl_fixes-v1-1-2b2a274df9bb@suse.com>
 <0b52257d-d557-4f26-9931-34c81ab621bc@iogearbox.net>
 <20260302171131.28373ccb@kernel.org>
 <0d7bb5c5-4122-4dc9-b52b-c305591207d1@suse.de>
 <bbee1ce1-0615-4be2-b7b1-a14eaf2afe26@iogearbox.net>
 <ba665193-bb6f-4293-b8ca-bbb267e92eb3@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <ba665193-bb6f-4293-b8ca-bbb267e92eb3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 923A22044B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,linux.dev,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263917-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 4:49 PM, David Ahern wrote:
> On 3/3/26 9:49 PM, Daniel Borkmann wrote:
>> Maybe the "fix" could be to just switch IPV6 from tristate to bool in
>> the Kconfig, and then once net merges into net-next we could deconstruct
>> all the helper cruft which makes the late on-demand module loading of
>> IPv6 work.
> 
> +1

Maybe I am missing something here, but I believe this won't solve the 
problem. Even if ipv6 is built-in, it should be possible to pass 
ipv6.disable=1 during boot and therefore nd_tbl would still be 
uninitialized, not NULL tho.

Thanks,
Fernando.

