Return-Path: <netdev+bounces-105403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A27910F6F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3FD1F2385D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C483C1B3F0E;
	Thu, 20 Jun 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxDZ0gFz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFBE1B29C1
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905541; cv=none; b=rf/Hs+9+sOtHBGAgXgyI6tIClKu70SsRBVqR3+zSXaRm5kWcLeKIIsDwuHqcwPIk8XZZIE8dqQApxjGy2vMDgB3KrSGgtRjeVf/uf8/C4Kj9k4Ygt5bgZMKc8NJ0z5WAHLKbCSbpvEv2sEsnSm9Z3uAx9bxnenMMKFxIqQAdlKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905541; c=relaxed/simple;
	bh=p5bIW8+hw87S8lNpnZFuizNHs2fd9qViSd+WxyKpmTw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ViCyKqyaS8ZK48OBO1T4dPn50qHNEAY9h+TwYyITt3tZ0hxOCwsTaPWBvNCUklrAGm3Q0xeYXL5NgTGo3ubp4ySXAS0vMF8pKPj7lpXsg7vDBlxfjWZGeblZElsX33gH0Hn9jABZua1T308RqwWE2fbPsCP9m98bWYwRkqGn0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxDZ0gFz; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6fd3d9f572fso629350a34.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718905539; x=1719510339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV+B9azjO4CWMIGP+IXnMAHUVv2CHaNiXhU13/St950=;
        b=bxDZ0gFznTqqtW0DuuvLSXR6+NlDv/e+7NGdTxCCQkv5dDCEwj1Ue0lXRawDdv53B6
         6ZfVVdSsSUXFWv+rRgtNFSJS7Z9/0ZwgftMqXucT1oEIGF23zdjmNv61mrF4a4lOj2G2
         HwX9vGedsO16saeZOg2L+52BS7IgFiDciPnEjDxhlqxuq3VFqHuNLzsJfzhXvcOSsG9J
         aBIH2oz3z6cVan/UwflwEjj3mjf6EBIt2478kTVoLIOStui8V4dXFAIXDHOx5Fd6g6N2
         oweLTtnjMolYcj9KjQtCrQzrsT4a/pcKXI0t6GidjtRkrEuPpLJz0IULvsX4184DnPcB
         aqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718905539; x=1719510339;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MV+B9azjO4CWMIGP+IXnMAHUVv2CHaNiXhU13/St950=;
        b=maRIrrjyInxLwIbkEWZtSrXjVv/x9NS+hIirq6yph/exZys+vFceTkZvICytB+H5J7
         ZAgO8LgWjJWuD60A9i8KoY/CnyVMjYiAlgmsj9ztUM18An5FLWyZrVxnTRv2LGa8Palm
         aIiQW8ScRl4ilIv/wcelJMFwHek98zJfqIggcOoLzmBHxlqqqwpdzadsHfR71B3+ZoEV
         YAyCazryKC9BRG5BGtSwiyfOmJu9sTzw/lgbEJtda7/AezmiGMcOptdw1Vy1MQrOqEF9
         yhO13VQ7+RZC7EzRl2NxN/bELEOf9+OAevaLZwHdGPH9tG5Xuv5zcoJy1TMJ8Th4p5Na
         iwHA==
X-Forwarded-Encrypted: i=1; AJvYcCWrtVJ8+Z4T1F8xG0sHEM/z3AwC493gqn9eDlAevJHCiWhsC6NDAM7BCfX46B2N+aHjNGFyN7OPr0WPczuRUG13X1tZvRF7
X-Gm-Message-State: AOJu0YwcxNmHacD+yJCORE7xsTWxyNKXqjUYRXpWlfvnLG3tk+inKfoD
	cyxjOR7s8vf9O1bTnJ5+nbuXqlGPL/7az7QjAxALCXCIPvb6zW5A
X-Google-Smtp-Source: AGHT+IHstFN0eVOTe98cz2rVnKYlw0BcFP1QcPaUiFgEImHHOtOv1OY0XNgunpx3ruShu0KXojZyjA==
X-Received: by 2002:a05:6830:130c:b0:6fa:81b:d4f8 with SMTP id 46e09a7af769-700733761fcmr5941141a34.1.1718905539146;
        Thu, 20 Jun 2024 10:45:39 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ee1327sm90543386d6.118.2024.06.20.10.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:45:38 -0700 (PDT)
Date: Thu, 20 Jun 2024 13:45:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Ziwei Xiao <ziweixiao@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Shailend Chand <shailend@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <66746ac265e37_2bed87294ba@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240620114711.777046-7-edumazet@google.com>
References: <20240620114711.777046-1-edumazet@google.com>
 <20240620114711.777046-7-edumazet@google.com>
Subject: Re: [PATCH net-next 6/6] net: ethtool: add the ability to run
 ethtool_[gs]et_rxnfc() without RTNL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> For better scalability, drivers can prefer to implement their own locking schem
> (for instance one mutex per port or queue) instead of relying on RTNL.
> 
> This patch adds a new boolean field in ethtool_ops : rxnfc_parallel
> 
> Drivers can opt-in to this new behavior.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ethtool.h |  2 ++
>  net/ethtool/ioctl.c     | 43 +++++++++++++++++++++++++++--------------
>  2 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 6fd9107d3cc010dd2f1ecdb005c412145c461b6c..ee9b8054165361c9236186ff61f886e53cfa6b49 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -748,6 +748,7 @@ struct ethtool_rxfh_param {
>   *	error code or zero.
>   * @set_rxnfc: Set RX flow classification rules.  Returns a negative
>   *	error code or zero.
> + * @rxnfc_parallel: true if @set_rxnfc, @get_rxnfc and @get_rxfh do not need RTNL.
>   * @flash_device: Write a firmware image to device's flash memory.
>   *	Returns a negative error code or zero.
>   * @reset: Reset (part of) the device, as specified by a bitmask of
> @@ -907,6 +908,7 @@ struct ethtool_ops {
>  	int	(*get_rxnfc)(struct net_device *,
>  			     struct ethtool_rxnfc *, u32 *rule_locs);
>  	int	(*set_rxnfc)(struct net_device *, struct ethtool_rxnfc *);
> +	bool	rxnfc_parallel;

Would it make sense to make this a bit, as there already are u32 bits
at the start of the struct, with a 29-bit gap?

