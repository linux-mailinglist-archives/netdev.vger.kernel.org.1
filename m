Return-Path: <netdev+bounces-145346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 821C69CF234
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BA71F235BC
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BDF1D515A;
	Fri, 15 Nov 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bhu/QvTZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8988762E0
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689718; cv=none; b=joLF2HD/nAAdWfmqz8lqopkSkOzik8vlBoCb+yzpLlmvUSwcd9/1Sgr2uQahrRTRLgvDbHRt3FJswZ39ALcwgHXg9Q3rUZESDHwp04mBOaQOMm4/oEA+fcfJ0Viv4IlWVo/AOFgv3/g3pG2DVEoJDVIRyq6deo1tF/0yklrvPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689718; c=relaxed/simple;
	bh=IgLzXavQdjK/5aH95pPM9ugA1OqsX9bgCpUzJSrNlW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiIEE9FQHgeNEFDLRXAcpWu+BjjaGITDtt5PgsBUZYnqFsTpggCaDUmowv8Wy1c2WLMLcJSycgRVMedkK2oZ7OEkYjzpNYMSw/440M7dedGWkYacszY/9RGEJYyJsl4SRuMKZZ18avkr18IOk9L2HgFY1FNDCriZvzciEZo0rjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bhu/QvTZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731689715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UndQQvaz2BWPfe663alob5z6FFAUciGi+iLOvRtoSU=;
	b=Bhu/QvTZvd7HE012OjbsSIf1Oin/rPl4Ow1ih37ALYkCza0WMf3L/NFbVI6HCx+AMYGOXX
	lgZWbt5pouiuBZMyYySMD3lWu5Szf1P7yH4q+FI2NXI7+AkbgreLhQ37xLTpKQYZ57r0Ej
	iE9EdwOy2L6YRZWVV/pTNPhHdIDmZ50=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-7nHFPmUlM-m4lbIcVsJf7g-1; Fri, 15 Nov 2024 11:55:14 -0500
X-MC-Unique: 7nHFPmUlM-m4lbIcVsJf7g-1
X-Mimecast-MFC-AGG-ID: 7nHFPmUlM-m4lbIcVsJf7g
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d5ca192b8so1244746f8f.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731689713; x=1732294513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UndQQvaz2BWPfe663alob5z6FFAUciGi+iLOvRtoSU=;
        b=n7w9pQF8higxQOMv1w5JgCL9jfAIOGQlgCQgvu0PYeKyrOkYGCYGiskiy4ok0u1WMZ
         5gUuw+Vlo/NwnLn+PUURHt5OdhArqKkBgmV0fWd5oZ7m/6EMXMxCnieDHSgl4In1a/q3
         zreOVnwriTtbSCWBunUSfnLweO9VSPwllpyGwkSInhv7zCm3Yb3fzdEOWd3d0D2XIJ1h
         Q0b4AZl2sI5qklQzLkDkAqwqDr620nxJ9W9XYc9BJqbw/q7eUkus6XRp5pmeteSXAF8X
         7TFqxhYEVMtW75AMsI8ZRedqodnB7SWUKKjt6xIHtx3hEzmH8SrFdChcRF6vF18k8WL9
         KiEw==
X-Forwarded-Encrypted: i=1; AJvYcCWzVRLPcncEmHzrvf4VDxuzHqEYzOKfuqZNVwkMElSBYmkRKbGjkhH3JvWuHA5o6trpZBNJ538=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKMbRCyOcm4Tuwvbp0j/aq095URedl8gGS5bG6eJ583efMvvD
	0uwBUxGC2Be8LlciS9NO6S/6/tBvcYnGXuFOiIXHMLwVjk/e+5QNZNVvoc9R8rBRQgSO6dK7a2H
	WTY2vq+pVopY4gxEwOuLWO5sWKYMmO/DRgUx0u/ogfUF7U0DbboyNTA==
X-Received: by 2002:a05:6000:1f89:b0:37d:3b31:7a9d with SMTP id ffacd0b85a97d-38214064614mr7116022f8f.23.1731689713227;
        Fri, 15 Nov 2024 08:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4cNRgKrO5Uuppx4robye6yBpFW+Vh1bqljZ/n4EB4OIo5T5gjB4C5v1Z4j8I2UQXdHPmLqQ==
X-Received: by 2002:a05:6000:1f89:b0:37d:3b31:7a9d with SMTP id ffacd0b85a97d-38214064614mr7115996f8f.23.1731689712837;
        Fri, 15 Nov 2024 08:55:12 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0aea8sm58446295e9.31.2024.11.15.08.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 08:55:12 -0800 (PST)
Message-ID: <9837c682-72a0-428e-81ab-b42f201b3c71@redhat.com>
Date: Fri, 15 Nov 2024 17:55:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
To: Stefan Wiehler <stefan.wiehler@nokia.com>,
 Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
 <20241113191023.401fad6b@kernel.org>
 <20241114-ancient-piquant-ibex-28a70b@leitao>
 <20241114070308.79021413@kernel.org>
 <20241115-frisky-mahogany-mouflon-19fc5b@leitao>
 <20241115080031.6e6e15ff@kernel.org>
 <9cdf4969-8422-4cda-b1d0-35a57a1fe233@nokia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <9cdf4969-8422-4cda-b1d0-35a57a1fe233@nokia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/24 17:07, Stefan Wiehler wrote:
>> On Fri, 15 Nov 2024 01:16:27 -0800 Breno Leitao wrote:
>>> This one seems to be discussed in the following thread already.
>>>
>>> https://lore.kernel.org/all/20241017174109.85717-1-stefan.wiehler@nokia.com/
>>
>> That's why it rung a bell..
>> Stefan, are you planning to continue with the series?
> 
> Yes, sorry for the delay, went on vacation and was busy with other tasks, but
> next week I plan to continue (i.e. refactor using refcount_t).

I forgot about that series and spent a little time investigating the
scenario.

I think we don't need a refcount: the tables are freed only at netns
cleanup time, so the netns refcount is enough to guarantee that the
tables are not deleted when escaping the RCU section.

Some debug assertions could help clarify, document and make the schema
more robust to later change.

Side note, I think we need to drop the RCU lock moved by:

https://lore.kernel.org/all/20241017174109.85717-2-stefan.wiehler@nokia.com/

as the seqfile core can call blocking functions - alloc(GFP_KERNEL) -
between ->start() and ->stop().

The issue is pre-existent to that patch, and even to the patch
introducing the original RCU() - the old read_lock() created an illegal
atomic scope - but I think we should address it while touching this code.

I have some patches implementing the above but I have hard times testing
vs net/forwarding, as the forwarding ST setup is eluding me - with
mausezahn internal errors.

@Jakub: do you have by chance any cheap tip handy about the forwarding
self-tests setup?

Thanks,

Paolo


