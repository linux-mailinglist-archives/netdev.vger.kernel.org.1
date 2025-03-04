Return-Path: <netdev+bounces-171579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F99A4DB3C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2FA7A23DB
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CF1FC0F0;
	Tue,  4 Mar 2025 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbYGPFH9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7889E1FECB1
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085275; cv=none; b=QsyrgbKHoC/zlYpIh+9DBQujbscWVUnsIk/w9K/uGrLDF7nq6G0Tk0PvOJikuP6Iebv6iUAUjqBCvMqDakwn8WIGZI+VdVfcA0b2Io2fzfTaU1u0LtGWb0ZYS/9cm4XfkhBL1wlNKG1uGagwopwCbczsMOXF4+b5v5g5WwhD8w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085275; c=relaxed/simple;
	bh=GDHmLRbpTAvcpqKY9+nVbCg+pOeoBmL645S5vBz+z5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejESBZ+BiUYP029+IoMXJFVSdo6t5edobHMds7rwybH608Rccg5xLFqBNw29kEoRtSYqSSbQkteb082SslfyVYctsNqil0yxHTq6un9KX3lx6z475Y090txzquTV8hlC0/5L3ha34J9N2EouYShC3TXd2Br4NxqTJy4YPAya8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbYGPFH9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741085271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozWRlkVvFvj5lU4SkREoIbQWM7uBXzxDwOOcUPy61o8=;
	b=CbYGPFH9HF/P9vnZhvOw8aIySlXVTALl6LZm9cpmSEB/Pe7W8F89PgsFmFI8icafmBLxOu
	sDaTRLcjhsanjpNgtYcasDHClqaiwr4xPU959j6SpcOHj7cDfWXiQQkl8pQEJYiWyZYvj3
	eWKfz3zaTiWl4ksUYzGveMVhCn2+0m4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-xD7SaTAPO-e6Cbz4gJF6FA-1; Tue, 04 Mar 2025 05:47:44 -0500
X-MC-Unique: xD7SaTAPO-e6Cbz4gJF6FA-1
X-Mimecast-MFC-AGG-ID: xD7SaTAPO-e6Cbz4gJF6FA_1741085264
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390df5962e1so2652986f8f.0
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 02:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085264; x=1741690064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozWRlkVvFvj5lU4SkREoIbQWM7uBXzxDwOOcUPy61o8=;
        b=nwifDJ69YatDtInRq5W40fKdA62gK5oobmsfR3X18AVIAZeN81iLmVcYfp5z7n1FkR
         /HOhVPPgQPWXt3GhuNN4K+2wiZHwCrCPdsf1zCsiClBBSxpJThdKC8NgwxMt5Jt5kyR6
         pGOieJZLd5UFMvxdEz6TVbh5CbIz8Vv85g1HyEwY03LHQiynn2weHoDpvzVt3RwTdDp5
         ltZ2gWSR8lQUrBZrsZ1D1wgo5TpwO1v/8d8JcznUrAcapMjXKIwmX8Hco+2naX7zv5Dx
         GTe2lpNY1N7X2NbOqH+MkCtyiQ2JYOjKs4jHGkxo0O5fw+ZeE+X6mTJfoDs4JesO4H4U
         aZnQ==
X-Gm-Message-State: AOJu0YyzaIskaqvO/TtfSA0DzEdZ+qqceEA9LvdUc+tRt3oYF1zAx+5X
	uAbGGcG/Elp738WK9ymIpNMpHmb8POnYCrfXuquI4rACe6Fy7vO2UVqzUQW7UM9Bw0zD6jfMRIG
	Bnu9OfMrDnSfvZJ5NWz799y/mTyJuK/ChqcQRyauauYjYbCzyu6JLBA==
