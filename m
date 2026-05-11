Return-Path: <netdev+bounces-286767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBxTNOcbAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:11:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F0951422E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B713A303C626
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7F237BE81;
	Mon, 11 May 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVyk3XcK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2A9281530
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521623; cv=none; b=dHPqgFcrggce1wwTrMmQA0FRhBm5UNw57rTrSyOLbA7gYhPgPYGNfn2XnS6Af6MV89j6JZnDU/pXsZ6m2vBf+Rx3vYvmqftr7BapAV5XI6ACi+RHZgze1EjpK8AtxRvZyZPuHY3JLxJO8RCwqw5IxRKEWKMsRduBN+P+we7mLWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521623; c=relaxed/simple;
	bh=a+/7fyNOQVtQPVWzzMaXJnotUAV583J2IHOTBuxQCWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9UImaRVzFWDceuSPOnf4sQ5KbROwSCwv3BvxAh0yFsyv/vzJdFI3IgMOZ8sm/3Q0hE6GQfHlR3st+JKS9LgR0Xa90773A5NsMfVtZmgnmObSTzTZZgmKSYf0HW10v1JFGA93UgCVleIS+uJgU4YqNkzooAZoDVdpv4b6v2Xw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVyk3XcK; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8bb09239328so38156636d6.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521621; x=1779126421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fn8w0ZMT4ktQ/u7MVa+/JHs31exhvHQ6lISI5LWtIow=;
        b=EVyk3XcKfwJ7J1sNz5bft4xy8bEGxFIny3dzxtvzUgfw6PejdB21AQwpXi71uBEEqK
         qvGHNZ42BQIn284CDCyplwqaQ4F8B8w6FMYL1bODUXZ+fJoRXGv0aYCsEcpAA9D4Bxa1
         PpOnQuq5faHV+JCLvS9REG0vp8p4M69PqhC7KhXhOsdjtDTdEIipBPE0QJKDtfSeosrl
         M6fcA2ZMILVkZCDwSJTb/waYMt3bbi+kYq3Sw1Syu2pJan2OdpkjtTgieiQMuUky8ET/
         hzR59TeUMD6Jvc2y0ifWSlw9cq2xF5vq1abNg/sDt5gmbiJL9/ZaoUgyMK/hTye3Ovkv
         PXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521621; x=1779126421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn8w0ZMT4ktQ/u7MVa+/JHs31exhvHQ6lISI5LWtIow=;
        b=DoS+k7rFG/990YEyQ+d9rAa+DKswkffMpzyl7+8WegnwLDDmqSzQhlfQvqsmIHNGvo
         UFKGhFIew95fMlLDP32hY3jkX6gDdV0uXbwXEs5rcxAyKTZOwWv/yh2ZcHao175MdzLD
         P74oJKqvNSBLtIwXuMmjbvyDTYO3x+hS5pZrzxSHOxZkXs++muuKy7//yDugKNvgC6rv
         i3UhD0WQPwW6KdrNnlGXZoXU0cVUai+ZfaZ/Db/OsnWaELDAEAEaJBf4RbOZdqv1yLnK
         vbsJt3E8NpEONoCgrPt5E3sQwx0K5yK2O9xxJZ/6vtwO7kDwWmeZdzqNcjruagQreBdp
         lMhw==
X-Gm-Message-State: AOJu0YzUDB4yhVq0hr+UVGYvH8YZTvEyQjG3CludOgfnZl7h4jLbA6+3
	88IVt73mNwVcgk88TTL9sZ9Fcyrrl/mtnQ0Mxa20hHRSNAtURtWm3RZI
