Return-Path: <netdev+bounces-205452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B543DAFEC07
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3756A545B4A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FB62E5B0A;
	Wed,  9 Jul 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLxEfJ4e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DA62E610F
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071420; cv=none; b=OS/n7XNUuXBPm0EjB6aQD4Xs1sgck3CTSfQdoUP7a0efDuIHQ3YP3AO3aMe+WyAT1c1+90LTHpC9l23audaF8w5+1ug+EAKTMLxpDwTpknEKhv2iXIA0fHB84kXAsAcC83VVvzKJaraTvbwZHZNwbzi8gzmLMntGRR6f0s/SuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071420; c=relaxed/simple;
	bh=gj1GG73gbvX3g4y2pIm44H3/uC9C9K3NIW9KCinYm78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7Nh7CyWvktVBWevAwof6As3jUskH66jBYlissSG7Rhj08kpV3xZAZ8YGNO8dVrlBFGORXMB0kEGmSV0Zcc15pDvdc20R3dG1qOn1PS+7EHN6bTzffWktyH5LNFKUTBnXe/JDxFldMkjrF8yO0TzswdtwAJyqEIpQkWIJa8RAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLxEfJ4e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752071417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zzn/qvGX/kYco+2RjqPmwKYggRHweDYxVHxTqcNT5o=;
	b=eLxEfJ4ev9AzncPtZUKZfAJhOqK7wmrGwnYhOkv4B0gDj/B9ld5CNqOn9hLkml5fVzmOom
	hFCudh4uts1I6cxhUtqB/aGn6gAzl+Xf58Tke/5vSz2DS1oNBQ4qjpwa2bdnWCJL+1SmHC
	mW9k+A/MbZt4VOunAayOgLcA/8L7DoE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Z17p44DEP3y9YztWn_cI2Q-1; Wed, 09 Jul 2025 10:30:16 -0400
X-MC-Unique: Z17p44DEP3y9YztWn_cI2Q-1
X-Mimecast-MFC-AGG-ID: Z17p44DEP3y9YztWn_cI2Q_1752071415
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d5600a54so45178955e9.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 07:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071415; x=1752676215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zzn/qvGX/kYco+2RjqPmwKYggRHweDYxVHxTqcNT5o=;
        b=KkJfniPLYcGG60hyf8zff/elYz7qBb7Dtnrpm4xjWgpGk8C2t7W6F3Fh6jDgYE2jI6
         jUpPiZw9p6LPLm6BnXFpKP6YRipyTK0511gn3UIRCAT6DA8nj2qEY+Kct11vm3ijmutg
         gXy8LeEILuABVmVdUB0fN3prKa4v3bF0DOPMWic82e+l1T8LxM9TS0vXIRzg9gKct1B9
         2nqkWYSKfwOndyYgNrufEd7sizEjVklnu1qM0zGjEs6k6mgbeNZM1xr6RFKj/PRklapO
         3eqGiqwswvgF6dPsmAQQKZ6KSAD0Sgd/9h2YSexrFPx8Ed6s44cRgbkR55+pvnXeQMNo
         m5kA==
X-Gm-Message-State: AOJu0YzfkdTBhw/Q276TUCJA36yN3+TVst/w3RFi0PTeT4kTJDM7BTss
	olYxqI4ht8vQB+mdRpSmNap5PTodT79pVPmhbH2vC2nsGEqr6dx7i0R4tBBa2AggpHwmE+wnqxp
	HFU6F45LwfPvLs8DF8976jMjEDbFWxdewpp2arD7Hk/xKRxgGQf4qLvf/MQ==
X-Gm-Gg: ASbGncuSMr+V73ApfzYCaZkeZZHvjoWIdU0LuHFcSIO3csF1j7SCQVuoeBeI4QB9WkU
	9LRCgPLKx+yyvX5Il6x9jypvo2yjHRTdd1KNm1kVfl+7jV5hDq2CoXpKbAZin56dvuKauaRXp8X
	yd6uS7RvNaWzCRQbPhQ9F28sudrLFLUOJDmKmccqFtZXrUAk5G7mt+v6CbykJczHS3oSrNB3JxP
	4VWU86vcbHOgjNKNfjaWddF3h01Bi6FrQXzQxiQQFLLSB2wTvL4HkmmbCadJLKYRi7XBOSTpYHh
	NezBgmFEjw==
X-Received: by 2002:a05:600c:46cc:b0:453:8bc7:5cbb with SMTP id 5b1f17b1804b1-454d53d4d63mr25962865e9.25.1752071414928;
        Wed, 09 Jul 2025 07:30:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/cG+HNGcV9Zio/1vqyD8GYIoan49l49yCf1a9T3pdrETB/urI7U7G162hg1m53O555jWPnw==
X-Received: by 2002:a05:600c:46cc:b0:453:8bc7:5cbb with SMTP id 5b1f17b1804b1-454d53d4d63mr25962635e9.25.1752071414507;
        Wed, 09 Jul 2025 07:30:14 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50503d1sm26072225e9.10.2025.07.09.07.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:30:13 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:30:10 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Aiden Yang <ling@moedove.com>, Gary Guo <gary@kernel.org>
Subject: [PATCH net 1/2] gre: Fix IPv6 multicast route creation.
Message-ID: <027a923dcb550ad115e6d93ee8bb7d310378bd01.1752070620.git.gnault@redhat.com>
References: <cover.1752070620.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752070620.git.gnault@redhat.com>

Use addrconf_add_dev() instead of ipv6_find_idev() in
addrconf_gre_config() so that we don't just get the inet6_dev, but also
install the default ff00::/8 multicast route.

Before commit 3e6a0243ff00 ("gre: Fix again IPv6 link-local address
generation."), the multicast route was created at the end of the
function by addrconf_add_mroute(). But this code path is now only taken
in one particular case (gre devices not bound to a local IP address and
in EUI64 mode). For all other cases, the function exits early and
addrconf_add_mroute() is not called anymore.

Using addrconf_add_dev() instead of ipv6_find_idev() in
addrconf_gre_config(), fixes the problem as it will create the default
multicast route for all gre devices. This also brings
addrconf_gre_config() a bit closer to the normal netdevice IPv6
configuration code (addrconf_dev_config()).

Fixes: 3e6a0243ff00 ("gre: Fix again IPv6 link-local address generation.")
Reported-by: Aiden Yang <ling@moedove.com>
Closes: https://lore.kernel.org/netdev/CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com/
Reviewed-by: Gary Guo <gary@garyguo.net>
Tested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv6/addrconf.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ba2ec7c870cc..870a0bd6c2ba 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3525,11 +3525,9 @@ static void addrconf_gre_config(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	idev = ipv6_find_idev(dev);
-	if (IS_ERR(idev)) {
-		pr_debug("%s: add_dev failed\n", __func__);
+	idev = addrconf_add_dev(dev);
+	if (IS_ERR(idev))
 		return;
-	}
 
 	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
 	 * unless we have an IPv4 GRE device not bound to an IP address and
@@ -3543,9 +3541,6 @@ static void addrconf_gre_config(struct net_device *dev)
 	}
 
 	add_v4_addrs(idev);
-
-	if (dev->flags & IFF_POINTOPOINT)
-		addrconf_add_mroute(dev);
 }
 #endif
 
-- 
2.39.2


