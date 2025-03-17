Return-Path: <netdev+bounces-175495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A1AA66202
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 23:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 470407AB3B9
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991DC204F6A;
	Mon, 17 Mar 2025 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=sandropischinger.de header.i=@sandropischinger.de header.b="LrlPBbb/"
X-Original-To: netdev@vger.kernel.org
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8CF204596
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251813; cv=none; b=M25WkF3NLCcz7RsEfx34bUaD9gjFSiH3R6fVEwgegdTKu96JN9lHm7FezDs4OuP+RL4/q0u6KhtNM7eAUMi/keBbTLw5gxvP6P7J7NaKECNYn3Iz86L+I/+zouexVxkmPZOkqOLNPcIKoiFsT0xdgy2shIbS/y0SvXctZKcOAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251813; c=relaxed/simple;
	bh=fc3WG6UFW0l4VdaDXLqPFhzUts1S6Myw6fnyGAl1OMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRd/bgr3supdWEgiOUGoXYQXirVCC+dDZEBhpxP4fTs1+51my8rC5OK7n+PCybBdgTChH3TOSOehe0QL+dh+CSZD728IOjeOFkti8zgtvkx/UHN2LwGI2QWrjuWL27tnZHgm7a69gizc6cKg1gyiRjxbfZgSUOcy6my16TDvDd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandropischinger.de; spf=pass smtp.mailfrom=sandropischinger.de; dkim=pass (4096-bit key) header.d=sandropischinger.de header.i=@sandropischinger.de header.b=LrlPBbb/; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandropischinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandropischinger.de
Received: from daphnis.uberspace.de (daphnis.uberspace.de [185.26.156.151])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 8AD0B181451
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 23:43:52 +0100 (CET)
Received: (qmail 9731 invoked by uid 989); 17 Mar 2025 22:43:52 -0000
Authentication-Results: daphnis.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by daphnis.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 17 Mar 2025 23:43:52 +0100
From: Sandro Pischinger <kernel@sandropischinger.de>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sandro Pischinger <kernel@sandropischinger.de>
Subject: [bug report, net-next] lo.disable_ipv6=1 allows ::1 dst packet to take a default route
Date: Mon, 17 Mar 2025 23:43:00 +0100
Message-ID: <20250317224300.25985-1-kernel@sandropischinger.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: +
X-Rspamd-Report: MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 1.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=sandropischinger.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=fc3WG6UFW0l4VdaDXLqPFhzUts1S6Myw6fnyGAl1OMA=;
	b=LrlPBbb/vaFOGJVms/tE4DkxaNf914t/C+Uv+AoAgBzT1oTsTrowTO34DMnlV7BZtn0bqgk4RW
	DH+M5Ui5i544Oq8mEa91ZuN6vZrb6fWZBgSJVqGAQzv2bIPrPb8YcpRwGcsXEjAsA0pPjoAER4GU
	1Y5FM8SIxl7XE7CKyEScJvC84S4pAJL5tIlzfBSVprMagTItI1O4iexve6fTcBRzeK89Js4ZPEZq
	hmBg5Z2cvm2EU038EXtseFpjTkmO+wl1zZsrDZW98NbXuKxnlzeEobHeCdWXpfkoKhl0dKIiV3rp
	NOe8uiJC3+3FIr1NwRjRuVEOVnlKEU08EP0eE/lVAEbX7Je3sFXDFsrG2LALBvkUsLiZj00wIQmQ
	QVjAsMphQfMstP9OjLFvA+9FARsOBx6WdRTLZDiL9eoZ56LITZcD+roJWr621gUow8BecAkSGLJB
	zzkE+0QwqoCx97Lvn2exPqx1o4i/k8y69AnfiQv2Flu+wQF6yTLZoAgS3HvVQ+sUxUO6hccOAdnb
	4JDSqQnWX8MobQz1+3rwpnUigHivjPamV8q5dnI0jgPXLYgxF2YTGnclkaEiReBNbMPpG+zR6W40
	9vl7/Fzq0KSxXjndXvHLL7fO3+LQB3pmJGGV8Hqe+vaHy7xVFPypZD7/k5iQXbAt1S+tnLJ7Wfgg
	0=

