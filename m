Return-Path: <netdev+bounces-237275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43387C483B0
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E21974F0BD2
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70AC2868A6;
	Mon, 10 Nov 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L07r9g/u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ajCS7wHB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L07r9g/u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ajCS7wHB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACACD248F47
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793725; cv=none; b=YlbZ45G6iINA7hrovCt8E7jHr5QMwGJ1Xq84DRZOHSpahabpeLKRnHwoNDHRQOk+EfjyuAImYnPGgBNAHINGyBAWCX2Tv7Eb1z3i6W1iBHoFQSFb8tH9i352Tg/8ml8SHvFllAVTfMmUf2h9bFvk7702A9vRaiMVPVA5uGbG6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793725; c=relaxed/simple;
	bh=FN8PJNNFcjUPFFsJs0n3S89M+sTD+u0bOToF10lMv/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faI5xFCaODXFnFreR2XOnB2qIsjac1NdpVssQ4nydITMxyieeZxfkc4iHw81MEgeSlp5mSWxyEPCcpbu982ntqMRm7GHV8v1ZJ5ezKGmZV5CX6x7Ik4B95sxpvTpK9JDS8VyAliYhlCSUIPTW9HrieX9pnkwLkMijjbt78+dmRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L07r9g/u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ajCS7wHB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L07r9g/u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ajCS7wHB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B94A21FB4E;
	Mon, 10 Nov 2025 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762793719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDwvy1KrQpsGFFbI5MqDqPr+2S6nAnQlxlYATLgWh40=;
	b=L07r9g/u2q2IhXJM7eO5VHt8GvFJCxdXA1oSUX2qVHadCniWxOSrXYOCs2uOUT7GOrt8h3
	KViLS/e9GbLAIZjFTctWue/ksLKpSm86Bv8dUP7THJDJ62PChtSC3xepIA83n1+i3RHw+U
	9mwg7wdKxMN6PD53PE5iIMNX89lRkB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762793719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDwvy1KrQpsGFFbI5MqDqPr+2S6nAnQlxlYATLgWh40=;
	b=ajCS7wHB4cYYIFpjuFOg//7mdawXRNwa3oZzgZqlh+3mlnNoVs5Hrug7KbRVrDOAYuBikO
	QSyRRSxM6M3tQ7Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762793719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDwvy1KrQpsGFFbI5MqDqPr+2S6nAnQlxlYATLgWh40=;
	b=L07r9g/u2q2IhXJM7eO5VHt8GvFJCxdXA1oSUX2qVHadCniWxOSrXYOCs2uOUT7GOrt8h3
	KViLS/e9GbLAIZjFTctWue/ksLKpSm86Bv8dUP7THJDJ62PChtSC3xepIA83n1+i3RHw+U
	9mwg7wdKxMN6PD53PE5iIMNX89lRkB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762793719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDwvy1KrQpsGFFbI5MqDqPr+2S6nAnQlxlYATLgWh40=;
	b=ajCS7wHB4cYYIFpjuFOg//7mdawXRNwa3oZzgZqlh+3mlnNoVs5Hrug7KbRVrDOAYuBikO
	QSyRRSxM6M3tQ7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A5D2144C7;
	Mon, 10 Nov 2025 16:55:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y9DzFvcYEmmDIgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 10 Nov 2025 16:55:19 +0000
Message-ID: <768cbcab-a172-4fe8-9c08-6550f5e12420@suse.de>
Date: Mon, 10 Nov 2025 17:54:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ipv6_route flags RTF_ADDRCONF and RTF_PREFIX_RT are not cleared
 when static on-link routes are added during IPv6 address configuration
To: Garri Djavadyan <g.djavadyan@gmail.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, 1117959@bugs.debian.org,
 carnil@debian.org
References: <ba807d39aca5b4dcf395cc11dca61a130a52cfd3.camel@gmail.com>
 <0df1840663483a9cebac9f3291bc2bd59f2b3c39.camel@gmail.com>
 <20251018013902.67802981@phoenix.lan> <aPzkVzX77z9CMVyy@eldamar.lan>
 <a25e2b7e899b9af7d25ea82f3a553fcc32c12052.camel@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <a25e2b7e899b9af7d25ea82f3a553fcc32c12052.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80



On 10/25/25 11:21 PM, Garri Djavadyan wrote:
> On Sat, 2025-10-25 at 16:53 +0200, Salvatore Bonaccorso wrote:
>> Hi Garri,
>>
>> On Sat, Oct 18, 2025 at 01:39:02AM -0700, Stephen Hemminger wrote:
>>> On Thu, 16 Oct 2025 00:12:40 +0200
>>> Garri Djavadyan <g.djavadyan@gmail.com> wrote:
>>>
>>>> Hi Everyone,
>>>>
>>>> A year ago I noticed a problem with handling ipv6_route flags
>>>> that in
>>>> some scenarios can lead to reachability issues. It was reported
>>>> here:
>>>>
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=219205
>>>>
>>>>
>>>> Also it was recently reported in the Debian tracker after
>>>> checking if
>>>> the latest Debian stable is still affected:
>>>>
>>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1117959
>>>>
>>>>
>>>> Unfortunately, the Debian team cannot act on the report because
>>>> no one
>>>> from the upstream kernel team has confirmed if the report in the
>>>> upstream tracker is valid or not. Therefore, I am checking if
>>>> anyone
>>>> can help confirm if the observed behavior is indeed a bug.
>>>>
>>>> Many thanks in advance!
>>>>
>>>> Regards,
>>>> Garri
>>>>
>>>
>>> Linux networking does not actively use kernel bugzilla.
>>> I forward the reports to the mailing list, that is all.
>>> After than sometimes developers go back and update bugzilla
>>> but it is not required or expected.
>>
>> Garri, best action would likely be to really post your full report on
>> netdev directly.
>>
>> Regards,
>> Salvatore
> 
> 
> Thank you for your suggestions Stephen and Salvatore.
> 
> Below is the full report that was originally posted to the kernel
> bugzilla a year ago. It is still reproducible with fresher kernels.
> 
> -----BEGIN REPORT-----
> I noticed that the ipv6_route flags RTF_ADDRCONF and RTF_PREFIX_RT are
> not cleared when static on-link routes are added during IPv6 address
> configuration, and it leads to situations when the kernel updates the
> static on-link routes with expiration time.
> 

This is indeed a bug, I have a patch already and I am doing some testing 
before sending it to net.git. I hope it can be sent tomorrow.

Thanks,
Fernando.

