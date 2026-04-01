Return-Path: <netdev+bounces-274075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPROOv0NzWnhZgYAu9opvQ
	(envelope-from <netdev+bounces-274075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:22:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933637A5F2
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C5B630B2791
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3663F54CB;
	Wed,  1 Apr 2026 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dTHjlJVu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PNDeRqVo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dTHjlJVu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PNDeRqVo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE33C7E05
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045187; cv=none; b=PJRo6aydvzz6UP9x/fsn2gVBWQojILLqk8uIJTIjGz01iKvQdAec5XbEBA/0senL1qmGZ+Z4uGzCTayB2HCpy8lylkoSM0hwfOl2PtD6M3rYySBCOUHH/oMmuZmtd3hRso4lCIu/aXsVcYUkkun8qdsD0y++H4RDATfYI0Qkd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045187; c=relaxed/simple;
	bh=cgOTHLSfmsKdkQ9u3WhDNQWskX7aZ9wY/jLmIz93cBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwX54NPNJ487ClsTSWYdi/2B1NhSqln5Ebf/ii3vXjLUJSmPYoVC2MTLGzuxH/cWmeKEk0FqGcKVw1cVmbLW87uITBvqV4TP0TdjPT++l2wSUDDIAmihSLipxVVHl8siaglzxOgmSApiHT/6r6TAgtaNdN0KlucGmtsNaoeyLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dTHjlJVu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PNDeRqVo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dTHjlJVu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PNDeRqVo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 404D84D2E6;
	Wed,  1 Apr 2026 12:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775045184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDkDbFI42s3OiOk4OwXY3OQMfs9TIMwacFsyfAqdjjw=;
	b=dTHjlJVu1LGtaRv8N1L+90RkRFm7ABpV0thPZSTnkqzZM0uOVhyvBNJBgvbv/bArZElqr4
	IZ1cB9uwXbXmHURMKn5iyNseAKR3UChYov/VHhlPnbReHkHtab+TZ6qHV0Z8JlgG63dbQX
	s25XVfDk8nQUg9m5Bt9bvBLrS0JXqxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775045184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDkDbFI42s3OiOk4OwXY3OQMfs9TIMwacFsyfAqdjjw=;
	b=PNDeRqVoX56EX2uNDmFcmqIQzat9Uut/Qx1sokH0YgB2VGNWor2stB8aUzXFXzFah90rLT
	W7tWqS9XArLyPpBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775045184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDkDbFI42s3OiOk4OwXY3OQMfs9TIMwacFsyfAqdjjw=;
	b=dTHjlJVu1LGtaRv8N1L+90RkRFm7ABpV0thPZSTnkqzZM0uOVhyvBNJBgvbv/bArZElqr4
	IZ1cB9uwXbXmHURMKn5iyNseAKR3UChYov/VHhlPnbReHkHtab+TZ6qHV0Z8JlgG63dbQX
	s25XVfDk8nQUg9m5Bt9bvBLrS0JXqxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775045184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDkDbFI42s3OiOk4OwXY3OQMfs9TIMwacFsyfAqdjjw=;
	b=PNDeRqVoX56EX2uNDmFcmqIQzat9Uut/Qx1sokH0YgB2VGNWor2stB8aUzXFXzFah90rLT
	W7tWqS9XArLyPpBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C43A94A0B0;
	Wed,  1 Apr 2026 12:06:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b9YCLT8KzWmTbAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 01 Apr 2026 12:06:23 +0000
Message-ID: <1a22150a-0f4c-412a-9789-ece497d1c92c@suse.de>
Date: Wed, 1 Apr 2026 14:05:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: hsr: require valid EOT supervision
 TLV
To: Luka Gejak <luka.gejak@linux.dev>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
References: <20260401092324.52266-1-luka.gejak@linux.dev>
 <20260401092324.52266-2-luka.gejak@linux.dev>
 <4549f521-6395-4c26-921e-eaead7248a36@suse.de>
 <85A635E3-DF1B-42CA-B552-729943E5C0D5@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <85A635E3-DF1B-42CA-B552-729943E5C0D5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274075-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,linux.dev:email]
X-Rspamd-Queue-Id: 5933637A5F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 1:06 PM, Luka Gejak wrote:
> On April 1, 2026 11:52:02 AM GMT+02:00, Fernando Fernandez Mancera <fmancera@suse.de> wrote:
>> On 4/1/26 11:23 AM, luka.gejak@linux.dev wrote:
>>> From: Luka Gejak <luka.gejak@linux.dev>
>>>
>>> Supervision frames are only valid if terminated with a zero-length EOT
>>> TLV. The current check fails to reject non-EOT entries as the terminal
>>> TLV, potentially allowing malformed supervision traffic.
>>>
>>> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
>>> with a length of zero.
>>>
>>> Reviewed-by: Felix Maurer <fmaurer@redhat.com>
>>> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
>>> ---
>>
>> Hi,
>>
>> This has not been reviewed by Felix. Felix provided his Reviewed-by tag for the v1 which was completely different than this.
>>
>> Revisions of this patch:
>>
>> v3: https://lore.kernel.org/all/20260329112313.17164-4-luka.gejak@linux.dev/
>>
>> v2: https://lore.kernel.org/all/20260326154715.38405-4-luka.gejak@linux.dev/
>>
>> v1: https://lore.kernel.org/all/20260324143503.187642-4-luka.gejak@linux.dev/
>>
>> Are these contributions LLM/AI generated? I believe so based on the email history.
>>
>> AI generated review on rtl8723bs: https://lore.kernel.org/all/B2394A3C-25FD-4CEA-8557-3E68F1F60357@linux.dev/
>>
>> Another AI generated review on rtl8723bs: https://lore.kernel.org/all/3831D599-655E-40B2-9E5D-9DF956013088@linux.dev/
>>
>> Likely an AI generated review on a 1 year old HSR patch: https://lore.kernel.org/all/DHFG26KI6L23.1YCOVQ5SSYMO5@linux.dev/
>>
>> If these are indeed, AI generated contributions or reviews they should be disclosed beforehand. Also there is the Assisted-by: tag. Also note that developer must take full responsibility for the contribution which means understanding it completely.
>>
>> https://docs.kernel.org/process/coding-assistants.html#signed-off-by-and-developer-certificate-of-origin
>>
>> Thanks,
>> Fernando.
> 
> Hi Fernando,
> About the Reviewed-by tag, that was my mistake. I forgot to remove it
> when rebasing. And about AI. I’ve been using it to help format my
> emails and translate them into English since it isn't my native
> language. However, the technical logic and the code itself are my own
> work, written without AI.

So I don't think this change in code is related to rebasing at all. The 
code in this function is identical when comparing net and net-next tree 
so why a rebase would cause such change in the code? Am I missing 
something here?

In addition to that, the new logic does not make any sense. What 
motivated the diff from v3 to v4? All that information is missing.

Thanks,
Fernando.

Should I send v5, and if so, what should I
> do besides stripping the Reviewed-by tag? I've read the documentation
> on coding assistants you linked and will make sure to follow it on the
> next revision.
> Best regards,
> Luka Gejak
> 


