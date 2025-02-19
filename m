Return-Path: <netdev+bounces-167789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241B2A3C50A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C0916D02E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271D51FDA7C;
	Wed, 19 Feb 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ct1MXz1g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4091FBEB0
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982617; cv=none; b=lDdl7zI5ttE+1CVakStbKNeNfDV1t+crtVWMraqGDApIo2On3n38drK6JL7fsA4qydgKfknt7+JXY2T3u23qVxvuUz38M6/kVnm5xe1pveWCWp5cEr6i1wr6tBRqByOyQOTFmW9fwzPcwz9m0umv+W3Wic3vA4xsUtyjmSbWr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982617; c=relaxed/simple;
	bh=tNXwsfdI7dt0qCnpvGJ/aSRt0ZUYosyB8PyA7F1Qw6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQikmToOpRrfUI171CD3ezjfW3ScDD3U3GKxwiIC2kKlLJryQlShMm364k4ZBBbxhv740b+FK3tKk+A83iM+ZzArumvSpUyT25vhlXYDqoIrSKNKfdY4824K9tBuLLDKmmY3FDJeZp3d2/hB0Q94KQxf8WbsVRQDr/e8dDAHp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ct1MXz1g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739982614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aa2wqg0QWIEvRCXzcfZqrTE6+FyeUVG0oWLgqYG3oSU=;
	b=ct1MXz1gzfUbeQlUlNne9NWjT+r8E0MOV1qn/3tOCGE8+y1/0Z+cC0llZ/P4WdG9Xap+kS
	dMbUgTjKLnw5hplT0eaOx9PR1P69mB5mZQBZv7V2h0EJ7G+lWmj4/yYkZ1fCgBUm7bjKov
	V5CCOHwUBY/4futinet5bwBgs5V6/30=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-hHS7nfd9Nzm2ec28lHdFeA-1; Wed, 19 Feb 2025 11:30:11 -0500
X-MC-Unique: hHS7nfd9Nzm2ec28lHdFeA-1
X-Mimecast-MFC-AGG-ID: hHS7nfd9Nzm2ec28lHdFeA_1739982610
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4399d2a1331so37415e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 08:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982610; x=1740587410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa2wqg0QWIEvRCXzcfZqrTE6+FyeUVG0oWLgqYG3oSU=;
        b=PwBG1h3sUtDrJ1RhaaVphge1v+RTkhmspc9AxJql4RThvvyk3ITz9Sw5NT4tASjBf7
         EiLbTlXN+x3VcPgObVxq/wyskKpekeaxqKuSO4e/4SaLRJAIyPC3qB2mbgmaKYwXllkn
         k9n2TcJZkLFum7jIDK5YGE1tTmAkrTM3KQWoU3hpDm16zwx5ofZwobuedZCIx4d1+KGC
         Bqy+qWdbrhhMAp+VArbQaBnlRXjmYHI2waHmsFAWPZFqFMYOeG77adS3vHXZBqF9/vX7
         81HPqcHzmcWJTbGdrOCE6sBBag3JmHP/dPbIrziJF2sqb+2xHM09+6Q6J+qzdmzKydnv
         +H7w==
X-Gm-Message-State: AOJu0YwleUHoq7ZdOQrm6vFzzkIFnfN52vZOcG0tFtnFGTp7dUH9QGZg
	el3tQi5tyDN8OM8lTLn7wtj1OA6LjG92/df3n6j4mPldy+5AP18kxuATLuk+LqutWuVQspXryVI
	BkuMfJg7wPF10kbD0sqd1mRwRPpKagrM2PUrj2QVFetbqpWIbYjnsvg==
X-Gm-Gg: ASbGncv3Pf0wTAA3/Qbv2IYCNsLE4KtrXShapHfLvbeXQrS99HlxOPB1Fp7XFz+Uj6r
	BXf+Ck/njTY5ENpWXNzqAJoEimusKNiIPYSwOhe8TYdW2NYLP9BzWiNDU+lT/mVJJwpXg9nGOvV
	OKh5EbOmHnq/nfMNjABfxKUKi0UCegePjeXS/ci3Fwj0sjIXiJB4/LHOVqmyXCMEXqhOj/kNwU5
	YTB+AN2Yd6pGxCM2xFa3ctuN/Uhm4fi78WhdAid2bMSqFmAKwgs9yDrjlfSCooms50Z
