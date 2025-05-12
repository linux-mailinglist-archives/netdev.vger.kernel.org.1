Return-Path: <netdev+bounces-189774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897E2AB3A52
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF3D189D408
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603BA21517C;
	Mon, 12 May 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx4iblAG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32E215181
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059650; cv=none; b=rg2N9dSXJiP2oqgk8gWR+Zt3+YNQazcFL+x4Kujp/2arroHeGnqLqDBOe2uylnCgj7vIcNTfJHGEEykm1qvS+oNZqDLSD8PQ9pCKt3LI9goSK0n3mZEkTV3A6iIltGCkw5zxCw9tC1bnqCKB00S0tsPZf0VulyS+lds3Wp3sdGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059650; c=relaxed/simple;
	bh=SfQtLLV5Xv6SefUlfYM5OvYPQt5ibmnTST2aljjwdTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZFiNwwO83B9Wr/YdGFq3o//3R2IDQMJb/0wL75q/j7jAPQHQpCqYMNloRry1T6rKO43gYTtZpFHkbtdKsSrWeiBWVTgVdfMtURCjXq12xWv+CqxSCofnVTbzqI4rpyCV5X5hJvjxnCIyuDGVCccHuVBsMy8yrD/FRDiEpOFJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx4iblAG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736c277331eso4794414b3a.1
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747059648; x=1747664448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEb9RKouaYUUh89Uq5bdAUEgyRZ+BB48LykVGqfnado=;
        b=gx4iblAGThLkeIirSayolUVRiuSr/92ahytvTG1m1Jlr0JNQbajYBKX8s+znZUtaAE
         mGiJWUB+s7lJTHBEkHODMu+e7tdileVZedpM8VYfoc+xf6aTE1F5kTpSw/8YGxAkQY2S
         FfTzEPOqt8sSl1/xVNC/A2BxLHBmTqlrC+WZNu/cDMNz9YQL2MWP5eIp19UctxpLuUaf
         o6NKWPRN9SUaJX3O0kKpF2XFWTSQR9hkKDa4Bnu3x4lVofY2HouC+EMDtsVCE6TC1miH
         ehBiV4j9/otaWa5jhp10CrLTbizWow5jO766huAHMli36W97lRS9I6/aXkqVxiOqhsJu
         lSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747059648; x=1747664448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEb9RKouaYUUh89Uq5bdAUEgyRZ+BB48LykVGqfnado=;
        b=p6tnfafgArTikiVXvzLvHlFt7YEA8OlpQEOApDzDLl0K+OZ/j8T6N9Kqts0b+nTbq4
         juulYkCdKGtN+E/kqdlKTjSxHcJEx/ChU+6h7hRaaS6d2AGqzZV3XwJB8CcmwW5OLpCT
         LM+JDBhDAdgT4hM+UAGXtuVbxrZ/dImo3KqfM8CZXpQwZvX9fawazVawMjwnFL+y884q
         6YICvyy1O6zi72cOetB4Tqo0bnPKbwJCXQXuC6lMFv4qLnkjh/ZhvEQc7+6aU1WxKVBG
         ujFjvomrGr0+WuXi7fv+T6L0iXilprFwQ2/UgKd+jTiwPiIZzVEiGiuOpBcjEA95dujA
         +akw==
X-Forwarded-Encrypted: i=1; AJvYcCUSmGanALX+KoTghwgNyYoDL9aeqxpAJv1JRT/pu0Y3VnJ2UslFpFjrXHLWfKUvpCojHKFW85o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyovUx35QibAwo5OFsxdpbowyiZQbgQGFMoSur2EWZKtyjrK2pz
	/mSuF/Zjk5do27Q+QQFG0KjV5DnzjsEGZSLTM8jHrNbVDf9FkPgJCBaV
X-Gm-Gg: ASbGncvPgnH1jn2z8i6XSz5ATtR6W//87avEgk3N16awZYtpgO9VyF6dVL3s7ZWILHO
	vnq25ey0Q3Uy8WQcv08cR43Btfxp0cpkQQm41sZkZ/VCpGbBE8T4xe01w/8RhG4hDTnOPs/b85Y
	F+EOyccC54mC/TSNaic2LpI4hF44asuaQQFhutWU2i1qvFPbrvhNUGuiZr5QQRqhy/ZTg5YMxda
	jo9KHkqIFQWGZyzE5xaM/dbh9fGtIUfs7MlRqK2kA2TJOsMxtFVHR3FKr8WYEp7OQS78qYBk5+b
	72GhNh5YzXqNUcvEGsd3+epXSV01ZY+HAHM71DowSbXquhrnx+PC7YV3rwNPDwgsD9Aee4Gmudf
	lB2kczr8cejGVVnKIIcFxEo0=
