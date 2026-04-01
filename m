Return-Path: <netdev+bounces-274119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIfdBM0kzWlkaQYAu9opvQ
	(envelope-from <netdev+bounces-274119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:59:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 852E737BBAF
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6AAB31BAC54
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A7143E48D;
	Wed,  1 Apr 2026 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DO6Prvv0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yln3XnMd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DO6Prvv0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yln3XnMd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9743DA29
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051064; cv=none; b=DN9uekQhORCsnGzy2XTqtUiMGs0hPp7E/dN6JAU9zjBRJuHMRnekCL2/GHEmR18f3KuMcKuhWlPbSqYWNpSi/5B9CwMgN069DC8RKx7Wo2xDcvdAbcF1Hi4BH7BwDEq9zyUC+ct0EYuwA8kTpidFjSVPLSzE0o0pVllRnvRFZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051064; c=relaxed/simple;
	bh=FEvOs4M2nRwCaa3ggLEnB5z5OfkaYYLVVu3sqa1lkig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sxi0XGI9urQOKgupk+7VVwi4D2xEg8yh87BxcRmDP84X/oOmEgYoEMHfitX+bOReOTsNJBcsLlP+KBHP09ZN7c7z5vLIYs5fUHaUGCQhy+Ee6J1rBlZb9mXy1poFdtYTUdk1YoYj28b0Z7avcMqFr5qou+QvknN1legZqcgUZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DO6Prvv0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yln3XnMd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DO6Prvv0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yln3XnMd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 154C15C15E;
	Wed,  1 Apr 2026 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775051058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0IgB63WmD+iO5YjsM6yIvpUDaT1GSBH7oZp9qPPI9k=;
	b=DO6Prvv00U47qQC8Fo6MIUI6uqVtPuOMu/M4jA3Di8hng85zoqMu6Mp1KyzOyxaHHG34EP
	ePRvQAA07Y3+/L1DUBFk7kRshHBYN78fEs3Djx5A/LUBdNAbr6mjqFX4EXp3aGJrMNiw6n
	kvtphgPfd7phIdZNJDWPCEyxIzGNnso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775051058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0IgB63WmD+iO5YjsM6yIvpUDaT1GSBH7oZp9qPPI9k=;
	b=yln3XnMdbCg7Fs42QELVgU6V6D3OZm+QbG8QkQlrGvv2oi8NuIHkxuhVghRKySjsY9errF
	DKrg5cPb/31Gc5DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DO6Prvv0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yln3XnMd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775051058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0IgB63WmD+iO5YjsM6yIvpUDaT1GSBH7oZp9qPPI9k=;
	b=DO6Prvv00U47qQC8Fo6MIUI6uqVtPuOMu/M4jA3Di8hng85zoqMu6Mp1KyzOyxaHHG34EP
	ePRvQAA07Y3+/L1DUBFk7kRshHBYN78fEs3Djx5A/LUBdNAbr6mjqFX4EXp3aGJrMNiw6n
	kvtphgPfd7phIdZNJDWPCEyxIzGNnso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775051058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0IgB63WmD+iO5YjsM6yIvpUDaT1GSBH7oZp9qPPI9k=;
	b=yln3XnMdbCg7Fs42QELVgU6V6D3OZm+QbG8QkQlrGvv2oi8NuIHkxuhVghRKySjsY9errF
	DKrg5cPb/31Gc5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BD614A0B0;
	Wed,  1 Apr 2026 13:44:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DiHsHjEhzWlpVQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 01 Apr 2026 13:44:17 +0000
Message-ID: <8cf382ce-b110-4758-9de4-8944ba980ca3@suse.de>
Date: Wed, 1 Apr 2026 15:44:16 +0200
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
 <1a22150a-0f4c-412a-9789-ece497d1c92c@suse.de>
 <7540A920-76E7-4768-9E62-6666D0FECFA9@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <7540A920-76E7-4768-9E62-6666D0FECFA9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274119-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 852E737BBAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 3:31 PM, Luka Gejak wrote:
> On April 1, 2026 2:05:49 PM GMT+02:00, Fernando Fernandez Mancera <fmancera@suse.de> wrote:
>> On 4/1/26 1:06 PM, Luka Gejak wrote:
>>> On April 1, 2026 11:52:02 AM GMT+02:00, Fernando Fernandez Mancera <fmancera@suse.de> wrote:
>>>> On 4/1/26 11:23 AM, luka.gejak@linux.dev wrote:
>>>>> From: Luka Gejak <luka.gejak@linux.dev>
>>>>>
>>>>> Supervision frames are only valid if terminated with a zero-length EOT
>>>>> TLV. The current check fails to reject non-EOT entries as the terminal
>>>>> TLV, potentially allowing malformed supervision traffic.
>>>>>
>>>>> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
>>>>> with a length of zero.
>>>>>
>>>>> Reviewed-by: Felix Maurer <fmaurer@redhat.com>
>>>>> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
>>>>> ---
>>>>
>>>> Hi,
>>>>
>>>> This has not been reviewed by Felix. Felix provided his Reviewed-by tag for the v1 which was completely different than this.
>>>>
>>>> Revisions of this patch:
>>>>
>>>> v3: https://lore.kernel.org/all/20260329112313.17164-4-luka.gejak@linux.dev/
>>>>
>>>> v2: https://lore.kernel.org/all/20260326154715.38405-4-luka.gejak@linux.dev/
>>>>
>>>> v1: https://lore.kernel.org/all/20260324143503.187642-4-luka.gejak@linux.dev/
>>>>
>>>> Are these contributions LLM/AI generated? I believe so based on the email history.
>>>>
>>>> AI generated review on rtl8723bs: https://lore.kernel.org/all/B2394A3C-25FD-4CEA-8557-3E68F1F60357@linux.dev/
>>>>
>>>> Another AI generated review on rtl8723bs: https://lore.kernel.org/all/3831D599-655E-40B2-9E5D-9DF956013088@linux.dev/
>>>>
>>>> Likely an AI generated review on a 1 year old HSR patch: https://lore.kernel.org/all/DHFG26KI6L23.1YCOVQ5SSYMO5@linux.dev/
>>>>
>>>> If these are indeed, AI generated contributions or reviews they should be disclosed beforehand. Also there is the Assisted-by: tag. Also note that developer must take full responsibility for the contribution which means understanding it completely.
>>>>
>>>> https://docs.kernel.org/process/coding-assistants.html#signed-off-by-and-developer-certificate-of-origin
>>>>
>>>> Thanks,
>>>> Fernando.
>>>
>>> Hi Fernando,
>>> About the Reviewed-by tag, that was my mistake. I forgot to remove it
>>> when rebasing. And about AI. I’ve been using it to help format my
>>> emails and translate them into English since it isn't my native
>>> language. However, the technical logic and the code itself are my own
>>> work, written without AI.
>>
>> So I don't think this change in code is related to rebasing at all. The code in this function is identical when comparing net and net-next tree so why a rebase would cause such change in the code? Am I missing something here?
>>
>> In addition to that, the new logic does not make any sense. What motivated the diff from v3 to v4? All that information is missing.
>>
>> Thanks,
>> Fernando.
>>
>> Should I send v5, and if so, what should I
>>> do besides stripping the Reviewed-by tag? I've read the documentation
>>> on coding assistants you linked and will make sure to follow it on the
>>> next revision.
>>> Best regards,
>>> Luka Gejak
>>>
>>
> 
> Hi Fernando,
> These 2 patches were in the same patch series as 2 other patches.
> Then, when rebasing to edit 3rd patch in original patch series(3/4), I
> forgot to remove the Reviewed-by tag(I ran git commit --amend
> --no-edit). Then I separated 1st 2 and 2nd 2 patches into separate
> series (one for net and other for net-next) because I was instructed
> to do so by Jakub Kicinski. His email:
>> I think that patches 1 and 2 need to go to net with a Fixes tag.
>> They look like run of the mill bug fixes. 3 and 4 are logical
>> fixes and change behavior so net-next makes sense.
>>

This is not addressing my concern. I am not complaining that it went 
into a separate series. That makes sense. The v3 version of the patch 
"net: hsr: require valid EOT supervision TLV" is now something 
completely different but the commit message is the same.

v3: https://lore.kernel.org/all/20260329112313.17164-4-luka.gejak@linux.dev/

I could guess the reason is that in order to make sure the last TLV is a 
EOT TLV with 0 length but all that explanation is missing on the commit 
message.

>> FWIW AI has something to say about patch 3, I did not investigate:
>> https://sashiko.dev/#/patchset/20260329112313.17164-2-luka.gejak@linux.dev
>> -- 
>> pw-bot: cr


