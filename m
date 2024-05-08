Return-Path: <netdev+bounces-94421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74808BF6FD
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9F52854E0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6C22EF5;
	Wed,  8 May 2024 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoVjLqwI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D912D1BC40
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153186; cv=none; b=QYwgqPWVaRd8be9881E94aeevcbZkEQFctg84eZtNYmX2HAv61ZMqphbNbJ5kG0eZa6VD9Hc+g/LB1uRZhSmkS/JHXD2cVV/y+Ow8B3joMzGX3PGNjoYVYd9aGknWMvOTZ4V5JPJzk3MDGBczQHreKBi2oSQr16nHt9wCAquUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153186; c=relaxed/simple;
	bh=nzHkHgB1kFFJ9xGqdQDFZ6L2FZdG9X2ezr1nxT4iXYs=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u6pbJjOxGEFScDkb5w8TP8qv4GEAfP38HzO8KZslHE1q5Fs+H+XH8nQUSBe6N8u7uRU8HPv/QSvDmbeanXodQxLyuISARbhT7wMt0OjfgIR+nHUVoklXRgF3eQ7b43wfG6R1CWZEz4ZveyqjhRLTzXqR2gzQxWDteANr+UUnZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoVjLqwI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2abae23d682so1105648a91.3
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 00:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715153184; x=1715757984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25F96gIo6jtVmRUaicY9ktJ04Hwv3tFkp4G88NiIyFQ=;
        b=GoVjLqwIKOLWnN7z5vLL6qKCOgmvzw1og7Tc15WoPa+gUTvuS2Hk11qAv1EAsqIok4
         yflSZX9qre0TI2x9IXSJpewheEVcjBS2TIkQItgyUa0Pp0u6cXYrlfFmGP2gx2AeeXhK
         4mZcwaJgpthA5pBvVhe+d3/0uSh85qiHS4yAjdrw99+56LuCMnWvzN6Q3RzNiaGJvzvF
         GqXhLLc4xXqelxcoCHa7SecXn7TlG3bPS5+zahOZjuaZt4blUDty/623WHoA3wlEvIg6
         8azV2YDZQJWPhQHFIHNdwW2hMSgxi4x7qwcHxl6va3ErrzNrubMJ5VzhaYvBb+ThWeXn
         oEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715153184; x=1715757984;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=25F96gIo6jtVmRUaicY9ktJ04Hwv3tFkp4G88NiIyFQ=;
        b=aVbraK71yRM8zrBdTeEhdM6c8RPOe9kyue2WDam4uvvMEvXdJgXvANtptCBl5paOaQ
         /eEF8kA7C285l0HnBjP+svQj/1uCzDmcVVNL3hd+eRVbhqWphjNfPdRqdEozk3g11toW
         lMqWnu8BH1A28CCx8qTZ5Ne9Vz2+Vy1JNJtfPE8ztZNQZ702y30txXa+/wW7mPsAS4UN
         QJy6kKLz0W8iXBssFGSx4XmBzklc3TXGykIa1g154G8ltZyqFQVBHTXsU5ZLK10W3uD1
         PrzJ9sx/XO/7OM3Kts/7uS/maW8cP9GazElLZrq7X7kjlYYq4y/NCWqcCg8KcbICjrXA
         TyvA==
X-Forwarded-Encrypted: i=1; AJvYcCVnB649VSAj0fCCIyeWDD35yJMgMjtoSwHz1t4qiYfzgR8AydfzxCp/B3YDqlyzUTDkp4T6GECZoOeFJ3ZCkcwuUGlF2LoK
X-Gm-Message-State: AOJu0YwSA+hP0QZdnk9zQORIl9WVi3OyIOQ1c3uMAZzB8J3orcLX981P
	NCwHYrpoI4fLM5uOYWU6+Zk4HUXOr7nI5AQcThmDkNWePvRN1cPWTHUiApmy
X-Google-Smtp-Source: AGHT+IEiL/YCUMDEtbiRdCE4NRWn9r1RZzo2HbYgLM23tV/Zo9b2jxNy4dlnBzoJP5JpgtR/zGSpeQ==
X-Received: by 2002:a17:90b:3002:b0:2b2:b080:dd35 with SMTP id 98e67ed59e1d1-2b615af6e05mr1756381a91.0.1715153183933;
        Wed, 08 May 2024 00:26:23 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea6a13sm739325a91.57.2024.05.08.00.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:26:23 -0700 (PDT)
Date: Wed, 08 May 2024 16:26:18 +0900 (JST)
Message-Id: <20240508.162618.236220769643680941.fujita.tomonori@gmail.com>
To: pabeni@redhat.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 kuba@kernel.org, jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v4 4/6] net: tn40xx: add basic Rx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <bde7b5c39b19cbc6e32a92b94e731d26a8d47922.camel@redhat.com>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
	<20240501230552.53185-5-fujita.tomonori@gmail.com>
	<bde7b5c39b19cbc6e32a92b94e731d26a8d47922.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Thanks for reviewing the patch!

On Mon, 06 May 2024 11:20:55 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> 
> On Thu, 2024-05-02 at 08:05 +0900, FUJITA Tomonori wrote:
>> +static struct tn40_rx_page *tn40_rx_page_alloc(struct tn40_priv *priv)
>> +{
>> +	struct tn40_rx_page *rx_page = &priv->rx_page_table.rx_pages;
>> +	int page_size = priv->rx_page_table.page_size;
>> +	struct page *page;
>> +	gfp_t gfp_mask;
>> +	dma_addr_t dma;
>> +
>> +	gfp_mask = GFP_ATOMIC | __GFP_NOWARN;
>> +	if (page_size > PAGE_SIZE)
>> +		gfp_mask |= __GFP_COMP;
>> +
>> +	page = alloc_pages(gfp_mask, get_order(page_size));
>> +	if (likely(page)) {
> 
> Note that this allocation schema can be problematic when the NIC will
> receive traffic from many different streams/connection: a single packet
> can keep a full order 4 page in use leading to overall memory usage
> much greater the what truesize will report.
> 
> See commit 3226b158e67c. Here the under-estimation could fair worse.
> 
> Drivers usually use order-0 or order-1 pages.

Understood. I fixed the driver to use only order-0 or order-1 pages.

> [...]
>> +static void tn40_recycle_skb(struct tn40_priv *priv, struct tn40_rxd_desc *rxdd)
>> +{
> 
> Minor nit: the function name is confusing, at it does recycle in
> internal buffer, not a skbuff.

Sure, I'll go with recycle_rx_buffer instead.

