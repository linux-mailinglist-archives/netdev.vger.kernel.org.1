Return-Path: <netdev+bounces-252384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JyiAP89cmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:10:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D0A68701
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2594A7CA1C3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B713587B3;
	Thu, 22 Jan 2026 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXdnTOWi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrxBHd0O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED814326958
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093356; cv=none; b=T5yF1u+2rMCWEqj1fOVmEWShbNGTOMXCekdnG9kX917lkRjRSvR551rdE2X3cj1xxOdBxYhDMJ/3Rxu5K+zIACPekmNqvGhKKcPOpGV2RfYGgtgeZm9bP93x45xbyr9FVXYZL3dtocqMrRmEg2QMV8OjdibauGzSLMEwInwGZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093356; c=relaxed/simple;
	bh=n5yIv4yEWaK+J9ZNezHfsjGrO4Cg8B3L8qjCmu4gCsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2KlIGMEV8JuXhqCXwiId3EQ1Rc93geMc21OUPFFuKYRqiMq7/xXAp0XC5HRSePqkmpb2bv7kqUTIQJQakV8cwcf8kKmao4vGxIhnC+yvIMqzM6neXdB1tXHAPrbt6Jd97f0bChBoi4pZphIvv0W9+dnqc0m5ieS0aHGZ2qqHec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXdnTOWi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrxBHd0O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769093353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QO5Ssnc82cnZaOGinNMEy5cNLP7JuGESksHbT/jvd40=;
	b=YXdnTOWivOXfIsFg+CcYVArxB6P/jHgcjQcdqqpWYtBAXFTLNSUwbJuvow/NnEbl2Pfdez
	W8uFS3xjs5xqcmJGRO5LpQQ5IBdtV2E8+geppZ65O3sN5w/E/OLZGXtYFIs3lIRvgDl5QZ
	E/U1fXiDJoO1vifSDVcmPQfBQmCjAgo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-1WtFpuueNoC8j7lIuWZXug-1; Thu, 22 Jan 2026 09:49:12 -0500
X-MC-Unique: 1WtFpuueNoC8j7lIuWZXug-1
X-Mimecast-MFC-AGG-ID: 1WtFpuueNoC8j7lIuWZXug_1769093352
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4803e8b6007so11088275e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 06:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769093350; x=1769698150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QO5Ssnc82cnZaOGinNMEy5cNLP7JuGESksHbT/jvd40=;
        b=BrxBHd0O0K/Aw8V914ou1Yfb5iqlaoZHrCHxKeEllVi18VF0fuNmpANM48/Bns5m5f
         gfC7l6xPRU04FliUdMQwjQfFCSdW8BFLr/VGJ3UZOO6yfP2n7pe6gdytpQVc3B6+o+tm
         uiHRufEwxoEHdJ9AwOK/50fTKJEiONU7JlnQoDUObrJZL/uDa3XZpSTMtTl2WGiHL21+
         eB43kHot4slT888jnDzpX8atxBAVcvBlwYPwtPjlxuDcQGrzK2oDzeww3cZjPA6Bl9VW
         QVsdK5M411VVwF2xpbQvTr0BFe8YdgmZ21ElYC357OZcXpBkR2Ruh6fNXu/pyL+nfrK6
         u5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769093350; x=1769698150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QO5Ssnc82cnZaOGinNMEy5cNLP7JuGESksHbT/jvd40=;
        b=R1kJXMH2gbPFnxHt+aCymw/DcKacHU3MlQi97/Go7HhkedQqt/TKJLvd2M/YsS560Q
         Z6jLowCjO41dXNfrPmaN2+3QoJC0E8S9OcK4dcqFnx37h2RhCFfLh0xnwg8dtBfpZ9Rc
         563a97b48D4ear4NvwkmHogvsW/XwLBePOk9y2QMnV2+Oysqy48J8mKyktEG0eVGbqDy
         80EF5XP8DgR1FyC4CzkH37kerLrZOKGTW0Cvbx5gygIFFhJM5bNYp7KMmmHCgwab0N0H
         O086Tgd/TQSwMUkZMMmfXtL+iC+/5uZ1aEO/p9lE4BCUSYdOKXyVzMAytFktdZokYL91
         Lj/A==
X-Forwarded-Encrypted: i=1; AJvYcCXDFEysB6VX/rsLbg8I5ihR6qfxlIagVdPpWTXIgoy+/6gtJLNU5ouZ3SSskPv806e0xY8H73U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFdZvG2nI7t6WIOmUXBwlOp3atKjUhax6pZ9enwPlJovY9aYVe
	ttHcMe+OP0cGVJbMfUQALF7qIRfkgIC2/9hXTQH/w+yyXEmG+Zn8WKerrdHcbIq/D3HDTRRp1HQ
	iEF+RAxEH4JWdMPYiVcPhLf1FUFGf5e9tEuvcvCyrl7AVzBwEObCAzWuckA==
