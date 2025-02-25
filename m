Return-Path: <netdev+bounces-169420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6DEA43D17
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B457A5ED6
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BDE267F70;
	Tue, 25 Feb 2025 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiCixUc+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C5267F60
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481488; cv=none; b=IMdhAi8CQRgKPRGVsml+hGwjzuVi/xHInbDenFTsOE8ozIauPD9/bGarIpctVgCTvbjGqraoN3YPBW/3SWUOYX7FPFc1J6+pcAenmsI6T+EGVxkJos3qiVi7J0L++b4vcH2cZQQ6NTBNDJxXF59sCg8bC2a2pZLgcIitxo1eKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481488; c=relaxed/simple;
	bh=gGk+PacptmgN7acYoXH8GXPzPxSKg6K9qKS3X8029eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZ6poZeNhwXc4Gi+GICTGDSi6Hw8iqH/6Mj7WH7dQRQJqFR3bOnyI4rmkjZ6cCaKEyrF15bYJ48TreKXAmPWCN14QpwV7rts2A/xtssTsxURZS5RgMFDfZl5Mjb7XIEPz9eO0cXQTNtFqUtEsly5JDaW56PhOCyp5SQepVw1yPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiCixUc+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740481485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hf4Gl5VvxPitA+JhAuJ5cDzkRGuYTLJmJvFqT9v4Tag=;
	b=RiCixUc+I3tkDtjommqFeaeUi4/o3tPJ9MGD8suB5vVmecxRvXyeLcoYlzpB7OiakkS8VC
	FgHSFp5RCNcSLVwRser7IzqPiqQXbJhv2cwOTgyR018z7HibDSu6UmQFsZdeRP2cuMKCTT
	zEdPoff1dHAP18ToMIN2EDgQ+NbSFc8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-QiSL3Pz2OTC1QMxOocVBiw-1; Tue, 25 Feb 2025 06:04:44 -0500
X-MC-Unique: QiSL3Pz2OTC1QMxOocVBiw-1
X-Mimecast-MFC-AGG-ID: QiSL3Pz2OTC1QMxOocVBiw_1740481483
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4399a5afc95so23546385e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 03:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481483; x=1741086283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf4Gl5VvxPitA+JhAuJ5cDzkRGuYTLJmJvFqT9v4Tag=;
        b=Id6sznLBZzv22kG8JJ65w+d+J6OzeN48l61n5jTZsgU36fEHWfaIzehqgCSUys5Ybc
         B5qTzNny0Aqo3ZhX5cLa3Ef1I6NSPmYEjoI8aF960UsV18kg5wA0f+eRIuX824HKzUYk
         Kuni300Mv8/VPKGH41Fm/Jz8OB2tN41TbTXPsCyWPqt3nXbvkL4FKIqwhXqieYG9V2yU
         Ck/RChOEvyNvqphifWwZFQbAUF60VLpMuADkWRQDm4i7mTQNeeAAqyijvX3W3JC9dxk4
         6RyClSR7i9CejOT1LR4/Xvdo+JIR/QW8F9VDrxeUDbGWgrpP/IJNHaIwAQWrZF/AvQ1L
         PNSw==
X-Forwarded-Encrypted: i=1; AJvYcCUq0rQBB8og1xpT7xsdJpyXXbGR3iUhC9oXlEDhzMoGzEfrwZjMaYtOaquHpcuZm5UM9CMCJQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtJVu2txCuL9cjUYm1s/CVcYGB91peCuPXcBq0FFqJNq24azA7
	tFqTAdoX2uOY/SwezAKyuJAS8lMskF9zLyk7k26QSD8/zjO10/RjlpZuQr9lJ/ah9/C+10Ws8xQ
	xS0THKI2uSYRFx8nk33o8bA9UFtBf7WCTfUXWXkxI8yXvwj0fD4J5lg==
X-Gm-Gg: ASbGncsSMT+5IrthIAvBB8027hZ/6X7XitTKHPP8az1EiM2ksivNfgujk6RmmlsOCK7
	vBTZ6vv8H7ZIQJZ6Rxr2Pjl5/VqZKb0R+FlUH5PQa1IZEn3AI7aud19pzhONdvK0ll7BYyV2OtO
	eZ46XErN2QUvY8kAj6ndzdqRrYjm+xa7aFBwXa/7qsRPDjogYVL6I1zeq0k+f2g+4Od/kzbuNeY
	e+KHDw5elvw2T6nFr/Er2uDfyb/WpmfsEqOp8i2GRi0iCEwSZ/ZGGcmt23WvbtyPDDA5sSUsmrz
	NH14/t1LyD4BzexM0neCI6paKxcp2ZsKdsHaQ1pHtEo=
X-Received: by 2002:a05:600c:3b8a:b0:439:942c:c1b5 with SMTP id 5b1f17b1804b1-439ae1eab68mr160890085e9.11.1740481483154;
        Tue, 25 Feb 2025 03:04:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW4QGYJdOf5T4Y3wYgYzWKvXZ19rq7KgZ0XHgM6DdrekdrQNp7EelFD973ZwHN2Wk7q7WBlA==
X-Received: by 2002:a05:600c:3b8a:b0:439:942c:c1b5 with SMTP id 5b1f17b1804b1-439ae1eab68mr160889695e9.11.1740481482789;
        Tue, 25 Feb 2025 03:04:42 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab37403cfsm12897525e9.1.2025.02.25.03.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 03:04:42 -0800 (PST)
Message-ID: <1f70600e-bb83-420f-98a6-b772781d5a3c@redhat.com>
Date: Tue, 25 Feb 2025 12:04:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: hsr: Add KUnit test for PRP
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, MD Danish Anwar <danishanwar@ti.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
References: <20250221101023.91915-1-jkarrenpalo@gmail.com>
 <20250221101023.91915-2-jkarrenpalo@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250221101023.91915-2-jkarrenpalo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 11:10 AM, Jaakko Karrenpalo wrote:
> From: Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
> 
> Add unit tests for the PRP duplicate detection
> 
> Signed-off-by: Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
> Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>

Only one of the above ;)

> ---
> Changes in v2:
> - Changed KUnit tests to compile as built-in only
> 
>  net/hsr/Kconfig                |  14 +++
>  net/hsr/Makefile               |   2 +
>  net/hsr/prp_dup_discard_test.c | 210 +++++++++++++++++++++++++++++++++
>  3 files changed, 226 insertions(+)
>  create mode 100644 net/hsr/prp_dup_discard_test.c
> 
> diff --git a/net/hsr/Kconfig b/net/hsr/Kconfig
> index 1b048c17b6c8..07fc0a768b7e 100644
> --- a/net/hsr/Kconfig
> +++ b/net/hsr/Kconfig
> @@ -38,3 +38,17 @@ config HSR
>  	  relying on this code in a safety critical system!
>  
>  	  If unsure, say N.
> +
> +config PRP_DUP_DISCARD_KUNIT_TEST
> +	bool "PRP duplicate discard KUnit tests" if !KUNIT_ALL_TESTS

IMHO kunits module are better suited to be tristate. Export the HSR
symbols as needed (when PRP_DUP_DISCARD_KUNIT_TEST=m) and add the needed
MODULE_ boilerplate

Thanks,

Paolo