X-Gm-Gg: Acq92OHcHpeNWiBybvlHUAPODWYsOK/ccssGwNPhKFLs7JG3BoRddjqbMMY6T53kmqf
	2XIyAktw2gaMQAbpe3h3Sm9fO3MrLS/ijseNEuJ3zQCgKi5VpCJAVMFVWm6xF8HLOohNuHMA2Qn
	KMJpZIHn0GCQeNkbXI7+Rz1m4xZNQsR5m/3vJxGMTcNnZH2XXRt4xszI5sTri2VKqr4isBfGkRW
	7+90YYLbUGUKraIXqYP5qYRnTczhybFYJc1SmkGgzGLQfMOFbuxbObgzFId71NDXRA57ftR2ckk
	MQqoC2O9JXsG204UTNw755iRKNoRDquyDCUon1MuFhPXY6hJrCjPRvc4LNKkiSf8CVF1cSnxroD
	FpVS1CsNIefGZCLH5fGyKC5hP3T6dgx9RR/N5kVOgMxZu0lqc7Jh/qNHskz3/gMlpbm5IEo3sMU
	dFlMitLwEmeHvPrtzC64yEz0RU9i1EtgL4Ul8Rwr0cBw2E30nu1Y+Gpz+XHiTSS9gAXtAEUw==
X-Received: by 2002:a05:6214:3d08:b0:8ac:ab30:fffa with SMTP id 6a1803df08f44-8bf4341334dmr257303186d6.32.1778521620639;
        Mon, 11 May 2026 10:47:00 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11d1::1011? ([2620:10d:c091:400::5:9448])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a71be9csm102375116d6.17.2026.05.11.10.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 10:47:00 -0700 (PDT)
Message-ID: <d962b7e2-7506-4ae6-91c1-58b4e712270c@gmail.com>
Date: Mon, 11 May 2026 13:46:59 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] netdevsim: psp: remove unnecessary UDP
 checksum computation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-2-4b50ed09b794@gmail.com>
 <willemdebruijn.kernel.1d153b0dc9762@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1d153b0dc9762@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 38F0951422E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 5/11/26 1:01 PM, Willem de Bruijn wrote:
> Daniel Zahka wrote:
>> The PSP spec requires the implementations accept 0 checksum in psp-udp
>> header. Let's take advantage of that to trim netdevsim's psp code
>> down. psp_dev_encapsulate() already sets uh->check to 0.
>>
>> Assisted-by: Claude:claude-opus-4.6
>> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
>> ---
>>   drivers/net/netdevsim/psp.c | 32 --------------------------------
>>   1 file changed, 32 deletions(-)
>>
>> diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
>> index 5073bda60883..75740e2a731f 100644
>> --- a/drivers/net/netdevsim/psp.c
>> +++ b/drivers/net/netdevsim/psp.c
>> @@ -1,8 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   
>> -#include <linux/ip.h>
>>   #include <linux/skbuff.h>
>> -#include <net/ip6_checksum.h>
>>   #include <net/psp.h>
>>   #include <net/sock.h>
>>   
>> @@ -81,36 +79,6 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
>>   			      skb->len - skb_inner_transport_offset(skb));
>>   		u64_stats_update_end(&ns->psp.syncp);
>>   	} else {
>> -		struct ipv6hdr *ip6h __maybe_unused;
>> -		struct iphdr *iph;
>> -		struct udphdr *uh;
>> -		__wsum csum;
>> -
>> -		/* Do not decapsulate. Receive the skb with the udp and psp
>> -		 * headers still there as if this is a normal udp packet.
>> -		 * psp_dev_encapsulate() sets udp checksum to 0, so we need to
>> -		 * provide a valid checksum here, so the skb isn't dropped.
>> -		 */
> Perhaps this was here as IPv6 does not allow zero checksums except for
> tunneling in specific cases (RFC 6936)?


Yes it was originally here for IPv6. It was needed to make a test case 
pass that ultimately never got upstreamed (yet). The test basically used 
the psp_dev_ops::set_config() function to turn psp rx off midflow, and 
then tried to catch packets with a udp socket listening on port 1000. At 
the time I didn't realize that I could probably make the test work by 
opting the socket into a setting for RFC 6936 with setsockopt().


> It seems benign enough to keep the code. Do you have a specific reason
> to remove it, beyond reducing LoC?


It was just to reduce LoC for the series :) I can put it back in if you 
like, though as I mentioned, none of the current tests cover that the 
psp-udp csum is correct.


