Return-Path: <netdev+bounces-287015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Pm5KRHxAmoGzAEAu9opvQ
	(envelope-from <netdev+bounces-287015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:21:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB05951D8DC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9957C302ECC6
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC9A3B7772;
	Tue, 12 May 2026 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="FVQPvXyT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E023B3BE5
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576620; cv=none; b=s2H8u68P40+SFpTbAHaRbBlEJ2YP8hjmfudprhl21UrOQujNdLB7FiVR30iNlknjoKXDV6TtjNy0tKM4WO1EYCuV2JIroF9lU/A8tSWcy/6bSSGskO+vFGqyqraRoMwIxiMu8miV5OLZZEIhSJ+JPG1k88h5QFW7+8co0YNd6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576620; c=relaxed/simple;
	bh=YaRdS6/HU0UNCZq6d8R/5etKgU5iBv+kQofVt3WrOag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukr7Q6mBsf/Zh+1fA2V4KbaAgZlF0UrWa70vFzLOMvT6+BOl86t94zPsUQgVvaqFSKIdPu1g0Fhetcjx8ILm+YFiZFAgg/fm2Lbo95pHyXpFKhCYwUu2lT7D0CwIcuu58dKIRyOSwPOK4P68npMXdYiL96sJ3k0VDVyialgJ0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=FVQPvXyT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43eb05b1875so3086814f8f.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1778576615; x=1779181415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GeQwgR3LsQgqn0nKN4yhs8JLip5DYYktZ+hVFenxoUM=;
        b=FVQPvXyTsGRzFrVTIS/hotODrwXFsxJSPmkgn8rADViNy2n2rH/0CvIjFaah2aW9VK
         uASzfG6O23r64iz8W8vwWD0oLz8axECGAPRJj43iHQT+6NwqN9RUEva5kHOZ/HSksVdh
         IgvZ/sFPlgIncQ7cnoZJJtGA3ZzKjJ3DD3hsDcvaJcK8kOVmtRzRZKwHNew7kC0leTD+
         B4MPz1wpRl4ouGw+TJyHm1ATaHeHgt2aaFrP2G0pXWbIEGxqUGzIwn4ScDkbVaYN0npE
         GM6VjNEQZwDgC/lOpBzw7n1eONiBpy9/GsD+aatufNf8PvHqgCsQ4ZatB+bpzwxxILzU
         3DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576615; x=1779181415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeQwgR3LsQgqn0nKN4yhs8JLip5DYYktZ+hVFenxoUM=;
        b=k9K7eYiTYRSDKFgzFnYFPYew3SmCc8iinn8owJD0sNl3+enSkeLtjD3nTrnKoHSij3
         cPmGRtHq6/4TCMDk3yu6BcHMI3F3dWXb7VN6bX1kdzekY0AZ4aNAjHPzQE9N0LA4HRqf
         spEGNWEfwRb20phM/jZxkE2HRUmmkTOMPkPHEUtKg9wiEV3nsLSRaTq6agj/TjWpHj7F
         vl8PFmKSHdJp3nkQ90vDHk16BZ0gV3tj1nHa2ubOKU+h8pmQ4aGmIoMS5yEnOLUsQrIl
         3Y1CkLkUJpuV5ehiJmrirgu8q7LHrk7fY6G5CD33TNDRPEpsMnGOyMCWROz+LBAuvxHE
         Gdrg==
X-Forwarded-Encrypted: i=1; AFNElJ8i46Gijb5hVP9DlYSkp46g0fliDMca8gjbAG1DsdqxJtt3T0mzbLcnF9bHTMN12ZU2cmcFwhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdV6kgSnhncs/jcIe/HJH+ziSU4xROlEk3E8TZfW2fMFpkLfU0
	LMJK852M/OcU75sX2ijCTPFxhcViwwqSs+H/w2NKpkpa7qwOHYp3q+14TtjUhJt1ccg=
X-Gm-Gg: Acq92OGPe37Mu1EhWj0rkA1NxjICUjlnt5PHV0lXcTYFYwTkCV7Sz25jKPXX52Q/pYu
	pmCJ2D3JROjVjt/MXDk9dhiCn77HLZEw5QxCHKQtIBKvN3fagWC2yM5rU8fU2mDsijy3PBYVxGE
	d0MAlVJ1VTWdJ23sAds/8jSR+b3s9hKyAzBbl8IoxZ4RP8g7q30oR4hx6VLZylZAySlzK9gI91Z
	2lEp2zjFqUnY7wikQ3F+n6ay+2c4xR6dzQw3kpqQrnaMznL+Yf0Un30iZ1r26GzicMp1ygxM8R5
	ckVtcAXsBHHCGXEXCYkDk0IF6OiQcmQ3xZVEtKqTA1pqFilQgwTsAfK7KA7TKyyO/SKiQ8P2Zpg
	tz9X06vNYtO1GLeLlmmIfqC8wzy3zIwKEaELUZxDbuhz0xnGm8U5mxwJzQyKyAbgopKDeRYi/dW
	2BVX7k1s4KRTMh368Mbb9EHxYGzNpQW1ajdsur91NGzaPe2sicz8kd3A==
X-Received: by 2002:a05:6000:430a:b0:455:8733:2026 with SMTP id ffacd0b85a97d-4568a93e624mr18843331f8f.15.1778576614746;
        Tue, 12 May 2026 02:03:34 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm31618975f8f.26.2026.05.12.02.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:03:34 -0700 (PDT)
Message-ID: <c2bbd2ab-e4f9-4142-a3d4-531f3d5ce6d7@blackwall.org>
Date: Tue, 12 May 2026 12:03:33 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: guard local finish against missing
 port
Content-Language: en-US, bg
To: Yuan Tan <yuantan098@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, idosch@nvidia.com, fw@strlen.de,
 davem@davemloft.net, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, tonanli66@gmail.com
References: <cover.1778504155.git.tonanli66@gmail.com>
 <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
 <1bfd86a2-e7f8-42ef-8486-4d7fa91b2199@blackwall.org>
 <CAPuPA7JzZC1veoLtdmsGdqZ4xuy7Znu=z=+7FsyX0_iUQxcZAQ@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAPuPA7JzZC1veoLtdmsGdqZ4xuy7Znu=z=+7FsyX0_iUQxcZAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AB05951D8DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,lists.linux.dev,vger.kernel.org,nvidia.com,strlen.de,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-287015-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lzu.edu.cn:email,blackwall.org:email,blackwall.org:mid,blackwall.org:dkim]
