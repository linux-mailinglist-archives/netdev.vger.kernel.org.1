Return-Path: <netdev+bounces-221163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038CEB4AA4F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723EF17C0FE
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5943C31A07D;
	Tue,  9 Sep 2025 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="dr9Fl88t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8270F312805
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413185; cv=none; b=g357GBoseSEaf+tT/wRSzdsBLFuecz3I4iJPgu8G0pb9R8Tjjb+YpxgNskwTKX1vug9xWfkDYFLAiHcQwMyeo+n+WmoSfY81Bp4zX3eIZbe9eBkF/CsPRgJUQVeG30WyBndHtt9GtxzcQ7vYm/Oe32r5YWeg2XGo2ufQeq3AZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413185; c=relaxed/simple;
	bh=LH9K9rHh5Lg8l41iu3U0msyFwQbyezH6Y8MW0jdv+Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aha7NauY2lhRdWAK6shmESS+cSep6UaAoSIHsQ0FBb3F++TUBlXnpGxcZ7x6yb3aSSFsKk0MIqzJgy6v0YW6TkikZsNEhA3ykQbj2NOj5ilEkbe2prXZ3xeb6mUhrc6rL7Ku7unev2gMnRNa3ElBdoaip6aupfPfBjy2beqxZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=dr9Fl88t; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-560880bb751so5441640e87.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757413181; x=1758017981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ULW63TGOLMnn1ghgDwwFUv5dysPY5E+bfANPuLSHOWc=;
        b=dr9Fl88tcTeQIJGbqOKcodqv5CaphKlWh0ptmX0+T8mkyhkbod0ntk+OD2Kfl884uU
         FLo83DsLMtmepIEzudNDbGde0v/FpK1mHNnUb+byyzFAesAcAVVqFwCDXinLzfrsmq1V
         qVAvlkihUQFSyriRRRGzFB1meqbKprkvcE/rpP05HUuNW0hqxWt1bUNCOBvFMGhVaxGl
         2S+VbNNGXEuLRoK9vaCDqI0QRYYDANy48fIp5JFS6e/ugrgId+9eDASZ5TWN+HdC4P/A
         bj97JzzbaMw3yZKIJlHAsvaVcn2hCmNGuB7GNn75E6Cjh3wMbIWDxebrtFiC7RQw6tgS
         ALeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413181; x=1758017981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULW63TGOLMnn1ghgDwwFUv5dysPY5E+bfANPuLSHOWc=;
        b=mcpBXft1RSTjphHmMBaPgN7d/L6cdVBUk7iuhXM+itgTiKRw9qwVpbb0TLN3i5+Qvy
         OfiiVQq/lwoOyz3C7pyghHm6BgJ04vDBKo6RHekSpVD3JC1ef00IkJBlu4YynHvnL5/o
         3KfWTRfnpnzgE5SQfpoD4OUdyh74fvrlcEg7YjpUDf3id2bFKHRwA3GLkUEIJBBpVovA
         eQsX93KQzCAW1E1sTa/sinDzuGGPsuOpaC4M2egscZNsqBD2l+1LOfv2Ur2tiOv6AXFy
         9VvtDn15ejTGE3bwqQc/xASF5qdW4jFnQ2bYJVzSVXgCSl+bOa3tdSNcYT5WlNYmdCxn
         O6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwdsMXp1zBG1iJNFbnOhp0dMS7oYXIRdOgEEb9W8+zR15gWNbr1n1x/G/BuSDVaWSKJtueWHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVgADZ4Vps625N63piwCUVZ1ZO+eT+32XKJFaegk66+RDs9UZ
	OMq8s5E+EJAwKhP7LqfYp5LaNQ3AdGeFlu1PYx9qKHjZRh/5h94xwKgjcNKNSBTHEwQ=
X-Gm-Gg: ASbGncv1Yom13e1EIL/D7A9HsQHcKV6v/hfg9YIgyCf92H5AID6bHxg0zRPoS2FKe0P
	HvEGTZLe7dc9IFu6LTFpRy4fVsRVsb8Xnf74Y+6MMs11pXvELQlRcx7UwkQn3pKc3iC+7fU1fhG
	WsZuxyiqlbo8jIITsLdnyXSHuNek3x7R0G0lQskv/F/OtIcoAWe7VSXz5cIm7SWwzevq2Ejgs+7
	bs3uegL5pUeEqTEwQKIMyUAyruE5uX/KsA41CChkjt1Nq667reV0zoKKUw59E13rAzyZTz8htx/
	QpdiHqXnRZuLnwsRca39oUYRhWZLn/i+66cIXuhpldNmcsTG4pmvrHLp+nSY/sJldNEi7belVwI
	ymu2QfzjiExtCBwV82VjHmJoYqmKIApxa9GUQwis7bXCY14D1qlo+Zy0RTAMFfLPTNb29dEsWRU
	jSJw==
X-Google-Smtp-Source: AGHT+IG3EcGP7NPzd87Mekp4gaYSXJ55pGHRJ3IARub8bMA9kj0YQ3jp3UoRnC3Iliyf0hEf0ofDKg==
X-Received: by 2002:a05:6512:2c94:b0:55f:5d1f:2451 with SMTP id 2adb3069b0e04-562603a2846mr2996076e87.2.1757413181376;
        Tue, 09 Sep 2025 03:19:41 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681853c59dsm412425e87.113.2025.09.09.03.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:19:40 -0700 (PDT)
Message-ID: <0f3402bc-4b9b-4e8e-83c1-7fe78d278614@blackwall.org>
Date: Tue, 9 Sep 2025 13:19:38 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vxlan: Make vxlan_fdb_find_uc() more robust
 against NPDs
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, petrm@nvidia.com
References: <20250908075141.125087-1-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250908075141.125087-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 10:51, Ido Schimmel wrote:
> first_remote_rcu() can return NULL if the FDB entry points to an FDB
> nexthop group instead of a remote destination. However, unlike other
> users of first_remote_rcu(), NPD cannot currently happen in
> vxlan_fdb_find_uc() as it is only invoked by one driver which vetoes the
> creation of FDB nexthops.
> 
> Make the function more robust by making sure the remote destination is
> only dereferenced if it is not NULL.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index dab864bc733c..a5c55e7e4d79 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -446,7 +446,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
>   {
>   	struct vxlan_dev *vxlan = netdev_priv(dev);
>   	u8 eth_addr[ETH_ALEN + 2] = { 0 };
> -	struct vxlan_rdst *rdst;
> +	struct vxlan_rdst *rdst = NULL;
>   	struct vxlan_fdb *f;
>   	int rc = 0;
>   
> @@ -459,12 +459,13 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
>   	rcu_read_lock();
>   
>   	f = vxlan_find_mac_rcu(vxlan, eth_addr, vni);
> -	if (!f) {
> +	if (f)
> +		rdst = first_remote_rcu(f);
> +	if (!rdst) {
>   		rc = -ENOENT;
>   		goto out;
>   	}
>   
> -	rdst = first_remote_rcu(f);
>   	vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst, NULL, fdb_info);
>   
>   out:

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


