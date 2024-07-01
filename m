Return-Path: <netdev+bounces-108286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDEF91EA7E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 23:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD8628284C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4800171086;
	Mon,  1 Jul 2024 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YzrfafVZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB42C1BA
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719870693; cv=none; b=F8SxHqzvUeSLEVcqD4V2JaUhuliAOq/nqZpS3d7k9eZZQmbVdMZTGDPzcPXVEE/rhBglrEJe9lp+6M8reabctH0USuwhdAc5vmixAxurlMY733PnS1etv1oUSbSa1nixFuKzDFCbzfC3fwtO4FjQZRi7xsoT+ppCSK90t17FY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719870693; c=relaxed/simple;
	bh=vSjW3mtZhDPM8kptVVfxp2YPgOpAuU4U3ynSHEnCf4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUkXOXeHv4jBYI2nxs5vwOM9iepRn0K/W7wPZ4o7BXav4XLN29TE7CnrPpJv04OX4YWRM/zBFvrkeIm/qZiK8Am4EXPTjlV3fQMbA01PvTSJ2PclanboAsevnXHD/33hagFv57UcR8wc5wHorRJNA15bcW/LWaRYjujFFD9C6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YzrfafVZ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25cb3f1765bso1984320fac.1
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 14:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719870690; x=1720475490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dhMW3RrqLnyH92qhU9KT4+7B7Gd+dTybrtLwN1aA2+U=;
        b=YzrfafVZzTjBJIfHr2C+vaLsdFC5yUbvjuURgzSb53WcJe7tbn6GoQY5rr1j5x05LX
         1dUS03QqVLMQFeAuUupmVh1H74F9j9lpGhU7I9sZ3Xyc66ROnzha/BaD+EiZzT6f8gUI
         7Aiqpa+z1GVct+rRf+hJMLWhRFlOTLJ9TMyjEvylgaT1lAbYjp1mLU4B69Om1UPX+AXL
         BPCdHPz9SlqkUsPgUhvtsxEjswRparYqqitgeLryk01wkOoepFk94RuepGDzfLcEnhbc
         eQGXsTdH7LuMHWyIg1x/sAaryhLsiw4xjHZxQ5zlM7Ip4RjsGHEEYbhj9aKt+KPuf8zg
         E9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719870690; x=1720475490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhMW3RrqLnyH92qhU9KT4+7B7Gd+dTybrtLwN1aA2+U=;
        b=EaKrbk+RLlfcqRRbeo4vEdbYNKcofOJA0Z2MG36+3Tm91xchpMndv901hg0eBiGJuA
         Y0V5wqATFAYHtMteiX5+ovmMHYaYI4BAgyhQgeHr2zqFVSCMIGpp90kmcRs1evY+ge81
         S5g84X41VFT2XF0gLE4bqR9NHporC20jC+dzP24EcFS9FfbpoONtLC/QDkJY9j8HI40+
         moQtl2JjpNWOG9xUH2l5MER8GQut2lk/qxaYwizSxAgjxXos7E+7p116EnXpZXXgPFTD
         VB3nQrBMqrows3yx5AeDuJ2A9lziuDUmPxqFyPaQm9daZFZ7JgspFXxYhRmiDy4vzPkA
         Ymhw==
X-Forwarded-Encrypted: i=1; AJvYcCUNbB58wOkDFN8MrvK88JecepWjt7+cNAdSdJplcZsfIDkN1urNR0Tz8ElBmCDOx3IWk/bXkyOltiizTA1wgSbt19RWoeKX
X-Gm-Message-State: AOJu0YxbFxHHeZGOER7ONH9rKKq07YCG83y5XTg3ISjaO9IGFRXdqukB
	s92EYwiiP/o8/GYWtihiH9yC7/17J60HViqE3yXcjXXhTvkPGepjov+OipIEv6o=
X-Google-Smtp-Source: AGHT+IETsdegfI4jOXCoSVehNHfLcl3TeoGVGKVMXgKbtPUxFoqAN8LzG+UWto/rQJUcvkuSo0uzKQ==
X-Received: by 2002:a05:6870:2195:b0:22a:b358:268 with SMTP id 586e51a60fabf-25db352c199mr6885310fac.25.1719870689840;
        Mon, 01 Jul 2024 14:51:29 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25d8e3a05f4sm1911411fac.58.2024.07.01.14.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 14:51:29 -0700 (PDT)
Message-ID: <ec536136-9dc1-4f4b-9fa2-ee3b7a3f95ee@bytedance.com>
Date: Mon, 1 Jul 2024 14:51:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: fix OOM problem in msg_zerocopy selftest
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240701202338.2806388-1-zijianzhang@bytedance.com>
 <66831e1c3352a_46fc1294d8@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <66831e1c3352a_46fc1294d8@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/1/24 2:22 PM, Willem de Bruijn wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> 
