Return-Path: <netdev+bounces-55463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F23DF80AF54
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815D8B20AE4
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC21158AD8;
	Fri,  8 Dec 2023 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="GpUhqjX4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB1F10E0
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 14:04:39 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c210e34088so2095945a12.2
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 14:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702073078; x=1702677878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NWBbyLhR/se4HbG1atfrY+dKLWbuEayxNh7+RneTVYI=;
        b=GpUhqjX48UwA5olgvC2QRDCnFYgGZhaM0X+HE9EjtQrLlF6AOrfXZS9TqHvSod+RE0
         307oPV9BLZBnR3247cgDUQ35TFw5TQH1WEScZoekj682ZuSrjVmKzhrjzjgm4ms9qE1s
         bV+Vff7AtrOTrrW92ACiOhw8mRKFPPjNzo1cVH6ahgvhNhzi2PcYhgExbO3htd7XSfX1
         h19gSPj9Im3VxT0aB8H6X4eguaHv4aSDC9AErWDpYpgWnCx86I+BwwPByebeRVFlmqLY
         6CRXHs7aH6w0VlOFHEKN1MaS0k4JHq0BSbASjYT9OScHFOTU3wq+yggKRPy86EpgAMKO
         FoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702073078; x=1702677878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWBbyLhR/se4HbG1atfrY+dKLWbuEayxNh7+RneTVYI=;
        b=IaDGWYXpasi2xmRtlJsm5IPiRutKDRNMFnh8dWOr1F9YUyLk/fR26/ArBZptWF3DpY
         r/qZ8mEs563B1i3F6iYrxp9+CfGN25I4pyhr8Mk5RvN/tLwbapWdpDFlscY+0FHfEMjT
         NbbtsnLrwadrVlO+DR0DYW/IepXMnAECiW5vVJUl+1LgBUIDHFVZw9t6QoJLyxfBd0Fm
         9AVRE2KNfGHPzwmbzVbBHm8BlWqXk4BmWa+9gqStJSdIyxGu29Jf9NWIi9ABULscKrOe
         hhxSs4F2Lbj7p3+eSgJBYUOYxZ22oBvslzblNGFmyS+GPvG0OZgyZRmoLOW98ThM2FcY
         d0Iw==
X-Gm-Message-State: AOJu0Yz+22D0z97Hw02sSYfxLGszu1UbStb1AD+YQK8of8ANLzsoQrPw
	LOaUwE20s/S4sJKIhi0kDhu45Q==
X-Google-Smtp-Source: AGHT+IFYM5q3cEbeoyXGhwe2zH6cUFYGF8Xdv1ZFNvlSzWtxaH+ZLg29EO7YeSEkAKWrZyYDQ6Huxw==
X-Received: by 2002:a17:902:e5c5:b0:1d1:cd8b:8bc2 with SMTP id u5-20020a170902e5c500b001d1cd8b8bc2mr864669plf.33.1702073078589;
        Fri, 08 Dec 2023 14:04:38 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:34a6])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b001d05433d402sm2182976plk.148.2023.12.08.14.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 14:04:38 -0800 (PST)
Message-ID: <54f9c382-f38b-4847-909a-2f9b122ab6d2@davidwei.uk>
Date: Fri, 8 Dec 2023 14:04:36 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] netdevsim: allow two netdevsim ports to be
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231207172117.3671183-1-dw@davidwei.uk>
 <20231207172117.3671183-2-dw@davidwei.uk>
 <20231208095817.5aa69755@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20231208095817.5aa69755@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-08 09:58, Jakub Kicinski wrote:
> On Thu,  7 Dec 2023 09:21:15 -0800 David Wei wrote:
>> +	ret = copy_from_user(buf, data, count);
>> +	if (ret)
>> +		return -EFAULT;
>> +	buf[count] = '\0';
>> +
>> +	cur = buf;
>> +	token = strsep(&cur, " ");
>> +	if (!token)
>> +		return -EINVAL;
>> +	ret = kstrtouint(token, 10, &id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	token = strsep(&cur, " ");
>> +	if (!token)
>> +		return -EINVAL;
>> +	ret = kstrtouint(token, 10, &port);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* too many args */
>> +	if (strsep(&cur, " "))
>> +		return -E2BIG;
> 
> What's wrong with scanf?

Also responded to Jiri:

I went with strstep() instead of sscanf() because sscanf("%u %u", ...)
does not fail with echo "1 2 3 4". I'm happy to use sscanf() though if
this is not an issue.

