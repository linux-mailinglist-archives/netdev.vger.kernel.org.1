Return-Path: <netdev+bounces-197716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EB2AD9B07
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 09:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2B93B6799
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 07:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2AC1C5489;
	Sat, 14 Jun 2025 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELGAvPxV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B23D984
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749886066; cv=none; b=qemSkJp3dNMoREH1DlZjsEX7JBRtLURjcmmTKPQN5LztN9OwIlYqK+XrwTCuxjDhk3+ENjRAMtYiJYP5X3RwbLwYf4AwFcSFql9+sUmXIKhB0pkEeKp3hHMe9dP6r93Ek3kudNoTKAsg5DY66b8az8NzL84iPl9NJUnSwzs8CAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749886066; c=relaxed/simple;
	bh=pMw6KTpW+5GQIcfQZOSIRahw7CmHruf+yFI46H9N3+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erpTmVBU7bxApR4uDq8RtW9OVgxQQuoMQL4/VwAj6GUEQYUdsvQjgLxlGas0YylFD3wHwUAhtOf/yctJMJQ1FMk+56Zy4GeplYz7bF74bjQdqB96gEAX14Afv1I8DORWQ6TQo7FHrIqG+NcPS4QJc38SO8XueUalX2aYzIxgKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELGAvPxV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749886063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tgTx+FSFOgAVr4S8eRgbVhbYZ47XLW56zTNKjJNZmA=;
	b=ELGAvPxV1txwbccSkULgzTy/LZEP7ukAWg96z+sVEm4ZqgIBUAJedAy8xWFXvpkwPikd2w
	s8Uq1JvRzICvSqoiKAdV5O9FCmoB6vHuBM9dkiONuSz1sAtjdNpm76XjlWxQfaNFsK9zhV
	0XjUAM/a/WmwmL4cjMNmlNB9YALy3HM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-kw3CRoaoPYyx9SSchCVLhA-1; Sat, 14 Jun 2025 03:27:41 -0400
X-MC-Unique: kw3CRoaoPYyx9SSchCVLhA-1
X-Mimecast-MFC-AGG-ID: kw3CRoaoPYyx9SSchCVLhA_1749886061
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso1283554f8f.3
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749886060; x=1750490860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tgTx+FSFOgAVr4S8eRgbVhbYZ47XLW56zTNKjJNZmA=;
        b=Ohxjk3Ti3VemGtVNCia/J5rj0x/z7G3khpoZkVOJbDv9sC6wcbJhtFlqrQZsjQclnC
         mhIS8s2Wsq+kiWCdnb3KmyVfaiRJBZWCSnK30oTNLzvuPDiBqtzm5Q0/egNZpJd/WSi7
         ga1FWCXEm1bcO0c+je3CgE3KIeK6fjuqzhGeWsbM0UYHo/4dawQgl/FNltNu5San9F8I
         UCEvdnFJuzip6zYKkwa7Rsd/lF/iZdvnQFytluL3u2zEDae/XpL8jfCyBiDtU11jb5m9
         hOc2TGqANVOFg8MXsGr8sjCJYmkpckpynma317tlOTdgn45a1KcCNtZdB7J9vGPajz+G
         aCsg==
X-Forwarded-Encrypted: i=1; AJvYcCUtlS7QrjqhUkwu77i0Z8K8DvkcyZ6Wye2VOo9dESah2YtPh7xVhORVYnfcNv4CN8mn6GRkzCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1W949bJxmvyh9ZRjYo9/aqdPQkZdntw95IQsJ+/cz7GwR60W
	hdcBzxNeEFlbmuOAZEmVIxaX5Whvrd8ZSb52P7rK38s1RLtJCqO31TtxIK0NsOuTc2vc4JjCKnJ
	jy76BmBHmpcb4alEhVmvPkkGpqH0B99M6xnDNe90I1DaFauaGIliNGzNpPg==
X-Gm-Gg: ASbGncumvLeQ35L8niD6r35eThmGeO7yRDX2vtUiWBpcYyQ2cQeBgeuxUIVj+jBq9Ly
	33VvwO05tgoPilfByN/VG7uyeSOgRSWO4Q1828BTjfAvc9Eg6vaH14vGgaAZVHRBifXb1pierh8
	nkJGuwCDgdkTBC6LPTGNx1Wwtx0foVylFt8CLhFzI3hDeMHmsGw6NRdDbyTjjPG/bfS4swBjqk7
	HQVR8vOqd/HR1lGWWtTxRQGYQuwYuxsWxVPesL9mPEIY0BWcrEKf/tniss7zXrEn13oQdWD8R/o
	j92/7Qub2svJMYqVy75mpSSvNn/8X4L35qKPuvZfMug3e8jsEREgyuNO
X-Received: by 2002:a05:6000:178e:b0:3a4:c909:ce16 with SMTP id ffacd0b85a97d-3a572e92862mr1966945f8f.49.1749886060608;
        Sat, 14 Jun 2025 00:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVqbzbF4duwLWA+nfDNoKtgT037HrMx8BxEUzQCGK0pWingKaV3bRhxJU6znPwPYUqw5Vqiw==
X-Received: by 2002:a05:6000:178e:b0:3a4:c909:ce16 with SMTP id ffacd0b85a97d-3a572e92862mr1966925f8f.49.1749886060143;
        Sat, 14 Jun 2025 00:27:40 -0700 (PDT)
Received: from ?IPV6:2001:67c:1220:8b4:8b:591b:3de:f160? ([2001:67c:1220:8b4:8b:591b:3de:f160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b2371bsm4490410f8f.70.2025.06.14.00.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jun 2025 00:27:39 -0700 (PDT)
Message-ID: <78d97778-06ec-4080-a9c3-19a754234f78@redhat.com>
Date: Sat, 14 Jun 2025 09:27:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 3/8] vhost-net: allow configuring extended features
To: Akihiko Odaki <akihiko.odaki@daynix.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <960cefa020e5cfa7afdf52447ee1785bedea75fd.1749210083.git.pabeni@redhat.com>
 <0497f70f-3c6a-4ecc-97e9-4487b3531810@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0497f70f-3c6a-4ecc-97e9-4487b3531810@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/25 8:16 AM, Akihiko Odaki wrote:
> On 2025/06/06 20:45, Paolo Abeni wrote:
>> +
>> +		/* Zero the trailing space provided by user-space, if any */
>> +		if (i < count && clear_user(argp, (count - i) * sizeof(u64)))
> 
> I think checking i < count is a premature optimization; it doesn't 
> matter even if we spend a bit longer because of the lack of the check.

FTR, the check is not an optimization. if `i` is greater than `count`,
`clear_user` is going to try to clear almost all the memory space (the
2nd argument is an unsigned one) and will likely return with error.

I think it's functionally needed.

Roger to the other comments.

/P


