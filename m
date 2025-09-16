Return-Path: <netdev+bounces-223384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61233B58F1A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0128A1B21FDC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 07:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE92DECA7;
	Tue, 16 Sep 2025 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inve8oDT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FDC1E7C11
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007628; cv=none; b=GAZc3enxe1HQyDl+/Lcm6zWdK+e/2RkMgXQP8q/6b7GoBuDmVGje6h/vHmUGzHOHY9ZrOkRvSnaamAjauVUgxQYS69EuNAF3PyXrun/BykyvtZm31AGkzxGYcGZu1tGIZhh7Q5V7K8ErCO+duz00W+miRkIKfOVKmicatTYXIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007628; c=relaxed/simple;
	bh=htOfm8j7PlYmW+Rtnd6y64tWH84Zol8cuOy1gjAKTdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlLwBDTPBi0yJcSWFkJ/DeTU6HDN+ltoxlZWFYMoQO9NapW2KJTV+exUNnFsys9XYvkJPqepotRjAiaYrIwY0a7QtTkNRU7tOuq+bLdzOc55tZY4fmMXZkL0tqky4OhwDxpwApjgzgPIWHINoNhqBESFbjoXJOUvH2RcHfZGOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inve8oDT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758007625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQlBR3Ghy71nnh5cM51WxMkelbcbsWsb/Ar6LR06Y2Q=;
	b=inve8oDTPaSwgdNt+bD3ONloHlth9Bv1cPPUs2iUYEtw9L0+LU6bXUW8yeluziv8ktYsZy
	kHyUvIWVD0t2MrbWLXRYAZWBet2Rh6yKgX4XzrtG6JMluGpWz3cNXdfQVJluoL3yIZpcie
	RyEVsV0WUUwb/gnD5D1NT6rRfzE1O88=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455--jRnJBVYP5-jpKxXmrP8tw-1; Tue, 16 Sep 2025 03:27:02 -0400
X-MC-Unique: -jRnJBVYP5-jpKxXmrP8tw-1
X-Mimecast-MFC-AGG-ID: -jRnJBVYP5-jpKxXmrP8tw_1758007621
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3eb5130a9efso1041330f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758007621; x=1758612421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQlBR3Ghy71nnh5cM51WxMkelbcbsWsb/Ar6LR06Y2Q=;
        b=IJaLtI7J95y7dwb1qzB2s6BYfjkXxacYPYnU54JwP1rDMn0NC5XQ+ipu7hjaBCCkN7
         581NwIdFSr6orOfI4N1Aezy+MGwdkpmVXEfBSwTC85Y8+scc7CqJrN+9LSfEIUBX7Kfz
         a07CdZL+oDGa5esW/eYI/ahHDVeSo7UUDNGJujwUrh51bkJrYI4oTIGfH0gOJBrY3AC8
         ACtjY3BRu70Y3fI/8nbLV2PzY0JUqbnFUEUNkOPOwd26HO0iFoKva7aGEEzwaQq5ZLUR
         L4CAjFLTGenGUz16xB6AnLBifKY/DaZSiywCAhnWTFk5CYSwlATXuYDm4uQEhODgwIEB
         GufQ==
X-Gm-Message-State: AOJu0Yxca98D7Kx/3BHfxCpqiLrhLuYQ/S66lLl4kPbS0dWhe/QYUjRG
	epQtkS/9OF4PXxdKzxnjP19Qn1ImAuJ5rTK1/1U1on3mKHJcJm9K/GT5qn8Edg6iYbIBEcQpeMK
	ZRVPEBBDaeSlJRj8pUbxgVVOoPgh4Tu6z2oNRpcM9TSrVtony156D5IwciQ==
X-Gm-Gg: ASbGncuvNxevzbKR3AdV/S+D1k/fmC8ZO4iTdCTEPznsalmufhjeYj0CoVdaoCilf+o
	dYUOTJouJHKCjtRbUgnGi92uoEyrxKLvM9+GJabbQ33l8/Lke4LSYnrR/ICqK5MjLZRqqRlhN+r
	ezwMWcE63JSFn3Jc9W3XDZAZ5ujESuXLrAJwJ30JDty2DnlnyFFgy/chMHB7tc1T1OR1F3R+IRY
	fCpBOJWhdQvzscJ8UF6gQwz1E/Qr71Rxadl2qm00IdwCqF+CGM1Eb1H8xXwQovYxnSBTU4f6S1E
	tChgchf2m9dkGS06RVSCfUdZlHVzNmo9svfuCgq17/rdxp8uYOQnhM9KxZvw4z1X4wnuZO1PvbG
	2VtoBVU9kZAfx
X-Received: by 2002:a05:6000:230c:b0:3dc:1473:18bc with SMTP id ffacd0b85a97d-3e765530b01mr14340683f8f.0.1758007621129;
        Tue, 16 Sep 2025 00:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF76mdH1F7YkVaHYliiYKdHsAOuurIWZDmAUIcz0ScWM+ITeIHhPj7ykJOrTPhRcYekt9Wg4A==
X-Received: by 2002:a05:6000:230c:b0:3dc:1473:18bc with SMTP id ffacd0b85a97d-3e765530b01mr14340658f8f.0.1758007620725;
        Tue, 16 Sep 2025 00:27:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775b13sm21221325f8f.10.2025.09.16.00.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 00:26:59 -0700 (PDT)
Message-ID: <060281aa-0511-4ebe-829e-b36301c417cd@redhat.com>
Date: Tue, 16 Sep 2025 09:26:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: fbnic: support devmem Tx
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, sdf@fomichev.me, almasrymina@google.com,
 alexanderduyck@fb.com
References: <20250911144327.1630532-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250911144327.1630532-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 4:43 PM, Jakub Kicinski wrote:
> @@ -574,7 +582,11 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
>  		desc_cnt--;
>  
>  		while (desc_cnt--) {
> -			fbnic_unmap_page_twd(nv->dev, &ring->desc[head]);
> +			if (ring->tx_buf[head] != FBNIC_XMIT_NOUNMAP)
> +				fbnic_unmap_page_twd(nv->dev,
> +						     &ring->desc[head]);
> +			else
> +				ring->tx_buf[head] = NULL;
>  			head++;
>  			head &= ring->size_mask;
>  		}

Why you don't need to avoid the unmap in the DMA-error path in fbnic_tx_map?

Thanks!

Paolo


