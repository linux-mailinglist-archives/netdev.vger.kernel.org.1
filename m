Return-Path: <netdev+bounces-289113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJtnDkc1C2qgEgUAu9opvQ
	(envelope-from <netdev+bounces-289113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:50:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C43B95704D9
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A74513111B9E
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5963FB05A;
	Mon, 18 May 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="XIWxQNX7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEE73FDBEE
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118883; cv=none; b=ZyMv7K8LUoeFuW3GZXIa2aYiPr5nquPPz2qywuU4oh6piID94rhiLwJ7GdIgMJa1ZbOUsTaoxfOhiIrOds+PrK3616FCiQjWQgNvZ+trfDwE8ImpQHICDP47whbEx+7JX1LO+aJsnkoEZtUpSMRduIqKfVgtQeJ124qPp9Gf7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118883; c=relaxed/simple;
	bh=tk5GTPAK/nlnsOY7+TwdKEKLbFUPr/NxBIWdKs81b/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKc8xdOLImVqKtvVlZiCufKKZ+uv7LSMMDfET+9r5T47vg5SmCqtkrXIgwHtgV+LpHDmTo/tbupmORnFY/fbalMv0PduMs1TTLHKSoQrM9TWTx/32r2O9VCuYY+SdCo1/M+7yEVrnazOlkZBBnzKdvUCny7ogdjj9sJ8eD1E580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=XIWxQNX7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4889d0a9df0so2529585e9.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779118880; x=1779723680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=94Zjn9XQ3WDyXLdVoVZUdv+2NPn/y4aj79+Tl33qL2Y=;
        b=XIWxQNX7m8TQdntyMGgQxBLS1mv3Q6HmKWuxc1yDJmr66Utt283l/LZHrDrTkcGjHX
         +WaRfN/iivzLR/5GjTWkSKsehnGxQwRybuzaqWwG0ZprvVx2IEiZP1bwY2cOzcf927Nz
         YyEm8ntvVba7ATjnEzgw6yWHhAtgbyofN1KJNtvBfzfNJ8wXPN5eLuNl/gkrBShHXVvg
         elEHntUwzeIHS1eKPS2svpqTfzN/Z1QW6vREXZGM2KWFbXOmN26D5j1zK4HgSwy93yT3
         AMXcyr1hvlnrf+K5E8B2O1uWwTDapAES05+zz6ECQI7q8eefHPgO4pV1CKck2m9PEx05
         Va9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779118880; x=1779723680;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94Zjn9XQ3WDyXLdVoVZUdv+2NPn/y4aj79+Tl33qL2Y=;
        b=UqGR1vpuBaKwNmVooZTt4VuZFChyRHz50kS+Hbr71QGYwVjF63aGFq63YVYJ0prLEj
         wwyi+EbxNWG6wIjCJrCVhFqwy0Ih0horzWD41aVRMAKUk5LoC/1PHm5nKwDbSsvPxVAL
         h/9cko2kFI0KrZMIbJQCDnhNFCsSHwSzUVbPPmIJVOqyCvvru/xzxwGIwWFD7pzqq8+H
         icSvGwQRM4gWtLqEzg7oV+A3w35Giw+mcywfCLwdzV1+WBmrf9knSeGKzBigBJTVEE1a
         6QbjeZwGH9PpVOF7pSBtzAGiSDkQ7DnjKYSIW77vGWvWASkf6+3JYQGEShuCB2/VXWh2
         9UxA==
X-Forwarded-Encrypted: i=1; AFNElJ+GXQjzgxAEVQeyadLJpLHCFP8keieX7s32MmAM6BWnyFzCa6P/vNNqX3r4W9VpMqsRiVg7WKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/40pC0QAG8a+Jwk8/sEIEvhEgxLFeD3rhymVyMS6GOjsLtDam
	QGbDLwQxcoDISYre5BliINW53f0m3KXHMazVKJxnhnL0Um/k1t3QcgkO8uWf7bM1zVo=
X-Gm-Gg: Acq92OHOUrNjrLk2suTvJ3ztKwXWYJN/E4vTRFE0JkukJbKdNqoxrjpCa5pQE2MZSUM
	BvMmNDlUq4jyGwK1oV4fEd0Ul4yXrfwPF9i9mh7+W57RIPeFqVJtdDrFWYZMM7+t9tQwxjIWtp1
	FfbndVNsb0UHl5fx0VRj65eyMdPO5g6ELD8I6Bs7wZYCIaIHxyXPQBPqVSXS2ncYc2QnAf2S0yX
	b6uNsAo9Y7rM6gCx5WBYBi923AkoOf4izl7t6bytisjDnDSNp06FKOtRbAM4oXagFiHWDoMQGOU
	+TF52yP+obaapLjGyRwPzHJl5QS5wfl2E7xVEITJK8KP1CqjoQmnsg5vihmOV0/4miLzn1L4xL7
	rMEpKxyVJ4imxYM6XqQwgz487ZHRBY9g+I2PjovQGmkhNpDExxSNfzS9Utk7Me1wbEaJUM0BuI6
	VLB8c+rXeZRcZLg7FJADdZUn7nUjzCN1l1Wg64Bip05Yhp2EzXGuPtY5TO4eSNuCl9DkvoGxqXH
	5rmhOmzUr1qKiJXv4NXWlPcHQ==
X-Received: by 2002:a05:600c:1d02:b0:48a:5302:8ed9 with SMTP id 5b1f17b1804b1-48fe5ea0842mr143830215e9.0.1779118880533;
        Mon, 18 May 2026 08:41:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm38102785f8f.37.2026.05.18.08.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 08:41:20 -0700 (PDT)
Message-ID: <ef3b3583-253e-4e83-8bab-31672effb9ab@6wind.com>
Date: Mon, 18 May 2026 17:41:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 3/5] net: netlink: don't set nsid on local
 notifications
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Adrian Moreno <amorenoz@redhat.com>, Jiri Benc <jbenc@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matteo Perin <matteo.perin@canonical.com>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
 <20260515201937.2813983-4-i.maximets@ovn.org>
 <40603dce-f801-42ad-96ec-c8c0a57e5aae@6wind.com>
 <5344852f-e920-4232-9b54-5b22f6c8a1d3@ovn.org>
 <5d19e543-ac3b-4d32-a464-377d03cde500@6wind.com>
 <f695ac3a-aec9-41fd-a3d3-9537ea4c50f1@ovn.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <f695ac3a-aec9-41fd-a3d3-9537ea4c50f1@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289113-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,canonical.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[6wind.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,6wind.com:replyto,6wind.com:mid,6wind.com:dkim]
