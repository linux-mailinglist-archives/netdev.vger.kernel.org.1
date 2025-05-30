Return-Path: <netdev+bounces-194423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 144ADAC96A8
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 22:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E0C1C00DE9
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 20:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A09C27AC30;
	Fri, 30 May 2025 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c2sjHzJ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7115990C
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748637464; cv=none; b=eqSmSsRxrU2p0pqnKrtGT3QY9IIT+N8O0j9L3UNn9mFps6DapNUU6R7n1Wv/rfWbC2ppPRF07elPFNjFczDFPlOyi+9BnacfAs23pC9wUbp4kERn9vZ2JdQ2Krx02AKRLjcnHuzGLmZZWnamNnkS13SBKfnpfnPABd0D7HK5B9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748637464; c=relaxed/simple;
	bh=09yRdOfHBBD74x72EqLl8KAykD8f9mVnzkSL5l54rpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r654LGFTUoc/IAPvp/u6niv02X93TBxROFfSprXzi77j7ekNt/Ng+/8go5MsonZsrsXYmpmXdo4Sz032VfCFR5E+LeQDq/iJRXF4Y/1v3UJWbimlHse9A91gewUn29v5Aawd80z/7W/w8ptQBuwOH26ICmFFq8QDBKIje+u8Yts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c2sjHzJ4; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d094d1fd7cso328862285a.3
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748637461; x=1749242261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s72Ujra1dO1NPQly4HIiBu9QKTze5HeShyxVLbJudtM=;
        b=c2sjHzJ4s0dBEI6hRzOHCmVa9MhGbPmygDaOCJgrRrtC+sYxRQlm5V1nb3vE6R/CYE
         oqu9GO6nYsoEqhjuxW3VG+g1IUDJcyB0ObbwGj6TqoESQkCMBR6mIj4pU4EQxUxAvlRT
         tU1NJ8ek6CdLMmusfs9udNKonTzfGBPg2WRg9NjuXMV+s+fSzAgrlUlnC1+e3hRkOzAG
         RkvrX8KEdpR/BBkUdCAccbXlTPis8q0cHFhrA6Hp/IQsccAZLzWlzbm3bJprSNUt0U6h
         7Zc73g8p1DnEu0lPrMejOARNOGUEB9XMgqAq4GrL5dIy7QTjAvXWoqVHK7wJW7d7XhgP
         Vf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748637461; x=1749242261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s72Ujra1dO1NPQly4HIiBu9QKTze5HeShyxVLbJudtM=;
        b=WpGutEXy6v2LTWvHEZuPpR0wuZaFHzr36fk9eQBjJB5lamwrfKS9ojbcFu5RwnlVqu
         HOtWGPAo1+MxV+0L++EsKBL2j9u4aHlmjT0YZD4rKUrYvPD8Gr03SLN4P4KB2oWc6Tgh
         Q/6s3BpfREVcwUYmuBaY7eWGdZBPck57NGvCLR65MKeQm7pj5KWvZe5i6iu+l+yeAI+r
         5l7uz0QB16pb32P+26kFiZzkv29574fmaotbO9LU06DRlIBS1NQAqUzE7mBUwIepO7/T
         xwU3qmZ6Pcg6wusHf4TkxTOAgLav3r3SvYHm0XcdaUzKfIJjCS2BD04AMkGXDzEJpRCT
         S25w==
X-Gm-Message-State: AOJu0YxL4uwuu53RRCXcQPB74XASiuqdImbCEVGKTNCgrPBUm8UPQqW8
	PbRpmRC9XRqiazY7AAW3V3mthaDz92mbO9QJchkR5ImN9m3t0oeBNEPk9H/RsPqFOx4=
X-Gm-Gg: ASbGncu7QeMI7I6UmEUzjqRhnWWBPtYqgMC4UdmDnYuARiMi2+JGrTJsHQvja/98Rq1
	UB0br4adUMBMu1C9TbVhTAtTYN+1+m5lOXMuAbdTdO9BP6NHT8ZtB/6q9/2yZ7dlI3iUtTSEFqS
	air6VAshmEeAV8MD0lvyC19SmUzOs1J/3JajZGkAlBObdQwNxDFy+GqKEeTXtPx3oKyWAE9fY+m
	PQBn0hEuSBYpJvW4Dflzn0YAcNTBJp5l/3zAb6coWtpabfjKF1j5Sb3RTOzhmyzG/OifANsQ+il
	xwgSfxstE2J+gaWCcAaiG3IDug2BsYCycwFv7BrydCy4bATrA3fD1+mRG4YfcF6lF3sRd4r/3mM
	vhhvbJg==
X-Google-Smtp-Source: AGHT+IGZyi5LZ/JJwRsDNg0g5DsqwCg5tBuBsCGwJaLgYtecTvK77ooayzvoj9wwz0v5+xfUDGtuJw==
X-Received: by 2002:a05:620a:2996:b0:7c9:4d4d:206e with SMTP id af79cd13be357-7d0a49e68c6mr559805085a.6.1748637460855;
        Fri, 30 May 2025 13:37:40 -0700 (PDT)
