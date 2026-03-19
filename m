Return-Path: <netdev+bounces-269634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KjiA8RVvGkXwwIAu9opvQ
	(envelope-from <netdev+bounces-269634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:00:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A40642D1E54
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF9F830101C6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81D2393DEE;
	Thu, 19 Mar 2026 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjDvHnsS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B463644C5
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773950400; cv=none; b=TxUbkCxi3XRdL1cyJy8jcRY54InO9T8r7+ohB4Y7iAKjOaMoKVtTosULkZq8jQZ0dz1EeXVkihtVSjfDdGGM6Tp3WL98DZt1yIaE6uyiAzwOqO80d/yyEw6/Xw+g8kftuLbHSrwuFIWbq4uG16Sc+LC+4rAwmDIlqg9hvXHcX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773950400; c=relaxed/simple;
	bh=FsxeLlAzfNydLkYpP7gzqRo3/9IM48N4Np4DbPRjo2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phI1Rgj196jgQ4mlSyM+TV2zjsoYI2JEbUKL+351L6/qt9rnprGUIuVhOC74sLiRSTGEVHZ76hLv1Mr6lEPmT2kqVV3Gj+TFTY+wqVR4Z8sZ6N7CkAJnBhwuW5oVQLaqe4aFwKvJKrF/4OLGZ+KMQLEAND/+43uHlJ3Er117RBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjDvHnsS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b4d73463dso933825f8f.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773950397; x=1774555197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUCI2m0WFzcR8O8Kz3H1xd/xONUYrQEt17rlCR8xjxE=;
        b=YjDvHnsSolCoe2otfZ+la6vOnJehraAW6lfBFpaYWwJLxTLt5Pt9BYfyWPUUFUSQLn
         yDuXtmW2QvmPPm8668nq/KWlGf+2V5/8jWJwAQ3wZmTV3cAho/8n8yBWi8jZxPmswIU6
         UvqvBnwqhoUm4BgHAU17HoEC5/Yupq4ogGyCHHdWXsVokSed/cU4sWHfjKiac0vTkJlT
         IPrY0kpluwEeAmA42uziry3+SDkt79gzgu4yali1y0OfrPkyZ5Bjrk3gVR1S5On4hXYH
         Fu79o07OjUuybA8l0NnvEYLeW6ob8Vy2MaLTyuAOpxh0RK8XYoqvGUHKXKSZvYWdsjeP
         NNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773950397; x=1774555197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUCI2m0WFzcR8O8Kz3H1xd/xONUYrQEt17rlCR8xjxE=;
        b=e9QxCkFh3oMJirrXsBY7ASQWfrDm9LfG1osNlPt05fHAtcnQNsjYgKeuEwv1juUyT4
         u80RiTkuuUZRlgD0CixdxrCESv0iirBBzYIao882zdW+z5L6H0NdlzpSIitTeGSR/T4b
         uNcE+J8uxWQbCWgEDQPXIr2RSgfeAPlkW+dUoW4Vs9Fc7HqxamUNKa59rAwazx2JGG2m
         M4PZdbKZpq9iqLUDhPt3VYl3rNF/l8eVlOX5p90cuCtRJCrNh+/88mVKD/kk0YGjQB+3
         +JEkeIhKPQezElBAGOH/z1rR5LIdF0zVmYhlDm14vzSGzYPpCvIgKK1JRuw6c+9Ku5OI
         ROWA==
X-Forwarded-Encrypted: i=1; AJvYcCWNABgj35gTF0i9kin3ue0K+Q0Q5VbJsB3sT5sKGjS0Pyu7LVp1f2KfYBgqA2fs4QxeDenskPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5HdE8xbRoNxVDFB0K44gpOAdQHRMZeRCPkQi5Mog7qqlThET
	+jG+QiL3Gqm5jbxy32J8Vmyi3nBqP6SsNPPXu/H3ihYeywwP51dQux1r
X-Gm-Gg: ATEYQzw3GlIDUn5kYqUk4L4s9teV4Mw/0tw8cNFI3C0OlUUVhx1LZ2933qmelLuW1+X
	iy56DGWOt714IW7bD+tpQctMux4tqXso0nm1X1NQuz1S6IYtkJJl51vrlChxYY3t01JVt0bvTjp
	+Fu4Z6fL+7P8vT4PgcfdSCha5ACIqJoXB9OUEQI3mw2maDA0AWsJl5/v4kYzM4ouPePqUyVUtEj
	IymFEp8BdCo2MMhMl+UPofQ5/9lMPoYklBNSFp+S3HDV7pBxHfECBeJvoroQ+Am42FOy5Am2oFj
	9U1h6Lt7P3Lz97ZKvN2WCeeGaRzicgMy1POW/IAynbLc3fh/GoCzjkpn1HSyZqs5704P+hiDLBm
	+avExIgNVrJdk9zyKF7phVmcjutdyh5OQPQl/lpA1Wdi0pCWzdDbvr/nm4VU8liQIuj983dtmHs
	PCK1JU8OgwXHiqPdYZju1g2rIKK8kyczKI4TT/PDg2v4jn0180wJOZB1mKE1DUfL/wLXK5VsXpU
	mOb+ctXfl9yi46HayDcVJOzTWiMV8hefL0H5QglzQfvdRl9dxJtUdeIXRZC7vk=
X-Received: by 2002:a05:6000:2912:b0:43b:45d1:f448 with SMTP id ffacd0b85a97d-43b64244c54mr1076988f8f.14.1773950397303;
        Thu, 19 Mar 2026 12:59:57 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2c:400:f8e0:cdaf:773d:7972? (p200300ea8f2c0400f8e0cdaf773d7972.dip0.t-ipconnect.de. [2003:ea:8f2c:400:f8e0:cdaf:773d:7972])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470c239sm870967f8f.27.2026.03.19.12.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 12:59:56 -0700 (PDT)
Message-ID: <e063ce5f-1789-49d0-880c-e4b6a40da9e1@gmail.com>
Date: Thu, 19 Mar 2026 20:59:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: Discussion on implementing RSS support for r8169
To: Javen <javen_xu@realsil.com.cn>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <1ce3478d571f4d26a45e792c4c84c429@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <1ce3478d571f4d26a45e792c4c84c429@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269634-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.977];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A40642D1E54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19.03.2026 09:56, Javen wrote:
> Hi, Heiner
> 
> We are now planning to implement RSS support on r8169 driver. This will require significant changes to the existing driver architecture, so we want to discuss it with you.
> 
Thanks for the question.
I also once considered this, but decided against it, as I didn't see enough benefit justifying the
significantly increased complexity of the driver. Even with a N100-based mini-pc I can easily
saturate a 2.5Gbps link with the driver as-is.
Any specific reason why you consider adding RSS support? Would be good to see a performance comparison
as basis for a decision on for which chip versions RSS may provide a significant benefit.

> Based on our vendor driver which can be fetched from Realtek, the key modifications will include:
> 
> 	1. Enable msix and updating the irq allocation mechanism
> 	2. Support multiple rx/tx queues
> 	3. Register multiple napi and update new interrupt mapping(isr/imr) for multi-queue
> 	4. Implement rx msix poll and rx interrupt function
> 	5. Implement ethtool callbacks for rss configuration
> 
> Should we submit the changes above separately or submit them all at once? Or do you have any other suggestions?
> 
As Andrew already said, please submit the patches in smaller, reviewable, chunks.
Best tagged as RFC.

> We want to align with you on the development and submission approach. 
> 
> Best regards,
> 
> Javen Xu

Heiner

