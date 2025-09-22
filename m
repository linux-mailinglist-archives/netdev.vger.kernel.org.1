Return-Path: <netdev+bounces-225307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A79B920F1
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552E9190321C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920C12D7DDE;
	Mon, 22 Sep 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="O8Mj+zY6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D0823815D
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556282; cv=none; b=XQrWNi9G+vGTuT8tVU55TaSf+IDGnv1w2QUVtvG76qZSjB/XVGPOrQSzn1myBFsVJLrHHA5g/CUNm5gAwMB4Q92dQGYFkx2vOjXazC94FArsoz7fi1p5nkOIfDqpdWL+CKsUww7otu/wkZSIpdjy3AtdELi+3pWzYGuMp+jYf4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556282; c=relaxed/simple;
	bh=z7rS/yxJoUim+mzpgAuctY4+g4cEAbyz7OeFTKQCvw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOJax566xv8LXuS5CmtSEy0vQVhWWRgVb9PQjwMMoh7mZOQmb66G4dsNNscdR4f9Qp+g1KybJdQauWeql86ve+f8bV0sJf3BrGz3lvJVftoybAdjKkSNXCy0mDrDvCQ5GrL4xem+2Wp/Yg88XoH6JNmw+inNvlm6yKxCEXepsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=O8Mj+zY6; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1814184e87.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1758556279; x=1759161079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KI0wiNUU9HxQFHxRzFr4Ntsm60rPJwqbW3BoojwKVFg=;
        b=O8Mj+zY67IzZ8sHcq2WpE/mZXJvzCM+E+n1gXnc5KJu35tr8s8X7mRxI/qOG2oAqc/
         SQFaQJ57K13aF6X63eGrkA+byDGjFv2H1PrOOcNvStSZawLsC4IdbwO9nixh+Shq1JZj
         UYzKIXYS54kX6RGeieRp7G6C27f9qCWSAwofXYq9uVD+lrWjwuvs9W3eCIUgKidgJoms
         7FlMDTomVIZGLRUl7Kbno2txuMpZ3hIjZrM6VYHNBhu5RuYVr7NPFT4YggHrvZ4XJMj5
         MtERvK6ZfNvcO2XM73FO9HCGjnd5M8desfIoBUD8cDlk5KANOdnIPUOLRpHPQbNvG4YY
         15QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758556279; x=1759161079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KI0wiNUU9HxQFHxRzFr4Ntsm60rPJwqbW3BoojwKVFg=;
        b=MUZl2gaQ7QTTWNovQebq0la9s2Nn8uetpKLDTWpEllK82GPLm9PShQIV7Tj3zJlveA
         oApKE3pBwZMLtGmep0j6JSy1MjRgFa43pHboIQf5EuatqKctMG9CMzlX8Gpc0QJ/0uEh
         gq4gGYCKQQq5rItSFX2C9GIcobGHfYs6rmidWBVYVzDEAJkLfgylJcEJBa5nymR+US0q
         tSPGD6PBe3C8OPb3HW3NLTWfeLBwe9M0AA29c8u5H1PJ1dY/26vw6wiqu/rrZDczJ6T3
         3bUMG6i9xTLkHLxGXOug3COmfQrpnbVdI5nRsmFXVsJAmboiNMdcUEqHCWZHp/Icv18a
         zPfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVjFc0r9i4h1W5oPuVo8vOfol0ltaHB8VcTyZiJNpA5cPGuoEzpxs5U2QpWFeC8uw34eSppMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDvaPQbeu5rvkrEfS1RW9GusKXkHwIaDFVGMy6eibwAomJkPlP
	UIN0s0zoo1c/AuLsZSnnyJlkcCsEL7HlgUibvSozGGNLShbpUQACNN48csx1rP5JohyAiLSpQUX
	0v8PAm08=
X-Gm-Gg: ASbGncuJyXDZt3vmgXCuw+5d+V/OaPE19mATF1Ivg7ErAhZ+YjAiWmYmX5f7GIAqk6S
	NUl93S/+WNa+Q7nc11BNo/xOuqpQlvH8csvul7hATYeH8Cy+vFL4wLiWOpJrYjOJWnfRIQoJBZm
	pDx/000HTdAz7aMVZ5j/AT/HjPd7UJ0EhrG89GeSOkdePyd0VPwDTChlMWvYDAPsKK2NOMS5/Om
	nWzXsK1vauzL+n91WgHrvLpl8Wl1p80VD7S47XY5wMq7sQjU4UXgMnaQ+6QpCMxqa6SGfejN/1/
	ulsB+XMdqUeJRZEwgm4EROYG1qCRCLy9COFp2Mwu/6umL8zIDofDvNuLkXwQclfeuzZZwKQsgF6
	Wzj4xMT+lculYz3g4GFZGnofptdwJTfyphu1IbbuLueTUkI+Ohu1me2EoWYaK/butRw4=
