Return-Path: <netdev+bounces-143314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB909C1F95
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA17B21031
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C21374F1;
	Fri,  8 Nov 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJwOXkZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414221C36
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077222; cv=none; b=VKccCbqXSWZAByvtzPNgs2SeC5JbRgaS3seoNNfgfPQNiQKzsk3w6+u09URrrHNg3eTjz/ysH67/ehvndZoOl0en3VN52TdFFvqenY9v3tfmBswh4Q8RnxmqlLoUHf8H9YyhKioKT+9yRSlKYfafjFHhgmHQAp86SqFNIUdzz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077222; c=relaxed/simple;
	bh=Kp5auo1LcPVnZM2m3WQbp03sx1GGfYTR0E3kUSziz5U=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A5LMk3mRHcu2Yau0iskDQvtNxXPEHWBEbfBmPFhc/b+0CcLLzCLwAxVTphACCZELlDumsTICl1TiTzOAu9rpPbqsLUykvoo0FwMEBtR7zo1fcfkAZmLvcOeBpFL6SXHMFXf8u3oDf91RgNUrLQ3b+PS2J488mTjFe6gRaqfpDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJwOXkZA; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99f646ff1bso319834466b.2
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 06:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731077219; x=1731682019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqte/BHbHjL6/RiK9M5s+noukLhYI4UnqVW5A9iFlFw=;
        b=VJwOXkZA6Mb9yi8c7dUmpgzwjQgYcTJ1iH/p0y1kA66irDjnpnpKK8m9Pb+/6Zq9zp
         WQdAmkzKLGYJBHVoYRD27RwgatQHsvGqwQWWG+WwrWi0UA62j2pbCKVdX+eYetjOxSJz
         CmZWwlrXQBayZ6w9JtEIQiOPv/wiMetaAgNO86hGQlflzx3IJOmq8nJXrOkJWA7pprXY
         twZkvt+lvdowFBwmklvN/wKLeqC6wDuKfdMj39XlBE/bpWjMfQXOEbr0o1ZO+OgTBpn+
         URLrpmtrzIJsECWBJkT6Qh3CjQRPtdo6FHUQZUc5FXK/D8fv7Z5WOvxgSUT3i7Ayr5J5
         WSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731077219; x=1731682019;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqte/BHbHjL6/RiK9M5s+noukLhYI4UnqVW5A9iFlFw=;
        b=GDrWB+1DEBA8VTqWtBm4k1+qwChpYebe2uYaw+y9QC9akO7jcQKKRUi7XG7HjMvxMD
         bDXoZDm/J/gtKOW5M9STp3M0hmsUq7Gher/eeX6HoWUjLrC7iVmWhmukMNPwqiLxIbwn
         oTtW1c4f56gDRbd3Vyrwx3svBHrtpmu8vXLb1jGqBQT+H/y7XZmLhX3krwtl7dO5OGnt
         dbVyD0Bif4PHvahKM8OTUBp0WIWuHF+qa8F+BnJrBGTXYptE/AZnkJdELHr0PUU17eDm
         45MtOMjoaKjIPgNkwDMwdO2z39pMo27Dx80ouQNCjm/i/AUmxRIcUrJC6VhZrz2NN/sB
         iPmA==
X-Forwarded-Encrypted: i=1; AJvYcCVYrPVUZpExO8mzr0m74YUJNgq9yW9E7ysduZWpwCFet9m4zbfHHwpLIV/4INR+y+9WhMRWg7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpcKg1/sGrAV6PcTzXQAKXqEyIsa47zL7VMecPYTEz1011RGTD
	1XubSxnYlFWa8YC27Bwbtl04em3v5yePo3laCYCFDrZa5S87b5W6ZCbDtiHT
X-Google-Smtp-Source: AGHT+IGrMgaTsczemZnvpF8Flfa3+rXdoQQlXEoCM0C2n39f36V6X2N0IlqjZ0xBeIFp63IJWNvbsA==
X-Received: by 2002:a17:906:6a12:b0:a9e:c696:8f78 with SMTP id a640c23a62f3a-a9ef001ea60mr308984566b.51.1731077219265;
        Fri, 08 Nov 2024 06:46:59 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a18843sm240459266b.36.2024.11.08.06.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 06:46:58 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <3be2edef-f3b0-4a02-b794-193e29047de2@orange.com>
Date: Fri, 8 Nov 2024 15:46:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Cong Wang <xiyou.wangcong@gmail.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: edumazet@google.com, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <20241107231123.298299-1-alexandre.ferrieux@orange.com>
 <Zy1qvkSHyEREU3Y1@pop-os.localdomain>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <Zy1qvkSHyEREU3Y1@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 02:34, Cong Wang wrote:
> On Fri, Nov 08, 2024 at 12:11:23AM +0100, Alexandre Ferrieux wrote:
>> To generate hnode handles (in gen_new_htid()), u32 uses IDR and
>> encodes the returned small integer into a structured 32-bit
>> word. Unfortunately, at disposal time, the needed decoding
>> is not done. As a result, idr_remove() fails, and the IDR
>> fills up. [...]
>> This patch adds the missing decoding logic for handles that
>> deserve it, along with a corresponding tdc test.
> 
> Good catch! I have a few comments below.
> [...]
> It seems you missed the idr_replace() case?
> 
>  - idr_replace(&ht->handle_idr, n, n->handle);
>  + idr_replace(&ht->handle_idr, n, handle2id(n->handle));

Unless I'm mistaken, there are two different kinds of IDR:
 - the "toplevel" IDR tp_c->handle_idr used to generate the IDs of hnodes
(hashtables)
 - the individual IDR ht->handle_idr holding IDs of knodes
As it turns out, hnodes use small integers in [1..0x7FF] in the IDR space, and
carry them along "encoded" (with id2handle() now), while knodes are directly
allocated in a higher range of the IDR space. As a consequence, it does not make
sense to encode/decode them with the hnode-oriented scheme.
It looks like idr_replace() is used on knodes, so it should not make sense to
add the decoding here.

Now, this is all based on reverse engineering, as I'm not aware of detailed
documentation (beyond code comments). Please correct me if I'm wrong.

>> +        "cmdUnderTest": "bash -c 'for i in {1..2048} ;do $TC filter delete dev $DEV1 pref 3;$TC filter add dev $DEV1 parent 10:0 protocol ip prio 3 u32 match ip src 0.0.0.3/32 action drop || exit 1;i=`expr $i + 1`;done'",
> 
> Any reason using this for loop instead of tdc_multibatch.py?

I have zero experience with tdc, so I'm just working on the README and
user-other oriented documentation, suggesting to extend the provided JSON test
specification. So quite possibly I missed some "other ways". However, I have
just posted a v6 of the patch that uses tc in batch mode (tc -b) and reduces the
execution time of this test from over 10 secs to a split second, and to me the
resulting line remains readable:

	for i in {1..2048} ;do echo filter delete dev $DEV1 pref 3;echo filter add dev
$DEV1 parent 10:0 protocol ip prio 3 u32 match ip src 0.0.0.3/32 action
drop;done | $TC -b -

Please tell me if you deem necessary to switch to another method and/or syntax.



