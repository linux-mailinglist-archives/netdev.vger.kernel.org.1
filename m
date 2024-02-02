Return-Path: <netdev+bounces-68487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8633284703A
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86D71C241AF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C16140783;
	Fri,  2 Feb 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qWcjWi3A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sa9oFaAB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qWcjWi3A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sa9oFaAB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633614077A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876728; cv=none; b=TIzXEohbEdAJNoKH5JO9J/dkV35h3QK4aiieFq3v02AsFzqelp/yyDu8htwJIgFKqL5qQRbUmTGJ+CrjCzaaHzWIW2U8ewDGghhsht6xtnYLA/1k2DyI/zCt8y2smSbwnrPxsfD+eknbC96x2SRMT80898u/8KTnmaJWOK8C+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876728; c=relaxed/simple;
	bh=e3ZnNNIWuBU/EFI+HVMYi9/5id2kl2QSlW2J4FvWeO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxEz/6adoRtergKjSRMR4Tph1sknxYvg1ZJftKSI9HTpjo1s6WDkKqX9oZpJtFjWZsyVNauHD+6udFGb5n7yArvSw7a9MbdSqUwo2SAo9DzYnnwTW3nRQsiXXUHlfgl95JLWwlIYU9dfSRuIToyRYvVefx4gx9ZVg2Lo3rT64Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qWcjWi3A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sa9oFaAB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qWcjWi3A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sa9oFaAB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AEF891F786;
	Fri,  2 Feb 2024 12:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706876724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVr9kcBdxoRJnBBzvIZPReDAQxlpaCyjtd2pjoG/VDY=;
	b=qWcjWi3AfhhHFdSAXkxKZd7wW32IiWniA7EW9nDbxJ4+oNGb7ixHL5DobJX3J81qPyPz7X
	9roO3PXbMUfuorHBWogP9W7tewWmOHvQjysGQrk3XZH+w4fji/5tlpq+2ZF4ZYUul1j3dF
	BzhDJwInT3mBRLhDXEb3LWuIre2WRxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706876724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVr9kcBdxoRJnBBzvIZPReDAQxlpaCyjtd2pjoG/VDY=;
	b=sa9oFaABoBMQJUyxc7C3UyeoupN1N/M3+fsMMvJUiO2pOix7SXld+gP4/J1vy1W6U41ZgU
	+qPSM/cNUm9oXlDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706876724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVr9kcBdxoRJnBBzvIZPReDAQxlpaCyjtd2pjoG/VDY=;
	b=qWcjWi3AfhhHFdSAXkxKZd7wW32IiWniA7EW9nDbxJ4+oNGb7ixHL5DobJX3J81qPyPz7X
	9roO3PXbMUfuorHBWogP9W7tewWmOHvQjysGQrk3XZH+w4fji/5tlpq+2ZF4ZYUul1j3dF
	BzhDJwInT3mBRLhDXEb3LWuIre2WRxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706876724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVr9kcBdxoRJnBBzvIZPReDAQxlpaCyjtd2pjoG/VDY=;
	b=sa9oFaABoBMQJUyxc7C3UyeoupN1N/M3+fsMMvJUiO2pOix7SXld+gP4/J1vy1W6U41ZgU
	+qPSM/cNUm9oXlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62F4413A58;
	Fri,  2 Feb 2024 12:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d2O7FDTfvGUyfwAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Fri, 02 Feb 2024 12:25:24 +0000
Message-ID: <5fa65887-1f56-4470-bc99-383fe7e3f47b@suse.de>
Date: Fri, 2 Feb 2024 15:23:48 +0300
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
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <913e0c6bb6114fdfaa74073fc8b6c2ee@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.38
X-Spamd-Result: default: False [-1.38 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-0.09)[64.45%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[ACULAB.COM,networkplumber.org,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO



On 2/2/24 14:32, David Laight wrote:
> From: Stephen Hemminger
>> Sent: 31 January 2024 16:14
> 
>>
>> On Wed, 31 Jan 2024 07:41:07 -0500
>> Denis Kirjanov <kirjanov@gmail.com> wrote:
>>
>>> @@ -893,7 +893,7 @@ int main(int argc, char *argv[])
>>>
>>>  	sun.sun_family = AF_UNIX;
>>>  	sun.sun_path[0] = 0;
>>> -	sprintf(sun.sun_path+1, "ifstat%d", getuid());
>>> +	snprintf(sun.sun_path+1, sizeof(sun.sun_path), "ifstat%d", getuid());
>>
>> If you are changing the line, please add spaces around plus sign
> 
> Isn't the size also wrong - needs a matching '- 1'.

I don't think it's wrong, it's just the size of the target buffer which is
UNIX_PATH_MAX bytes.


> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
> 

