Return-Path: <netdev+bounces-176295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F8A69AD7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13EE423E77
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA382139C8;
	Wed, 19 Mar 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itldpmn6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480F4A1D
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419623; cv=none; b=LmrJlQ+azRlcwqu6FLAu5PtwGrC/5Aj2A9JURTYCpoPL0sTpN97V9hcd+VxKi4QDiOggyrfEQGn6Ab64t3ZEA4shYcu/tBiMQZCM3j4psiH6towjqh/eKKq/Qjzb21viYSt0r2xVaEZO+CYnPlPUvOB+pIX/bOGR8DQf7KG3ot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419623; c=relaxed/simple;
	bh=mFAMESNIIPsQxXJymxHBPuoZ60AmGAKt27V85NqOcdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhzKw+z5ywi9sz15xjg2WQ7mp08TvHw50Bkhh9CWUNDBAFFWcbQx+XwZL92XTKWqlugxK0AzYlajAL/i/vy0BTnIHf2KbOP9mot+BhCmtDIU3Ddo0vU23lKGa0J4T+DPVRTTztRvvd34z0dJTP+Lx/v/emJNos2du8IXBZqnagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itldpmn6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742419621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZyUb5g2cHvTC31VqfCajyVjvwJQkT19dofcq5w3vL4=;
	b=itldpmn60Rl/FG/YPns4KGiD+CHpSU/I+MaIrLz7IodM0kqz3yFGvb3U7wQUOZUAJEPX0h
	D+AHYLx1pP2bOw0zvirBfE4PgEo/iaZD5n8QqvNw1qj/1t4oDxAA0nRT0Y2cJAxUInP6r0
	JP3bECM7+cau7oxc54ZwriFBSU+/g4k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-4EaOuf19M96PkGULT4alpA-1; Wed, 19 Mar 2025 17:26:54 -0400
X-MC-Unique: 4EaOuf19M96PkGULT4alpA-1
X-Mimecast-MFC-AGG-ID: 4EaOuf19M96PkGULT4alpA_1742419613
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf446681cso450015e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 14:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419613; x=1743024413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZyUb5g2cHvTC31VqfCajyVjvwJQkT19dofcq5w3vL4=;
        b=d6VskxxINXTlFTbuAfodZwD86azyYhFO+Y5kAvj0Vs9yF4fP2678qUq+RpLeOcQyK5
         JDmKxrnHup6zP/9Kv2XlTc56Jeg1p/NGo2a578Jj3GdUu+CBCEGggjW7icToAI4E+7S0
         8VQv4eZC/qT35TgwHOLFKhcUUDtdCDTL+00iy2cMeyo3/G4f8pPjav3z7X5UINevWcE1
         hPkKWXseVJUiN2ttObR+K3xL9ZnDNA4DWk3BmQI2Y4PDVDJlZxRoN350+tRIFjnKSSNw
         eVcGKZRHoZVzkWlCwruCBsYeglsKiP/LHrOB414r9Ak26HkJJl6omch5NbmVJpsIBiuG
         sXXw==
X-Gm-Message-State: AOJu0YztL5fDey6SsSaAtoNOmEgjK1Xro0AJ+AJUwLbsc6CCFwnt5SYI
	RsSGHNRTuYrQP5I3JYbOny5vzAjMOfCfNW2LKHofKeQ7TP6rWgy4lz0wyS9yXCYZxDgXaNbx2jQ
	7CD+7a7snkXRzOQPY2trflS9RX22KS0uuBIlkgNEZfCO+Opm6dTdPGw==
X-Gm-Gg: ASbGncv2DW0ryuos7tZcHJcE+7r97SRjN1Qb24QatiDCIA+FykcvwCbrMrrpNsPtxFc
	xgQe8ecs/7+go936+uR4oBp+3nzwICNdFaq3gcejPtEoM5DBjCzrQ8S0rPBKJkJsvQSAC7eergv
	VFhPg5OC8kY4+Ihh2GDFQDOU1qju3BL6kbhUDQArQVr7hSre/nEsnalHyOPKW5YWhf7dfPa19gR
	clKCG5lm/vrFZH3dNgex49zFuitT9jfGBXvvHkb4kSUqkqUslB044hE7p8c7mOr/5UpWXv4ESzc
	y2HPHe8vx0BcBPew5N/wK1waRqGI1oyiy0zGjp0cSDoQahKlHuKdtba5K+iI6eYAOYMk/GU=
X-Received: by 2002:a5d:5986:0:b0:390:f88c:a6a2 with SMTP id ffacd0b85a97d-399795ddfbcmr1116096f8f.39.1742419613391;
        Wed, 19 Mar 2025 14:26:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFngL1Plte2EzxzUVAQjtRQ1zDAcWtVgmrpcbY//+hYDR4Uby+mV32qev+P3PacXiC/wYC3Hw==
X-Received: by 2002:a5d:5986:0:b0:390:f88c:a6a2 with SMTP id ffacd0b85a97d-399795ddfbcmr1116071f8f.39.1742419612949;
        Wed, 19 Mar 2025 14:26:52 -0700 (PDT)
Received: from debian (2a01cb058d23d600155a5103ba09f99c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:155a:5103:ba09:f99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f7460fsm29096095e9.28.2025.03.19.14.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:26:52 -0700 (PDT)
Date: Wed, 19 Mar 2025 22:26:50 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH net 2/2] Revert "gre: Fix IPv6 link-local address generation."
Message-ID: <8b1ce738eb15dd841aab9ef888640cab4f6ccfea.1742418408.git.gnault@redhat.com>
References: <cover.1742418408.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1742418408.git.gnault@redhat.com>

This reverts commit 183185a18ff96751db52a46ccf93fff3a1f42815.

This patch broke net/forwarding/ip6gre_custom_multipath_hash.sh in some
circumstances (https://lore.kernel.org/netdev/Z9RIyKZDNoka53EO@mini-arch/).
Let's revert it while the problem is being investigated.

Fixes: 183185a18ff9 ("gre: Fix IPv6 link-local address generation.")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv6/addrconf.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8b6258819dad..ac8cc1076536 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3209,13 +3209,16 @@ static void add_v4_addrs(struct inet6_dev *idev)
 	struct in6_addr addr;
 	struct net_device *dev;
 	struct net *net = dev_net(idev->dev);
-	int scope, plen;
+	int scope, plen, offset = 0;
 	u32 pflags = 0;
 
 	ASSERT_RTNL();
 
 	memset(&addr, 0, sizeof(struct in6_addr));
-	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr, 4);
+	/* in case of IP6GRE the dev_addr is an IPv6 and therefore we use only the last 4 bytes */
+	if (idev->dev->addr_len == sizeof(struct in6_addr))
+		offset = sizeof(struct in6_addr) - 4;
+	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr + offset, 4);
 
 	if (!(idev->dev->flags & IFF_POINTOPOINT) && idev->dev->type == ARPHRD_SIT) {
 		scope = IPV6_ADDR_COMPATv4;
@@ -3526,13 +3529,7 @@ static void addrconf_gre_config(struct net_device *dev)
 		return;
 	}
 
-	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
-	 * unless we have an IPv4 GRE device not bound to an IP address and
-	 * which is in EUI64 mode (as __ipv6_isatap_ifid() would fail in this
-	 * case). Such devices fall back to add_v4_addrs() instead.
-	 */
-	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&
-	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
+	if (dev->type == ARPHRD_ETHER) {
 		addrconf_addr_gen(idev, true);
 		return;
 	}
-- 
2.39.2


