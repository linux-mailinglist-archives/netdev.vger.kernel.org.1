Return-Path: <netdev+bounces-263684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIB+LCX3p2mtmwAAu9opvQ
	(envelope-from <netdev+bounces-263684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:11:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA8D1FD4F9
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9F543066275
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5122439EF39;
	Wed,  4 Mar 2026 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YZwSOPE1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="47wJBQ2h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YZwSOPE1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="47wJBQ2h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170439769B
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615031; cv=none; b=hHFhZEr82IlOs4Z4PHgPPlZlfRq175umjt0xv7ortlATCmX8yuxELJmWAkBqpjCqEffEvLCKbaBZ/dHx/HDlUg2ugtFTaemgMY7Gz0xIl1EDStFg2JhbS0G6gGOP++j6YVt5sG2z7xAjmir22rQOvB1s2FNeQeNR+J7j3laLrYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615031; c=relaxed/simple;
	bh=/nJoaEneFYJ6ytWXUkuIFv6wacytrKIrZeW/btn89OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjMb5Q9uQ7/gNfUzGC7Kh0dGQRtOlWn5tem8uRhU3OR9BtJLMHSTX0yPUS2fXiEdOipZ0ItA9tdK+vZwBpRMfEvqa75KrZ3n2rdJc/Wniz96fBABKDmt0uA9ZKtEC95RT0SlcLXKxu8xLU6NqZj3xA77Vo7t2f6YwzL2d9q8U/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YZwSOPE1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=47wJBQ2h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YZwSOPE1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=47wJBQ2h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 219B73F795;
	Wed,  4 Mar 2026 09:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772615028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv186FURKfdUVSctylq5Eh0+n7yU6aMhFoRc4CNpXCo=;
	b=YZwSOPE1DPyQ6PvgV8oQBodb51zwq9AAzCxVkEJkA2CEZlyLsLbeBo2F+UL+DdzmbfRlcR
	jYC0RybT1xaFXktrJ/n/uRfdWmAkmcorS9xJQP5pxCrqKLaposuUUl0ckHIHokr6DcOh/M
	45LTTn6nUPAlvzM/NGRa7ZC3+1rroTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772615028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv186FURKfdUVSctylq5Eh0+n7yU6aMhFoRc4CNpXCo=;
	b=47wJBQ2hNDkTjdbh7u1enjETBjIvmlj/ut/o9MXFokqlSW1vVm+4uMzg3PXi4P8AgRYaS+
	457DXlcrvIZqI3Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YZwSOPE1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=47wJBQ2h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772615028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv186FURKfdUVSctylq5Eh0+n7yU6aMhFoRc4CNpXCo=;
	b=YZwSOPE1DPyQ6PvgV8oQBodb51zwq9AAzCxVkEJkA2CEZlyLsLbeBo2F+UL+DdzmbfRlcR
	jYC0RybT1xaFXktrJ/n/uRfdWmAkmcorS9xJQP5pxCrqKLaposuUUl0ckHIHokr6DcOh/M
	45LTTn6nUPAlvzM/NGRa7ZC3+1rroTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772615028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv186FURKfdUVSctylq5Eh0+n7yU6aMhFoRc4CNpXCo=;
	b=47wJBQ2hNDkTjdbh7u1enjETBjIvmlj/ut/o9MXFokqlSW1vVm+4uMzg3PXi4P8AgRYaS+
	457DXlcrvIZqI3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2E333EA69;
	Wed,  4 Mar 2026 09:03:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qNbiJHP1p2nfMQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 04 Mar 2026 09:03:47 +0000
Message-ID: <e773e5dc-b08c-4bc4-bfd6-95b6134e344a@suse.de>
Date: Wed, 4 Mar 2026 10:03:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ipv4: bump rt_genid when a relevant devconf value
 changes through netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
References: <20260302130858.5197-1-fmancera@suse.de>
 <20260303183843.5b29d5b0@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260303183843.5b29d5b0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: BBA8D1FD4F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263684-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:dkim,suse.de:mid]
X-Rspamd-Action: no action

On 3/4/26 3:38 AM, Jakub Kicinski wrote:
> On Mon,  2 Mar 2026 14:08:57 +0100 Fernando Fernandez Mancera wrote:
>> +			switch (nla_type(a)) {
>> +			case IPV4_DEVCONF_FORWARDING:
>> +				if (nla_get_u32(a))
>> +					netif_disable_lro(dev);
> 
> why not dev_disable_lro()??

dev_disable_lro() takes netdev_lock_ops() but when handling IFLA_AF_SPEC 
at net/core/rtnetlink.c:3320 we are already holding netdev lock ops. So 
we need to call netif_disable_lro() instead.

> 
>> +				fallthrough;
>> +			case IPV4_DEVCONF_NOXFRM:
>> +			case IPV4_DEVCONF_NOPOLICY:
>> +			case IPV4_DEVCONF_PROMOTE_SECONDARIES:
>> +			case IPV4_DEVCONF_ROUTE_LOCALNET:
>> +			case IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST:
>> +				flush_cache = true;
>> +				break;
>> +			default:
>> +				break;
>> +			}
>> +		}
>> +		if (flush_cache)
>> +			rt_cache_flush(net);
>>   	}
> 
> Looking closer at this I'm struggling to connect this to
> devinet_conf_proc(). The attrs you're snooping here are completely different!?
> Logic for when rt_cache_flush() happens is different.
> 

So I was planning to to handle inet_netconf_notify_devconf() calls in a 
follow-up patch to net-next because it might require some more changes 
and also the missing notification shouldn't be net tree material IMHO.

This is handling ipv4_doint_and_flush() which is used by 
DEVINET_SYSCTL_FLUSHING_ENTRY() macro. But now that you mention it, 
BC_FORWARDING and ACCEPT_LOCAL are part of devinet_conf_proc() while 
they probably could go to ipv4_doint_and_flush().

In addition, I guess we should flush the cache only if the value 
changed. I will add that bit too.

P.S: there is also dead code in devinet_conf_proc() as `i == 
IPV4_DEVCONF_ROUTE_LOCALNET - 1` won't never evaluate as true.

Thanks,
Fernando.

> inet_netconf_notify_devconf() is missing even after the patch.


