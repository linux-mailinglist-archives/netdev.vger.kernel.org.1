Return-Path: <netdev+bounces-198039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171D4ADAF51
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3FF3A48F9
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D713527932E;
	Mon, 16 Jun 2025 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGbmEcy5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF12E889E
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075118; cv=none; b=TAyz+e5qOv60uIJAuxGjuBuNkcG/ogrA4F23Qr/rMKX9BERaBoEte2xDheNXq4TIhJgCVA5q1PzMvRm5l+DOoo6zSyucXnYmCSXoISXgDIgIbw35O6ZfqMgpeYoC/5SpC+FEJsCFHva2rDpOcw2ZeWxs1mimdsIu1ctPsTdD+Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075118; c=relaxed/simple;
	bh=eE3m2/exUBaU2QHBuCbtwqqaUd9xb+QgFdZiJtYo8GU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qfIklSh/LLAPUdVd8PL7pEatNL3WMKv5i+ha0bOBjwjcXJLuV4oopGAtn/lF/LePd9DBqLPBhMDlyDP+NHiMWGKPOpWV5FNEKOQjh4FreB7pRLpYUE0v9OkBSB7LDJ271jNJnqRxwav2LNk+eS7GM8sCOdVrtnojvdASZhtP4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGbmEcy5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750075116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=/80dW6e5di76AvZW+MAGqD/FrKaFe3z9aGoSoXj7QB8=;
	b=aGbmEcy5kZC/K+mcVu8vIIgkYnBuqCiggg9sHb4N15hRebrkLSroj9fwVuLvX/RLYW8Oh+
	KRGIucKJLd8e5RXdDwo3GaAiHluIoeGzLebfTmFJMSdb+ww+IwkAvA2CpmYRUpuNbj7Pqc
	fICDqX/pNMidHc5qzxKWTSD7Gctxcu0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-OCVLhKYqNa2ZrpL1GxPcWQ-1; Mon, 16 Jun 2025 07:58:34 -0400
X-MC-Unique: OCVLhKYqNa2ZrpL1GxPcWQ-1
X-Mimecast-MFC-AGG-ID: OCVLhKYqNa2ZrpL1GxPcWQ_1750075114
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6cc5332so2578956f8f.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 04:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750075113; x=1750679913;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/80dW6e5di76AvZW+MAGqD/FrKaFe3z9aGoSoXj7QB8=;
        b=ifKkM7eXnKRMmCugZLJ3nW/0UJSj/uFPtMorgqNOBq9Jvvyzah1ryW5L9OxfruzxmE
         LCse+XjyLnvrucNMjajVG6/NCeePP+qa99fXzKz1KBexsBXkGiXIL0AjQihEBqmLo9BU
         PzixIDaNTTGKQZb5/8imHoo0gdFTI2aebNnfdawWGTrHkCwyfWvXFo0QTSK5Bc199R3J
         Fvp1GbcBidcI6jpVuUyXbNEYXYVhBEBPwQIOzZlOSawNle3PCnNcgF1xPZIkal6djYU0
         hTbVmSVG2v8FmqO9xbVtvkzuUqu16RVRg2Kbh5Ui/8WRO3sasGNt24zG8l6yffIfi+Ee
         lMGw==
X-Gm-Message-State: AOJu0YxKYw7lkPZQlAl9p9FoFJSegSddVuhXzFAQVPmlkR+4DAkCb0xB
	f+uPTOWMz/0KAMoTYAkRUVc7Hr8qmtzgtK+Q5wT0D4jnpQyNAcAZINWxxlbYhf3RqZM+C1eGqS+
	nKXpeHZrORuoWbPYd6FhWPwrpLjXfzspDicD4gUBJl2lIc17nQ6KJc0Ta2A==
X-Gm-Gg: ASbGncvftrxDwQsM4A9AV+gtwRn3OORHFxpanwCNGY+8Fqh6AzxiclWqkcqXU95rIrg
	1e2eR6MoU/NZbJmMRN+y5HvUxjbhbW1FnfWHD3MePcVmwKnRZ2Iyr1otmDCzf1KUly4GdYCjRQZ
	SrAE8ITBVYfSr/zMEMT4ywrfurYh5Y+TG5NvxjOBg+LXSyQWwsN9zmmhW2MYc8+ZVf2p24IGPL0
	2/k+5LW4N+ZSCV5ajfszvtu6tYjlTyUY8rLaVa3rxqkqwlwLZVsJZUQagt1TPATSfCmUlb1FpFo
	sj+C3mMfAhFdT8h4+CeNv0fz8m2brgp2TPd/UjZGxI/zz9fbfLWH4oYvXOnIcw7GzKksAlQ5nVD
	JSA==
