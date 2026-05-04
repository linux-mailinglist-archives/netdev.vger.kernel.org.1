Return-Path: <netdev+bounces-283911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGzTJqy1+Gn1zAIAu9opvQ
	(envelope-from <netdev+bounces-283911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:05:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 373174C0632
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31F7F30098A5
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5113DF004;
	Mon,  4 May 2026 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bSrjcPlR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K4mUmkz8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lagbQCMn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="072XkwW4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA63D6CA4
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906924; cv=none; b=T6fDrNca8GPmPBNS1ypqkYXKC5zQRjvVqy9q5oFqiE0uDD7qIBuhp4d29Uo45JftSWo3N19yO898xttgr6TOv3eUydnxu+/bmo4KstbU8ZItn+anoJTpgKB6abngl58tR55XV05CdQse+rt1VagWs98ZgkL0Z2xyPZ5HPJp5OLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906924; c=relaxed/simple;
	bh=gHEEu3i2lAtUdjFzSmA8zzRy2/2/gwHXx0B3ugYNibc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceGi4zDFiGkLSZLTrWBVxmyCdL3T2saDqHYjHGqGYgChhcZSAbleVEsydvNUSTKOZHBhCWylShYrQSuPSvNlB9ZmkuAkFSh1qAa0PYI1gsQM+CjIGwn4CUXJm23vdbmX5NS9pLb8KvuXyZT84zbaF/r7uJf9fxH+34Otmj+PaZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bSrjcPlR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K4mUmkz8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lagbQCMn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=072XkwW4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8B2C6B348;
	Mon,  4 May 2026 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777906916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzXieXDgOJjo8lmnMnCqsJRnjai8Jc2VOGJUwi7SIl4=;
	b=bSrjcPlR4q/a8r6B/EEPlXO1Mvp+wQaDUdEC2zSp5QcFmI3MbK6dLNrqCXg8ydj+IPUXnF
	534LOqknEbqAsM9Ep6CNAbTfDt/y4rENuXM1sRp74vxDTKx5h9Ie8bQCDEmya1fa72IrnM
	7ULpf/dZtN+6H0MAQRB3BfteHTc8foU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777906916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzXieXDgOJjo8lmnMnCqsJRnjai8Jc2VOGJUwi7SIl4=;
	b=K4mUmkz8uhtvO3nqvImnUPqHI59bnGwGbINxtxklHI152BIFjXz24a4td5S7RBxJDOTclz
	196tNb7QlT3bx1Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lagbQCMn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=072XkwW4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777906911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzXieXDgOJjo8lmnMnCqsJRnjai8Jc2VOGJUwi7SIl4=;
	b=lagbQCMnOh4IJMSRdsfdyNHzcMOn7YEYyDnZp35W/dS8IUMO9V5OZ2ioBUYwozBhEdfuFn
	5+4vafjWIcmNFm/lGKp/IiRTp4c/+V18LNDcv8/RCCdC28jsH7LA6JghLY5dv+nJi0+Ox2
	UMTe6pEGzWp5Grlx3BSQV7R3pAj1Ks4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777906911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzXieXDgOJjo8lmnMnCqsJRnjai8Jc2VOGJUwi7SIl4=;
	b=072XkwW4ZYiMOk+eEVCKvvBrKxlRauIep5SX1Wq2RWJx0fG1v384ITfXNuHF8vIHxgUInQ
	gn1PAaxFQaYPUhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3309C593A3;
	Mon,  4 May 2026 15:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g0uKCd+0+GnDeAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 04 May 2026 15:01:51 +0000
Message-ID: <d299649e-d01e-451a-b604-76c8662f1ecc@suse.de>
Date: Mon, 4 May 2026 17:01:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ipv6: default IPV6_SIT to m
To: Alyssa Ross <hi@alyssa.is>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20260503192515.290900-2-hi@alyssa.is>
 <5f676587-fcdd-4704-9523-07a7fd98455a@suse.de> <878q9zdz6s.fsf@alyssa.is>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <878q9zdz6s.fsf@alyssa.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 373174C0632
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283911-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,alyssa.is:email]

On 5/4/26 4:30 PM, Alyssa Ross wrote:
> Fernando Fernandez Mancera <fmancera@suse.de> writes:
> 
>> On 5/3/26 9:25 PM, Alyssa Ross wrote:
>>> This basically defaulted to m until recently, since IPV6 defaulted to
>>> m.  Since IPV6 was changed to a boolean with a default of y, IPV6_SIT
>>> started defaulting to built-in as well.  This results in a surprise
>>> sit0 device by default for defconfig (and defconfig-derived config)
>>> users at boot.  For me, this broke an (admittedly non-robust) script.
>>> Preserve the behaviour of most configs by avoiding building this
>>> module, that's probably overall seldom used compared to IPv6 as a
>>> whole, into the kernel.
>>>
>>> Fixes: 309b905deee59 ("ipv6: convert CONFIG_IPV6 to built-in only and clean up Kconfigs")
>>> Signed-off-by: Alyssa Ross <hi@alyssa.is>
>>
>> Hi, I am not sure about this. IPV6_SIT was already defaulting to 'y' for
>> most distributions (except for ARM). Sure, if you had CONFIG_IPV6=m then
>> CONFIG_IPV6_SIT was defaulting to 'm'.
>>
>> Hm. Maybe we can aim this for net-next tree instead of net? I just don't
>> think this is a fix but a change in behavior. FWIW, it makes sense to me
>> to have this as a module by default.
>>
>> Let's see what do others think.
> 
> Yes, it appears you're right.  I had only tested on ARM.  In that case,
> perhaps it make sense to instead set this to m in the arm64 defconfig, to
> preserve the previous situation, but I can also see the value in
> reducing platform discongruity by letting it change to y on arm64 too.

Changing it on arm64 defconfig would make sense to me too. We should 
probably visit other configs that might be in the same situation. That 
in my opinion would qualify a net tree fix as you proposed initially.