X-Rspamd-Queue-Id: C43B95704D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 18/05/2026 à 16:06, Ilya Maximets a écrit :
> On 5/18/26 2:56 PM, Nicolas Dichtel wrote:
>> Le 18/05/2026 à 14:46, Ilya Maximets a écrit :
>>
>> [snip]
>>
>>> True and also not really.  The main problem is that ID can be allocated
>>> at any point in time, so the application needs to listen for NEW messages
>>> on the same socket that it is listening for the events that are interesting
>>> to it (to avoid races), if it doesn't want to make a separate GET request
>>> per notification or track all the IDs that were previously checked.  It's a
>>> non-trivial amount of code depending on the application structure.
>> iproute2 handles it ;-)
> 
> I don't think it does.  If I run this in one terminal:
> 
> ip netns add test-ns
> ip netns exec test-ns ip monitor link all-nsid
> 
> And then in the other terminal:
> 
> ip -n test-ns link add dummy1 type dummy
> ip netns exec test-ns ip netns set test-ns 100
> ip -n test-ns link add dummy2 type dummy
> ip netns del test-ns
> 
> I see the following events:
> 
> [nsid current]2: dummy1: <BROADCAST,NOARP> ...
> [nsid 100]3: dummy2: <BROADCAST,NOARP> ...
> 
> Which is confusing to the user (myself) and shows that iproute2 doesn't
> know or doesn't care (which may be fine for this particular command) that
> 100 is the ID of the current namespace.
Right, it doesn't update its cache. I thought I fixed this :D

[snip]

>> I need to make some tests with your series.
> 
> Note: sashiko points out that it may be possible to have stale values reported, so
> re-setting the nsid_is_set flag unconditionally before the check may be required,
> e.g.:
> 
> +  NETLINK_CB(p->skb2).nsid_is_set = false;
>    if (!net_eq(sock_net(sk), p->net)) {
>        NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
>        if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
>            NETLINK_CB(p->skb2).nsid_is_set = true;
>    }
> 
> I'll include that in v2.
I will wait for the v2 to test the series.

Regards,
Nicolas

