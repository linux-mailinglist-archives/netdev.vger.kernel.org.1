Return-Path: <netdev+bounces-166001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13BDA33E57
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21057188CE6E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFDC21D3F6;
	Thu, 13 Feb 2025 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beg1QDjN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D25C2080DE
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447111; cv=none; b=MIIwyGk1f/GpzkU8PaBVy2O1kyOFfqxPYGXGxOMmilqp38gLFub6lcGhBvH/uilNAYCvkVBYcg1ihNzuYkodRwT83jD3flBV8Qa4kxgX2aAxw/EObBSDrb4+/kyvVAk6bhXvref2OoXRwxq4yF4Cy9PyGBkFgoy8rkH7/cQL3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447111; c=relaxed/simple;
	bh=z4FzBPhL+KmxxVmJsJ8LIv/mETG7bxy17DamwT8n4wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNc7aNsBNnfLahoTnrkuDBlJVbXJNM3fJk6KHCdX0wMacFutzAu4c8D02IMnRi8Xy5aAt0KiGMephVGlnAJynRavv5JokYvwLdpNsR8QojD3tHQUH9/2FYhbeTKwJx2l2WFLm3s6QT6aAH5z/i+H6RbNwSR+gb5bl0pvq2xRVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=beg1QDjN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739447107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ail4YrUpEYkDWqUc8Ez27id76e/8NDgaGRJNAbGRmo=;
	b=beg1QDjNvwnE7SxeIUE3jgKdZ9FI1yShicV41vfrU/iWdqQrkxoGchVXIcWPAK8Y1FWgd7
	DReTdNXZTZ32se+T3hgF0txj0HBLnmD06vbvwf2lvyYR7AzbOs54Qz8lc3vRqKXRJ6nkmw
	uiOxBnQnGMN8elLjPZ0zlgB8+PP5D3Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-_QHT7wNDMqODJLdWel32xw-1; Thu, 13 Feb 2025 06:45:05 -0500
X-MC-Unique: _QHT7wNDMqODJLdWel32xw-1
X-Mimecast-MFC-AGG-ID: _QHT7wNDMqODJLdWel32xw_1739447103
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4395f1c4354so5713475e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 03:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739447103; x=1740051903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ail4YrUpEYkDWqUc8Ez27id76e/8NDgaGRJNAbGRmo=;
        b=HdYsl1BumWwPRwWESc2UofFcEI75PdT6Y675CU75r/3YHYJ/tHWF5TTsWHxeYDYlco
         gJfjXDfy8tJMOmGf+z/qVx0Q3yhj5iUMjAPNy4Vajv2s/jUURpD4LQthrNETuU4gRXlO
         b0PZDdVQFBuiR3L6mg4Pan0/pK2ZQukqO2MzmkAIxTQAQkQIIcjsa+aS9qeuzh3L1iZl
         YnAXHssj6Pz0x60qcEsUXKVxzhmkUs+3lMfQtZ0gLdTTzd4O6szRwTdazWDl1chKPcmy
         wxjxkN0EgTTWgpN+bl33n7EX5N7eD6s2UOKkQACyrQSRGPHrTYYyU3bZCFE49NrDl/St
         00EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKJRQJhOstcLJ64OUjtyPv1H9ghNsKQMesImW5hvjKWCqrPvxbeAdm9s3/etV+gF0w6hso9Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFM4L4YAfKti4aXVpWqj4g9uO7x/qnTIm7EheAgvWsHyYLTkX
	ZGZMvHfYOpO7xcv75JI7DH7Qo40JG8wZSxUz5EWz1rUEYkZNXYzKCwBvJNZdkAFfOwPAJvH38Sn
	pUB919cCoi8l9E0zFqIO4UHTDna8BY8UvW44RenYkS4TSC/lo9ASdBgA22KO/Jg==
X-Gm-Gg: ASbGncuIWSmmP94dQwBGq8Pef/N0vb0t4VIsJZ7sXq3tr88oSkXkhnY2OxR+IO74Yl3
	3NlKYaFFE8FsAMszBv3ySbNhioSlSn0gJ9kEfggCt1z5EMM5MiAJE40yfK32fWJg5Mne8g6yZHk
	qpZrOqtmoVBM+LwtW1nc7TsBEgG8sm5+uPOHXlyymBFg+GGR2DiiCA5RtDHbQQBd+aSVNptbfOw
	ZRGi3K9jmRPFlOyNQvCQVqjpnFtEsNFnGeyWzCGGauoCznbJ5gkp8l0J0BfrDZUIub/vKtIlXVJ
	KkE5ch11L/y7w28D/8yyDOvNvXzNPrR2QWs=
X-Received: by 2002:a05:600c:3ba8:b0:439:4832:325f with SMTP id 5b1f17b1804b1-43958160560mr57564805e9.1.1739447103147;
        Thu, 13 Feb 2025 03:45:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsSaO9nwngXTwOiOIOnC4gfeygnFqnmDRDuBNDDrC1cNijFS2fay3xrPf6j87eCOO52vmu/Q==
X-Received: by 2002:a05:600c:3ba8:b0:439:4832:325f with SMTP id 5b1f17b1804b1-43958160560mr57564445e9.1.1739447102713;
        Thu, 13 Feb 2025 03:45:02 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617da91asm15645415e9.2.2025.02.13.03.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 03:45:02 -0800 (PST)
Message-ID: <013921c8-1fd0-410d-9034-278fc56ff8f5@redhat.com>
Date: Thu, 13 Feb 2025 12:45:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] documentation: networking: Add NAPI config
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, rdunlap@infradead.org, bagasdotme@gmail.com,
 ahmed.zaki@intel.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 9:06 PM, Joe Damato wrote:
> Document the existence of persistent per-NAPI configuration space and
> the API that drivers can opt into.
> 
> Update stale documentation which suggested that NAPI IDs cannot be
> queried from userspace.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v2:
>    - Reword the Persistent Napi config section using some suggestions
>      from Jakub.
> 
>  Documentation/networking/napi.rst | 33 ++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/napi.rst
> b/Documentation/networking/napi.rst
> index f970a2be271a..d0e3953cae6a 100644
> --- a/Documentation/networking/napi.rst
> +++ b/Documentation/networking/napi.rst
> @@ -171,12 +171,43 @@ a channel as an IRQ/NAPI which services queues
> of a given type. For example,

It looks like your client mangled the patch; the above lines are
corrupted (there should be no line split)

Please respin

/P


