Return-Path: <netdev+bounces-133918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A35997796
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76FC1C21E3B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D011E261A;
	Wed,  9 Oct 2024 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="heqPBuoF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6D1A0AFA
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728509765; cv=none; b=LA00YXpKLafMmehwSUiLkFUeX4+/j/MUDsueLcb4laOshrtI2xHEiM6/Eg5UV1Th9oFXQogmkap3pvPz0RkZRnuaGgUYco6GkHg6Kk8G7MkSMIB3DUOry+KlzpNBA8B38s+E/YZkyRHWb9604ownJa0Iio6D3mVkk6AOzDTbqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728509765; c=relaxed/simple;
	bh=V+UM1KZqe0MyoAcGD+VdzdsIs5FGD13ixwV3wVKKATU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=folPVrTEb+ssASVXREI3SEpsmSEJpaWncUE00ZLvsGLcmoADv5ra6DW1f1O5Z9/p6zp70U7GWkt/XggJ27pcWwABEHpg6I1R8hyU8hArrM4Wv4oX+DuQYDVitNkZMB7DV/obuKo31DGtqlnL/mNjLvnCFusV2maDch4QPnyrq9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=heqPBuoF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71def8abc2fso228180b3a.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728509762; x=1729114562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iq91ha5qoJGNUtqOzDNWyHHNeSPTI4MkpTmh1lIw4EM=;
        b=heqPBuoFaRrN0192RAWH7KceUaunfjTMhVkCwX9GLCflECErPUUiLpse8tgEoRy5bJ
         lkKnCpl9zHzqDYvv0hYGjmxBS+uw34KqLZqNLkmtGRLEY9KQetzQ2DBcyf52NuG/+AY1
         TR6601WE5SfKjGakvXXNIJa1r/bZJ2sjCYfwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728509762; x=1729114562;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iq91ha5qoJGNUtqOzDNWyHHNeSPTI4MkpTmh1lIw4EM=;
        b=oUV1uKe0h5gjM/dmYgQ62uG/4jUOJEckrPszh4rpeI6WKHsIK/fb0GIs/WgsjvvsWj
         g1TR5Y+W9tE5i21YCde8fP8Hrwqxij6OCWraVBfRU5vKoT+1R09RT3wVOo9+Ads6JM5q
         mDqkFxv0tL8uzcVnX1UCKlhCDRybZeGp05zYqK70XAd0PaSO1t+cY8DorqWELJrzWP2D
         +1uSV9DmyNs4ET129i4H3UO/m7lGLiz1+EKhce9hXmg80KqCuE20hj359YpmIJNgjZO6
         eEafDw0n0Oqw8a+4TIVoOq1uHJMQ39ZX+ndsaGXFtxfmjW5p7GpvT7Nj/2/4WQwaP4SF
         W+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6HOlDZ4xenyU8yd4xhmp8JmfpFYYQWqQuxcJ78BuZ4r7zJQnMBAjQKclsQfNUmShz/O1SUfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqbaG5Y/jeYSI7LLodUHFmE1qzCDo+zevfHAnkoJsxg0YVrS97
	qFnkF9Fff49LAejokvQPkPNWqMIs8YhU06j3ZoYIsUtlIeY2rifPCbN9gQwHreI=
X-Google-Smtp-Source: AGHT+IFGKmchD6PQPRJnQ/WVk5jcKczkOqSly9YXT2GW1/t8dXc0PBMeSq4cyZmlTpCF6bJuKDKSzw==
X-Received: by 2002:a05:6a21:4d8c:b0:1cf:6baf:61c0 with SMTP id adf61e73a8af0-1d8a3c490e1mr5443108637.44.1728509762443;
        Wed, 09 Oct 2024 14:36:02 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4663csm8241895b3a.106.2024.10.09.14.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:36:02 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:35:58 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
	horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
	christophe.jaillet@wanadoo.fr, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11 net-next 07/10] net: hibmcge: Implement rx_poll
 function to receive packets
Message-ID: <Zwb3PvG_EjwqMT4v@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
	horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
	christophe.jaillet@wanadoo.fr, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241008022358.863393-1-shaojijie@huawei.com>
 <20241008022358.863393-8-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008022358.863393-8-shaojijie@huawei.com>

On Tue, Oct 08, 2024 at 10:23:55AM +0800, Jijie Shao wrote:
> Implement rx_poll function to read the rx descriptor after
> receiving the rx interrupt. Adjust the skb based on the
> descriptor to complete the reception of the packet.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

[...]

> +
> +static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
> +{

[...]

> +
> +	if (likely(packet_done < budget &&
> +		   napi_complete_done(napi, packet_done)))
> +		hbg_hw_irq_enable(priv, HBG_INT_MSK_RX_B, true);

I am not sure this is correct.

napi_complete_done might return false if napi_defer_hard_irqs is
being used [1].

In that case you'd probably want to avoid re-enabling IRQs even
though (packet_done < budget) is true.

[1]: https://lore.kernel.org/netdev/20200422161329.56026-1-edumazet@google.com/

