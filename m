Return-Path: <netdev+bounces-190105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E01AB5317
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012DC1887418
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C760A241684;
	Tue, 13 May 2025 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFgnNLWy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2573241674
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132884; cv=none; b=ahrGCtpjPMki250UBIdcCPipWsz6HS87ZvIqUUY1CvvXpzieLuFYVAFDuJoWJ11tLLqwcWiOE00JsZ0CY6AWOXEaA9e3pBdKh9hAHvzvdfve1WuBAw1ZE6PwQ8+jSfoqBbeSUxQvlrX5oUs9s4wyp+VOADBqlFHUn3e/JIt8QlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132884; c=relaxed/simple;
	bh=CzXbJtVm+kfPx2wU0kxbzltwOiI2Rq/axwGhJhgRpjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/sBHLtHf6Re+pmbfX6kODYMuTXNqqM+SEYhYqo7XpgqyYImHHWxR6p4KIPW3u3Hd/lzo9VC9IDyEXVn1PInIJ/o/vWtEXtAtZooYme0HTnoR7ETgGd8Q9f6vzBw1uNUQ9aQSxUGGw9LgT/NkAr+U/tgSga5ZIRwcPA6AgE4TAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFgnNLWy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747132881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJeKw16z9gukuPHYO36IGk1ktHWHQEMVdMrmzMhOzO8=;
	b=PFgnNLWyssieO4x89SMSobbUJg7XI1qfODespef5o+BCa/1ivi1iRV6EZfoBn3Hfo8Tbji
	Lck6tGU1ZaGwyRNaPmQSBbbd21StQDcOaF529yyAiyvLev+Skw0P+LD545DJB3xTHl/MZf
	F2s1oFSyQ9a+PRDQdyByQBIWn00TzKg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-FD_LAW6kNjCRrpo3AVX34g-1; Tue, 13 May 2025 06:41:20 -0400
X-MC-Unique: FD_LAW6kNjCRrpo3AVX34g-1
X-Mimecast-MFC-AGG-ID: FD_LAW6kNjCRrpo3AVX34g_1747132879
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso32294855e9.3
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 03:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747132879; x=1747737679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJeKw16z9gukuPHYO36IGk1ktHWHQEMVdMrmzMhOzO8=;
        b=l3tOcbAMmEPdzBFnSWmSu6/mAvdEURz7qReTCv1eNKeGGWTi3+vNFf7I3E68Vjr0yt
         Mz6DkadJkkTnjZTbTPkjLByDGPh9ft85u6xzkLcLMzoXFrGtEx+JRNKK3HNk0uAZRO2J
         2MWEJWhJqBQfnJNPvsj7/Sp9xwEtEdsUThPN4vDtkXUvwfN4Waib9OVuDwn8hE8YkOyZ
         htWD5yZIlSVlePmQVO7d4QqfRUfdeqq/123BfuJD6TeOo9Rw2fnWI/xkIULVouTpqwjj
         Ec6bfJOEdse73KzSLUdOLtnEio2iK4MykyQ1nNMCmIe4TYtkCGSKaYppLZ8QBL2Wnphj
         xqVg==
X-Forwarded-Encrypted: i=1; AJvYcCV5aqXwHBmpDvYo5X0jRcdF6WW2fFrMwRMEEcMYkzmYtP7dvRZA0+aCcesruHlozcrf6mNr2us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzux8eXdByzioM60ZH6e+R7fg3Kc0qMioyDCo5fQCPOkYKvWqwM
	cdCARx45lxBBpktvTvZe9fRm0yA4T9UOhZghFNdzvLhrqPQLIdZQcY+586IkFiQhfD5qR5eCdkq
	8/2easXgqHYJtyfbZOBKu4kP5lF9Xj/Tpd1ZmaTSB8ZxDBv1s3LfCJw==
X-Gm-Gg: ASbGncvEsai/7uQTd6qE8RYBaY+IrY+vYOSslCz6t/M7DEmeyCyK8DxsitJsk/Ddm2v
	ZwZPJX3W5nllV3lu+7wSDijE13IuPM0BPgioFm43ujcKepr2K/um+J+ozNtqdn8a3WXdHQlwNyB
	DSPasnZBVV6nmn4nOU6RWq5aeOKy7W8LNJd36mRlEXCZNdW5FhbEkUvlikkRskOA5xE+mbY4wCX
	wQ2R7RqT1/XLeKwM7oJO76Cn9v6pE94unayDxpfR0zBR6yB+fuuEdX7RQbXsjsaqPCJh5GWKLaE
	YGBnWkd+6mZ028qCIJA=
X-Received: by 2002:a05:600c:46c3:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-442d6d0a9f6mr139315935e9.4.1747132879363;
        Tue, 13 May 2025 03:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl4gdyqUK+UhO8XqkYELW23efHSZ7ANt+SKdLL7x2md+luIlfmn/ndhYYAarVKcIiNK0vd+Q==
X-Received: by 2002:a05:600c:46c3:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-442d6d0a9f6mr139315655e9.4.1747132878948;
        Tue, 13 May 2025 03:41:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm15609566f8f.22.2025.05.13.03.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 03:41:18 -0700 (PDT)
Message-ID: <8d1206d1-1b62-48a4-a304-23e13c1316a3@redhat.com>
Date: Tue, 13 May 2025 12:41:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] vsock/test: check also expected errno on
 sigpipe test
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20250508142005.135857-1-sgarzare@redhat.com>
 <20250508142005.135857-3-sgarzare@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250508142005.135857-3-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 4:20 PM, Stefano Garzarella wrote:
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 7de870dee1cf..533d9463a297 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -1074,9 +1074,13 @@ static void test_stream_check_sigpipe(int fd)
>  	do {
>  		res = send(fd, "A", 1, 0);
>  		timeout_check("send");
> -	} while (res != -1);
> +	} while (res != -1 && errno == EINTR);

I'm low on coffee, but should the above condition be:

		res != -1 || errno == EINTR

instead?

Same thing below.

/P


