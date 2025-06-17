Return-Path: <netdev+bounces-198607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C42B3ADCD4D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704C5400514
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020B238D54;
	Tue, 17 Jun 2025 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLctoOnB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BEC2E7169
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166767; cv=none; b=HJrQTpdpPCu4GgfJCvrdU2IC+m+v6ypUjtyoJmpyWlLWwF0WLg8MZTSlQkGTx67/WkQ9D/swPUsf0Of1CIM2oP/s8z6hENzK1ayZF1pmfRok4D5NnODQnFGQi3oBkWCbb1FIbxpsYQ9gLxGsCjNqYr4pvwkcPUjvh5M8PILg/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166767; c=relaxed/simple;
	bh=wmul7Zy9slwuN+Vr6FOy+FnDieNV9h6BmD+I3O/vZsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNmpaPzztO6WrVahKMoNxWCe3VRF47Uh/74WrSfJnv/nfmxasaeQE9+6PlVgS8qD66EGV0Ld/+4446W6p6mPsRcPNcTcU0dWjoOSAGOgkTEn7sffmYG9gQtL9n69N601KtYNVRGYmKLfoHb1LUapUz0EGLj002M4sTB9JS9Hq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLctoOnB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750166765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1L4C4BW3/woPtDTr9VLxob4MbjstfYncjP/MZGqNxKY=;
	b=XLctoOnBfQ5jLxT0ZlavpRaOsru9QRl0Xvf1AbpADgKbWb/bv5VSgs/yyEew7QXIMjMsPN
	TgE5FgOmOWbgynSbCUIXSg1mI10yo0307HJsVcTZxuXlJ6VQW1fowrOChiUcQHErpOQcjR
	jyZ7HePtwNhSuXleEc9sSvtuLHh05SE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-4Q-l8fqmMXWna1H17JJqoQ-1; Tue, 17 Jun 2025 09:26:03 -0400
X-MC-Unique: 4Q-l8fqmMXWna1H17JJqoQ-1
X-Mimecast-MFC-AGG-ID: 4Q-l8fqmMXWna1H17JJqoQ_1750166763
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f6cc5332so3254695f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 06:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750166763; x=1750771563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1L4C4BW3/woPtDTr9VLxob4MbjstfYncjP/MZGqNxKY=;
        b=Lh/rFOJLzklsR4e33chuKb6Yc5IiYxOGdOKE1hFw2irBkhLJW4GkKfO3KnOv0s7quR
         PyFMlvP2f9boQqDrI+8bq9zidX7STQwutNXQZFCIkC2WL3xzUzVo9jR9R0/+FgynrFP6
         BZ7hF1bRKviJscNR9DwzjjANVLQe+nQh5zU816L2tjTaJL8uR0hJYv0bOP188/A88HKu
         mdzpU5tsMxi/6cC3MY4kxWegw29jwLT334/Q93f08ZCGphtSW7TlqYAcsOYILzl/WNj5
         PNB+csh4LVYB1l4n6Tvx9hfORsJ+Xr1sABO1Cz4JSHMIu4CTIQOZL6j7XukJFtEydTiI
         v8Fw==
X-Gm-Message-State: AOJu0YyeqKhNp+SPeaWxL30VbUQAZJDOMkMI5AQLW2xA/cuNo7prEmDO
	/phYwUaYiKNN2NZ+cQt+XoaVac5gcwDk7kmvpNuH77pbg+ofHMqIx683+gpnXAnVa2k1rIXx+b4
	1k9GaXwwA1ICax/TN7McJPQvu91dT4q7R12v2BBH7+oIm4LHGZ6nqxJwm/w==
X-Gm-Gg: ASbGncsvhrtn1nV94SH65d5Z7FNeTevdNlxBnwJJVqD46JnM7/9T+rkUmphY95tI8A8
	yYyi5fyit8VQEyUMMll8jJRQbh0JiaebXsAaYCHbxVFU9qg1+JqfDJodA5LoPmLJfT5qfvTbUfo
	w81kryYRDp7dmY25bj6VYgDf8HuYebcbDqK9agQ8Q4diQd/1QunCwR9c7rYGpdBzHBzIugSmCGQ
	0vbzZWwlEzrw47zny3xhccbrvQvZUQnbtV2GV/NKcLzx/Txz9yFQ3/bFELju3NbstjSDUzlxdKT
	ce0uu9f68zfnoEzJeTAtypzCO06Fvw==
X-Received: by 2002:a05:6000:70b:b0:3a4:cf40:ff37 with SMTP id ffacd0b85a97d-3a572367b08mr9185811f8f.6.1750166762707;
        Tue, 17 Jun 2025 06:26:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZwe88v07R9w5tFE7VYLuW0TD7meelvS3OzaNFlAftRLETROLEQTnP4uruRDsE5Kid6kI3oA==
X-Received: by 2002:a05:6000:70b:b0:3a4:cf40:ff37 with SMTP id ffacd0b85a97d-3a572367b08mr9185794f8f.6.1750166762259;
        Tue, 17 Jun 2025 06:26:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10::f39? ([2a0d:3344:2448:cb10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a578510edcsm9959956f8f.8.2025.06.17.06.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 06:26:01 -0700 (PDT)
Message-ID: <df6b49bd-0faf-4c5c-a900-459e76f40536@redhat.com>
Date: Tue, 17 Jun 2025 15:25:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] neighbour: add support for NUD_PERMANENT proxy
 entries
To: Nicolas Escande <nico.escande@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, decot+git@google.com
References: <20250613134602.310840-1-nico.escande@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250613134602.310840-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/25 3:46 PM, Nicolas Escande wrote:
> As discussesd in [0] proxy entries (which are more configuration than
> runtime data) should stay when the link goes does down (carrier wise).
> This is what happens for regular neighbour entries added manually.
> 
> So lets fix this by:
>   - storing in the proxy entries the mdn_state (only NUD_PERMANENT for now)
>   - not removing NUD_PERMANENT proxy entries on carrier down by adding a
>     skip_perm arg to pneigh_ifdown_and_unlock() (same as how it's done in
>     neigh_flush_dev() for regular non-proxy entries)
> 
> Link: https://lore.kernel.org/netdev/c584ef7e-6897-01f3-5b80-12b53f7b4bf4@kernel.org/ [0]
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>  include/net/neighbour.h |  1 +
>  net/core/neighbour.c    | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index 9a832cab5b1d..d1e05b39cbb1 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -182,6 +182,7 @@ struct pneigh_entry {
>  	netdevice_tracker	dev_tracker;
>  	u32			flags;
>  	u8			protocol;
> +	u8			state;

I think it's better to be consistent: either store the full state (u16,
without masking) or a `permanent` boolean alike: !!(ndm->ndm_state &
NUD_PERMANENT).

The current choice could confuse who is going to touch this code in the
future.

Thanks,

Paolo


