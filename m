Return-Path: <netdev+bounces-249359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B1FD1732D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EBEE301E6F7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF5378D8E;
	Tue, 13 Jan 2026 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBz7Dsth";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ed8CfGmy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0183793A0
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291653; cv=none; b=DS1Z4WZtXESSmEIfgMtKsoX00QanxQoV80yFV8E6Jc2EvH6/JPPPLbUuJOhfFC7OHJbKcdNug6fhc3+dRlgKWinstWZCJkZCXraIWdvdVtCZTj8mvHuoAlXRgCQ1/CJ18xyelrKxW9Jzvtwq/dujH+Pjymv4oY6cmNTQD7ozXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291653; c=relaxed/simple;
	bh=QqHS8tGSO+lAiUJDu64Fy3Z87MlLp6hIRj3FncezFoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+PSQv23jThKIwduMpKj3Kb0hiMdiodL5yZ8LLZ+kgOp/BIj8kjmkEE/Y9fomakN1LqJTX0RCVp372JThJMF6jXCVVvBEEWOSePeBysp/IrKuZNigmLc7hZdL/rfYTDXlasTCMJb2zjTwsY9emW5oX2P3iTqDojpa7FWJSAPFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBz7Dsth; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ed8CfGmy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768291650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpFpD/66JMzeRmJEIFuITSB9NnlDWQx+ollnQo+GVf4=;
	b=CBz7DsthE4vc27GB1wvMHrqnNeLj1JTsEyDIMHP4UfexI+5JebCBp7cZ3VJ0wRhHaYKrKf
	8NnErHCaMoNUA1DpAz2IDuY8jN0LrnfuX1a3hTKH4U7g6MPU9NQCyHCQTWNdo4WaYhKK1J
	AqsDWaaTQWGTfSOzcTr64X8i9Zwg5qQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-TeDW3NpXNOS3z4o79tDpRg-1; Tue, 13 Jan 2026 03:07:29 -0500
X-MC-Unique: TeDW3NpXNOS3z4o79tDpRg-1
X-Mimecast-MFC-AGG-ID: TeDW3NpXNOS3z4o79tDpRg_1768291648
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d4029340aso74775165e9.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 00:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768291648; x=1768896448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpFpD/66JMzeRmJEIFuITSB9NnlDWQx+ollnQo+GVf4=;
        b=ed8CfGmyBD0iCkq2DLkqoHqtkOvdr3HG7Mll8xuZHKEdRpfXzcPQVONz0+4ffq9hE6
         snR0Qi9dIyKDtDrhH0XEXRGyN/obMzHpXslvCD7B31CctHBVY5TamnJ/MZb+p/LmDXpO
         5akYvGgcebbhmDh094ZBGHVX1tKlfCnVniTjTInXfuhlNnB1MC3FV/UorEcJGFq5pHyc
         Jfp7xu5bZrTqDDG8ankhVybdnnH41pAbe+ynm4jQq3xuKlTHM6d5rNK5h1pty+ZwE+4O
         EaxImmAcQ1n9mtT4WgsM26lR+H283+fumPLLzLVOn4IK79i01yJMZqZBBuB1M6iUl3lj
         Xc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768291648; x=1768896448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpFpD/66JMzeRmJEIFuITSB9NnlDWQx+ollnQo+GVf4=;
        b=jejQwmMl3Bh8SxRpTHe4YN/T9ycbp54bOvtAPgWkz006ETCUVunqGC0l7bCajpgxaq
         QK1NJw4AByGjil63ahKViiMoQ+gCArsZwAKwQBG8kngd4GndCKSAoe3DmE7xyZq91uFN
         ibopTTA/X48y+XnHRQWS6y24FHprNwCjIZO1Eb60aijZ1EiAiF7yblYxSJ9zKV5+FvS6
         Un1O1jedzGppjyOH8XgOVeVQQgP4UTMgoCc+fknGzi4MkU8JMl5+xzVMMKoPpmf8YsaK
         56B51AbWSOj5hSquT7/HXH4DVzaTdEavyrY6bf0FoKVhrIS1xScqLAcTxpWCAvAgLl/M
         ld8w==
