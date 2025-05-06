Return-Path: <netdev+bounces-188451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07167AACDAF
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 21:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D9F983AA3
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72DE13A265;
	Tue,  6 May 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEPi+hMX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F723347B4;
	Tue,  6 May 2025 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558199; cv=none; b=kfI7vM8wcQ66TL9hl/FcK4N0O0bStlrrd64qNNl27F2/lkCN9mdF0zM9rojoARxbbih7jrny4Aci4+ZKQ6E66xU++tN7K6U12zJEbV9MQ/SXRPik1Yk14sB6OTle5ty+TpKWPoD+ByO1gePeUuySMiC8QphyclNVbxpKzy45Ffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558199; c=relaxed/simple;
	bh=prJM3YsEiSjPdjRctS67kSlherHtK/zYgrRfUPqmGdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSXDI28B86aIXr4B4bldt52clQi0tprAhbWF4ApN+gD+JXOO8u4pZSAID6mauqjP0hrAtQl90Odg4a0WrgT9aHAs9MZlopU4FAAEHKHPeWU/HaiY0orCjQtaN3ISzyVyHtaKM/UKJqnb+Voa858PUmvXvoMQ32pN0jW8RbnxITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEPi+hMX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227d6b530d8so58830145ad.3;
        Tue, 06 May 2025 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746558197; x=1747162997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=raTXFLVYBB/HYu2RiU0lUBif13ecYIjCdhLjcqxohjE=;
        b=EEPi+hMXxCy/ag7a3JhY+lj7V7Vipi1HsMUsHrkmfdnfdUlCjMavJTfUmZshHbb3vV
         br2N3Pc91OQefQdNe5iMviMQe+IdDHllLkWjh+xLjdlb3Gs1XlvQO7Jjz4UF4zr2XY3A
         PrKqgHGvt4SA2s1hPM1GbklVk0V6s1qhPwFrbvyl9WMPj/72KvbWAnVnP38lNMMbziSf
         B0bBksDnWOFyUNqKbIMvewN2TMEsm+9FGrbtPGMDANEMcmEbIDUKUG/MEhG31+8IJgZl
         DqX0PbPSv+Nz9u2Tz/w6huq7pj4SEdsicJInSg5LKMV4I8UHn7F22yyoD0rVZzV++abV
         Mf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746558197; x=1747162997;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raTXFLVYBB/HYu2RiU0lUBif13ecYIjCdhLjcqxohjE=;
        b=WWjuqGOZvYC/DWedH8y1CfJ3zUrCur71g3Cpa8yQoCaPY1qdBOETb5yRohiKTo8Rgi
         AufcAbwYwsPCKDihUbQJbxe7ytK1oRONVFxVyXRbT6ccH60jr+IYSc3d7LDm/wc5HLwF
         X0eMsFTgK5Y9t7VpsIfPOdic+gfWWarLpJkEnY+tbMqqaKxvnq4Uz0wzIz6UUn+az4U/
         f3HoYy682DlbdszmJigonaEIIVbRqEmbWxv4AQvFnDxIykMYZ4Jg2wzkWVDu1YwoHr4v
         1yjeImmPXNqHah18tQuurGFKY3M/m0n5c+eshl/1O6K0NuOdNmak72NtWqPGS0eQ0prE
         N1bw==
X-Forwarded-Encrypted: i=1; AJvYcCVGirJMnYxsSHQYN4DAkE6xCvSaHcCSjYIijuRzqdMOAdooiRZxDZg+pFFSkG7wxt+Jsd/Mau1D@vger.kernel.org, AJvYcCVK+Z23mZSSW8fKCNHkpiD06apocmfSvoSEfTJ85yVFgF8LfTyKwtAEnRAplpxtgLP0ZoQNEv/o5TagqMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS2/3ud0x+GS2Jeoi0iMn8AbDB0tLUtlqfOZ0MH89a3JdAlNmS
	ju5gcDicaKX08d3Gxv7K1cDeBRMQ4q7SlSQalOPs0LR8v/BXiUie
