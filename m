Return-Path: <netdev+bounces-243202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5534AC9B6E0
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 13:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F11A14E04D0
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 12:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D67A30F92B;
	Tue,  2 Dec 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bs8bFAju";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfJ/LM/3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8330EF88
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764677210; cv=none; b=u95DfmErsyXsR+vTFojPUk2twsnkJBP0MQO3zWcfi3qt9umkISdD6uXU80z08ykJmvKn7dG8CvfMTPojrbuWWUrNir5trtNf8xKc8k/isnZHNCRaiwrmiVMzbL1c9RmnJSR0bWGPRjDZrUfkN55+SSrZDVYWUZ4wBsJqB6bFDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764677210; c=relaxed/simple;
	bh=jElgder7nrZyrZsIILYazwa+ABo4MOdYqcU6J4eFD6o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=nPHBXbj5wUdQEHJTFPQT6XUtFvoZWrK9gsPu2eIYi5zq/GzpqMHEEt0nSUu3bsRcOuiX9fGhZP8cG2fqQv+IHxIY9vjYmLdnnH2CIi5NN5Kit+pAQcpWJx1t1NifE/G1wZaiDG8qSZ04KiL7Hgw8clQu2bzRUt8Bxs1XubItImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bs8bFAju; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfJ/LM/3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764677207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vu8w78ppJKzD+pyJ97l9yhoz2LsykwyJLe1oVUhLGQo=;
	b=bs8bFAjuyDKFnoLSDJPcNq55g2HYVK9tzqEQk9qqk9Ur8AWCSfPoNl79VWJWX+bJRP+taY
	RbVDpLNz8UK1U3K7PWcDAlb2Atifnlrbm2tVVQRh9cx/Yi7Q4bkyVwDLArVHct7Rc5yQ3+
	B7TWtEcL846E25a9yY05qthDbEOviHA=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-WxvmeqeWPXS5ZdbzWJggYw-1; Tue, 02 Dec 2025 07:06:46 -0500
X-MC-Unique: WxvmeqeWPXS5ZdbzWJggYw-1
X-Mimecast-MFC-AGG-ID: WxvmeqeWPXS5ZdbzWJggYw_1764677206
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63d34257de6so5714721d50.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 04:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764677206; x=1765282006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vu8w78ppJKzD+pyJ97l9yhoz2LsykwyJLe1oVUhLGQo=;
        b=QfJ/LM/3psr9Mo61CsQCadyWBMb5SGaWDVDuTFV74CAHEKlFPC6r8igey5bVGEWmK6
         0ayJ1PhM5r0jl99v+wuzlEDWoNyUVXMAFSP/UOq6hc7f9XDWjP7E9l3uEIQUeJfDG/dr
         RGGRD88mKBQlTwoweSzLFD5TRFtO864HQURYaD2Z++9/uBxPpHgSwW87otA4ogj0z5jV
         7o5waV6HJmpXxzelYLmsmIc+t1scEaQlvI7Tp+Tt8Qoa1bxVt3+ragzhF+/P8MChWccb
         y9htYcTJPtkiRuH3lgQqSLt0FtXAqfKAyHBTu1JdVaewhibcP9yakSYHAAxat3n2xQJt
         X6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764677206; x=1765282006;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu8w78ppJKzD+pyJ97l9yhoz2LsykwyJLe1oVUhLGQo=;
        b=uz85Zh5Wxf2mDNO8DISIjXWEZliHsoZftCIzQPlvYse91wwZgGDyUZf7TxK2CFyjks
         2Y8SXxC/gHd1/jlnusOD83dB95XdEEfz9aWyHUU76izfoKAndW8Mw0dSpMx+h458cl9m
         wqmfWAiYmWUwYT1qEPg22sfBIm0HDi1BaSQdYumFx+Eimjoc1y5taaOpkLvcyxP9PUpZ
         IY5buM6cQkAe5lGmW2nMkc+Dqi7lHHLHn6fa7MQupj7rbxijhgWGdd9vJJ7y77Twdr0H
         D05PD/VMda6EasWl3PCjJKyxAZZ5qSs9CVTGNxIpgQnqzDsdfpaRZhvKCPoujVNww5hR
         BXlg==
X-Forwarded-Encrypted: i=1; AJvYcCVpAHxG0qef3gVqgIopwy5+azwzDuygDlJWxN019rGFWh4dedqh7vdCvWR/gex3a4qUPKDGyNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaH63nDLbY92QEKMkbfNJrqL3BHspiAwkChBn0mMBwq98QZd48
	MN0q9pzdNFy36WvwWAb0RgVY9Om+vZGoth7tqB1Xwwc8lMcKe56AMs0Uw13qcFg136A9lGTtahs
	aNOQYIyBuGccYE40v5kob+t5N9z9Mk3RcGwET7f7L4oH8cRq2Z1VuKq43Dg==
X-Gm-Gg: ASbGnctsaV6Qusy5Nel2NI5PxO8X8Jp7EdDGyyMfPi0dgUmNufN5wLCzLITjItJ29Jf
	Vp1AfVwx1m32h6soQwyDpm35BrwZghTAkAxUwEnMBkQA2lBmE3koNg2J8AHf/QT7oNMJ64RPLqM
	hMnt4YXWI2f/ARTVsAeUQ+V+46638OssSqEhwPX90k8MXatMUcrE0J+tDJLP0hHPXjGUM1kDZun
	/4vhJ/HfuxZSiDpbN4U32RxVDSwOWOcD4jJ0dNTAiDi0Y9YN9tO3fX1BYGw7cB+cFvi+gmKTTBO
	jwxzzwLdytMiiys8spF6zvJESZhNO+56v3wVSrnd6uxT5b+aL1IfsBFr4aGIOTZuQTHrleNeZNm
	wdtf4Y2dFSyHfTg==
X-Received: by 2002:a05:690e:4198:b0:63f:a585:14 with SMTP id 956f58d0204a3-6432922291bmr23844838d50.17.1764677205692;
        Tue, 02 Dec 2025 04:06:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5Sdjh/m7TzMmdRnQ9P7KG8fVYzgT1krE8TwXTWrg5V2JN13cvKcOeXw781va0brfxI2DyyQ==
X-Received: by 2002:a05:690e:4198:b0:63f:a585:14 with SMTP id 956f58d0204a3-6432922291bmr23844819d50.17.1764677205374;
        Tue, 02 Dec 2025 04:06:45 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c484722sm6095485d50.23.2025.12.02.04.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 04:06:45 -0800 (PST)
Message-ID: <3728e02b-02d9-4dad-b5da-47e64e91f406@redhat.com>
Date: Tue, 2 Dec 2025 13:06:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: gso: do not include jumbogram HBH
 header in seglen calculation
From: Paolo Abeni <pabeni@redhat.com>
To: Mariusz Klimek <maklimek97@gmail.com>, netdev@vger.kernel.org
References: <20251127091325.7248-1-maklimek97@gmail.com>
 <20251127091325.7248-2-maklimek97@gmail.com>
 <a7b90a3a-79ed-42a4-a782-17cde1b9a2d6@redhat.com>
Content-Language: en-US
In-Reply-To: <a7b90a3a-79ed-42a4-a782-17cde1b9a2d6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 12:36 PM, Paolo Abeni wrote:
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

I forgot to mention that AI review noted the above check should be
placed in skb_gso_mac_seglen(), too:

https://netdev-ai.bots.linux.dev/ai-review.html?id=bed04a62-0239-4392-a9a3-2399fee27630

AFAICS, it the OVS forwarding path should be impacted.

/P


