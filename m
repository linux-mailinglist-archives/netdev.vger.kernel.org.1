Return-Path: <netdev+bounces-146610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719F59D48D9
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1FE1F230C7
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BA51CD1F0;
	Thu, 21 Nov 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS8qmR6V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCF41CD1E9
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177719; cv=none; b=MYs94rH7+gOjCPuw3UhPEbr6SAhGxWOVVEO13Rbw2AGYY0NtBZt7D8uMCWYvYHkiWA4dLea1Kat9PL50sRpSlLHLZwQ8WgM1jjEXUDy5Nv01YKgWXgicrKjx3rOWkOHGmgxQ+XOVDBqV5lJ4dw8A56X4s+2nbH7szHTeugL6ys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177719; c=relaxed/simple;
	bh=rpfFLAFnZrY34Tx7YZQRkB4Xe7nOo8WltafnvqN1d2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMPjwqW89BBYy9m6OWtZg5WFWgK2gDHnKySf9HJrUc8yZzJukg/sA1F3ncZCQrfLJULpDvxQKr9j5hdSER0RcUOG27OZLYrB/GNMbY8w5VVRcDbcb6RgQGx7BvxoPjdA+6JpeXOEV0DoIO+CoTHzs6lnwLnh8pfxzIJzONVK6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IS8qmR6V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732177716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//ytyIGwJU/7+usu7ACf7/NLRSxi7kbRDsQjYD5hFoQ=;
	b=IS8qmR6V07UZnm7fbiAzZ+U/GfzActeM6R7urgwjHjwXYKocIw1pNnU8o31NeC//Ovekyo
	vtQz+Jlpk4WOXN7SGMlQrYH21cBJxizXl6ISN8c5wLoJ1dHM0EphKxe7R3fEY7LYU4SJKy
	1T1e/qxC5RFlXgKOwnPkldMes6AgRLY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-gmeUOtKMMO-tzdpCnQrGFw-1; Thu, 21 Nov 2024 03:28:34 -0500
X-MC-Unique: gmeUOtKMMO-tzdpCnQrGFw-1
X-Mimecast-MFC-AGG-ID: gmeUOtKMMO-tzdpCnQrGFw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4316ac69e6dso4738025e9.0
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 00:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177713; x=1732782513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//ytyIGwJU/7+usu7ACf7/NLRSxi7kbRDsQjYD5hFoQ=;
        b=Tpl1ZuGvE63oQubVjoglBHVaqBLHpVWkD6yIEz8+iu+tLmmUe4FCp6n5Ev0mKngJa8
         +xiRVIPzXMTVwEC3HU9EdcOaqi55oWawVf+h4cEdzKxz83F/+I34nkt7pTvo0JDR79Ga
         C+D6SZlmxJObNPS0mLv9SdcHChMen90mj0jJZnAl0LAKMbGkjs6j6nETjUDvC0KpUwpU
         eg31h9v+93hhdWCSRW3P+YspK3icU0QVL/UyFyAu6v1biQJM4kH2uEszY5HTTU5BEnT6
         jy1DwXUQBWNNtpIXvXCffnhexupG56IBiGTjCFkwYvxHX2KqBQFMBIASa9Y2dF2t6m9f
         x3Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXtfOdXGgv8U2aeG9IbcBUMw8ps87aOrUG5qOuaCdT1X5u6uMUd6ZFqLBLxwHagKpHORQf15NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztUNfflbrYXk5Qbfxy+OdXp1xYibjx/bgEk3ORQ9Fn3pO5GIEi
	JxfKUCcVUOQYedV6V7uI5Jrf59mLKAjvOozmUXJpkozoRfPIBNrjZ3K1y6oL33YRaSfZnn6xA71
	9kCKXnwoJ946P/9wZDr7zCk6B2TwYZaxvyXoGN6zQx/wL6sPKKp7zYA==
X-Gm-Gg: ASbGnctU304NZ5qA9WTbNQl68knXfFjfX5ACBA+kKn5IQ3U4qSiF8FFEswqRmJjLefd
	X4u/sEiPUlBbohaPZPkvnwU7WFzaNEuMFmQbMvnLeONaspEFJe91N7uf6loDLzPGIKDcKsGe0RH
	v8oKDku4jHlHmn98+9lMPlhFl0yw1UPhNK74Q+a8TF8qlQzlJhd8cX3DBZg6NKe7xdHoXshcM3D
	Up+7J55AGhDUgbA1Zdye2HcKuS1e6qMFWEfUBeViU0F7+sDSagIqawDUHYQQTKK3nbHCIwuGg==
X-Received: by 2002:a05:600c:35d5:b0:430:54a4:5ad7 with SMTP id 5b1f17b1804b1-4334898711dmr44379245e9.1.1732177713240;
        Thu, 21 Nov 2024 00:28:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHee7Tyb4QNMI1oZUcMrDDlSalmyk59Oq4LLlDqDJZj1F8D0rIMqICqUoUnjpkvfupaUq4c8A==
X-Received: by 2002:a05:600c:35d5:b0:430:54a4:5ad7 with SMTP id 5b1f17b1804b1-4334898711dmr44379045e9.1.1732177712894;
        Thu, 21 Nov 2024 00:28:32 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d40basm47402025e9.21.2024.11.21.00.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:28:28 -0800 (PST)
Message-ID: <722719e7-6f11-41cc-8a83-0a860bd1f12e@redhat.com>
Date: Thu, 21 Nov 2024 09:28:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ptp: ocp: Fix the wrong format specifier
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, jonathan.lemon@gmail.com
Cc: vadim.fedorenko@linux.dev, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241120062605.35739-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120062605.35739-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/20/24 07:26, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Use '%u' instead of '%d' for unsigned int.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  drivers/ptp/ptp_ocp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 5feecaadde8e..52e46fee8e5e 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -1455,7 +1455,7 @@ ptp_ocp_verify(struct ptp_clock_info *ptp_info, unsigned pin,
>  		 * channels 1..4 are the frequency generators.
>  		 */
>  		if (chan)
> -			snprintf(buf, sizeof(buf), "OUT: GEN%d", chan);
> +			snprintf(buf, sizeof(buf), "OUT: GEN%u", chan);

Note that the above would still cause a warning, as the formatted string
could be theoretically truncated:

../drivers/ptp/ptp_ocp.c:1458:61: warning: ‘%u’ directive output may be
truncated writing between 1 and 10 bytes into a region of size 8
[-Wformat-truncation=]
                         snprintf(buf, sizeof(buf), "OUT: GEN%u", chan);

Since 'chan' range is [1,4] you can probably safely cast it an unsigned
byte, and update the format string accordingly.

/P


