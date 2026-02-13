Return-Path: <netdev+bounces-258659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDCwBlpkj2n6QgEAu9opvQ
	(envelope-from <netdev+bounces-258659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:50:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C8F138BEC
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A383039CBC
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E29C26FA77;
	Fri, 13 Feb 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUPi1LNk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE117555;
	Fri, 13 Feb 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005015; cv=none; b=bw/Qaz1bqGlhum04iHpwdCrKmR/OJ/YkP3I6NpDL2ENK4nOnpTcxTBKZDHZ4BTzmPuBt39ohzvJFB4+KUvxwe1Yl9dDrpVClSy94NBMzeYoD+8SoJtzxV7DC44Zi4TvoM9VBrZ0QYbSC+v05eBwfiNsoyyc4JiAdBXVXvh8ntjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005015; c=relaxed/simple;
	bh=yV+n5t3bhZiNowfgdaluBYucTqAeFF0YgQPwfgowN1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNzJoSMNQ79uEKe/xnImSu6nIKTR0IAfnrPgvACfrw/OaDR7QQ34NgRPyw1suxoVK/MAn1AXqMvJXeb+qn4s3jwweAi+kxH9X1bIpwCp6veoKg5NexA7pgdaoG6D3W7zvyTPWRCsEsHeQ7+xPMBIcXFr1lYCL2QVA7I6Qdm+s64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUPi1LNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B99C116C6;
	Fri, 13 Feb 2026 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771005015;
	bh=yV+n5t3bhZiNowfgdaluBYucTqAeFF0YgQPwfgowN1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bUPi1LNkE7jZCCQU2LXR+gJvBN7Iq7Lle+VGZ4jeLizNCXmi8zEC72/e5evMOgoOr
	 LkwmdP+9fCdfmdxVAxiscNnlL+D0mDMGfkOxr3ay08CBnwniwJvN9aA33/0NBBqGj3
	 avzStgkmpaTLR/WOFBQKWsx2vwenPNu2GUZq+CAqGSPsDQZKNpCrWByKQ9xiBHrKyN
	 NxoCGW8QUuThGdKnDpnIOnm7pVGAAHTF+SwvNLSIuoyA4MHarVvx3LQWt4Uo89OOk/
	 vtHK248MPDsN6gbxzBC+w/M6Dj0q6c5BndOowlras0u9f/WFbCIiqHLfVv8cJp2j5L
	 ny/gl8S07LFoA==
Message-ID: <25d8d1ab-b01c-4416-9f8d-9f29e59dc781@kernel.org>
Date: Fri, 13 Feb 2026 18:50:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/6] net: sched: introduce qdisc-specific drop
 reason tracing
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, atenart@redhat.com, carges@cloudflare.com,
 kernel-team@cloudflare.com
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039506239.2258217.7863252279149995024.stgit@firesoul>
 <f1827414-b6c4-47de-827a-9f9f4c796cf8@redhat.com>
 <dda23104-3ca9-4f81-aa79-b0517a9cc5a2@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <dda23104-3ca9-4f81-aa79-b0517a9cc5a2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258659-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,vger.kernel.org,gmail.com,davemloft.net,toke.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61C8F138BEC
X-Rspamd-Action: no action



On 11/02/2026 09.46, Paolo Abeni wrote:
> On 2/11/26 9:36 AM, Paolo Abeni wrote:
>> On 2/6/26 5:24 PM, Jesper Dangaard Brouer wrote:
>>> @@ -593,7 +591,7 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
>>>   	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
>>>   		if (!q->drop_early && must_drop(sch, q, skb)) {
>>>   			drop_and_retry(q, skb, sch,
>>> -				       SKB_DROP_REASON_QDISC_CONGESTED);
>>> +				       QDISC_DROP_CONGESTED);
>>
>> An explicit cast is needed above to avoid compiler warning (or you can
>> change drop_and_retry() signature).
> 
> I see that the type confusion issues are handled for good by later
> patches in the series, but I still think it would be better to avoid
> introducing them with explicit casts as needed (removed by later patches).
> 
>> Also a few lines below there is another drop_and_retry() calls that is
>> not converted.
> 
> I see it's handled by a later patch. I guess it would be useful to
> mention such fact in the commit message.

Yes, this is handled in patch 3/6.  I acknowledge this is annoying from
a review perspective, and also wrong because I'm leaving compiler
warning that I'm fixing up later.  The reason for splitting it out into
a separate patch was because I wanted document (in commit desc) the
special usage of SKB_NOT_DROPPED_YET as a sentinel value.

I'm leaning towards folding patch 3 into this patch 1, as suggested by Toke.

--Jesper

