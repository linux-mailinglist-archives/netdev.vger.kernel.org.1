Return-Path: <netdev+bounces-294812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mMlHEstIIGqm0AAAu9opvQ
	(envelope-from <netdev+bounces-294812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:31:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC8F63936A
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:31:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UgGFWYIh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4UaNvA7p;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UgGFWYIh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4UaNvA7p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294812-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294812-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6146C308D11F
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02DC3ADB99;
	Wed,  3 Jun 2026 15:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2730C629
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:22:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500170; cv=none; b=M4UBQUzBAMIPliKABW6me2QcJCdW/fzMan0MpktEOTAfky1MHueV++Dxlk/08e0lBewkxtDBRfJRGSXVH6cW06iarKGk49umaG8agwSnHII3UgBgAgsmLKwI0D+c3kcFQ79CAhEMunXbG4iZrz+l5idNHiwn94cmR6q1Zw2Msfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500170; c=relaxed/simple;
	bh=YEV4TtqnDytvbO7kTFFg+RZn+X5bh8A4BSGy7/5foVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGWh4ZeQkOTSOkk4S1Lqcw4Ny6VlFdIiKknUvrgo2y0PAUxgKTMQ0U5O8DyDDtPtaz2QOmVRfxpax9/76Gc8a9GziNdSwjyUzeuRoY+fPDzba0EEiJ2kj7nXnlXKhyV2xaSht4+emSnYvYXbCRkOMcJuLCi0re6lYQeQ0nttw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UgGFWYIh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4UaNvA7p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UgGFWYIh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4UaNvA7p; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 863FA6779A;
	Wed,  3 Jun 2026 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780500167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHhNPkKQeQ+MJIJ/UWfXuFDcGod5+43wDOvluxj1u0E=;
	b=UgGFWYIha/Fdv/sYXl3gDiWcOVSsUlc+EwGFaQRwlfMElS9X9iSjRPrcVAw1WF7ZYaQt01
	dEu2pBTPBdSoCaHenycUI6Z9m3y0EROwzYw/USPJ03hiZS9Fs4+Vca7eAlavDu9bWu3DrK
	kBjecbn0hA1yo0B2Mef+8RlEJvWdv4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780500167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHhNPkKQeQ+MJIJ/UWfXuFDcGod5+43wDOvluxj1u0E=;
	b=4UaNvA7psF9ouuFMucGn2IEhdTtngMsN3eDCpqCb0aRTN+6h1GXF5U19Ch4P7QvbypLP8f
	ygArbXEusm3rJXDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780500167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHhNPkKQeQ+MJIJ/UWfXuFDcGod5+43wDOvluxj1u0E=;
	b=UgGFWYIha/Fdv/sYXl3gDiWcOVSsUlc+EwGFaQRwlfMElS9X9iSjRPrcVAw1WF7ZYaQt01
	dEu2pBTPBdSoCaHenycUI6Z9m3y0EROwzYw/USPJ03hiZS9Fs4+Vca7eAlavDu9bWu3DrK
	kBjecbn0hA1yo0B2Mef+8RlEJvWdv4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780500167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHhNPkKQeQ+MJIJ/UWfXuFDcGod5+43wDOvluxj1u0E=;
	b=4UaNvA7psF9ouuFMucGn2IEhdTtngMsN3eDCpqCb0aRTN+6h1GXF5U19Ch4P7QvbypLP8f
	ygArbXEusm3rJXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23691779A9;
	Wed,  3 Jun 2026 15:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D/LQBcdGIGrSMgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 03 Jun 2026 15:22:47 +0000
Message-ID: <78284e03-c868-4ae4-a74f-f8c98e2a3945@suse.de>
Date: Wed, 3 Jun 2026 17:22:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iplink: add support for setting IPv4
 devconf parameters
To: David Ahern <dsahern@kernel.org>, nicolas.dichtel@6wind.com,
 netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
References: <20260601143242.6729-1-fmancera@suse.de>
 <6365ef1e-d62d-4b2d-8e41-526881bbbe37@6wind.com>
 <491689b6-95f9-4e32-ae70-fdae464af353@suse.de>
 <0bc2dcd4-b29e-4a82-8d1b-5170e78c2d74@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <0bc2dcd4-b29e-4a82-8d1b-5170e78c2d74@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294812-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:nicolas.dichtel@6wind.com,m:netdev@vger.kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,6wind.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAC8F63936A

On 6/3/26 5:18 PM, David Ahern wrote:
> On 6/3/26 7:24 AM, Fernando Fernandez Mancera wrote:
>> On 6/3/26 2:50 PM, Nicolas Dichtel wrote:
>>> Le 01/06/2026 à 16:32, Fernando Fernandez Mancera a écrit :
>>>> Currently, modifying IPv4 interface configuration parameters requires
>>>> interacting with sysctl (/proc/sys/net/ipv4/conf/*). While
>>>> ip-netconf exists for monitoring these values, there has been no native
>>>> way to set them directly through iproute2.
>>>>
>>>> This patch introduces the support for that via 'inet' at the 'ip link
>>>> set'. It uses IFLA_INET_CONF netlink attribute to set the parameter.
>>>>
>>>> Example to enable forwarding on an interface:
>>>>
>>>> ip link set dev enp8s0 inet forwarding on
>>>>
>>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>> Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>>>
>>> Do you plan to add the ipv6 part also?
>>
>> Yes, it is cooking but I want to get merged IPv4 first.
>>
> 
> If I merge the ipv4 patch today that means you are signing up to send
> patches for ipv6 set and then ipv4 and ipv6 show in detailed device
> dump. All of that in the next 2 weeks before 7.1 is released. Just want
> to make sure we are clear on expectations.
> 

Sounds good to me. I am already working on it.

Thanks.

> With respect to this patch, the usage is getting long and wading through
> all of the inet and then inet6 options is going to be a challenge.
> 
> Stephen: opinions on location and details? Should the list even be in
> the usage vs only the man page? ie., usage just has `[ inet <devconf
> options> ]` (and similar for inet6)? If the all of the options stay
> listed in the usage they should be in alphabetical order (and added
> after the existing gro_max_size line?).

