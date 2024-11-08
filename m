Return-Path: <netdev+bounces-143437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21C19C26EA
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46EE7B21908
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC3C1E0E08;
	Fri,  8 Nov 2024 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sXXV1reo"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C621AA1F9
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731100104; cv=none; b=HwiQuUVmBUsZxobYUAFtnjdr3/XdcvoEGDV16KXnTPF/YSidYrsniIRWWkk0WLtJH5YXwOhYrA9flmXp17mEvGDlyVJQ52LjIgfUfy85zGGgDGkVrwUVyzLKhPMrWdvECFyOibCA2dHZXn15JLrGoCheRkEDgVSemH3+K3hnq4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731100104; c=relaxed/simple;
	bh=JjIgWMnQyToPodUFYA4g0djq+fKAypzUgrehtbL2raE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pbkf6gZTXNq2MU2tUBFMT+gZpUfBjqNwvtQ1OmB4E0kUP0GrfA6D936aj1MS8dbaH6D9h5I+sL2WKmKUepoRIvz33aUKKICZM6JwlojSLKdqC+q+RRRhCmIiQobK3zYbk4Hiwuv3/NEvQqo5o0ETrNOSIWZLeiMfKYzMsFGr60w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sXXV1reo; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55fc6114-7e64-4b65-86d2-92cfd1e9e92f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731100099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otUs9kZ/bOaxVccuA7V597M98+y5StW+4hKm15T+i3I=;
	b=sXXV1reoq9dG6hwzK6bU+TqYuSMjPi7YxkhYq9uHi1G9eFxnvK1w1l3jowKWdR1ygGCaNt
	ea8+0DSPtNKhP5RdEUyZNAAcDA1AJG0YmY3IlhMCD8yTsxaSFHL4RBgJVmWquI3fN507jJ
	ihz6Q99W3lEF1v/HaScZcu8BizPpYaE=
Date: Fri, 8 Nov 2024 13:07:57 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: fix recursive lock when verdict program return
 SK_PASS
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: mrpre <mrpre@163.com>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
References: <20241106124431.5583-1-mrpre@163.com>
 <2939664d-e38d-4ac4-b8cf-3ef60c5fd5c6@linux.dev>
Content-Language: en-US
In-Reply-To: <2939664d-e38d-4ac4-b8cf-3ef60c5fd5c6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/8/24 1:03 PM, Martin KaFai Lau wrote:
> On 11/6/24 4:44 AM, mrpre wrote:
>> When the stream_verdict program returns SK_PASS, it places the received skb
>> into its own receive queue, but a recursive lock eventually occurs, leading
>> to an operating system deadlock. This issue has been present since v6.9.
>>
>> '''
>> sk_psock_strp_data_ready
>>      write_lock_bh(&sk->sk_callback_lock)
>>      strp_data_ready
>>        strp_read_sock
>>          read_sock -> tcp_read_sock
>>            strp_recv
>>              cb.rcv_msg -> sk_psock_strp_read
>>                # now stream_verdict return SK_PASS without peer sock assign
>>                __SK_PASS = sk_psock_map_verd(SK_PASS, NULL)
>>                sk_psock_verdict_apply
>>                  sk_psock_skb_ingress_self
>>                    sk_psock_skb_ingress_enqueue
>>                      sk_psock_data_ready
>>                        read_lock_bh(&sk->sk_callback_lock) <= dead lock
>>
>> '''
>>
>> This topic has been discussed before, but it has not been fixed.
>> Previous discussion:
>> https://lore.kernel.org/all/6684a5864ec86_403d20898@john.notmuch
> 
> Is the selftest included in this link still useful to reproduce this bug?
> If yes, please include that also.
> 
>>
>> Fixes: 6648e613226e ("bpf, skmsg: Fix NULL pointer dereference in 
>> sk_psock_skb_ingress_enqueue")
>> Reported-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
>> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> 
> Please also use the real name in the author (i.e. the email sender). The patch 
> needs a real author name also. I had manually fixed one of your earlier 
> lock_sock fix before applying.

and the bpf mailing list address has a typo in the original patch email... I 
fixed that in this reply.

> 
> pw-bot: cr
> 
>> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> 
> The patch and the earlier discussion make sense to me.
> John and JakubS, please help to take another look in the next respin.
> 
> 


