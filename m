Return-Path: <netdev+bounces-230019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F83BE30C5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B17DC4E0F27
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC03164C1;
	Thu, 16 Oct 2025 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NjbsrNeS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CC2E172E
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614028; cv=none; b=Z+Iz5n89xkgyjeYG9hJ4wKDEaCw0mL0onc5s5SPBujYzf30M2FX6PMoXupmTshkJYCEtj+0daUSd3uM/kYggbAa3aVW899ztOkUUSbgRaSLzCW2+7GGZ2xfPnnhBgpeFKtKxPk7nXbZEc6tZ+nu0OKLOmDAi2uOHlPKiuLfMYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614028; c=relaxed/simple;
	bh=rOYcDSrhRWLgtnzpoeHuge7O06Ip2GR7UW51Bh01bCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWQPSMP+33xmgobIJBj8me3XIf5TUdjvFNlpJG6MLtBdNiEePC2Jn/9Vki6SOHiwPAC35mUBjdmR895rpRhZEf982YLRbPjjn6YWa1/ZWeFw3FyzWL0FFKAqwMULPs5dkujBO9D61CbvAitTUtwAvAFouY2dnLhFkh1q0NPhfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NjbsrNeS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso5676175e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760614024; x=1761218824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S9hYzjpUktnCETUL8826o3/CkmCIwf0/rTKQ/FR1f+M=;
        b=NjbsrNeSpJ1RJxnSHSXWFZR16nyPfWuxIv2onWfekEwqQamNRboNFm6T0D3/k+X0ts
         9b8VPZkdNOYvMVp5bq93V1xWcQjQ/t16kKPNKSYuutTtLcISzQgg6ofIMq6ZzMUeB43F
         CacM0/EW/sS8Rhb68TO0pGVF0CsqmFcXioQS23QLIvJhcGqIpidlWcSx3cOC/358CgyO
         +tMbD0f8qXSoj4jnDBOfJSHHq/lxW5oPa5wXi7d2xO0oqJN3eel7M6dwjw7P3Ajy0vOf
         wkegVFKuZO7mHt3cVD9byoaXgYG73UCqZm9cl0dQizCRDQ5DfTbi8m4QFm2mXIuPGXlF
         gfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760614024; x=1761218824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9hYzjpUktnCETUL8826o3/CkmCIwf0/rTKQ/FR1f+M=;
        b=ZxTCyW8rc4LlsQcRvy0S4kaX9rTW+4ZunS1jc3DdGigQSIev5zPyFH9ZIx5te/T1B8
         66fcdLx4iIViqfOnkdvN2RboZ9GXuyl7/WbQHyOIe/zZGcj0Q/FyjbHA/63sst7442a9
         FkFDyjgImN91p4PwJjvAcFwUvtgPOEOySzBWDRGlseS92iODilfCWUcUVIVnRerRdFBr
         dHFUE+HOcsWauzNc3yN/0tS0MZU6csvaW6+12DgzvSQHmGG4Qc8DwcXlu6JtiwN+q3FZ
         cY60eAFcoHDYRvlpGQOH+To/U1+A2unIo4HtQ6eSb+48mhEXnOTgr2yvEvYqpUd8KRyF
         uRmw==
X-Gm-Message-State: AOJu0YyUt6dp6ruMMGhKyX1Ks6AalQVfJxwKLWZ39GznWZ2IHRMKHw62
	yvbEYgxa9A6ZESrF5i8aOFBB3FlQO0zi3z9o7xSyrgC7E6j8SF+mwNfkE516k/Ix2ZU=
X-Gm-Gg: ASbGncvE+oHIlHLnguf/g7BHkPHtxX8ZNBERiWTsZMzLmM59Osg0Rg1kll6YbCtqeqd
	/K3aUVDpaAcQjyyMNSswaTZDTd90cRyOo3DHmQboUYwTueDV0o2hfstrBKnC+JlhljAmerUP5BP
	0P52JjSJcuBpdCLF8rRCs8L+6FxIuIeDlBz2e9xLF42ntkU67d+d8/Hzl3ShJKyY6kgWXiM5F1R
	FdabM7kewOeBwp7sUrhJzrVobXxVccr1rUxQF/d1gVABYCuOImc/681gvLchJyDZA5xj8P+wvk6
	gQyrZ+tL7JmsjhF0TNHQ2mG/Csfyr4m6JlpuKtWG7AiGGOwm21wpisQzt9lQrnLSxGuf3RMMj/m
	CqIkAQYRedRf1veT3JXVuuTkYzpRqeqNDFDTXN5ujwai61d4iYiGP8DBzfvGkNTUnSrQsJFoyFp
	1Y53xIoXk7ZRy7nsghAbPXHYgy9RLsYlmNARHirw==
X-Google-Smtp-Source: AGHT+IFb112ZtZLsO+hoNYz2HxlsdyYfC7JZQ7Gax5FlERbPuY4E7182eA14h+MSwUZXQUmyS7FO8A==
X-Received: by 2002:a05:600c:8719:b0:45d:d97c:235e with SMTP id 5b1f17b1804b1-46fa9aa0edfmr226344305e9.12.1760614023765;
        Thu, 16 Oct 2025 04:27:03 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144d17cdsm20097575e9.18.2025.10.16.04.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 04:27:03 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:27:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sdubroca@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
 <aO74J20k16L7jS15@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO74J20k16L7jS15@fedora>

Wed, Oct 15, 2025 at 03:25:59AM +0200, liuhangbin@gmail.com wrote:
>Hi Jiri,
>On Tue, Oct 14, 2025 at 11:40:12AM +0200, Jiri Pirko wrote:
>> >+#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
>> 
>> I don't like the "virtual" naming. In the past, we always tried to avoid
>> that for lower-upper devices like bond/team/bridge/others. Soft-device
>> was the used term. Please let the "virtual" term for vitrualization,
>> would that be possible?
>
>Sure
>> 
>> How about "master_upper"? This is already widely used to refer to
>> bond/team/bridge/other master soft devices.
>> 
>> MASTER_UPPER_DEV_VLAN_FEATURES?
>
>I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?

Why? We have "master_upper" to point exactly at this kind of device.


>
>> [..]
>> 
>> 
>> >+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)
>> 
>> netdev_compute_master_upper_features?
>
>netdev_compute_upper_features?
>
>Thanks
>Hangbin

