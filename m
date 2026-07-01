Return-Path: <netdev+bounces-303764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wsPiEmxARWqu9QoAu9opvQ
	(envelope-from <netdev+bounces-303764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:29:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 626676EFCCC
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:29:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.com header.s=fm1 header.b=pgzXdUaP;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="c LxJZny";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303764-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303764-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E65530B8542
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7962C367B6F;
	Wed,  1 Jul 2026 16:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A63279798;
	Wed,  1 Jul 2026 16:23:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923014; cv=none; b=trWir/lSTqtQeyWfPpCbchP172BQKOZPAFVpuYQybDqsBoZMuPu12Amy+ke+GHPhVgJYk86skDdfVEgDK2UMA970XBOtFR450NIrhZLokycJCHXFErmmw18FKKGZs+6WQ5mP0AKfHnT6lSJ8tlqRUpQ4oWKv1akYAVd0Bnl/V1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923014; c=relaxed/simple;
	bh=x10C5v/pkDN5JEhi5Z90muc7qgtwdJDaeB1HgP/pcHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLE2f4foDbPNJrRJ3j6Y5sklUTbtFfW2UFV3FIDfBU2E9ubS9lWKw2O8PrzmcDccpv/yqpmuYlZbwNGmwwe7zqklCNgtJdRMkpQp8R8SjNhBN/+DuEacmCo2q8RZCwfo5DRHGo2zgihpzwZ5vmXi/HQAbbHPdJvUBoogokRbq8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pgzXdUaP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cLxJZnyt; arc=none smtp.client-ip=103.168.172.140
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id BA85013803FA;
	Wed,  1 Jul 2026 12:23:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 01 Jul 2026 12:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782923011;
	 x=1782926611; bh=bIIdkaiZyLJ8dGaBsy+pOB1LtJlZqvLnI/SY4kK7MsE=; b=
	pgzXdUaPLJ59bm5PICdUUbPY4QKNEAuIenH4eOEV6jc0vrgkONRWWwsIQKAhsZd3
	90fZFVaF0+7dET/zgxPwjp2nF3EFcGJ8cHHJ676NnMPtOJ45I0snDn3B3GgNyTA4
	MAIbJ9bPUPXanAa7GO+vL26wYF5t6FfOHYL6TsK5zUZYQIqSTOcEWv6RMmT329zC
	JzCX8JupRxOg7kgHFeOlg4/K2lF4DOiS3mx3g3h3Q/0tSCbRQjJ4HutKmukVWycA
	6DQxaEoySrFPpg3Ady70qQGJETOMBYoe0gHyvSZAcLjEaXb9VCB+wRFHWZkJFzkU
	5/wy2vRiX5FhqafaDpuzSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782923011; x=
	1782926611; bh=bIIdkaiZyLJ8dGaBsy+pOB1LtJlZqvLnI/SY4kK7MsE=; b=c
	LxJZnytS/Tsv+E6zFyJz2sDFARGejdBa+611xVW6J4K8ExVcQQ7821+Z4Md4vKNe
	yY/0FEH3bfXpC1UV98oA9x+SbsEyrUyUhN3IcPmRQu+cpSDLX5Hc5Sdp7bLb7SKE
	F79fANlOZRzUgTFZqVlPN+CRkzMVKaE4XRahebYiB8B8pjs8KlUnx1XQd0L8xA6V
	4ltzH1zzwUYNtn/9JiF/gUogelwMkEvDAu1Ebdw4B1F9nFY37E761quF89Pf7f9u
	URwiMP59+vqsN2KWvhGPJchxSJ0ftsHzcndfAdTTMc8vucP4q/fIJVPVdfgaTw3/
	2JW0NyobZfPSCmpursITA==
X-ME-Sender: <xms:Az9FanA6nZdvvh80sryBZc0yAwO-d8RWxYUgm4bVAFswfvcrF2BBfQ>
    <xme:Az9Fanifm0Tn4oHnl5x7ulmY0aa_TuNOWYlb4O8pU1wAWbH7gEtbmE_dxqIM5jFuY
    9Ktwk5EcXEaJFbEesT_Vv43ZMmdTDtSfW-KJ2spKkxdPiDumKWgiA>
X-ME-Received: <xmr:Az9FapNEZ0KoUHXrNDSbn6CFdfMRFCa48AC8dLPAN1fqtxMVnBeNfSbutoZum6az9A>
X-ME-Proxy-Cause: dmFkZTE4zoAaZe8L2+jvZaacThwtfnpMPC6LLvbRLosiLXdN5TxmBr60aNb8A08/c4yk10
    rCva1N2EQrNvsd+TFvLDW12DsF4qfnYXGB+3XNnrCiHAr72tANSXf99ZHOSryWtQ4mpg9u
    FQ1neFOoU6VFX3cb2SR4lwTNkqVM3HAoWu8mHUzjv6hWxlYrg1bllFJMuvCm2KwbjOeHdr
    en5TZcFEf5lWtcngTgtA+JUlrs3qe5KsFaFg+qUU0N5o9yxOqnydem7SNHsZOKJVpLNNKD
    uf2q/MpwAUHpZfj0UjqgVy4aS5NXqW3DRtp9MVJna1NNgBuZU2KW32CnAuQ0/abf7bLAci
    p8ttWjRHa2xaStm7lJf/ZANB2+tIGvZ4Pnn2LXaVUpjS4c00q9wHb964z1d6TtZzMq3K/c
    3ov6ezT2MmjtoLgK1QMBP3qe9+vBy9n6tEZCsR5bObwWxBHjyqprfMt2AyScy0Q88wIfYV
    J7EkHzfZqUX9ZIfUKey4b78TgR5r+0xMWIk6P3B5xH4Vv/Ae06f86Jey5kDSe6XPUcewh0
    0gH7Amom3VgvBGgmz0fdJWbxTgRHfAkM95fgrSxvV4NW5+4F9Uvt7bcofOt3Vtgs5Rkt5K
    PvCFRpCY7HcTRxJpwhyOWJ5q1tdop90NA7kGokl6d/viQCmxRo4PABs579sw
X-ME-Proxy: <xmx:Az9Fan9C0J-o1xbpeh1PuSyYeR1ZSOT1ZXfwMXl9OlFhKxOF51IuCg>
    <xmx:Az9Faqe6QRktZSkJ-_OtikT0gbokATpQZYHSel46uqxwLx4GCVWCnA>
    <xmx:Az9FamxjVuXg80nBscT5k3vRAfKjAKCLOfuHVidNe4FxFHTa8oSyUw>
    <xmx:Az9FavIxyRlDTayDd1tayuy8lNAwV674R8sK4hkoPebJlKJd7siOyA>
    <xmx:Az9FakW0d48ptBsfSbrFxNY0HsifCMXqeio4jMF6Y5qqJpMSGK1o5TJP>
Feedback-ID: i9dce4b48:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 12:23:29 -0400 (EDT)
Message-ID: <fe22e7b2-4cf9-4816-a513-5dfa9d3bf84f@fastmail.com>
Date: Wed, 1 Jul 2026 19:23:27 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qede: Prevent possible snprintf() truncation by bounding
 %s string format
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:QLOGIC QL4xxx ETHERNET DRIVER" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260701144713.197557-1-barant@fastmail.com>
 <akUw_GsNELK4NKTN@gmail.com>
Content-Language: en-US
From: Baran TUna <barant@fastmail.com>
In-Reply-To: <akUw_GsNELK4NKTN@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303764-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[barant@fastmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barant@fastmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 626676EFCCC

The current solution is pretty arbitrary.

Numbers are coming from a simple calculation, to make sure output always 
fits.


I will take a further look and send a patch if there is a more 
generalized solution.

On 7/1/26 6:27 PM, Breno Leitao wrote:
> On Wed, Jul 01, 2026 at 05:47:11PM +0300, Baran Tuna wrote:
>> GCC warning shows that formatted strings may
>> exceed the fixed-size destination buffers.
>>
>> Bounding the %s string format
>> so the maximum formatted output always fits.
>>
>> This eliminates the -Wformat-truncation warning.
>>
>> Signed-off-by: Baran Tuna <barant@fastmail.com>
>> ---
>>   drivers/net/ethernet/qlogic/qede/qede_ethtool.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
>> index 647f30a16a94..5428f53150a0 100644
>> --- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
>> +++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
>> @@ -618,10 +618,10 @@ static void qede_get_drvinfo(struct net_device *ndev,
>>   	if ((strlen(storm) + strlen("[storm]")) <
>>   	    sizeof(info->version))
>>   		snprintf(info->version, sizeof(info->version),
>> -			 "[storm %s]", storm);
>> +			 "[storm %.16s]", storm);
> Where is this 16 coming from?
>
> Also, isn't the if above checking for no overflow? I.e,
> we got here only if strlen(storm) + strlen("[storm]") < sizeof(info->version))
>
> For whoever else is reviwewing this, this the buffers:
>
> 	#define ETHTOOL_FWVERS_LEN      32
>          char    version[32];
> 	char storm[ETHTOOL_FWVERS_LEN];
>

