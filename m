Return-Path: <netdev+bounces-177827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB24BA71ECF
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 20:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DFC16DF13
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9632219E8F;
	Wed, 26 Mar 2025 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Q0yqjLNU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE8191F8C
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016084; cv=none; b=qDDGTVW87tt3IpzVUwhOjQqmoz98MQhiqgEMJ1izd0KZZl3e9Ch5AaquUOo5T8Ay0LO4GTd5OarM6gcX87EKsHzYR6U0AsslF+65MH1Ujl2RyZ9Z6hKTF4k/aJsNN/+xoMe3z6jtLm0nT1tqsnFnQ7yOvlJLpadpNJRBpfgKjQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016084; c=relaxed/simple;
	bh=7RVgYIM4oj+y9+f7/CAA0dyO6P1l7KBbToFOhY1GXn4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hf0p5QOs5Wdw3v9R4914zokeLv55YqndHi4x1yK+1kZpo3XlH2cUAre5kEx0ex3JyJg5O97tBua+Ts6OC3aoegSXQkknt+aUfx8ZVTt8U203T4qDL+WX1kd/aUktQGyoPWWHDBcT9XWUvhnQP5cvzKSzRDIWx2kj/wnfgj835RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Q0yqjLNU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso6279195ad.2
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743016083; x=1743620883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nx/hPE0jDwRnFgP5uI3XcutfB0Ey6NWCcZfWskoFM5s=;
        b=Q0yqjLNU3sEuqmwhqaU40+1QwJro9YmhtUIiS+5gamzku/KiQkFVYRstW8UHMkG/3f
         bd46mzuIrXK4Nh36pWmvrBl2uWaRQRfKTpbts5BEkF9QhTHUnQaQh6QB2Vlw/EDJHJzc
         nJEeWVJHyL3N61M/134oFr+zcnc/T+uEAEUewpspTUnf7iRH8hmvI3FffJirW84lrIUr
         MEyKbTDoo+w3LwPMuWzz13gDlN+ypNLcuZvuq+ouwj2Faw8aQ619+5GWpSW/0AUSlOyi
         tQY0EmEklsEo9qCfanm2OhlXOwAWUGlTLbjjuvCiLS3jKRe2H5scEVvCEU9LxEOG9kLa
         sTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743016083; x=1743620883;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nx/hPE0jDwRnFgP5uI3XcutfB0Ey6NWCcZfWskoFM5s=;
        b=e+fWlGP6HrA3opezAdVJufRv1A/ESW2Vn+ox/fKG+McFE91CvA/SC8eP84T7t8cNpf
         SoRP1o3LMSssXud+4SUWxZTSSc+KP2qtV8KYhfq0JR2KdWT7777rPHCRRTx3wdvU/nB8
         Iv+1vrkNEJYndJ0BDu8IEYjb+rVkThUnFY++Qw/M6t+f2MUCuDsSAxZKCt8mApzId09s
         qu2M3va1kp7hjzLnsawKHU0B4aSLUS2/YBgrCVUAdp7YEMAK8CwjkFVKW6rIgSvjgt72
         OzqM2RiVBG2s8mi+iJexT0Br37zwK+tibZNVmktelFPdJDQArqCFZrLxWGwKt0sR6QVW
         vNWw==
X-Forwarded-Encrypted: i=1; AJvYcCVd/d4tkfgMGWz40scqGLRl4VMzzp9laPkM2b/tUXeGifc9vb+sMIPbRp3jPB/GdGUkVl1swG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVAt4H4y6ttAYlBaZTFbg0pNpQ8qPek5Ctd3Tr2XmtG4uLokF
	2jCrW+R5BZikjEIaW0Lr4Lj5UYWjep71SlQfvrB9AnWvafnByjPKbArlPzKyQmRv+uIegf0+cxw
	=