X-Rspamd-Action: no action

On 12/05/2026 11:57, Yuan Tan wrote:
> On Tue, May 12, 2026 at 1:29 AM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>
>> On 12/05/2026 07:31, Ren Wei wrote:
>>> From: Nan Li <tonanli66@gmail.com>
>>>
>>> The bridge local receive path may be deferred by netfilter and resumed
>>> later. By the time br_handle_local_finish() runs, skb->dev may still be
>>> valid while its bridge port association has already been removed.
>>>
>>> br_handle_local_finish() unconditionally looks up the bridge port from
>>> skb->dev and dereferences it for source learning. If the port is no
>>> longer attached to the bridge, the lookup returns NULL and the deferred
>>> local receive path can no longer rely on the port state being present.
>>>
>>> Skip the learning step when the bridge port lookup fails. In that case
>>> there is no port state left to learn on, so returning early preserves
>>> the normal behavior for existing ports while avoiding access to stale
>>> state.
>>>
>>> Fixes: 8626c56c8279 ("bridge: fix potential use-after-free when hook returns QUEUE or STOLEN verdict")
>>
>> I don't think that is the correct commit, it seems to me this bug
>> has existed for a very long time. From a quick search I think (Florian
>> please correct me if I'm wrong, but I think NF_QUEUE existed back then)
>> it was introduced in 2010 by:
>>    f350a0a87374 ("bridge: use rx_handler_data pointer to store net_bridge_port
>> pointer")
> 
> 
> After checking the history, I believe f350a0a87374 is indeed the
> commit that introduced the underlying root cause.
> 
> The 8626c56c8279 commit in the patch is the one that actually made the
> bug reachable in practice. I am a bit unsure which commit should be
> used in the Fixes: tag. We have run into this situation several times
> already, where the commit that introduced the root cause is different
> from the commit that actually made the bug triggerable/reachable.
> 

Hmm could you please elaborate? How did that commit make it reachable?
I can see the call was done before it as well:
                 /* Deliver packet to local host only */
-               if (NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
-                           dev_net(skb->dev), NULL, skb, skb->dev, NULL,
-                           br_handle_local_finish)) {
-                       return RX_HANDLER_CONSUMED; /* consumed by filter */
-               } else {
-                       *pskb = skb;
-                       return RX_HANDLER_PASS; /* continue processing */
-               }
+               NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN, dev_net(skb->dev),
+                       NULL, skb, skb->dev, NULL, br_handle_local_finish);
+               return RX_HANDLER_CONSUMED;

NF_HOOK() would return 1 for NF_QUEUEed packet so essentially it was doing
the same, how would did it make the bug triggerable?

> What do you think would be best?
> 
> Also, if the Fixes: tag should be changed, would you prefer that we
> resend the patch, or would you rather have the committer adjust the
> Fixes: tag when applying it in order to reduce traffic on netdev?
> 
> 

You should update the Fixes: tag but also wait 24h before re-posting another
patch version.

>>
>> because that commit removed the same check for a NULL port.
>> The patch itself is ok, it restores the check that was there before the commit
>> I mentioned.
>>
>>> Cc: stable@kernel.org
>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>>> Signed-off-by: Nan Li <tonanli66@gmail.com>
>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>>> ---
>>>    net/bridge/br_input.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>>> index 2cbae0f9ae1f..5b0d7450de5f 100644
>>> --- a/net/bridge/br_input.c
>>> +++ b/net/bridge/br_input.c
>>> @@ -247,6 +247,9 @@ static void __br_handle_local_finish(struct sk_buff *skb)
>>>        struct net_bridge_port *p = br_port_get_rcu(skb->dev);
>>>        u16 vid = 0;
>>>
>>> +     if (unlikely(!p))
>>> +             return;
>>> +
>>>        /* check if vlan is allowed, to avoid spoofing */
>>>        if ((p->flags & BR_LEARNING) &&
>>>            nbp_state_should_learn(p) &&
>>
>>


