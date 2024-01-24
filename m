Return-Path: <netdev+bounces-65449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A79D283A890
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 12:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DAF1F22C85
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1383560886;
	Wed, 24 Jan 2024 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="nEefqo6l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE906087D
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097162; cv=none; b=amHXEuxLrI3t8GibNyy/SuylORiUWvy7A9Cf2z7IT4Kn9PSNCTf5bh2kSiHAjLHcn89zSfM4vN8g3FdAdBfntsX74VK6JaV17BBRqlqdJgoDTQ1L6ELis2G8gV2wivPDgDQcjW8ZHML4abD9Cpx8dkXfLBccdzR1Fa5i3s84GAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097162; c=relaxed/simple;
	bh=35TzRf1iqrpO+kvL/ZgrLkZs4y5LkfcAcVg6kR04IWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPs+j1H7HIMoJcPUkc+c7Oj5mog86Zaph3PxZ1ePxcI5PmtBOCKFUCPJu2bNtcMLa7EppUetSWnF6iKCG4h5FPTcTqtiHnjLzNaiSiAt1VFYigbzP3C+A+WgdedSmDd6u3s2n9/wH+vneAkvK3xDGG1hkZwexP+aadOkkgoCFYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=nEefqo6l; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ddc1b30458so10207b3a.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 03:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706097158; x=1706701958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLT6be+hi95lLZ51yKFnZXpYmPsuirEXuz1rGnx+0do=;
        b=nEefqo6lRRs8PsFFyryxK2G+v0PalBm0C58d+LASKCrT0jU5Q37qtWNI2DUtvmMtiB
         oN9hcO4xj0UNXjg1I3bsX6QmMUrVlJXWJlv4fo8JJ4TwOfcRat4ZP12En8s1bQjdJmjI
         Qc87pu84AXD3nc7ZSMF9k3hPF3xaL54dfGNQu5/gd+S6rm78ul/FXA4WaMlbtwnHHKeh
         iEgBsBuFpb+FVZDNHYmiHjjqLAwv8W9WtF5GTX9+7gl6ZfuyeP8ViMb/XndP8aLATpt/
         Gx2E1jePujDCk93UNiEzv+tY2pQgccHiRf1zwj/a3uvN+3BGM2/wniIpXFHxsezDbGeR
         BgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706097158; x=1706701958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLT6be+hi95lLZ51yKFnZXpYmPsuirEXuz1rGnx+0do=;
        b=JwDSTIcDVg2piAo61jkYRLgKG4Oe5LjbTM8PsAAGTYajg3k1Ona+A/f7Cno6WgoFhu
         xyGAcZytksvfwtiuSt1/0WgTd14GOUHW/EOpdBI1Kz0KvyIprjpRQcZCX4g0IP3bTl9+
         uKyVbMqAI6W5vwrg0E0oL0pwQAAgM5H6E8Ie9Wjd5KeOw8XkZxyFVGlFgS/y1UyxmEfP
         LCFHMO+QiJueRCqFIOy21i4kI/AfkOIhbjHYf+J1vhrf86iz1ArAfBBpW4suEEpycb+u
         Rs3jrKGBfewqWEKT17zo89j2yv528k6sGiVFljUgp2X4CmY4uRQinfJNt7XaTF1anvu+
         KqhQ==
X-Gm-Message-State: AOJu0YwGIaoCpoH0DkLP6FXW4XaQEY5xrXhdfTW3ViTrBOVBlfmloEXV
	UE4hp381wz5PJV1LxTuVg4HfmLilQbj1kpJrNv19xjKYPxsH3aeV4msGZYniRQ==
X-Google-Smtp-Source: AGHT+IG0WojltBds3ScEBQLfdRTNLHLC46Dj8NnJDjrDAx0AB2VlvqF+Mzsup9QlGzy+HXif7JahEA==
X-Received: by 2002:a05:6a20:8e10:b0:19a:57d9:526b with SMTP id y16-20020a056a208e1000b0019a57d9526bmr864945pzj.47.1706097158042;
        Wed, 24 Jan 2024 03:52:38 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id fm27-20020a056a002f9b00b006d9af7f09easm13479565pfb.29.2024.01.24.03.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 03:52:37 -0800 (PST)
Message-ID: <6e12e0c3-3e7a-44cc-8fc1-0e85fa55b3f5@mojatatu.com>
Date: Wed, 24 Jan 2024 08:52:33 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Suggestions for TC Rust Projects
To: Trevor Gross <tmgross@umich.edu>, Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
References: <CALNs47v8x8RsV=EOKQnsL3RFycbY9asrq9bBV5z-sLjYYy+AVw@mail.gmail.com>
 <CAM0EoM=1C2xWi1HHoD9ihHD_c6AfQLFKYt4_Y=rnu+YeGX7qMA@mail.gmail.com>
 <CALNs47sqEzW831Sjh7WzgaVrLQJmM9b0=8bhkWLrR3592GU4vg@mail.gmail.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <CALNs47sqEzW831Sjh7WzgaVrLQJmM9b0=8bhkWLrR3592GU4vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/01/2024 03:10, Trevor Gross wrote:
> On Tue, Jan 23, 2024 at 3:23 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>> [...]
>>
>> I think a good starting point would be tc actions. You can write a
>> simple hello world action.
>> Actions will put to test your approach for implementing netlink and
>> skbs which are widely used in the net stack for both control(by
>> netlink) and the runtime datapath. If you can jump that hoop it will
>> open a lot of doors for you into the network stack.
>> Here's a simple action:
>> https://elixir.bootlin.com/linux/v6.8-rc1/source/net/sched/act_simple.c
>> Actually that one may be hiding a lot of abstractions - but if you
>> look at it we can discuss what it is hiding.
> 
> That sounds great, getting an OOT equivalent should be a feasible
> first step. I will pass the information along.
> 
>> Note: We have written user space netlink code using rust and it was
>> fine but the kernel side is more complex.
> 
> Would that be the code at https://github.com/rust-netlink? 

Not really, we wrote a small low level netlink library for an internal tool.
What Jamal means is that dealing with netlink as it was intended in Rust 
is not a huge hassle[1]. When we were writing the tool we saw that all 
of the existing netlink libraries at the time were doing a serialization 
model, which was not acceptable to us. We wanted to build the message in 
place without any intermediate structs.

The challenging part for the kernel part will probably be the 
abstraction and the interfacing with all the C API that exists to 
validate the netlink attributes which is a must.

As for documentation `man 7 netlink` is pretty complete and the iproute2 
source code is usually a good test suite for responses.

[1]

Take a look at this snippet for instance:

```
#[derive(Default, NetlinkPolicy)]
pub struct P4TCActOpts {
     #[nlattr(nldefs::P4TC_ACT_OPT)]
     sel: nltypes::DynaSel,
}

#[derive(Default, NetlinkPolicy)]
pub struct TCAction {
     #[nlattr_str(nldefs::TCA_ACT_KIND)]
     kind: String,
     #[nlnest(nldefs::TCA_ACT_OPTIONS)]
     opt: P4TCActOpts,
}
```

The NetlinkPolicy trait handles all the boilerplate to construct the 
message in place and in our implementation it's method base:

```
let action = TCAction::default();
action.kind(msg, "foo"); // Adds the attribute `TCA_ACT_KIND` to the msg 
in place
```

It kind of resembles the netlink policies in the kernel, so perhaps the 
above could be a good starting point for the kernel abstraction.



