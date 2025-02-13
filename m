Return-Path: <netdev+bounces-166017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA3DA33F1C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C41B169052
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29ED221577;
	Thu, 13 Feb 2025 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0u2WcqX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD67221570
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449602; cv=none; b=WoFVcA4tsUbGad2NDuZEgkMN8X8PuEc1Wcn92qck5+6ZGoH/5G9mJXsR1svyQz2MapN9JAxYEW5VotMNbl+07qpzlnu5jo/FlybRqTpAFU6bOBON3KbwdB99mYOFHdG1ckmFhjNU1K9BEYHH6tVms6z/ZfLrHt9VeuvLY4X5A0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449602; c=relaxed/simple;
	bh=3jWd1Krc5wn/OKEeAHBstJpZuM1HOkgVPn6hr3ovv8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prqCtaxJIL03zuergpXi5Wxiuoke9+jqesWvR5hNfjWNzA672g2Mp1NxXMS2rL0T3uXx3pNUHFz4WhFRoecfqw0M//2JjNhLNcO4VC0djKESoGqvesahCgcCVxhNs/WezfBXOEUrTDwjiJi1GUDMp8W/Du+gB+0VWhm0CtrvSY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0u2WcqX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739449599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEe6I1tgC5IN6/Wq62N1ONtXhNM2tczBomQlUMLqsX4=;
	b=L0u2WcqXlgJIAtDGIeDKZockNopl/hALJAOyOjOM7BHi6oPodsmD9wjVeqwy8ZzjVvvt0r
	m1UbUm0/RFHbRyaddJI7Y4jjM6iEWlyxsdvaWZNrKh8TRxHFvhdlWRT/S5hIzXu5oBCm4z
	856tNHwXZ1YVENWEqQQk2rRz9GFbqfQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-S7THMqcJOraNjsDWe7MrNQ-1; Thu, 13 Feb 2025 07:26:38 -0500
X-MC-Unique: S7THMqcJOraNjsDWe7MrNQ-1
X-Mimecast-MFC-AGG-ID: S7THMqcJOraNjsDWe7MrNQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4388eee7073so9632235e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739449597; x=1740054397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEe6I1tgC5IN6/Wq62N1ONtXhNM2tczBomQlUMLqsX4=;
        b=hf+zWKi7GtKFinzqRqMkP2/eslDO11TnNaLVFctAm0QgGjEqir4c8665B+m46EsJY3
         dP1j5mLy3n/GGSk0adkgRjlNV58RJe9cmzbMlH0WOb5aFHSk1ZAHlvpx3SXiOUJiBflw
         ktt5nLV5UYH0b7BZ/K3GKTdXG3PR6GHXa0OzPRRuLRGAMYcShQm6zgqjVj4w6jOux0NW
         MIXAOn87dMa5tGQLM/8ZdNuKm9L9cHniDFvOe5dIoR77CvZ551t9V9AogCQQ5J/GrkCo
         CDk9h16oBMqp4MPvgYfUsoiHs0eWABbYShgB60HcS+sLL0+0BLWMmP5oc/n3r9w65ZN4
         mNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Q85hZ7kgCGREnH37tsynkiKDexqw3VCfKqUroOsPvSl+y0XaT0FhJrTp/Sc7Ww9sayEBH5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyStFxvs3ajpqVPWKxEviGoPZAu5ekQX4vK5vEzy5ZURO4BNNzG
	4ODBhZg0cpAzpsMec3/nTKBd+0RMp76AI+hxjIvppR5W/qiQHjaVAE7Ik4us/4UDuNlEDePZH8E
	6knoKZWlsui3XVcKvvPt5FsQK9zc6rsx0f0SjJasWYd8aAdi4n4kEvQ==
X-Gm-Gg: ASbGncuJyAFbMcKM3W8VRE4VJ7D7I+/xYjultbAhQ/n14L8LipliIxhH9WiXpylZe0A
	q6i9S/vVXnfLUBv5TlxzUw+L1LwfkAeoqXFl7Vds9NlMNB2qGz6sikCUVR0740DjxF55lSJbyWu
	/nlCjzM4D9aDGBjnNqecWC8V6LP74jC7tV5eUnK3H3fLvwsk13qA6wOBCnhdVa98Hd4oc3a15uj
	Se7ZrvKcWvy5VQ7TPGw8ykLnKaBOd7qtazzm1XsLFIIWIxT922BHvlNNOWV8o07X13sybAosy5x
	0UrfxJ3vV/M6aP9NsNxzAj5E0Ok0rrYL4Ec=