Hello all,

I stumbled upon an issue when disabling ipv6 just for the loopback device.
Afer doing so, sending a packet with destination ::1 will follow an available
default route, if exists, e.g. "default via fe80::2 dev ens3". This seems
to contradict RFC4291 2.5.3, which states that loopback packets must never leave
the node.

Using mainline kernel v6.14-rc7, configured with
x86_64_defconfig and kvm_guest.config on archlinux (in qemu):

$ ip -6 r
fe80::/64 dev ens3 proto kernel metric 256 pref medium
fec0::/64 dev ens3 proto ra metric 1002 pref medium
multicast ff00::/8 dev ens3 proto kernel metric 256 pref medium
default via fe80::2 dev ens3 proto ra metric 1002 pref medium

$ ip -6 r get ::1
local ::1 dev lo proto kernel src ::1 metric 0 pref medium

$ sysctl -w net.ipv6.conf.lo.disable_ipv6=1
net.ipv6.conf.lo.disable_ipv6 = 1

$ ip -6 r get ::1
::1 via fe80::2 dev ens3 proto ra src fe80::c9cb:505e:82a2:8ca7 metric 1002 pref medium

When observing trace events `fib6_table_lookup` for ping ::1, then we see that the ens3 device is selected
for the case when ipv6 is disabled for lo:
== lo.disable_ipv6=0
            ping-356   [000] .....   292.199930: fib6_table_lookup:    (ffffffff84041fd4)
            ping-356   [000] .....   292.199932: fib6_table_lookup:    table 254 oif 0 iif 1 proto 17 ::/56460 -> ::1/1025 flowlabel 0 tos 0 scope 0 flags 0 ==> dev lo gw :: err 0
            ping-356   [000] .....   292.200176: fib6_table_lookup:    (ffffffff84041fd4)
            ping-356   [000] .....   292.200176: fib6_table_lookup:    table 254 oif 0 iif 1 proto 58 ::/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev lo gw :: err 0
            ping-356   [000] ..s2.   292.200187: fib6_table_lookup:    (ffffffff84041fd4)
            ping-356   [000] ..s2.   292.200187: fib6_table_lookup:    table 254 oif 1 iif 1 proto 58 ::1/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev lo gw :: err 0
            ping-356   [000] .....   293.255592: fib6_table_lookup:    (ffffffff84041fd4)
            ping-356   [000] .....   293.255594: fib6_table_lookup:    table 254 oif 0 iif 1 proto 58 ::/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev lo gw :: err 0
            ping-356   [000] ..s2.   293.255606: fib6_table_lookup:    (ffffffff84041fd4)
            ping-356   [000] ..s2.   293.255606: fib6_table_lookup:    table 254 oif 1 iif 1 proto 58 ::1/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev lo gw :: err 0
            ping-356   [000] .....   294.279429: fib6_table_lookup:    (ffffffff84041fd4)
            ping-356   [000] .....   294.279430: fib6_table_lookup:    table 254 oif 0 iif 1 proto 58 ::/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev lo gw :: err 0
            ping-356   [000] ..s2.   294.279441: fib6_table_lookup:    (ffffffff84041fd4)
            ping-356   [000] ..s2.   294.279441: fib6_table_lookup:    table 254 oif 1 iif 1 proto 58 ::1/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev lo gw :: err 0
            ping-356   [000] .....   295.303440: fib6_table_lookup:    (ffffffff84041fd4)
            ping-356   [000] .....   295.303442: fib6_table_lookup:    table 254 oif 0 iif 1 proto 58 ::/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev lo gw :: err 0
            ping-356   [000] ..s2.   295.303451: fib6_table_lookup:    (ffffffff84041fd4)
            ping-356   [000] ..s2.   295.303452: fib6_table_lookup:    table 254 oif 1 iif 1 proto 58 ::1/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev lo gw :: err 0

