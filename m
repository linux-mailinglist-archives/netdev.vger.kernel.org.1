Return-Path: <netdev+bounces-124515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61012969D02
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B54F1F25B13
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD791C9867;
	Tue,  3 Sep 2024 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K32E9Fg+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81531A42D6
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365317; cv=none; b=R31WM1lImgwQWO7hnSPFTSDvoB/I3wRHweVkd/NXPlQ8q7KB9V0jyI0scb0iTky1Ee2j1zDr2V7mnfcLCHEPjbYBb8XV1Xz1RKpEiSPtidrmfzWpDyeMkybyz0Zu1Fbo3k0qIXR6Il4b6Z2Bdb4AzlYy5FiCjJ9oeCNshe12rtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365317; c=relaxed/simple;
	bh=BsZ1n0bOcMMHp87eIkC1zg9ceFjqaILO25XZebbY6Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1SAHY2/CYtKFq6Qr1z5mrqqBF/XCbve7KXxBq8FtLjdUIXKbSjNHzl6upapWCVLjV6BHJwibRjyHguK4d7/RGVRaY3fxZwQrWVXXSBUyb9B9G3pt/yDb900AS+uhi06sY42YaYKZhfib2AiY1pnSxW2gReOUwcXU6ERXz+eAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K32E9Fg+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725365313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9aYRYgG0kixSIOydeenongC/DRL5RnTOeLQrTKXisEc=;
	b=K32E9Fg+vcGTIt5kmZB2CAX0PraKQyk7DCri+mtm6FmAJagnQLjAlUp42SQ90zlGpSkPZL
	oZrkm5Ok0DGgBv6zG96s/fey1h5I/gWNuwHwXD5naBCylMNinU/K4jqsNvD7zI5vAFZ8+e
	wYbU+raeeg7w34jWY04ZThh9Hel+H3c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-7tkY4X4-ODKJQJndcYPVUQ-1; Tue, 03 Sep 2024 08:08:32 -0400
X-MC-Unique: 7tkY4X4-ODKJQJndcYPVUQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bb8610792so46386015e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 05:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725365311; x=1725970111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aYRYgG0kixSIOydeenongC/DRL5RnTOeLQrTKXisEc=;
        b=j6LaytyOAULYUDT8v9c/d3CIR3a7dj9nUkL1X5CYWL9r8LGAz18rXOXcL3uyTfCyGz
         PYthQF2MTlnSXiC1Cc8jBDx3UaFSN+ZETmwHvZv3zc1PNOBSrxUxSAQlDrwO6cQz9yNh
         AlyfYQixo+lN5yu+9gxbohPWasdiCNjFznBWC8s0hgLL3SFtVKdvEohrYrDQGiaiZ3/x
         h6HqotxIfIX6cYGx5cIv30Doohjjotc8taOAc4eixaGzSXWggjW0d8tNpJ3jA39BYRtT
         UHu4+vWhMVCxvrXSCOib8qu+ZQCqpVgWaasODOKpIXJlNmMwkER4d08oXs9uGSSIwasD
         RWow==
X-Forwarded-Encrypted: i=1; AJvYcCXebDyYDSc/OkypUB2qJ66pDAAipIBeMOp/3w2Hxw1SIAukJmT8mPobo0TiNqmuJQGeyjglEjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTd8zAYVAs43v2E/poNo4cu0Ql2prNp4BvD/XOKnhEEuahEoD8
	vak1cDPYI/D0XuNSDoizN63HJuNMXwd39lKuG+IfpHM48cG/oCYgcP4VQ3kzmRqM2qy5lDt+z9Z
	eEXiB9vR3ygxcykJqBtcojKpDk9GjuM42ZInP+lBhEfUotK7GfK49WQ==
X-Received: by 2002:a05:600c:470f:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-42bb02c0727mr129293725e9.5.1725365311435;
        Tue, 03 Sep 2024 05:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYuACYFYmdeRau/l5pNATI4VMioGx45q1slOGtbAH3lBc6r4xbg0dCcuR4/N7ge1VOuo7FrA==
X-Received: by 2002:a05:600c:470f:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-42bb02c0727mr129293435e9.5.1725365310883;
        Tue, 03 Sep 2024 05:08:30 -0700 (PDT)
Received: from [192.168.88.27] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb3efsm170510925e9.6.2024.09.03.05.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 05:08:30 -0700 (PDT)
Message-ID: <0f3cf321-3c23-43df-b6eb-55dd0a1fec64@redhat.com>
Date: Tue, 3 Sep 2024 14:08:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 net-next 07/11] net: hibmcge: Implement rx_poll
 function to receive packets
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240830121604.2250904-1-shaojijie@huawei.com>
 <20240830121604.2250904-8-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240830121604.2250904-8-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 14:16, Jijie Shao wrote:
> @@ -119,6 +122,20 @@ static void hbg_buffer_free_skb(struct hbg_buffer *buffer)
>   	buffer->skb = NULL;
>   }
>   
> +static int hbg_buffer_alloc_skb(struct hbg_buffer *buffer)
> +{
> +	u32 len = hbg_spec_max_frame_len(buffer->priv, buffer->dir);
> +	struct hbg_priv *priv = buffer->priv;
> +
> +	buffer->skb = netdev_alloc_skb(priv->netdev, len);
> +	if (unlikely(!buffer->skb))
> +		return -ENOMEM;

It's preferable to allocate the skbuff at packet reception time, inside 
the poll() function, just before passing the skb to the upper stack, so 
that the header contents are fresh in the cache. Additionally that 
increases the change for the allocator could hit its fastpath.

> +
> +	buffer->skb_len = len;
> +	memset(buffer->skb->data, 0, HBG_PACKET_HEAD_SIZE);

Out of sheer ignorace, why do you need to clear the packet data?

thanks,

Paolo


