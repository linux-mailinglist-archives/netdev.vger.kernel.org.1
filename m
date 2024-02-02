Return-Path: <netdev+bounces-68521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E648847126
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26AE28E202
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3736E4644E;
	Fri,  2 Feb 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XFSArmQm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+KZX5wHl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XFSArmQm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+KZX5wHl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF345C07
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880533; cv=none; b=mGdnakdrjYZy7a58H+hIPGg7/uP9U/t3857bfWUWo9uHQNdWwzjAqgfEkzKAZr1aZ13tx2susjG0pjc9KLrr8pxPxqRTqXBTK27s2GyWvKFgZHjRuSeF7xy6KXjopQJYZHYfC56WU3CQjeAMXtB4GV5wNZj8SolOEW2f5hSkBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880533; c=relaxed/simple;
	bh=xjDHb/nl37vfEOTHGO2vmnqCzsnrEDBY/Rf1/nL4rog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPhz1l3pKLmUquXSHi8xdGij7nyoIFU/jYUv9ABSFTaSe1XG1MlVJEcRp6/qGPRf3EmX5BhqDy/DCwdalToWA4gyA1lT3HX3aXGIkIXGMDfa9KDFx3Uwe1kNgCQ/BIkTld1yELq/VKN+KuZOdmKmAk/4t5jDZJ48HchiVs8ryzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XFSArmQm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+KZX5wHl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XFSArmQm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+KZX5wHl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B37671F78A;
	Fri,  2 Feb 2024 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706880529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9/C1p7haXcEz+iJb96LprsTgumnZH4E464AtrJ4rLw=;
	b=XFSArmQmU3ICb8xXeEgX8mjxlq4wsNbEZSZnrw7DtcqVxah/NSdYHQww3bekCULxeNWqiC
	bCuYz4cm7wii04yVZWs/VJj7rmFQ1n6L5Sdn7l631alcEalpeTEwzMVx+gIpg/+OtRY1bI
	6nw44TsYXIg9B9dE4rvA5bDYIg7dzOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706880529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9/C1p7haXcEz+iJb96LprsTgumnZH4E464AtrJ4rLw=;
	b=+KZX5wHlw+JI0TPkauJ/ycNZp9Q50mwEZpJI+itSVsu6BhcaJuQqyXqnrVR9jRvU+kOHGD
	R46Da5eGMd3+EADw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706880529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9/C1p7haXcEz+iJb96LprsTgumnZH4E464AtrJ4rLw=;
	b=XFSArmQmU3ICb8xXeEgX8mjxlq4wsNbEZSZnrw7DtcqVxah/NSdYHQww3bekCULxeNWqiC
	bCuYz4cm7wii04yVZWs/VJj7rmFQ1n6L5Sdn7l631alcEalpeTEwzMVx+gIpg/+OtRY1bI
	6nw44TsYXIg9B9dE4rvA5bDYIg7dzOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706880529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9/C1p7haXcEz+iJb96LprsTgumnZH4E464AtrJ4rLw=;
	b=+KZX5wHlw+JI0TPkauJ/ycNZp9Q50mwEZpJI+itSVsu6BhcaJuQqyXqnrVR9jRvU+kOHGD
	R46Da5eGMd3+EADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6ACEE139AB;
	Fri,  2 Feb 2024 13:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 68X2FhHuvGUFEQAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Fri, 02 Feb 2024 13:28:49 +0000
Message-ID: <631a90a4-24fb-48a5-b533-131042751821@suse.de>
Date: Fri, 2 Feb 2024 16:28:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] ifstat: convert sprintf to snprintf
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 'Stephen Hemminger' <stephen@networkplumber.org>,
 Denis Kirjanov <kirjanov@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240131124107.1428-1-dkirjanov@suse.de>
 <20240131081418.72770d85@hermes.local>
 <913e0c6bb6114fdfaa74073fc8b6c2ee@AcuMS.aculab.com>
 <5fa65887-1f56-4470-bc99-383fe7e3f47b@suse.de>
 <d2e9ab2c4df04f0e8f12b623366123eb@AcuMS.aculab.com>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <d2e9ab2c4df04f0e8f12b623366123eb@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XFSArmQm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+KZX5wHl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.60 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[ACULAB.COM,networkplumber.org,gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.10)[65.36%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.60
X-Rspamd-Queue-Id: B37671F78A
X-Spam-Flag: NO



On 2/2/24 16:02, David Laight wrote:
> From: Denis Kirjanov
>> Sent: 02 February 2024 12:24
>>
>> On 2/2/24 14:32, David Laight wrote:
>>> From: Stephen Hemminger
>>>> Sent: 31 January 2024 16:14
>>>
>>>>
>>>> On Wed, 31 Jan 2024 07:41:07 -0500
>>>> Denis Kirjanov <kirjanov@gmail.com> wrote:
>>>>
>>>>> @@ -893,7 +893,7 @@ int main(int argc, char *argv[])
>>>>>
>>>>>  	sun.sun_family = AF_UNIX;
>>>>>  	sun.sun_path[0] = 0;
>>>>> -	sprintf(sun.sun_path+1, "ifstat%d", getuid());
>>>>> +	snprintf(sun.sun_path+1, sizeof(sun.sun_path), "ifstat%d", getuid());
>>>>
>>>> If you are changing the line, please add spaces around plus sign
>>>
>>> Isn't the size also wrong - needs a matching '- 1'.
>>
>> I don't think it's wrong, it's just the size of the target buffer which is
>> UNIX_PATH_MAX bytes.
> 
> But you are starting one byte in.
> So, if the size were 8 the '\0' would be written after the end.
yep, you're right
> 
> Also, to avoid the next patch in a few weeks it should be
> calling scnprintf().
I'll post the next version


> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

