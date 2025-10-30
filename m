Return-Path: <netdev+bounces-234378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C8FC1FD38
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ADD9E34EA38
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A732570D;
	Thu, 30 Oct 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gmva9kfu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAD2F5473
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823889; cv=none; b=SojZiG1lkqEKF9iS9FhuG42nh8bjzV1M2VjGuR6hl+I9DHfMk2/CduKsb95a783fkIqKD7cO5YkfJdyrF970nOO9Rl+BkH9oyM21eii0j0lqGfti+G1LwEMxD+/UiJhP83XJ9HcG64yzDpy8rBlHTY9zxQwW8WNVwLQbFvc8nr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823889; c=relaxed/simple;
	bh=PalcqpnJMqwi6lBplDZuoLJUjAKrWK8eNRu93Izv5nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5mIKFf8rAKqtYd6Xmc/gUl0IOW4+olQWk9tApseuZLV6mEl0khzwOrGj9m2rXYC1zdGCbR6HPa7kF3h/mCks4GF47bwmVxQno2fKl5UOzH3xm3IcKMHKRqKC/i7M/pQ259x6MWFsv20ZFw83CgMQr6oXiBwX1KVvf3+vnlBjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gmva9kfu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761823886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNPmqukZVrL1nRBEg8kswOAZNYJ7QWgglOXnRwYjysY=;
	b=Gmva9kfux8KsBnXEWoc0GjawVAiSeC68+bPA1PcyLrFUFFl5qD0b5L2TQG+HHQz+CDNgcV
	3/J9k14isSTvJo5oNzX2YrZaD6wyc3p2ntiwNVkieUoyTWdVNbv/+SJ6ph+ANHUuVJzL3p
	j2qLgrTmiSynPLE+UIdO65uVS5lkS1E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-bMBA8h_oPZK9f3zeK8TBSw-1; Thu, 30 Oct 2025 07:31:23 -0400
X-MC-Unique: bMBA8h_oPZK9f3zeK8TBSw-1
X-Mimecast-MFC-AGG-ID: bMBA8h_oPZK9f3zeK8TBSw_1761823882
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4298da9effcso901320f8f.2
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 04:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823882; x=1762428682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNPmqukZVrL1nRBEg8kswOAZNYJ7QWgglOXnRwYjysY=;
        b=DZZqetXJM5mfZKQ77GbCkO2Zghfgl84a9kRVPZkJigwrfRe8MS9YmsaO4TkWEkduT0
         s+Li0HK7KkXUsMtj1dpq5+w23STta7jl1qVLal51UMvW91DxijPMGNTRP+G2GOq4cMNC
         SYzJC/U0gd+8yMvi9C4an6IV2yzaYZd7775G7hI57O3hw7b/QVj8cLsgy8Y6h9oa9Ach
         B1TZt51CSS1YAZaUtXnj6nKMJIaqHBeJ7lAjkLaFgNy/BEIU5QPe3X/wsmfjPWvNTynE
         QcM119onsv1CF8XqL4croERccJHLk6pqLe3iqyTpPkBqjcOWLGIcf6Ij6OIbXE/qmJlY
         zYuw==
X-Forwarded-Encrypted: i=1; AJvYcCUo84/1tPK0+q0pNmp5pHnDknr+flqhCkjbSd+N963icw+1qxWyXZb0L5z4Y3f70gr4yBArTQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXUYwOfzLroXSFSARexhjES6fJUEndC8rz4YyCEQRTK2Tgtkj+
	53xBA+ozbneam0/M0BMEVfwezGDfCPUBoksmSkM7ac/4B32iHMKdWs7I/aR7PE7KCfmEJuekO5w
	HvMVWorKHH76c+Komqwxuo4q4EPj8Fz5+En+I9iMiIr62Lyus1Ptl2xk8rg==
X-Gm-Gg: ASbGnctT9JB80vH9ZKXRVekqDTxz0xWlceUZGAhv52LMm0E8XpI8pelUafzgILnYGg+
	67jMpupztr8Gu+mtBmqbWMTqhik5qbxJ8odyFLuuI3ha8PBdoRWQl+aqfMg/Te7nDGuZB2QvJHc
	qHNMIsBLa2i45cIoOC3k6L8u21xkzVJzQcLKvD7Do4/t1PkrNnXEeetOuWKLCaptlNlyDNxZjxx
	tM/u0P8T1+J3FdJy5RuhkRCvHAgur9V3AyY5jsseossl3SvGjXihG6ioAUibrmjmFBnrcWLLheo
	pEtBHKrU48mBFA7jetuTtFRsom4eGpC1MWHjIV0FIXTtvhjhUfnL4ds3VWcbwxvlRmkxo67w+ML
	1T41z00Ah/rUBmp7r2bz3/DgtOjXPfE6zve+jeoxK7Ftq
X-Received: by 2002:a05:600c:4ed1:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-4771e1e10a5mr57072475e9.30.1761823882500;
        Thu, 30 Oct 2025 04:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg4pUYWYJn5DSp/qvYpqqu8dWSsUkDIL1fKa7DHscLp3BNjyufKl2NcGIwl/reA4vImajWlA==
X-Received: by 2002:a05:600c:4ed1:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-4771e1e10a5mr57072195e9.30.1761823881975;
        Thu, 30 Oct 2025 04:31:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771902fa8dsm64427935e9.8.2025.10.30.04.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 04:31:20 -0700 (PDT)
Message-ID: <9d469be5-e2f3-427d-9e6b-5d9c239fcb79@redhat.com>
Date: Thu, 30 Oct 2025 12:31:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 08/12] virtio_net: Use existing classifier if
 possible
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251027173957.2334-1-danielj@nvidia.com>
 <20251027173957.2334-9-danielj@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251027173957.2334-9-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 6:39 PM, Daniel Jurgens wrote:
> @@ -7082,8 +7097,9 @@ validate_classifier_selectors(struct virtnet_ff *ff,
>  			      int num_hdrs)
>  {
>  	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
> +	int i;
>  
> -	for (int i = 0; i < num_hdrs; i++) {
> +	for (i = 0; i < num_hdrs; i++) {
>  		if (!validate_mask(ff, selector))
>  			return -EINVAL;

Minor nit: this chunk possibly belongs to in patch 6/12.

/P


