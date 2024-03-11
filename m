Return-Path: <netdev+bounces-79170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9036687817F
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 15:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C351F2362B
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741893FBAD;
	Mon, 11 Mar 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0hm4noYM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YzdGOfXf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0hm4noYM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YzdGOfXf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D63D993
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710166837; cv=none; b=KSyIyOb/tpLI+fwrqvZMApPXQHLFwNi3QzZvt46/1+totj4/lYzHJ3j8kH/xoyaOv/bgQQ7jQadi+iy26++zRsFb65lbsALsH9cuXb8Fs5tqNr9zzqjJDIeMrziqOrKk9CnugEXT6qbZwmFk754/X27SmY1kNtz1+uX1CDtKAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710166837; c=relaxed/simple;
	bh=hXWNF0GxhRMKCxdZ2uE0LU72vRNOJwOImsi6K2omx7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1ptj1er8eZYV7Zy+LzA0QKO84DwCkk4l+OLxEFZftAahpBMg1brz8Od+NaHI/KM4t6KKWfexQ1WtZbOPjM7Jqtfps0Od7ZTkPQo0I1t00g/FUEKCH5vgCsDmgkf2rpVn8hAspQZO4HuAeHQFXYTXAvj+Wmc93yglkHLZAYwH8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0hm4noYM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YzdGOfXf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0hm4noYM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YzdGOfXf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D601334D30;
	Mon, 11 Mar 2024 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710166832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CM2pCHrQdr3+5aEgD55FdaZHO6j7BGKnuPcYF6cJMCk=;
	b=0hm4noYMzg+o9SYnyZfB7aCObdYihvVggg0Bp2EjA+tsJact+y9UuKHQK79Jl3fbJvBjPm
	eWjQjD2qOstaEbHYhW1/pHC89JEK1uq3XZz1N/LgbolWusRmhDHTqohXJezuyXCyIjCl2e
	2pYvO6ygo2O3U/2cEuxQSUYIqsQhcrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710166832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CM2pCHrQdr3+5aEgD55FdaZHO6j7BGKnuPcYF6cJMCk=;
	b=YzdGOfXfQUtRRjEUNk84xnJVlBOKSsUHPRMbtn5drgv/zrHPw8cvxxlkdTQneA0+w7kWuA
	mKCb57h8sP0P1WAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710166832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CM2pCHrQdr3+5aEgD55FdaZHO6j7BGKnuPcYF6cJMCk=;
	b=0hm4noYMzg+o9SYnyZfB7aCObdYihvVggg0Bp2EjA+tsJact+y9UuKHQK79Jl3fbJvBjPm
	eWjQjD2qOstaEbHYhW1/pHC89JEK1uq3XZz1N/LgbolWusRmhDHTqohXJezuyXCyIjCl2e
	2pYvO6ygo2O3U/2cEuxQSUYIqsQhcrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710166832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CM2pCHrQdr3+5aEgD55FdaZHO6j7BGKnuPcYF6cJMCk=;
	b=YzdGOfXfQUtRRjEUNk84xnJVlBOKSsUHPRMbtn5drgv/zrHPw8cvxxlkdTQneA0+w7kWuA
	mKCb57h8sP0P1WAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7979D136BA;
	Mon, 11 Mar 2024 14:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qQkFGjAT72V2aQAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Mon, 11 Mar 2024 14:20:32 +0000
Message-ID: <4c58ab4f-e1c8-4267-a4ba-518986d03125@suse.de>
Date: Mon, 11 Mar 2024 17:20:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ss: fix the compiler warning
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, Denis Kirjanov <kirjanov@gmail.com>,
 stephen@networkplumber.org
Cc: netdev@vger.kernel.org
References: <20240307105327.2559-1-dkirjanov@suse.de>
 <cd48d41f-b9ee-4906-a806-760284a3eeb4@kernel.org>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <cd48d41f-b9ee-4906-a806-760284a3eeb4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.42
X-Spamd-Result: default: False [-1.42 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-0.13)[67.47%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url,suse.de:email];
	 FREEMAIL_TO(0.00)[kernel.org,gmail.com,networkplumber.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO



On 3/9/24 21:22, David Ahern wrote:
> On 3/7/24 3:53 AM, Denis Kirjanov wrote:
>> the patch fixes the following compiler warning:
>>
>> ss.c:1064:53: warning: format string is not a string literal [-Wformat-nonliteral]
>>         len = vsnprintf(pos, buf_chunk_avail(buffer.tail), fmt, _args);
>>                                                            ^~~
>> 1 warning generated.
>>     LINK     ss
>>
>> Fixes: e3ecf0485 ("ss: pretty-print BPF socket-local storage")
>> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
>> ---
>>  misc/ss.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/misc/ss.c b/misc/ss.c
>> index 87008d7c..038905f3 100644
>> --- a/misc/ss.c
>> +++ b/misc/ss.c
>> @@ -1042,6 +1042,7 @@ static int buf_update(int len)
>>  }
>>  
>>  /* Append content to buffer as part of the current field */
>> +__attribute__((format(printf, 1, 0)))
>>  static void vout(const char *fmt, va_list args)
>>  {
>>  	struct column *f = current_field;
> 
> The error message does not align with the change - and it does not fix
> the warning.

since vout is not a variadic arguments function I put 0 into the 3rd argument since we 
already have a check in out function.
doc[0] states that:
"For functions where the arguments are not available to be checked (such as vprintf),
specify the third parameter as zero. 
In this case the compiler only checks the format string for consistency." 

[0]: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html
> 
> pw-bot: cr
> 

