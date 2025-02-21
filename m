Return-Path: <netdev+bounces-168425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD69A3F02E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DBC8605F1
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D814204C34;
	Fri, 21 Feb 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTOMpnbc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E0204C39
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129853; cv=none; b=FwYdAyTFSGQtZ7m2+okmPMuviWa7DeDg5nQtN2+XFgom9i2eLLmKEtr0VnXRynMy/A0BRV9GBeQRjTCHNr7M+VCqfq1SzaSb6aC6CzNEsZHgrMP9QLydI+GFfpneHIVMFT6+papOFGV+ioekMQdaaiDZJV/Q28ybkSCYFnfQexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129853; c=relaxed/simple;
	bh=cDLm2C1nI275N7W2/cLjmILIrNgL/CpWY5/XxEkE8XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWlPPnjZ2GCrzqybJ9JwUNWRgX3/JTwarJSW6C5r1//oEfBcONoiJ8DKXyK0HbKJRzht/H1xhV9mS0IqTwTF3A/NTOzLXWQ3yMUgwB6QHATzalzgA9wFJs0UpluA1QqHZ2t66dS/MzyRX+2QNQG67eLn/rx9k1AgeZk3fat0La0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTOMpnbc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740129850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSRYm/qNQakanMxCvXY8bFyXAFzTvxkUv5zufFxOGKM=;
	b=fTOMpnbcOGkWH455I9dbKR5Txub3rB5GLCObenHdoBjkxWp5+nrs5hsqVMalzPap7mxDM2
	LNagkDd9i9aBA4AdLaAEIt44nLMv8eLE9Rz6wu7E52s/ogwv6xaanTYYu3f5c9R4784kXG
	7lps5bhI1GRVCGqdHHp2be4tM/EXJs4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-OXNV2PJpORqlDVtd_TgdAA-1; Fri, 21 Feb 2025 04:24:08 -0500
X-MC-Unique: OXNV2PJpORqlDVtd_TgdAA-1
X-Mimecast-MFC-AGG-ID: OXNV2PJpORqlDVtd_TgdAA_1740129848
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f20b530dfso2727070f8f.3
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 01:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129847; x=1740734647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSRYm/qNQakanMxCvXY8bFyXAFzTvxkUv5zufFxOGKM=;
        b=FI6qZjpS0lG/pfihtD0lWbgIagOcMa3CTJzVHr2JixI0kAxNmnqsUc8KITgcU1Yoki
         VMxFX2vRxhoxqjKuxwAZPtr6wcx3CDCGQaPNaKqczuCoR0DGPArchfbgvnqNAiWaxiuS
         FWa/aj83nMDGNQaoiloxynxOIKjvDb2/N+GVfWqADvPyHN7Pzto3B/bfukyGgZZsdN+m
         CVitXTaYtoVtbxZ4ZjWUeoYSwy960xFJGyMHFeTdggugZcqgNzHLNp+RqdxeORs0XdcV
         hip7cCkNievZNhYv83/V12e5HXeJYV2rNn9tAsekj3ksAcYtEbMxPFqIw4zbcBFoXhkM
         H4fA==
X-Gm-Message-State: AOJu0YxY7LzmSBrPP+LzGuuAQbMpE483VzKSQvA174QYU2Trl4QqWvU+
	wYwNgL6sd/m+sD8wiVCDAXui1wcX4cdF1AlsKnlE+Oy9zmGwoDow0LpXvmr1ZVcaQkQ1SFX9yKV
	VLHse5G498oc0RFau8ls5hO0m2fnuYQudnuyOMxNa9r4RhCIDgrc1Ig==
X-Gm-Gg: ASbGncskV7a+jSaoZ6/W6CG96IqhyC+BL0fkkQmsdydKtd2+OteDPEfqCad1VqKk+qi
	tePT2Q0J1dO8yzzqWjlg1VnwbbxRy/O5OsRtbp9zwuGv+gTJeltr3YPvX1/pd8xUKKuBEXZZA6I
	+o0p+bjL2uACjRBXYit7zf6OtpWTVp17E16lwbsOAbot99gTBQY4WkjlqpGV9F33dIbJFMlUwY8
	RMOPQgLz06G5L9T5WAX+HBxjR72zJEE+0zLIljOUBVUxX9dP2iwgVrSpq8buCWWK0KgeLohlr/a
	tCI=
X-Received: by 2002:a5d:6c6e:0:b0:38f:2a3e:870c with SMTP id ffacd0b85a97d-38f70799f23mr1580848f8f.16.1740129847422;
        Fri, 21 Feb 2025 01:24:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW4kaKVY3wZyP2lhCcq49Y+JYuolRvoNf7ydAcLm/D2zsD9NGs/lmK4JDHenqQzAJBbq5Y7Q==
X-Received: by 2002:a5d:6c6e:0:b0:38f:2a3e:870c with SMTP id ffacd0b85a97d-38f70799f23mr1580814f8f.16.1740129846976;
        Fri, 21 Feb 2025 01:24:06 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4491sm22462354f8f.7.2025.02.21.01.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:24:06 -0800 (PST)
Date: Fri, 21 Feb 2025 10:24:04 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH net v2 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <942aa62423e0d7721abd99a5ca1069f4e4901a6d.1740129498.git.gnault@redhat.com>
References: <cover.1740129498.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740129498.git.gnault@redhat.com>

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

Fix all this by reverting to addrconf_addr_gen() in all cases but the
very specific one that remains incompatible.

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


