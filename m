Return-Path: <netdev+bounces-177523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9841CA7071F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B280E16D7F9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3C25D8F7;
	Tue, 25 Mar 2025 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2SJfsWo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D11FAC4E
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920655; cv=none; b=sy3pEbSSkelIszDrlThhTbba0l3g+Uh0EPRHVVyf9ZyyRFDB+zzCAOjuuRCcUQim9F1yMsDNs/DjKwwJ7oXjp53NRcQCIJ0QweJsuUM5pz0BuPz9YLvvZFDIiVRFguENe+Bs9J0Oits+UD9dVFPQFjAchEl42gZm8Hqutv9tbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920655; c=relaxed/simple;
	bh=z1Ad17fYuT6xHAw45tVLyuFWdPbb7io5XRKBX5/8HMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SV1EcRLFb9ZAD1MS71V3anmiCSqNSaXupcbI+SrB/RpsplFmqzjPnrpSZRLHCISOCcQi4e6MCeYA3Mf28URnAm7ixOOj+CS3Dt/TaCHJfrjdJ8Zc3t1IdPRySZKxmF824NiXN7hbUWyNiUStCv524028enya+nvc/XFcoBpjvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2SJfsWo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22398e09e39so121725975ad.3
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742920653; x=1743525453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2/Rqe5oG7Nhyk5jqpxC4eUXHUH/un/N1HYHJwWY5tU=;
        b=M2SJfsWozMWBcL+5WrmkTSWbQdlC+AZI/cGgnQt3hzsvlllFhBF/3RiWWzqgWmatIR
         RoWnmYLnlt+2VephMFG6VuzToUnMIBQ9HLQ84bI6BAuvLR1a51Y9aNshfM9AawazuXDN
         paCNg6H5S0oIEbul7lpUSChIIof+Dx1Djom7VmNNbFtg5crlOORy2ayxRGxoMsMCDdyt
         q4lsqyaPW99o3damW/e8DPw6qQ/Ij6Q1A+k0Hc0zQi2+K29eOrj29qM6B9jIvuLVeXiN
         jJrLtBkkDb2Q3wu4yRMLy3w1T7mc9fy++yJgbFwQmG2mzQsOICFJ32LqQ1wN81HjANk4
         L1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920653; x=1743525453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2/Rqe5oG7Nhyk5jqpxC4eUXHUH/un/N1HYHJwWY5tU=;
        b=VHzyJnOu0j21UZ7hktp4MqOhvLkaDISaEkVI+9VkmmbhYbjPBdfo0DN6aGux16uAwL
         tzUJZXKdjLMMeaJX4EFMDUVdWMsS2bW4FMpwUTL8DdTf219XVYZd6T9eP40mmjr282a3
         CB4LxpB0vs3IHbssZO2FtP9iqGRlnWe1s6reNFC7aFBtlxH+nZYeAsI7FhsMKWWg6uTG
         Jvq6e6ONVSdFPSN+PqJgcbDlzj0Gh8ovowdoA8AXuLgE28mrhY0D39kAkbyrfZUi89oG
         oB4hHVtOOTSQMxl6ao3+frFtmLeOyurYV8AN8Je78gu4WLcMB/86V53rclt5V+4v8Uo5
         w6KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpGp1Tbx9Ell3ek3qqSV4diYZcw9p3sDcE3dTZaN8G9MliE9dabX7L6V9iCz0Y6MbDqMX/Hzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyopCJqRycXcqsfbfU52m+VroZQXmo7daoPv4Wnzv5gUOIjpCaW
	ChbWgZC1SMmluh1PFU0MP1nsZdgOLT8ziYMp9BD+TfDQXq6dTV4=
X-Gm-Gg: ASbGncuvuRIzd6n4F4+l2cmkPbTrv5ZFSMsNdA/cq1MI5YSiIUo1uuDnZxqdV+t1PUE
	Tf7XxhTHQvf2jVau77rnhfCiYc+r4sd06k/oassHYD9xfIeAMyMvYRLCbjayWSkKC219WRXOzBk
	AdCkl9q931O1L7jIHhapTH3QKJZz4Wb2EeGZLKycTxQgs6tN7nAjEQ0ujos/N2fZo2DVAs4Fo/i
	OdNiw5u4SNJ4gri7gYzNpDMT4x3NPIAzrAOC09pWm6UeZaYXJfMb2/GSbGWUvh1s0W3CQdPYkhQ
	SFySI/bea/8T643qIIK/IduZIMeZl8vZj6q3xI3gNDnmrDAv6t/dnYY=
X-Google-Smtp-Source: AGHT+IGtaLkY5Bc6MXuoJqd+u4KTEE3dBcm48qQ3D+3PC7wM7bNhEt00vQQjbNUsVUHLS+XnIGDEpQ==
X-Received: by 2002:a17:902:dad2:b0:223:2361:e855 with SMTP id d9443c01a7336-22780e17b3amr280292305ad.39.1742920652999;
        Tue, 25 Mar 2025 09:37:32 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f50c80sm92621805ad.104.2025.03.25.09.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:37:32 -0700 (PDT)
Date: Tue, 25 Mar 2025 09:37:31 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
	mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] xsk: Bring back busy polling support in XDP_COPY
Message-ID: <Z-Lby6WMFkHaaJxB@mini-arch>
References: <20250325044358.2675384-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325044358.2675384-1-skhawaja@google.com>

On 03/25, Samiullah Khawaja wrote:
> Commit 5ef44b3cb43b ("xsk: Bring back busy polling support") fixed the
> busy polling support in xsk for XDP_ZEROCOPY after it was broken in
> commit 86e25f40aa1e ("net: napi: Add napi_config"). The busy polling
> support with XDP_COPY remained broken since the napi_id setup in
> xsk_rcv_check was removed.
> 
> Bring back the setup of napi_id for XDP_COPY so socket level SO_BUSYPOLL
> can be used to poll the underlying napi.
> 
> Tested using AF_XDP support in virtio-net by running the xsk_rr AF_XDP
> benchmarking tool shared here:
> https://lore.kernel.org/all/20250320163523.3501305-1-skhawaja@google.com/T/
> 
> Enabled socket busy polling using following commands in qemu,
> 
> ```
> sudo ethtool -L eth0 combined 1
> sudo ethtool -G eth0 rx 1024
> echo 400 | sudo tee /proc/sys/net/core/busy_read
> echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> ```
> 
> Fixes: 5ef44b3cb43b ("xsk: Bring back busy polling support")
> Fixes: 86e25f40aa1e ("net: napi: Add napi_config")
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  net/xdp/xsk.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index e5d104ce7b82..de8bf97b2cb9 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -310,6 +310,18 @@ static bool xsk_is_bound(struct xdp_sock *xs)
>  	return false;
>  }
>  
> +static void __xsk_mark_napi_id_once(struct sock *sk, struct net_device *dev, u32 qid)
> +{
> +	struct netdev_rx_queue *rxq;
> +
> +	if (qid >= dev->real_num_rx_queues)
> +		return;
> +
> +	rxq = __netif_get_rx_queue(dev, qid);
> +	if (rxq->napi)
> +		__sk_mark_napi_id_once(sk, rxq->napi->napi_id);
> +}
> +
>  static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  {
>  	if (!xsk_is_bound(xs))
> @@ -323,6 +335,7 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  		return -ENOSPC;
>  	}

[..]

> +	__xsk_mark_napi_id_once(&xs->sk, xs->dev, xs->queue_id);
>  	return 0;
>  }

Can we move this part to a different place? __xsk_rcv maybe? So it
doesn't trigger for the zc case where napi is resolved at bind time.

