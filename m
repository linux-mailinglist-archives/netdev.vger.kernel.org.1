Return-Path: <netdev+bounces-176417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0FEA6A2C2
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B003189D96A
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E34F214A98;
	Thu, 20 Mar 2025 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZQCezAE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F051EB9F3
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463399; cv=none; b=CI2AblfCoMO5b0UPoxNav0OeqDOLVvW2kzWZ5XzC/u06NL00Je+lPP4fw1GYFpQtZylO9Neo27Ye7/qwumbvtwozK39Z75eucA6P3P1Tow8QLztmcTRkm4qzb/iSNtVhGqFb21ElJmYqfwQkqugRBLojbOOhtxeiAMqeW4OfA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463399; c=relaxed/simple;
	bh=DlxG7YItVNAR14j3bE60v7Fghkobcv7oaIEL+prOqt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qh5pLYeZqQD1zu/wZblq7asJ4jyPzfiOTtEya4L7OY8TyrFvfIk0QFcAnk+8RruFBpwsdrQzP6stHWGfm/cvhJtkmXfuNkp7Kn75Rs2bvXIy8hUtAJkiYRxF5YE0OpLQA3J7JmtMhSojzf7nM9UIJykrd6fbsj3CGn0zMjmSevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZQCezAE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742463396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYxh6WQJVqkRf5Me1BP6cV8WT9O8y3uSDp4lZNYQpYI=;
	b=KZQCezAEX0Nr53sInTNu+iASi+yoqz8ghsF0pVu2/aB92Z9ATNgEYk6Oc0W5mLdlOe68bU
	Eq8BLShbTgmskZn/+8Yx2z1W8sYojCLMgdpqUg5vg+b86vFelOWWnBWk4Kwu/o5zt5nFQS
	M5TxOgCeDrcXUAH/k0fvFWYoaYym/e8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-J6FNeAedMlq_G4UY1cgO6g-1; Thu, 20 Mar 2025 05:36:33 -0400
X-MC-Unique: J6FNeAedMlq_G4UY1cgO6g-1
X-Mimecast-MFC-AGG-ID: J6FNeAedMlq_G4UY1cgO6g_1742463392
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so3528475e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 02:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742463392; x=1743068192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYxh6WQJVqkRf5Me1BP6cV8WT9O8y3uSDp4lZNYQpYI=;
        b=tnaZ9PnbDcl+JNQixVPb1eTRlZa2dwvYMrsI77Dg93xWn8FkA+SHcA1LJykU/p42C7
         Mg6S7zsk6rvJbXukZRsA629wEzzpPXQ7HLxUuHjOC4JGjKTOZanaEfrpfNiLweSRbAHN
         nyVmwTta1oMGxPR2Cv5XPqwUfMUrmPnBieRNKEbMQXZltWwsMN5mRHbpgNpWdBJny4n0
         nzp8Eun7G2hE8YtH8ptawPwRtRezVArCbg3a170LqBLS2+vIjBlDfZiN5BYuNOR3/qWx
         2d+6q5K0s2JONhrQmsg73NnsKpQx4CqYitRj/5mWwFnxuG1PzCg85O6eYru3ApshyRIc
         nZhw==
X-Forwarded-Encrypted: i=1; AJvYcCWHxQOZYxGK8wbdfJn9LAQCJ32WW43k3jtwmlU7g2z0aaq4iEgFQquJNr9YP5plZlkzrqHqaTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3DM3/BG1JL/dvCwrtU2Il1pr1iC+hMDQEPHXZRP+Epj80FyJK
	EEOGM/mPO2WCXqRYXVMaaBakPe60ZoS5h+CP31cWvi/yXAh02IrCqyJHz5v/f+FvnSyvIYyWJki
	wJiy+5TZVtvs8S8HBvhj6dp6tlV2usBOj4AcT10fFB0EVDuao0AeJoQ==
X-Gm-Gg: ASbGncvU7JAa7kBlj0xh78nchYizEJKJ17oWN8lPtDY5tEdO3aLqbu70vZUV0siSrmG
	X/gurVhFSt6ZKFvkv/TJg7hIQHiv0m5a6Ejzy8ijHMMKEC6mTiYMLoyq++UJFwYsK8jSJXBBgsQ
	S73fmxrONYG1w1LmMYyN9qTSzlxhUzk3GNyUiT1bin7+BHlRa0bk7+deJHJooIux8Z3b9dXZTzw
	AUPb3lCJ30u46EBf7yBPlBxZGN8bkLepSlGIRzvAR5tFFAGANoJ3S0LYbRbUamV4a/gwDqozi6U
	KzjoGzb5LnCMdrTQJdJuqw6QolcMIE1j9KuDBEpUPAqOVQ==
X-Received: by 2002:a5d:6d06:0:b0:391:30b9:556c with SMTP id ffacd0b85a97d-399739becc7mr7042081f8f.21.1742463391846;
        Thu, 20 Mar 2025 02:36:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1kUXIYYSm+iNIAa2D/jbYS9WNcXjo97Rh5q0r+HW3IPJlyqoAmr7PwushWAWJ0lSQ82k5tQ==
X-Received: by 2002:a5d:6d06:0:b0:391:30b9:556c with SMTP id ffacd0b85a97d-399739becc7mr7042049f8f.21.1742463391444;
        Thu, 20 Mar 2025 02:36:31 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a32sm23631272f8f.33.2025.03.20.02.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 02:36:31 -0700 (PDT)
Message-ID: <c1b104c0-7b06-48fd-9463-9330b17678a2@redhat.com>
Date: Thu, 20 Mar 2025 10:36:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] atm: null pointer dereference when both entry and
 holding_time are NULL.
To: pwn9uin@gmail.com, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Minjoong Kim <alswnd4123@outlook.kr>
References: <20250314003404.16408-1-pwn9uin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250314003404.16408-1-pwn9uin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 1:34 AM, pwn9uin@gmail.com wrote:
> From: Minjoong Kim <alswnd4123@outlook.kr>
> 
> When MPOA_cache_impos_rcvd() receives the msg, it can trigger
> Null Pointer Dereference Vulnerability if both entry and
> holding_time are NULL. Because there is only for the situation
> where entry is NULL and holding_time exists, it can be passed
> when both entry and holding_time are NULL. If these are NULL,
> the entry will be passd to eg_cache_put() as parameter and
> it is referenced by entry->use code in it.
> 
> Signed-off-by: Minjoong Kim <alswnd4123@outlook.kr>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Please include the full splat for such UaF in the commit message

> ---
>  net/atm/mpc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/atm/mpc.c b/net/atm/mpc.c
> index 324e3ab96bb3..7fb854ea47dc 100644
> --- a/net/atm/mpc.c
> +++ b/net/atm/mpc.c
> @@ -1314,6 +1314,9 @@ static void MPOA_cache_impos_rcvd(struct k_message *msg,
>  	holding_time = msg->content.eg_info.holding_time;
>  	dprintk("(%s) entry = %p, holding_time = %u\n",
>  		mpc->dev->name, entry, holding_time);
> +	if (entry == NULL && !holding_time) {
> +		return;

Brackets are unneeded here.

Thanks,

Paolo


