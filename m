Return-Path: <netdev+bounces-90668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD1B8AF762
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 21:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4F21F22AF6
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 19:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665681411E6;
	Tue, 23 Apr 2024 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W1HduENv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F71411C7
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900691; cv=none; b=ovFzx+TcDFfGdtj54gt6UiOPe3+etryX1pchzTtkKK18/oCVxTVOx3WHfzdW0wFA917cIHV5ePeN9e3B/1P/S+U05eegpXI9MCEYt59c5ADJw18L+1dJFujjWPkM2V3gT5d+sDGa/kmq51VIrJDntwYsOj/rulTyjLH8mZ0eLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900691; c=relaxed/simple;
	bh=DIuFItPYMb/untmVS60nu5zhKj/LmY5kTINvt8IeL+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1qsvtywxgo8t6/3n+n2HXKgH6JwuOy2ozFLbUzjAZ5C+yFfmcwSAXCukVDIjojmg9059Sw8/irr3I88m0kd5LIJq4mNz0fRPQXNYMNdFc3vkVwiFPpKDGCVLfkmF1WYVdmuBG9czgaieGMLMhjas76dIuwo9iEzaPZSGltx2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W1HduENv; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de45dba157cso4885679276.3
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713900688; x=1714505488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBGWAuw6cA4teHN6XusQ98Vx0S4U6mYmyRdKZ/EeBmY=;
        b=W1HduENvP16lQsZkhF/9riXdtujUprR6OuvjKXLdcXKE/m0hqR1LOov6W4MeShUfJb
         m75Y1uTuYqWt015719SBcxGEysO5BFKQnfu69IR9JIniGlKz/ExWfP1N8x7aDyF1BcDW
         WMe4hXyxTYoaRIcBb6INJo0uSo+h3c9fRjaAWJb2FwCZiqORwSIOjbn9yqutw6eCWpxc
         TauRDKrAUn/omMR9aG7At8sZ1Wp+UwhARoLK+AICC+HF8N85vde5YdOEjT9NblaQNePU
         6IwMMjOsVLLmAaXXfV9v/+jWfVtCHfB4F8pHQ/gX+Pyf4bmLQ46PN5k/FLgpfc1b302a
         BNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713900688; x=1714505488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBGWAuw6cA4teHN6XusQ98Vx0S4U6mYmyRdKZ/EeBmY=;
        b=VZo2odgXcDXieERte/unTpxobcIagvd4EGrCvt1y8DiSpbwdg6en82oCAV6zlnCPnp
         KQ+0Aw2SYyFPOd+3KBOrimMrQhjgLcIJMw2L28K+ijYWOUIbRX9EYHJ8e2Ti9FeJeYXv
         BHDm4EKEwONKz7bOYY6hqz+BoQhsLiklfi9YD6GIcJlxsfs16S3MLV7d0hRV2M3Lm5eA
         n5qeejE4sFl+yYBP8KxMEz/tCrVvhzn/PvSZY6qPpxJBcYa7ZrfP+ponUIDxdqiK3JZU
         U98C/VK0yQ50q4attjY8eh5jy6L1OcfCasYHOdvGMRRewAKJmQ5g7wjWvFBGqsN+Y4dK
         ADog==
X-Forwarded-Encrypted: i=1; AJvYcCWp1SxYI7TEaYuOks4BWSN6RgMgPy1VxT+9hK4krK9AMGYnfyXig93scllmCJj7526jQGOUru3NkiaP0P+xe2bUTCvKJaxW
X-Gm-Message-State: AOJu0YwUxi3cqrUdyqAoQMCp5W5vKkjss+5iEeLgQM6za625GXR6Ot+7
	UxRbUhArlgjA8d/KRK4xq4CJ1JSv46wEmjgSELBuUNUDTUYeZXZAeAqwMjYvAMI=
X-Google-Smtp-Source: AGHT+IGX0QuiODT+r/uGAjjS4j19QxQaDfxMhOlGZWDboSyOir1qOuJb/AoZisZe/2pU1MtX6JSJYg==
X-Received: by 2002:a25:ad24:0:b0:dc2:5553:ca12 with SMTP id y36-20020a25ad24000000b00dc25553ca12mr658905ybi.14.1713900688637;
        Tue, 23 Apr 2024 12:31:28 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id m3-20020a252603000000b00de55b3bde0csm284981ybm.42.2024.04.23.12.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 12:31:28 -0700 (PDT)
Message-ID: <a37a16e1-0aa7-4d7c-9b0b-5e7f76fb2368@bytedance.com>
Date: Tue, 23 Apr 2024 12:31:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next v2 1/3] selftests: fix OOM problem
 in msg_zerocopy selftest
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240419214819.671536-1-zijianzhang@bytedance.com>
 <20240419214819.671536-2-zijianzhang@bytedance.com>
 <66252de247122_1dff992949f@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <66252de247122_1dff992949f@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the suggestions, all make sense to me. I will update in the