X-Gm-Gg: ASbGncvsLqvAckZe+MKLw+ekUW6Ft5XMaQ1d5loEveLdJ0KsCMaf4I6oCnHPaylCsrf
	wjkKVYcLzkxnEiCrsahc1jajRG8K2vC+EFEjGlJCD7lZf8V3LeHpa8NubMqV7ZRirO7CS68QD21
	o7YnOBke6iPBHCJVGX7BaKC7ENxAFRVNDIwaueevV3UO6xnFFkwgrmpiv2s8wUyuA5XULn9++Th
	7ASrvpfMwzU1DEAYGIXeg1mMqNc51lijsX9i8gB7nvsKn/I6GUO7r3Nx293z85kFkbF0i2k7lh7
	SwRlpkcGdZI1YvRJoHeRf5vUUt83r2rE0CBUTG8QFXxPJQ==
X-Received: by 2002:a5d:59af:0:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-391155fff3cmr2199365f8f.11.1741085263743;
        Tue, 04 Mar 2025 02:47:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKsGGn0f/jRHWk1XXNEVK6OtmwuK7qRmHXGvVjX+OIeWT8bbXwzK3XUIPqKMexSIXmBvuV/g==
X-Received: by 2002:a5d:59af:0:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-391155fff3cmr2199340f8f.11.1741085263363;
        Tue, 04 Mar 2025 02:47:43 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6f22sm16984595f8f.47.2025.03.04.02.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 02:47:42 -0800 (PST)
Message-ID: <b16a716e-69e3-406f-a0f6-1d62cfa39c42@redhat.com>
Date: Tue, 4 Mar 2025 11:47:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] enic : cleanup of enic wq request completion path
To: Satish Kharat <satishkh@cisco.com>, Christian Benvenuti
 <benve@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>
References: <20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com>
 <20250227-enic_cleanup_and_ext_cq-v1-7-c314f95812bb@cisco.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250227-enic_cleanup_and_ext_cq-v1-7-c314f95812bb@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 1:30 AM, Satish Kharat wrote:
> diff --git a/drivers/net/ethernet/cisco/enic/enic_wq.c b/drivers/net/ethernet/cisco/enic/enic_wq.c
> index 88fdc462839a8360000eb8526be64118ea35c0e2..37e8f6eeae3fabd3391b8fcacc5f3420ad091b17 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_wq.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_wq.c
> @@ -6,8 +6,12 @@
>  #include "enic.h"
>  #include "enic_wq.h"
>  
> -static void cq_desc_dec(const struct cq_desc *desc_arg, u8 *type, u8 *color,
> -			u16 *q_number, u16 *completed_index)
> +#define ENET_CQ_DESC_COMP_NDX_BITS 14
> +#define ENET_CQ_DESC_COMP_NDX_MASK GENMASK(ENET_CQ_DESC_COMP_NDX_BITS - 1, 0)
> +
> +static inline void enic_wq_cq_desc_dec(const struct cq_desc *desc_arg, bool ext_wq,
> +				       u8 *type, u8 *color, u16 *q_number,
> +				       u16 *completed_index)

Please avoid 'inline' function in c files.

> @@ -111,7 +81,41 @@ int enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
>  	}
>  
>  	spin_unlock(&enic->wq[q_number].lock);
> -
> -	return 0;
>  }
>  
> +unsigned int enic_wq_cq_service(struct enic *enic, unsigned int cq_index, unsigned int work_to_do)
> +{
> +	u16 q_number, completed_index;
> +	u8 type, color;
> +	unsigned int work_done = 0;
> +	struct vnic_cq *cq = &enic->cq[cq_index];
> +	struct cq_desc *cq_desc = (struct cq_desc *)((u8 *)cq->ring.descs +
> +		cq->ring.desc_size * cq->to_clean);

I think the code would be more readable creating an helper to access the
`cq->to_clean` descriptor.

> +
> +	bool ext_wq = cq->ring.size > ENIC_MAX_WQ_DESCS;

Please respect the revers christmas tree order for variable definition,
and avoid empty lines in the variable definition area.

The above also applies to other patches.

Please include the target tree name (net-next in this case) in the subj
prefix in the next iteration.

Thanks,

Paolo


