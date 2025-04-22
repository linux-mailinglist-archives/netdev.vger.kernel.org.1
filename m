Return-Path: <netdev+bounces-184783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C987A97275
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90C017AE96
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CAE27C159;
	Tue, 22 Apr 2025 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW38R173"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF7E29CE8
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338918; cv=none; b=CVSBxORFvSmIrr0arAm5nO0NlSpDEVB6nzL1EMe82vVHvlhjPTKCOVpdIceLbfR4/FX1yNnBi5cCLSp1pCU1jw0irnQYp9MOtx23FFV8CwMDxMjZ8WR99fQ9tLp1Lb6S5EX8M6s4/wV44NtYOh5rfOSDHieL6O9wUMqmNB6dmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338918; c=relaxed/simple;
	bh=rGgdqp5XRwNy7Is0UecKdRwmqsto9yz25GUDcgtro+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pW6O+xoflRdqJAin9tuPrY+oqr1NIB8m60Lq1xxIiCG6snYcjXAKkc7BQgKdA2HVJI1CyKd4UHJmUEZDatCELKJQly7vp+ufd8DCWbnP//D/W/og8MGXhMuOBVjEvRyrCMuIdQztDzTKOzmTM5ycKrsEndU5h3HzSV+jyo3ygWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YW38R173; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736c3e7b390so4632009b3a.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745338915; x=1745943715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bcqM0aJxpyjb84aOSL7Pp7sQgZtDtrvBIGbnXUCExw0=;
        b=YW38R173pz+0RX+WmYkJdcdOAORPOSrgHxp+KELSPBuIrN5h6DCxApbPBSg7J5rSGa
         1r5EP2m7nENFwRiWX0CfZEbVCC4HaLiXLiFMk6+00WnRU+qv2gz7TTxjQcOMygeQ/hlS
         uTpEfqpknv8U7wzaiYd7/ea+6zWE8tx0NUuiU433bSJbArjssS001L1qj+3GtIucoZjd
         eGNYglsUN1d7ytY1Gaxa7+NqLzlG36ubxcq5f5MWmCcaiGCOcFtyipKEDm7lxoxIX+VQ
         tgFpR1Ggd3rZM1/cXgIsdrxRP3wbvUpRVRDaKUuJ7YHVo+yZ4DHTVecpHb8TkoQ3ubON
         lgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745338915; x=1745943715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcqM0aJxpyjb84aOSL7Pp7sQgZtDtrvBIGbnXUCExw0=;
        b=MyvTO+gaTnHPSY6re/9dsFpufJVOF541fZoVSfqydIRv4Y81sgVX9lVSFo1hYUNkr8
         ioRXmBTjZaewz8lSepsaYJJZvo2qnWY2p7aV8lUf2//LCK9f8MiF2mHLkzV3nSA429yC
         KPvyqFLSF19uNm6Xwx2U3DcjzAm5a5uXFbvQoRRtGBfY7B/TzdiM1xG0zqQRihu8L6dx
         4E31MBaUlIOGTUxx5/eGV+h+kMfEdIl6KOgG7ypejemdoELL9d1tgpbOpDZAhc4t6Yzq
         4eiI1+qJY0kHoXxfPLIypvmbrpuTkRV0IrAb94H9rysH6GUMsTpIkUhbah0ybJUtkZNF
         qtmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUCep7pfvgVOHV4OGeR3xMlA99mdMfuYkHwvFS/xdLzhONbOPw4xQsNLNUnfpBX90zPdUGorE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydEu4mkz5599kbqFOzyxTD/LNNLBeSnohrRSyWYKtViGA/Z+Vq
	S5h2QUJppyrYMT/g2siRvKp2Q8T0X8+9rrEfxR19d5yNoQ9ge+s=
X-Gm-Gg: ASbGncvLZNmG9490r7KFbaEJ/3ASB8sTfkjiZGBid3X8ivH/yRvcHINGEOvyrn/L9ef
	CZU3lTHcIw3/uDLsMkx0OwtOry5Gacc9/Q6IEE/dddAnzfhzd908/0fr+zXmlfLh9lqvNG0PiID
	qJ3qq5XEfLObE1zL1XZ78R+VshLwpvlHmYzCHb6bvZdfjR5wBkyZU8xPlz976eMK8zk5+vdwI7F
	HMmetvUUgNGHzhMsOefLFPTZ6lNldFSrA2NRe19QesBde49+zkP6Yvvy5lL0oQQ5+N3Z9CD58rz
	kkliP+5/C2uApQd4xWVw3x6kUWKeK1CFEic+PiQCsoyFB36RFXA=
X-Google-Smtp-Source: AGHT+IHZAXgY8xCD1MFGKXtZVxn9WilgJDTR7u7OMURhas/nfR3IurFlvCwiu/eT1/RrLyGy2zweAg==
X-Received: by 2002:a05:6a00:1142:b0:736:fff2:9ac with SMTP id d2e1a72fcca58-73dc15d0c1amr21759787b3a.23.1745338915505;
        Tue, 22 Apr 2025 09:21:55 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbf8e42c0sm8865661b3a.71.2025.04.22.09.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:21:55 -0700 (PDT)
Date: Tue, 22 Apr 2025 09:21:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 18/22] net: wipe the setting of deactived queues
Message-ID: <aAfCIq6ktXXCOp-9@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-19-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-19-kuba@kernel.org>

On 04/21, Jakub Kicinski wrote:
> Clear out all settings of deactived queues when user changes
> the number of channels. We already perform similar cleanup
> for shapers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/dev.h           |  2 ++
>  net/core/dev.c           |  5 +++++
>  net/core/netdev_config.c | 13 +++++++++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/net/core/dev.h b/net/core/dev.h
> index e0d433fb6325..4cdd8ac7df4f 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -101,6 +101,8 @@ void __netdev_queue_config(struct net_device *dev, int rxq,
>  			   struct netdev_queue_config *qcfg, bool pending);
>  int netdev_queue_config_revalidate(struct net_device *dev,
>  				   struct netlink_ext_ack *extack);
> +void netdev_queue_config_update_cnt(struct net_device *dev, unsigned int txq,
> +				    unsigned int rxq);
>  
>  /* netdev management, shared between various uAPI entry points */
>  struct netdev_name_node {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 7930b57d1767..c1f9b6ce6500 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3188,6 +3188,8 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
>  		if (dev->num_tc)
>  			netif_setup_tc(dev, txq);
>  
> +		netdev_queue_config_update_cnt(dev, txq,
> +					       dev->real_num_rx_queues);
>  		net_shaper_set_real_num_tx_queues(dev, txq);
>  
>  		dev_qdisc_change_real_num_tx(dev, txq);
> @@ -3234,6 +3236,9 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
>  						  rxq);
>  		if (rc)
>  			return rc;
> +
> +		netdev_queue_config_update_cnt(dev, dev->real_num_tx_queues,
> +					       rxq);
>  	}
>  
>  	dev->real_num_rx_queues = rxq;
> diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
> index ede02b77470e..c5ae39e76f40 100644
> --- a/net/core/netdev_config.c
> +++ b/net/core/netdev_config.c
> @@ -64,6 +64,19 @@ int netdev_reconfig_start(struct net_device *dev)
>  	return -ENOMEM;
>  }
>  
> +void netdev_queue_config_update_cnt(struct net_device *dev, unsigned int txq,
> +				    unsigned int rxq)
> +{

Presumably txq argument is here for some potential future use cases?