X-Forwarded-Encrypted: i=1; AJvYcCVpgX0RdKwmhKj25dcg8FXLq/IA9imLjuqgwHECk9B04C4pE+N3pRO0lFPuNmxv/bCuXAB8nrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9J22kvHcPgO1WyO9xZeeDWKSGJ7Hv7/ATJoJdR/HQjc9ZZXt
	MQEngyHuCz11BgoLzvRhIE2SxmkOQOHJouF3AvQ2myz9AMJFjWkjeH5m2dWDhuFtsFXKLY3XvwO
	jacpXzLHnKj1ksljh4taSagnL9cHTqN2yxzK9zLwGgQzx6RtxJdygKwxvTQ==
X-Gm-Gg: AY/fxX5ps1u2iPoU/Sy5Sg9ZLHDlzdemNub0xK21/3D+CqaWvngQeEqdSwBTt5fg5Bl
	Fmcilu33WME6+aGvNtmuEoWjfpP1rew8wod3Yti6sfzWJPtuyBuDDHIHtV82cqkMKGuWMnBR2mT
	vdKCbOuT4ufD3DHCv8mrExyolOdNKgG6J/kNZucUQP0MHUBH/cKpps4/X4o39nBAtIMa9T42YM0
	M2R/ZD3MqpgTJ+Yy0jOpkLlGiT7M2u/Qoe0ERTLvZ+1wWDjQIbkiuPTrf0dUVTr6d6MxY4f1K/q
	tcrVvFNuyH07jEe6uzFdi6gfUHNxyS+xoS7cmTRbgxo1hYE444VRHHjalCrKzVGAYRDzVzuxz4C
	nhSLNJeey1ruE
X-Received: by 2002:a05:600c:4e8a:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47d84b170famr271324775e9.10.1768291647895;
        Tue, 13 Jan 2026 00:07:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOFVjo+JswERF7bNgzNfXDlKZqG+DpPg56zhYUkxZzuUQMa8aCTbd70GGyky4hiW1KBY5XaA==
X-Received: by 2002:a05:600c:4e8a:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47d84b170famr271324195e9.10.1768291647476;
        Tue, 13 Jan 2026 00:07:27 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e6784sm43665733f8f.19.2026.01.13.00.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:07:26 -0800 (PST)
Message-ID: <c9fca0a2-227e-4081-b7f9-ea7c2189f6d2@redhat.com>
Date: Tue, 13 Jan 2026 09:07:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 00/13] AccECN protocol case handling series
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Cc: "parav@nvidia.com" <parav@nvidia.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@google.com" <kuniyu@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 cheshire <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
 "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
 Vidhi Goel <vidhi_goel@apple.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
 <56f6f3dd-14a8-44e9-a13d-eeb0a27d81d2@redhat.com>
 <PAXPR07MB798456B62DBAC92A9F5915DAA385A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <9d64dd7e-273b-4627-ba0c-a3c8aab2dcb1@redhat.com>
 <CANn89iKRAs86PVNAGKMUgE49phgZ2zpZU99rRkJq=cc_kNYf=Q@mail.gmail.com>
 <PAXPR07MB79845267EDCDAF9FA379B139A385A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB79845267EDCDAF9FA379B139A385A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/8/26 5:01 PM, Chia-Yu Chang (Nokia) wrote:
>> On Thu, Jan 8, 2026 at 1:05 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>> On 1/8/26 9:47 AM, Chia-Yu Chang (Nokia) wrote:
>>>> Regarding the packetdrill cases for AccECN, shall I can include in this patch series (v8) or is it suggested to submit them in a standalone series?
>>>
>>> IMHO can be in a separate series, mainly because this one is already 
>>> quite big.
>>>
>>> /P
>>>
>>
>> If possible, please send a packetdrill series _before_ adding more code.
>>
>> I have been reluctant to review your changes, because there is no test.
> 
> Hi Eric and Neal,
> 
> A separated AccECN selftest patch series has been submitted.
> You can find the used packetdrill commit and github link in the cover letter.

I marked this revision as 'changes requested' because I think a resubmit
after pktdrill patches merge will help the review process.

/P


