Return-Path: <netdev+bounces-294818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id li+EJpJTIGqH1AAAu9opvQ
	(envelope-from <netdev+bounces-294818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:17:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6826399ED
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:17:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o4I8gxWG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A4APNyNv;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o4I8gxWG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A4APNyNv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294818-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294818-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D69E73385D85
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBE11A680A;
	Wed,  3 Jun 2026 15:30:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27812399354
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:30:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500639; cv=none; b=YknmP2OgL0M9fMVS9nBl6jIv4zTcF4vV3OVdURlifUlHQ3GGtF8wSqniGfKCeomaio1PnqU8XVHHVfpBbRMf4bLryfRZwI71NuaAMhk00DvZcomSn1Xy7Lg2K4ZZF3KZIXiYTFJKBh8Uc0d0LJZ5hV94QyCavAkbGAXzZ2b7Jpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500639; c=relaxed/simple;
	bh=YH8QjehUUHYXfkOR4RyLOOM+FbbCxkFsYCObtfNRgrY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vh9fv5wNZ6qRqCRYvxo0LJHKzgNadBfGWhfIPMUGFomM2HwurXQaPgBawt1aYFHKRkdAvlP5i7XhWcKBtCM2FDlM7chsMa/8o+fMiJcN6K+2QERj7jJMXvaA8jl1DiKUOQgYqT2tG0DP/eGvufUv53NIzePFBldVD0+3PrOVupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o4I8gxWG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A4APNyNv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o4I8gxWG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A4APNyNv; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2712C6AA6B;
	Wed,  3 Jun 2026 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780500634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57At0JKhdOkr3+R8RYksb9H2Pj7UIRMYAWqKjWDhXX4=;
	b=o4I8gxWGpIoZXreFOB/xliyGXxZ0HLZnAMPki4b4mYEQzMfCv+bhtbWXW4R0X6gF6fjFP5
	tLSBIQRtvQPZ6VuUske99pv/UmLSLOBM7lE8Lx6hPA45ezuJhqEMwo0pQSRuRYHERa5FFt
	2ljSS5pnllXz7mrxvHSscHNA6hU2aT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780500634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57At0JKhdOkr3+R8RYksb9H2Pj7UIRMYAWqKjWDhXX4=;
	b=A4APNyNvl++JpI+XhxpH2hcedvPp9FjZO8JCNvpUSUP5B+WOu3Qqh0l/eqfi6du+tSgRJ+
	R4OkKvssd6rGZdCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780500634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57At0JKhdOkr3+R8RYksb9H2Pj7UIRMYAWqKjWDhXX4=;
	b=o4I8gxWGpIoZXreFOB/xliyGXxZ0HLZnAMPki4b4mYEQzMfCv+bhtbWXW4R0X6gF6fjFP5
	tLSBIQRtvQPZ6VuUske99pv/UmLSLOBM7lE8Lx6hPA45ezuJhqEMwo0pQSRuRYHERa5FFt
	2ljSS5pnllXz7mrxvHSscHNA6hU2aT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780500634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57At0JKhdOkr3+R8RYksb9H2Pj7UIRMYAWqKjWDhXX4=;
	b=A4APNyNvl++JpI+XhxpH2hcedvPp9FjZO8JCNvpUSUP5B+WOu3Qqh0l/eqfi6du+tSgRJ+
	R4OkKvssd6rGZdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7F1C779A9;
	Wed,  3 Jun 2026 15:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SekGKplIIGqKOQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 03 Jun 2026 15:30:33 +0000
Message-ID: <15a1950d-1a67-45ee-ab0d-588b5504ef08@suse.de>
Date: Wed, 3 Jun 2026 17:30:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iplink: add support for setting IPv4
 devconf parameters
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: David Ahern <dsahern@kernel.org>, nicolas.dichtel@6wind.com,
 netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
References: <20260601143242.6729-1-fmancera@suse.de>
 <6365ef1e-d62d-4b2d-8e41-526881bbbe37@6wind.com>
 <491689b6-95f9-4e32-ae70-fdae464af353@suse.de>
 <0bc2dcd4-b29e-4a82-8d1b-5170e78c2d74@kernel.org>
 <78284e03-c868-4ae4-a74f-f8c98e2a3945@suse.de>
Content-Language: en-US
In-Reply-To: <78284e03-c868-4ae4-a74f-f8c98e2a3945@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294818-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:mid,suse.de:dkim,suse.de:from_mime,suse.de:email,6wind.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB6826399ED

On 6/3/26 5:22 PM, Fernando Fernandez Mancera wrote:
> On 6/3/26 5:18 PM, David Ahern wrote:
>> On 6/3/26 7:24 AM, Fernando Fernandez Mancera wrote:
>>> On 6/3/26 2:50 PM, Nicolas Dichtel wrote:
>>>> Le 01/06/2026 à 16:32, Fernando Fernandez Mancera a écrit :
>>>>> Currently, modifying IPv4 interface configuration parameters requires
>>>>> interacting with sysctl (/proc/sys/net/ipv4/conf/*). While
>>>>> ip-netconf exists for monitoring these values, there has been no 
>>>>> native
>>>>> way to set them directly through iproute2.
>>>>>
>>>>> This patch introduces the support for that via 'inet' at the 'ip link
>>>>> set'. It uses IFLA_INET_CONF netlink attribute to set the parameter.
>>>>>
>>>>> Example to enable forwarding on an interface:
>>>>>
>>>>> ip link set dev enp8s0 inet forwarding on
>>>>>
>>>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>>> Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>>>>
>>>> Do you plan to add the ipv6 part also?
>>>
>>> Yes, it is cooking but I want to get merged IPv4 first.
>>>
>>
>> If I merge the ipv4 patch today that means you are signing up to send
>> patches for ipv6 set and then ipv4 and ipv6 show in detailed device
>> dump. All of that in the next 2 weeks before 7.1 is released. Just want
>> to make sure we are clear on expectations.
>>
> 
> Sounds good to me. I am already working on it.
> 

Just to clarify, the IPv6 support depends on a series I am testing for 
kernel as the current support is quite poor. The "get" operation is 
rather simple and works fine without any kernel patch.

