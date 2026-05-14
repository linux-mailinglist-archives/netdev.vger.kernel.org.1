Return-Path: <netdev+bounces-287905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L/cLsCeBWr4YwIAu9opvQ
	(envelope-from <netdev+bounces-287905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:06:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C33F7540224
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D129F300722F
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D138A73A;
	Thu, 14 May 2026 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyQTNrnZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sj7LmSuj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B5026C385
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753211; cv=none; b=UvlZmck3BWeU6bQcxFQyHD5JBWEYSrs6xyIWPuRSSKOVcxP7NhMim/e+HULqEM2J8da4NM5kE2EKJtBEDKXvL2mZLkaUAT48+pUHDXT7uRSsjcUdW4XdC7JlY9g290xZx76OF7zAf+aU45Imv787vmG5qPGETiMBoXTt1zeuiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753211; c=relaxed/simple;
	bh=Zo0AubGdqRbZ+FBNZO7BM/vptbnO3aQb/AozfXDwcN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJ0vpQ/HkFZutiqTWihA6h1IJaYvOL+Gs4nvWuxK1YbHmFcr78ebW6N+tCGPmqNYibNz5gsI9yBUtDDuoRDqshzR1fMn4LhGQc/jkVLmOP2DQxkppqlB7BMUmvIGN2zYOmgJLNj9vKlebiIfdVPmEUF4awLM18ITZ35qsNm5+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyQTNrnZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sj7LmSuj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778753209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJzy/5TWfxuyNBcsMLStOGjPlZfH0xIQTIJv+vQDZg4=;
	b=WyQTNrnZXtFKNt0x5ZUgr3ywSg6esgqpTsm4eanhBA7WyhIJYvMRAEJ8Z6zL3vkYp2NkqP
	Ab2CXn2pROIv64XDjaORdsG1ikuppWtHGAwDx6X9frQE9+NMKTQly2kCOtEnSKQKZppAup
	2eJfx4ZsXU7mSxil4wUHw9az1520ego=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-xV5ksbf7PxGqbhJVvQZ1GA-1; Thu, 14 May 2026 06:06:46 -0400
X-MC-Unique: xV5ksbf7PxGqbhJVvQZ1GA-1
X-Mimecast-MFC-AGG-ID: xV5ksbf7PxGqbhJVvQZ1GA_1778753205
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so4920926f8f.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778753205; x=1779358005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJzy/5TWfxuyNBcsMLStOGjPlZfH0xIQTIJv+vQDZg4=;
        b=sj7LmSujlWgt9uFU+PHYTUTLuk/0pHaOhy7gIaMAhqGdhMTXPXw+ZljKixcjmSquuj
         CE5z9sUC5boaIJFO4+pzNy4nTkXO7d7sfFC82Hn5iD3nSgmIxLUGn5GgtXdlzfY1/dkq
         AXTPWj1l2RwbBtwSobgtX7CiXxvwQqe1kthptyDCULsCiw17OVfdKZMDBOx4XEkxuNFW
         zZmgCd+qYN0wRtjlTU5QRP1Jbp9C+h6FpxXvp2RsKk2WA9UV4QnXB9kGELi0JEBrblNv
         7ipH/t0Hm3A1whxkCCUxqIVatXlhXJ2AMhHIpinUK+9IG1O7Jp4FhA81jI54zCFTsZt6
         1IGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778753205; x=1779358005;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJzy/5TWfxuyNBcsMLStOGjPlZfH0xIQTIJv+vQDZg4=;
        b=KEovtrKCCs2jsMMDu0JgnHZSV6vuXu0K3BfaoGvRHkRKR43pShlIO1N42Ylv7BUDO2
         8Zvd3lE7zI7VhgDeVluEG11TsJH5rlAjnLhknjGm8DFiQlhI83vADUkrZAF1R4sPMEkF
         CSrcrp7yt7BPv/1GvoDqXGs6cj1FrurxZYgrVEuXGsuPvLD0gVHf3kCmVZFXFeL2ykCG
         /lfZCiSv+5eLuVP9GgdW1Rih88V9HupPpU+YyAP61XomtFwKOAHpxvWzQCDhaUNtbWFv
         57fCGSQ3AZvYfX/zTmFT7Ul/+o4vr2PDjKKeyjzAHu/UQmQtlPt26NP27Yui5nICPHGU
         o2Sg==
X-Forwarded-Encrypted: i=1; AFNElJ+a4FByLVTtBH0ZeiebYSShD8zRTQpK20i9YrU+ZbG72QirJXo/7iDufmQzyFTiN2xFttGX2cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyGCuPWvswnVWwcg/kk+duBjwIIwEd4XGNWOD7AMBdEC3XLtuL
	HJpAjYbgK0/WCVW37cq0WESZ/ALOT162fG/AC6aGfDvX3HbNtdZh5CnrCAXt0sOGMUhtxyyDsp6
	RnczaxVmHyfd/72ygK3EJA7Q1d6Mj+U6mKiu5FhfX4CEeglG18oLnhAsLAg==
X-Gm-Gg: Acq92OGZOh7ST9QIyAgD3pHMhmwLmpAnbvnMwcKSIBD6JezID90fqyicjNf5eHC32uD
	wdEX0ES2ELPdiKLqvftBx5cUZEwplyA1OpY4BSACkeZzGJi73SrpajZB6qbhHEo8VivyTdp0bpb
	ULPfimUsotqQrPrq2DKG9DOxIGsONVtorzI8VnLuBXAxVFw8kR8uWaNOK+hEFpwQaiolsJJ2hb5
	kfaV11PIMPosUy7JdjorqBy3KsxKZSsLGXLrKmwd+I0YB2svWOlYZOhgxbxt3xHixt7TZTBuTZf
	R6AkdH7bzYD5fUpPOmQnZSg+N/WKfh7rV4JOI6HiwbQumFIn7h8ucdLAlzo+6BBFfQIojzLiOEV
	RhbsRbDKw7b3nCFQGtd/+1fqlS20CmDJ59ggLuSPhop22lA+04uAkQ4o=
X-Received: by 2002:a05:600c:4ed1:b0:489:a4:e555 with SMTP id 5b1f17b1804b1-48fc9a41e96mr98884275e9.21.1778753205011;
        Thu, 14 May 2026 03:06:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed1:b0:489:a4:e555 with SMTP id 5b1f17b1804b1-48fc9a41e96mr98883835e9.21.1778753204551;
        Thu, 14 May 2026 03:06:44 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdafb6145sm20539805e9.1.2026.05.14.03.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 03:06:44 -0700 (PDT)
Message-ID: <1b6d8eab-798b-4dce-be1b-adc93b0fd9fc@redhat.com>
Date: Thu, 14 May 2026 12:06:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net/sched: fq_codel: local packets no longer
 count against memory limit
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 "David S . Miller" <davem@davemloft.net>
References: <20260512094859.3673997-1-edumazet@google.com>
 <20260512094859.3673997-3-edumazet@google.com>
 <ff0a041e-16c9-4e9c-b717-ff8a2bb85d84@redhat.com>
 <CANn89iJ=t=DPd5cw0YTdcj9dNv9BthW+=3jcHDXgtQYmp1nX1w@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CANn89iJ=t=DPd5cw0YTdcj9dNv9BthW+=3jcHDXgtQYmp1nX1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C33F7540224
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
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,toke.dk,vger.kernel.org,gmail.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-287905-lists,netdev=lfdr.de];
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

