Return-Path: <netdev+bounces-82490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2CB88E5F3
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F18F8B29087
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE406137C26;
	Wed, 27 Mar 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lRo4EXOI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BNhwN7gU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lRo4EXOI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BNhwN7gU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C75D1311A7
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543957; cv=none; b=V29tPxOui3slwVTbOqWzCeS55IonqeGieDg/x/aVLgfr/JTgog7GXe4uW6x5tNLDtMIHLwy5tGYKhzstNExgXOnAVaJjh9E1cs0o9a6x4UpywPS9VdUJvWcUcOq5n4FoZfikmG4ow2wtlTExdAnV68uLmjTmM2cma+3/5SDdZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543957; c=relaxed/simple;
	bh=KJ+oDQrl1z1XncT8uz86fktpl7op/N9UqUP/VBKhPh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vln6EXab5NoD1M15QTuLULiJUnJg8G8FBse40ofzGJNU/ofKdpktvCZqsce0la0lzAJ6THe8BY4noPyhIOPk4J3wBlI8IxFDyepG8P0zQSGbxhNqOCFRlqCozbALC7nZENNfDfxtOr5VFgwsGp9z5rR9AXKSUgSYjOjo7CnLJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lRo4EXOI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BNhwN7gU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lRo4EXOI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BNhwN7gU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04C9B21C16;
	Wed, 27 Mar 2024 12:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711543954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uTJ3ZkxHMF5Lg7sxSMlW6kd+Qw7Xng5HTdbxK7Wof4=;
	b=lRo4EXOIZ0PFCRxj97ASMDb/92D87kAW1uMhrsUyPi3Tb/JtWPRWjSK4rv+YvAJydIVWby
	S8TKicLKe3hgL5/cstTHth+vz1FCcvzJlOFLTmj8yj/X8bzEEXhdkfws9o7OQy75msj8Fu
	uIVfPY5JwPnfzfSy/oPCitnCP37uL4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711543954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uTJ3ZkxHMF5Lg7sxSMlW6kd+Qw7Xng5HTdbxK7Wof4=;
	b=BNhwN7gUTUyBZchNrbOCuZwfLkjsvj84qBA8S45AW8T3PMb+SrJI0oyxpwY2VjTPu/5xkr
	q/4tH6HdOHnKJqAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711543954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uTJ3ZkxHMF5Lg7sxSMlW6kd+Qw7Xng5HTdbxK7Wof4=;
	b=lRo4EXOIZ0PFCRxj97ASMDb/92D87kAW1uMhrsUyPi3Tb/JtWPRWjSK4rv+YvAJydIVWby
	S8TKicLKe3hgL5/cstTHth+vz1FCcvzJlOFLTmj8yj/X8bzEEXhdkfws9o7OQy75msj8Fu
	uIVfPY5JwPnfzfSy/oPCitnCP37uL4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711543954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uTJ3ZkxHMF5Lg7sxSMlW6kd+Qw7Xng5HTdbxK7Wof4=;
	b=BNhwN7gUTUyBZchNrbOCuZwfLkjsvj84qBA8S45AW8T3PMb+SrJI0oyxpwY2VjTPu/5xkr
	q/4tH6HdOHnKJqAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6393713AB3;
	Wed, 27 Mar 2024 12:52:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vJfwFJEWBGZKOAAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Wed, 27 Mar 2024 12:52:33 +0000
Message-ID: <c4e83bff-18a6-4cbd-9412-b1da83f7358e@suse.de>
Date: Wed, 27 Mar 2024 15:52:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Xen NIC driver have page_pool memory leaks
To: Jesper Dangaard Brouer <hawk@kernel.org>, paul@xen.org,
 Arthur Borsboom <arthurborsboom@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Netdev <netdev@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 kda@linux-powerpc.org
References: <CALUcmUncphE8v8j1Xme0BcX4JRhqd+gB0UUzS-U=3XXw_3iUiw@mail.gmail.com>
 <1cde0059-d319-4a4f-a68d-3b3ffeb3da20@kernel.org>
 <857282f5-5df6-4ed7-b17e-92aae0cf484a@xen.org>
 <ba4ac0f4-7a95-4fb2-b128-d7b248e4137a@kernel.org>
Content-Language: en-US
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <ba4ac0f4-7a95-4fb2-b128-d7b248e4137a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.29
X-Spamd-Result: default: False [-1.29 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FREEMAIL_TO(0.00)[kernel.org,xen.org,gmail.com,linaro.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO



On 3/27/24 14:27, Jesper Dangaard Brouer wrote:
> 
> 
> On 25/03/2024 13.33, Paul Durrant wrote:
>> On 25/03/2024 12:21, Jesper Dangaard Brouer wrote:
>>> Hi Arthur,
>>>
>>> (Answer inlined below, which is custom on this mailing list)
>>>
>>> On 23/03/2024 14.23, Arthur Borsboom wrote:
>>>> Hi Jesper,
>>>>
>>>> After a recent kernel upgrade 6.7.6 > 6.8.1 all my Xen guests on Arch
>>>> Linux are dumping kernel traces.
>>>> It seems to be indirectly caused by the page pool memory leak
>>>> mechanism, which is probably a good thing.
>>>>
>>>> I have created a bug report, but there is no response.
>>>>
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=218618
>>>>
>>>> I am uncertain where and to whom I need to report this page leak.
>>>> Can you help me get this issue fixed?
>>>
>>> I'm the page_pool maintainer, but as you say yourself in comment 2 then
>>> since dba1b8a7ab68 ("mm/page_pool: catch page_pool memory leaks") this
>>> indicated there is a problem in the xen_netfront driver, which was
>>> previously not visible.
>>>
>>> Cc'ing the "XEN NETWORK BACKEND DRIVER" maintainers, as this is a driver
>>> bug.  What confuses me it that I cannot find any modules named
>>> "xen_netfront" in the upstream tree.
>>>
>>
>> You should have tried '-' rather than '_' :-)
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/xen-netfront.c
>>
> 
> Looking at this driver, I think it is missing a call to skb_mark_for_recycle().
> 
> I'll will submit at patch for this, with details for stable maintainers.

Please do

> 
> As I think it dates back to v5.9 via commit 6c5aa6fc4def ("xen
> networking: add basic XDP support for xen-netfront"). I think this
> commit is missing a call to page_pool_release_page()
> between v5.9 to v5.14, after which is should have used
> skb_mark_for_recycle().

Hmm, looks like I've missed it  
> 
> Since v6.6 the call page_pool_release_page() were removed (in
> 535b9c61bdef ("net: page_pool: hide page_pool_release_page()") and
> remaining callers converted (in commit 6bfef2ec0172 ("Merge branch
> 'net-page_pool-remove-page_pool_release_page'")).
> 
> This leak became visible in v6.8 via commit dba1b8a7ab68 ("mm/page_pool:
> catch page_pool memory leaks").
> 
> --Jesper
> 

