Return-Path: <netdev+bounces-303125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bqMBMvawQ2rqfAoAu9opvQ
	(envelope-from <netdev+bounces-303125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:05:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8306E3F7D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:05:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ml4BlUlP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303125-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303125-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0159A31A957C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F417401A26;
	Tue, 30 Jun 2026 11:38:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1DE3CB8FB
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:38:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819484; cv=none; b=JjwKeMMtNTM2a4zCNq6c2mzQVO1+kzJqdwd3wR15FCAevW+J3hp7aXnU+OxQ3FHdeUSC4ytRmvsDal2cjonRrrNPfkbfGqVOyfPvGyXkah3nIPG6em9xVhOFi9YR+hJvSYUjyPmxOrckdh30+ly/I63ICvvC+MhYZmaujdvKWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819484; c=relaxed/simple;
	bh=dNS9gJ59kETwtxmLRKpGI1mdji+DmuUq51Ry7zd9YVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0cXv0tdpJpFxNRME1VMNyjv+qMBGKJrjvmRmRPHoBf4QoE3hDY65mHJYPsUMrDU+k4og2Sw70D/HCfOWkynHcswcxHgrmtv44at4MjH23xwxmipFu1W0BTzaFXld52xfpmxIys6crwK2JS3LUZiPoJEP/M72i3a3FZCJvtyDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml4BlUlP; arc=none smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9217d13c276so316558385a.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782819482; x=1783424282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNS9gJ59kETwtxmLRKpGI1mdji+DmuUq51Ry7zd9YVI=;
        b=ml4BlUlPMJFq/uzp9fMfHi0D01Uoz7DNV4NJRzUZDqf3rhnwaQMe3VFUVNeVoyrSQ0
         nPZO9tFH21yojYbzQYk680W38VbvULJdjuzd3ta38FTw+P4H1d5Wq+DYVUy8BV9z7vp3
         10isD2wb/GvUh6o9h6soybjopB9cK9gMVNNHs3nh1KEs+TJlV4zK+WiQUafQZYazShWs
         X1BdmO8K7WCvaOWzPa9HtRd6DKxaKIsxGA8bIcJiyqlNEfpN9CrEBaNlY659HnkeXwJO
         8LfKV9LOjxgw/9TKLKFULcR8x/aStqPD/oZJNdIl3oJ9J49Z3rMKfO7BNBQp+gWBey7h
         BWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782819482; x=1783424282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNS9gJ59kETwtxmLRKpGI1mdji+DmuUq51Ry7zd9YVI=;
        b=Kr3MD/r4aM7/gplTliWMThAcBfsNpP9I2jnibQMSyM9O8lYzc1AQgIClTVAqQSfDVT
         Z4juxX/E6mYp4eh5Xt5nbgiReXp6bjgFYvOpWIlF2u+YEsP6ujL4xH2InA8tB4IWl1Bu
         zPRbnHAn7J2IYdxgPvxs2XgjAA6oGj1QgKzT6sbuhlXi/Iww4/2+7MSbmmnk5BC+hrka
         Y1WP2c6jsRD07UESto1V5CTTaD+aC/shymaHZuYiBpE1tkQv9b8QWbbPwF8MynOycsRV
         ILH2MiHTCT9u1urvmjfwwjH8oSQcV/TaFZcUjsiqUVvngZO87vWLjJus6Il6UC0WYnFj
         6eyA==
X-Gm-Message-State: AOJu0YxiCOOYuBT6JQ9M3N/y2z55iZEU9eoPmv2jkQBPihuTG2T6KReK
	tqJIgSvPLIU5KM+tzb+m8mS+mEI7Gg74v3swr5lJR3AqTFzX/MEDCuUu
X-Gm-Gg: AfdE7ckrqKQpC8r81G9Cj2M7BK3NzZSvUYa9QqRAFVSLzQUCW+bnCEj/0esRemZ7bco
	vndA0fnuJI5gSoeHVDGz+Y9vwm/LJdivJXhIdjb3QM5DXo9uxrjBSjTgryi9aseRim0kcffKSxj
	fbzpDjQKCW2DVuP+uZTxft6oUzoyJcaBGnq6MBPqWnexd5Ld4X0j6dQyxY+gcFsAAu3m3Okgf1I
	JcSuySFv5fHEfmkuY0LfaVOyOY4vo+zac4PfjuJ7oVZOpCyMdGbNyXO2CZug73HAVAANh/+sSgB
	HWLE26em1j/NXHa+DGOU2YSAknKHVPOHev8Jzy9YKcKfZVZ3ITLBm4v4XY1sqGL44p4HCz9XU/S
	14R104TWRZaNiNXJf+j2/f4sbNjOPh875oUMEbBzo4XaoMzWo3b70pjsSBjVa3FGjcfYj8T/4IU
	5oeAJ5geEgShwy5gggAm6cTrQ8LAiatkzI760mzhKafUePqBOjRFbTMdc364SpOOg+HCk=
X-Received: by 2002:ad4:5cee:0:b0:8ef:b23a:d741 with SMTP id 6a1803df08f44-8f1bbbdeb2fmr46454616d6.28.1782819482187;
        Tue, 30 Jun 2026 04:38:02 -0700 (PDT)
Received: from ?IPV6:2600:4040:93b4:e600:a22c:878f:7c1a:1976? ([2600:4040:93b4:e600:a22c:878f:7c1a:1976])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c283fsm22449346d6.26.2026.06.30.04.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 04:38:01 -0700 (PDT)
Message-ID: <daabe7f5-a6e1-4d37-83a3-3f05da0dd3b5@gmail.com>
Date: Tue, 30 Jun 2026 07:38:00 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: drv-net: tso: don't touch dangerous
 feature bits
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260629233923.2151144-1-kuba@kernel.org>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260629233923.2151144-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303125-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B8306E3F7D


On 6/29/26 7:39 PM, Jakub Kicinski wrote:
> query_nic_features() detects which offloads depend on tx-gso-partial
> by enabling everything, turning tx-gso-partial off, and seeing which
> active features drop out. Enabling all hw features is dangerous:
> we may end up enabling rx-fcs and loopback for example. For the
> ice driver we end up getting into problems with feature dependencies
> so the cleanup isn't successful either, and the test exits with
> rx-fcs and loopback enabled.
>
> Scope the feature probing just to segmentation bits.
>
> Fixes: 266b835e5e84 ("selftests: drv-net: tso: enable test cases based on hw_features")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>


