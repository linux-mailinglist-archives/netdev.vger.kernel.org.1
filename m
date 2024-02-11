Return-Path: <netdev+bounces-70829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E3850AC4
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 19:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E8E1C2039C
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A495CDF2;
	Sun, 11 Feb 2024 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mgFqiFTm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C9IbAMoL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mgFqiFTm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C9IbAMoL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAED5C91E
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707675005; cv=none; b=od3nZLouC4o7qOsWRN8bHT9QxIv40y74/Ahk9zLfT2Cb2QOjnWU0f4nEzO54a+MN7zEuXZZzVXFecH53dOIUPceVNCD87BXKJVniDS07VOtisaK8yIDrfYvI7YoWsUGGZUapcZzvXjFXiwQaNDEmYj/QkAu1/Gu7TyfbXWoRCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707675005; c=relaxed/simple;
	bh=m/BmaoTtn7HsfkahkZm1WJwP6YR7KPTq2eSIa0xEhFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vx2SCswE9NZVFwjCwSzT5XJezOt9ydSej8lFNoi+O5TECDoKZBHQz6eyVg5P/hf6kyHt0l0tg2Y+6lJcn4Jm4+mEUaMlWBbxTefkK8qd7K5h/xp2G4CCXNFnD+xpnju8yOa8PFfXoq8jwcq0yz17xtAJadF3ZVHNvWuvhbl8xaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mgFqiFTm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C9IbAMoL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mgFqiFTm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C9IbAMoL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 02C191FB8B;
	Sun, 11 Feb 2024 18:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707675002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWV9K9mRgg002CAL69aLb/ELpKx+STPaEguUHWY0sMI=;
	b=mgFqiFTmrf9+klTdTBmnjMlSqJGNh7hJvN1LWO+nVlQjyV6TAoclho/NbZmjEOUksjUZcd
	MOdXwCqWEy/zqMwDB7o67QGhfQZeGa24kvc0WxU5lVbqFwLYot58hDrYW48FztkgrfTBoT
	SscFMwI+hfTTSaLWA8VvKC2Ia70rxAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707675002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWV9K9mRgg002CAL69aLb/ELpKx+STPaEguUHWY0sMI=;
	b=C9IbAMoLHUW+ylxkmxtJ2hZWBrb6UxZeRm2xRoQqC55aWi7Fv/plfsxYfHBK2OIrF9Tv5Q
	6D8IqSUoioh8U4AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707675002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWV9K9mRgg002CAL69aLb/ELpKx+STPaEguUHWY0sMI=;
	b=mgFqiFTmrf9+klTdTBmnjMlSqJGNh7hJvN1LWO+nVlQjyV6TAoclho/NbZmjEOUksjUZcd
	MOdXwCqWEy/zqMwDB7o67QGhfQZeGa24kvc0WxU5lVbqFwLYot58hDrYW48FztkgrfTBoT
	SscFMwI+hfTTSaLWA8VvKC2Ia70rxAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707675002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWV9K9mRgg002CAL69aLb/ELpKx+STPaEguUHWY0sMI=;
	b=C9IbAMoLHUW+ylxkmxtJ2hZWBrb6UxZeRm2xRoQqC55aWi7Fv/plfsxYfHBK2OIrF9Tv5Q
	6D8IqSUoioh8U4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B380D13A38;
	Sun, 11 Feb 2024 18:10:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qvV2KHkNyWVUMAAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Sun, 11 Feb 2024 18:10:01 +0000
Message-ID: <1de98d9d-7a7c-4e84-85b8-f28055210ee2@suse.de>
Date: Sun, 11 Feb 2024 21:10:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2] ifstat: convert sprintf to snprintf
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Denis Kirjanov <kirjanov@gmail.com>, netdev@vger.kernel.org
References: <20240202093527.38376-1-dkirjanov@suse.de>
 <20240210123303.4737392e@hermes.local>
 <331c1b3b-4dbe-48e7-9e75-0536528a8868@suse.de>
 <20240211091802.21885973@hermes.local>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240211091802.21885973@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mgFqiFTm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=C9IbAMoL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[34.38%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.50
X-Rspamd-Queue-Id: 02C191FB8B
X-Spam-Flag: NO



On 2/11/24 20:18, Stephen Hemminger wrote:
> On Sun, 11 Feb 2024 11:39:13 +0300
> Denis Kirjanov <dkirjanov@suse.de> wrote:
> 
>> On 2/10/24 23:33, Stephen Hemminger wrote:
>>> On Fri,  2 Feb 2024 04:35:27 -0500
>>> Denis Kirjanov <kirjanov@gmail.com> wrote:
>>>   
>>>> Use snprintf to print only valid data
>>>>
>>>> v2: adjust formatting
>>>>
>>>> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
>>>> ---  
>>>
>>> Tried this but compile failed
>>>
>>> ifstat.c:896:2: warning: 'snprintf' size argument is too large; destination buffer has size 107, but size argument is 108 [-Wfortify-source]
>>>         snprintf(sun.sun_path + 1, sizeof(sun.sun_path), "ifstat%d", getuid());  
>>
>> Right, this is addressed in the patch with scnprintf
>>  
> 
> But I see no need to convert to scnprintf(). Scnprintf is about the return value
> and almost nowhere in iproute2 uses the return value and those that to look at the
> return value are checking for beyond buffer. Plus if you convert to scnprintf you
> lose lots of the fortify and other analyzer checking.

the last line makes sense.

> 
> Bottom line scnprintf() makes sense in kernel but not iproute2.

I'll push the next version of a patch with snprintf then.
Thanks!


