Return-Path: <netdev+bounces-272139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHonBPphxWkJ+AQAu9opvQ
	(envelope-from <netdev+bounces-272139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:42:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F2B3389DF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA7D93130AB8
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82A43FA5CB;
	Thu, 26 Mar 2026 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="bq1ipTNx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB23F20FA
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542641; cv=none; b=ha9CBrPWDo4HPnv0jGTq6EKpHuk6P4cUnAvBqI2s2bjq+mqDn0jtBNBSMfHu8fI3ChMktlH2EJakXQzZ/WrB3x7vAhWm23bEEBHO14x5I4VLroNAdcE5nQLlD70qv0yYjzz0VfSfRp84lysCpVZ/M70hUYL6n39LivpY5HxChS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542641; c=relaxed/simple;
	bh=d4H1o2R0J+kUt8ry+L3/+wyUypeBZ5BXzQHUJxcX9Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0nB+zJdr6FBai14auhl/M24c/zZlFmXB3MVEfudP3a4Av6F+tCa62Agc2qaF3ccLFaFlWuCbkT4L0LwhePXt7qwrzSANxkwVh/zzrZ1Qlq1s4PndBnZA9Kes2UTdZXyiGS14vZ6ToIvolSrI18RKWeDjSOAcE2nYUeI1I+87bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=bq1ipTNx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4853a485721so1596005e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774542638; x=1775147438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qHLmgaBJ2N195zLhmhOsO5EN5YT8pJxrNs0F7eHbLF8=;
        b=bq1ipTNxEKTxbUT0e+BRU1u803YRUzOpdVkl3eT8F98sUqhmM95A5ePQ3YjvjdhnNa
         hzcKcrfbPqNgQCxrNLfIFiA/QbGRs5uPs1usL/JMKdXfeyV+7WqGHyoioHmtlkcjUou2
         foFVWSvJfwgPUROvz4caOXy0pNfS1zRp5bRkFhELsqX+xyaniT50MmtZyPHJeUbWha08
         v068JFZpjSkReSPfpACeGxWECF9bPm+hFS651V+1zmm3yNkbCEV4RGnCUNukc9raxcZw
         UG9mNJ0RF9fXeJbzxF/uPjv2PQEHAzHB8uYJaCJUkZoQ81lv8WufnN0pyz+uaEXQizH8
         lW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542638; x=1775147438;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHLmgaBJ2N195zLhmhOsO5EN5YT8pJxrNs0F7eHbLF8=;
        b=ntFOLPNJRWs9kZnT6JWKxIr+R0PuiLe7X+FTvyJsrCsbiT6x3C/0HpwD9walmbdl+G
         oc18SNRxnC+jZ3PutTswYR+CmFaHRhP1ylXap/6RsfS4smrFRa9W49QR+LmQ8rFZh+JY
         vH0HRmsJylkqvl3ueMPgE+UQgGBQ7diMdJk1vH0KtQauGHGT4Eu702KoztFMfbUv/TBn
         EPfEBXsHBY53edWqXGFIq4zSdUm66cyCERl8XiliY2YjkUuyyraZeKbM5E0uQMtW5PtT
         cyknHt0TkRZxkG8syBd3WoxeVvS/7GwjjwTxkT+SxH2jtImF+XpoW8wNFOssrPJysKL0
         HjWg==
X-Gm-Message-State: AOJu0YzErCJ7gXSQLbhGH8z19elI3nmViBU38nqYg4on4TIuVLPiHlze
	61JWmF0TFixi8lYqWXUz1bGjHJ67AbBLUEECumeTcW8XMoDQCNQGCZHjQOANbIAnXek=
X-Gm-Gg: ATEYQzyptF4iqUPpUPVD0YjcrAIY3gzY9iuPSK48fzkQoBtHeGarXOgPJtfyqp2JPLt
	lVCf2pfce05K/ZwOYn7L8N1FSdV9vlOMBZEPWOTcZeSpB+6OEfpHh61WBkKPoHZ2aws3N3rxOFO
	SGffVReywJ97LYySrgKqfk1Z4eqCifJagXKOg/ESZaf4u03fB8KcPlXjEUtS5QAWAyjjM15bEpY
	tdEFCxTq0/Ft1xr5GT+3FaEEdhtn1rTpAhS78z2eVKVX/NroheO1mHCjv4RucFuP1AbA/Qdn87F
	BBgD0o1R0M05fIMI4H7NWdoUY5SjOX4gsfxt351fgYI0SlmCJ7TxL3Ehbt+qIo1231a1VLG7sq9
	p1RAZ5zMOPalRwjDBNzuePaJ6Tei9s6nL26Ewh3Bq57Yau/gUwBC4yuuUDbks4sOkb1/YKpbyoS
	StoGJHgZfHu1gy03CrP/8nIZXF2WvvPLQKy4FGHGCWK099zEVhhUfgAcLs52BBR/1E6vc90N7hN
	kHZ
X-Received: by 2002:a05:600c:3589:b0:487:1fbb:5a1c with SMTP id 5b1f17b1804b1-4871fbb5d12mr38717455e9.2.1774542638298;
        Thu, 26 Mar 2026 09:30:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872092b540sm17363435e9.28.2026.03.26.09.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 09:30:37 -0700 (PDT)
Message-ID: <dfc4fb29-7f27-4e9f-b6c9-bd37cbddbf1e@6wind.com>
Date: Thu, 26 Mar 2026 17:30:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [RFC PATCH net-next 0/3] seg6: SRv6 L2 VPN with End.DT2U and srl2
 device
To: Stefano Salsano <stefano.salsano@uniroma2.it>,
 Justin Iurman <justin.iurman@6wind.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels@cisco.com>, linux-kernel@vger.kernel.org
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
 <CAOY2Bqx-ZmBm-o-BoUYCxJjGQn31WF8V2u7gbnB52gOSYvG5Rg@mail.gmail.com>
 <6fef33af-b351-4bf6-a210-ae2283ec9f69@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <6fef33af-b351-4bf6-a210-ae2283ec9f69@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-272139-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:replyto,6wind.com:mid]
X-Rspamd-Queue-Id: 61F2B3389DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 25/03/2026 à 08:10, Stefano Salsano a écrit :
> Il 24/03/2026 17:00, Justin Iurman ha scritto:
>> On Sun, Mar 22, 2026 at 12:06 AM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
>>>
>>> Hi all,
>>>
>>> this RFC series adds support for the SRv6 End.DT2U behavior and
>>> introduces the srl2 Ethernet pseudowire device, together with
>>> corresponding selftests.
>>
>> Hi Andrea,
>>
>> Thanks for the work you (and Stefano) put into this series! As
>> discussed offline, there is interest in such a solution.
> 
> Hi Justin,
> 
> thx for your interest!
> 
>> A general comment: I'm not sure about the name "srl2", as we're
>> talking about SRv6 specifically here. 
> 
> fair point
> 
>> I would personally love to have
>> "l2srv6", although I suspect we may end up with "l2seg6" to remain
>> consistent.
> 
> I'd like to keep it as short as possible, our initial idea was seg6l2, very
> close to your last suggestion, then we opted for srl2 losing the "6" concept
> 
> now it comes to my mind that l2 is somehow redudant in an interface type name,
> as an interface is an l2 concept per se, so my preferred option becomes:
> 
> sr6
Note that the interface name is defined to kind + a number when the IFLA_IFNAME
attribute is not specified:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/core/rtnetlink.c?h=v7.0-rc5#n3823

Here, the default name will be 'sr60' :)

'vti6' is already in this case, so it's probably ok. I vote for 'sr6' too ;-)

My two cents,
Nicolas

