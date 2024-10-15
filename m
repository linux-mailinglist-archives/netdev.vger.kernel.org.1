Return-Path: <netdev+bounces-135535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F83D99E3D9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC4B1C21114
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359661E5717;
	Tue, 15 Oct 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brVGufr9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F501E4930
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988115; cv=none; b=KQh3qBUDEETGHY3oEIv/H5Zv55+xn+HHVAGdlQMU0M4+Z6toLDKe7dku2g8yjgHPkwC9UWxDCBGdORsxq4mAoDbDR7dz8AfF+zcnH5ft5Jyd9fN7NoJwCE8UKPlScrXDEvzfX2pAjATTmJ2w0aumxoG2Oi2vH4SSDd0Bq1VLtg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988115; c=relaxed/simple;
	bh=VgJvuDkJACz+nKbm3fgGpAqb49d91mYdGlKdFuQGhR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0oizdPuqdneoV//MbHS9zMMPYHNgziIEd8bnTKXkOc1gOxZya5l/hQkIXK6xNBYGe3k+bS16ze8E/Yfq/UIpT50tQdpE1hXdQ9v/eJ9bJcTIMLkgNhvv3yXTP7UvoG/KpkeCK7VjJUO3CcxMB4/95TGadikrsBuIeJIt0SVECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=brVGufr9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728988112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cps/LOuop4Pu5oc4Vsr3y8b/IN0J5M76l5RtraQo7R0=;
	b=brVGufr9Y4DwoVHwzP3oiM6btrumXzmIIBV5oQlfQUAedSXAaenkX47WFXTd5yIKUwmmE0
	pCrbBMF+rRrUCvY3Fh6iJicPuovOEggTI5hdsvSGWn74m6dw1jN5Xu367rslZZlZDTDYuA
	v34lYf7o8B5ZWLpyMgbXJIpCI2f18W4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-sDgKzwtdNOaYlHwyHAgUwQ-1; Tue, 15 Oct 2024 06:28:31 -0400
X-MC-Unique: sDgKzwtdNOaYlHwyHAgUwQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d4854fa0eso2580129f8f.2
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 03:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988110; x=1729592910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cps/LOuop4Pu5oc4Vsr3y8b/IN0J5M76l5RtraQo7R0=;
        b=f/EWF5HPKclh1gXk+WEF+beePf6zzcPuSIY8dr1JEBiQlvngxaiDfgUJSIi3IuQ7YJ
         aUoK65qCgvZfhK0qIMRL4Irm5df2eJ3GSlIoBtvH4JjBy9L3+pkde3pR52XooDkpkls+
         BDU8ceZS24Rezqd2XVRW62EG7kFjE4fJg9/IAt8gxstKprpuOZKZKjA7SlFQxNONmO1H
         FbNV1hFqwZH/rxtXHX/1AkU2rGETjHZuldesulYawt0fwYNwwkMTW/O7azXgL46qpBQy
         26UrPbP7ckeoCkHATf32g7XhwRjWPa7vrOJke0qqr4fpgzLWiky3JGxmRziuOgRkwfqL
         J79A==
X-Forwarded-Encrypted: i=1; AJvYcCUX+pdscn2ziHC9U6Qt50SPcEImo06GbuIubRIrTriPfrIDYdtrncXrzTj0KKdHsAnwA/0d2qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNx12RKnOCYhr2zuykZ1gSZK/RpZoS7kp13dmdgA3l4guCVolB
	FEBC0Mwkv+c+BWPWoacihfkulyXd6wc6w8/ar9gbC624XhFuhW6LS6WwCSCWwzTtKoszRHtAP3V
	joUUdtePCXLemx+SimZLo+Pm3HAhqOUvJcrsYyXJzTRZu1UF/4Osfwg==
X-Received: by 2002:a5d:4c43:0:b0:37d:5496:290c with SMTP id ffacd0b85a97d-37d551aac20mr8651059f8f.7.1728988110005;
        Tue, 15 Oct 2024 03:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExTzwbPKlTTkRpsnClYF7+R/Tjm4icbAPJb2joq7lD1QZdO9fKsuHcYHIuJ+ORRD3Pk1H9WA==
X-Received: by 2002:a5d:4c43:0:b0:37d:5496:290c with SMTP id ffacd0b85a97d-37d551aac20mr8651040f8f.7.1728988109542;
        Tue, 15 Oct 2024 03:28:29 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc41154sm1194674f8f.108.2024.10.15.03.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:28:29 -0700 (PDT)
Message-ID: <2dd71e95-5fb2-42c9-aff0-3189e958730a@redhat.com>
Date: Tue, 15 Oct 2024 12:28:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 net-next 07/10] net: hibmcge: Implement rx_poll
 function to receive packets
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 christophe.jaillet@wanadoo.fr, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241010142139.3805375-1-shaojijie@huawei.com>
 <20241010142139.3805375-8-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241010142139.3805375-8-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 16:21, Jijie Shao wrote:
> @@ -124,6 +129,20 @@ static void hbg_buffer_free_skb(struct hbg_buffer *buffer)
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

It looks like I was not clear enough in my previous feedback: allocating 
the sk_buff struct at packet reception time, will be much more 
efficient, because the sk_buff contents will be hot in cache for the RX 
path, while allocating it here, together with the data pointer itself 
will almost ensure 2-4 cache misses per RX packet.

You could allocate here the data buffer i.e. via a page allocator and
at rx processing time use build_skb() on top of such data buffer.

I understand it's probably such refactor would be painful at this point, 
but you should consider it as a follow-up.

Side note: the above always uses the maximum MTU for the packet size, if 
the device supports jumbo frames (8Kb size packets), it will produce 
quite bad layout for the incoming packets... Is the device able to use 
multiple buffers for the incoming packets?

Thanks,

Paolo


