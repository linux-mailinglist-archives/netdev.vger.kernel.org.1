Return-Path: <netdev+bounces-215570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA6B2F4BD
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7EA7283C0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3692DBF5B;
	Thu, 21 Aug 2025 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8CuMj+h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384A2D3ED2
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770318; cv=none; b=Ar6e8MxusZLkoMr2LByaFeR6hGNV1r8bPKa66rIocUwZCMxKRBlbpwWSwPffjqDA/SmO26x9UFp27qh/4T6NFitk7MBMaAkYp5oYrotNpR9DQCgFpJePV40J7Wyks6jLDStDiMv2A3xel4eKmGvdMee08E+4nwI9MIWcDE3N36g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770318; c=relaxed/simple;
	bh=XB3EZ8j7YkKt/8KMmdNXzNovgfdsgt6+zgy/CZv3JJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXrf4tyA0eJA8RQvcMiwRB9CIdCSS+98EER6DF7Lxxj/roS+H5hI7K/8g/0l7TlUceK+N+3eFZaR9hvQjoADALc/tvoajyRJsx/owyazsbokpac8N0+oRSB5/Vk0/TUBDu29GWAOFqZ7Vvouy0zbxp8cdYNkdGbs+pdn+m+8xYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8CuMj+h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755770316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwZfHOwRnxWIL8uIiY6ltxdcRFnpGdMGmzHCK8fkbdw=;
	b=Z8CuMj+hLXEdxuUUwxvWaTgwWFJpmn1hZ3ScMtJ+4+OmbJYDvaApKRt8LEkhfMompcLxZL
	18fly1k98Khd4910ceW87DGTgjz0z3OHO6cj+N+J+3sk27nDckGM6PlpNeQGh/j6KCzG44
	YAAkpSCaEBXWrkOE4tjOvDZgW4eJC58=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-WDL1iZ_lOhS6rBHASrWL7A-1; Thu, 21 Aug 2025 05:58:34 -0400
X-MC-Unique: WDL1iZ_lOhS6rBHASrWL7A-1
X-Mimecast-MFC-AGG-ID: WDL1iZ_lOhS6rBHASrWL7A_1755770314
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e87068c271so209905485a.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770314; x=1756375114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwZfHOwRnxWIL8uIiY6ltxdcRFnpGdMGmzHCK8fkbdw=;
        b=Tb1wo+bIDNzwBQ0SRnlUE+fGe/Wau0nH6cTJTMg0WjpQYpXjrMvpX2/yBojIZpbWC0
         uKZJJpFyY+Fd62Ypa5OWJJXk/maab4KxCRzUarQeQjjC1elPjl9UyEISKv0Ik61nDAvz
         hNA51REKLNdXBWj2mZxhn9HPR7q/OruX+FM1nYIqXVIA+kghZ03RnLg1j4AnfX6lqSmV
         /YHf8MUmH4holZdwdetctOjMTV8Hua4IilJPYitSahyiEHRar9yRK8e1fINlMBsfU2G/
         hVvt2IHZi7j8LGC8nOShi5infKc3HcXacUV8FdimZJbL/94ZxP9urDId5pLcABy4ZKHP
         GkNw==
X-Forwarded-Encrypted: i=1; AJvYcCW1jxkiW6y27Ka2V9rCVTV28DQMG81SttYukM5bJkrnBLAGxziND4wJom7Z7VWCTp31maLTz3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHKVWFjTeBk6aCaNh0pvh4Stj8AdRrnkIdxb9YykDW6+lJ3//
	XJL2pfVuHg+BrO7DgZEWYvQxpVrezB0XUGeckQDD3qynPxmBrKM0EDq5nVlnwwkPxmFYo3fZneh
	/KkzKn0ih8cLqsslLfl56+MUuzJn27bogDZW2i1P53/95hW262KXp1AAqRQ==
X-Gm-Gg: ASbGncvOD/RlbSJl/m/J4B4PJcflpoHhGIQIhEUnicX3OvC0bwb15gA+gjMtngrl4AZ
	yAytfhvaD6y3vruI4v5zEi6R9gKE+aVlO3nqt64jpSr3gdPPl66TOnO1hOh+qsXTzrFu006j9dO
	T//vORh7BWL/zo+S5nNqk4LPuYG84oWpYU4v6iFpRveqXQwHfxktm/n8KpXguyKjfxUPiO78/QS
	PkqLdAMjzvx81uTUdMYXpvBgVH4MO4xIxfJlTlcZBZZfeyHSBgC20tCSpJVJfrpuAUrM3P34rCQ
	eJuGoxTz6D/y6Btz3UNaoYrQAQux3WdZu2l+C9G7Y44PDLcvX9poJYxHb+twTDwzK1Yeb+JuwOQ
	piOz+ZzjMU8w=
X-Received: by 2002:a05:620a:2684:b0:7e3:4415:bd06 with SMTP id af79cd13be357-7ea08eae1f3mr155246785a.61.1755770314117;
        Thu, 21 Aug 2025 02:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsWc3ciqbgQEFg8G0ehzLsjXTh4Kzl5qlzMMp7q4LmklUAyDFZ0ouhZeqV9qbIQReLv+L30Q==
X-Received: by 2002:a05:620a:2684:b0:7e3:4415:bd06 with SMTP id af79cd13be357-7ea08eae1f3mr155245385a.61.1755770313729;
        Thu, 21 Aug 2025 02:58:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c42e5sm1091142985a.65.2025.08.21.02.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:58:33 -0700 (PDT)
Message-ID: <03c92599-00e3-4481-a97d-1acd901d0ac0@redhat.com>
Date: Thu, 21 Aug 2025 11:58:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] amd-xgbe: Add PPS periodic output support
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 Shyam-sundar.S-k@amd.com
References: <20250818115801.2518912-1-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818115801.2518912-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 1:58 PM, Raju Rangoju wrote:
> @@ -122,6 +148,8 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
>  	info->adjtime = xgbe_adjtime;
>  	info->gettimex64 = xgbe_gettimex;
>  	info->settime64 = xgbe_settime;
> +	info->n_per_out = pdata->hw_feat.pps_out_num;
> +	info->n_ext_ts = pdata->hw_feat.aux_snap_num;

Both pps_out_num and aux_snap_num are read from 3 bits out of a
register, and I don't see any check to prevent such values exceeding the
limit hardcoded below (4). Why don't you need some additional sanity check?

Thanks,

Paolo


