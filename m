Return-Path: <netdev+bounces-287858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH5eJruGBWr5XwIAu9opvQ
	(envelope-from <netdev+bounces-287858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:24:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9646353F3A5
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1831A300B505
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 08:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432253D669C;
	Thu, 14 May 2026 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPmZUW69";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfT+ZW21"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724723AEF34
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747061; cv=none; b=cUEcrSXDtIGxBbQqXoLUkGxuRBmAVe2eCbvDcDbKT0WTVdCJ6DFaOUBWBsbXkQ4D2aLu2V/DygsUl1Y98hjOMyGcIVnixW0jVZlKYgiAkAUskUzXNaE7CEbOg4iu0Y3PfMBuYFPie0tmA+tQWXh0JthP0XezIw4uhUXib9W5AbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747061; c=relaxed/simple;
	bh=iFyqX8Am0gjwGcOURZ0Avy1kng5n+zhYNxntjvYbcXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2u1T8pqtqUSqwhgnHlCO5MjGZDfmvt0Mg535snZCVQyVM6IIDZQWaeS2M/fluznkoAtHuu4YLarEfHzPMDTSBENdZ9M2huUniGsga8QOWQSyoa6rzU0IQTMnNKCY8gbrzNxb+u7zK0/nqEUamDt9gD3mLM6cIaVFZ1WGaRCQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPmZUW69; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfT+ZW21; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778747058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFvYCd2Hwf8eGLp50f+3Wf8d59ZGM5uDfQyB3lnisdc=;
	b=PPmZUW69FfuxD+XBfyeh7CzhAOttilWSKOHa6a5fyhhe1wM2xk2ireCYP5CnqVTSI3r4ga
	YvY5maCtqpkrJ83cMgOWWbLmU2hb1JEgWYMQxj+fvEY1fyHbBU0T+QTMDzOluqu4AgZwhR
	2K0Rx4F9OLOsinAq87ubdM1WLKRwlVk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-tAvUUCB3NVWadr_BjA8kcQ-1; Thu, 14 May 2026 04:24:17 -0400
X-MC-Unique: tAvUUCB3NVWadr_BjA8kcQ-1
X-Mimecast-MFC-AGG-ID: tAvUUCB3NVWadr_BjA8kcQ_1778747056
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44d83e45febso6720452f8f.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 01:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778747056; x=1779351856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFvYCd2Hwf8eGLp50f+3Wf8d59ZGM5uDfQyB3lnisdc=;
        b=BfT+ZW21kJGRDiw/ZDS8q7Y+SGolsf3J2IxswK310rjgc0lhPpebhQRTF9VGt23XIE
         Sgr6BPniAlwQky/ZW0w/5OGT2Iqugjxv++P6yoO0quzqOS7zcR73OoYZaHUI4A0dHVwE
         nLSEe4nVAMQKKpVTyT8jNqpmq3sZD/qUgH8DRPYmO5zomdNiSEomoxU99p7QIviCnFIe
         U3mAS9EpHH828L/Ot9SXcUDb23VBu+W3FU8tUa1NOwwqNEcBroEatERIRrJwWhI9WgHf
         SNgxZ5ajrtE1XdDSGVH0J2eBOkIHlH5xkHvGtMvC5j3XBhjwrWpOW2ERTqJZ8XavB/Sz
         rnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747056; x=1779351856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFvYCd2Hwf8eGLp50f+3Wf8d59ZGM5uDfQyB3lnisdc=;
        b=Djvj6ZoXkQ+P5qbP/NNih0Gp5SQF3f0YKs7XhFo7lyP5UeEwgv4yxad5EegVPFR9z+
         CrTHLKucBduLpoYT0IKGUjlO1plfqdUKPx6z1udcqLf/jjpjkCNtRTuQIweRGWYz+X1Q
         4Yp3Lz201oDl4/ALO3e3mI/A+uxFp1KIizwUTagResLJP2FU39k1pDwn9OyuaVG7PgED
         p5X/AqDisFu8pVqlqgHC5QUrTdLBVE/9YhnO4BAieTzWIcdIgreIs31NNJiNbW2N4vka
         t7r8q24L0TpJbscjokgIX4okfG8S84NZnzu0ZwPwknO6uWygxZOWRbeeBvt+h1zh2tDP
         BRIw==
X-Forwarded-Encrypted: i=1; AFNElJ+oJ4rDbm8MpeO+E79ZHcLxlGHT/P1umJcqOGQ4CLyB6wa0kGAQcmc3x52PehTFLoLVXzNFL4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJu7/j07CP1sqB1EV5hkrG4HDu9gX52cIisjEx7CoI1U0jIhYd
	3PqpMgj8yUb2ccQFlBWpm3sJ98m3cA1YXTEQ544PRoK403vcQtJDgqFZGEK4GbKaDC0/gwxn9jB
	tDMz4qkRKfecTDBgSIQwoOvx/Qt4xCYzk18/DJEOuinONxWmvbUrdYaVs4g==
X-Gm-Gg: Acq92OFhyUUvtOdX71mIWKOMpnQUkxLNgcJZjOFbO2+e0tbB5H7BC93kM334bkx4g9N
	bofoOfAqB1lmCMmprQ8QGQj+TyJfX3ArSaT2Q5KVoKCkNu4HouDl4wVwNah6hAaH8m2VNe3vaAD
	FlUHB6aqBgQCSf9pQAiKrT2MEVBm1mQE88393DHDevvJW4Vvd4okYAfOBk0zpygsxcBXVo2JrQr
	r8M4jgerwZqm2kzYE/eAARgjo3dJ1/oYYbcThWWXvsmvptE0TxtuG36rWXSBJCPnM9F2g5McQ0Q
	5LFF2ED1MC0lUTYk43Z2j3j+LEaNXudGS8rJpgmQF3cZzGDu27D/JEmmWjSlO9TL2QCCpSshVqi
	R+DSCyODgMAjguKdV9nm+qtRkXrQBcHhUsxaotd07q2Hr/pPw3x6X9Fg=
X-Received: by 2002:a05:600c:37c3:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48fd646b6e8mr3852115e9.13.1778747055852;
        Thu, 14 May 2026 01:24:15 -0700 (PDT)
X-Received: by 2002:a05:600c:37c3:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48fd646b6e8mr3851795e9.13.1778747055413;
        Thu, 14 May 2026 01:24:15 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64cead5sm46617205e9.10.2026.05.14.01.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 01:24:14 -0700 (PDT)
Message-ID: <ff0a041e-16c9-4e9c-b717-ff8a2bb85d84@redhat.com>
Date: Thu, 14 May 2026 10:24:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net/sched: fq_codel: local packets no longer
 count against memory limit
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 "David S . Miller" <davem@davemloft.net>
References: <20260512094859.3673997-1-edumazet@google.com>
 <20260512094859.3673997-3-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260512094859.3673997-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9646353F3A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,resnulli.us,toke.dk,vger.kernel.org,gmail.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-287858-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 11:48 AM, Eric Dumazet wrote:
> Commit 95b58430abe7 ("fq_codel: add memory limitation per queue")
> claimed that the 32Mb default was "reasonable even for heavy duty usages."
> 
> In practice, this is not the case.
> 
> Packets that are associated with local sockets sk_wmem_alloc
> do not really need additional memory control.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_fq_codel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index 1b1de693d4c64a1f5f4e9e788371829dea91740e..71107dc52be799a14f370f2ad74d2eadd93992c1 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -212,7 +212,7 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		q->new_flow_count++;
>  		WRITE_ONCE(flow->deficit, q->quantum);
>  	}
> -	get_codel_cb(skb)->mem_usage = skb->truesize;
> +	get_codel_cb(skb)->mem_usage = is_skb_wmem(skb) ? 0 : skb->truesize;
>  	q->memory_usage += get_codel_cb(skb)->mem_usage;
>  	memory_limited = q->memory_usage > q->memory_limit;
>  	qdisc_qlen_inc(sch);

I *think* this patch is causing TDC self-tests failures:

# not ok 704 a4bb - Test FQ_CODEL with HTB parent - force packet drop with empty queue
# Could not match regex pattern. Verify command output:
# qdisc fq_codel 10: parent 1:10 limit 10240p flows 1 quantum 1514 target 99us interval 999us memory_limit 1b ecn drop_batch 64 
#  Sent 490 bytes 5 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0
#   maxpacket 98 drop_overlimit 0 new_flow_count 1 ecn_mark 0
#   new_flows_len 1 old_flows_len 0

whole log at:

https://github.com/p4tc-dev/tc-executor/tree/storage/artifacts/645644/1-tdc-sh

Looking at the test code, I think the patch broke it, but the failures
started a little afterward the patch merge, so I'm possibly
misunderstanding something here.

Thanks,

Paolo