On 5/14/26 10:49 AM, Eric Dumazet wrote:
> On Thu, May 14, 2026 at 1:24 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 5/12/26 11:48 AM, Eric Dumazet wrote:
>>> Commit 95b58430abe7 ("fq_codel: add memory limitation per queue")
>>> claimed that the 32Mb default was "reasonable even for heavy duty usages."
>>>
>>> In practice, this is not the case.
>>>
>>> Packets that are associated with local sockets sk_wmem_alloc
>>> do not really need additional memory control.
>>>
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> ---
>>>  net/sched/sch_fq_codel.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
>>> index 1b1de693d4c64a1f5f4e9e788371829dea91740e..71107dc52be799a14f370f2ad74d2eadd93992c1 100644
>>> --- a/net/sched/sch_fq_codel.c
>>> +++ b/net/sched/sch_fq_codel.c
>>> @@ -212,7 +212,7 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>>>               q->new_flow_count++;
>>>               WRITE_ONCE(flow->deficit, q->quantum);
>>>       }
>>> -     get_codel_cb(skb)->mem_usage = skb->truesize;
>>> +     get_codel_cb(skb)->mem_usage = is_skb_wmem(skb) ? 0 : skb->truesize;
>>>       q->memory_usage += get_codel_cb(skb)->mem_usage;
>>>       memory_limited = q->memory_usage > q->memory_limit;
>>>       qdisc_qlen_inc(sch);
>>
>> I *think* this patch is causing TDC self-tests failures:
>>
>> # not ok 704 a4bb - Test FQ_CODEL with HTB parent - force packet drop with empty queue
>> # Could not match regex pattern. Verify command output:
>> # qdisc fq_codel 10: parent 1:10 limit 10240p flows 1 quantum 1514 target 99us interval 999us memory_limit 1b ecn drop_batch 64
>> #  Sent 490 bytes 5 pkt (dropped 0, overlimits 0 requeues 0)
>> #  backlog 0b 0p requeues 0
>> #   maxpacket 98 drop_overlimit 0 new_flow_count 1 ecn_mark 0
>> #   new_flows_len 1 old_flows_len 0
>>
>> whole log at:
>>
>> https://github.com/p4tc-dev/tc-executor/tree/storage/artifacts/645644/1-tdc-sh
>>
>> Looking at the test code, I think the patch broke it, but the failures
>> started a little afterward the patch merge, so I'm possibly
>> misunderstanding something here.
>>
>> Thanks,
>>
>> Paolo
>>
> 
> It seems this test uses a memory limit of 1 byte.
> 
> $TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit
> 1 flows 1 target 0.1ms interval 1ms
> 
> This might be a typo, I think they expected a limit of 0 packet.

FTR, I think/agree a change to the self-tests would be preferable.

/P