== lo.disable_ipv6=1
            ping-363   [000] .....   358.104211: fib6_table_lookup:    (ffffffff84041fd4)
            ping-363   [000] .....   358.104213: fib6_table_lookup:    table 254 oif 0 iif 1 proto 17 ::/37566 -> ::1/1025 flowlabel 0 tos 0 scope 0 flags 0 ==> dev ens3 gw fe80::2 err 0
            ping-363   [000] .....   358.104453: fib6_table_lookup:    (ffffffff84041fd4)
            ping-363   [000] .....   358.104453: fib6_table_lookup:    table 254 oif 0 iif 1 proto 58 ::/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev ens3 gw fe80::2 err 0
            ping-363   [000] .....   359.111414: fib6_table_lookup:    (ffffffff84041fd4)
            ping-363   [000] .....   359.111415: fib6_table_lookup:    table 254 oif 0 iif 1 proto 58 ::/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev ens3 gw fe80::2 err 0
            ping-363   [000] .....   360.135436: fib6_table_lookup:    (ffffffff84041fd4)
            ping-363   [000] .....   360.135437: fib6_table_lookup:    table 254 oif 0 iif 1 proto 58 ::/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev ens3 gw fe80::2 err 0
            ping-363   [000] .....   361.159595: fib6_table_lookup:    (ffffffff84041fd4)
            ping-363   [000] .....   361.159597: fib6_table_lookup:    table 254 oif 0 iif 1 proto 58 ::/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev ens3 gw fe80::2 err 0
            ping-363   [000] .....   362.183614: fib6_table_lookup:    (ffffffff84041fd4)
            ping-363   [000] .....   362.183616: fib6_table_lookup:    table 254 oif 0 iif 1 proto 58 ::/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev ens3 gw fe80::2 err 0
            ping-363   [000] .....   363.207450: fib6_table_lookup:    (ffffffff84041fd4)
            ping-363   [000] .....   363.207452: fib6_table_lookup:    table 254 oif 0 iif 1 proto 58 ::/0 -> ::1/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev ens3 gw fe80::2 err 0
     ksoftirqd/0-16    [000] ..s..   363.527470: fib6_table_lookup:    (ffffffff84041fd4)
     ksoftirqd/0-16    [000] ..s..   363.527471: fib6_table_lookup:    table 254 oif 0 iif 2 proto 58 fe80::2/0 -> fe80::c9cb:505e:82a2:8ca7/0 flowlabel 0 tos 0 scope 0 flags 0 ==> dev ens3 gw :: err 0

Intuitively I would expect `ping ::1` to fail with `ping: connect: Network is unreachable`,
as it does if there's no default route configured. However if there is one,
then ping just continues trying to send packets via the matching default route.

$ ping ::1
PING ::1 (::1) 56 data bytes
^C
    ::1 ping statistics ---
11 packets transmitted, 0 received, 100% packet loss, time 10230ms

Searching through the netdev mailing list archive, I found a somewaht related discussion,
where special handling for ::1 was mentioned. In particular one comment by Stephen Hemminger was:
as found in
  https://lore.kernel.org/netdev/20101216132812.2d7fd885@nehalam/
  Message-ID: <20101216132812.2d7fd885@nehalam> :

> When loopback device is being brought down, then keep the route table
> entries because they are special. The entries in the local table for
> linklocal routes and ::1 address should not be purged.

I don't understand enough of kernel IPv6 networking in order to
known if this is (still) the case today.

Is this behavior intended? If not, here's my draft patch for this, though
I'm not familiar with the codebase and cannot foresee any side-effects.

Best regards,
Sandro Pischinger

Signed-off-by: Sandro Pischinger <kernel@sandropischinger.de>
---
 net/ipv6/route.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index fb2e99a56529..b27844de3baa 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2193,6 +2193,12 @@ int fib6_table_lookup(struct net *net, struct fib6_table *table, int oif,
 
 redo_rt6_select:
 	rt6_select(net, fn, oif, res, strict);
+	if (ipv6_addr_loopback(&fl6->daddr)) {
+		struct fib6_info *rt = res->f6i;
+
+		if (!rt || !(rt->fib6_flags & RTF_LOCAL))
+			res->f6i = net->ipv6.fib6_null_entry;
+	}
 	if (res->f6i == net->ipv6.fib6_null_entry) {
 		fn = fib6_backtrack(fn, &fl6->saddr);
 		if (fn)
-- 
2.48.1