X-Received: by 2002:a05:600c:22d1:b0:439:9384:7d08 with SMTP id 5b1f17b1804b1-43999acbademr39530735e9.2.1739982609687;
        Wed, 19 Feb 2025 08:30:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTQpWD1wYcCK5ohELNlkdwVdwHOnChhSe2+InchuBnYmY+2xFAol0uIbByfbJBRJU/slWy2A==
X-Received: by 2002:a05:600c:22d1:b0:439:9384:7d08 with SMTP id 5b1f17b1804b1-43999acbademr39530225e9.2.1739982608940;
        Wed, 19 Feb 2025 08:30:08 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258eb141sm17921696f8f.41.2025.02.19.08.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:30:08 -0800 (PST)
Date: Wed, 19 Feb 2025 17:30:06 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH net 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <942aa62423e0d7721abd99a5ca1069f4e4901a6d.1739981312.git.gnault@redhat.com>
References: <cover.1739981312.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739981312.git.gnault@redhat.com>

Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
devices in most cases and fall back to using add_v4_addrs() only in
case the GRE configuration is incompatible with addrconf_addr_gen().

GRE used to use addrconf_addr_gen() until commit e5dd729460ca
("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL
address") restricted this use to gretap devices and created
add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.

The original problem came when commit 9af28511be10 ("addrconf: refuse
isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
addr parameter was 0. The commit says that this would create an invalid
address, however, I couldn't find any RFC saying that the generated
interface identifier would be wrong. Anyway, since plain gre devices
pass their local tunnel address to __ipv6_isatap_ifid(), that commit
broke their IPv6 link-local address generation when the local address
was unspecified.

Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
interfaces when computing v6LL address") tried to fix that case by
defining add_v4_addrs() and calling it to generated the IPv6 link-local
address instead of using addrconf_addr_gen() (appart for gretap devices
which would still use the regular addrconf_addr_gen(), since they have
a MAC address).

That broke several use cases because add_v4_addrs() isn't properly
integrated into the rest of IPv6 Neighbor Discovery code. Several of
these shortcomings have been fixed over time, but add_v4_addrs()
remains broken on several aspects. In particular, it doesn't send any
Router Sollicitations, so the SLAAC process doesn't start until the
interface receives a Router Advertisement. Also, add_v4_addrs() mostly
ignores the address generation mode of the interface
(/proc/sys/net/ipv6/conf/*/addr_gen_mode), thus breaking the
IN6_ADDR_GEN_MODE_RANDOM and IN6_ADDR_GEN_MODE_STABLE_PRIVACY cases.

Fix the situation by using add_v4_addrs() only in the specific scenario
where normal method would fail. That is, for interfaces that have all
of the following characteristics:

  * transport IP packets directly, not Ethernet (that is, not gretap),
  * run over IPv4,
  * tunnel endpoint is INADDR_ANY (that is, 0),
  * device address generation mode is EUI64.

In all other cases, revert back to the regular addrconf_addr_gen().

Also, remove the special case for ip6gre interfaces in add_v4_addrs(),
since ip6gre devices now always use addrconf_addr_gen() instead.

Fixes: e5dd729460ca ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL address")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv6/addrconf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ac8cc1076536..8b6258819dad 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3209,16 +3209,13 @@ static void add_v4_addrs(struct inet6_dev *idev)
 	struct in6_addr addr;
 	struct net_device *dev;
 	struct net *net = dev_net(idev->dev);
-	int scope, plen, offset = 0;
+	int scope, plen;
 	u32 pflags = 0;
 
 	ASSERT_RTNL();
 
 	memset(&addr, 0, sizeof(struct in6_addr));
-	/* in case of IP6GRE the dev_addr is an IPv6 and therefore we use only the last 4 bytes */
-	if (idev->dev->addr_len == sizeof(struct in6_addr))
-		offset = sizeof(struct in6_addr) - 4;
-	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr + offset, 4);
+	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr, 4);
 
 	if (!(idev->dev->flags & IFF_POINTOPOINT) && idev->dev->type == ARPHRD_SIT) {
 		scope = IPV6_ADDR_COMPATv4;
@@ -3529,7 +3526,13 @@ static void addrconf_gre_config(struct net_device *dev)
 		return;
 	}
 
-	if (dev->type == ARPHRD_ETHER) {
+	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
+	 * unless we have an IPv4 GRE device not bound to an IP address and
+	 * which is in EUI64 mode (as __ipv6_isatap_ifid() would fail in this
+	 * case). Such devices fall back to add_v4_addrs() instead.
+	 */
+	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&
+	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
 		addrconf_addr_gen(idev, true);
 		return;
 	}
-- 
2.39.2


