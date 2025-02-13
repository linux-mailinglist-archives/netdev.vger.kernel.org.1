Return-Path: <netdev+bounces-166175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70469A34D45
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D571888333
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BD0241690;
	Thu, 13 Feb 2025 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TluH0srw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF48204C21
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470369; cv=none; b=p4lkmbbSo68kIKCy0GFjoJqC3X2cEOnq4QOjELmnXTzHLLC9R7OT1FVDcVoqZ1Gb9hBs1HitNm6EHwRTSOI6lugBXVAYr4fOLKlan9tX+muTw9tEzV/ZLUx+a+wwWMPgNChUhlIppDzIjUZM4iUqN88eXXX0VR0eKiQNZhJgKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470369; c=relaxed/simple;
	bh=UlLK9wnv9l68dOBHmY2u9ee5MSToJwrSe8XSGZkffFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/qoUP2j0GapztzXhgWGOkgctkyfmiUGWZ1iGtOv8LK9uo1YXkV9vhmNWyjOTS/s8Ab7UGjyLh4VjRCRIaqq6mRkg1JCWVLsD95+h6qsAzwcoPYfHYGZYAn9Mwy2EmJGUrcmYa9FTgBwdv161B9kopH81UuJF8uV8LVZSKw/dKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TluH0srw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739470366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93bj8/izYlaVPYeZCycYCJAhSZjizEuIK8oHtdOa+uk=;
	b=TluH0srwoncM9t+PYqzjG1DqeYYKGJ8XazWRMpQO5sqNQEDf/mnvIk7gCbgKc4l1CDcZdh
	pvT5WVkx4caEDsYUrKRgvBGLQWOkE1RstzaxCOr0kmRa5icwngbTcQcu8IuLJ3TJxwhJHR
	PMsF/fHKWEXR4KQE57YmYhg+CK7ZZls=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-dHWqPZLmP5uEY_8ixGoLbg-1; Thu, 13 Feb 2025 13:12:45 -0500
X-MC-Unique: dHWqPZLmP5uEY_8ixGoLbg-1
X-Mimecast-MFC-AGG-ID: dHWqPZLmP5uEY_8ixGoLbg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394040fea1so7059465e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 10:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470364; x=1740075164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93bj8/izYlaVPYeZCycYCJAhSZjizEuIK8oHtdOa+uk=;
        b=LNcyxLfANQ6VN4KzR1UEJyzRBiB1S04eNeOErxONkJoXHPw3VZg4NIPwWZH/K+G7y+
         kfYxJfaqXVq7Rhv+cIp0LhLk/UzMhtbZTwVHSsnvZh0LVUzjeChToJa6UR4vshpplglk
         BtBPMr1xBfuZMfwAYyBI6gcae/TCDSAViYwcFT51YElUiBgFK7eeSF1VHZtuwHvHwnZi
         4ftPFhouJjKIOa+yPniUhMLiLrX++8A2K41JsG0n7aNqmVFK3uzGSMumGUuk35nLszxN
         aqWt+wXXQvCCjUe04KvyP2YLKfpo9kzm81TkY0H5nvpP3ZFwRJOmURdFiVDzCcZIHxWc
         n5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0lJr6KRM4Vf/mhU3aykTKrXwM/av4H6zHG8Bcpnk2dgx7BIafCM8HwfR9SNaTf8WpScD7Bo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgO1BxC/+qxfMtUGXM7rGraHQrrBOjZwhszVv6TzzKpLKicyJ
	JLL6Yma1Mgg2+UlYafgI884+beiPWHfhJHwkvflMXm+2UYd8WtZrZADrUCd/M7OmFsypTGcVsyl
	Q8e1g5BYSzdBmoRl6Vn7Flk5LcWbHiCayS7H0i1e3JCoPpMPHtlBoEw==
X-Gm-Gg: ASbGnct5dfp/+HKk2XHo/qAnGwICDB+lggFMfcvQkea9WPkKx3xN8G2keN+8j3EcrpZ
	9jKHWEAChgl76LQlOpMiYTdr9iZjY7UEKSog/SNPcXKAqMIE1wooJ6JHigJ48rKtw2+i0gc7BIU
	Tj3MhennhP7svEhANAnmBkHSZbP+Sxp/j2b1+NJH1AjNLT25cHCstL4uTO4rEefn9tHv5xz5l7/
	qWvYmPbkk8iPYNvxyb3EdeFugscjL4EFoZfmfJdVeMdWSqq/9+g2w4tonl/fHAv8GZGt2mXNjNE
	IARSbDoea/rccLZnYqvsL7fyuFnCV62EEis=
X-Received: by 2002:a05:600c:2319:b0:438:9280:61d5 with SMTP id 5b1f17b1804b1-43960bcb171mr41669415e9.5.1739470364211;
        Thu, 13 Feb 2025 10:12:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiZtF4YKzidB8ikmahkoz8y8vrP5AbazV11emmVVKYJ9cJ7zulXRCI8JyoRf04GTsUaqZzPg==
X-Received: by 2002:a05:600c:2319:b0:438:9280:61d5 with SMTP id 5b1f17b1804b1-43960bcb171mr41669205e9.5.1739470363859;
        Thu, 13 Feb 2025 10:12:43 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4344sm2561697f8f.13.2025.02.13.10.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 10:12:43 -0800 (PST)
Message-ID: <864d12bc-2ecb-4770-af33-044232876376@redhat.com>
Date: Thu, 13 Feb 2025 19:12:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/7] net: initialize mark in sockcm_init
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 dsahern@kernel.org, horms@kernel.org, Willem de Bruijn <willemb@google.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
 <20250212021142.1497449-3-willemdebruijn.kernel@gmail.com>
 <d5ff9165-a221-4ab2-ad9a-3f5b025f09a3@redhat.com>
 <67ae1142e9bdd_24be452947e@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67ae1142e9bdd_24be452947e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 4:35 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> On 2/12/25 3:09 AM, Willem de Bruijn wrote:
>>> From: Willem de Bruijn <willemb@google.com>
>>>
>>> Avoid open coding initialization of sockcm fields.
>>> Avoid reading the sk_priority field twice.
>>>
>>> This ensures all callers, existing and future, will correctly try a
>>> cmsg passed mark before sk_mark.
>>>
>>> This patch extends support for cmsg mark to:
>>> packet_spkt and packet_tpacket and net/can/raw.c.
>>>
>>> This patch extends support for cmsg priority to:
>>> packet_spkt and packet_tpacket.
>>
>> I admit I'm a little bit concerned vs possibly impacting existing
>> applications doing weird thing like passing the relevant cmsg and
>> expecting it to be ignored.
> 
> We have a history of expanding support for passing variables by cmsg.

Ok, I should have paid more attention to other cmsg related changes.

git log says this is actually allowed, so I'm fine with the patch.

Thanks,

Paolo


