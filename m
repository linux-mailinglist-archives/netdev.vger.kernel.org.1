Return-Path: <netdev+bounces-296684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zkExFyT/JmqSpQIAu9opvQ
	(envelope-from <netdev+bounces-296684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:43:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC8D65959C
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:42:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TvOG3flg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2rMQYrbm;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TvOG3flg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2rMQYrbm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296684-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296684-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89A14300B9EC
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 17:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C06368D60;
	Mon,  8 Jun 2026 17:42:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BFD367B6A
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 17:42:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940524; cv=none; b=OdTc36K6CKi0Z3tMgnbiVT7dFXWJn3MDJpBEkqeZ+lEKT947twr/Nxf/9YPpUbfSKbA14i4b6l8fB04VgmWLsNxf82Zcg3zqhwnA+quy/2sV5ye4R8xUUicDnRiArM6mOEn5gfQ3AJwmm0hmx25nuL3d1JLqtvSOSDZK8OH4tJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940524; c=relaxed/simple;
	bh=BzoNkzAvNhDh69dYfkurv4pgngpj1kWvlPE8Eka7Ruo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBvHR0t/hyq2+Pe5DsBtFelJTVjXsPz1UDGrs/1NhhIYBn3sRqMZ2vqS6+nb0cYwLTf+P5tOKmAv2ZGS2bupyzynvtoM5Ep9w+/zSzfvicH1iQ9Yp9V9u3Br7e35957VSvvyvFylxS61/ToE6a6CczYs23ZYQ682INlU3N5dJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TvOG3flg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2rMQYrbm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TvOG3flg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2rMQYrbm; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B14C16A9FA;
	Mon,  8 Jun 2026 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780940521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3tCh0jPJNjOk0TbCgUCupOL4KmSVywuiVe8aP07Buk=;
	b=TvOG3flgSAIFfwT6yUuMgzHv0re9yIQqM18BEfXr7R3DQwGWn2DGrJ8qtXOXPqzVnO5f7s
	fj69PjnGsRTYAHGEzAjYUeaiT26MCMeLMPA7bfxin4ZMPgzQTq9vJSyue8wGlTavZfKK0P
	+EDNq886/edQKDpio5PXzJyQvLrL8xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780940521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3tCh0jPJNjOk0TbCgUCupOL4KmSVywuiVe8aP07Buk=;
	b=2rMQYrbmWjkXqF3WZe25/2KhhTh9bmnq5GAEB2Xwc4keltcM9yVakPR2Zxfij+x4/wopAU
	FhM/Vv5jxPnIr4CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780940521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3tCh0jPJNjOk0TbCgUCupOL4KmSVywuiVe8aP07Buk=;
	b=TvOG3flgSAIFfwT6yUuMgzHv0re9yIQqM18BEfXr7R3DQwGWn2DGrJ8qtXOXPqzVnO5f7s
	fj69PjnGsRTYAHGEzAjYUeaiT26MCMeLMPA7bfxin4ZMPgzQTq9vJSyue8wGlTavZfKK0P
	+EDNq886/edQKDpio5PXzJyQvLrL8xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780940521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3tCh0jPJNjOk0TbCgUCupOL4KmSVywuiVe8aP07Buk=;
	b=2rMQYrbmWjkXqF3WZe25/2KhhTh9bmnq5GAEB2Xwc4keltcM9yVakPR2Zxfij+x4/wopAU
	FhM/Vv5jxPnIr4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F68F779A7;
	Mon,  8 Jun 2026 17:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vXaRCOn+JmpEAgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 08 Jun 2026 17:42:01 +0000
Message-ID: <c57b3480-3049-4e1c-8f26-4073a96cfec8@suse.de>
Date: Mon, 8 Jun 2026 19:41:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3 net-next v5] ipv4: centralize devconf sysctl handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
 dsahern@kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>
References: <20260607110123.5939-1-fmancera@suse.de>
 <20260608090333.21c94721@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260608090333.21c94721@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296684-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:nicolas.dichtel@6wind.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FC8D65959C

On 6/8/26 6:03 PM, Jakub Kicinski wrote:
> On Sun,  7 Jun 2026 13:01:21 +0200 Fernando Fernandez Mancera wrote:
>> The logic for handling IPv4 devconf sysctls is scattered. Notification
>> and cache flushes are managed in devinet_conf_proc(), while a separate
>> ipv4_doint_and_flush() function and DEVINET_SYSCTL_FLUSHING_ENTRY macro
>> is used for properties that solely require a cache flush.
> 
> Hi Fernando!
> 
> Do you have the necessary iproute2 patches pushed out somewhere?
> I'll pull them in the CI to make sure the test works.
> 

Oh sorry, I thought this was using iproute2-next.

Yes, feel free to find it either here [0] or pick it from [1].

[0] https://lore.kernel.org/netdev/20260601143242.6729-1-fmancera@suse.de/

[1] 
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=fdb064bf64e5df738f5f823a11f315340679d336

Thanks,
Fernando.

