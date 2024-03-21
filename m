Return-Path: <netdev+bounces-81019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E78885881
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 12:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79A71F226FB
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 11:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46DA58AD1;
	Thu, 21 Mar 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KhyIQyUA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U9ulRhMS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zpkgrTRC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qgKWbwMS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87FCC2E6
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021397; cv=none; b=EYet9vSccXLmgUlv3k0KZr0ihysah9lP+HTUQ+K47P333tfWprQKPsK0Htu5bZ8NApD4vl2suakXioLrG5y0+aczORyd3/9DP7vKZEDWoNvLsujoN+F1jnLXndIB1OayUIqZxc4q6RyKfgP2BC7zC7+kZhN9J9/s1Pln4L7EYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021397; c=relaxed/simple;
	bh=Q20saGg+g/JAMy3oB2NKi7fPuxcIg5/O0Co5t+q2DVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLV59XqXL924O6dH9rNcsysadnHwJnW9NV56k+sAHUB7uydwj32Rcytz/NoLqwwlaE6fjdaHZPrUOwh/LB+CNR5dEOiRf2i5jDrlTfCpYEvVWoY5+m8q/Gw6mJ1qyiqNPfw+6h3KyaQfHL1J/My0N8PKA0i7/4rGtzm6SzHRnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KhyIQyUA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U9ulRhMS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zpkgrTRC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qgKWbwMS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 019E85CD54;
	Thu, 21 Mar 2024 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711021394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNVa3x/CVT4NV0DTFPj3VdV1FpsRQ3awxkq5MoaLxKs=;
	b=KhyIQyUAtLoqyhnx7XuBozUtOt2x2kAI6wTV6JbQBcW0yy8BZHefFk1+/KCmsMaPfiJkjf
	n94d6LLn5R/vgmVATPxq5SYDkioMCORGSs5cBp2vtA9jqYqgOClWua+NFhhwkSkj6keq/L
	4qmKI52L41Y4xG2/thm2s/JY09hnQkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711021394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNVa3x/CVT4NV0DTFPj3VdV1FpsRQ3awxkq5MoaLxKs=;
	b=U9ulRhMSARUK/cJWGDUhZLgdRSbxe9VLYtFs0gDZ9NGIy84IP58Adwgq7niNM6QPjQ8eR7
	jv1jRYfHM4dkxLAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711021393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNVa3x/CVT4NV0DTFPj3VdV1FpsRQ3awxkq5MoaLxKs=;
	b=zpkgrTRC3GSEY3lagDt+Urjec3fu3MQ15x9vO1JEiBx+8cOUh7MJVClNLRVd4o4kj7ZWOJ
	TzhPBwzxKlBQ8eYwr7qI1CTGI/zkhQfHxJdaNWKHDrs+D6hlYg8rgKZcL8inD8PJCGUzkr
	HZe+wPTX5euH0o+UB6lO1m37TVhHibo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711021393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNVa3x/CVT4NV0DTFPj3VdV1FpsRQ3awxkq5MoaLxKs=;
	b=qgKWbwMSq1rSecM6v/DpWblfWvrP8PJq5QJC4GZ1d8vVu1ysoJHHd3/iHOEn4etb6+RtxD
	PVcwVNxMl1/6jxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F0E213976;
	Thu, 21 Mar 2024 11:43:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TF9/I1Ad/GUGNwAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Thu, 21 Mar 2024 11:43:12 +0000
Message-ID: <2e1c3333-7060-4224-80d6-4437afa4af01@suse.de>
Date: Thu, 21 Mar 2024 14:43:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding UDP-Lite deprecation and removal
Content-Language: en-US
To: Lynne <dev@lynne.ee>, Netdev <netdev@vger.kernel.org>
Cc: Kuniyu <kuniyu@amazon.com>,
 Willemdebruijn Kernel <willemdebruijn.kernel@gmail.com>
References: <Nt8pHPQ--B-9@lynne.ee> <NtV7B0y--3-9@lynne.ee>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <NtV7B0y--3-9@lynne.ee>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zpkgrTRC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qgKWbwMS
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.26 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_ALL(0.00)[];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.26)[73.54%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,lynne.ee:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[amazon.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.26
X-Rspamd-Queue-Id: 019E85CD54
X-Spam-Flag: NO



On 3/21/24 11:29, Lynne wrote:
> Mar 17, 2024, 01:34 by dev@lynne.ee:
> 
>> Hello,
>>
>> UDP-Lite was scheduled to be removed in 2025 in commit
>> be28c14ac8bbe1ff due to a lack of real-world users, and
>> a long-outstanding security bug being left undiscovered.
>>
>> I would like to open a discussion to perhaps either avoid this,
>> or delay it, conditionally.
>>
> 
> Ping. To be clear, I am offering to maintain it if the current
> maintainers do not have time to.
> 
> Should I send a patch to remove the warning? I wanted to
> know the opinions of the ones who maintain/deprecated
> the code first.Otherwise it doesn't make sense to maintain it if it's going to be deleted :)
BTW if yo have a list of tests to implement please share to avoid stepping on toes 

> 

