Return-Path: <netdev+bounces-259077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLJKGsuOlGn6FQIAu9opvQ
	(envelope-from <netdev+bounces-259077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:52:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A775F14DBA2
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63100301ABA9
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41A236C0BD;
	Tue, 17 Feb 2026 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHA/Z4Ul";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PadDXZQP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF39286417
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343560; cv=none; b=DFFEwgFsmhNeq6jMQEygMUYpy8y+JvcWj7aMiRjFFJJgCRHB+QrppqgLRdjsJjjLfUhvZMJzP/rJ4e5YGZEi1Ys4wvLvevLnqe7jg6XfKSRHZ+34YbkCki3fp0DN2BRKwOza1GQzC5HCfkg7BNitVP5XbfU/FKWV4BiISHFrGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343560; c=relaxed/simple;
	bh=cmWGQpxlfefp21UR/k/FXrYAIKpBSYWFy/h9m1Sb0rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/JkU+GxUvAlFTPKHIT2YA4uMuW1GoTXHPbpsN8F5XQEmln9M1zahpNoB6uYMxs1EFLYaN7didPXLbyImrzsXTar9ydcJJieYnrnRINQn29grjgYECKItcYBHvpeDv5XKny9UJ4pshGQI8tLNBbCLTUi1lRYK4B+Px8eGEBiIxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHA/Z4Ul; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PadDXZQP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771343558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zW4I6qN2l9IF3Jq18nch/YuBSC86RHv1R/1ce3rE5Mk=;
	b=jHA/Z4UlHCD8pShaImU/jaQnAyUwrcvYKuP+NH8s+vxsPJT4vsfOuNO/+5nDJzCQozpBcc
	exPie+wQJM0eMgMpIE/rdJDJC7S5Nvm8Lh/ppw9n1C1UBP8ApijHDcP3tmH3XNLvLiO288
	uxXqn1AjzC4ALZMaAQBUeUYY+E3U+98=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-fo26ZjboOuGvCQ_qVx0hNQ-1; Tue, 17 Feb 2026 10:52:36 -0500
X-MC-Unique: fo26ZjboOuGvCQ_qVx0hNQ-1
X-Mimecast-MFC-AGG-ID: fo26ZjboOuGvCQ_qVx0hNQ_1771343555
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435a11575ecso4244912f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 07:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771343555; x=1771948355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zW4I6qN2l9IF3Jq18nch/YuBSC86RHv1R/1ce3rE5Mk=;
        b=PadDXZQPM2/l3Ugt+IvO2XaStS+5tt9Sa7meevk9kDGMv2ItdGebL0X092TxzgRSoi
         ewzDbc0qrUJCMJ7QdgGH9G9N4vfjWnnwgdBp9fWk5PCmeY9ZoSZ1/lhu00JfMGXwhDIF
         0BUZtG9EYtO9Fh8qi67jQWsWLkXwXEGG1ms2myQHYgsd6lAzXZtrxpAyCxEA5rThGfxu
         GTYeXIG6IGppVh7DXFiNXMC75cDHT6u+LE4osDIUoMQSrW+wzHDt5/Q03fdlQgS0D9Qu
         4BiQSJPq2fb8K4LHQTWFr0DreT6j9+7BoebhAowiWT8uEfO1ENktXJN1h4EZBpHTsHeV
         slDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771343555; x=1771948355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zW4I6qN2l9IF3Jq18nch/YuBSC86RHv1R/1ce3rE5Mk=;
        b=wB8ThefOYSsBARUGSY/P5OOa532VQqW3ykBmkW6UAjl1B3Jz3zx7Xn2A4Mvspd8z/R
         nP8JaQOL9818I8ky4kleHkjmQLVt+T68ZciAFPGwX1eRR12ig5ncPM3jQBUE4nFBT5/B
         fKNrDMCjUY/99jLDyIdQ9hGBwWyRDFBm950+1lSclftN2T6Ry+Qa1tuWSxpNnXTHmno0
         UsyT94mFLL9i0OF/Nhmxwd7l1jQIy2qPPiFLGRMTgf1lzcci2YZhGzhMflHaxevD4cbU
         wcNyC3c8IqdOkgEmfsXE8FT/ayZjzwERJe/EYZ/FOHGxH3dlGClvSgMLQTYBVRwgSdrJ
         m+yg==
X-Forwarded-Encrypted: i=1; AJvYcCXh8jcXePGH9mJqJHpwU56w16hXyGqQKCwcRRhsodYTZN/LIuKmVdSbUkOdjEoB8rfR0R4eGqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfXI7Fa0zRnzZbu1DXy5NqJNm4qFALEOzx60yKqwe19IkKeV6O
	+Ap/LXROiPGrF14N59US4SnFV6LPtBs38txdhP8Z5i22tSOzd+tpiO7XGeO0xKPFgXwKB/aUANH
	FQAhF6LTbiHvDS5G7yIHl4iX9jcRK1uRpsVEoY5Wc+exQosFCpCSa2qVFlw==
X-Gm-Gg: AZuq6aLiOcvtk+o/HsecB2p/dz9Uii9S1aTPNzbB01c14lTPQp1/JU5o1YK5AXnsu4d
	jAYqMZ4xusSeICs55F33LH+ZP2oxIFA5X1HdIJhiiKmLl/1Ya7ZFnjeVtWGlwhisyp/0lDyWwbZ
	npDCfgJzAbVE2QZ8cLbDRGUofmlFJYZNjzxti48NEZzLPFSCwrFgWg+QAnE20M4QrJUG+ITYZTo
	NQ7ADFAwg5cC6UJPPw0s4aYKC6MMbaZ4oOHBtPiS0oJeI4s7Y/Tsj2tAMkE54BfrwkdPxWxEISc
	WA1mPYNbZzGO2wF0ZWBfxeOgsNkqTh/A3671Khj9c3hFbRv8ov+/A/xXGjpJ/Fspz+MRrwndP9L
	wgcCUYBoPDk0xTMeESZSfOVd/ZA==
X-Received: by 2002:a05:6000:310d:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-4379793ef97mr24704284f8f.55.1771343555275;
        Tue, 17 Feb 2026 07:52:35 -0800 (PST)
X-Received: by 2002:a05:6000:310d:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-4379793ef97mr24704238f8f.55.1771343554720;
        Tue, 17 Feb 2026 07:52:34 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1bfsm36771425f8f.13.2026.02.17.07.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 07:52:34 -0800 (PST)
Message-ID: <ecfc49ae-99c9-414e-8b8d-211112fc5873@redhat.com>
Date: Tue, 17 Feb 2026 16:52:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net_sched: act_ct: drop all packets when not attached
 to ingress
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Henrik Steen <henrist@henrist.net>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Bob Briscoe <research@bobbriscoe.net>, Olga Albisser <olga@albisser.org>,
 GangMin Kim <km.kim1503@gmail.com>, Eelco Chaudron <echaudro@redhat.com>,
 Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
 <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-259077-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com,redhat.com,strlen.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A775F14DBA2
X-Rspamd-Action: no action

Adding Florian, too

On 2/17/26 3:49 PM, Ilya Maximets wrote:
> On 2/17/26 10:38 AM, Paolo Abeni wrote:
>> Since the blamed commit below, classify can return TC_ACT_CONSUMED while
>> the current skb being held by the defragmentation engine. As reported by
>> GangMin Kim, if such packet is that may cause a UaF when the defrag engine
>> later on tries to tuch again such packet.
>>
>> act_ct was never meant to be used outside of the ingress path. Making
>> defrag really works for act_ct outside such constraints range from very
>> difficult to completely impossible.
>>
>> Address the issue making act_ct drop any packet when not attached to the
>> ingress path and additionally emit a warning about the bad
>> configuration.
>>
>> Reported-by: GangMin Kim <km.kim1503@gmail.com>
>> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
>> CC: stable@vger.kernel.org
>> Link: https://patch.msgid.link/16f6b264373ad60ab18eb8525809e7267442afa7.1770394932.git.pabeni@redhat.com
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> Catching the bad configuration at runtime instead of init time to reduce
>> complexity
>> ---
>>  net/sched/act_ct.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
>> index 81d488655793..e8eb0d195f4a 100644
>> --- a/net/sched/act_ct.c
>> +++ b/net/sched/act_ct.c
>> @@ -987,6 +987,11 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
>>  	tcf_lastuse_update(&c->tcf_tm);
>>  	tcf_action_update_bstats(&c->common, skb);
>>  
>> +	if (!skb_at_tc_ingress(skb)) {
>> +		pr_warn_once("act_CT should be attached at ingress!\n");
> 
> Hi, Paolo.  I didn't test this yet, but I'm a little concerned about this
> change.  For TC offload of OVS tunnels, we create egress qdisc for internal
> ports, a.k.a. bridge ports.  This is necessary for tunnels to work.
> A typical setup looks like this:
> 
>     Bridge br-int (10.0.0.1)
>         Port br-int
>             Interface br-int
>                 type: internal
>         Port vm
>             Interface vm
>         Port vxlan0
>             Interface vxlan0
>                 type: vxlan
>                 options: {remote_ip="172.31.1.1"}
> 
>     Bridge br-phy (172.31.1.100)
>         Port br-phy
>             Interface br-phy
>                 type: internal
>         Port eth0
>             Interface eth0
> 
> When a VM sends a packet that supposed to go through the tunnel, it enters
> from the vm port and OVS forwards it into vxlan0 LWT with an appropriate
> tunnel metadata.  Then it gets encapsulated and put into kernel routing to
> find the next hop, which is via br-phy bridge.  Packet enters br-phy and
> OVS forwards the packet to eth0.  There can be stateful processing in the
> br-phy bridge involving passing packets through conntrack.
> 
> With the TC offload enabled, OVS creates following filters:
> 
> 1. Ingress filter on vm interface that forwards packets to vxlan0.
> 2. Egress filter on br-phy interface that forwards encapsulated packets
>    to eth0 interface.
> 
> If some stateful processing is involved, both of those could have act_ct
> in them.
> 
> AFAIU, we have to use Egress qdisc for the br-phy, because the packet is
> egressing from the kernel routing via br-phy and the ingress qdisc is not
> invoked.  Ingress will be at play when packets are flowing in the opposite
> direction from eth0 to br-phy, as that's where they will ingress into
> standard kernel routing.
> 
> If act_tc will not be allowed on Egress, then stateful processing will
> not be possible in this case in br-phy bridge.
> 
> Thoughts?

This looks very problematic. A slightly different patch tried to
somewhat preserve functionality, but it simply can't work in presence of
IP fragments.

Why stateful processing on  br-int/port vm ingress is not enough?

/P


