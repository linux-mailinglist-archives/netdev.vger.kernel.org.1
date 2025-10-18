Return-Path: <netdev+bounces-230670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE865BECD0B
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 12:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2381419A711F
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 10:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74881283FC5;
	Sat, 18 Oct 2025 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yG5/9uuw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BbWJ9btR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yG5/9uuw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BbWJ9btR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FBB354ADC
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 10:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760782271; cv=none; b=GHdM/j/MCOJlO/zy3znck2IkG8Ek9H69WQ0PlVxQU6Ie6sHVseY5PZrrT1bPZBwC8MQBo++BDdAo/11JxyPTL/2NTBnWB3LbPU7EfhBNF2ludyXf4M80TktpjH7JzmEsM8qGxrQNjL+BW0utKuYlFn1IguBsR2eyYRi5V5haI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760782271; c=relaxed/simple;
	bh=wRisja7exUNghd9MfnAongKFRiA2fBBj04LCvjD42Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asP80opvOr4e3880MVDD82jxt7K/ClK0xnrKD/OC4BJQWailQVK2m/aUU3kQvnS7ciwPhHcFpiZXDpV6pfB60MQ4iW8+Qvj62EwMdWDXmyduPGQUIxxNn/EO+7iLmCzIULjBqfM0QFCLLxOBhdtirefUeFPfv3IqgubusxHjU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yG5/9uuw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BbWJ9btR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yG5/9uuw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BbWJ9btR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 315C421D76;
	Sat, 18 Oct 2025 10:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760782265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WXY1l/cPJMx9BuYODo4AfCJmueQbYYaLeJ7r5bzFjc=;
	b=yG5/9uuwSuhbQZnk18IYsOEl29jBe3u3Pv9a+SUf0OAApr70rcnwXgt+3GC2cX6E3A/zfj
	mVMlgctxo6WJbOjlxdpNCqZke7bMhv/d+DXIrjox+hq9OKwGbYxQSJ0ZTM4XF9XgsTy+bp
	cXqsuv8doge6uEmZ31cWsVe4oCJv7Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760782265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WXY1l/cPJMx9BuYODo4AfCJmueQbYYaLeJ7r5bzFjc=;
	b=BbWJ9btRhYZmrBPeKY6G85MfMaEp8lM7H9PtEXcHRuGchftSPnIDMzBtH+l2DWNSPmtKnx
	Jys+9w/18h7nZkDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760782265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WXY1l/cPJMx9BuYODo4AfCJmueQbYYaLeJ7r5bzFjc=;
	b=yG5/9uuwSuhbQZnk18IYsOEl29jBe3u3Pv9a+SUf0OAApr70rcnwXgt+3GC2cX6E3A/zfj
	mVMlgctxo6WJbOjlxdpNCqZke7bMhv/d+DXIrjox+hq9OKwGbYxQSJ0ZTM4XF9XgsTy+bp
	cXqsuv8doge6uEmZ31cWsVe4oCJv7Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760782265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WXY1l/cPJMx9BuYODo4AfCJmueQbYYaLeJ7r5bzFjc=;
	b=BbWJ9btRhYZmrBPeKY6G85MfMaEp8lM7H9PtEXcHRuGchftSPnIDMzBtH+l2DWNSPmtKnx
	Jys+9w/18h7nZkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8A4F1386E;
	Sat, 18 Oct 2025 10:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3bTcKLhn82h6LwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 18 Oct 2025 10:11:04 +0000
Message-ID: <6d67143b-533d-450b-abb1-2db0857f563f@suse.de>
Date: Sat, 18 Oct 2025 12:10:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/hsr: add interlink to fill_info output
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jan Vaclav <jvaclav@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20251015101001.25670-2-jvaclav@redhat.com>
 <20251016155731.47569d75@kernel.org>
 <6f9742f5-8889-449d-8354-572d2f8a711b@suse.de>
 <20251017151733.785c138a@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20251017151733.785c138a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30



On 10/18/25 12:17 AM, Jakub Kicinski wrote:
> On Fri, 17 Oct 2025 12:17:21 +0200 Fernando Fernandez Mancera wrote:
>> On 10/17/25 12:57 AM, Jakub Kicinski wrote:
>>> On Wed, 15 Oct 2025 12:10:02 +0200 Jan Vaclav wrote:
>>>> Currently, it is possible to configure the interlink port, but no
>>>> way to read it back from userspace.
>>>>
>>>> Add it to the output of hsr_fill_info(), so it can be read from
>>>> userspace, for example:
>>>>
>>>> $ ip -d link show hsr0 12: hsr0: <BROADCAST,MULTICAST> mtu ... ...
>>>> hsr slave1 veth0 slave2 veth1 interlink veth2 ...
>>>
>>> Not entirely cleat at a glance how this driver deals with the slaves
>>> or interlink being in a different netns, but I guess that's a pre-
>>> existing problem..
>>>    
>>
>> FTR, I just did a quick round of testing and it handles it correctly.
>> When moving a port to a different netns it notifies NETDEV_UNREGISTER -
>> net/hsr/hsr_main.c handles the notification removing the port from the
>> list. If the port list is empty, removes the hsr link.
>>
>> All good or at least as I would expect.
> 
> Did you try to make the slave/interlink be in a different namespace
> when HSR interface is created? It should be possible with the right
> combination of NEWLINK attributes, and that's the config I was
> particularly concerned about..
> 

Ugh, right. It is completely messed up indeed. I am handling this in a 
patch series. Thanks you Jakub.

