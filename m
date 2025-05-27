Return-Path: <netdev+bounces-193669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188D6AC508B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2643B6CD4
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37989276052;
	Tue, 27 May 2025 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVVCYQTI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E771DF254
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355198; cv=none; b=UPBcDTSiquf5psJAJ7ui3mjoel7dcR3rcELb78N6xChKPjmfDkFnZGxutEkoSVV3dVMSOW2QPnjRv5oai79E34/UoKmwOzNTu+6x4JKxK5XxwrrVRlj5t9SCdpfcQEdIzWX6MR3x7QEPZGnMlhEhan8zUDJNSwz5qRjpiJDHWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355198; c=relaxed/simple;
	bh=Dm2fCcWPFkqVpoaOoMldRHva0p0D4ax9QfDXlR//M4c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dH6arcF5sNu+G1eK7vd4e329/C4wbo1Xz//4Y6d1HvM4Xcb4PtLMquUo2SInDfHI4xGcJ9DY8/Ba5k0JxTzQyjlGiLFvEQ8tLMrzEGJBq9/tijxnDdWR3PX4V6ryK1Y3BvNi+8U3TAGC9fyB2JMBdrcahsXwGtX6yj7q7XJkD2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVVCYQTI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748355194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8doBSOz1YzfUZreRFRqI0zNFnwdh7KfYauCLrEkgwJk=;
	b=EVVCYQTIJQeuxY818gEai8amSwH5eCS/VDzVmeoEbeTdN1NTiwP6SAOYrX9JCqj8bpej7B
	OKSjKubos9R1+JUHLBq5gIF++7ARB4CX3ULbcwp8nKf0joNHNNiX5kDYST0nPe9IevsgOa
	r2b6CAodcN82YIDl4xA1pom3kp2hleQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-O8dZ-VqRNuGqZNK6u--5vw-1; Tue, 27 May 2025 10:13:12 -0400
X-MC-Unique: O8dZ-VqRNuGqZNK6u--5vw-1
X-Mimecast-MFC-AGG-ID: O8dZ-VqRNuGqZNK6u--5vw_1748355192
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cec217977so19472245e9.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 07:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748355191; x=1748959991;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8doBSOz1YzfUZreRFRqI0zNFnwdh7KfYauCLrEkgwJk=;
        b=Yzvsy68dr8CY74LF4bN9xkNFj2lzO9bgPa3EbXJtIhp8B0J2kkkdupAxR6K5SFxqeC
         PUWnP/+ABLx1gjdMi6MEfIhKmBhpD6rC+V+K7YN+UdBOCT7JPPpDtlffkuM98buNOE0/
         JVy11nKTn9e+Y2rpvar56qqhmmKtstQ/Zdan4D4aOufqyxRJ7avmyTJeyl3gAfh1CdH/
         7DJ8FBuT4Y7jW5Y3w/o6I8a+uJ0hvf2j6w5l5I5ysO4+UXcj1YVcbXsdT1Jnm3zS/0ld
         VKvMOGy4c42ExbNtkn8Eey2K2VHcUGDBTFYMz63MY/x9jqUDD4PZ+lfeOewD/hsNVS54
         1Ewg==
X-Forwarded-Encrypted: i=1; AJvYcCWz/CdIPtKqnqhkaF5nFKvFEPkQ0n+ZH37VQjgosUK3tdoziR94M4EbvsePCRzEDFbgRtw1QeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSRfHh5tYaNQbNUfVnkHC2sJ5nx2lbRGH+3lqUYKudJdJnYbJv
	xR42SFbJhUscp624TUwo+HNWu6oQq8ZWY5AOvfsKtrR7Ws2KjTYamWZEnlUBEdkySBwxS3eLo6i
	n2ohUNVxHJ/n8N6wkjsAY+2biHNdh+wDBIrJ3nLgVL671nvLMk6dXGr/U7yydo2bm+7ur
X-Gm-Gg: ASbGncuxj1NToEHaQzZCODWfxj6Q3pjr3eYfzkBHENLxaRLh9FnKGm2WbZ+jOtZzTnX
	la3fnoRM3M+Um9oEkoQ2izWwCfT6MecziuQPUgddElu1fKlGBt8bJFnpw6sAw6oKWdnooftwGy3
	0wvdhxuRYYmxrMDA9vQRoz3wqQgiDH9yKngJuJBsWXtthS3Amn/qIVfHjryxTDZdcoX1DKyWo0l
	QGYX/r6KOg8ph1Fc3kWe7B+TQPu1xg4I7r2P3JbIAPopYn03WMqgDVuhnPIFxuiG3zQhDrKWMRP
	dz36GU/SmNnnPSEsQ2A=
X-Received: by 2002:a05:600c:35d3:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-44c9301650cmr133688055e9.4.1748355191283;
        Tue, 27 May 2025 07:13:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv7aTBRcs9JyDjCxxGEscoDIEKqlKntER2I+Ka7F6Yh8T/WZKGGuRWuDdv8/y9Ja38VTMKMQ==
X-Received: by 2002:a05:600c:35d3:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-44c9301650cmr133687565e9.4.1748355190832;
        Tue, 27 May 2025 07:13:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4cce08411sm10832447f8f.51.2025.05.27.07.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 07:13:10 -0700 (PDT)
Message-ID: <68c3346d-98c4-409a-a772-4f8fe31be57b@redhat.com>
Date: Tue, 27 May 2025 16:13:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v5 3/4] net: bonding: send peer notify
 when failure recovery
From: Paolo Abeni <pabeni@redhat.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250522085516.16355-1-tonghao@bamaicloud.com>
 <20250522085516.16355-4-tonghao@bamaicloud.com>
 <8865be45-e3a8-479e-b98a-b06e5ed6ee65@redhat.com>
Content-Language: en-US
In-Reply-To: <8865be45-e3a8-479e-b98a-b06e5ed6ee65@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

 5/27/25 4:09 PM, Paolo Abeni wrote:
> On 5/22/25 10:55 AM, Tonghao Zhang wrote:
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index b5c34d7f126c..7f03ca9bcbba 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -1242,17 +1242,28 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
>>  /* must be called in RCU critical section or with RTNL held */
>>  static bool bond_should_notify_peers(struct bonding *bond)
>>  {
>> -	struct slave *slave = rcu_dereference_rtnl(bond->curr_active_slave);
>> +	struct bond_up_slave *usable;
>> +	struct slave *slave = NULL;
>>  
>> -	if (!slave || !bond->send_peer_notif ||
>> +	if (!bond->send_peer_notif ||
>>  	    bond->send_peer_notif %
>>  	    max(1, bond->params.peer_notif_delay) != 0 ||
>> -	    !netif_carrier_ok(bond->dev) ||
>> -	    test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
>> +	    !netif_carrier_ok(bond->dev))
>>  		return false;
>>  
>> +	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
>> +		usable = rcu_dereference_rtnl(bond->usable_slaves);
>> +		if (!usable || !READ_ONCE(usable->count))
>> +			return false;
> 
> The above unconditionally changes the current behavior for
> BOND_MODE_8023AD regardless of the `broadcast_neighbor` value. Why the
> new behavior is not conditioned by broadcast_neighbor == true?

Not strictly related to this patch, but as a new feature this deserve an
additional test-case.

Note that the series is not threaded correctly in PW - the cover letter
does not belong to this thread. Please adjust that, thanks!

Paolo


