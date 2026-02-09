Return-Path: <netdev+bounces-257958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBMCN+L9iWluFQAAu9opvQ
	(envelope-from <netdev+bounces-257958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 16:31:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFEB111EDF
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E4A8305DEEE
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 15:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9166F37F100;
	Mon,  9 Feb 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dVe4aC8U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ahVUEU0o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dVe4aC8U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ahVUEU0o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409BB37F0F7
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650762; cv=none; b=VvICGMpvmnvmIHxbeGZnjveb7vjHWUS7bo/wKiTtlwEzmmEiwKe/T7v8Ifb5fJYoCwjcOGl3A8o2ANfXWCSabq/JdoZEeFQIQiyLXAhIGEUZ59X6t/SVRkDQ2Fzcya2PF2aESxHY7pdZ/8UWGcx92fLbzTzdvpp/gGBOFygK7bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650762; c=relaxed/simple;
	bh=8sf12bdDZSlGSccRjkyFc4DzSqXFDuafZoAwDn99dy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSc95SSY2L0KUxS41j9Cwpm42Q79XvrjvTyeNkrq5n1AWlbZXGcViScp3+yZz7ctS3eZHsBCfbn2nHX/qIhccuUxfU7RL/qjcE1dd14Q5KxERopVkV0r2j5AXXkcDbihXNQqapCQt/wNoIIbxNycHKv1idjQkMS+qfrJLxzjs5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dVe4aC8U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ahVUEU0o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dVe4aC8U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ahVUEU0o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6076D3E712;
	Mon,  9 Feb 2026 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770650760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/t3djtqceczc/kumZH/3BRs3t1izpbgkuB3k4cyq1LU=;
	b=dVe4aC8UMGE8KQGJx/+IsBkhtOLhUxg+O7l3196R65K0WqisVv3ib8fFTPJV4o13K/H7oi
	RALU9B8rmNkihxyZiHw1GF83hSnO0/gbbf2xxUoQZyRmL3w6OJji3zLOLpB0RnxSvvPlrb
	Ceqsta/6IoPez/gWmiyvPLx3sc99K5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770650760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/t3djtqceczc/kumZH/3BRs3t1izpbgkuB3k4cyq1LU=;
	b=ahVUEU0oENpqE3omnQgpD5vkq5W3aIWsekqTc6ZuUM16siyQ8T+PI3UmOYw/fOAdtoodB1
	3vxPcbiiS5IW2pCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dVe4aC8U;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ahVUEU0o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770650760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/t3djtqceczc/kumZH/3BRs3t1izpbgkuB3k4cyq1LU=;
	b=dVe4aC8UMGE8KQGJx/+IsBkhtOLhUxg+O7l3196R65K0WqisVv3ib8fFTPJV4o13K/H7oi
	RALU9B8rmNkihxyZiHw1GF83hSnO0/gbbf2xxUoQZyRmL3w6OJji3zLOLpB0RnxSvvPlrb
	Ceqsta/6IoPez/gWmiyvPLx3sc99K5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770650760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/t3djtqceczc/kumZH/3BRs3t1izpbgkuB3k4cyq1LU=;
	b=ahVUEU0oENpqE3omnQgpD5vkq5W3aIWsekqTc6ZuUM16siyQ8T+PI3UmOYw/fOAdtoodB1
	3vxPcbiiS5IW2pCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85A1E3EA63;
	Mon,  9 Feb 2026 15:25:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tn61HYf8iWlMPQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 09 Feb 2026 15:25:59 +0000
Message-ID: <641a1a66-705e-46ee-9612-db35d92729cf@suse.de>
Date: Mon, 9 Feb 2026 16:25:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] inet: add ip_retry_random_port sysctl to
 reduce sequential port retries
To: longxie86@protonmail.com
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org,
 idosch@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thorsten Toepper <thorsten.toepper@sap.com>
References: <20260203175422.4620-1-fmancera@suse.de>
 <CANn89i+UUWx5OhPnJnDhiCfr53BPTAGedBucgqYwyfqkidf_Cg@mail.gmail.com>
 <8d94faf9-2fb6-483d-9767-bd665c4a4b9a@suse.de>
 <1649583d-71c2-425e-a2df-685d5f6dc67d@suse.de>
 <CANn89iK3Pu2NXxejTSLF-7MhBc03_ZJUjOtZcTC4nMsbsDpbSw@mail.gmail.com>
 <d76cd8c3-deb0-4f39-b5b9-a711d155cd5f@suse.de>
 <egIQQeDF4RIP_614tU-XIK-01DgThdPOU3KA253uNHvZv76zymXyBFhey1G7wj5mA2nwHpdT7VBoGuFnATSO-PS0hUb0Qrt0AyN5JNbpATg=@protonmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <egIQQeDF4RIP_614tU-XIK-01DgThdPOU3KA253uNHvZv76zymXyBFhey1G7wj5mA2nwHpdT7VBoGuFnATSO-PS0hUb0Qrt0AyN5JNbpATg=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257958-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,0xffsoftware.com:url]
X-Rspamd-Queue-Id: 3AFEB111EDF
X-Rspamd-Action: no action

On 2/9/26 2:53 PM, longxie86@protonmail.com wrote:
> On Monday, February 9th, 2026 at 12:57 PM, Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> 
>>
>>
>> On 2/6/26 6:09 PM, Eric Dumazet wrote:
>>
>>> On Fri, Feb 6, 2026 at 5:28 PM Fernando Fernandez Mancera
>>> fmancera@suse.de wrote:
>>>
>>>> It makes sense. I have tested this approach and we got a more even
>>>> distribution of source ports when having thousands of reserved ports. No
>>>> difference at all when not using reserved ports.
>>>>
>>>> Please, you can find the distribution graph with the current algorithm
>>>> [1] and with the random step algorithm [2].
>>>>
>>>> While I understand that this approach is introducing a call to
>>>> get_random_u32_below() on every connect, I am wondering if it makes
>>>> sense to replace the existing algorithm with this variant. What do you
>>>> think?
>>>
>>> I would ask RFC 6056 experts like Fernando Gont what they think.
>>>
>>> Note that if we use random at each connect(), we defeat one of the principles
>>> of ephemeral port selection : try very hard to avoid 4-tuple collision.
>>
>>
>> Right. I will reach out to him and get his opinion. I have plenty of
>> time before net-next open again. I am also collecting some metrics
>> regarding the 4-tuple collision frequency.
>>
> 
> We have had this problem in AWS for a long time. The patch works on our system. What is needed for it to be included in the next Linux release?
> 

This just an RFC, I discourage using it in production yet. An official 
v1 will be sent once net-next is open and there it needs to be reviewed 
and approved by the maintainers.

> Please bring this to the stable versions.
> 

I don't think that will happen. This is an improvement not a "fix" per 
definition. Anyway, you could ask for a backport to your 
vendor/distribution.

Thanks,
Fernando.

>>>> Please, notice the implementation below. I plan to send an official v1
>>>> once net-next is open. In addition, I am rewriting the commit message as
>>>> I find the current one confusing.
>>>>
>>>> [1] https://0xffsoftware.com/port_graph_current_alg.html
>>>>
>>>> [2] https://0xffsoftware.com/port_graph_random_step_alg.html
>>
>>