next version.

On 4/21/24 8:16 AM, Willem de Bruijn wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
>> on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
>> until the socket is not writable. Typically, it will start the receiving
>> process after around 30+ sendmsgs. However, because of the
>> commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
>> the sender is always writable and does not get any chance to run recv
>> notifications. The selftest always exits with OUT_OF_MEMORY because the
>> memory used by opt_skb exceeds the core.sysctl_optmem_max.
>>
>> According to our experiments, this problem can be solved by open the
>> DEBUG_LOCKDEP configuration for the kernel.
> 
> Not so much solved, as mitigated.
> 
>> But it will makes the
>> notificatoins disordered even in good commits before
> 
> typo: notifications
> 
> We still have no explanation for this behavior, right. OOO
> notifications for TCP should be extremely rare.
> 
> A completion is queued when both the skb with the send() data was sent
> and freed, and the ACK arrived, freeing the clone on the retransmit
> queue. This is almost certainly some effect of running over loopback.
> 
> OOO being rare is also what makes the notification batch mechanism so
> effective for TCP.
> 
>> commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale").
>>
>> We introduce "cfg_notification_limit" to force sender to receive
>> notifications after some number of sendmsgs. And, notifications may not
>> come in order, because of the reason we present above. We have order
>> checking code managed by cfg_verbose.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
>> ---
>>   tools/testing/selftests/net/msg_zerocopy.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
>> index bdc03a2097e8..6c18b07cab30 100644
>> --- a/tools/testing/selftests/net/msg_zerocopy.c
>> +++ b/tools/testing/selftests/net/msg_zerocopy.c
>> @@ -1,3 +1,4 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>   /* Evaluate MSG_ZEROCOPY
>>    *
>>    * Send traffic between two processes over one of the supported
>> @@ -85,6 +86,7 @@ static bool cfg_rx;
>>   static int  cfg_runtime_ms	= 4200;
>>   static int  cfg_verbose;
>>   static int  cfg_waittime_ms	= 500;
>> +static int  cfg_notification_limit = 32;
>>   static bool cfg_zerocopy;
>>   
>>   static socklen_t cfg_alen;
>> @@ -95,6 +97,8 @@ static char payload[IP_MAXPACKET];
>>   static long packets, bytes, completions, expected_completions;
>>   static int  zerocopied = -1;
>>   static uint32_t next_completion;
>> +/* The number of sendmsgs which have not received notified yet */
>> +static uint32_t sendmsg_counter;
>>   
>>   static unsigned long gettimeofday_ms(void)
>>   {
>> @@ -208,6 +212,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
>>   		error(1, errno, "send");
>>   	if (cfg_verbose && ret != len)
>>   		fprintf(stderr, "send: ret=%u != %u\n", ret, len);
>> +	sendmsg_counter++;
>>   
>>   	if (len) {
>>   		packets++;
>> @@ -435,7 +440,7 @@ static bool do_recv_completion(int fd, int domain)
>>   	/* Detect notification gaps. These should not happen often, if at all.
>>   	 * Gaps can occur due to drops, reordering and retransmissions.
>>   	 */
>> -	if (lo != next_completion)
>> +	if (cfg_verbose && lo != next_completion)
>>   		fprintf(stderr, "gap: %u..%u does not append to %u\n",
>>   			lo, hi, next_completion);
>>   	next_completion = hi + 1;
>> @@ -460,6 +465,7 @@ static bool do_recv_completion(int fd, int domain)
>>   static void do_recv_completions(int fd, int domain)
>>   {
>>   	while (do_recv_completion(fd, domain)) {}
>> +	sendmsg_counter = 0;
>>   }
>>   
>>   /* Wait for all remaining completions on the errqueue */
>> @@ -549,6 +555,9 @@ static void do_tx(int domain, int type, int protocol)
>>   		else
>>   			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
>>   
>> +		if (cfg_zerocopy && sendmsg_counter >= cfg_notification_limit)
>> +			do_recv_completions(fd, domain);
>> +
>>   		while (!do_poll(fd, POLLOUT)) {
>>   			if (cfg_zerocopy)
>>   				do_recv_completions(fd, domain);
>> @@ -708,7 +717,7 @@ static void parse_opts(int argc, char **argv)
>>   
>>   	cfg_payload_len = max_payload_len;
>>   
>> -	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vz")) != -1) {
>> +	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vzl:n")) != -1) {
> 
> no n defined
> 
> please keep lexicographic order
>>   		switch (c) {
>>   		case '4':
>>   			if (cfg_family != PF_UNSPEC)
>> @@ -760,6 +769,9 @@ static void parse_opts(int argc, char **argv)
>>   		case 'z':
>>   			cfg_zerocopy = true;
>>   			break;
>> +		case 'l':
>> +			cfg_notification_limit = strtoul(optarg, NULL, 0);
>> +			break;
>>   		}
>>   	}
>>   
>> -- 
>> 2.20.1
>>
> 
> 

