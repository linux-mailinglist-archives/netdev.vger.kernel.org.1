Return-Path: <netdev+bounces-135816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43B899F46A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7608C1C225B0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D561F6676;
	Tue, 15 Oct 2024 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4NNl5ME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B81E6311
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014761; cv=none; b=elB8LZs6AQvKbIlOY/o6DJE2LISAmZa9Ihcy6kcuwUuxr3u5JNfdiBfbUBtTuv9BPtWEzsITo0R+pXgj+HDUYUY+mthBsNJ4iqtVGYxz8+bg80+s8x88MgSyC7z2xj+BQtXZAS5y61fUu1xSkoGEIC/9GwQH7Qvw31OEuNdqjrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014761; c=relaxed/simple;
	bh=9CgV0bkzyfbyppR/T88Qa/zpogXsoKY69zLFb0cWhWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E+E5IEFbdsRTW/OWTZuaIX0XXiixX0jiXeHIHATs8ig6jHYg+CqUr1YTbCZMEq+VHKHIquq4yaDhbpvNlWfpt1bS8Y7zAChWWludDIsiyGxHMGRqa5ZhePsLOmN0okdzHeimMgqgVPdT1gFVwRfyyUI0YJIIhUMHAzRdoJZX8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4NNl5ME; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d461162b8so3765095f8f.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729014758; x=1729619558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3RHsgpousClFfORxknvI26zGBHRWHxYVIP8AnzrEW4=;
        b=e4NNl5MEYJf1EirkFgfqm+F5LLnlSxgcE/3WzB6UHeyIdIvlmXsHKrkQWDncwSNbiN
         fFH+NoSb/FfeM+FUPwsVyE6dG4Q2Ro5tgsfaTY6ei4X/f2Dq4ZsePfB48GUvB4Ve/0L3
         2V0wDNW+whZldcIoKC5p7Uq4TnuEGUY7BH7o0/yuRQEQssUv8AkrNMOun8PosE4zpIVe
         gHJKgzkgTKdxD2A5o65RY5Raz5SMnmEz0EgjshNxu2vBvRrYfCkLE7Av1EaoeUNLO0kz
         A1dWJ1VVS/d4ff901dGHqBtByki2Uu5hrTFmfpuQQ8BFyDdiBHgUALo8JCaLiWG1WeMQ
         S0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729014758; x=1729619558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3RHsgpousClFfORxknvI26zGBHRWHxYVIP8AnzrEW4=;
        b=CqjrRi+Or8LkhIQAsavz9igey/EZszeUivC0oc/HxTbsQtXxw9PzUhyOq+DlTlQaLM
         IfwlZDS3Uj8uxsr1Je23SuuOq8Nsox+L468Y/Vx0c3TnsKeDR8paEsdPtOm4AcMr7OG+
         9LDen3RnXqd6LHm04HKvbEcE58jTJuI/UqARdldORwouMOldLF0qv25XQrA4RpsGThT+
         uqsoYvBg0zw9Rx8hlKKdNgMTW13TcmkX5sBUki01GJ+wygYXlglAh6QSebrBt9tS0a38
         Fg++RlDuJK/QvguOXMZ6BmnXrOME8hvI+BlP4ny1Vij0V+Vbk0Ng5zIKP+A/v18zsKg/
         it1g==
X-Forwarded-Encrypted: i=1; AJvYcCVt3QbTB4E+HOkh+Mho/35AEKL4XonTgQIAYkf2Gh8hc1xSztMmdrEMdFi7bWjkm1tuj5hKDo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyrWnW6gQABe2wCcAUANVGEfG++PyZ96uJwe+p88PTFBs1tKSo
	sESVvz8kg+VIn4tn3252u6Q0Qv7eNal8es759kJ7Yn8wv/bE5aCp
