Return-Path: <netdev+bounces-169385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43479A43A41
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63783B2300
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE71FE465;
	Tue, 25 Feb 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="WkOHmzOu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485525A2CD
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476840; cv=none; b=FtTwPnMpSXmXVmLdhiTM/5OK2/KnKErNbADfscXAy9WZFY+9qUWPU1+uksDnXsvwMNAQI0YsNr5kqcjRtsyWT8o6a4ffJQgWfySgy3SdkJ2r0xwAq5jDKuVF/dTV+xYBkUC26+zQEYGLnO+Yel72ODNr+ZrHkcXLUYOV0gE5m2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476840; c=relaxed/simple;
	bh=1IHwqesQk08lufeZTBYIk2f7P1gwtjDf0lQkrtr/4QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fg2oleUKTtpFvOIaJ+X2OA1EmKnKS3Pe2yYnCmUP4Rd/zM5mp87WilZ6ATjhtO5/uNRm/h0dqYSW8clRb0Z5cd++mRoFGQ9Q1bD/mTUDtbVKZ20KPdRAD7zWlPLBM6kLGVLLYvAZTpWm5pW1/5B+Lwj2G1manXMTKT76oOIMQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=WkOHmzOu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso33425135e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 01:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740476837; x=1741081637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bU6pYEvOEizzQLjYkTI7JJD3Z+QYLCwitlQcIgyNBJQ=;
        b=WkOHmzOumY1waLkpjZw3tzL3PpXCVevPmR4kQrkd5p5vU/JgrqVMCrTBZYJMX0Nt8H
         8thHkM3Bq/e6U9llu74NZwYlZuBJQhb9y44XqMsXlGXWJt9FH0DFjX6PiD+UYThczyAB
         uJhizL991Q15oSU5f1BXEroqPXTdjg3OoOvZhH6zTy5ULmYXBFJK0iutp6KlBzba2iX/
         n/SOxo6jpikliu/BZaO4khcBuCEBV0rjOTIY8eKDUqKNkWL7JvFficEcwMXARJ18iNV+
         jQDxKq0GROiELff3l6ovzhG0WWdlfowseAbmxr+CuDLcroMnoEBCRRwZoSMVLT4eSdRh
         gjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476837; x=1741081637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bU6pYEvOEizzQLjYkTI7JJD3Z+QYLCwitlQcIgyNBJQ=;
        b=dF+6/pXblW3dEfiZRNgtG4R+tkDQ4angBaPwXAFOmgsdtlhMHeGZZ2PcESJXGmi/mn
         QBKmCuAypD468ddTh337yMcMkCFtNf1ziwEGEjbUpwd2Qr6uQPYNNMjDzxpPXNBC6KZ4
         1H+70/IvFUvEzs1cx5QXN3DMT74/+gqr9I6QG3QFddceXsggOMO2HZz7Y4HcFI3IKzpz
         oWAFokMGlpXN54TE4MdXsyjbz5nHW+o1iZmMe7vfAUo5SKd6vSEFiCuUiLdr+ujfC03m
         xojRpUI+DHAuFl0i93Ny1e5U94vd5CX5PQvDG/SB5KSibsBZUuHE8DEQGsWDGEh654Yy
         R/ug==
X-Forwarded-Encrypted: i=1; AJvYcCWWjJaCDHr0PGE+aCrGMKWcF+T7VYNYNXH6JWX1Lxp/S8ZmySWv5sqwda+M0PygONDOOQA3tNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhjj1tgGc0v18LhfxypUxBq+CY1A+EtAHtLmEof7BTb3QjU2NJ
	0Tij73BliPBhxYKsMHzgS5fVhFbDuGXebepLqKMrepka7CaVYBH/cvbsWykLHoy2gFk9i3Q+K1l
	r
X-Gm-Gg: ASbGncussxeC1VKTvYtQ5u/ErtwfSlto1EXztDsJ9kjaKURKFwovBxjLtxWKt0KIIzU
	XzUuH7FAqlXks8f5kvrHaAbVMdiu3O/1qwTxRBA+egnyVxXWi+33mjdTvrIZT5wRN0vjo4hgCNa
	nCya4Wbar314brrA//lQSDmELjVTMU1qhWTyM9aBjzupOmLBI97QXwg2KPZWSgfzUwbK0at+BJM
	/Q8/UbrobC2uk12yiEHdLqKlYkqQsQYW1Wk4Thhd8fOaiq0/pQqWPf5jo7j+5HaQ+ItH8hnvnPN
	/mnSIvbznWxILYCVYvcp2LVitP0Dsujcj2UQwGeb4vm0DrfF8ZUkh6T4ag==
X-Google-Smtp-Source: AGHT+IEH9BuTR7e3cX9hlXLEtnZAxiSr3msyKmpW1dMtJNLMv3DVluSpKIXlP3IFKnIPJE4Vi+6X+w==
X-Received: by 2002:a05:600c:1c18:b0:439:96b2:e8f with SMTP id 5b1f17b1804b1-439ae21d19fmr131970375e9.28.1740476837202;
        Tue, 25 Feb 2025 01:47:17 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce740sm134182475e9.4.2025.02.25.01.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 01:47:16 -0800 (PST)
Message-ID: <2907ae61-5e67-4db7-89df-821da999fbf1@blackwall.org>
Date: Tue, 25 Feb 2025 11:47:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next] bonding: report duplicate MAC address in all
 situations
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20250225033914.18617-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250225033914.18617-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/25/25 05:39, Hangbin Liu wrote:
> Normally, a bond uses the MAC address of the first added slave as the bond’s
> MAC address. And the bond will set active slave’s MAC address to bond’s
> address if fail_over_mac is set to none (0) or follow (2).
> 
> When the first slave is removed, the bond will still use the removed slave’s
> MAC address, which can lead to a duplicate MAC address and potentially cause
> issues with the switch. To avoid confusion, let's warn the user in all
> situations, including when fail_over_mac is set to 2 or not in active-backup
> mode.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> 
> v2: add fail_over_mac != BOND_FOM_ACTIVE to condition (Jakub Kicinski)
> 
> ---
>  drivers/net/bonding/bond_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7d716e90a84c..7d98fee5a27f 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2548,7 +2548,7 @@ static int __bond_release_one(struct net_device *bond_dev,
>  
>  	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
>  
> -	if (!all && (!bond->params.fail_over_mac ||
> +	if (!all && (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
>  		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
>  		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
>  		    bond_has_slaves(bond))

LGTM,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