X-Gm-Gg: ASbGncu56JqOZLR1r3NNg+ubo0IWm6LCJW4iTstDNhbWbI9J+iVQ4qDzfn1WdhoB5Zb
	JpUDybOj2YUD75GrvjmT9ByAsPCobU9q8RvFdfUfccOh5YKFyUUR9FF/eWgXUD7PeNwirtGqLvt
	fxOX2xxoXEZyvpvcoh/Bw5i47Fx7nSSKoAVQiuQn4HsHt9teXvCsd3Fo9g3Cpeso8UFDLJyZguZ
	dOUKtjYem8crTsvMytwzcKopVFlu0jqoJxbcEBtFvpBTIGZaelcPhQosLcEj1Gb63ETIh75b1BO
	y/TOLBDGNaLbiwZVb0zhbUVIkOTYXad5EGUq4k1WLAiTavDrodbJ+Q==
X-Google-Smtp-Source: AGHT+IEz0CLvFdTg/2IAsAJVcnbXhjPY3FIdgipM/EkEKYtdD6VzPL0YeolZTGeUP/+/3IROIFR7ZA==
X-Received: by 2002:a17:903:3a8d:b0:21f:74ec:1ff0 with SMTP id d9443c01a7336-228049314eemr9545075ad.32.1743016082580;
        Wed, 26 Mar 2025 12:08:02 -0700 (PDT)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4581csm114428695ad.59.2025.03.26.12.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 12:08:02 -0700 (PDT)
Message-ID: <6c694107-5c99-4d3a-a741-eb1d798060ee@mojatatu.com>
Date: Wed, 26 Mar 2025 16:07:58 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tc-tests: Update tc police action tests for tc
 buffer size rounding fixes.
From: Pedro Tammela <pctammela@mojatatu.com>
To: Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Torben Nielsen <t8927095@gmail.com>
Cc: Jonathan Lennox <jonathan.lennox42@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Lennox <jonathan.lennox@8x8.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
References: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
 <20250304193813.3225343-1-jonathan.lennox@8x8.com>
 <952d6b81-6ca9-428c-8d43-1eb28dc04d59@redhat.com>
 <20250311104948.7481a995@kernel.org>
 <CAM0EoMnmWXRWWEwanzTOZ_dLBoeCr7UM4DYwFkDmLfS93ijM2g@mail.gmail.com>
 <20250326043906.2ab47b20@kernel.org>
 <d6231806-8666-4b07-982c-7061ca352b59@mojatatu.com>
Content-Language: en-US
In-Reply-To: <d6231806-8666-4b07-982c-7061ca352b59@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/03/2025 16:04, Pedro Tammela wrote:
> On 26/03/2025 08:39, Jakub Kicinski wrote:
>> On Tue, 11 Mar 2025 07:15:26 -0400 Jamal Hadi Salim wrote:
>>>> On Tue, 11 Mar 2025 10:16:14 +0100 Paolo Abeni wrote:
>>>>> AFAICS this fix will break the tests when running all version of
>>>>> iproute2 except the upcoming one. I think this is not good enough; you
>>>>> should detect the tc tool version and update expected output 
>>>>> accordingly.
>>>>>
>>>>> If that is not possible, I think it would be better to simply 
>>>>> revert the
>>>>> TC commit.
>>>>
>>>> Alternatively since it's a regex match, maybe we could accept both?
>>>>
>>>> -        "matchPattern": "action order [0-9]*:  police 0x1 rate 
>>>> 7Mbit burst 1024Kb mtu 2Kb action reclassify",
>>>> +        "matchPattern": "action order [0-9]*:  police 0x1 rate 
>>>> 7Mbit burst (1Mb|1024Kb) mtu 2Kb action reclassify",
>>>>
>>>> ? Not sure which option is most "correct" from TDC's perspective..
>>>
>>> It should work. Paolo's suggestion is also reasonable.
>>
>> Sorry for the ping but where are we with this? TDC has been "red" for
>> the last 3 weeks, would be really neat to get a clear run before we
>> ship the net-next tree to Linus :(
> 
> Jonathan's issue is solved.
> A new one popped in iproute-2:
> https://web.git.kernel.org/pub/scm/network/iproute2/iproute2.git/ 
> commit/?id=afbfd2f2b0a633d068990775f8e1b73b8ee83733

I pasted the wrong commit, it should be this one:
https://web.git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=667817b4c34944175deaf6ca9aa3afdf5b668fc5

> 
> Changed the nat's "default" ip address from 0.0.0.0/32 to 0.0.0.0/0,
> which makes tdc fail :)
> 
> https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/50205/1- 
> tdc-sh/stdout#L2213
> 

