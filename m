Return-Path: <netdev+bounces-174457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E455A5ECE4
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE84174990
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 07:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9351FCCFD;
	Thu, 13 Mar 2025 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SzH5XY+v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yKfVreDz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SzH5XY+v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yKfVreDz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605671FCCE4
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850525; cv=none; b=awiDeSB5TxNFH4h9vAMlRgKHjtwAv4VCKWZVsBRYqxCNpnPzB78FSnjFnLcMXlllQWVcrnUmDqlkaYVubPql9W/5pEry6Jou3+uC+KMOkfRoT0KUdyj8fTTAtkXF8Bxs4CK1FGL3qNIfwrs0Q/HU9TLbmKOatVf9S/AQdwrzaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850525; c=relaxed/simple;
	bh=U5zqIXsTZyG72+UlJE/PxPO2CiBCfh4l0Yrx/LsruUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1dW2CrklRlOoihe2VSLwTqlufLI92IGtT/UpZMzSasLLJLLUhSyMGi+lcCQu3Sd8ehG2lhmWnrupxlLBwQKaq2P3qSB7k2Bq+9en++SrtYfTALgwDr35lAh9EP2u3TiedQeNsH5yXqOxs5KrAsgv2elHGbw9m/0CtQ+DMFB/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SzH5XY+v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yKfVreDz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SzH5XY+v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yKfVreDz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D3971F388;
	Thu, 13 Mar 2025 07:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741850522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeipWfL+CB6I9hZ1UBEBbSd2YSX9nkJswbCQ+DEf4p0=;
	b=SzH5XY+vwTkm8AK+wY+D0oqaI3Iwgd1pwj3yfxb2ibLhQoOp3mIXAQPtYqk+w/f0ZUf3Vp
	ST4Z9r/2ZtbfYRoVgIlKqSRZm729UDGYd2qeQ489skGxBghx7Jw0r9k9d+xLZcUKM4fmVk
	evQq4VSUtIJAlySz8Mf54qZyYhaTy2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741850522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeipWfL+CB6I9hZ1UBEBbSd2YSX9nkJswbCQ+DEf4p0=;
	b=yKfVreDzBE/V0mR5jU/0ldV69ZKZ4+w2ImMJh7rS6Yt1VKlTGAQ3nZ9ZtPBItOwyJYrw3+
	2u93Zg0F5AA+R+Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SzH5XY+v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yKfVreDz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741850522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeipWfL+CB6I9hZ1UBEBbSd2YSX9nkJswbCQ+DEf4p0=;
	b=SzH5XY+vwTkm8AK+wY+D0oqaI3Iwgd1pwj3yfxb2ibLhQoOp3mIXAQPtYqk+w/f0ZUf3Vp
	ST4Z9r/2ZtbfYRoVgIlKqSRZm729UDGYd2qeQ489skGxBghx7Jw0r9k9d+xLZcUKM4fmVk
	evQq4VSUtIJAlySz8Mf54qZyYhaTy2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741850522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeipWfL+CB6I9hZ1UBEBbSd2YSX9nkJswbCQ+DEf4p0=;
	b=yKfVreDzBE/V0mR5jU/0ldV69ZKZ4+w2ImMJh7rS6Yt1VKlTGAQ3nZ9ZtPBItOwyJYrw3+
	2u93Zg0F5AA+R+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 059C1137BA;
	Thu, 13 Mar 2025 07:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sufcOpmH0mdEEQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 13 Mar 2025 07:22:01 +0000
Message-ID: <9af6dff3-adce-40f8-8649-282212acad9e@suse.de>
Date: Thu, 13 Mar 2025 08:22:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
To: Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
References: <20250310143544.1216127-1-willy@infradead.org>
 <20250311111511.2531b260@kernel.org>
 <4fc21641-e258-474b-9409-4949fe2fda2d@suse.de>
 <Z9BsCZ_aOozA5Al9@casper.infradead.org> <Z9EgGzPxjOFTKoLj@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z9EgGzPxjOFTKoLj@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D3971F388
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/12/25 06:48, Christoph Hellwig wrote:
> On Tue, Mar 11, 2025 at 04:59:53PM +0000, Matthew Wilcox wrote:
>> So I have two questions:
>>
>> Hannes:
>>   - Why does nvme need to turn the kvec into a bio rather than just
>>     send it directly?
> 
> It doensn't need to and in fact does not.
> 
Errm ... nvmf_connect_admin_queue()/nvmf_connect_io_queue() does ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

