Return-Path: <netdev+bounces-242897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B3C95EED
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 07:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7524C3A152A
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 06:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBE21E9B12;
	Mon,  1 Dec 2025 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L13URArP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986681369B4
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764572290; cv=none; b=mmrCeYAbvAcojUP0xnry1QEOA7u3NxLbDLKgNdGRlVlmryqzEkFxAP0qjF8thUWrAX8c5IHX6fQ8y3sYbNVmPXr/9IKAbwxmL1lW2csJ+IHP7sBMjNwjpm6wRezLQlAUmSwgQNxkWBTjb9pF/r7prDOp21HvGPOzsw1TvS7k2mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764572290; c=relaxed/simple;
	bh=taeQDHjGBIoarltrjK2R5rOq13MY1UF/qHY5bVaF6Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL1Gn+2OxbH3HN8zvPaHKeffo0QmoGq+4wOeK3KHqJH1Hfk0S39hn07icVfHgYbxmtQP84NI58pmySR7g5acy+ad1DVjpeIXTrX8JI+NoEJfF1BlUFqEKQGj0dKOkKTFJjcfJxvfTDvg3avwOUEaG3Hdpz1d/uAzSDP7QAlEN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L13URArP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aad4823079so3253931b3a.0
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 22:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764572288; x=1765177088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NQMU/GY5gqzKXUnzGpXn7Bne27D4q11oVEsJuTXpGmA=;
        b=L13URArPavt4P8ROJx+P+eCxkPPjZYdlK21InkE0gCvc/elktJPQ734u0uBH++ey/v
         z4lSWT1O8LPUrvjnDAFE/7GkC1l2xwzLcoYnnlScR79VLxmNXMlmap0ESGXPYknL/vfF
         abs7kscVF+AzfN0nr2q/WSejLRptEkgucSq3gazALrCbTyGReJoKfD3/W+iSwMAb010y
         wJYwrxydSYVYXrDDZ12PKtRCd9X/r/bOEcZB8by861i+9B7WxJF8sEH+kPCpull6K9xT
         3a+GRhcjj1xeoGNtP+MjVJuFHAuTSH9u9cu5DKG+V6OzybRd4v8tZqyjt81xPESaNsV6
         FH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764572288; x=1765177088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQMU/GY5gqzKXUnzGpXn7Bne27D4q11oVEsJuTXpGmA=;
        b=EA7zPUsZV2OdA1CbfpQUZJIvmEsdnyzD0ElgAqGUBnu9FNBni77aaOC3aiuhBpgbIe
         0NaaBwKnfr9L9KtN8YpORNDHbmyJhKWdai9Ns56vjzlD+g4M1KykvPSCWot+HwgpB7st
         2M4IPZhKnTfOIaIlhuMRuhh2GGsdRySmZKSKW95NAfTcwF80uEXhsKSI16O0bwfq01En
         Mc5yusfjHwCA0ZagIjD+HMwPZh5zBHyEbXJq135J4nnDWhpoPpX2HWTE7TwPQVuF3xMs
         bunHF3qLWoNaB1OIaTO09LsgGzQgsKsZ5gL1bRlkMALoh/5gC/6h+ZiMdcpyLzRiKkhz
         gDzA==
X-Gm-Message-State: AOJu0Yy/d8bCyBiEgwKTILHOiZSl6TXjwCRGX/SPy0n/iqhjHz8Rs/rC
	w9vfB9GqreOFuJrdwugwHxn+Edu6cO5S6YEwYSe/Q0dho0L0jpEiVxh1
X-Gm-Gg: ASbGncteL37nUlFHq/WazVSvNr27WSfMB1IQ9aCIlhWWdNaTTFpnw4cVo1o6aYOxwdz
	RLJI1gytuP/m/n6/at8uTaNshvkk9uwD71zvd/gvP1y/P/far2Seso2xME3n1TCehIFAWtEAriu
	os2Qi1UfDfnfcZ7HN3znZNKltMb1h/WUQfSIKbgypeNedqbaHrFxi6+nBq3N79fPiTdrXi1D6/p
	ypZCmBVure0pHEtfMU7aEXdU4BAYvBfpB8T52xrHaXS1toHYWIG11ty1PdAxP/PwA3OcLynwYEG
	+K//4QkO4dCuDnBmyoRPCZ+DIdRSz8b34fwnISFqi3PM+KGVq2nFc71UHPipfhOFGeSJvg/M29I
	eonCzK68yF0lWmWGIIF+4QYTo36f3uSI+ZEc6xK6MrkzkeKXt8T+amjqOaPL42ZN91F0zYWXv9O
	oGku9+sAtBlJ57Ct1dkGwqIsHGcw==
X-Google-Smtp-Source: AGHT+IEx0+fOQ+sjg4jauP1ggQ/RAwWAbzU9AwmksnWlYGLeaUGLprox73QFNxOUAeVpJ/PfGwCfiQ==
X-Received: by 2002:a05:6a20:3c90:b0:353:1edd:f7a with SMTP id adf61e73a8af0-36150f35860mr41386023637.59.1764572287736;
        Sun, 30 Nov 2025 22:58:07 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbde2350sm11106638a12.9.2025.11.30.22.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 22:58:07 -0800 (PST)
Date: Mon, 1 Dec 2025 06:57:59 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 1/4] net: bonding: use workqueue to make sure
 peer notify updated in lacp mode
Message-ID: <aS08d1dOC2EOvz-U@fedora>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
 <20251130074846.36787-2-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251130074846.36787-2-tonghao@bamaicloud.com>

Hi Tonghao,
On Sun, Nov 30, 2025 at 03:48:43PM +0800, Tonghao Zhang wrote:
> ---
> v1:
> - This patch is actually version v3, https://patchwork.kernel.org/project/netdevbpf/patch/20251118090305.35558-1-tonghao@bamaicloud.com/
> - add a comment why we use the trylock.
> - add this patch to series
> ---

I think you can move the change logs to cover letter.

>  /**
>   * bond_change_active_slave - change the active slave into the specified one
>   * @bond: our bonding struct
> @@ -1270,8 +1299,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
>  						      BOND_SLAVE_NOTIFY_NOW);
>  
>  		if (new_active) {
> -			bool should_notify_peers = false;
> -
>  			bond_set_slave_active_flags(new_active,
>  						    BOND_SLAVE_NOTIFY_NOW);
>  
> @@ -1280,19 +1307,17 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
>  						      old_active);
>  
>  			if (netif_running(bond->dev)) {
> -				bond->send_peer_notif =
> -					bond->params.num_peer_notif *
> -					max(1, bond->params.peer_notif_delay);
> -				should_notify_peers =
> -					bond_should_notify_peers(bond);
> +				bond_peer_notify_reset(bond);
> +
> +				if (bond_should_notify_peers(bond)) {
> +					bond->send_peer_notif--;
> +					call_netdevice_notifiers(
> +							NETDEV_NOTIFY_PEERS,
> +							bond->dev);
> +				}
>  			}
>  
>  			call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
> -			if (should_notify_peers) {
> -				bond->send_peer_notif--;
> -				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> -							 bond->dev);
> -			}
>  		}
>  	}

I don’t see the benefit of moving NETDEV_NOTIFY_PEERS before NETDEV_BONDING_FAILOVER.
Is there a specific reason or scenario where this ordering change is required?

Thanks
Hangbin

