Return-Path: <netdev+bounces-268966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAyvJRaCumldXQIAu9opvQ
	(envelope-from <netdev+bounces-268966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:44:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D372BA22B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 775E73058447
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3906D3A785D;
	Wed, 18 Mar 2026 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xYssy6hV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DV7Keg3x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xYssy6hV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DV7Keg3x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F939F169
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830624; cv=none; b=Qi6nOBynX4RwWbE74EUzTyeBX8q7KIHvL+o5ai/0Wv3Ceh1C7hcqqugY/rnV48chh0x1nFQT303LldDT5F99kK0XIxum5wGwtxfVl4lR16m/F6j9eZAHvrrnYBot8iEX/5OSK4Wv7ubqTfNevcMv5JfSvBQoxjBtgmX1K8uS6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830624; c=relaxed/simple;
	bh=oc4D1PESup3IFzdbD0jEbTXo/0kAy+Rh8+zH1oNFcTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsN6vh2ShTTEmQ2pVATjmdyCVE2aGasYy8+MQozk8v6zSbnQ+eLsam4pBQK+YHU8EskFfYJG9n3ErKCCWV4WJSVbjORdhPvBq0Hwnw/Emca/w77nS87OYSgWU1D6AJQhcZUfufXtu2mrrHFM405BgtsM0elIzxUGG9ABV0w+Z6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xYssy6hV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DV7Keg3x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xYssy6hV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DV7Keg3x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53F885BE62;
	Wed, 18 Mar 2026 10:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773830621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UJnDC4G6fXouGsf83DgNZb3q00GIR95KOLG391dZDM=;
	b=xYssy6hVQPkZtmkI8inkgZuolgoig9HYnHVTaAWk5p0/5cKVEFSbalNn3e5HbkbVguYc/C
	co9stD8lMZyy2cQ079WJI1jKvlpE8B5iOpjMXyT8Jn6MM6Z34wyOMzalYRWUDd11NOL3lO
	ww9zzBNso7I3rh5xo9Rnev2mUmjbhOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773830621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UJnDC4G6fXouGsf83DgNZb3q00GIR95KOLG391dZDM=;
	b=DV7Keg3x4jzanUR1z00yrZZuBXcGlBXXl15uPOz1UPkymz/m+6DYTqvD7YghZQ2lR0EX5a
	ADnYssAFbJk+SGDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773830621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UJnDC4G6fXouGsf83DgNZb3q00GIR95KOLG391dZDM=;
	b=xYssy6hVQPkZtmkI8inkgZuolgoig9HYnHVTaAWk5p0/5cKVEFSbalNn3e5HbkbVguYc/C
	co9stD8lMZyy2cQ079WJI1jKvlpE8B5iOpjMXyT8Jn6MM6Z34wyOMzalYRWUDd11NOL3lO
	ww9zzBNso7I3rh5xo9Rnev2mUmjbhOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773830621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UJnDC4G6fXouGsf83DgNZb3q00GIR95KOLG391dZDM=;
	b=DV7Keg3x4jzanUR1z00yrZZuBXcGlBXXl15uPOz1UPkymz/m+6DYTqvD7YghZQ2lR0EX5a
	ADnYssAFbJk+SGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEBCF4273B;
	Wed, 18 Mar 2026 10:43:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ap+aK9yBumn/dwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 18 Mar 2026 10:43:40 +0000
Message-ID: <f67f32ef-d619-4f61-9054-e6b6340129ad@suse.de>
Date: Wed, 18 Mar 2026 11:43:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10 net-next v3] ipv6: prepare headers for ipv6_stub
 removal
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?=
 <rbm@suse.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260317140141.5723-1-fmancera@suse.de>
 <20260317140141.5723-5-fmancera@suse.de> <20260317201236.GA3581148@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260317201236.GA3581148@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268966-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 15D372BA22B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 9:12 PM, Ido Schimmel wrote:
> On Tue, Mar 17, 2026 at 03:01:00PM +0100, Fernando Fernandez Mancera wrote:
>> diff --git a/include/net/ndisc.h b/include/net/ndisc.h
>> index d38783a2ce57..6152401f29f1 100644
>> --- a/include/net/ndisc.h
>> +++ b/include/net/ndisc.h
>> @@ -69,6 +69,12 @@ struct prefix_info;
>>   
>>   extern struct neigh_table nd_tbl;
>>   
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +#define ipv6_get_nd_tbl() (&nd_tbl)
>> +#else
>> +#define ipv6_get_nd_tbl() NULL
>> +#endif
> 
> What is the reason for converting code that is dependent on CONFIG_IPV6
> to use ipv6_get_nd_tbl()?

I did it mainly for consistency. If you think this isn't fine, I can 
move it back to &nd_tbl directly.

Thanks,
Fernando.

