Return-Path: <netdev+bounces-287871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKZ5EAaTBWoxYwIAu9opvQ
	(envelope-from <netdev+bounces-287871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:16:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9E453FAB7
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD2DF3011786
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB1A38758C;
	Thu, 14 May 2026 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vccfMLmG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tt+LJV9T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vccfMLmG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tt+LJV9T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD63363084
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750210; cv=none; b=MpbSXKfjyKsfxtSEIT0gPmImlEbsN5aOJ7gLBlH+8ihrGzG2kHLiv9gBnpH70v1j9HB8wwGp2ejydlpQdLqee628TrWeglPXkPVQU/JlVH6LLqGmYpGMDy+eR1CzALLl1QNlbEhMI+hKWMneAW4qr976E+0tzbPxyIWTPMYVCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750210; c=relaxed/simple;
	bh=1KKQcCgHleDtajii5IXPAUwKw/SU8OSz6uYGiRUpjRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+XWUshcXCilqGb4k7N9yzH9oPtw3wA5x18W/5CaIu2UvaraW+52nFKpLG0Rwqa/Fa7k5I8s/Mf2KahMloB2pv43f72IQX556ukdShlNadi9XuybLG7i9RQZJc3thwZk5jCfUxz3v+RiApKVVMcOX3TAk1tnL0KKwwcvIRWBeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vccfMLmG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tt+LJV9T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vccfMLmG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tt+LJV9T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3634666D8D;
	Thu, 14 May 2026 09:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778750207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXheNdV7Mv1MJCNf5R+S6H56kcbJwTDSSSRhPTdn7Lk=;
	b=vccfMLmGn0iA2aX6CtT0Llgog1sZ9OjSjNo1+jhiEAnI+D6HIDXYJu7YW9IkrIH8eOjNal
	Pjcb5RxMh+R0J7g2FFT2TEKSWuLn45mmNtY9BuWlgQxQJa/GASIIBYCJZrhNfjLP0tlayN
	5VH5fiXzEMHrZYgdhZ4CU2iYfZC+ra0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778750207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXheNdV7Mv1MJCNf5R+S6H56kcbJwTDSSSRhPTdn7Lk=;
	b=tt+LJV9TJARl4pcSZzWE2qXGl9GbuwrVwV2VSj0Urpn2Y2o2SuV5rq+urRUGD7gXyEH50W
	a4EieNsYlFbwANCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778750207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXheNdV7Mv1MJCNf5R+S6H56kcbJwTDSSSRhPTdn7Lk=;
	b=vccfMLmGn0iA2aX6CtT0Llgog1sZ9OjSjNo1+jhiEAnI+D6HIDXYJu7YW9IkrIH8eOjNal
	Pjcb5RxMh+R0J7g2FFT2TEKSWuLn45mmNtY9BuWlgQxQJa/GASIIBYCJZrhNfjLP0tlayN
	5VH5fiXzEMHrZYgdhZ4CU2iYfZC+ra0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778750207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXheNdV7Mv1MJCNf5R+S6H56kcbJwTDSSSRhPTdn7Lk=;
	b=tt+LJV9TJARl4pcSZzWE2qXGl9GbuwrVwV2VSj0Urpn2Y2o2SuV5rq+urRUGD7gXyEH50W
	a4EieNsYlFbwANCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4686593A9;
	Thu, 14 May 2026 09:16:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6YcjJf6SBWrZeQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 14 May 2026 09:16:46 +0000
Message-ID: <c5ec2140-f0ba-4905-b40e-17ed943db38c@suse.de>
Date: Thu, 14 May 2026 11:16:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3 net-next v4] ipv4: handle devconf post-set actions on
 netlink updates
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>
References: <20260510081528.5257-1-fmancera@suse.de>
 <20260510081528.5257-2-fmancera@suse.de> <20260513193039.7dd435df@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260513193039.7dd435df@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Rspamd-Queue-Id: CC9E453FAB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287871-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 5/14/26 4:30 AM, Jakub Kicinski wrote:
> On Sun, 10 May 2026 10:15:27 +0200 Fernando Fernandez Mancera wrote:
>> -		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem)
>> -			ipv4_devconf_set(in_dev, nla_type(a), nla_get_u32(a));
>> +		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem) {
>> +			int old_value = ipv4_devconf_get(in_dev, nla_type(a));
>> +			int new_value = nla_get_u32(a);
> 
> Hm, what checks if nla_type(a) is in range?

That is handled at inet_validate_link_af(), see:

	if (tb[IFLA_INET_CONF]) {
		err = nla_parse_nested(nested_tb, IPV4_DEVCONF_MAX,
				       tb[IFLA_INET_CONF], inet_devconf_policy,
				       extack);

		if (err < 0)
			return err;
	}

(sorry if the formatting is messed up)

Thanks!
Fernando.