X-Google-Smtp-Source: AGHT+IGx0Pa9zKIcPTvNUkSQUu0+zse4WaYDRLfr9YhrclGYhp91O8uu/S21+M6dE+kAuqox08QzCQ==
X-Received: by 2002:a05:6a20:111f:b0:215:d41d:9183 with SMTP id adf61e73a8af0-215d41d9208mr5238115637.1.1747059647752;
        Mon, 12 May 2025 07:20:47 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74237a8f4bcsm6029217b3a.159.2025.05.12.07.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:20:47 -0700 (PDT)
Date: Mon, 12 May 2025 07:20:46 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	sdf@fomichev.me, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net] bnxt_en: bring back rtnl_lock() in
 bnxt_fw_reset_task()
Message-ID: <aCIDvir-w1qBQo3m@mini-arch>
References: <20250512063755.2649126-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512063755.2649126-1-michael.chan@broadcom.com>

On 05/11, Michael Chan wrote:
> RTNL assertion failed in netif_set_real_num_tx_queues() in the
> error recovery path:
> 
> RTNL: assertion failed at net/core/dev.c (3178)
> WARNING: CPU: 3 PID: 3392 at net/core/dev.c:3178 netif_set_real_num_tx_queues+0x1fd/0x210
> 
> Call Trace:
>  <TASK>
>  ? __pfx_bnxt_msix+0x10/0x10 [bnxt_en]
>  __bnxt_open_nic+0x1ef/0xb20 [bnxt_en]
>  bnxt_open+0xda/0x130 [bnxt_en]
>  bnxt_fw_reset_task+0x21f/0x780 [bnxt_en]
>  process_scheduled_works+0x9d/0x400
> 
> Bring back the rtnl_lock() for now in bnxt_fw_reset_task().
> 
> Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 86a5de44b6f3..8df602663e0d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14960,15 +14960,17 @@ static void bnxt_fw_reset_task(struct work_struct *work)
>  		bp->fw_reset_state = BNXT_FW_RESET_STATE_OPENING;
>  		fallthrough;
>  	case BNXT_FW_RESET_STATE_OPENING:
> -		while (!netdev_trylock(bp->dev)) {
> +		while (!rtnl_trylock()) {
>  			bnxt_queue_fw_reset_work(bp, HZ / 10);
>  			return;
>  		}
> +		netdev_lock(bp->dev);
>  		rc = bnxt_open(bp->dev);
>  		if (rc) {
>  			netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
>  			bnxt_fw_reset_abort(bp, rc);
>  			netdev_unlock(bp->dev);
> +			rtnl_unlock();
>  			goto ulp_start;
>  		}
>  
> @@ -14988,6 +14990,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
>  			bnxt_dl_health_fw_status_update(bp, true);
>  		}
>  		netdev_unlock(bp->dev);
> +		rtnl_unlock();
>  		bnxt_ulp_start(bp, 0);
>  		bnxt_reenable_sriov(bp);
>  		netdev_lock(bp->dev);
> -- 
> 2.30.1
> 

Will the following work instead? netdev_ops_assert_locked should take
care of asserting either ops lock or rtnl lock depending on the device
properties.

diff --git a/net/core/dev.c b/net/core/dev.c
index c9013632296f..d8d29729c685 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3177,7 +3177,6 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 
 	if (dev->reg_state == NETREG_REGISTERED ||
 	    dev->reg_state == NETREG_UNREGISTERING) {
-		ASSERT_RTNL();
 		netdev_ops_assert_locked(dev);
 
 		rc = netdev_queue_update_kobjects(dev, dev->real_num_tx_queues,
@@ -3227,7 +3226,6 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 		return -EINVAL;
 
 	if (dev->reg_state == NETREG_REGISTERED) {
-		ASSERT_RTNL();
 		netdev_ops_assert_locked(dev);
 
 		rc = net_rx_queue_update_kobjects(dev, dev->real_num_rx_queues,

