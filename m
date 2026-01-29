Return-Path: <netdev+bounces-254909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB65HHy/e2mnIAIAu9opvQ
	(envelope-from <netdev+bounces-254909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:13:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE52DB42EC
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1CC5301DAD7
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F12E3254A2;
	Thu, 29 Jan 2026 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQeialWk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332632F763
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717587; cv=none; b=qeq6C/onyZvln3mnSazVUN9WYrRjtsPPixdxZTL3lgc6aKhTpS21mPXHeilra/um2jkHbXkOkN+vYpBt37cRDF9wWf0ZFgb8ilsBC6MEtUKQ5nzET/5hy/G2U9iv9Xqss+B9a8KM9XfST6A+BI22cYGc2+GXFPEkp152lBf8qWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717587; c=relaxed/simple;
	bh=r81xv40H+JwVCkYOkOIZIFpTJkgRVsFhSyjutuzS5Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eJB6VfDt7VzLPInrhohCIlyNvUUyKEo9FwKoBS7ugMt3H3zoyy3Uv8GgUypJxl0Djhd9jVnfDrSuyvi/OZC00Nc+FtIN9XZqwLvGvzVTYylhAXTxiqivCNdKhg6aPpSD+0Fqvdb/x2eaYjLmaJhTVbUybk0x6KgK0oc2uSHZm9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQeialWk; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so1793920a12.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 12:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769717584; x=1770322384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vyejpy7R29nGjBVoLPL/Q1Gctjw0gEMafobmT90sO+E=;
        b=QQeialWklkztz050ZZREqDiXseCKSUufFqfPoxrf83LjFPbKyKEPn1h2TtuzxnMaek
         H+ZWVjY+KlL1oGzrCl+HfyhrEVX4ekBP2rVm3x1BJerUcaNh7bTt9uGADUT2sH9GWw1J
         DVca30R8S96CiJlf0to388R0GobpP7hErsoq2pb5uNapPwNNjzpekEFl09h9WumhrEpS
         JuNA8Ss49B7iKr7jduWxmAGWqlAmsh+BNP+s8tvrUnhDUkVb9Bu1ZhR9eUXOWHzfI3VW
         64jYc/WAhpb5D/EhVh7Ha35aySEpyMAAXwsLFkw6Tp/1PRZ+7iOnTnw3V8Zx63lubxbc
         MfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769717584; x=1770322384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vyejpy7R29nGjBVoLPL/Q1Gctjw0gEMafobmT90sO+E=;
        b=H/o4rGW8ZxEuMgd5EPupd83ptixJlPg+n2nAy4QLyCkimty/xpT+194Xvz5HFXZ5jf
         I7SWkGP04Uh983U3zGfAgF7Mk5fCHMNw2gS6SJduIbkn55sTWAe83pjeDbMRl8LJ6Qbg
         H7/wLVTjDKThssNRJkm4Lcvjo0cfCTFNUApxDW5SHz3MCRlgjxGDehFYIwPfBtKnl87g
         taxj8/OGw7DSNYnPp5RZxw4Pn4kGrHDAFDn1SnGj21TPT/+T1GIwpRRg58OYeoQ/9Yu+
         pXVEmRqrL6b+soYi7zugSJdsBnLyBm9N6n7iYvn0BZ40m6cfX4cWmwb9ynYkv8WTSj8g
         WzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7TFiy1bbNDFDEV6JFD1el7s/uiilknN3Q7UlnWKNDCz3rHRCuHtzW2ZADI6XINJJAm5CwWfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLIZPfiTbacOij9mQYJVk8XHXFiLWgVuP9Ge8n32+4qTWXWWGb
	X7M8S468yJ/KwmNtGMqt2NmPxedHmfXUX30e7W0ylcxuBgiBc2SanZ2o
X-Gm-Gg: AZuq6aIVy1cocqhIry8z/lnrx2Fn58e30Oa9iYrlyNrAb82Vu5A4ZdSNEltgk2Ukul4
	vUTuJrlKqNpAXtFhUYUw4L1HgYjoLWmAmTeEdqduQKONnWeyti+AR9VtQCHRC5T6Eor805NYuTU
	JRla2ip9N+koFfs/Lf4tkaonXxvVswKI2HrvhGAWIaXW0Wd86GoRnesNkMy/z7ueJCFvf/n1ANV
	g+siEvjxjfZUL1RshIyytlqEpLNpLMLoLdXCFNVbGweHxd9saZLoKDWuhU0OgdQeQDSK6Z6Bem4
	qdmXAJuTsflgUjP2rHRvOTWO5QbOYxT18pKnyrzR39vVz48d2j1SvFyMMwYKatQ3a7WGEVYnfX7
	/908IUXGeypwJRFg+vknKVwHhI5YHDMSCEebZ93mSntbc6QpoBf4FndCuspHQuy/96c5BQNlnXh
	TR5h8FsW8vv9ZzXMD4ZpJhwvzzXSiJy9W9RBNrTAUr1V4kExUv5Q9H9X61dA7Zt+RQwNuqrvxK6
	/Qs
X-Received: by 2002:a17:907:9412:b0:b88:641b:b0e0 with SMTP id a640c23a62f3a-b8dff6f9e97mr17029266b.49.1769717583634;
        Thu, 29 Jan 2026 12:13:03 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:8ea7:1ca8:fcdb:48b3? ([2a02:a03f:a75e:9a00:8ea7:1ca8:fcdb:48b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbef86df9sm307298066b.10.2026.01.29.12.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 12:13:03 -0800 (PST)
Message-ID: <2745371a-8ea2-44c3-9238-93560fcdbb77@gmail.com>
Date: Thu, 29 Jan 2026 21:13:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 6/7] ipv6: Enforce Extension Header ordering
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-7-tom@herbertland.com>
 <willemdebruijn.kernel.19061eebdb902@gmail.com>
 <31232399-4cf4-49ea-b769-84aceca61dc9@gmail.com>
 <willemdebruijn.kernel.8e46b721f5ed@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <willemdebruijn.kernel.8e46b721f5ed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254909-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,herbertland.com,davemloft.net,kernel.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE52DB42EC
X-Rspamd-Action: no action

On 1/29/26 20:05, Willem de Bruijn wrote:
> Justin Iurman wrote:
>> On 1/29/26 06:18, Willem de Bruijn wrote:
>>> Tom Herbert wrote:
>>>> RFC8200 highly recommends that different Extension Headers be send in
>>>> a prescibed order and all Extension Header types occur at most once
>>>> in a packet with the exception of Destination Options that may
>>>> occur twice. This patch enforces the ordering be folowed in received
>>>> packets.
>>>>
>>>> The allowed order of Extension Headers is:
>>>>
>>>>       IPv6 header
>>>>       Hop-by-Hop Options header
>>>>       Destination Options before the Routing Header
>>>>       Routing header
>>>>       Fragment header
>>>>       Authentication header
>>>>       Encapsulating Security Payload header
>>>>       Destination Options header
>>>>       Upper-Layer header
>>>>
>>>> Each Extension Header may be present only once in a packet.
>>>>
>>>> net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
>>>> enforcement of xtension Header order. If it is set to zero then
>>>
>>> [e]xtension. There are a few more typos in the various commit
>>> messages.
>>>
>>>> Extension Header order and number of occurences is not checked
>>>> in receive processeing (except for Hop-by-Hop Options that
>>>> must be the first Extension Header and can only occur once in
>>>> a packet.
>>>
>>> RFC 8200 also states
>>>
>>>      "IPv6 nodes must accept and attempt to process extension headers in
>>>      any order and occurring any number of times in the same packet,
>>>      except for the Hop-by-Hop Options header, which is restricted to
>>>      appear immediately after an IPv6 header only. Nonetheless, it is
>>>      strongly advised that sources of IPv6 packets adhere to the above
>>>      recommended order until and unless subsequent specifications revise
>>>      that recommendation."
>>>
>>> A case of be strict in what you send, liberal in what you accept.
>>>
>>> This new sysctl has a chance of breaking existing users.
>>
>> Willem,
>>
>> Note that RFC8200 does not use normative language, which is part of the
>> problem. It could theoretically break existing users, but I don't think
>> it will in reality. For that, you would need users to beginning with
>> (joke aside, I like EHs). Anyway, if the order is enforced at sending,
>> why would any receiver accept a different order? In this case, being
>> liberal in what we accept might be a security risk (see below).
>>
>>> The series as a whole is framed as a security improvement. Does
>>> enforcing order help with that?
>>
>> IMHO, any packet with EHs in a different order than the one specified in
>> RFC8200 looks suspicious. So, yes.
> 
> Looks suspicious. But does not introduce concrete new risks?
> 
> The main risk I understand around IPv6 extension headers is the risk
> common to all untrusted network input: bugs in parsing code. Bugs can
> cause crashes, infinite loops, or worse subtle effects. This is why we
> introduced the BPF flow dissector, for instance.
> 
> I don't immediately see how different order of headers increases
> parsing risk. Nor, btw, that reducing max number of headers from 8 to
> 2 significantly mitigates a real risk.
> 
> No objections necessarily. But I don't fully understand the argument.

Enforcing the order kills two birds with one stone as it also allows to 
automatically limit the number of DestOpts in general. This is a gap 
introduced by RFC8200, where you "must" accept EHs in any order and 
occurring any number of times in the same packet (even though it says 
that there might be two DestOpts max). The wording is ambiguous and 
non-normative. Since the DestOpt can contain a certain amount of 
options, then you theoretically end up with a nice attack vector.

Regarding why "reducing max number of headers from 8 to 2 significantly 
mitigates a real risk", it's not about the number of EHs, here this is 
about the number of options inside a Hop-by-Hop or Destination Option 
header specifically. Therefore, you further reduce the attack vector.

