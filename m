Return-Path: <netdev+bounces-290492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDV4KlwhD2rPGAYAu9opvQ
	(envelope-from <netdev+bounces-290492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:14:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF1D5A8160
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E81CE3078DE6
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138493C5855;
	Thu, 21 May 2026 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="IyXo3MfR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6942AA9
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373542; cv=none; b=ud4Ae0OO6HJK6YOzmFyEqqnAKWAa9CeMY2CazbRx36QhrRznHFz2emkp8wHXNxqNzo1rbueTvSHfbHEvDuPJB+BkNNAIap5HwTsb5V/kX52Wic350R95GM7hECuAbZfb956ab7Jz0CKnG5nQBNcwmrLCaN/a5RsIVH22jkVDaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373542; c=relaxed/simple;
	bh=+C3fO9EHQqC8yb9Ea8YRyF+2U4PtwzeiyV4Jx0pc3HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MT0s/aNEIgKp36eSkSIUqTx9Zo+gtOqV3ARAzPMxqAFY3sAVsr8ECLgs9r03ciurtSjFBCWRyeALR9SUmHIFEDhmpj3GKbaP4iL2oebAC4LBWuhPo2ZD/5U5YeYeCTmOqbAX03VHO53Eht/mk8mzDQ2IkmCE895MkCpDhwEhByk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=IyXo3MfR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bce3350fe3eso86160066b.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779373539; x=1779978339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8fIErPlRSj4fk2dY+zUS744qFronKsaelvf6iKyKFKQ=;
        b=IyXo3MfRPtLzvEM7I5Bch8BNUC1qogTTnjTAL64Ar7313l6eEXzn35z8h7uvybRlrA
         mb1bXOkqNru2qu49NvwAzN+W3JC+4RsZ2JSgEBqZ9gbXrBg4ya2lr5/0tr/DcSgEL6/a
         Z1FdAMlqSCbksJMSweiV7CJ/H+47wPPtbNjU2fBX7sAd63dLbmBxuZqBU+NV+0hGpI6p
         IdcbA36EUy5O3sotzGGKohA0jcGT/O92j1Iuz8BjCBNC4ls6DVVHUFSZRNUK6ncQKsw8
         r8cEtqMRkVcKYlcZGmZTlB2qFQXjK1yZbB2Mtx0c6N9FqMLoSLeOujuhCEJJPQ3OCSCN
         byxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373539; x=1779978339;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fIErPlRSj4fk2dY+zUS744qFronKsaelvf6iKyKFKQ=;
        b=ToIME4mQAvrZOIxc+5AYw+4Z9QIPwtvHD1OLqMbUGhx9qovzg54ZJlQvNodQCvkLzf
         9MpNXxm3/Iwbj2vjrHzStWAaxdJGvpE+x2P0FYfPQeyXQlLnkEIJLfO0JDkuEaK3q1/y
         4aesdE/T9rbrvUBxSgAo02Uv/SsD4oVGWf79Y5CS8KNl/W5Tuinbm5d4zVe3vJdX5m28
         N6SMOA4VwJ7pNPK6pdffx8BgFVCl6USq4h0lBJzguKB+P9wNP39kGNIqMHhn1CjODnd/
         J9U/wdkvaQ3XM7S4c4QXHONxkLhkw/8oVNFTYJ3wqVg1Ex5mfhnilAkcMxLcznPaqoPo
         0a1A==
X-Forwarded-Encrypted: i=1; AFNElJ+7lutwfqw9fvOZ6WEGDPYV7flcoEbUsHAVkxKrG9sPwz0N4Yh03Mgqkmtas0znlsv6MhwcWD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa3mcmcrbmT1Hc4A/bQnuwi8UQEVk++eR0W43FFfZ8HqNqWsaP
	5K7Pf3x+moJc4JeF06Zx3oGlmPYUEudsEe+KCyjV4940Y1BEOx5MAxJlPxv4VTY8eP0=
X-Gm-Gg: Acq92OGEDXXXKUHDoLHUlJmkkSsbINR6FAOjufgRCmDwIjaQQt6dqL7bmk2yB0KLOy5
	nORrjN5GZkO7OvVsMdmgsjwfXe7vS45+3vFn9gDM/uW3hKqVY/CJdTKScO+MjlVr81ZziTMFLR3
	+fAuKNOHkN/L5JTuRcAnDQDM3rIC58H5xw6PAarIdmqZrV/gs7WUFUGeQ9ZjZ5hi5+pHBz9jYyE
	ZLtbRb7VmRcKyq9eB/iLtQECm8ovV+P3GimF75B2VL7PMjjEa8vErzSWn3I3ncjgER1ROPzp/EE
	3F2rPtjSzPaIJTsZqXLUZ4j9rFFeL1Obqxf/qdDKXFR1ml6ILdjcrzw5QQQS00b8ao3h0E0N4VU
	v2bhh/MJ0W6zej1c4lAST8SqinfzHynJIkTmqGd81AfDxqulZJPWllX6GLAovB34LXKSQWPXm7t
	YrvRe3xsJVoeuW6u/I6b98lHOc1/R3bXwXdxSVQ8y8o6OzK1rzZnECwfwcVpBPWr7Jw1F3WzX4E
	RwNsLWGEHb5+nA=
X-Received: by 2002:a17:907:961c:b0:bd2:a2a4:fd3a with SMTP id a640c23a62f3a-bdc1437aeddmr66262566b.7.1779373538588;
        Thu, 21 May 2026 07:25:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8aa03d4asm57107166b.47.2026.05.21.07.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 07:25:38 -0700 (PDT)
Message-ID: <9e7b7aab-dad4-4b72-87cd-822e67b27afe@6wind.com>
Date: Thu, 21 May 2026 16:25:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 2/4] net: netlink: don't set nsid on local
 notifications
To: Jiri Benc <jbenc@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Kees Cook <kees@kernel.org>, Adrian Moreno <amorenoz@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matteo Perin <matteo.perin@canonical.com>
References: <20260520172317.175168-1-i.maximets@ovn.org>
 <20260520172317.175168-3-i.maximets@ovn.org>
 <bd9c0751-55ea-459e-8b22-8bd24abf235c@6wind.com>
 <20260521160036.413771e9@griffin>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260521160036.413771e9@griffin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ovn.org,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com];
	TAGGED_FROM(0.00)[bounces-290492-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,6wind.com:replyto,6wind.com:mid,6wind.com:dkim]
X-Rspamd-Queue-Id: 4FF1D5A8160
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 21/05/2026 à 16:00, Jiri Benc a écrit :
> On Thu, 21 May 2026 14:36:12 +0200, Nicolas Dichtel wrote:
>> I still don't think that this is the right "fix". The app is broken. Even after
>> this patch, the bug could be easily triggered again by a third party.
>> There is nothing wrong with assigning a self-nsid. It would be a lot more robust
>> for the app to assign itself a self-nsid when it starts.
> 
> On the other hand, does the patch break anything in practice (as
> opposed to in theory)? It makes live of several apps simpler, which is
> not a bad goal.
I'm not against the patch, it just look like a workaround.
I'm trying to understand how NETLINK_LISTEN_ALL_NSID is used (in fact, why it is
used if the app doesn't "understand" NSIDs).

> 
> The only scenario where this would introduce incompatible behavior is
> an app that self-assigns a self-nsid and expects to see it. That looks
Yes, I thought about this.

> quite stretched, doesn't it?
It does.

Regards,
Nicolas.

> 
> Not that I have a strong opinion about this, though.
> 
>  Jiri
> 


