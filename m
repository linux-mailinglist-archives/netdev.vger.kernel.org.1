Return-Path: <netdev+bounces-80349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD8687E7AD
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537A51C212D6
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2B2EB1D;
	Mon, 18 Mar 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K0XK407e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5yLeD3ON";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K0XK407e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5yLeD3ON"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1F2EAE0
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758993; cv=none; b=c2Kb7AXrEu0GEqrCLWm8C4FpvnoE+k7eGYTfY0zih4kNBZrmdxLFL1sX12iR3ywAoArbzTsxVTdyQLfLJTbW5VNfbiC5PHTE3sjTycaJJelgpDvAK2U/fcQJ+2Vi7VQnE8hi/MagFSlgBNKHxaUl6gXGUEMXR8jfd/2vui1jR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758993; c=relaxed/simple;
	bh=PX47G8jHQYNhXzqSZigKXnwxArY8VZVMbIbJ4EAtkRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eY+amhWJbEG2yUHmPHUS6bEoE3iR9/3kUJ7H450YuXNGdOBdwluaAasuEJFerDFGzlio4mllzvRsboUixVkaEJVQB+eRugpnk/hs+Cefd+/f5apwX+2CeHSjEIDkqazQDQk2ErxZ0EdsXUS8jUCmwY7BDjDmCJPOX7/c4dH5N+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K0XK407e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5yLeD3ON; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K0XK407e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5yLeD3ON; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95E895C3E3;
	Mon, 18 Mar 2024 10:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710758989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJhZiNZiutYHKc9nL7GwXBz7Rig/pEDMnyjXk+zMzYk=;
	b=K0XK407emtQ89GKV6Mapmfc0gJtGFzlCkWTSjP/KxbxWs8XWkDV6BDEmzEsY9uFIxvM4eQ
	gf125KVK8RuzbcjUbJ2UDd+a71vbanitQYiOWH5IKmHySKcIefEjcGs1RkAy/QcCRfD6fG
	lhwnjispSQ+lQqfzPKZgb2aKEQIWyKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710758989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJhZiNZiutYHKc9nL7GwXBz7Rig/pEDMnyjXk+zMzYk=;
	b=5yLeD3ONueq+ki2FM9H3lEjkZTOlSlHxIoBvVcVLtmPoDXV6EEC9U94SoKS8nD6z1QDCaD
	F0JYZXSCiP1QhYAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710758989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJhZiNZiutYHKc9nL7GwXBz7Rig/pEDMnyjXk+zMzYk=;
	b=K0XK407emtQ89GKV6Mapmfc0gJtGFzlCkWTSjP/KxbxWs8XWkDV6BDEmzEsY9uFIxvM4eQ
	gf125KVK8RuzbcjUbJ2UDd+a71vbanitQYiOWH5IKmHySKcIefEjcGs1RkAy/QcCRfD6fG
	lhwnjispSQ+lQqfzPKZgb2aKEQIWyKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710758989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJhZiNZiutYHKc9nL7GwXBz7Rig/pEDMnyjXk+zMzYk=;
	b=5yLeD3ONueq+ki2FM9H3lEjkZTOlSlHxIoBvVcVLtmPoDXV6EEC9U94SoKS8nD6z1QDCaD
	F0JYZXSCiP1QhYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B7AB1389C;
	Mon, 18 Mar 2024 10:49:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B0wjC00c+GW9aQAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Mon, 18 Mar 2024 10:49:49 +0000
Message-ID: <b89274d1-e8c9-4f2c-a6ce-998129b1b699@suse.de>
Date: Mon, 18 Mar 2024 13:49:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding UDP-Lite deprecation and removal
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Lynne <dev@lynne.ee>,
 Netdev <netdev@vger.kernel.org>
Cc: Kuniyu <kuniyu@amazon.com>,
 Willemdebruijn Kernel <willemdebruijn.kernel@gmail.com>
References: <Nt8pHPQ--B-9@lynne.ee>
 <658523650c342e7ffd2fcc136ac950baca6cf565.camel@redhat.com>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <658523650c342e7ffd2fcc136ac950baca6cf565.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: 7.70
X-Spam-Flag: NO
X-Spamd-Bar: +++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K0XK407e;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5yLeD3ON
X-Spamd-Result: default: False [7.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_ALL(0.00)[];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[41.60%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[amazon.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: *******
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 95E895C3E3



On 3/18/24 13:36, Paolo Abeni wrote:
> On Sun, 2024-03-17 at 01:34 +0100, Lynne wrote:
>> UDP-Lite was scheduled to be removed in 2025 in commit
>> be28c14ac8bbe1ff due to a lack of real-world users, and
>> a long-outstanding security bug being left undiscovered.
>>
>> I would like to open a discussion to perhaps either avoid this,
>> or delay it, conditionally.
> 
> I'm not very familiar to the deprecation process, but I guess this kind
> of feedback is the sort of thing that could achieve delaying or avoid
> the deprecation.
> 
> What will help more IMHO is someone stepping in to actually maintain
> the protocol. It should not be an high load activity, but a few things
> would be required: e.g. writing self-tests and ensuring that 3rd party
> changes would not break it. And reviewing patches - but given the
> protocol history that would probably be once in a lifetime.

That's sounds good enough to try

> 
> Cheers,
> 
> Paolo
> 
> 