> Remember to append to PATCH net or net-next in the subject line.
> 
> Since the title has fix in it, I suppose this should go to net.
> 
> As this is a test adjustment, I don't think it should go to stable.
> Still, fixes need a Fixes: tag. The below referenced commit is not the
> cause. Likely that sysctl could be set to a different value to trigger
> this on older kernels too.
> 
> This has likely been present since the start of the test, so
> 
> Fixes: 07b65c5b31ce ("test: add msg_zerocopy test")
> 

My ignorance, thanks for pointing this out!

>> In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
>> on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
>> until the socket is not writable. Typically, it will start the receiving
>> process after around 30+ sendmsgs. However, because of the commit
>> dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale") the sender is
>> always writable and does not get any chance to run recv notifications.
>> The selftest always exits with OUT_OF_MEMORY because the memory used by
>> opt_skb exceeds the core.sysctl_optmem_max.
> 
> Regardless of how large you set this sysctl, right? It is suggested to
> increase it to at least 128KB.
> 

Just retested, even though I set net.core.optmem_max to 128k+, the
problem still exists.

>> We introduce "cfg_notification_limit" to force sender to receive
>> notifications after some number of sendmsgs. And, notifications may not
>> come in order, because of the reason we present above.
> 
> Which reason?
> 

If I open the Lock debugging config, the notifications will be reordered.

>> We have order
>> checking code managed by cfg_verbose.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
>> ---
>>   tools/testing/selftests/net/msg_zerocopy.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
>> index bdc03a2097e8..7ea5fb28c93d 100644
>> --- a/tools/testing/selftests/net/msg_zerocopy.c
>> +++ b/tools/testing/selftests/net/msg_zerocopy.c
>> @@ -85,6 +85,7 @@ static bool cfg_rx;
>>   static int  cfg_runtime_ms	= 4200;
>>   static int  cfg_verbose;
>>   static int  cfg_waittime_ms	= 500;
>> +static int  cfg_notification_limit = 32;
>>   static bool cfg_zerocopy;
>>   
>>   static socklen_t cfg_alen;
>> @@ -95,6 +96,7 @@ static char payload[IP_MAXPACKET];
>>   static long packets, bytes, completions, expected_completions;
>>   static int  zerocopied = -1;
>>   static uint32_t next_completion;
>> +static uint32_t sends_since_notify;
>>   
>>   static unsigned long gettimeofday_ms(void)
>>   {
>> @@ -208,6 +210,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
>>   		error(1, errno, "send");
>>   	if (cfg_verbose && ret != len)
>>   		fprintf(stderr, "send: ret=%u != %u\n", ret, len);
>> +	sends_since_notify++;
>>   
>>   	if (len) {
>>   		packets++;
>> @@ -435,7 +438,7 @@ static bool do_recv_completion(int fd, int domain)
>>   	/* Detect notification gaps. These should not happen often, if at all.
>>   	 * Gaps can occur due to drops, reordering and retransmissions.
>>   	 */
>> -	if (lo != next_completion)
>> +	if (cfg_verbose && lo != next_completion)
>>   		fprintf(stderr, "gap: %u..%u does not append to %u\n",
>>   			lo, hi, next_completion);
>>   	next_completion = hi + 1;
>> @@ -460,6 +463,7 @@ static bool do_recv_completion(int fd, int domain)
>>   static void do_recv_completions(int fd, int domain)
>>   {
>>   	while (do_recv_completion(fd, domain)) {}
>> +	sends_since_notify = 0;
>>   }
>>   
>>   /* Wait for all remaining completions on the errqueue */
>> @@ -549,6 +553,9 @@ static void do_tx(int domain, int type, int protocol)
>>   		else
>>   			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
>>   
>> +		if (cfg_zerocopy && sends_since_notify >= cfg_notification_limit)
>> +			do_recv_completions(fd, domain);
>> +
>>   		while (!do_poll(fd, POLLOUT)) {
>>   			if (cfg_zerocopy)
>>   				do_recv_completions(fd, domain);
>> @@ -708,7 +715,7 @@ static void parse_opts(int argc, char **argv)
>>   
>>   	cfg_payload_len = max_payload_len;
>>   
>> -	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vz")) != -1) {
>> +	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
>>   		switch (c) {
>>   		case '4':
>>   			if (cfg_family != PF_UNSPEC)
>> @@ -736,6 +743,9 @@ static void parse_opts(int argc, char **argv)
>>   			if (cfg_ifindex == 0)
>>   				error(1, errno, "invalid iface: %s", optarg);
>>   			break;
>> +		case 'l':
>> +			cfg_notification_limit = strtoul(optarg, NULL, 0);
>> +			break;
>>   		case 'm':
>>   			cfg_cork_mixed = true;
>>   			break;
>> -- 
>> 2.20.1
>>
> 
> 