Received: from [10.200.180.213] ([130.44.212.152])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a115a38sm291574585a.59.2025.05.30.13.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 13:37:40 -0700 (PDT)
Message-ID: <9e167af1-1265-4427-806e-67eac349cbf3@bytedance.com>
Date: Fri, 30 May 2025 13:37:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch bpf-next v3 4/4] tcp_bpf: improve ingress redirection
 performance with message corking
To: John Fastabend <john.fastabend@gmail.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, zhoufeng.zf@bytedance.com,
 jakub@cloudflare.com, Amery Hung <amery.hung@bytedance.com>,
 Cong Wang <cong.wang@bytedance.com>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
 <20250519203628.203596-5-xiyou.wangcong@gmail.com>
 <20250530200735.hhzeicomnb7mbwdl@gmail.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20250530200735.hhzeicomnb7mbwdl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 1:07 PM, John Fastabend wrote:
> On 2025-05-19 13:36:28, Cong Wang wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> The TCP_BPF ingress redirection path currently lacks the message corking
>> mechanism found in standard TCP. This causes the sender to wake up the
>> receiver for every message, even when messages are small, resulting in
>> reduced throughput compared to regular TCP in certain scenarios.
>>
>> This change introduces a kernel worker-based intermediate layer to provide
>> automatic message corking for TCP_BPF. While this adds a slight latency
>> overhead, it significantly improves overall throughput by reducing
>> unnecessary wake-ups and reducing the sock lock contention.
>>
>> Reviewed-by: Amery Hung <amery.hung@bytedance.com>
>> Co-developed-by: Cong Wang <cong.wang@bytedance.com>
>> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> ---
>>   include/linux/skmsg.h |  19 ++++
>>   net/core/skmsg.c      | 139 ++++++++++++++++++++++++++++-
>>   net/ipv4/tcp_bpf.c    | 197 ++++++++++++++++++++++++++++++++++++++++--
>>   3 files changed, 347 insertions(+), 8 deletions(-)
> 
> [...]
> 
>> +	/* At this point, the data has been handled well. If one of the
>> +	 * following conditions is met, we can notify the peer socket in
>> +	 * the context of this system call immediately.
>> +	 * 1. If the write buffer has been used up;
>> +	 * 2. Or, the message size is larger than TCP_BPF_GSO_SIZE;
>> +	 * 3. Or, the ingress queue was empty;
>> +	 * 4. Or, the tcp socket is set to no_delay.
>> +	 * Otherwise, kick off the backlog work so that we can have some
>> +	 * time to wait for any incoming messages before sending a
>> +	 * notification to the peer socket.
>> +	 */
> 
> 
> OK this series looks like it should work to me. See one small comment
> below. Also from the perf numbers in the cover letter is the latency
> difference reduced/removed if the socket is set to no_delay?
> 

Even if the socket is set to no_delay, we still have minor latency diff.
The main reason is that we now have dynamic allocation for skmsg and
kworker in the middle, the path is more complex now.

>> +	nonagle = tcp_sk(sk)->nonagle;
>> +	if (!sk_stream_memory_free(sk) ||
>> +	    tot_size >= TCP_BPF_GSO_SIZE || ingress_msg_empty ||
>> +	    (!(nonagle & TCP_NAGLE_CORK) && (nonagle & TCP_NAGLE_OFF))) {
>> +		release_sock(sk);
>> +		psock->backlog_work_delayed = false;
>> +		sk_psock_backlog_msg(psock);
>> +		lock_sock(sk);
>> +	} else {
>> +		sk_psock_run_backlog_work(psock, false);
>> +	}
>> +
>> +error:
>> +	sk_psock_put(sk_redir, psock);
>> +	return ret;
>> +}
>> +
>>   static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>>   				struct sk_msg *msg, int *copied, int flags)
>>   {
>> @@ -442,18 +619,24 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>>   			cork = true;
>>   			psock->cork = NULL;
>>   		}
>> -		release_sock(sk);
>>   
>> -		origsize = msg->sg.size;
>> -		ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
>> -					    msg, tosend, flags);
>> -		sent = origsize - msg->sg.size;
>> +		if (redir_ingress) {
>> +			ret = tcp_bpf_ingress_backlog(sk, sk_redir, msg, tosend);
>> +		} else {
>> +			release_sock(sk);
>> +
>> +			origsize = msg->sg.size;
>> +			ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
>> +						    msg, tosend, flags);
> 
> nit, we can drop redir ingress at this point from tcp_bpf_sendmsg_redir?
> It no longer handles ingress? A follow up patch would probably be fine.
> 

Indeed, we will do this in a follow up patch.

>> +			sent = origsize - msg->sg.size;
>> +
>> +			lock_sock(sk);
>> +			sk_mem_uncharge(sk, sent);
>> +		}
>>   
>>   		if (eval == __SK_REDIRECT)
>>   			sock_put(sk_redir);
> 
> Thanks.

Thanks for the review!


