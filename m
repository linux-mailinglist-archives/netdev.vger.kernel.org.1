Return-Path: <netdev+bounces-114209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA519416A2
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DDF1C23585
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FAE184547;
	Tue, 30 Jul 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7I8f+zs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3ED184536
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355327; cv=none; b=ehS48fJj0QdftssnpBeXENTLX+m+UuZXrYy7E+ZZJ2RwU128FFYpsuTsGJ+aFJEnbJuuYX1OHeH0QF3EYXw/niGfi5l/3WraLbdwprILHLHFQIN8eX/vdPxXooT6LmfphTbA+KSYceuhs2P6//6LDftXOJQs2tvqfTim7kQSgy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355327; c=relaxed/simple;
	bh=/eRkzIkzLgm9C+Wb+SDkdL2q9mcyunIMjzPLwcMJcMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gV0mek9ve5wxOlCER3QhWyIBExt1IhcYWWKPcDCfr9tw4DZwxs3lrDNrJ5CMp8poUsO4wWjk0qZpgMtboV1ZW1RqSobdZjs/v7XfI9HnoWfZemNNMSOntQYDFHfxndLNS8OL2mjOrU1f0d6Q6HkrHYh4pktYK1gSvw6hmCuuTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7I8f+zs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722355324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBMiMODYMCrB9wMhYAuFW7OLEsxsBDqxP2+XWERRDW8=;
	b=Z7I8f+zs/j7JCLpgvfOxTguuxAf6zp8wQHvRIN0eGsOrV4LewYmWYsZmZ4qwaJgexitmD1
	2lfAjc1eEcd6Y1c0urFVKKmwmE9fyWdOH1OojlF8XY66g41rlVxX+hpzW2WQ6Wtb5cEFT9
	+m6JnrXF2UeS0ZCOQPQbnsRkJi5fDb4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-XAfAdievP1mIOViLv9-jgg-1; Tue, 30 Jul 2024 12:02:01 -0400
X-MC-Unique: XAfAdievP1mIOViLv9-jgg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42818ae1a68so5388195e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722355320; x=1722960120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBMiMODYMCrB9wMhYAuFW7OLEsxsBDqxP2+XWERRDW8=;
        b=FNRmMW7WdluvY+1JiXOjQUX2CLwn3GUTDhCIeLcAp1yvl7h8Om2Ig/W51e2JfBFuw/
         m7tQBGWF4mlrtO8x30lBLUcPqqRwOzRIKm7UsGVuTLAxpg9r1fFmgZe5KiCzevcdesKx
         0tb06BY+1twmITVBPlu1XpFOqWuNqTWwa+DPyn8ouiflUakZdjigW1GrAPj0znj6TgzC
         cDL8ejsrosrLruhvnMi0FVkvCgP/nuOfA6sHmrpKL2o0daT5iC9lMRVZCOMlJmi6puvy
         zQ9aLOlDJXCW35qnWBKMBMwEVDfFd4P9K2SfGpyljR53m+kQECYQ+Kde/LRoY+Ur4gV4
         MD7g==
X-Gm-Message-State: AOJu0YwkNcMMOniok+AMdjIXveOXEBpmIgUxFPw4tumP+1mjX/0W4vYO
	kDa87X2gQdKFf0Nn82/rHYcI8CVAmOJq50uzJQwQU8+v8If5zlJXVB4IctnSQWfj9cEH1rFrJKI
	g54j1/yrZ7zQdhO1I4M2oiMkpgR13MZbuy3882tmagvrL/qTy0daqCg==
X-Received: by 2002:a05:6000:1849:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-36b34d183b9mr7988972f8f.2.1722355320404;
        Tue, 30 Jul 2024 09:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3vAVKdxjjZSQc4wmqII3zWximymOuFshGAHB4zbcZ59U5GOapsVrCP4cU4PvgXOGuTYKtuw==
X-Received: by 2002:a05:6000:1849:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-36b34d183b9mr7988959f8f.2.1722355319942;
        Tue, 30 Jul 2024 09:01:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410::f71? ([2a0d:3344:1712:4410::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282716063asm6627665e9.44.2024.07.30.09.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 09:01:59 -0700 (PDT)
Message-ID: <3fbe534d-b816-4d0b-b1c4-de63a02aba0f@redhat.com>
Date: Tue, 30 Jul 2024 18:01:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/11] net: introduce TX shaping H/W offload API
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1721851988.git.pabeni@redhat.com>
 <Zqc3Gx8f1pwBOBKp@nanopsycho.orion>
 <5fb64fb5-df6d-409f-b6c6-7930678df9d2@redhat.com>
 <ZqextLo-OUq_XLzw@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZqextLo-OUq_XLzw@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/29/24 17:13, Jiri Pirko wrote:
> Mon, Jul 29, 2024 at 04:42:19PM CEST, pabeni@redhat.com wrote:
>> The general idea is, with time, to leverage this API to replace others H/W
>> shaping related in-kernel interfaces.
>>
>> At least ndo_set_tx_maxrate() should be quite straight-forward, after that
>> the relevant device drivers have implemented (very limited) support for this
>> API.
> 
> Could you try to draft at least one example per each user? I mean, this
> is likely to be the tricky part of this work, would be great to make
> that click from very beginning.

I think we need to clarify that we are not going to replace all the 
existing in-kernel interfaces that somewhat configure shapers on the 
network devices.

Trying to achieve the above would be a (not so) nice way to block this 
effort forever.

ndo_set_tx_maxrate() is IMHO a good, feasible example. Others could be 
ieee_setmaxrate() or ndo_set_vf_rate() - ignoring the “obsoleted” argument.

>> The latter will need some effort from the drivers' owners.
> 
> Let me know what you need exactly. Will try to do my best to help.

Something like what is implemented in this series for the iavf driver 
would suffice.

Thanks,

Paolo