X-Received: by 2002:a05:600c:3485:b0:439:5736:454d with SMTP id 5b1f17b1804b1-43960d7da53mr26850405e9.1.1739449596974;
        Thu, 13 Feb 2025 04:26:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2t5vG5oik5wiNL4Wj3F5RKYuWhD0Di7fEhtXDr94Qm7SdBE6dVVsNEXYaBZYdboLIClF0rQ==
X-Received: by 2002:a05:600c:3485:b0:439:5736:454d with SMTP id 5b1f17b1804b1-43960d7da53mr26850185e9.1.1739449596616;
        Thu, 13 Feb 2025 04:26:36 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1c2aasm56592615e9.0.2025.02.13.04.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 04:26:36 -0800 (PST)
Message-ID: <738fed19-378f-4aa9-8d42-5c18b8ea321d@redhat.com>
Date: Thu, 13 Feb 2025 13:26:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 3/6] net: napi: add CPU affinity to
 napi_config
To: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, davem@davemloft.net,
 michael.chan@broadcom.com, tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com, pavan.chebbi@broadcom.com
References: <20250211210657.428439-1-ahmed.zaki@intel.com>
 <20250211210657.428439-4-ahmed.zaki@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250211210657.428439-4-ahmed.zaki@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 10:06 PM, Ahmed Zaki wrote:
> @@ -394,10 +395,8 @@ struct napi_struct {
>  	struct list_head	dev_list;
>  	struct hlist_node	napi_hash_node;
>  	int			irq;
> -#ifdef CONFIG_RFS_ACCEL
>  	struct irq_affinity_notify notify;
>  	int			napi_rmap_idx;
> -#endif

I'm sorry for the late doubt, but it's not clear to me why you need to
add the #ifdef in the previous patch ?!?

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 209296cef3cd..d2c942bbd5e6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6871,28 +6871,39 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
>  }
>  EXPORT_SYMBOL(netif_queue_set_napi);
>  
> -#ifdef CONFIG_RFS_ACCEL
>  static void
> -netif_irq_cpu_rmap_notify(struct irq_affinity_notify *notify,
> -			  const cpumask_t *mask)
> +netif_napi_irq_notify(struct irq_affinity_notify *notify,
> +		      const cpumask_t *mask)
>  {
>  	struct napi_struct *napi =
>  		container_of(notify, struct napi_struct, notify);
> +#ifdef CONFIG_RFS_ACCEL
>  	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
>  	int err;
> +#endif
>  
> -	err = cpu_rmap_update(rmap, napi->napi_rmap_idx, mask);
> -	if (err)
> -		netdev_warn(napi->dev, "RMAP update failed (%d)\n",
> -			    err);
> +	if (napi->config && napi->dev->irq_affinity_auto)
> +		cpumask_copy(&napi->config->affinity_mask, mask);
> +
> +#ifdef CONFIG_RFS_ACCEL
> +	if (napi->dev->rx_cpu_rmap_auto) {
> +		err = cpu_rmap_update(rmap, napi->napi_rmap_idx, mask);
> +		if (err)
> +			netdev_warn(napi->dev, "RMAP update failed (%d)\n",
> +				    err);
> +	}
> +#endif

Minor nit: if you provide a netif_rx_cpu_rmap() helper returning
dev->rx_cpu_rmap or NULL for !CONFIG_RFS_ACCEL build, you can avoid the
above 2 ifdefs and possibly more below.

> @@ -6915,7 +6926,6 @@ static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
>  	if (rc)
>  		goto err_set;
>  
> -	set_bit(NAPI_STATE_HAS_NOTIFIER, &napi->state);

Minor nit: I think it would be better if the previous patch would add
directly this line in netif_napi_set_irq_locked() (avoding the removal
here).

/P


