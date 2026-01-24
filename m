Return-Path: <netdev+bounces-253024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHOBBhtWdGnj4gAAu9opvQ
	(envelope-from <netdev+bounces-253024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:18:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6F7C8B4
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 126B2300360E
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 05:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541421DF248;
	Sat, 24 Jan 2026 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGqRwl96"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5D1A9FBD
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769231895; cv=none; b=IdL/XalbuRX8YRncHn+7YlveJ36Bmww/QqvJNvtbNMG3seFTS6bgKmnFPFhDXl9wxFHtrKkBahH8JMF1JEDRLjZiJdlLxmF2lQZDZkfzuqPuIrkV78aumVpSW3Myjmp3Yzk3WmwaRSsxir5c2FQi6IK5MAhcSTSR2RIlslAnw3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769231895; c=relaxed/simple;
	bh=rPtHryY0q9AVLq9N0aEIaze3I2zH4NeZeRcE+2JStw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5tIB1tdhrYMNYVukw5VBkz1hpvLqA0WdvYzfLfapSrIhsNvR39R6ClNG7JDPAimH35bUEmDJ36z5DEhC2IrCrYUmclH8y4B5nf+cbdAXIUhFcxgxnmRr/yN9xWJGcAJktYmnw6JRgwzAaWBT1wjbG54NvEj1+M0QNSzzLONork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGqRwl96; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c6c922850cso303796585a.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 21:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769231893; x=1769836693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAVsETK21+kGnCxqlDEtp4ioX9WXTvhY2/OchwRYyU8=;
        b=VGqRwl960RKleyqmpe21M8Z+RY3wDdC2KOl03FvsZFeZXqFZ0Ip8Ns4wm03QWZEcTE
         t+537x8UodNnxc67n18oe9WdWFuKLBIX/FvXIdzgGa7g2GFQg6w20xPrMOFtkLY+UEPh
         8FiA/cG0ddqf5PGPOzHjb1OEn4dM3B6CtGWnBo7v3TBH+o/0ktTMmWwcbvI0sRlmJe1o
         STXDcryi11SXVckNeffD5sZCLFOS/JJU5Lly/rj1T71Z2L33k8PS+k4vo4eSgM62nZUe
         5nrAPi93rDwx1AqMhm8XuJYRD6EBLOc08KlxfEL+uL6QJkNNVCdeTMEs8IWOplWIwWO9
         8hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769231893; x=1769836693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAVsETK21+kGnCxqlDEtp4ioX9WXTvhY2/OchwRYyU8=;
        b=sAJntlWsX2cSkeW+yCK65jxJaXmDM8wgSEGp0SDwC+97HQ9dPmwVF6M/rCabuNttGI
         fYFHTYPgfJMt9bI5zvoEXqdQStVhenm2GLMpPuS2k15Yux2+LTvxEyfEoLu9X24CI+2d
         2aBe0bSY95CnDzuRMpgcBSEejRer2934E8w1Jv0kjblMzhrf+zmaqN8h6vnkDyrHorQ7
         waklEArjAgoEjRrfMBLM1dHdQzmthwkLD/h2Oa2CjfMeeALpe/diatDT7t2EobWcewzS
         MA1BTtlmFmQaiTBmgRZvmKWIC1iGvONKuQGHFR5s0WnJ0/3eUB3ygNBEAzMBtaOhwADG
         cwkg==
X-Forwarded-Encrypted: i=1; AJvYcCXLy+Akz5AgNhr9Hcs9AIgvwM4EwmmWWrOApb8eNyNdtRkAU+K6OtcRrtl8e8xLIGR0tadohiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkBZBIN9LY/ytFvdZTkPsfyEdFVn6mNamijFS27Bl/JxgfZ27K
	VIjNfGJcP/al/eZhR/oZ/gcnVNYauhSJVE8G5I5+8SgNTfDpMBbX1l80uMkkbw==
X-Gm-Gg: AZuq6aKXVJwC5Rk5VM/7THN630BVgm2/lHzkzX/TiUInfaEVjGBJFPT79aTOrtXhZ8l
	64v3LWw6LqTEXMN6Xd6fF4JRxu8tpg8qF2sQo+yr+L9Z5Fsec/CgAOBEkgE+07SVzmfD1lTBs1v
	V/Zj1m0w0PJPfZSP1BDibsFVt/S9ez2jvqnAs2hoW3z4eIZEKy2U3WxXcNeFfu8TMtA01g4w3JQ
	dV2H7QP0QRjQ6Re2O8Oq6u8Y0GNte9POMUCiffFxAGFagi16xbYj12Za40iPtf+5EnaGbdl1DwU
	NXRcMmv0ZkICBYrkuokLk0TUOT59L1cCnTYfmbw6LPxLJz4g1QYcWv6WiJ3zWREYHj74SLLU6IF
	hDuWJZmY5Ov37O+83LXIshR1/PuUsFJselkUQKmzpPbC9JPeea2w2v0U9su04b35L6ZdkoQeE4g
	hXvSYrDywvbjfGkLU+dWxugJ+wi0om2ayzJr0=
X-Received: by 2002:a05:7301:1015:b0:2ae:5db9:f32c with SMTP id 5a478bee46e88-2b739b6d1bdmr2095282eec.26.1769230365229;
        Fri, 23 Jan 2026 20:52:45 -0800 (PST)
Received: from [172.16.0.242] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa22707sm5548789eec.29.2026.01.23.20.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 20:52:44 -0800 (PST)
Message-ID: <009aefc4-fbc9-4f91-9230-23d18c281bf3@gmail.com>
Date: Fri, 23 Jan 2026 20:57:23 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock sampling
 control
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, =?UTF-8?B?5p2O5b+X?=
 <lizhi2@eswincomputing.com>, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 linux-stm32@st-md-mailman.stormreply.com,
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
 <abf12a3f-9cdd-472d-a02e-af4da594b84f@gmail.com>
 <e6f7da45-3dec-4af6-a5b1-a72210bf24f4@kernel.org>
 <43923bf9-6202-4147-8eac-5bd7bb653fd4@gmail.com>
 <bd202cfa-d6eb-4d0e-982d-b49795dd25f7@lunn.ch>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <bd202cfa-d6eb-4d0e-982d-b49795dd25f7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253024-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,eswincomputing.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,einfochips.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ganboing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EE6F7C8B4
X-Rspamd-Action: no action

Hi Andrew,

On 1/23/26 11:43, Andrew Lunn wrote:
> On Fri, Jan 23, 2026 at 02:47:18AM -0800, Bo Gan wrote:
>> Hi Krzysztof,
>>
>> On 1/23/26 02:07, Krzysztof Kozlowski wrote:
>>> On 23/01/2026 08:39, Bo Gan wrote:
>>>>> I assume the address of the interface is fixed. So you can just key
>>>>> off that to distinguish the two instances.
>>>>>
>>>>> Since this is an internal property, not a board property, it is not
>>>>> clear it actually belongs on DT.
>>>>>
>>>>>        Andrew
>>>>
>>>> IMO, they should be in DT to provide maximum flexibility. The SoC .dtsi
>>>
>>> This is not the purpose of DT. Please rather use arguments in terms of
>>> DT rules (see docs, presentations).
>>>
>> Any examples? links? Thank you for your patience.
>>
>> I'd say if the board .dts never overrides the eswin,rx-clk-invert, (E.g.,
>> the SoC .dtsi has rx-clk-invert, later the board /delete-property/'s it)
>> then yes, it can be treated as something inherent to the mac, and then
>> "use arguments in terms of DT rules". I was thinking about use cases like:
>> https://lore.kernel.org/all/20230714104521.18751-3-samin.guo@starfivetech.com/
> 
> Your device should be compliant with the RGMII standard by
> default. There should not be a DT property to ask it nicely to follow
> the standard.
> 
> Properties like
> 
> motorcomm,tx-clk-adj-enabled;
> motorcomm,tx-clk-100-inverted;
> motorcomm,tx-clk-1000-inverted;
> 
> are for broken boards which break the standard and require the MAC do
> also break the standard so that everything works. We should not start
> out with the assumption you need to support broken boards which ignore
> the standard.

My reading of
https://lore.kernel.org/all/308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com/
is that the eth1 MAC is already breaking the standard at SoC level, and
the boards can un-break it or break it even more. Hence, even for proper
designed board, SoC .dtsi still needs eswin,rx-clk-invert (for *eth1*).
For broken boards, they may require eswin,rx-clk-invert for *eth0*, even
though SoC doesn't mandate. For *eth1* broken boards might have to
/delete-property/ it and use eswin,tx-clk-invert or something else.
It's clearer to have all these parameters visible and explicit in DT.

ESWIN, please correct me if I'm wrong.

P.S. I'm not affiliated to ESWIN, but I do own eic7700/hifive-premier
board, and I can talk to someone who owns eic7700/megrez. I can help
validating ESWIN's patches independently.

> 
>         Andrew
> 
Bo