X-Received: by 2002:a05:6000:2507:b0:3a4:f644:95f0 with SMTP id ffacd0b85a97d-3a572e5730fmr7196649f8f.54.1750075113468;
        Mon, 16 Jun 2025 04:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz0ImZkZDPmOSZMwvlF4nmlIxRK85alfbe2v822He0QDcY5pUGgGZJrufcjr+ZcMEmXT61qA==
X-Received: by 2002:a05:6000:2507:b0:3a4:f644:95f0 with SMTP id ffacd0b85a97d-3a572e5730fmr7196622f8f.54.1750075112958;
        Mon, 16 Jun 2025 04:58:32 -0700 (PDT)
Received: from debian (2a01cb058d23d60097431fc7e366f661.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9743:1fc7:e366:f661])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b6debasm11098381f8f.93.2025.06.16.04.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 04:58:31 -0700 (PDT)
Date: Mon, 16 Jun 2025 13:58:29 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@idosch.org>
Subject: [PATCH net-next] ipv6: Simplify link-local address generation for
 IPv6 GRE.
Message-ID: <a9144be9c7ec3cf09f25becae5e8fdf141fde9f6.1750075076.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since commit 3e6a0243ff00 ("gre: Fix again IPv6 link-local address
generation."), addrconf_gre_config() has stopped handling IP6GRE
devices specially and just calls the regular addrconf_addr_gen()
function to create their link-local IPv6 addresses.

We can thus avoid using addrconf_gre_config() for IP6GRE devices and
use the normal IPv6 initialisation path instead (that is, jump directly
to addrconf_dev_config() in addrconf_init_auto_addrs()).

See commit 3e6a0243ff00 ("gre: Fix again IPv6 link-local address
generation.") for a deeper explanation on how and why GRE devices
started handling their IPv6 link-local address generation specially,
why it was a problem, and why this is not even necessary in most cases
(especially for GRE over IPv6).

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv6/addrconf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ba2ec7c870cc..9c297974d3a6 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3208,7 +3208,7 @@ static void add_addr(struct inet6_dev *idev, const struct in6_addr *addr,
 	}
 }
 
-#if IS_ENABLED(CONFIG_IPV6_SIT) || IS_ENABLED(CONFIG_NET_IPGRE) || IS_ENABLED(CONFIG_IPV6_GRE)
+#if IS_ENABLED(CONFIG_IPV6_SIT) || IS_ENABLED(CONFIG_NET_IPGRE)
 static void add_v4_addrs(struct inet6_dev *idev)
 {
 	struct in6_addr addr;
@@ -3463,6 +3463,7 @@ static void addrconf_dev_config(struct net_device *dev)
 	    (dev->type != ARPHRD_IEEE1394) &&
 	    (dev->type != ARPHRD_TUNNEL6) &&
 	    (dev->type != ARPHRD_6LOWPAN) &&
+	    (dev->type != ARPHRD_IP6GRE) &&
 	    (dev->type != ARPHRD_TUNNEL) &&
 	    (dev->type != ARPHRD_NONE) &&
 	    (dev->type != ARPHRD_RAWIP)) {
@@ -3518,7 +3519,7 @@ static void addrconf_sit_config(struct net_device *dev)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_NET_IPGRE) || IS_ENABLED(CONFIG_IPV6_GRE)
+#if IS_ENABLED(CONFIG_NET_IPGRE)
 static void addrconf_gre_config(struct net_device *dev)
 {
 	struct inet6_dev *idev;
@@ -3536,7 +3537,7 @@ static void addrconf_gre_config(struct net_device *dev)
 	 * which is in EUI64 mode (as __ipv6_isatap_ifid() would fail in this
 	 * case). Such devices fall back to add_v4_addrs() instead.
 	 */
-	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&
+	if (!(*(__be32 *)dev->dev_addr == 0 &&
 	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
 		addrconf_addr_gen(idev, true);
 		return;
@@ -3557,8 +3558,7 @@ static void addrconf_init_auto_addrs(struct net_device *dev)
 		addrconf_sit_config(dev);
 		break;
 #endif
-#if IS_ENABLED(CONFIG_NET_IPGRE) || IS_ENABLED(CONFIG_IPV6_GRE)
-	case ARPHRD_IP6GRE:
+#if IS_ENABLED(CONFIG_NET_IPGRE)
 	case ARPHRD_IPGRE:
 		addrconf_gre_config(dev);
 		break;
-- 
2.39.2


