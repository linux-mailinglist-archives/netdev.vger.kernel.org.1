Return-Path: <netdev+bounces-87419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11C38A30FC
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 16:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31143B25636
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 14:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B933514388E;
	Fri, 12 Apr 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnDEhEkc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4C513FD91
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932892; cv=none; b=rjpII1ZJ7KZiNRVQS0J4lv61XkzrM6FZEgP9rFRb478ujcTfKCnmpJWwnwFSlUPHh3pY6WUuH3rcuN2koq+tJ4VIbwR3YI6tqX/Ah5ueNaGEGfRFXr5h88jSpI7QTAm5ttT0hFOHnJQRnzSsjXfgXoh534Wz6DUvLduMLv+loUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932892; c=relaxed/simple;
	bh=5uQ3IU3IoW/ayotWkvW3cHlwX6V5L3VW+Uta4EYn2Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tq6nWQU6zIo4HWO2LE82ygkmXdaYngL/uDuq/DiW34DnupZ1SacY+I2gFx8bAqDZ9VRP+aPjogm2r20Q02mJdNHnSSVnQbXbLy/8en8AyBAu/FrlRCpVixd5Fv+1riYpV0Y3HQTeHpB4PoZhNjMCJPLxC/w5BoZtklB+S2gc6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnDEhEkc; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c7f3f66d17so35828739f.0
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712932890; x=1713537690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4yP2az/Izv6W7vNibdZDYvZ+6udXrdee3P53NnkI+8=;
        b=jnDEhEkcTrHkack6kzMIK5TPCEobG+waa6r9hkkqihCLvC0PovEhpii5sNNCW6mBPz
         IHoRnP5/OCG+9sv31el3sjOH2rRej9mZ/bdJInJfXR1uzsYKumqYx+zVc03nY4p2LKVy
         R+GGgh9v9u9bvyhFzaaFlmtP62NH/U3X7wUpP5sx4HQ//JZB0pz+dQnrSnjuBAS7VKg1
         7iA7BcHKtrNcX0dDQCk3I7j5SLo3hyP1adk/NDw7PCo6xTfwsTLvfExc12v/jgxa1okZ
         SuTzJMDhUO7P3clXZpzE9ZX7HzqrOakNveaoKb6gjbSJeltmvY8I6lt3Apyea5O3qdcz
         iziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712932890; x=1713537690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4yP2az/Izv6W7vNibdZDYvZ+6udXrdee3P53NnkI+8=;
        b=aWIwtU2g1ACaDRMRTBQbghEjWpT+QojqU6vWj6np8JEXSOKX+TMo8d3u2mfZAx8zMO
         o/JwNVlU5cjlWa4yGEF+166YesRAcbjvPD7Gi1lwaVwFtHN8MIIAwyL1KguVXwUI8m6B
         TfhZLtYi182cDd/D41WdAMeTb/WDtmNTEUuKl8DNWe85z8670kWMyRPOHGhxZkUsAP1e
         56LqNi1HPMkox/h/05zitXT+IzGV/UEbMIyFTxeCBqnRHbc5DJb1Pl+uRfEH7Ln1uHyj
         YeVdQ/3l1VFUeAN9G2BH1+LAEWoUgl6hTI5yGBtWcd5zlcQQGtWzhnUBCHU0z42HFUXW
         VF6w==
X-Gm-Message-State: AOJu0YwFExcGmciYlbzHQOJ60EMZD9fSiiuXKwmyXqFMDTwbr2nuE7UF
	07mtWjUNY0FPdj/3pkqXeABz7nLovD7+ZuYCS7OvQYQAzFqArCg2OmfFJQ==
X-Google-Smtp-Source: AGHT+IH0Jb5A1/dimwaKmZtH/zeM5UPp/VeC2KXvcbknrfqi8lZb/TC3HhuPjawq2RpzvLJuu8fNxA==
X-Received: by 2002:a05:6602:3982:b0:7d5:e4a5:c20a with SMTP id bw2-20020a056602398200b007d5e4a5c20amr3860869iob.12.1712932890573;
        Fri, 12 Apr 2024 07:41:30 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:dc50:94e9:9666:b9f9? ([2601:282:1e82:2350:dc50:94e9:9666:b9f9])
        by smtp.googlemail.com with ESMTPSA id fh36-20020a05663862a400b00482e3e46478sm144485jab.129.2024.04.12.07.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 07:41:29 -0700 (PDT)
Message-ID: <8e6ede0f-2505-4c29-94da-c96e97bad78e@gmail.com>
Date: Fri, 12 Apr 2024 08:41:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/2] f_flower: implement pfcp opts
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <20240410101440.9885-1-wojciech.drewek@intel.com>
 <20240410101440.9885-3-wojciech.drewek@intel.com>
 <20240410085319.2cc6a94a@hermes.local>
 <94297026-c760-450c-aaee-ad0034c1431d@intel.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <94297026-c760-450c-aaee-ad0034c1431d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 5:32 AM, Wojciech Drewek wrote:
> 
> 
> On 10.04.2024 17:53, Stephen Hemminger wrote:
>> On Wed, 10 Apr 2024 12:14:40 +0200
>> Wojciech Drewek <wojciech.drewek@intel.com> wrote:
>>
>>> +pfcp_opts
>>> +.I OPTIONS
>>> +doesn't support multiple options, and it consists of a key followed by a slash
>>> +and corresponding mask. If the mask is missing, \fBtc\fR assumes a full-length
>>> +match. The option can be described in the form TYPE:SEID/TYPE_MASK:SEID_MASK
>>> +where TYPE is represented as a 8bit number, SEID is represented by 64bit, both
>>> +of them are in hex.
>>
>> Best practices in English writing style is to make all clauses have similar
>> starting phrase.
> 
> pfcp_opts
> .I OPTIONS
> doesn't support multiple options. It consists of a key followed by a slash
> and corresponding mask. If the mask is missing, \fBtc\fR assumes a full-length
> match. The option can be described in the form TYPE:SEID/TYPE_MASK:SEID_MASK
> where TYPE is represented as a 8bit number, SEID is represented by 64bit. Both
> TYPE and SEID are provided in hex.

expand the contraction (doen't -> does not); otherwise I am fine with it

