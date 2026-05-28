Return-Path: <netdev+bounces-292807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJEBGFuPGGq4lAgAu9opvQ
	(envelope-from <netdev+bounces-292807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:54:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BEF5F6C33
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A038300D571
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7382732BF41;
	Thu, 28 May 2026 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JO/Sy55d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ptLeS0kf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0L6eBG9v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G4ns8Rw7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B18303A37
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994259; cv=none; b=unciGXvc3N5apCfIwp4AT6S8GPrrYMDsdAUkD7pu9nDdHp677umwD3jMOUdocnqyIZ363z9KrU8N3/1pi2kn0dBSzxY80R5lZKxaVVEu4xU82EYOo3dyURHCDc64AV9V7wNhagmH1MP8tI2fjJ7d9ujtvhdoIY8AVddUF2/x2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994259; c=relaxed/simple;
	bh=L1pLkxy8UqO8Vh5rkJ8qmcLYO698M1tU8okP8V8J28Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZcBR7QXXxo0CSOnHzVhO+FB1BZleLmxDMuvbRjt+fXooZSlQQI/opcrkQqPRG3lMR3MlzDJqU4fY091ee5n0z3a8I6uVJeIX1srxj12oycdasV4+WQxMbxslOB7U+KpyAKAjFBlP5knBnT1MVHcLwgYLbqaJZ6O7PkkVsPTjO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JO/Sy55d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ptLeS0kf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0L6eBG9v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G4ns8Rw7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3640266EA8;
	Thu, 28 May 2026 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779994256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq4FnlG1+s6CGYrNOgZyOD9bctSjJVctedFloN8niGw=;
	b=JO/Sy55d6NkFn2FX+JOPineU4noEcsLQ+E/2Y3ejg1UMj7kCwA7BtOHyApQ0K5WFTS9kUQ
	wJ6PtCLzCTMf28AJU3rng7O2KL8Sled0/Ocihv3prA3BGBLuZvwpuh2wqJsbEabEuC4KKM
	YWH6UDgh2/9TWEYuOI3YxLVQRXMSq0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779994256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq4FnlG1+s6CGYrNOgZyOD9bctSjJVctedFloN8niGw=;
	b=ptLeS0kfaBHnI1yWu0SRY0sLZYxHaC0f+Y3g5OgyeaE0RGJr4JaDQ1FMIUpwtLk0Vy49Po
	PXHBGQQSj+Vm40Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779994254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq4FnlG1+s6CGYrNOgZyOD9bctSjJVctedFloN8niGw=;
	b=0L6eBG9v7jfjO0v8hd4V9S5kT6T8feGznAnivwdk4+Wdgp6v9fdWok2RIghFcHW70oW8Mo
	FctiVRHqZOW+xt+IM4ZJkXrNjb7ev2bAwUOaFbxgy9TFgGhnoQPj7TIXCpCxow2B8w0U3O
	s3TNSpk2j2Z8HZhN4+TqPgDdrXMGJrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779994254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq4FnlG1+s6CGYrNOgZyOD9bctSjJVctedFloN8niGw=;
	b=G4ns8Rw7Cw0klpgw/F27i7Mwd9jQ9KBc5gwie5PUEriHQUcvfj7O4x8iV95h2n0fMalgVO
	8zlEHhQ1EBhRGFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 803F35AF2A;
	Thu, 28 May 2026 18:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 51M5HI2OGGq0BQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 28 May 2026 18:50:53 +0000
Message-ID: <e91507d6-cbfc-447c-8236-d9b3d91f18c5@suse.de>
Date: Thu, 28 May 2026 20:50:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with IPv6 privacy addresses in 7.0
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Stefano Brivio <sbrivio@redhat.com>,
 Beniamino Galvani <bgalvani@redhat.com>
Cc: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Justin Iurman <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
 <20260528073849.759da84a@elisabeth>
 <baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
 <20260528131250.1352ab48@elisabeth>
 <b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
 <bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
 <20260528153202.14900687@elisabeth>
 <CACT4ouf5ZqGgb=RO8_7NovLCvYKLKL4vD70dEe6xUODT1UEcSA@mail.gmail.com>
 <20260528165320.15b90ded@elisabeth>
 <CACT4oue2EMM9Kfsm9Jii2rG9ooi=D37PK=8886cpLuBkwhrOxw@mail.gmail.com>
 <ahhm1-XfnsWyIWDV@tp> <20260528192143.31c9e9ea@elisabeth>
 <ed954836-742a-44c3-8c2d-65dd06c3514e@suse.de>
Content-Language: en-US
In-Reply-To: <ed954836-742a-44c3-8c2d-65dd06c3514e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,leemhuis.info,kernel.org,vger.kernel.org,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-292807-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 56BEF5F6C33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/28/26 8:42 PM, Fernando Fernandez Mancera wrote:
> On 5/28/26 7:21 PM, Stefano Brivio wrote:
>> On Thu, 28 May 2026 18:01:27 +0200 Beniamino Galvani
>> <bgalvani@redhat.com> wrote:
>>
>>> On Thu, May 28, 2026 at 05:24:28PM +0200, Íñigo Huguet wrote:
>>>> On Thu, May 28, 2026 at 4:53 PM Stefano Brivio
>>>> <sbrivio@redhat.com> wrote:
>>>>> I think what's considered UAPI in this case isn't so clear-
>>>>> cut. I guess it would have been pretty hard for anybody not
>>>>> familiar with NetworkManager's codebase to imagine that an
>>>>> application would rely on IPv6 addresses (and only IPv6) to be
>>>>> returned in the reverse order.
>>>>
>>>> IMHO it's not because an application would rely on the order.
>>>> It's because the order matters, as the first one is considered
>>>> the primary.
>>
>> Yes, that's also the case, but:
>>
>>>> This is not NetworkManager specific. Or I am mistaken? I'm
>>>> speaking by memory
>>
>> ...from what I understood of the issue at hand there's a part that's 
>> specific to NetworkManager here, because NetworkManager replaces / 
>> deletes the Privacy Extensions addresses, instead of different 
>> addresses, because it relies on that specific (reversed) order.
>>
>> Anyway, yes, I see your point about UAPI now.
>>
>>> Yes, exactly. If you do:
>>>
>>> ip addr add dev X 3fff::1/64 ip addr dev dev X 3fff::2/64
>>>
>>> then the old kernel chooses the address that was added last as
>>> source address for outgoing communications. With the new kernel it
>>> chooses the address that was added first.
>>>
>>> I think that any script or network management tool that cares
>>> about the source address selection is impacted. Indeed, the commit
>>> had effects on one of the selftests, which had to be modified to
>>> change the order of iproute2 invocations.
>>>
>>>>>> If the fix must be in NetworkManager, we only need to parse
>>>>>> them in non-reverse order like IPv4, I guess.
>>>>>
>>>>> But that would then require some form of detection, and, at
>>>>> least according to Fernando, isn't the most robust option
>>>>> anyway, as ideally NetworkManager shouldn't rely on the order
>>>>> at all.
>>>>
>>>> True
>>>
>>> Correct, if the new behavior is considered better, there should be
>>> a way to detect which order must be used. Otherwise userspace
>>> tools won't be able to maintain the same behavior with different
>>> kernels.
>>
>> My remark here is about whether NetworkManager needs to detect this
>> at all. If it used timestamps to detect recent / older addresses, as 
>> Fernando mentioned, then you wouldn't need any detection at all,
>> right? Or is there something else we're missing?
>>
> 
> Ohno. Now that Beniamino and Iñigo mentioned it, this will likely break
> many other environments. In essence, many tools relies on the previous 
> ordering to identify which address is the primary one.
> 
> E.g cloud tooling communicating with the metadata server via IMDS(v2) to 
> configure IPv6 primary and secondary addresses. They are likely relying 
> on the ordering for that.
> 
> So maybe we could fix whatever is wrong with NetworkManager and 
> temporary addresses order but I don't think this will scale for the 
> cloud tooling with the primary/secondary issue.
> 
>> By the way, if really needed, one could detect that with the
>> equivalent of:
>>
>> ip a a ::2 dev lo && ip a a ::3 dev lo && [ $(ip -6 -j a | jq -rM '.
>> [] .addr_info[0].local') = ::3 ] && echo wrong || echo right
>>
>> ...depending on the application, that's not necessarily practical,
>> but so far we have no evidence of any application needing to do that
>> at all.
>>
> 
> Plenty of tools (NetworkManager included) uses netlink so this isn't 
> useful for them.
> 
> For now I am more in favor of the revert and to look for an alternative 
> for pasta situation (like using a flag or something). But I am not a 
> maintainer so it isn't my call :)

*facepalm* I just noticed the "with the equivalent of", disregard this 
last part tho.


