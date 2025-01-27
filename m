Return-Path: <netdev+bounces-161175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C9A1DC06
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290163A67D9
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 18:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F55318D621;
	Mon, 27 Jan 2025 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkYixlld"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760791F60A
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002513; cv=none; b=P0iCZzlenMI0rUic9y0mSRhsOS5A0rj9L99qK5RUmoKKJu34lZDazVaZfXKZoQUfD2h4Q8+hAl/8iYXVdOSU7nCl8Q+bgZiJhXUMofcSiKkerktrkB2UM0hanecrwyVG2V0F2BnfSWxXcmFWVZ7LextLqlJarIilz1elSNxNJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002513; c=relaxed/simple;
	bh=eshubJdtXnqkXbqQ0EU4HNnJHatunvU6xtO2Db7n6us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=farXOpgW4xfuDuDRn9cw3z3oFPuiU7vkx2sD+OI13gTXxOhuVkbrE3RUY5fAJqhVtGchazbYH8xMfblCguQSwZYoxxl2rvHq8MfCLwNL3pthzRlrPTFw6DPm0fQ1QWWAVlvkE6eZahayBzU02idcwuilhaBddq6WYymc7r/t9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkYixlld; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738002510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8C6JSbcwzxm9tbeD7KTk1cEwkb6TTH6wnvvqHRdC5lc=;
	b=SkYixlldg0RE9OAtSDZVsbes4NbTfWPd5zkdjxnLyQnaJZfoto+Axc+U0CxUvwY9RZjwvm
	JztV7Bw+nD2AzroTnca0+kZ4wfEo0OxZqs8rcN6q851cmQKwU0fzO5FDqdnqqkRgi0GBdA
	BwHurDb4H09H/rG4UIIfk+NVz+UsLtg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-UNBGjTYrNMKkabUtZgRKnQ-1; Mon, 27 Jan 2025 13:28:28 -0500
X-MC-Unique: UNBGjTYrNMKkabUtZgRKnQ-1
X-Mimecast-MFC-AGG-ID: UNBGjTYrNMKkabUtZgRKnQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361efc9dc6so26020205e9.3
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 10:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738002507; x=1738607307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8C6JSbcwzxm9tbeD7KTk1cEwkb6TTH6wnvvqHRdC5lc=;
        b=W/2R/2OuJwApLJ4rSGzIuYGHZ++FXG/E4ZtCq02sQEum1gLk/gP/LsC/XdoI8ca7zY
         +YAm+gxwqxyMyrpNhBAxqxtpK1OkIMwD4EvofD86T5fU3ZMq4tpag+UPersJMLYbz1L2
         2CZdfvfrtcry7TIqLwHIEyoBfdXzPBvSFL9d0qVOcRS6j8L051Z/ForIE6fUVIkkmRla
         jGUP3Hb0ZL3wo8c1NA9QNzhyZRXn83z1PhDzPINK6n3LrgHtM6JZ1edN9FSb2JCOiSiX
         P/Rl00CETJG14ViCYdv4IwK5w7mNvm5RYyO/EP1gO6OFOyifLbAv8Q14VBop/sDys9yr
         8u4w==
X-Gm-Message-State: AOJu0Yyqt11w0f0QosjZKxl/JuIUu68gz/vxID+SsyPfj2pi6+xAqtel
	Tc66fWw+y8gNB4VTagACAPGaAgA/erzzks/iCuWs6VUv/mvaQBu3dD7NnZmHIwTP/pB0seHsoQH
	kVGBI2xwF8wwMWAjf8+lbmypKVc92vhbusvA6efbSejADtWclUGdJkg==
X-Gm-Gg: ASbGncu9VSVBjaKMpQ9DQXhfIozJRncPyoRNF5BsukMKYGDPhXa41FzwzNQmr4Idbl5
	KLqOIGr0Q8q09xs/dsCLECv5DfQDMD9h889k9nJLLguHIJW8mtct49sRh/qeZXpekEKJVJ6AF/n
	eW4uFsGEyRJEOISBsaLTOuPjR7i6tFE/pVgpdUf1XrBTIkfjHCoE9ucyOLPoWiXlSAohcJkmdvx
	UbGFf0inUd6bClVKUkDLtvdn7dUrLIZHJLve+UWONeHJjq1KebzlnrWYlOP1jXd1zgFRCyeFM7o
	umyt2hTXzAoa6cHfgU5nLacSBi37VdH+BD8=
X-Received: by 2002:a05:600c:4710:b0:434:a59c:43c6 with SMTP id 5b1f17b1804b1-43891451388mr317169725e9.26.1738002507642;
        Mon, 27 Jan 2025 10:28:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtU33uhPYbjVbbK62fuwuEp0ZUWVToMkkN8abX5hEGvaZV3xw9DWh5wDuaQ1MdjeYuuFCAzg==
X-Received: by 2002:a05:600c:4710:b0:434:a59c:43c6 with SMTP id 5b1f17b1804b1-43891451388mr317169515e9.26.1738002507224;
        Mon, 27 Jan 2025 10:28:27 -0800 (PST)
Received: from [192.168.88.253] (146-241-90-109.dyn.eolo.it. [146.241.90.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd501f1esm139822185e9.12.2025.01.27.10.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 10:28:26 -0800 (PST)
Message-ID: <595520fc-d456-4e62-9c39-947ccfb86d0d@redhat.com>
Date: Mon, 27 Jan 2025 19:28:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 04/12] net: homa: create homa_pool.h and
 homa_pool.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-5-ouster@cs.stanford.edu>
 <a39c8c5c-4e39-42e6-8d8a-7bfdc6ace688@redhat.com>
 <CAGXJAmw95dDUxUFNa7UjV3XRd66vQRByAP5T_zra6KWdavr2Pg@mail.gmail.com>
 <4e43078f-a41e-4953-9ee9-de579bd92914@redhat.com>
 <CAGXJAmxPzrnve-LKKhVNnHCpTeYV=MkuBu0qaAu_YmQP5CSXhg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmxPzrnve-LKKhVNnHCpTeYV=MkuBu0qaAu_YmQP5CSXhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/27/25 6:34 PM, John Ousterhout wrote:
> On Mon, Jan 27, 2025 at 1:41 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> raw_* variants, alike __* ones, fall under the 'use at your own risk'
>> category.
>>
>> In this specific case raw_smp_processor_id() is supposed to be used if
>> you don't care the process being move on other cores while using the
>> 'id' value.
>>
>> Using raw_smp_processor_id() and building with the CONFIG_DEBUG_PREEMPT
>> knob, the generated code will miss run-time check for preemption being
>> actually disabled at invocation time. Such check will be added while
>> using smp_processor_id(), with no performance cost for non debug build.
> 
> I'm pretty confident that the raw variant is safe. However, are you
> saying that there is no performance advantage of the raw version in
> production builds? 

Yes.

> If so, then I might as well switch to the non-raw version.

Please do. In fact using the raw variant when not needed will bring only
shortcoming.

/P


