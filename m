Return-Path: <netdev+bounces-260094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIRWM2p3nGlfIAQAu9opvQ
	(envelope-from <netdev+bounces-260094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:51:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F371790FC
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8B9D3035E3A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D87F3033E6;
	Mon, 23 Feb 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kTjtKdW/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GneL3eMH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kTjtKdW/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GneL3eMH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23504303A07
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861861; cv=none; b=MK34oz68SlFoJo9Y47jtb8/OhSDgCml+UDR5aWgN6pEyJTR9M2bNqCNaWNSQGBJc8zecBPBsbTQJNsIHsHN9wP1/CQUd+6rdydlohnXycUtxRmL3GPh0l69hZAjMPRZDqOe07cBladY5C7ulLMwm5dpJFEyYSVA3mduHKp97FvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861861; c=relaxed/simple;
	bh=qD+odozM+lfrsQkkS8hNOToW4ZPCWeW8pPBaUt52K8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhUZZSQkSPsU2ZF/U86HtiknE4Uq1hhCJYR9LLn/xM3Ie1CYCoW7jvC2olX/nfBh6v6OunRf0IxY+10FVecXSv+Sv+C/+gpaewrC3xTRC3f9+kwnA8av7oc4FP37dr/sV/oGY5Oh1hUqczrL32HBmAwha5pSVR9MBBN6RPYdCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kTjtKdW/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GneL3eMH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kTjtKdW/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GneL3eMH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40E775BD1D;
	Mon, 23 Feb 2026 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771861858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzwV/6OLu75mHGev233fez7Ueq6qAbtGuzbLgyFwdsk=;
	b=kTjtKdW/KppNKaKo8mu/jfmc9KwczZaSzb0W193TvfpngIlfgrMLKAFAqvKmlAEVs8WWmc
	1OfUnsyNKXtp1rTzi7RZO0auXI9KAdy3+jK/9DZQj4c6Q5pDbypedd99QO/NtEH1CI72+x
	b8+Rfo4BnZ5Xbp9qkroNjvklY7nzkmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771861858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzwV/6OLu75mHGev233fez7Ueq6qAbtGuzbLgyFwdsk=;
	b=GneL3eMH3JV9CT0q1Y6eG5IYmzB/TvunEyh3hnlBhW/Ij8n/KGqB0CUbzQMVzfPcJW8Egu
	wuI0iOqZlNksVzDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="kTjtKdW/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GneL3eMH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771861858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzwV/6OLu75mHGev233fez7Ueq6qAbtGuzbLgyFwdsk=;
	b=kTjtKdW/KppNKaKo8mu/jfmc9KwczZaSzb0W193TvfpngIlfgrMLKAFAqvKmlAEVs8WWmc
	1OfUnsyNKXtp1rTzi7RZO0auXI9KAdy3+jK/9DZQj4c6Q5pDbypedd99QO/NtEH1CI72+x
	b8+Rfo4BnZ5Xbp9qkroNjvklY7nzkmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771861858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzwV/6OLu75mHGev233fez7Ueq6qAbtGuzbLgyFwdsk=;
	b=GneL3eMH3JV9CT0q1Y6eG5IYmzB/TvunEyh3hnlBhW/Ij8n/KGqB0CUbzQMVzfPcJW8Egu
	wuI0iOqZlNksVzDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAD9B3EA68;
	Mon, 23 Feb 2026 15:50:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jMhfKmF3nGlTSwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 23 Feb 2026 15:50:57 +0000
Message-ID: <a750c744-58b7-42bf-a43a-98be8cc90ab4@suse.de>
Date: Mon, 23 Feb 2026 16:50:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: discard fragment queue if middle fragment
 is not 8 bytes aligned
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, dsahern@kernel.org, davem@davemloft.net
References: <20260223151918.31965-1-fmancera@suse.de>
 <CANn89iLHNrikOivuKDbBHaZGY-OPD124_JoLthiv49G7Hhm7UA@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CANn89iLHNrikOivuKDbBHaZGY-OPD124_JoLthiv49G7Hhm7UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260094-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 94F371790FC
X-Rspamd-Action: no action

On 2/23/26 4:42 PM, Eric Dumazet wrote:
> On Mon, Feb 23, 2026 at 4:19 PM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
>>
>> Currently the kernel IPv6 implementation is not dicarding the fragment
>> queue upon receiving a IPv6 fragment that is not 8 bytes aligned. It
>> relies on queue expiration to free the queue.
>>
>> While RFC 8200 section 4.5 does not explicitly mention that the rest of
>> fragments must be discarded, it does not make sense to keep them. The
>> parameter problem message is sent regardless that. In addition, if the
>> sender is able to re-compose the datagram so it is 8 bytes aligned it
>> would qualify as a new whole datagram not fitting into the same fragment
>> queue.
>>
>> The sooner we can free resources during reassembly, the better.
> 
> Ok, but there is another situation we could do the same ?
> 
>   if ((unsigned int)end > IPV6_MAXPLEN) {
>     ...
>     return -1;
> }
> 

Hi Eric,

Yes. That is right. I missed it when reviewing the function. Will handle 
that case in a V2.


Thanks,
Fernando.

