Return-Path: <netdev+bounces-252670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEpeAzYnc2kAswAAu9opvQ
	(envelope-from <netdev+bounces-252670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:45:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA7A71F02
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED5AA3058A87
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6CE33EB09;
	Fri, 23 Jan 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHaQs6gb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4477133C514
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769154070; cv=none; b=r+2Pkz2un6D9c/HBBqSniIRleLu5akfBeazA5pYi52lM9sPbrXlJ6wMLq4Lz1KZBSEDYfQ6SmZHxS9SroEUF9TPdLTAQDYZB+qUBoHxE6K9A/6EEG6+6byQ0tdyzb02/xcTIYHFxYcYOl1DxqXQieVaTSKCyV+zi37SWlojahRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769154070; c=relaxed/simple;
	bh=SSNlL//EmVJwdSLWb5H1AdPiODSjZ0wQbWKwPLq4WTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+FzN9DQ+WfEkeEAKH4nhet0RszYqxaVkKJ28L2FsOFRDMwwxXdg5dBayvRFTKXa38K5Xx0Hkk3CIJiGdPLwbgMlEkymS4YjwzpzxVUcNhVhY7vNqq8icCCCeFy/1f8eo1J07LXOH4rTNVEVs38Vn+IDgy4kBJJMRs1ZQ20/sac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHaQs6gb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3530e7b3dc2so1890598a91.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769154069; x=1769758869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BybO1XLVfdhod5yqmV9OoExkCCsTqBLc4oAzOMgKi/0=;
        b=UHaQs6gbZKjX1Lcb6jA3vxC54wtI5UgluRNZ2t8Rd4xhjtTqJRxuyixloQMLgcBI+1
         RniU9V7kgy0/Pqpt1JQ8xx1AS4sCfoN/xeICB4bU52oHlIcir0MAM8xt7Xt4UjqbYnBw
         D8HFM7emUZPemAQbDnYdkuAbHY4/+n6eA8CIfrdTTKuKceWXtkFUrWPNhnZnf6ue7n7G
         qQ/1AGyRIsXrAIwVCr9HKIwXdFRn2xuLfXwYu1htCQg5Z/FBnFcAvonXOXEQVzI0cbM+
         zg/RJnvMNJiD2+ApkEKb5QZ6K3PzbE4LGZ+yVlyhNNaEfN3p9jhOHDN1FJUKnmWYHhCQ
         i0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769154069; x=1769758869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BybO1XLVfdhod5yqmV9OoExkCCsTqBLc4oAzOMgKi/0=;
        b=mobetv9649FaD5sdXQdr3oqchF1ntj50IufRyUWG65BdQb+1KtB8C08OKb2zSnZ0RO
         sQF7pOajzSPj5Fv9jADltBPoRf/DFam8HTaMP5VE1Nx2TMJ+drkgWoxpax1RO17XXCuj
         kGVVsuhWlwVNnMVNBKEk367bK+wa604Ws7Bd16b5XEzjotwCT6OgO/A7LTO7wRw33+GO
         9nkOP5U7gC+fA+5bMzgQoC/8cCFL+LayH7sSrlBhlUSnlScQzjXurEzwLd46vUomX4Jw
         iLxBUm/VsYg+1EVAwuuxYi19/XAvzxVY7HNFWiPXbowlLQEQJsaP76pzryn78E/xqYak
         RFQw==
X-Forwarded-Encrypted: i=1; AJvYcCWYfkt+zuljGcC5peV5nLW9YMiOJkL1G6IjSdkM+wSf9yge4kKCoZ5h1Zio6q9ROsKIsjJg/5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTb5KlNUZtFI8QTpCTBMw0ixmi69mDPMKHSMgn1bbAu38guuXC
	tyXRB8WFrs6iCYGUODPzZ6bcInJgG+7xiW4qj5fHIWaFKZ4IdQMp2SKX
X-Gm-Gg: AZuq6aKO1G0XDliiaCvZRzkjO/a08H2Gq1+/vq/a4L2Xt9ZnFhMoLlnJZCdA00YWqaA
	4FCAnEblSZmIB6wwGzOwkSYJtMGX3+dWLQKaas+b1JXk6IX88nbGM+OgRbe5vAzUAY6vcsc7d52
	W9HBgOukpn7YFxgw9fU+29T5lz2EcyEWimfBBiB7S1XR5Zzul2FQ1RCeXSWL0MTRIQf6b+W6OrR
	Cb0Q+QXLMxaFQYcKd0DMGiDNdShsgFd3/vN6vtFWUYzbOobvFGu/Hrfv/VeZL3+Qzad0H/2yBfb
	LhsVbwHbuagf3nTBSMVv8UR88xNDOQ8mC7GrWcAN7i26096HqWLcD6obGFcCrF4NXrQ681RAp5k
	pY1h1HSAQWJljVKK36VUcjpHWW9GzmgwPRYpWaGCPxuWUBVnss9vQTFkCw80l5AeQMu3xBgC8Ta
	AHJBSd186jxDNd
X-Received: by 2002:a17:90b:2d8c:b0:33b:be31:8194 with SMTP id 98e67ed59e1d1-3536911f08amr1801422a91.34.1769154068601;
        Thu, 22 Jan 2026 23:41:08 -0800 (PST)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc506dbsm1276411a91.14.2026.01.22.23.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 23:41:07 -0800 (PST)
Message-ID: <abf12a3f-9cdd-472d-a02e-af4da594b84f@gmail.com>
Date: Thu, 22 Jan 2026 23:39:29 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock sampling
 control
To: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?B?5p2O5b+X?=
 <lizhi2@eswincomputing.com>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
 <308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com>
 <59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.ch>
 <4e2a55e7.3662.19be8cb9c3c.Coremail.lizhi2@eswincomputing.com>
 <c5c0bfdb-316d-4796-afa0-f6f018ceb414@lunn.ch>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <c5c0bfdb-316d-4796-afa0-f6f018ceb414@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252670-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ganboing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BA7A71F02
X-Rspamd-Action: no action

Hi Andrew,

On 1/22/26 19:19, Andrew Lunn wrote:
>>> You say internal. So the skew is fixed, it is a property of the
>>> silicon? If so, why a DT property? Why not just hard code it in the
>>> driver? Since it is internal, different boards should not need it set
>>> differently?
>>>
>> Thanks for the question.
>>
>> EIC7700 has two Ethernet MACs. Only eth1 has this internal RXC/RXD skew,
>> eth0 does not.
>>
>> So this is not a chip-wide constant that can be hardcoded in the driver.
>> We need a way to distinguish the two MAC instances, which is why this is
>> described per-port in DTS.
> 
> I assume the address of the interface is fixed. So you can just key
> off that to distinguish the two instances.
> 
> Since this is an internal property, not a board property, it is not
> clear it actually belongs on DT.
> 
>      Andrew

IMO, they should be in DT to provide maximum flexibility. The SoC .dtsi
can provide some sane defaults, and the board vendor can later override
them if the mac/phy requires further tuning. Applying such tuning by
the address of MAC seems messy and it hides the parameters used behind
driver. Through DT, everything becomes really clear.

I assume this is not uncommon: E.g., starfive/jh7110:
https://lore.kernel.org/all/20230714104521.18751-3-samin.guo@starfivetech.com/

BTW, no need to worry about backward compat. ESWIN hasn't checked-in any
DT for eth yet. As you and Russell said, they need to do it, pronto.

Bo