X-Google-Smtp-Source: AGHT+IFbn6UAGD/yYipR4ScnqHgSY4Xy5Snk4YVDAIMeIpi4wrTyL2u+7jItUvxJiL3bukK5bqgVQg==
X-Received: by 2002:a05:6512:3a84:b0:55f:5c1d:6cd8 with SMTP id 2adb3069b0e04-579e1b690a2mr4729095e87.2.1758556278396;
        Mon, 22 Sep 2025 08:51:18 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f44a8bsm3412268e87.18.2025.09.22.08.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:51:17 -0700 (PDT)
Message-ID: <2e27010e-5a7b-4dc2-a7dd-703a94d2c4b1@blackwall.org>
Date: Mon, 22 Sep 2025 18:50:36 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: bridge: Install FDB for bridge MAC on
 VLAN 0
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, bridge@lists.linux-foundation.org,
 mlxsw@nvidia.com
References: <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 17:14, Petr Machata wrote:
> Currently, after the bridge is created, the FDB does not hold an FDB entry
> for the bridge MAC on VLAN 0:
> 
>   # ip link add name br up type bridge
>   # ip -br link show dev br
>   br               UNKNOWN        92:19:8c:4e:01:ed <BROADCAST,MULTICAST,UP,LOWER_UP>
>   # bridge fdb show | grep 92:19:8c:4e:01:ed
>   92:19:8c:4e:01:ed dev br vlan 1 master br permanent
> 
> Later when the bridge MAC is changed, or in fact when the address is given
> during netdevice creation, the entry appears:
> 
>   # ip link add name br up address 00:11:22:33:44:55 type bridge
>   # bridge fdb show | grep 00:11:22:33:44:55
>   00:11:22:33:44:55 dev br vlan 1 master br permanent
>   00:11:22:33:44:55 dev br master br permanent
> 
> However when the bridge address is set by the user to the current bridge
> address before the first port is enslaved, none of the address handlers
> gets invoked, because the address is not actually changed. The address is
> however marked as NET_ADDR_SET. Then when a port is enslaved, the address
> is not changed, because it is NET_ADDR_SET. Thus the VLAN 0 entry is not
> added, and it has not been added previously either:
> 
>   # ip link add name br up type bridge
>   # ip -br link show dev br
>   br               UNKNOWN        7e:f0:a8:1a:be:c2 <BROADCAST,MULTICAST,UP,LOWER_UP>
>   # ip link set dev br addr 7e:f0:a8:1a:be:c2
>   # ip link add name v up type veth
>   # ip link set dev v master br
>   # ip -br link show dev br
>   br               UNKNOWN        7e:f0:a8:1a:be:c2 <BROADCAST,MULTICAST,UP,LOWER_UP>
>   # bridge fdb | grep 7e:f0:a8:1a:be:c2
>   7e:f0:a8:1a:be:c2 dev br vlan 1 master br permanent
> 
> Then when the bridge MAC is used as DMAC, and br_handle_frame_finish()
> looks up an FDB entry with VLAN=0, it doesn't find any, and floods the
> traffic instead of passing it up.
> 
> Fix this by simply adding the VLAN 0 FDB entry for the bridge itself always
> on netdevice creation. This also makes the behavior consistent with how
> ports are treated: ports always have an FDB entry for each member VLAN as
> well as VLAN 0.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 512872a2ef81..c37e52e2f29a 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -37,6 +37,11 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
>   	int err;
>   
>   	if (netif_is_bridge_master(dev)) {
> +		struct net_bridge *br = netdev_priv(dev);
> +
> +		if (event == NETDEV_REGISTER)
> +			br_fdb_change_mac_address(br, dev->dev_addr);
> +
>   		err = br_vlan_bridge_event(dev, event, ptr);
>   		if (err)
>   			return notifier_from_errno(err);

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


