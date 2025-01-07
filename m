Return-Path: <netdev+bounces-155790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF79A03C85
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9644D1881570
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FED1EB9E8;
	Tue,  7 Jan 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUxNJEM+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50D1E3DD1
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736246036; cv=none; b=BW56quxRv3VXtUF5WQrz0JJkhek+jKtQATc/woeOpy8R2Br06REAAMM22isszDv25EZEAZHlqBO3CtMzM9/NJBOirScCHZp1q3rl2wdL1U6VYAsWCxYSE1LeMI0KX1B0dPg2lp22QM0hve2Xf3XZkjzXYGf/zgHo+/+XVNb6G9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736246036; c=relaxed/simple;
	bh=KlAnMVi7kxHbAL8i1I40oISbY1f3YUMzi5z+6Qx+sbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uz9+iuyZnNhvXebQMvBHwLAc8XYaAkMRNBdEOYUNfGj+bmtmYsq1jUUBiXD+jbkbgxduZY4Pcyq09g9N6dPi0NnJ3VlFPwdr1/RXKzZ94kbl9AXA9Mwe8Gbux2mdi8J1Bvaf/KskYfMv1Pn4X0VLAzarQmClwRZVF8UFCYH1X+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUxNJEM+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736246033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXzykKC742JQfA609u5R+N8edwL+BSb+rtg04e/FuHU=;
	b=OUxNJEM+YBmZUcbxaH5ZYjUHQNJCDKkPLh4yx3sME+eDVYEsJ6JKU6M4TjQk3Z/AxHZqsl
	k4LBFTzCtOeONdgGpxePPIAnhXLoPZiEbEirEyzJknkPIkgVEfT0/NU5iQxvNpGFWoM0Y6
	BH/BYQdlGx/JkuByFiILaokEZ/h/AqU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-p4tzE-X1NOmAV43QFWZxEw-1; Tue, 07 Jan 2025 05:33:52 -0500
X-MC-Unique: p4tzE-X1NOmAV43QFWZxEw-1
X-Mimecast-MFC-AGG-ID: p4tzE-X1NOmAV43QFWZxEw
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d889fd0fd6so248517156d6.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 02:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736246032; x=1736850832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXzykKC742JQfA609u5R+N8edwL+BSb+rtg04e/FuHU=;
        b=hFUc2itvSIKv9bilppGUCiboteDvJv4hgvY7R8W7m1vc9Z147yKU5PybCKplVTPz65
         jiSSWUNHOsof8H0EUCGcJ3oFw8491Y/GQebvuEb/Ss2nNJxOl5bMEVHI10lvhHVcNwv9
         a2stfGHdhDppx4+nTEKdZxBOhYRozkSSALftaWX3ddb1DN79bHOBL7oyZbN0yxNeqD1W
         jz0D3hQqDKVrzvQ2nXj9HaQPXF56W7tOg1n3fQUa/lO/r8BVn1cvOr9UIWnkgiugW4HZ
         UweC+erBXFnhTTG1v8TLk83FxbeaTewrx+iejychnYo7sluSBA2ROFAqzKFqVlg/hv88
         UJPA==
X-Gm-Message-State: AOJu0YwfPrWSGMREE3G2u8AzR5t0XLcCXFaWitNCzMyy04grupSiH1tC
	7krLxNtn4PjnBLTiAhudOikqyP+J2niNCUlwwskVfrL664DAoE1VYz6dvI9nuErPdplwrD9qfnw
	rha7fWpXHu0GPRHUryfKkPNoGOIV9LHzGwMYTV48X5drK57XtYF75QA==
X-Gm-Gg: ASbGncs25WElwc1HjS43cVhHQzSInKI4cIzHdy/AUMkNZzq6k/VpR5QJgKWLr2kLg2F
	8sgP+3BvuU0FC0Wca/Q//4507rG7O9AXKr2271QgOVooaV8eJl+qshwo05B3KRDs6O9oPZWlLWu
	XrB3FVHCa8OtMAk1i8KFtVPRq2J5WpLkOygeF7RaAJcPdAUcDzt3oCjjnOcPn/73SieVVHcqH2I
	b62s2hRsDu/JFvDBWo5cGzhJPav6mP/H5GelsuEN6l76JVCXvCy3+NeJARb2Pg5vKYidKF/i73R
	GGuhWA==
X-Received: by 2002:a05:6214:29e7:b0:6d9:87d:66f4 with SMTP id 6a1803df08f44-6df8e7d6555mr42405426d6.8.1736246032026;
        Tue, 07 Jan 2025 02:33:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuc8gM85Rz0pqiwUv6SELXbUVtH+oxBXwOqMwrOnkOqm7Ao0U0mNA9FBlHBQ3t1vLfQ3uKBg==
X-Received: by 2002:a05:6214:29e7:b0:6d9:87d:66f4 with SMTP id 6a1803df08f44-6df8e7d6555mr42405246d6.8.1736246031768;
        Tue, 07 Jan 2025 02:33:51 -0800 (PST)
Received: from [192.168.88.253] (146-241-73-5.dyn.eolo.it. [146.241.73.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18135f2fsm178644426d6.54.2025.01.07.02.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 02:33:51 -0800 (PST)
Message-ID: <964c1290-4959-4dc6-a203-16941e7de0a2@redhat.com>
Date: Tue, 7 Jan 2025 11:33:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] netdevsim: allocate rqs individually
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, dw@davidwei.uk,
 almasrymina@google.com, jdamato@fastly.com
References: <20250103185954.1236510-1-kuba@kernel.org>
 <20250103185954.1236510-5-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250103185954.1236510-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/25 7:59 PM, Jakub Kicinski wrote:
> @@ -682,10 +682,21 @@ static int nsim_queue_init(struct netdevsim *ns)
>  	if (!ns->rq)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < dev->num_rx_queues; i++)
> -		skb_queue_head_init(&ns->rq[i].skb_queue);
> +	for (i = 0; i < dev->num_rx_queues; i++) {
> +		ns->rq[i] = kzalloc(sizeof(**ns->rq), GFP_KERNEL);
> +		if (!ns->rq[i])
> +			goto err_free_prev;
> +
> +		skb_queue_head_init(&ns->rq[i]->skb_queue);
> +	}
>  
>  	return 0;
> +
> +err_free_prev:
> +	while (i--)
> +		kfree(ns->rq[i]);
> +	kfree(ns->rq);

FWIW, ns->rq is allocated with kvcalloc() above. kfree() usage is fine
but makes coccinelle unhappy. Perhaps worthy switching to kvfree() for
consistency with the existing code?

Thanks!

Paolo


