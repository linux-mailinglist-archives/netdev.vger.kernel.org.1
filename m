Return-Path: <netdev+bounces-138642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F83F9AE719
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9501C21BDC
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3031B1D5ACC;
	Thu, 24 Oct 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b="XJ0jDcV7"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850F138DD1;
	Thu, 24 Oct 2024 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778553; cv=none; b=iAAdEDSYuhq36+r5mvmSLLq58f9zgLNInNAa+BWbOOSdjmL/xtKl2NJWx1jbLqHv5wF0Vr1ZeEyZ8CjwqRc+JHViDgzvzYEBy2rsTp1xfJTWb2WALW417h3K8z98sWYuJdeFpehgjCo2TqwjpTPi6b6GnUvNBhhyjE8qlLIH8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778553; c=relaxed/simple;
	bh=Ipm8P50Y+llp0O+WOlfXkI4PWF637EaTo+hlh2/TUZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b7w9ax+6qifIlzhsMvUxv+1lkH6KBn0t7bvrXPFZdA26sGl6MbvhAosm4OM1MN2x1AYFKvTgY9mtJu3EZo51XgAXLUgsxbdycPaTQ5UhI2OmJmn7VLCnV3ybetuDl37bv6+bHlxOufRv5Yp5of55Pv0Cb5csZLjshXAztbW8gnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr; spf=pass smtp.mailfrom=gmx.fr; dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b=XJ0jDcV7; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.fr;
	s=s31663417; t=1729778516; x=1730383316; i=benoit.monin@gmx.fr;
	bh=+Tg6T7Zx5JMzwVi2DSF1T6BeCmhZbKmA/yMe10eZSKY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XJ0jDcV7sHuS/XOStok0nsiUp7Syv3XmFgyBc819YvwaO1k8EBZoitlU3WifsNev
	 MMv1xl4+/Zik6vl8Jo4HXRdkPA/absrj9VXRp34GmPic6fQ0MC9L3hdt1yyexZ1R6
	 5mAmUCoBNDagED9AKK0YG4mWBpnXXzA1ZQGcGKWHg4RGi6DwZyXXTrRXuvNjs/yVa
	 O8tmdV1dc4WBP7Q+xI6WEUV2LluoFc6igWjlSZTmvauSN6ltlHzy719xvmNoznvVx
	 UwR313X2Y+v/aDSNK5r/trrhP67utLoZhLNCHlS43hjEUm37IVYRa6FUo2iYHJVJc
	 jZJqj7U8AXA2RR+P2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pianobar.pianonet ([176.145.30.241]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2O1-1tZAMH02hV-00n7VR; Thu, 24
 Oct 2024 16:01:56 +0200
From: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>
Subject: [PATCH v2 net] net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension
Date: Thu, 24 Oct 2024 16:01:54 +0200
Message-ID: <5fbeecfc311ea182aa1d1c771725ab8b4cac515e.1729778144.git.benoit.monin@gmx.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:giEvIU1I27U22AFCsK8eH0m33K+9irDl+kPrnl7RtlbzKSnY4fC
 jtP7AsYP7JtEmSlAjEenE57bcTd5ZcSaMNXWLKZwujYEs16psf7HOuR77omPFLLBE03Vm1V
 9gHdzEqZ89yN43YIkAxTD/Qj6buecp+m4A9iruiG5GOsSnmaDXcqHbu0rCdcEaMetsPp3k9
 0Hm+NT1Vpifbft4W9kRcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zSkK1Tq1cBA=;xXxWl/24tyS998LC42LFKpHgDiy
 aLIXH3O+HiRvqGU/DrMPfWT7zzYGqgXOncyFrihaJVVaRxj0qhbkFlVUt/rWTFPeC09WMV1un
 oGn/IqSAsIXK27imPelqf0GKRP3hXFBz8S77YSKzKLW1m+77E0JPwynYjW0ZkGAZjIiRiOS/6
 6kLuzKxOrGayUHxcR39ul/CmKTegzGfrfo4DfunvBQCwkCDNfSHG1Fr3qvzXh1HOOrAoL1iye
 C+ZO4Cjm8xJ0qhAMLUIgqa3a6EGf/ygFFAx/anxrwt/ZiDWNRQvURGWvljYTIkgDjeeDz9T4i
 28gA9GR5yeleBMQXJKp0exDPsy/yVfumYWUmkGz+U7OVpcPPaEPc4F3lWX5uzZkIId/oEt/cA
 Y9GVe5ijoFmJQkUqgwFR5MiVzcS7NU+9sVwXe/Tm4Y2vWX1DQkZzNdbag/CI02Z0Dcdqnp7C5
 xJq70xB491RXlKEEa3dAcDZfk8yVyC+tzXGfwdWVJfHWL46fhnF2iuFNMhi4wdIsJFr4v+Ptq
 9yM333nxc+C/RQSsu/IGWXHhdLd/opX+Cl0ip2xKnjiWZP2er7VCXPnrG8FqjPPmidv+IYZLg
 rrm9KssLXK0gxyzaZsfSIZMg5RWEs+hN0rAc7Rg1hRpsqE2BejIuMBR9Dk1Suh5KYrGccXCyw
 tGgikNS6CpDRhuUlCTuJoRSusV49H0Lk2iO5tl0e1wza4KYUMl7837XR0IHCQU9urvL21wNxZ
 +MZNSP2bqUgEO2yBfQl1zb5MNzI8QbPCDyHv1ff07VXGtQr+waGgjI/HpD62wmoujOfz0Si/I
 0uvB1/wiyYt6bwMK/qSs+9FmjuUpsQn87FpCClNw61cHY=

As documented in skbuff.h, devices with NETIF_F_IPV6_CSUM capability
can only checksum TCP and UDP over IPv6 if the IP header does not
contains extension.

This is enforced for UDP packets emitted from user-space to an IPv6
address as they go through ip6_make_skb(), which calls
__ip6_append_data() where a check is done on the header size before
setting CHECKSUM_PARTIAL.

But the introduction of UDP encapsulation with fou6 added a code-path
where it is possible to get an skb with a partial UDP checksum and an
IPv6 header with extension:
* fou6 adds a UDP header with a partial checksum if the inner packet
does not contains a valid checksum.
* ip6_tunnel adds an IPv6 header with a destination option extension
header if encap_limit is non-zero (the default value is 4).

The thread linked below describes in more details how to reproduce the
problem with GRE-in-UDP tunnel.

Add a check on the network header size in skb_csum_hwoffload_help() to
make sure no IPv6 packet with extension header is handed to a network
device with NETIF_F_IPV6_CSUM capability.

Link: https://lore.kernel.org/netdev/26548921.1r3eYUQgxm@benoit.monin/T/#u
Fixes: aa3463d65e7b ("fou: Add encap ops for IPv6 tunnels")
Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>
=2D--
changelog
* v2:
    - patch against net instead of net-next
    - clarify documentation of NETIF_F_IPV6_CSUM
    - add link to thread describing the problem
    - add fixes tag
    - use vlan_get_protocol to check for IPv6
* v1:
    - https://lore.kernel.org/netdev/0dc0c2af98e96b1df20bd36aeaed4eb4e27d5=
07e.1728056028.git.benoit.monin@gmx.fr/T/#u
=2D--
 net/core/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index ea5fbcd133ae..8453e14d301b 100644
=2D-- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3639,6 +3639,9 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		return 0;

 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
+		if (vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6) &&
+		    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
+			goto sw_checksum;
 		switch (skb->csum_offset) {
 		case offsetof(struct tcphdr, check):
 		case offsetof(struct udphdr, check):
@@ -3646,6 +3649,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		}
 	}

+sw_checksum:
 	return skb_checksum_help(skb);
 }
 EXPORT_SYMBOL(skb_csum_hwoffload_help);

