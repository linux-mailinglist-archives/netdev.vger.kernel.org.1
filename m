Return-Path: <netdev+bounces-176314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8144A69B3D
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B308A87AC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02BC219A97;
	Wed, 19 Mar 2025 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0xiSVGQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88B219A67
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421074; cv=none; b=PWz47THBdwAo/VJlPL74wZwvYCy1eipCBm33az3xav/tww3jp0oPXl+O4Sz3y0AZR7eZMxf1JxPpchzcLnHAK+anziwRUZw4utTd76HCrjXxaaOIqcooKuLB/uAcGIrBOT13CCWEBXb7m5H0YJNpuzNvaeTLezUClC5c7WwozfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421074; c=relaxed/simple;
	bh=9AcDbLMxeWpZbncq8GxGRZQgFvTcdZytYIEX2q2FJOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIMWWpJ3ymEbXbziSZ5t/qRuIYcLtGxhLeKJXCx5K/ccXgWzz4oq7Y+WmzaIyswpeYtFNQq1klarCQcNaSRd9elpbcDgkhACSkNbjaLOXXbGaRTXtMarnKnq1dLdbsDsADWs7b2N5QFbQqaNlLB9lpudtLNqwu/0jd0/Kls4BHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0xiSVGQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742421071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTBfEOflOyN9LSTymaLKZz6lkixLefi6Hp47M0DpKrc=;
	b=R0xiSVGQTQPFIVLr/wWHCP3h65aC4sxPp7YFJ9hwBfXAuso8L3mnY7jo/XXw1Uv6gRsbVz
	1Cz+lIPzn543AU3CuA3sNi+ER7E+z3yhuVOdha4aj8Hr4PawtcBfgCjmIgYHKAHXyJLC7J
	hcA38qZd04ky7vwALq6lN0/KRk8gTJc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-BHp23ZJ9PZKlLwfb70mwpQ-1; Wed, 19 Mar 2025 17:51:10 -0400
X-MC-Unique: BHp23ZJ9PZKlLwfb70mwpQ-1
X-Mimecast-MFC-AGG-ID: BHp23ZJ9PZKlLwfb70mwpQ_1742421068
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d22c304adso5305645e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 14:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421068; x=1743025868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTBfEOflOyN9LSTymaLKZz6lkixLefi6Hp47M0DpKrc=;
        b=WEvtUlCb+LqTpf7mj5tOdJXw1iDyzr9pMAvtnQWr1pnMyvnUqxlcvLos11oH5UIOML
         4i9R7TDWT9jh18qI8iRNFgR6AjhkOriVdPXaZ4V+e8PIWpd7pa32ZBYBENWX8jWoxyXY
         AmGgupNcnNAr24Uf8I2WKubA0X7E4C8fOVE3FJYT4b18QO1rC11CROuCoCFJ8g2GyYCF
         Twe0IIskNokMUBSq6LTXXHAyY/KWCBbJtzZ1CTFjZyLB276SlNQt+1zvFKmqxzl9KSq+
         wnSeSvbzgJMeGH8RTFRwi+FDRpfPl4uIf2khoZyNnsTA5LQ3iNKONGcu5N/pSda9ydZG
         f/Ow==
X-Gm-Message-State: AOJu0Ywk3oJFTn9eL/FNQV0Xss/W2KhjskTs89orcJS1+erBeknitats
	IZR2DAKEaKtZM+PKLxxo7VJ3VIwfZOdtLydtKZRPj0I6wGJZPBdkazMD3R03nCICfmJMuOgKRkk
	DWwMR1RyaMWY1ovyHSTvmVz3vANZrE9JLX947yPUu43Ql2SsJu2W9DA==
X-Gm-Gg: ASbGncuGzg70UYIqEtqEwHzcR6bdJCc1dI53a4rgZMEjUmImtOV5eqTIuV+WcGZ0gso
	FL92H9ODzAQT+qO3VQvqKYACM/4o8q/+2WJwX0FcMS8oWXQnWVzhEKvAyWcvMbVoXoO3WG5CgTc
	RGrhQIZ85+DU5WuUVQ3VMWrhDC5IB5LLvZVDXdViU8H4IsQlqgz9IfffberJaQNKv63PEHVgvJB
	VsqXxPBmguVaVirFbKJ75LGOlI4HV2H0uusbqh9WSIywwUzbBXX1qBXmqHA/dd3fYldKVSaY4Vw
	fs/8W35/JIS5uiF3l0oyxGGzisTzgf2D7g2l0VY+h0c00Q==
X-Received: by 2002:a05:6000:1a86:b0:391:2e6a:30fa with SMTP id ffacd0b85a97d-3997959cc2amr784896f8f.27.1742421068023;
        Wed, 19 Mar 2025 14:51:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU2w0WSmJqJ1ufbRJ0ypCJuntkV6cjNYBqt4Gss5MO+N1ZPZ9SWHPK8nxdfnD1FqbinTU57w==
X-Received: by 2002:a05:6000:1a86:b0:391:2e6a:30fa with SMTP id ffacd0b85a97d-3997959cc2amr784885f8f.27.1742421067595;
        Wed, 19 Mar 2025 14:51:07 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a5fsm22355449f8f.79.2025.03.19.14.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 14:51:07 -0700 (PDT)
Message-ID: <5d8c2b59-44ba-4444-9cd5-5ba70ba55f32@redhat.com>
Date: Wed, 19 Mar 2025 22:51:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/11] net: designate XSK pool pointers in queues
 as "ops protected"
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, sdf@fomichev.me
References: <20250312223507.805719-1-kuba@kernel.org>
 <20250312223507.805719-10-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312223507.805719-10-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 11:35 PM, Jakub Kicinski wrote:
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 14716ad3d7bc..60b3adb7b2d7 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -279,9 +279,12 @@ static void xp_release_deferred(struct work_struct *work)
>  {
>  	struct xsk_buff_pool *pool = container_of(work, struct xsk_buff_pool,
>  						  work);
> +	struct net_device *netdev = pool->netdev;
>  
>  	rtnl_lock();
> +	netdev_lock_ops(netdev);

I agree with Stan, NULL ptr deref. looks possible here.

/P


