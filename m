Return-Path: <netdev+bounces-294381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 98HgJIEyH2pdigAAu9opvQ
	(envelope-from <netdev+bounces-294381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:44:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C586317DF
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:44:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bqamb79x;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qeMyxkkJ;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bqamb79x;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qeMyxkkJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294381-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294381-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 751483007F7B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4F231F985;
	Tue,  2 Jun 2026 19:43:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EEA30F540
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:43:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429439; cv=none; b=ZoMCblu7zVK2yzCi3fjVEgJkGFYoKYNv9PByo+rzIJuCZOaFdZXpaV7ck8szxPPHyp0VlEfnoSUaz7ZWAnoII8fEx2txFGcBojMlCv9/MnZLuFJ0DLnbgBF7UcQUamdNKqj2ZHrEMdhMdhrjDKyA1ifUoXx5WzTjF+Y/P/fVM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429439; c=relaxed/simple;
	bh=6A+exUyZ0cOTezUaa3Hwl7lX3IJNQt75M/ttInn7Cj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKlHihF181lCX90Dn4RWELSVVj331NDs6s5msl6UJA5kYx3cHunckqQLyHzDudiBsNqH/N7mQreOhS7QLdmaWNbKfdRqjOnKTJpOIZ5eRMsHi7gd8a9RvmySVXQR6GySrH3ypMVLyJGLeKohePMlE5GDC6vBBYuylDS49gZJ/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bqamb79x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qeMyxkkJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bqamb79x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qeMyxkkJ; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3C2B6ABAC;
	Tue,  2 Jun 2026 19:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780429435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXYwZzHow+zC2LuSvOlIgA1JtE+IJZAWpYDd3+Hl59o=;
	b=bqamb79xNnafD0w61B0033QSACMN+R+8kr9HOaD21PrLMn0qXV/X2G4okmvPOP0ugNhiIE
	+yyFjTwIdCfWnRtcp3MUuQsc4ThGGRPWqdMgw9LD6mZmsASfuMcEJ/745e1x8JOQQ8ttIM
	CCi6Hrf7chOjjRp8GXJMe7ZpLcT/Kl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780429435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXYwZzHow+zC2LuSvOlIgA1JtE+IJZAWpYDd3+Hl59o=;
	b=qeMyxkkJaYtMKiGnW8XVXMCT31hN5rv3lTPpUD1Q6H6gC1OA5DIcwVfOZeoOnDpTvD2Ely
	RN/RxHLmIvTXnCCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780429435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXYwZzHow+zC2LuSvOlIgA1JtE+IJZAWpYDd3+Hl59o=;
	b=bqamb79xNnafD0w61B0033QSACMN+R+8kr9HOaD21PrLMn0qXV/X2G4okmvPOP0ugNhiIE
	+yyFjTwIdCfWnRtcp3MUuQsc4ThGGRPWqdMgw9LD6mZmsASfuMcEJ/745e1x8JOQQ8ttIM
	CCi6Hrf7chOjjRp8GXJMe7ZpLcT/Kl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780429435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXYwZzHow+zC2LuSvOlIgA1JtE+IJZAWpYDd3+Hl59o=;
	b=qeMyxkkJaYtMKiGnW8XVXMCT31hN5rv3lTPpUD1Q6H6gC1OA5DIcwVfOZeoOnDpTvD2Ely
	RN/RxHLmIvTXnCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29F73779A7;
	Tue,  2 Jun 2026 19:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KVpEB3syH2q7IAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 02 Jun 2026 19:43:55 +0000
Message-ID: <e659d001-e39c-454c-ba47-cbb762e1c19f@suse.de>
Date: Tue, 2 Jun 2026 21:43:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] hsr: broadcast netlink notifications in the
 device's net namespace
To: Jakub Kicinski <kuba@kernel.org>, maoyixie.tju@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jvaclav@redhat.com, andrew@lunn.ch, ap420073@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260601022014.1175348-1-maoyixie.tju@gmail.com>
 <20260602190700.1920420-1-kuba@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260602190700.1920420-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294381-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:jvaclav@redhat.com,m:andrew@lunn.ch,m:ap420073@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:from_mime,suse.de:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1C586317DF

On 6/2/26 9:06 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> hsr: broadcast netlink notifications in the device's net namespace
> 
> This commit modifies the HSR subsystem to broadcast generic netlink
> notifications in the device's network namespace instead of init_net. It updates
> hsr_nl_ringerror() and hsr_nl_nodedown() to use genlmsg_multicast_netns().
> 
>> diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
>> index f0ca23da3ab99..eb6d222535d8b 100644
>> --- a/net/hsr/hsr_netlink.c
>> +++ b/net/hsr/hsr_netlink.c
> [ ... ]
>> @@ -288,8 +289,17 @@ void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN])
>>   	if (res < 0)
>>   		goto nla_put_failure;
>>   
>> +	rcu_read_lock();
>> +	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
>> +	if (!master) {
>> +		rcu_read_unlock();
>> +		goto nla_put_failure;
> 
> [Severity: High]
> Does jumping to nla_put_failure here cause a NULL pointer dereference?
> 
> If master is NULL, the code jumps to nla_put_failure, which frees the skb
> and then falls through to the fail label:
> 
> nla_put_failure:
> 	kfree_skb(skb);
> 
> fail:
> 	rcu_read_lock();
> 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> 	netdev_warn(master->dev, "Could not send HSR node down\n");
> 	rcu_read_unlock();
> 
> Since master was not found previously, the re-fetch will likely still be NULL,
> meaning the dereference of master->dev in netdev_warn() will crash.
> 

Hi Jakub,

FWIW I don't think this can happen. I didn't mention it because it was 
kind of pointless but I was wrong.

i.e master cannot be NULL here. When cleaning up the link at 
hsr_dellink() we always call timer_delete_sync() for all the background 
jobs before removing the master.

But given this AI report it seems it is just better to remove the master 
check that this patch is introducing to avoid AI reports all over the code.

Thanks,
Fernando.

>> +	}
>> +
>>   	genlmsg_end(skb, msg_head);
>> -	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
>> +	genlmsg_multicast_netns(&hsr_genl_family, dev_net(master->dev),
>> +				skb, 0, 0, GFP_ATOMIC);
>> +	rcu_read_unlock();
>>   
>>   	return;
>>


