Return-Path: <netdev+bounces-257936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF2WJGfUiWmFCAAAu9opvQ
	(envelope-from <netdev+bounces-257936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 13:34:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0211110EB0F
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 13:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA02A301586D
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4E372B47;
	Mon,  9 Feb 2026 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QwMWAhtj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/sY770O0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="08D8sHvU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2ZXFGEvR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94DE36998A
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770638235; cv=none; b=cBU95p7ek6qceo2N3A247Khci5hylwxYKF2I1wEz/L2SkEWu41ea+JTmq7OWQbyr6nXNIQzltcZxNRGIb8W8j232HQEwRerl84kHg6IaANKAsEK3if7HAjict1lNx8ijOUlPiQvfZ1+8cJign4K8xzKedJnGhicF6JdJ/soAW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770638235; c=relaxed/simple;
	bh=ZG1N/MjOHF9XpE9oCKezmaofYM9c9/vDo81q2GRU+70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orUATypEwcX4A8ytPBMCfeswXmdB8TDJj29L7ac1ipMrPTfLi5EsB8EwI4H1vMN8E0yXvdL6GZzui2wEZdV+gkLMHDMBOtR/BSewXj2TJuiOGT0lsNJIVjqwNwrPij3jZWroIcBsZRZ/UjZYp3Zh9wWsdsQjzZwaTyvhdTFFfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QwMWAhtj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/sY770O0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=08D8sHvU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2ZXFGEvR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 102CF3E6F5;
	Mon,  9 Feb 2026 11:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770638233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgQb4rjIV3uuOqT/ANzRAmp+D+By/bwgN2YDqg4mxPk=;
	b=QwMWAhtjSvQ/vuInss53V93Ktux2RRPj612DfPznLhS16dllHv7O1QUOMCy2wm2VUNBURS
	BwFQrJteSFZnQ1dwbz2DAbNcbtx2l/pgbPlVu3dL3Uu4lcLHekPkDlgaKEd41N8sirtHnb
	wOYyWLpNRR26VS2q/JjU5KKAiMrf0IQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770638233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgQb4rjIV3uuOqT/ANzRAmp+D+By/bwgN2YDqg4mxPk=;
	b=/sY770O0GkYLEBsDDWjlKPIQ7WrL+8hP77QSjAYHOvYEe01dunB+3dE7RmpNWuVmtdyJrd
	K7Exk97B9wNUreCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=08D8sHvU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2ZXFGEvR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770638232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgQb4rjIV3uuOqT/ANzRAmp+D+By/bwgN2YDqg4mxPk=;
	b=08D8sHvUAW4GDurT1P01URFrHEPSzBXOEG67zb2ZTfRdP2toffHuOVAAUdXoemWMvmaGTb
	PVkOsqDQwxP8qGoIUaJagABJgyri65OFnsry85Y3gP2tzo+weUAqoAORAD0g9H8I5OnAa8
	d4vqyIcG8Qf+KsK2BR9Dl71PsbrvoUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770638232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgQb4rjIV3uuOqT/ANzRAmp+D+By/bwgN2YDqg4mxPk=;
	b=2ZXFGEvR/di2drbDEuyCLfmBbGEIIU4c0m0NhPq8Q3r9zIjLePFB0+3FSVEX829Tf+bPv8
	gtJtUSyC4PVcvEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 316BB3EA63;
	Mon,  9 Feb 2026 11:57:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ok7zCJfLiWklJAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 09 Feb 2026 11:57:11 +0000
Message-ID: <d76cd8c3-deb0-4f39-b5b9-a711d155cd5f@suse.de>
Date: Mon, 9 Feb 2026 12:56:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] inet: add ip_retry_random_port sysctl to
 reduce sequential port retries
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, ncardwell@google.com,
 kuniyu@google.com, dsahern@kernel.org, idosch@nvidia.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thorsten Toepper <thorsten.toepper@sap.com>
References: <20260203175422.4620-1-fmancera@suse.de>
 <CANn89i+UUWx5OhPnJnDhiCfr53BPTAGedBucgqYwyfqkidf_Cg@mail.gmail.com>
 <8d94faf9-2fb6-483d-9767-bd665c4a4b9a@suse.de>
 <1649583d-71c2-425e-a2df-685d5f6dc67d@suse.de>
 <CANn89iK3Pu2NXxejTSLF-7MhBc03_ZJUjOtZcTC4nMsbsDpbSw@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CANn89iK3Pu2NXxejTSLF-7MhBc03_ZJUjOtZcTC4nMsbsDpbSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257936-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0xffsoftware.com:url]
X-Rspamd-Queue-Id: 0211110EB0F
X-Rspamd-Action: no action

On 2/6/26 6:09 PM, Eric Dumazet wrote:
> On Fri, Feb 6, 2026 at 5:28 PM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
>>
>>
>>
>> It makes sense. I have tested this approach and we got a more even
>> distribution of source ports when having thousands of reserved ports. No
>> difference at all when not using reserved ports.
>>
>> Please, you can find the distribution graph with the current algorithm
>> [1] and with the random step algorithm [2].
>>
>> While I understand that this approach is introducing a call to
>> get_random_u32_below() on every connect, I am wondering if it makes
>> sense to replace the existing algorithm with this variant. What do you
>> think?
> 
> I would ask RFC 6056 experts like Fernando Gont what they think.
> 
> Note that if we use random at each connect(), we defeat one of the principles
> of ephemeral port selection : try very hard to avoid 4-tuple collision.
> 

Right. I will reach out to him and get his opinion. I have plenty of 
time before net-next open again. I am also collecting some metrics 
regarding the 4-tuple collision frequency.

>>
>> Please, notice the implementation below. I plan to send an official v1
>> once net-next is open. In addition, I am rewriting the commit message as
>> I find the current one confusing.
>>
>> [1] https://0xffsoftware.com/port_graph_current_alg.html
>>
>> [2] https://0xffsoftware.com/port_graph_random_step_alg.html
> 


