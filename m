Return-Path: <netdev+bounces-264722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMscM1+mqmlTVAEAu9opvQ
	(envelope-from <netdev+bounces-264722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 11:03:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 589AB21E5FE
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 11:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24A2930AF720
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F95B34F487;
	Fri,  6 Mar 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xk6vWkNZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CxdhXeYY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xk6vWkNZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CxdhXeYY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757AB34D4E0
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791135; cv=none; b=qMXJqsRR52mIYUvgC3ag//ESRge/m+lH0Z4uQmj9ifbodLwaGCVlTRANXzN1u5NQlKrJpAMqXq+2vijhW09tGfvdlNfoSYHvJoZb6gtVmdNyRtKT8KILsL/vhXmaRcnuxAD3E7YbZx9l/DKqLPVz0gOtz8P77OfbsOFbHXQNemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791135; c=relaxed/simple;
	bh=P0IkSeqQ7fCQIGnFk3lw3TNS81NHlXKUzK61UgqZNFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnEmL0Qh+/BBqA6P0Qv5FCHwcMzS+KIMAJZrRe+LUce0Ffdwd+IL+ujtlX+W9tg3zIwfPuPNu0lns4cie59Ryr10eHG9cwuvj6k6MilIDkYxwlzyX0KMPCDcIGVkwvV5VY4FNXZY2xP4fdJM1FGZTWYEya1cCpwWENiFKIIVj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xk6vWkNZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CxdhXeYY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xk6vWkNZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CxdhXeYY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3935A5BD8E;
	Fri,  6 Mar 2026 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772791127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhMcktw3Gz3DMzPYzGWkb8un5tONzEZ2V5rvxzmHAIc=;
	b=Xk6vWkNZ422rV3iMi4Ve6Qn1ufBJgdErdesucNVMM9yzQarWLRCGa/+9kS1MdgB3BQb2WE
	lYOBoeALVrkQrLUkdTqBATvEXSKCm70vl/XjrBfd6CbTor/Me4UCkeW8lX01rCFAFg9Nbl
	0D/5ojq3CZV8z/4LSnrGsu0WZR6/dwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772791127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhMcktw3Gz3DMzPYzGWkb8un5tONzEZ2V5rvxzmHAIc=;
	b=CxdhXeYYUMVzJ7txBMqnAinrsNWft+/4ku0Y3SBGnzauNTJYoQJhzlHda+fFQ6bli6PJK9
	GXiA5/e3XmN5NRBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xk6vWkNZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CxdhXeYY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772791127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhMcktw3Gz3DMzPYzGWkb8un5tONzEZ2V5rvxzmHAIc=;
	b=Xk6vWkNZ422rV3iMi4Ve6Qn1ufBJgdErdesucNVMM9yzQarWLRCGa/+9kS1MdgB3BQb2WE
	lYOBoeALVrkQrLUkdTqBATvEXSKCm70vl/XjrBfd6CbTor/Me4UCkeW8lX01rCFAFg9Nbl
	0D/5ojq3CZV8z/4LSnrGsu0WZR6/dwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772791127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhMcktw3Gz3DMzPYzGWkb8un5tONzEZ2V5rvxzmHAIc=;
	b=CxdhXeYYUMVzJ7txBMqnAinrsNWft+/4ku0Y3SBGnzauNTJYoQJhzlHda+fFQ6bli6PJK9
	GXiA5/e3XmN5NRBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD6FB3EA75;
	Fri,  6 Mar 2026 09:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id raUgK1WlqmlMEwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 06 Mar 2026 09:58:45 +0000
Message-ID: <b3477010-6fdd-4bec-8951-152b12bf56e6@suse.de>
Date: Fri, 6 Mar 2026 10:58:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
To: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?=
 <rbm@suse.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>,
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
References: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
 <20260305-net-nd_tbl_fixes-v3-2-fde28b30a744@suse.com>
 <20260305182521.0ca7313c@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260305182521.0ca7313c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 589AB21E5FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-264722-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 3/6/26 3:25 AM, Jakub Kicinski wrote:
> On Thu, 05 Mar 2026 18:29:56 -0300 Ricardo B. Marlière wrote:
>> +++ b/net/core/filter.c
>> @@ -2228,6 +2228,9 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
>>   			return -ENOMEM;
>>   	}
>>   
>> +	if (unlikely(!ipv6_stub->nd_tbl))
>> +		goto out_drop;
> 
> So neither Fernando nor you checked whether this code can be built
> as a module? ipv6_mod_enabled() should work just fine
> 

I checked it. If IPV6=m this is not fine.

ld: vmlinux.o: in function `bpf_out_neigh_v6':
filter.c:(.text+0x3231d60): undefined reference to `ipv6_mod_enabled'

> SMH


