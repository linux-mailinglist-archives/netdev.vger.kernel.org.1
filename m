Return-Path: <netdev+bounces-263140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMt6OnvDpmn3TQAAu9opvQ
	(envelope-from <netdev+bounces-263140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:18:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B65A1EDA1F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EE253050430
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF774219FE;
	Tue,  3 Mar 2026 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BkFAS++5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8HlbMCBj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BkFAS++5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8HlbMCBj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610A6421EEE
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772536695; cv=none; b=sYu77T1S5xyO5IYHRiSSFlkZmUNo/Uz541Ro9bYX4LStThGMlfsW7Waiz0Avypr5c7wdqBQUiyaABIY6wYeesAUfHuwvwYDlJaTp0Q/BxsjCckXMEoLEp35BXzCodoL2ybBRERluhK9hvWNmpkWqyEaqTVs50hHHJ08ZHfrj+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772536695; c=relaxed/simple;
	bh=BjIk8tiq+TAUzq0+BzZIJ32j+Zo/0o3Qj1XDI8hrRh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcP9+MPa4JBjXRmtTGLFM9eY4T/zab2aobJxxEnS9Y1XWtOSMeSE2MBX/WERa4aw5n0eMgP6iT1XnO8IwsrgfoM2kQHQ+3Zqkd0ZpN7qSsGdzVz0ZuoP7SnBmNM1bEBSkVy8uTmIGoorm6WpGRSw7+0mz4H8jlHq+/G86CpAR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BkFAS++5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8HlbMCBj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BkFAS++5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8HlbMCBj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A05325BD15;
	Tue,  3 Mar 2026 11:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772536691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9AEVZ90tFj3NWUIQ7kVxP/nON9bYU5NOyMqJpy/xA6Y=;
	b=BkFAS++5jTBNcxwQIxwiObQmLM2xT0fgKnI4Nbe/KZmfsBYJy+ZKZHCyFBPs6NbGSwIXYC
	hOWZEkpiOV0lER9aNJC5y243vz493UlgofVWcfrPxkdZtk42qY6bnZtgbt5Q9I0R0vqRa9
	pET9MxEVbTwoFZJUoHJKfdFLC7rw2Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772536691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9AEVZ90tFj3NWUIQ7kVxP/nON9bYU5NOyMqJpy/xA6Y=;
	b=8HlbMCBj96n8LEIlFZx5vVpFZp37e9UqhtR4tQ6UBWjZuJWNwFCFJ4FQw3l98iXQnK4/Se
	A8psbFNkUCXeP3DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772536691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9AEVZ90tFj3NWUIQ7kVxP/nON9bYU5NOyMqJpy/xA6Y=;
	b=BkFAS++5jTBNcxwQIxwiObQmLM2xT0fgKnI4Nbe/KZmfsBYJy+ZKZHCyFBPs6NbGSwIXYC
	hOWZEkpiOV0lER9aNJC5y243vz493UlgofVWcfrPxkdZtk42qY6bnZtgbt5Q9I0R0vqRa9
	pET9MxEVbTwoFZJUoHJKfdFLC7rw2Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772536691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9AEVZ90tFj3NWUIQ7kVxP/nON9bYU5NOyMqJpy/xA6Y=;
	b=8HlbMCBj96n8LEIlFZx5vVpFZp37e9UqhtR4tQ6UBWjZuJWNwFCFJ4FQw3l98iXQnK4/Se
	A8psbFNkUCXeP3DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43D5E3EA69;
	Tue,  3 Mar 2026 11:18:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KyWhDXLDpmliQwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 03 Mar 2026 11:18:10 +0000
Message-ID: <0d7bb5c5-4122-4dc9-b52b-c305591207d1@suse.de>
Date: Tue, 3 Mar 2026 12:18:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
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
 <toke@redhat.com>, David Ahern <dsahern@kernel.org>,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Hangbin Liu <liuhangbin@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
 <20260228-net-nd_tbl_fixes-v1-1-2b2a274df9bb@suse.com>
 <0b52257d-d557-4f26-9931-34c81ab621bc@iogearbox.net>
 <20260302171131.28373ccb@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260302171131.28373ccb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 6B65A1EDA1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,linux.dev,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263140-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:dkim,suse.de:mid]
X-Rspamd-Action: no action

On 3/3/26 2:11 AM, Jakub Kicinski wrote:
> On Mon, 2 Mar 2026 06:58:46 +0100 Daniel Borkmann wrote:
>>>    	} else if (nh->nh_family == AF_INET6) {
>>> +		if (!ipv6_stub->nd_tbl) {
>>> +			rcu_read_unlock();
>>> +			goto out_drop;
>>> +		}
>>
>> Can we just completely get rid of allowing IPv6 as a module?
>> So either its built-in or not available at all, and then we
>> can get rid of the stub completely rather than adding checks
>> in various places which also brings a small performance benefit
>> of not having indirect calls in some places.
> 
> +1 fwiw, if someone complains we can revert it back in
> feels like a complete waste of everyone's time to maintain it
> https://lore.kernel.org/all/20260224180544.3c865751@kernel.org/

Dropping IPv6 as a module sounds good to me. I could prepare a patch for 
net-next as RFC to start the discussion/feedback loop.

Anyway, I think we still need to fix these crashes on net tree first.

Thanks,
Fernando.

