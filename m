Return-Path: <netdev+bounces-194755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C26ACC461
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 12:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B0E1651BE
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B751DF75D;
	Tue,  3 Jun 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMgSBBKk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01151C7015
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946847; cv=none; b=ach0+AtrmRhGFZXWi76kKb+XgHc0cYV8pCM2AiRf5NiUXWLIS1W7v72stioC4lxamXt18YcCWpgbFaiFg+Y+7LnQYqvC/Dfz78XmOKDF8vGJiFEQv2tDFn8RQQmCADIhLSqNy4UzP3qjtvGK1KAgtEXTsrtfKfEwnXZn4uj0d0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946847; c=relaxed/simple;
	bh=a70Bg4TxTGUH0mnu6b3PqDCP/iDyUy0+jkNeBE5HO3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iEpEeTKq+pJ0gzbPzxLS3T4PtnduR11pZ99SGj27KCIQRoWX2bJA6fpifivlPMS2QyzQ1bseI2TFFzsrHzVQ+CBYMrqfbEGTJ+9wjQUN3X0LqrY7khlZI+AbRJc8SX8tKuEf6GNJ4WcVGBg3eebUxD9ePTUkWV5iM/NJ6060cuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMgSBBKk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748946844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NlczaEApIN4sl+pxyBLL7DpTnisPbJmHNbDupcSccM=;
	b=fMgSBBKk9kFEWKnRQ2sMgEQNrvS9V8bz3lJXuuW5SrvJk1W6rhlLJFpMuQOZBjflt4bBaI
	FcmhHM8bmOCvMVy5lZp9PaqiWIcahPHDC+2hRfFQ2oz+rT9Dk2cXzEH0g4D0f2w6tYobfr
	5CfDOcVBcamlTPBmo90VMw3eEKo4oJI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-7xv7cXRrNtGoozp3oGF1Sg-1; Tue, 03 Jun 2025 06:34:03 -0400
X-MC-Unique: 7xv7cXRrNtGoozp3oGF1Sg-1
X-Mimecast-MFC-AGG-ID: 7xv7cXRrNtGoozp3oGF1Sg_1748946842
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450cf229025so15246555e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 03:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748946842; x=1749551642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NlczaEApIN4sl+pxyBLL7DpTnisPbJmHNbDupcSccM=;
        b=mcI8m1P1EDwcofwNeQjl2m0ImOGoASfnT2+x5Vy1bra9wGU6TkgByLtC2KTCWJ1/9U
         4V22YXu3iQeqQ5vLE2Ud0KJwhQXe+BjHfM2irt3bFr/jpIx1UWjOaQA/1Z81qes8TbRO
         46yA1VzvePBnqywNbyKT/nD3UV/aP0DnUdqzk4uHGVXDjos4Ev+u4qS/IWRyEHRlAycl
         qxUgvsD5iIYzfrld61KpCFVYaHSrVdFOWXEeTWwlVCDyopqd4e3ZYZqzwHL3V5g1jZ88
         q8HfLq6VAe+9+sR44hGvb3LhIrOb0zJ7QYaparDTbgmbyiTfkzYTTc2ei7d3D2F0PbMc
         r2jw==
X-Forwarded-Encrypted: i=1; AJvYcCWn93OISxiVteixRluxnQj5zuSsj+e8HGQqeHYKSkGHgPc/ez2/VGvRpH0nz3wYTzQLRt/JmXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ovJ7vXm0bLStr4+3hml3GgtFCkKKDdvoDmJFKOpZ1UkFO6O+
	0/VJ8lRw7LSbjeOtE+bYz5c3FnonCu0H0QQiLys4ZEh1P1MKsfRnE0BRybyJ/WPf3hVeIAlcE/l
	CtF4I6L4CH7UpZR0A1MLdSFX4G8AuOoWZ/FAIFQhen+AWCEZvjFHiKI0KRg==
X-Gm-Gg: ASbGncuZ/b3Y7MUPRe4R4mQDJPnDElrwAiB8PcGZrN2VTwTnj+i33jAlCUpp7ISkHy8
	7FiMR3X4Tauny8LOOoEYHRqLfk2J1vrYbkGAMLcqtZv0y0cSyub16cCBEZlUqj3ekOs+9TovZVc
	ca+frj4QfNJzcCFkjLOtQSBXNbolGJIe9yGBPOV5RIrerKBuPFofPJ782f6RUyL/PRSzrskdQOs
	enG2WjO7AoXQCMebI/FZwxEK1jfaMfiBplpKeSYRawypF3Qnjh0vg6WhwxZ+kzazqR02JQ520Wt
	U7p7gzHA1S7JGVhYSgJ2zK4a0yXaE/u1BtmlGd8mGqdx8HO1RD51Dm6C
X-Received: by 2002:a05:600c:5007:b0:442:f4d4:522 with SMTP id 5b1f17b1804b1-4511ecbaa8dmr103276755e9.5.1748946842055;
        Tue, 03 Jun 2025 03:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8ofIGLRe7M56un1ufgHCQKkJAZ+SFQgu857TY9WXLx25C1tILiQOTGP2WUr7Xym7aj/6VEQ==
X-Received: by 2002:a05:600c:5007:b0:442:f4d4:522 with SMTP id 5b1f17b1804b1-4511ecbaa8dmr103276505e9.5.1748946841719;
        Tue, 03 Jun 2025 03:34:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450dcc18a80sm149463925e9.38.2025.06.03.03.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 03:34:01 -0700 (PDT)
Message-ID: <3fc6e01d-64d5-496d-8be6-d449b7e65182@redhat.com>
Date: Tue, 3 Jun 2025 12:33:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUERY] gve: gve_tx_free_rings_dqo() uses num_xdp_queues instead
 of num_xdp_rings
To: Alok Tiwari <alok.a.tiwari@oracle.com>, almasrymina@google.com,
 bcf@google.com, joshwash@google.com, willemb@google.com,
 pkaligineedi@google.com, kuba@kernel.org, jeroendb@google.com,
 hramamurthy@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, netdev@vger.kernel.org
References: <20250601195223.3388860-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250601195223.3388860-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/25 9:52 PM, Alok Tiwari wrote:
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> index 9d705d94b065..e7ee4fa7089c 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -424,7 +424,7 @@ void gve_tx_free_rings_dqo(struct gve_priv *priv,
>  	if (!tx)
>  		return;
>  
> -	for (i = 0; i < cfg->qcfg->num_queues + cfg->qcfg->num_xdp_queues; i++)
> +	for (i = 0; i < cfg->qcfg->num_queues + cfg->qcfg->num_xdp_rings; i++)

Please note that num_xdp_rings has been moved elsewhere by commit
346fb86ddd86 ("gve: update XDP allocation path support RX buffer posting")

/P


