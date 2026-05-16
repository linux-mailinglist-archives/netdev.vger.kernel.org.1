Return-Path: <netdev+bounces-288595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHzxDqoWCGorYwMAu9opvQ
	(envelope-from <netdev+bounces-288595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 09:03:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6C455A8CC
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 09:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EA713018ADE
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 07:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F844371887;
	Sat, 16 May 2026 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GkCWD3sm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DPIqoM9N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GkCWD3sm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DPIqoM9N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2614935E1CD
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778914961; cv=none; b=lbPozncSLstQm9qY8if3DxzB1HUz/k21uIfnmP5k3rSE2q88uFrNFvKWKF8pbhnVLx78MnV7aIbY82NkOEgPQrECA6UYlZ917SaLJplSOiQ+BR0Sv340YTW+nYYgpws3rlsrYzWkFbBSEpeZLzq+C3C5/eiHBktvqT4t52RyZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778914961; c=relaxed/simple;
	bh=tMMZNlzAyJhWGPORawbViec/lbgCUwgopIP8U5sACYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqqX0TUu0DwHragZk3KuaECw21I0eRTY8x6ZE7rH0ek5pBqpEOh5xPckQTtAcBvrjvF72cXpsn5NCwIYQj/BYq3h1BaMM+pI1vuwvZ+vocuXNdBowm2HSdN+4Un32lt90fgbAnMmPID8cQ8g95tVpwwDWiyq3FDmDmnM86sDnFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GkCWD3sm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DPIqoM9N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GkCWD3sm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DPIqoM9N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1B25618B2;
	Sat, 16 May 2026 07:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778914956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fx1HImtpNbf9r3+ZuscqsV8lfMcF7aUDitALcVW1KCU=;
	b=GkCWD3smq2JUjVeH4m9BungaGkxVsmfqMzqxrlXizkYIFIMbiChlvVDgAjZ6oHxSzDnI2J
	o2xwrL1acR7zMg/0ky2YPZWNk9xYox3plDxOZBXNK0YcsmS+UOBqTVp4DSKO8A5jM6m8Lp
	Iz9p47s37NvxwdWrR5jo5BGSFnGPb9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778914956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fx1HImtpNbf9r3+ZuscqsV8lfMcF7aUDitALcVW1KCU=;
	b=DPIqoM9NAv/DHCfeAvUQ0fLyVMsRc1ylU97Fbh2HJFC0S9x8iSRAeysSpMyf6fhKSpNr7A
	Gl7+aN4LT6NrVoDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778914956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fx1HImtpNbf9r3+ZuscqsV8lfMcF7aUDitALcVW1KCU=;
	b=GkCWD3smq2JUjVeH4m9BungaGkxVsmfqMzqxrlXizkYIFIMbiChlvVDgAjZ6oHxSzDnI2J
	o2xwrL1acR7zMg/0ky2YPZWNk9xYox3plDxOZBXNK0YcsmS+UOBqTVp4DSKO8A5jM6m8Lp
	Iz9p47s37NvxwdWrR5jo5BGSFnGPb9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778914956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fx1HImtpNbf9r3+ZuscqsV8lfMcF7aUDitALcVW1KCU=;
	b=DPIqoM9NAv/DHCfeAvUQ0fLyVMsRc1ylU97Fbh2HJFC0S9x8iSRAeysSpMyf6fhKSpNr7A
	Gl7+aN4LT6NrVoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA076593A8;
	Sat, 16 May 2026 07:02:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v4gCKosWCGotawAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 16 May 2026 07:02:35 +0000
Message-ID: <f5cae72f-93c7-41d7-b7db-2b60281afb72@suse.de>
Date: Sat, 16 May 2026 09:02:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 net-next v4] selftests: net: add test for IPv4 devconf
 netlink notifications
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net
References: <20260510081528.5257-1-fmancera@suse.de>
 <20260510081528.5257-3-fmancera@suse.de> <20260513193544.47970cb8@kernel.org>
 <bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de>
 <20260514162429.366b94c9@kernel.org>
 <f528360c-18b3-46e5-8ba8-88f921203716@suse.de>
 <20260515181623.5a44140e@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260515181623.5a44140e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: CC6C455A8CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288595-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/16/26 3:16 AM, Jakub Kicinski wrote:
> On Fri, 15 May 2026 10:02:50 +0200 Fernando Fernandez Mancera wrote:
>>>> No, AFAIU, iproute2 does not expose devconf settings. The main user of
>>>> IFLA_INET_CONF are netlink libraries and other userspace tools that
>>>> heavily rely on netlink operations like NetworkManager, nmstate, nispor,
>>>> rust-netlink..
>>>
>>> Isn't this ip netconf ?
>>>    
>>
>> Oh sorry, I should have clarified it. ip netconf only shows/query them
>> but it cannot set them AFAICS.
>>
>> Usage: ip netconf show [ dev STRING ]
> 
> Oh, fun. anyway, you gotta find a better way. Or just give up on the
> selftest, the YNL hack is too ugly to live
> 

Fair, let me see what I can do. Otherwise, Paolo as you requested the 
selftest, would it be acceptable for you to drop it given the situation? 
I looking for alternatives anyway :-)

Thanks!
Fernando.

