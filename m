Return-Path: <netdev+bounces-243251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F33C9C458
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67FF3A9FB6
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F6A296BDF;
	Tue,  2 Dec 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AalfpIxh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4726E710
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693746; cv=none; b=BxStbrllAP/BrIKg0XE+L1irXaW1NgNzdWyfTrcDbawrFVqh0XMeem0jFazG/lluhC1sGcc+EI3SbnqSnIMv/bYXS+5La5b3egR4BfBXOtkXDvI0iCjvmkftHqPxOnKEj8o+AMqivr2VDqOwpXOYfc+cQCmXJyqJVHMdt7Uyv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693746; c=relaxed/simple;
	bh=vpSelNLgVwY2+CQEqUbmgw8caQDlx9QMPGHMhMWW0NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g0hycQ+go1/RGS8hPGoUSAlvcWCsHejz6ErpXzL0JsB9w0nRNXpyYy5wDesfy2/UkE7tCAbNuMjvIDlrO6oDKsV7tqkheCvpDu+FEDApQC77CkHiesqCyHgqtlOFLjP7e5tmNkdUYzq/supBgMW62mRqDn7iJYV9N0XiTzcdY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AalfpIxh; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-787e16f17fbso2958897b3.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 08:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764693744; x=1765298544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byqbrpnY9aNEjHKOamSViX4rjqC5ERNtHgY9HNzT2sA=;
        b=AalfpIxhE+hHGXJPAvkHTxyi5R9elJGfIRA39IyRlkKOk9cKozyJY378crPk0/Ir69
         pt1Cp2hzfWDa8m+gbEzywotNJ4grdRPrIOzNYyG2Ah+FOMVJ/7GjpByriO5IDJlG0N+C
         JHF8neYsVNvxFcY/2CobIAw611mH4TBZfuJIPoKRfKBafrPLMWfm94LNLkMdwwivkYtm
         ABqvBGNlEgKiudJN4ZuImdc8w5YcQ8HM4TTmvbuSS7ni2bcMHG6+onnRQFENAJVmbyRZ
         iL/Uy3cbQvqgDUWnQPOKHUXrgrazlF1Z0rpV9NZUQZ2Grx/Kc554/Oo8VI42H+BNLjRG
         mb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764693744; x=1765298544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byqbrpnY9aNEjHKOamSViX4rjqC5ERNtHgY9HNzT2sA=;
        b=X8aH8JEoJ3mPL3qe3V4idZeg9I7E+gk/6eAr7OgfO7+ZWWKNr1l00bZb505zke3r1p
         tXI+NB2ElDCEOBVJpLJW+gey9Tb/X86fOwJLMaBnM7RzP3cIBM+fbq27zDUZGkMaLvHY
         WL9L1sKen3ujf12C/C8YV9HN6UF6GK8C5oJAHVrWwH8lLbqHYo7uUsjPLkSi1dU6C2AJ
         kwya5/2ApLpHejUXXDt9T1E78WEaNmi3IjjDqGwJz5gXgP2/eeD7t3LKP5YIQzo9FZGz
         0soExX3YDLgySW1FY8vnR2gPez6YSZx2/HQZofOJeYAmo5yF4/23fzMYL4NuL9m8x1j6
         Bu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2Jr6L3p2Hyrxrs/eaXER04S4SP6NUj78A2lr+hpo8jd3qEaqbXYqNa1ZOXankYcj4oBNZULg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTTF1Wk5DPAvrVhpkbSjkWACZ691Lpa/9Y6AppDKKWt36LTZN
	j94U9BBWONIO6ENPgyymZTlnWy/u8aAnSa+Q4H0AJ+jkbLdM7teEuDrE
X-Gm-Gg: ASbGncvsap+FB5Kt2ZTRrvtolE1PWVHWaMzGKpQQt79qGwlqD9o7hEDWAF1aq2LSgzW
	X3HIhzOUHFfCoXi1MQRNdUV+E8seVWj/HqeQXCnA3UtjPsm9zM9ynG19N5e8sg9NYJeT4LoXEuK
	xIVlfFV2V2oXliOwWaso1JomlCKp/1L8pX1KRw8okO7qE1Y5otDTqLa32plTppvqIB2GA+NcT3V
	NOo/EmfICKtab8NKSOnTqseambKN2wyOOPhLnPs1CWi/qXlZ05x2jCN5P5BOPAn1tlqkGBulAgg
	Oo5I1dsaQmt4eWwDZCWwiq83Uk7k3JMOc3hW59JpCw5qfNRPLBYJv/IgCvd4+sXLpdO16RcNiBX
	KeJ6shIdq0rIAVuGCtcAn/wTTFjzhu8ywbSLhuKMY7xCK4oT/TYSyyGWkBMnnPVcSHIlIhYyKdS
	69yFaCoB/4
X-Google-Smtp-Source: AGHT+IGJS318XBwfkAhBkvC0FACjengzILSeGoZsrJvW9mRQistrJYxwosv0bMFcsAuEN5bt/sMGPA==
X-Received: by 2002:a05:690c:6611:b0:786:4fd5:e5d9 with SMTP id 00721157ae682-78a8b55e357mr275527377b3.7.1764693744007;
        Tue, 02 Dec 2025 08:42:24 -0800 (PST)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0c25ae5sm64853467b3.0.2025.12.02.08.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 08:42:23 -0800 (PST)
Message-ID: <3428eb6d-2698-4a08-bbb8-336c633752e9@gmail.com>
Date: Tue, 2 Dec 2025 17:41:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: gso: do not include jumbogram HBH
 header in seglen calculation
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20251127091325.7248-1-maklimek97@gmail.com>
 <20251127091325.7248-2-maklimek97@gmail.com>
 <a7b90a3a-79ed-42a4-a782-17cde1b9a2d6@redhat.com>
Content-Language: en-US
From: Mariusz Klimek <maklimek97@gmail.com>
In-Reply-To: <a7b90a3a-79ed-42a4-a782-17cde1b9a2d6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 12:36, Paolo Abeni wrote:
> On 11/27/25 10:13 AM, Mariusz Klimek wrote:
>> This patch fixes an issue in skb_gso_network_seglen where the calculated
>> segment length includes the HBH headers of BIG TCP jumbograms despite these
>> headers being removed before segmentation. These headers are added by GRO
>> or by ip6_xmit for BIG TCP packets and are later removed by GSO. This bug
>> causes MTU validation of BIG TCP jumbograms to fail.
>>
>> Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
>> ---
>>  net/core/gso.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/net/core/gso.c b/net/core/gso.c
>> index bcd156372f4d..251a49181031 100644
>> --- a/net/core/gso.c
>> +++ b/net/core/gso.c
>> @@ -180,6 +180,10 @@ static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
>>  	unsigned int hdr_len = skb_transport_header(skb) -
>>  			       skb_network_header(skb);
>>  
>> +	/* Jumbogram HBH header is removed upon segmentation. */
>> +	if (skb->protocol == htons(ETH_P_IPV6) && skb->len > IPV6_MAXPLEN)
>> +		hdr_len -= sizeof(struct hop_jumbo_hdr);
> 
> Isn't the above condition a bit too course-grain? Specifically, can
> UDP-encapsulated GSO packets wrongly hit it?
> 
> /P
> 

You're right. Also, It should actually be skb->len - nhdr_len where nhdr_len is
the length from the beginning of the packet up to right after the network header.

Should I send a new version or wait for net-next to re-open?

-- 
Mariusz K.