X-Google-Smtp-Source: AGHT+IGPU1pm4iamqiLTxjGWYg9Pv0h1jSuaiRVsZuLWwe2fkbI2tw3zCkfy7B/Ba4tJkjx/pPhQsg==
X-Received: by 2002:a5d:530f:0:b0:374:af19:7992 with SMTP id ffacd0b85a97d-37d5fe95725mr7189495f8f.7.1729014757840;
        Tue, 15 Oct 2024 10:52:37 -0700 (PDT)
Received: from [10.0.0.4] ([37.169.106.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa90a33sm2130794f8f.54.2024.10.15.10.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 10:52:36 -0700 (PDT)
Message-ID: <414cad58-c070-4da3-8ec4-894cdf9b551c@gmail.com>
Date: Tue, 15 Oct 2024 19:52:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/44] DualPI2, Accurate ECN, TCP Prague patch
 series
To: "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>, "g.white@CableLabs.com" <g.white@CableLabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com"
 <vidhi_goel@apple.com>, edumazet@google.com
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
 <dc3db616-1f97-4599-8a77-7c9022b7133c@redhat.com>
 <AM6PR07MB4456BDCF0928403D0E598F9BB9452@AM6PR07MB4456.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <AM6PR07MB4456BDCF0928403D0E598F9BB9452@AM6PR07MB4456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/15/24 5:14 PM, Koen De Schepper (Nokia) wrote:
> We had several internal review rounds, that were specifically making sure it is in line with the processes/guidelines you are referring to.
>
> DualPI2 and TCP-Prague are new modules mostly in a separate file. ACC_ECN unfortunately involves quite some changes in different files with different functionalities and were split into manageable smaller incremental chunks according to the guidelines, ending up in 40 patches. Good thing is that they are small and should be easily processable. It could be split in these 3 features, but would still involve all the ACC_ECN as preferably one patch set. On top of that the 3 TCP-Prague patches rely on the 40 ACC_ECN, so preferably we keep them together too...
>
> The 3 functions are used and tested in many kernels. Initial development started from 3.16 to 4.x, 5.x and recently also in the 6.x kernels. So, the code should be pretty mature (at least from a functionality and stability point of view).


We want bisection to be able to work all the time. This is a must.

That means that you should be able to split a series in arbitrary chunks.

If you take the first 15 patches, and end up with a kernel that breaks, 
then something is wrong.

Make sure to CC edumazet@google.com next time.

Thank you.



> Koen.
>
> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>
> Sent: Tuesday, October 15, 2024 12:51 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; netdev@vger.kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@CableLabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
> Subject: Re: [PATCH net-next 00/44] DualPI2, Accurate ECN, TCP Prague patch series
>
>
> CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
>
>
>
> On 10/15/24 12:28, chia-yu.chang@nokia-bell-labs.com wrote:
>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>
>> Hello,
>>
>> Please find the enclosed patch series covering the L4S (Low Latency,
>> Low Loss, and Scalable Throughput) as outlined in IETF RFC9330:
>> https://datatracker.ietf.org/doc/html/rfc9330
>>
>> * 1 patch for DualPI2 (cf. IETF RFC9332
>>     https://datatracker.ietf.org/doc/html/rfc9332)
>> * 40 pataches for Accurate ECN (It implements the AccECN protocol
>>     in terms of negotiation, feedback, and compliance requirements:
>>
>> https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28)
>> * 3 patches for TCP Prague (It implements the performance and safety
>>     requirements listed in Appendix A of IETF RFC9331:
>>     https://datatracker.ietf.org/doc/html/rfc9331)
>>
>> Best regagrds,
>> Chia-Yu
> I haven't looked into the series yet, and I doubt I'll be able to do that anytime soon, but you must have a good read of the netdev process before any other action, specifically:
>
> https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/process/maintainer-netdev.rst#L351
>
> and
>
> https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/process/maintainer-netdev.rst#L15
>
> Just to be clear: splitting the series into 3 and posting all of them together will not be good either.
>
> Thanks,
>
> Paolo
>
>

