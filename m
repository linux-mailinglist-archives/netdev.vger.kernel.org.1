Return-Path: <netdev+bounces-207469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC39B07794
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2C31C26837
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2BD21C16A;
	Wed, 16 Jul 2025 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdlgX3dk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30B31C2335;
	Wed, 16 Jul 2025 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674736; cv=none; b=gFo9mn5lTjbn1hJy+OkK35TY4yXflE5LWfoTQ77/TrpqROoS9HJaS9+8Iw8R+XD9M2q43KjJH1cNyFelRRlJdEGmHIRTrBOtd4a1gv4Bd7XLmRdcCvDN0KGjiVCZSNuA9Tjk3q8jZiTOKABAJIO6IJnuN4RmPiLftAD/diXI6Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674736; c=relaxed/simple;
	bh=9xnLeBla/FFMBBo7v10c52NMg8azTE2NYd7eJgAUNVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG2rdl/Z0zqEfGYXS0cXIv0bchEh7Cf+JsKRYeUKjBx5j4XDg+q4y7KmCYJltrV2hr0cg5NzKTgKff6QfFlfBsGcGtSp5WxrHv4Vkk528f3wtioQuV469CDpu8IaI8FmBScGguXiV4jTjMu06tq/sSU+us5PyASqsIr5VPMIr9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdlgX3dk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so5949958b3a.0;
        Wed, 16 Jul 2025 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752674734; x=1753279534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qngeXK27KFOZ6peAoX++OdVfM+ufKRNsR7T6dP/zpzQ=;
        b=bdlgX3dkO1uzHQ9gpc1TctzQLihmGi83gMsWGPvUA3lp9MncrAMrGukrZzFNDaMidU
         rX7pek5Ig9YBkUpjB4eehpYZGSSgkgWVE/3nVziQcgng+cortdxk4ucBdr0MsXFHDnrC
         enOOKgmJtyWMsjjmVkbcOnWplnT6w8QeYQFon/tFPjr22uf6hdnthBbNUuH9m8tTjrmI
         mgvC3lvbdWleFQTmhJvvgyflj3qlwQ8ahMHxKLW+4nQcf5eXwyooGPMPUIkvBNG7a6zv
         7ir0qL4M1bW9f84G5jvr1W0+YA5ERUHuwhpEWwU0pANpWobaQXcds2E8dxysJg2Py/q4
         N09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674734; x=1753279534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qngeXK27KFOZ6peAoX++OdVfM+ufKRNsR7T6dP/zpzQ=;
        b=et/5U2nqinikrH5gf+ugrk24hGSsm4xA0Cr135vAiGAcq1aq0Q8VO4LihuQ1CQrlpn
         IUjAulBd8XE17DX38gBR3w9OGadJuY5YQho84j9IhfTocXkJsJl9x6tHC5ImkipJw5Ru
         mhYVGNaO/GmdE7IE3sD5q0+2zj0+N1Haqqw1tW/QoOkoVLynNZakstiW7Hlnfq2Dv5ey
         5AtqKw5LjUpVaW5v8LouAGvVpjR+MyiiREeOJ7w4WPr+EROGsrZDgGdujt8XGBX5vgox
         zXJB2436Y1MC5AvQlaxGePIaKGcMoPuWzL6Dhrn5toWRWsFFj/2DColVoAwj3WGrW/TQ
         MMog==
X-Forwarded-Encrypted: i=1; AJvYcCWeMbKStSJDHBzbqU1guoky8g0YJDwQNe9zkqtNPemsGQbXfxSWRqej0b7iWuHH9TSV2bbsILDV@vger.kernel.org, AJvYcCXV3vCmhy8XGpBRiaebAxEUbNS63fICwqjHrzA6tQ/wqnDrM+CxknQhadrMDH9MvHPf5+wLp6WsJNB03XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuVJEdoF4nz7lO7+nVfnJnNpv2TGBw4PAvwdWs8g1Fj55vxoli
	qHxsxSaTL8h9Eljz2N8o/xWrMN8QGBi6yagbXOlTyAZVbzt0nJRQh5SfSExzF03H
X-Gm-Gg: ASbGnctoOyTfG+DbYsEMNTZxV++0dosf+8b2d3bR0T7t0NSO/EOe+uG1NsCU5/BrNwu
	tcsGvP0vuTIcwntmSK6wu4a1i6PSK8Ti5qM/HoRnJmMXNk5QB4MOoSlClL1SMovuKsRWBo9MqkG
	yTAAXjJAwukkGTCPEEvA7z8aUvca7CbPIPStZRqifx+VaswKDpYGJZhiekOX5vTZXsYmzuHnfvL
	cwOVf9wEJ2+yALGDmGee7+Mvm7a0Yx3d7B3m+BKod45NeMPzrXhuioV24WXE7pj+Puec0zUBw5+
	0XuN78FlGCQbyY2A4zIiV3z9GGcS0UNmA7JR9OEHyITQAsIxFbKQVnBhTgw18PIr87F90yFKkPl
	KMgZGJhfQkTTqrQVhdI9YVZXfMzA=
X-Google-Smtp-Source: AGHT+IEPRDlnRInkBbptUzd6OmEvFdGjOYJJ6agFhxVJBBcA22kFZ0bVG2Q4o4Ceq94Kr8Zs+aiIlQ==
X-Received: by 2002:a05:6a21:6494:b0:237:b321:1e0 with SMTP id adf61e73a8af0-237d661c82amr4911939637.17.1752674733709;
        Wed, 16 Jul 2025 07:05:33 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm12382332b3a.76.2025.07.16.07.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:05:33 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:05:26 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ipv6: mcast: Simplify
 mld_clear_{report|query}()
Message-ID: <aHexpi793R81UrAt@fedora>
References: <20250715120709.3941510-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715120709.3941510-1-yuehaibing@huawei.com>

On Tue, Jul 15, 2025 at 08:07:09PM +0800, Yue Haibing wrote:
> Use __skb_queue_purge() instead of re-implementing it. Note that it uses
> kfree_skb_reason() instead of kfree_skb() internally, and pass
> SKB_DROP_REASON_QUEUE_PURGE drop reason to the kfree_skb tracepoint.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v2: Add drop reason note
> ---
>  net/ipv6/mcast.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 8aecdd85a6ae..36ca27496b3c 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -845,21 +845,15 @@ static void mld_clear_delrec(struct inet6_dev *idev)
>  
>  static void mld_clear_query(struct inet6_dev *idev)
>  {
> -	struct sk_buff *skb;
> -
>  	spin_lock_bh(&idev->mc_query_lock);
> -	while ((skb = __skb_dequeue(&idev->mc_query_queue)))
> -		kfree_skb(skb);
> +	__skb_queue_purge(&idev->mc_query_queue);
>  	spin_unlock_bh(&idev->mc_query_lock);
>  }
>  
>  static void mld_clear_report(struct inet6_dev *idev)
>  {
> -	struct sk_buff *skb;
> -
>  	spin_lock_bh(&idev->mc_report_lock);
> -	while ((skb = __skb_dequeue(&idev->mc_report_queue)))
> -		kfree_skb(skb);
> +	__skb_queue_purge(&idev->mc_report_queue);
>  	spin_unlock_bh(&idev->mc_report_lock);
>  }
>  
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

