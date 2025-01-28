Return-Path: <netdev+bounces-161301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E2A208E4
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAB918847C4
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF33188CA9;
	Tue, 28 Jan 2025 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNSPBpIL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A619ADB0
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738061273; cv=none; b=DhSi6sVTmGa+vvJIJdFSU5NO1JKDqAxWHo2Q5Jnmnf8Sqi19DCWmd+WNtVh2IPxZn4S08d4stHdorkFiL4MkvHS6bWXyGXg0QTGwqEnnY8174MwV7ohMQrkx43F6H6Fh+hO9v/yy6QiiLzgcizpLCDpGCxB13+YmBayyf8Tcm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738061273; c=relaxed/simple;
	bh=HP90OcOHcFAOlSNCgyDknUeF3odb/iX69QRWvitG1Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRWWktfTSO3KTO+hCjSftS14vvWRoiBSxCpCaR5P8p85490h4JjSOHhSPewL8wvnln4iQ3Xg25kOoRCLBnabMOvVIWIUrC1cYFiLL7haavI2zXhbfxpcKmFq94NSZvxyQeO+4YHNZczPYKWdLJVCLpxGroW/BOD69e+2y1YtnS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNSPBpIL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738061270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWQ0ihpGpO21seLBQCed0Ou2kpJonW2uY4Y9Srpr4ik=;
	b=VNSPBpILBZRBG4Rmb0hVZS/T+Cv+JduKJP7L0KOkQjtK5f8jN1rk/EmwFYjt4colgVCl4Y
	BFyDbOtMRSgKL0Zm+goIEncoAWc07+8FXIHsrB9K9RtSGTUBPg5JEU9XcKsO30a+75w0xf
	RSd5yxoUv2sguxtW2AHPU8F9XdQy/Ys=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-ER5r8xCMOWu5loC3luv_dg-1; Tue, 28 Jan 2025 05:47:49 -0500
X-MC-Unique: ER5r8xCMOWu5loC3luv_dg-1
X-Mimecast-MFC-AGG-ID: ER5r8xCMOWu5loC3luv_dg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4362153dcd6so27813125e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 02:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738061268; x=1738666068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWQ0ihpGpO21seLBQCed0Ou2kpJonW2uY4Y9Srpr4ik=;
        b=XWQgA0ahpzYMIzwK5T0SEvUYFRNzDRqdTe7uLCFTE/uX5ObdfWNzq40Yj0dlcPPxOo
         dEIyxB11lZBFUMPiLZtxNDN8pnvwJc27Sj0wLe10Y1qnej2/D+5WyupqPlOyObDorvz5
         /T7Laq2JT/vFGeKPAz5g7ch46E1YaXQz5fwJBNiiTt3d0F2HMauEOf8vbaN4KgZyBUxR
         oqgkq4sm4sEU6pUcuUyWfXFX5+m1xCtiyDL5j28XBdWCBka7XZ5KZGEpVfUld3bNet2r
         M34J7zijypEcMUDZnC1hXYMTbux7F4KXexU7CGVRtwm4zDiw9izoI8IMWXch3JFUknUp
         3+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiBodQFCxPiFJHbLQG0tCCENSRowKi9MZR2/+J99vGVCEe0i1KdAwSyX2ykSwtwfo3nRTYtrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0Dc5Z+sPrWGcmHP/7hHXdWRDys2msPOU6YJT0Q+mgN+sBZca
	3GR2oLfQ/Zpb+OY5Flhaviw3pBJyysnI8LXAJFgP9hXYfUhDSpnHQAEmIeJw/2DxkulTgfO2Lcl
	+29ENqZHghupaamRyJAbxUFN76wVndPvFd2oFqk78fmu/DVwuwSA7aw==
X-Gm-Gg: ASbGncuaAae4r+dTNJhCVmnjHSlfFwB1DJXmYFbxVOD7TfYpvqLHjEpo4hwuDqB3qdF
	2eCGHM+MFLKVX7XNylpIZfs4yOVV8Ewa5z3qVjkFYLWW5PyebhVQaEXeWOMto5CAg3XPM1BWUvK
	ejoetJhVHlihJ7DEpTkd+nZvCpw/2h7YvBqj7Pui8zg2dXQfwuh7BbFYwgIW+Wt5H5VRdr/gkFd
	pUN6DLhlD/U9b3n4Oiwd0P9BuADPKGHMC52hugj5KjMOR8bicyxiaUmlejjjWtREyUXj360Cmks
	QZ3lDMa3dZL6Yxor9dHW88v6akcCE53GYBA=
X-Received: by 2002:a05:600c:3495:b0:434:a315:19c with SMTP id 5b1f17b1804b1-438913bdb0emr392319625e9.3.1738061267905;
        Tue, 28 Jan 2025 02:47:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfpF8y2CKT7XcJmqqjAg4t+V7DDDQQWuN/Rs/6h2ZaxFYDfNi1pmHGQZn1TUOOoFipdTcdSg==
X-Received: by 2002:a05:600c:3495:b0:434:a315:19c with SMTP id 5b1f17b1804b1-438913bdb0emr392319425e9.3.1738061267537;
        Tue, 28 Jan 2025 02:47:47 -0800 (PST)
Received: from [192.168.88.253] (146-241-48-130.dyn.eolo.it. [146.241.48.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4d3393sm162551155e9.37.2025.01.28.02.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 02:47:47 -0800 (PST)
Message-ID: <32e872e1-e842-4839-beeb-a1e9f235ed42@redhat.com>
Date: Tue, 28 Jan 2025 11:47:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mv643xx_eth: implement descriptor cleanup in
 txq_submit_tso
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>,
 sebastian.hesselbarth@gmail.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org
References: <20250124062414.195101-1-dheeraj.linuxdev@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250124062414.195101-1-dheeraj.linuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/25 7:24 AM, Dheeraj Reddy Jonnalagadda wrote:
> Implement cleanup of used descriptors in the error path of txq_submit_tso.
> 
> Fixes: 3ae8f4e0b98b ("net: mv643xx_eth: Implement software TSO")
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  drivers/net/ethernet/marvell/mv643xx_eth.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index 67a6ff07c83d..8d217f8d451e 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -881,10 +881,20 @@ static int txq_submit_tso(struct tx_queue *txq, struct sk_buff *skb,
>  	txq_enable(txq);
>  	txq->tx_desc_count += desc_count;
>  	return 0;
> +
>  err_release:
> -	/* TODO: Release all used data descriptors; header descriptors must not
> +	/* Release all used data descriptors; header descriptors must not
>  	 * be DMA-unmapped.
>  	 */
> +	for (int i = 0; i < desc_count; i++) {

Please move the 'i' variable definition into the initial definition for
this function.

> +		int desc_index = (txq->tx_curr_desc + i) % txq->tx_ring_size;

AFAICS we reach here when the first `desc_count - 1` descriptor for the
current TSO packet has been filled and filling the `desc_count`th one,
in the `txq->tx_curr_desc` index failed.

Given the above, you should free the previous `desc_count - 1`
descriptors, i.e. txq->tx_curr_desc - i.

> +		struct tx_desc *desc = &txq->tx_desc_area[desc_index];
> +		desc->cmd_sts = 0; /* Reset the descriptor */

It looks like you should still unmap data descriptor as done in
txq_reclaim()

/P


