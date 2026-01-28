Return-Path: <netdev+bounces-254099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F7DGBSQeWl9xgEAu9opvQ
	(envelope-from <netdev+bounces-254099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 05:27:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A09CF81
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 05:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2C81300468A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8325D33032C;
	Wed, 28 Jan 2026 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSCbreYE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C044F32F74D
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 04:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769574416; cv=none; b=lJKbTIHsWGqUO9+UcTyGvjaHkvs/PEvF6HkL4/0nZACx0Ef+8BnP3/+cTWwmPocMwR2iE7VRyLKZ8+WAXyOApCUqlaM6nyKZzYYrbaiIjPWiFGSvRJnyFnkR1ryyPU7e236k1A7HsofE6wpSm2Oo8KJhDvra+0MGowBj5rpD258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769574416; c=relaxed/simple;
	bh=oM89C4h0+705Q5QrOC+AfMkyUp4pRbPcDrBjP080Sos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZMpGwWHUoViV8I+3RvRPAw+H2HEhvygc56Xwxxb+ZmhbCvCwSbvcyOZNruD5tmSNKrupKsAVwb2gPzti3FJHL10Xi7Fmj9906PjzXsLJ1lgJBlXyoYh6nBrI55BZ2Tg/FNhi6qn87boGa11adiGPXDm3aWyRvfR9NCbRmPQUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSCbreYE; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d18d02af68so345403a34.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 20:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769574413; x=1770179213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VklwEd5dwuBjikrAPpEFP/UQPzhOaAWoIKJ/0tvPqOU=;
        b=kSCbreYEXAhYBbYLYGpFyiN+NWpLZGu1kwM5p1Enx2QxAirsG+QvfJQoU4CoXS1gzH
         U3FZ9xihO5Pd/Nn+hameRMXYf/vGhludPcd+JkSHDEvBXL1fIKHGCFxSfe2MR2wlbmGI
         tDyl0lhyt6e23w1oQlgdD6RqfhuTz2dmCpRA0M2WBTiBJ/79iw/WN3QisPul/SfGlDhk
         8tdljfB2qPBr/+Kpa+krat5/9cNjNMgJHRCbel53bNRaBM6qq9WGAPZB/OYbDyGsIwYE
         wriGLq8SBK46OJdFmgs/YS1z/Et905tXZ9KR4qOUrjVwLqiFqoRESi5/HYofezzkQTeF
         Z65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769574413; x=1770179213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VklwEd5dwuBjikrAPpEFP/UQPzhOaAWoIKJ/0tvPqOU=;
        b=UVN2QCefBarqeqwRhKUU0xSOh1Hme3E2akoC457GSNkadUp+HTMH5i6CAyM1PCAs4q
         SnCnJM8nAqbopCXvb4OM5KuhfnwX1h8QI208LNIE+lbMcM1AmqcaQ15mXi9k2ulGkDwb
         bsvjTPC4va7yeXskDflQn1CPJwMO0dDVBT9h45yflNcSKiAyIBfvzabXdi0WENaW6ae6
         CgF4l3NJCg8z/p/w/wbkXZRtOiWmHAKnrvHkD9dAs/99jcugaw/K3/Vn1JEx2axxnEnm
         0bwFZ1E7VVxzyj3nLE3kE8GeMv/6i9D11YUYRZXzWpyU7y33UC+yba6tcqEp0Wdw9Wjd
         sYtg==
X-Forwarded-Encrypted: i=1; AJvYcCUPF199UPWnexqNiTVyXwwFAXJthNrA/3DDrDEgUlATBh+z2/SjPGxhbkpP3SXh6MxY6qaZUwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/a/PokYx0MtzSRpq25UGPrWLHtN/jqi6wqcf/UuRZ5IrcxsgM
	AyqgMOwTAY0q2PmnWGXVAeWlpD2OrbgQoke2B1tTwunsF0EhAOzxlrwYfzB74Q==
X-Gm-Gg: AZuq6aIwyU1SksHTbGBT2ngPZ+9O1oGwWCFdj54zJ26YBLPW159SNXuwYB0d5oTqrZ9
	Aiqz3kBwvZ90sFdHXl9GzrbocsiHCpoMnkfz2Yci8+dbQdShjPt7PQRj7V8aM/xH4icW90WC/dx
	Y+WEyN4IR7tXmChoXsrchx3lODeLxe1lmobKiUqqlpjavvL10IpxHv7Ncd0VFJUDIswQXfYIrXC
	f+Sb1hUy92CHy6cWPgY/s+I7x7SYN3mw9i+VHGXKod5Ljm+lMD10uFiMRTI1mv5Hch3D9xrbfCB
	rfyICaJVgaU2KJ+wuaBo1a3oK90s8tqw50LfSCaSJD6wxHSXJBk3Ybj+MYH6TXfunxgWT4x0MHG
	Gtq4K6msJ43VFxuUKd2SCYMUqONawERBYls26zZoWFiiXMr429oIW9uAsMjfmzO3KXBxBMayHpb
	IYSdp3IiKQVC+g71XA25zMzdAzR50RCuOYcVnCp3X37TAKjg==
X-Received: by 2002:a05:7022:1099:b0:123:3488:89a3 with SMTP id a92af1059eb24-124a00bd734mr1918278c88.24.1769567650952;
        Tue, 27 Jan 2026 18:34:10 -0800 (PST)
Received: from [172.16.0.242] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1addafesm780825eec.25.2026.01.27.18.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 18:34:10 -0800 (PST)
Message-ID: <973f2b4b-bf8d-4a77-a27a-47495bc21ff8@gmail.com>
Date: Tue, 27 Jan 2026 18:38:28 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock sampling
 control
To: Min Lin <linmin@eswincomputing.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>,
 devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ningyu@eswincomputing.com, pinkesh.vaghela@einfochips.com,
 weishangjuan@eswincomputing.com
References: <308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com>
 <59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.ch>
 <4e2a55e7.3662.19be8cb9c3c.Coremail.lizhi2@eswincomputing.com>
 <c5c0bfdb-316d-4796-afa0-f6f018ceb414@lunn.ch>
 <abf12a3f-9cdd-472d-a02e-af4da594b84f@gmail.com>
 <e6f7da45-3dec-4af6-a5b1-a72210bf24f4@kernel.org>
 <43923bf9-6202-4147-8eac-5bd7bb653fd4@gmail.com>
 <bd202cfa-d6eb-4d0e-982d-b49795dd25f7@lunn.ch>
 <009aefc4-fbc9-4f91-9230-23d18c281bf3@gmail.com>
 <73ea5619.2b71.19bf847c80d.Coremail.linmin@eswincomputing.com>
 <aXeydXuWEMDz-yVM@shell.armlinux.org.uk>
 <32a1f814.2c79.19bfe173225.Coremail.linmin@eswincomputing.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <32a1f814.2c79.19bfe173225.Coremail.linmin@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254099-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,eswincomputing.com,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,einfochips.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ganboing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[einfochips.com:email,stormreply.com:email,armlinux.org.uk:email,st.com:email,davemloft.net:email,eswincomputing.com:email,lunn.ch:email,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:url]
X-Rspamd-Queue-Id: AD4A09CF81
X-Rspamd-Action: no action

Hi Min, Russell, Krzysztof,

On 1/26/26 22:14, Min Lin wrote:
> Hi Russell,
> 
> 
>> -----Original Messages-----
>> From: "Russell King (Oracle)" <linux@armlinux.org.uk>
>> Send time:Tuesday, 27/01/2026 02:29:09
>> To: "Min Lin" <linmin@eswincomputing.com>
>> Cc: "Bo Gan" <ganboing@gmail.com>, "Andrew Lunn" <andrew@lunn.ch>, "Krzysztof Kozlowski" <krzk@kernel.org>, 李志 <lizhi2@eswincomputing.com>, devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
>> Subject: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock sampling control
>>
>> On Mon, Jan 26, 2026 at 11:10:12AM +0800, Min Lin wrote:
>>> Due to chip backend reasons, there is already a ~4-5ns skew between the RX
>>> clock and data of the eth1 MAC controller inside the silicon.
>>
>> Let's analyse this.
>>
>> 	TXC / RXC	TXC / RXC
>> Speed	Clock rate	Clock period
>> 1G	125MHz		8ns
>> 100M	25MHz		40ns
>> 10M	2.5MHz		400ns
>>
>> The required skew for TXC and RXC at the receiver is specified to be
>> between 1 and 2.6ns irrespective of the speed. The edge of the clock
>> is also important: the rising edge indicates the lower 4 bits, and
>> the falling edge indicates the upper 4 bits.
>>
>> At 1G speed, with a "4 to 5ns" skew in the chip. If this is accurate,
>> then inverting the clock and adding 1ns of additional skew by some
>> means (PCB trace, or at the MAC or PHY) will give the required clock
>> at the receiver.
>>
> 
> Yes, that's exactly the case.
> 
>> The timing table in the RGMII standard (3.3) allows for Tcyc (the
>> clock rate) to be scaled, but there is no allowance for scaling
>> TskewR (the required 1 to 2.6ns skew.) This skew parameter is
>> fixed.
>>
>> So, at the other speeds, you are completely unable to meet the timing
>> specification, whether irrespective of the clock inversion. In effect,
>> the only speed that you can meet the specification is 1G.
>>
> 
> The timing table in the RGMII standard(3.3) says the max value of Tskew
> for 10/100 is unspecified.
> Quotation:"note1: ...,For 10/100 the Max value is unspecified."
> 
> I think for 10/100, the "4 to 5ns" skew in the chip doesn't break the
> standard. At 10/100 speeds, it meets the timing specification without
> having to to add clock inversion.
> In practice, it works at 10/100 speeds in the rgmii-id phy mode.
> 
>> Thus, I think this is something that needs a lot more than just "do
>> we need to invert the clock". You also need to prevent 10M and 100M
>> being supported IMHO.
>>
> 
> Regards,
> Lin Min

I had an offline discussion with Yao Zi and others regarding this. We feel
like the proper way for ESWIN to deal with this broken eth1 is to have a
different compatible string just for eth1, where it can be associated with
platform data with quirks to do eswin,rx-clk-invert at 1G. The property is
therefore not required to be exposed in DT. (Pretend it conforms to spec
for 1G). Need confirmation for 10M/100M, though. I double checked Lin Min's
claim, and indeed the spec says "For 10/100 the Max value is unspecified":
https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processors/20655/1/RGMIIv2_0_final_hp.pdf

Thoughts?

Bo