X-Gm-Gg: ASbGncs8ilYEiRHVpabLg1+RwluC7hzANXAAoNUh4b66EYXVv5x92+0BxIq2yV4Cwn6
	KwA39vocLqKGvtz2aX564pcWBf25sZsPn+Gq66c0ztYc98LQMCPD8I1xrfISH6dolkPjo2idEWa
	jBXJ2JDAkxyGjHtNo4lzWuZusiU5J5q3TfuyUddwpoDTHSeIkzHRdsdH5okQeiMBipYqsQt0rUy
	uEo8eIr1BXzG3ZPXpDf6Q60HPmeap4CzNOyi8wYeZwkpq7T5SWYmWk8pdvjTfCBqkdReJKxP0LM
	hLMJkacEt66v9eAMbXJKZjHD/UzgouF4Wm3FXI8H/cdAPQQuWVEx1U71yhSwyi6hHt16NBZQ8X0
	8Kck7H/gikSZy0FESc/z4fhWQ5GmKUghwbRwg0w==
X-Google-Smtp-Source: AGHT+IG8DhnRmqXW04dFWICPcas2W3reI1l/G/38K7CthPyp0aGNN5jxUkJLVDx7E6AQ9AtFEDn4Pw==
X-Received: by 2002:a17:903:990:b0:22e:39f8:61fa with SMTP id d9443c01a7336-22e5ece3f6emr5604285ad.34.1746558197528;
        Tue, 06 May 2025 12:03:17 -0700 (PDT)
Received: from [192.168.1.24] (90-47-60-187.ftth.fr.orangecustomers.net. [90.47.60.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fc27sm77519625ad.151.2025.05.06.12.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 12:03:17 -0700 (PDT)
Message-ID: <531074c1-f818-4c0a-b8d1-be63ace38d5f@gmail.com>
Date: Tue, 6 May 2025 21:03:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 00/11] net: dsa: b53: accumulated fixes
To: Jonas Gorski <jonas.gorski@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
 <52f4039a-0b7e-4486-ad99-0a65fac3ae70@broadcom.com>
 <CAOiHx=n_f9CXZf_x1Rd36Fm5ELFd03a9vbLe+wUqWajfaSY5jg@mail.gmail.com>
 <20250506134252.y3y2rqjxp44u74m2@skbuf>
 <CAOiHx=kFhH-fB0b-nHPhEzgs1M_vBnzPZN48ZCzOs8iW7YTJzA@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <CAOiHx=kFhH-fB0b-nHPhEzgs1M_vBnzPZN48ZCzOs8iW7YTJzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/6/2025 4:27 PM, Jonas Gorski wrote:
> On Tue, May 6, 2025 at 3:42 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>>
>> / unrelated to patches /
>>
>> On Wed, Apr 30, 2025 at 10:43:40AM +0200, Jonas Gorski wrote:
>>>>> I have a fix/workaround for that, but as it is a bit more controversial
>>>>> and makes use of an unrelated feature, I decided to hold off from that
>>>>> and post it later.
>>>>
>>>> Can you expand on the fix/workaround you have?
>>>
>>> It's setting EAP mode to simplified on standalone ports, where it
>>> redirects all frames to the CPU port where there is no matching ARL
>>> entry for that SA and port. That should work on everything semi recent
>>> (including BCM63XX), and should work regardless of VLAN. It might
>>> cause more traffic than expected to be sent to the switch, as I'm not
>>> sure if multicast filtering would still work (not that I'm sure that
>>> it currently works lol).
>>>
>>> At first I moved standalone ports to VID 4095 for untagged traffic,
>>> but that only fixed the issue for untagged traffic, and you would have
>>> had the same issue again when using VLAN uppers. And VLAN uppers have
>>> the same issue on vlan aware bridges, so the above would be a more
>>> complete workaround.
>>
>> I don't understand the logic, can you explain "you would have had the
>> same issue again when using VLAN uppers"? The original issue, as you
>> presented it, is with bridges with vlan_filtering=0, and does not exist
>> with vlan_filtering=1 bridges. In the problematic mode, VLAN uppers are
>> not committed to hardware RX filters. And bridges with mixed
>> vlan_filtering values are not permitted by dsa_port_can_apply_vlan_filtering().
>> So I don't see how making VID 4095 be the PVID of just standalone ports
>> (leaving VLAN-unaware bridge ports with a different VID) would not be
>> sufficient for the presented problem.
> 
> The issue isn't the vlan filtering, it's the (missing) FDB isolation
> on the ASIC.

Could not we just use double tagging to overcome that limitation?
-- 
Florian


