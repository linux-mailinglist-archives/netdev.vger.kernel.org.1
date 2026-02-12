Return-Path: <netdev+bounces-258500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mYtXMDY6jmmKBAEAu9opvQ
	(envelope-from <netdev+bounces-258500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:38:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E4D130F59
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7A1C3004D13
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4023F3033DB;
	Thu, 12 Feb 2026 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VdOXS1Dx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EBDF9C0
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770928690; cv=none; b=I1Wr7+bIOzYc9g7tzkTmo64Red5Z+z9x8VNae5EPcv8erz7UB8i0QKDFY/pGPFqGsqWg5xWwDg59XHDKImVhcYwsXU+F7o3vC4juq4qVlztLwUZi668WR3K8Es6+pG3zZ86BMF+kVV9czAACNnMGdEW3h6V9xyhdz01UJJwMp2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770928690; c=relaxed/simple;
	bh=8DemoD+6jLIRvaqWPd64qq5kb+8bZDaZEbMIdx/xbzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQUXBhSfiJm+MrP++cDvMOAiOa2vw2coMYHHGmz8Dw9GdPvOyF71ypuXhYEqAa0IHtDrGuv+ZKeB8Xn/VQOJ9US2DPWZay/YpEqKh7sZbsBdzQk9TMWoCIOgdDg4oGvX3XU3vNRlww2w1clbcsn4UroobXHZ5Hxo4Yoa8NLUYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VdOXS1Dx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee0291921so2332495e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 12:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1770928687; x=1771533487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz5Tu3S5+Sv+FMhbeR8re+gY+jm+XKnRuhsiVfye3mc=;
        b=VdOXS1DxIxt46cUzRZDZXjy+sNA44CJQVpezhV3hL8knnLr202LLlaYsUM5C3Azh7Y
         IvV1N1h0ADDaJcNhsj7QwBrgZZEMnth4EoP7LFSKmhyJWRXGPIW7EmlysUBFWqhN3nfU
         ddikwVZTv0C/JufkLmxSre8F1HiYWpfTVxsZkv23XqxY5MVySEQqCWZ3JWwxWItWqM24
         FtnulBmrijnZlh9/ifJV9GQkd0CEZx/3Lwo1D5FCygx98mc9lMMIBL37Rgu++TRaAwNA
         a50BjauYNXKv1eDCrlOagVMg5NXgnHaTZouYCC1gX4ttDNamlUJUnOnr9dVo9H1JEhNI
         S/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770928687; x=1771533487;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz5Tu3S5+Sv+FMhbeR8re+gY+jm+XKnRuhsiVfye3mc=;
        b=d7/vp8xeAqGQHqStcC3H/LEtfrkbn0blvzE1489azTXjecyZHFMaZe6VkZhuGUfsY1
         jNN6eCTpEBKLMBxJs5iuxZNkQANUNu9hQ36AD/k88PtHzH03qzG9xWNgCKcz9zG2tGpm
         tb+QpknBP1mOaZqEiq90guxZoodr2ynT5AVBYZcWgi6qDnXG9p2InbnlxhdQuHmbs2Ut
         g+8+uKBOme6HjZdpIIWPb/65Y6y7VZCGmbwuHbxVPsZenkIajh6YBUMUKX/VgZTyaGGl
         6XFqi06zT/DhuKfnqE0vQ7xpeJd/1snE2PUlFwoxS1P3YbAPAKFvIMQFnffQH1hRla/7
         yTzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQC//FGfYu+KjNMW8HqEWcL54XeMZzhUOBjYjREqOcaa//GGEuX4nxyLdcv7IMEQGgZYVtCP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwffyvIFKttXxdGE1bdMkt2U8PbgYRtW/BSfuFfhomXG3s2e4NB
	tf9KSaRNNHzUUOzZXvucUoTdE8JHsPimd9yWZ9ysvy8vG5Dff7x5m67GhryxCjyyrOv1TqYQgCQ
	Y704Tgm0bBuauHbZwsHF+3uVpmmt2sVSY2/CBG9DjAafHGezR9yo=
X-Gm-Gg: AZuq6aKZIAtGzS0YAX93fBZ+zXOyA0Q/TdkwdNYetRfvGssJKqez/Dojzaol5jXrwLg
	MnHjQay4pKNoNI5X1xGKFenGZbl/KUq5+t7w2Qlb0SIZ+4GYTE4jUqWxIM2qNlFJP7Btl7GKShq
	k8EHxz8cgxrbosXFPXgMrXYo2EZYlWpdgN40yuwENgFeGWPdxEZPw85vqbxaNCxtrfTmySVRNnN
	isnkUSPkUodmo7k7mEqAh/cUJTiEu/KcVDy1UMjiyYGTVvK0xZLVySc1WROAYMTkjVPiATjEvzA
	ANG8OiosRDmLIHTzNk8Nc71Ful4/6CaPsQzBtwsg7qR0gnRU+hUN7EidhWyWgQnil0ywn1pQ00L
	mX6u40oIVUDmOCBryY/j0IWTR2cyYk5vKbfsIJGxbmQvQpu+ne0mjF78a1YuGFWsu3zbqrJQgir
	Mz4u5Kr/u7ykgMV4UU4ZCtn2S04Eg31rEKr2hftlsSXWDLCgccBTv4J87Y89TG7g==
X-Received: by 2002:a05:600c:5304:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-48370e2e303mr7036965e9.14.1770928687170;
        Thu, 12 Feb 2026 12:38:07 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:af2a:8088:67a4:6046? ([2001:67c:2fbc:1:af2a:8088:67a4:6046])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a3eb7asm4467495e9.1.2026.02.12.12.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 12:38:06 -0800 (PST)
Message-ID: <bfae563e-d2c0-41a1-b967-e9ac2c940d21@openvpn.net>
Date: Thu, 12 Feb 2026 21:38:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1126499: linux-image-6.17.13+deb14-amd64: ovpn NULL pointer
 dereference and lockup under heavy load
To: Salvatore Bonaccorso <carnil@debian.org>,
 Jon Penn <jpenn@bentonvillek12.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, 1126499@bugs.debian.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Lici <ralf@mandelbit.com>
References: <4be2e796-77ba-4864-a288-e6edf3b7de12@bentonvillek12.org>
 <176996279620.3109699.15382994681575380467@eldamar.lan>
 <be2d036e-42eb-4d3a-be1d-60c49801b884@openvpn.net>
 <aYYwvGbStTFvof4E@eldamar.lan>
 <9d240ea8-7e55-4be2-b99b-3f2657c5f8c8@openvpn.net>
 <aY43tezcIO5DDE2B@eldamar.lan>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <aY43tezcIO5DDE2B@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258500-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:mid,openvpn.net:url,openvpn.net:dkim]
X-Rspamd-Queue-Id: 39E4D130F59
X-Rspamd-Action: no action

Hi all,

On 12/02/2026 21:27, Salvatore Bonaccorso wrote:
[...]
>> This is the patch:
>>
>> https://patchwork.openvpn.net/project/openvpn2/patch/20260202132309.567382-1-ralf@mandelbit.com/
>>
>> Jon can definitely test the patch and give us his feedback.
>>
>> However, being this part of the code very critical for socket handling, I am
>> still spending some time with Ralf and Sabrina to make sure we are not
>> introducing any subtle bug/side effect.
>>
>> In any case, please feel free to test so we can confirm that the problem you
>> reported is truly the same as the one we were already investigating.
> 
> Jon, were you able to test the patch referenced above by Antonio and
> can you so confirm it fixes the issue for you as well?

Unfortunately further review highlighted risk for a critical race condition.

Hence this patch, despite fixing the reported NULL derefs, cannot be 
submitted as is.

I am working on a new patch which I should be able to send to netdev for 
review in one or two days.

Will report it here as soon as it's submitted.

Thank you.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


