Return-Path: <netdev+bounces-173079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF4AA571B3
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89821189625B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525F32505C4;
	Fri,  7 Mar 2025 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAC3/osG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE624FC03
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375746; cv=none; b=e7NNMcY1eJiqifpNEAKMGaDQ+MhDcmjwPYYdWpOOMXLp/ojWORj13LyJlE9bXxKJnGcsyS5sK3Z3pHpc/Gs4yk6awEphODFnjUUvBoQaEXLbpQVdJpfBoVN/vUP7Z7ywcZ5pCqTNbmdkIq2Eu2e3bumMfIvGYD9DRtlWnbcteNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375746; c=relaxed/simple;
	bh=iTplKUu8oLarD+LUIbNS7hBM3sfObhrHwacQG8ikXT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNiAvpjw7Xbedxi6/cZteBjyD8b3hINhAJiDhmwSUrroqs8No9Jk0U45vKN+rol/KjINAPDrFtLMUW3FRj5AnApc7LguqnWxJ7nQZqlmCELTy3Q+BpHZOqyYkppoQ8dsOk2lWZ32maVYvlM7qdFyvQIxJca4OAfgsLn+rtD8fog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PAC3/osG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741375742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdXN7YsPymqWNzzus1bQMIFanDxK4q97AMmnrO4/az4=;
	b=PAC3/osGXUJFTi++vzVBW4N92f+5DkJ5gLwSfaSp17EcDVzygGXeyBQmTmccOFrr1NcvyQ
	jfuyxejlPWa8pTvLRyuRYkWCM5kTOsbs6Z8j7L/vWp+eVxsAq2tPP+jPaNgL2AEGase1wz
	bCWAmhr7G1ryD3JHZ0bMtJTYdxxDjM8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-p3mIfSN9PyKKdj_u7p5K1A-1; Fri, 07 Mar 2025 14:28:57 -0500
X-MC-Unique: p3mIfSN9PyKKdj_u7p5K1A-1
X-Mimecast-MFC-AGG-ID: p3mIfSN9PyKKdj_u7p5K1A_1741375736
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390f3652842so1180111f8f.1
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 11:28:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741375736; x=1741980536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdXN7YsPymqWNzzus1bQMIFanDxK4q97AMmnrO4/az4=;
        b=oOsYLoQ/UgwrzZFnY4K94N9UDfZvjZgHkGsFS6LKpUrx5mig4wnBkuMj4y8WJ7SKI0
         FStSfR/yNhxaPXGf+LLsI8819MsRAnK8s08rP9TDZdBqMgBL/oz6N6PTsbxH+/pJwjd8
         hNR2s2JZjRBfMmPE49cK/nBChyKBjwGosl8FWdnvjaW+jn5D9i/9Lyi08+c8HH+hBTJZ
         VnV5yvYBsgp06Gupe3jtiqNSt4aVOPu8EXxfZZTk4sft+bBSM+d82AnVwZFlpfmy4LuL
         gO3QgA1/OcWyrCNCnY/4ongowWPTZ4vBJ3CW+miNxuA/QcBTcdeh1yx/JSrI2v5GAEIB
         cJew==
X-Gm-Message-State: AOJu0Ywv22h/4BSg9ld59yWdMD4W3rjYgC0hEBRgwGZNWOWX6vMPzCla
	ibR6aTZ/GS4Sbbzxyxtq5ytwa9h4Flyt0O5jiYIlnbBUTSk0OCY5jd+EM27aGzyY7qrnJupeUP4
	sQdO7pL59qYm5/X8Vc8Ckuoovl6yHqbl8GUKV4vhSVgpuVIk4dwd5pQ==
X-Gm-Gg: ASbGncvuJ1QhYYmHwcl8Uj3OGtdi+sD0loEjzqW0cKHSOOgBGutZ9rhaFvjzcdJ2YOo
	O1O64H4RKEjiD1Eda4oQobOuv6ohjKWWGscpGr7tEG1RQ2Gs8eobBuk0uBdWoJY3FPCExMdvs0c
	rGpO98oK7/A94dMgIVcbxuTapgSIKCMZooB12XoZNQdHOUFByQNBQbShdc7dJ62ABs3ejhgkdto
	NlTAI/4AR0RkgF5SOlqurGCZcvbVs9if2fh415emzWBsHvtqRZVz7Dq7GtnK3IQ7/0OQ02g4wWY
	ZId6YmW5rNLT1JkAj4grp8oYk3qPk4K4hZ5WBTDEEvSVgub0CnYFSRCmv/ft1uddcC5+J/0=
X-Received: by 2002:a05:6000:42c3:b0:390:f116:d230 with SMTP id ffacd0b85a97d-39132d8a552mr2259414f8f.16.1741375736166;
        Fri, 07 Mar 2025 11:28:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdlXZsob4PRHDMym+RysI1l4JR3mk1WpEGLbztbI0hAi0b0wzu7Y6x3XPm0G34zcdOp6lp9Q==
X-Received: by 2002:a05:6000:42c3:b0:390:f116:d230 with SMTP id ffacd0b85a97d-39132d8a552mr2259401f8f.16.1741375735790;
        Fri, 07 Mar 2025 11:28:55 -0800 (PST)
Received: from debian (2a01cb058d23d6008552c00d9d2e4ba2.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:8552:c00d:9d2e:4ba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c015d2bsm6119070f8f.43.2025.03.07.11.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:28:55 -0800 (PST)
Date: Fri, 7 Mar 2025 20:28:53 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH net v4 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <559c32ce5c9976b269e6337ac9abb6a96abe5096.1741375285.git.gnault@redhat.com>
References: <cover.1741375285.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741375285.git.gnault@redhat.com>

Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
devices in most cases and fall back to using add_v4_addrs() only in
case the GRE configuration is incompatible with addrconf_addr_gen().

GRE used to use addrconf_addr_gen() until commit e5dd729460ca
("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL
address") restricted this use to gretap and ip6gretap devices, and
created add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.

The original problem came when commit 9af28511be10 ("addrconf: refuse
isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
addr parameter was 0. The commit says that this would create an invalid
address, however, I couldn't find any RFC saying that the generated
interface identifier would be wrong. Anyway, since gre over IPv4
devices pass their local tunnel address to __ipv6_isatap_ifid(), that
commit broke their IPv6 link-local address generation when the local
address was unspecified.

Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
interfaces when computing v6LL address") tried to fix that case by
defining add_v4_addrs() and calling it to generate the IPv6 link-local
address instead of using addrconf_addr_gen() (apart for gretap and
ip6gretap devices, which would still use the regular
addrconf_addr_gen(), since they have a MAC address).

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
where the normal method would fail. That is, for interfaces that have
all of the following characteristics:

  * run over IPv4,
  * transport IP packets directly, not Ethernet (that is, not gretap
    interfaces),
  * tunnel endpoint is INADDR_ANY (that is, 0),
  * device address generation mode is EUI64.

In all other cases, revert back to the regular addrconf_addr_gen().

Also, remove the special case for ip6gre interfaces in add_v4_addrs(),
since ip6gre devices now always use addrconf_addr_gen() instead.

Fixes: e5dd729460ca ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL address")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v4: No changes.
v3: Rework commit message to make it clearer which types of GRE devices
    we're talking about (Ido).
v2: No changes.

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