X-Gm-Gg: AZuq6aI7TGIJorvVUUnpzAtm20d/nBW2urDARWV5YrD8NTA1mtFnV3faqy4KNZQ3Wg7
	y8Jpb12RNF57jXcBg/5O2qQadQwGLlPyetg8MJThgSd4OoMHghyEGaE2lXW67REc0pcaV9uRx+4
	w/fDxIJlEvXtTNgcznx0cCp84yDd9yKcxVu78Yu/4bAUxdOtvvOYu+TVDIRCt83++GKWKiuOQfS
	empcFn9ayzQXTWpZ3kDWCOgt1n1e0++Jm026HKWgprm7iYENEiAVWwxslJOwQNs+6eLAlriCUnn
	cMVNg2+tPENzbi9Z0WG6icQZFNs/4gcuS0GzIAeM1o4J4BllduYEZS0wcVBp5hJnPObj+GjotAi
	ASKGIGA4oS4NX
X-Received: by 2002:a05:600c:3e1b:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-480469fd331mr58493405e9.36.1769093350048;
        Thu, 22 Jan 2026 06:49:10 -0800 (PST)
X-Received: by 2002:a05:600c:3e1b:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-480469fd331mr58493035e9.36.1769093349604;
        Thu, 22 Jan 2026 06:49:09 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e664sm41035217f8f.30.2026.01.22.06.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 06:49:09 -0800 (PST)
Message-ID: <6fdf2b6c-2c92-4b74-b746-6c68ed7cdf59@redhat.com>
Date: Thu, 22 Jan 2026 15:49:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang.tang@linux.dev>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com,
 Eulgyu Kim <eulgyukim@snu.ac.kr>, Geliang Tang <geliang@kernel.org>
References: <20260122131306.2119853-1-edumazet@google.com>
 <CANn89i+wyDiyq13nn4_NkckA0A9z7ybeKRXaC4A-VS0yFc9GQw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+wyDiyq13nn4_NkckA0A9z7ybeKRXaC4A-VS0yFc9GQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,strlen.de,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,snu.ac.kr];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252384-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,5498a510ff9de39d37da];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[free_list.next:url,snu.ac.kr:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 45D0A68701
X-Rspamd-Action: no action

On 1/22/26 2:54 PM, Eric Dumazet wrote:
> On Thu, Jan 22, 2026 at 2:13 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> syzbot and Eulgyu Kim reported crashes in mptcp_pm_nl_get_local_id()
>> and/or mptcp_pm_nl_is_backup()
>>
>> Root cause is list_splice_init() in mptcp_pm_nl_flush_addrs_doit()
>> which is not RCU ready.
>>
>> list_splice_init_rcu() can not be called here while holding pernet->lock
>> spinlock.
>>
>> Many thanks to Eulgyu Kim for providing a repro and testing our patches.
>>
>> Fixes: 141694df6573 ("mptcp: remove address when netlink flushes addrs")
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Reported-by: syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/6970a46d.a00a0220.3ad28e.5cf0.GAE@google.com/T/
>> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
>> Cc: Geliang Tang <geliang@kernel.org>
>> ---
>>  net/mptcp/pm_kernel.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index 57570a44e4185370f531047fe97ce9f9fbd1480b..1a97d0eafa2b0c9e4275b90d4a576f837dc286a9 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -1294,16 +1294,24 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
>>  int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
>>  {
>>         struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
>> -       LIST_HEAD(free_list);
>> +       struct list_head free_list;
>>
>>         spin_lock_bh(&pernet->lock);
>> -       list_splice_init(&pernet->endp_list, &free_list);
>> +
>> +       free_list = pernet->endp_list;
>> +       INIT_LIST_HEAD_RCU(&pernet->endp_list);
>> +
>>         __reset_counters(pernet);
>>         pernet->next_id = 1;
>>         bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>>         spin_unlock_bh(&pernet->lock);
>> -       mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
>>         synchronize_rcu();
> 
> 
>> +
>> +       /* Adjust the pointers to free_list instead of pernet->endp_list */
>> +       free_list.prev->next = &free_list;
>> +       free_list.next->prev = &free_list;
> 
> 
> We have to test if the list was empty, and avoid the synchronize_rcu
> in this case.
> 
> I will squash in V2, unless someone complains.
> 
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 1a97d0eafa2b0c9e4275b90d4a576f837dc286a9..af23be6658ded4860133bb9495c7738014815d28
> 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1305,6 +1305,10 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff
> *skb, struct genl_info *info)
>         pernet->next_id = 1;
>         bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>         spin_unlock_bh(&pernet->lock);
> +
> +       if (free_list.next == &pernet->endp_list)
> +               return 0;
> +
>         synchronize_rcu();
> 
>         /* Adjust the pointers to free_list instead of pernet->endp_list */
> 

LGTM, thanks Eric!

Side note: I think is very busy elsewhere and this could go directly via
the net tree.

/P


