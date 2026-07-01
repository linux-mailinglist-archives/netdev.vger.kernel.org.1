Return-Path: <netdev+bounces-303801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UbBZLbRnRWrG/QoAu9opvQ
	(envelope-from <netdev+bounces-303801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:17:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 219806F0C8D
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:17:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303801-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303801-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05A63300DA6B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 19:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F8238E8CE;
	Wed,  1 Jul 2026 19:17:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4739BFFC;
	Wed,  1 Jul 2026 19:17:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933425; cv=none; b=SQ2UOsnGowS2XGi6G3ZWhRCE4IqrIXdOu4+KvdQesypaOYh/mxdzSohfMj0XgW5jjXja3zuAOP0T80HxFsG+HLj5gjKXQkBaglcJa8w2VBH4+B6oxt/RY7Hqx5gIsZfvtwdBnAMOA/rYYywPCIRYQM5oJq/yYnkFuGB0xd9/fKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933425; c=relaxed/simple;
	bh=wqaB8Da37laHFc58cKhsEgK0j08j5cjtH5A4EJaj4bw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gO/1lKCIxZU7cX3oIM8mI9ww31ushOs2aMO5bpWh64KCn6Q2BHSAemkiGuqEjKZGw7ureMbHkLNelDDRiUvvw43hFldtG04ZPC75fqYYZ0bsScTvXEdT+8Hl7wuqa+jY+lhi9upxjffWd/2OjB/TiPXV2VxLezZnyv90UNBOK8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Date: Wed, 1 Jul 2026 21:16:48 +0200
From: Brett Sheffield <bacs@librecast.net>
To: regressions@lists.linux.dev, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	Simon Schippers <simon.schippers@tu-dortmund.de>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded network
 performance
Message-ID: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303801-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[librecast.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bacs@librecast.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:regressions@lists.linux.dev,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:mst@redhat.com,m:simon.schippers@tu-dortmund.de,m:tim.gebauer@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,tu-dortmund.de,gmail.com,lunn.ch,davemloft.net,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bacs@librecast.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,karahi.librecast.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 219806F0C8D

TL;DR - Commit 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 causes
significant performance regressions with TAP interfaces and multithreaded
network code. Please revert.


Librecast is an IPv6 multicast library. One of the tests (0055) fails under
Linux 7.2-rc1. The test performs data synchronization over IPv6 multicast using a TAP
interface. This test has run successfully on every stable, LTS and mainline RC
released in the past year. Every kernel with my Tested-by has run this test.

There have been a bunch of changes to MLDv2 so I started bisecting there, but
the culprit is actually 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 "tun/tap &
vhost-net: avoid ptr_ring tail-drop when a qdisc is present"

Reverting this commit fixes the test.

To eliminate my code and any multicast weirdness, I ran tests with iperf3
comparing the same host running 7.2-rc1 both with and without 1d6e569b7d0
reverted.

CPU: AMD Ryzen 9 9950X

[ host ] - [ bridge ] - [ tap ] - [ guest (qemu) ]

Running matching kernels on host and guest, I started iperf3 in server mode on
the guest and tested from the host so traffic passes through the tap interface.

iperf3 -s -V                 # server
iperf3 -c guest -P nthreads  # client

7.2.0-rc1 (threads 1):

[  5]   0.00-10.00  sec  20.2 GBytes  17.4 Gbits/sec    0            sender
[  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver

7.2.0-rc1 (threads 1, reverted):

[  5]   0.00-10.00  sec  15.3 GBytes  13.1 Gbits/sec  368            sender
[  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver

7.2.0-rc1 (threads 2):

[SUM]   0.00-10.00  sec  10.9 GBytes  9.33 Gbits/sec    0             sender
[SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver

7.2.0-rc1 (threads 2, reverted):

[SUM]   0.00-10.00  sec  15.9 GBytes  13.7 Gbits/sec  1567             sender
[SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver

7.2.0-rc1 (threads 4):

[SUM]   0.00-10.00  sec  10.9 GBytes  9.33 Gbits/sec    0             sender
[SUM]   0.00-10.00  sec  8.00 GBytes  6.87 Gbits/sec                  receiver

7.2.0-rc1 (threads 4, reverted):

[SUM]   0.00-10.00  sec  16.5 GBytes  14.1 Gbits/sec  6701             sender
[SUM]   0.00-10.00  sec  8.00 GBytes  6.87 Gbits/sec                  receiver

7.2.0-rc1 (threads 8):

[SUM]   0.00-10.00  sec  10.7 GBytes  9.15 Gbits/sec    0             sender
[SUM]   0.00-10.01  sec  10.6 GBytes  9.13 Gbits/sec                  receiver

7.2.0-rc1 (threads 8, reverted):

[SUM]   0.00-10.00  sec  16.2 GBytes  14.0 Gbits/sec  19319             sender
[SUM]   0.00-10.00  sec  15.7 GBytes  13.5 Gbits/sec                  receiver

7.2.0-rc1 (threads 16):

[SUM]   0.00-10.00  sec  10.9 GBytes  9.35 Gbits/sec    0             sender
[SUM]   0.00-10.01  sec  10.9 GBytes  9.32 Gbits/sec                  receiver

7.2.0-rc1 (threads 16, reverted):

[SUM]   0.00-10.00  sec  14.4 GBytes  12.4 Gbits/sec  43593             sender
[SUM]   0.00-10.00  sec  14.4 GBytes  12.4 Gbits/sec                  receiver


As you can see, the new code works for single threaded, but for all other cases
there's a significant performance drop. I see this trade-off is mentioned in the
commit, but the performance drop off is much worse than suggested with the
current patch.

In our multicast use case data is sent by multiple threads to multiple groups
simultaneously, this just breaks things to the extent that a <2 second test
times out after 5 minutes.


git bisect start
# status: waiting for both good and bad commits
# bad: [dc59e4fea9d83f03bad6bddf3fa2e52491777482] Linux 7.2-rc1
git bisect bad dc59e4fea9d83f03bad6bddf3fa2e52491777482
# status: waiting for good commit(s), bad commit known
# good: [36bdc0e815b4e8a05b9028d8ef8a25e1ead35cc1] net: usb: asix: ax88772: re-add usbnet_link_change() in phylink callbacks
git bisect good 36bdc0e815b4e8a05b9028d8ef8a25e1ead35cc1
# good: [db314398f618a3a23315f73c87f7d318eaf06c1b] Merge branch 'net-bridge-mcast-support-exponential-field-encoding'
git bisect good db314398f618a3a23315f73c87f7d318eaf06c1b
# bad: [079a028d6327e68cfa5d38b36123637b321c19a7] string: Remove strncpy() from the kernel
git bisect bad 079a028d6327e68cfa5d38b36123637b321c19a7
# bad: [f396f4005180928cd9e15e352a6512865d3bc908] Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path
git bisect bad f396f4005180928cd9e15e352a6512865d3bc908
# bad: [ec1806a730a1c0b3d68a7f9afe81514fb0dd7991] netfilter: x_tables: disable 32bit compat interface in user namespaces
git bisect bad ec1806a730a1c0b3d68a7f9afe81514fb0dd7991
# good: [50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85] mptcp: do not drop partial packets
git bisect good 50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85
# good: [68993ced0f618e36cf33388f1e50223e5e6e78cc] Merge tag 'net-7.1-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good 68993ced0f618e36cf33388f1e50223e5e6e78cc
# good: [34c78dff59a25110a4ce50c208e42a91490fe615] Merge branch 'net-use-ip_outnoroutes-drop-reason'
git bisect good 34c78dff59a25110a4ce50c208e42a91490fe615
# bad: [9587ed8137fb83d93f84b858337412f4500b21e9] Merge branch 'gve-add-support-for-ptp-gettimex64'
git bisect bad 9587ed8137fb83d93f84b858337412f4500b21e9
# bad: [83ea7fd73b11dd8cbf4416507a5eac3890b49fb0] net: dsa: microchip: remove unused phylink_mac_link_up() callback
git bisect bad 83ea7fd73b11dd8cbf4416507a5eac3890b49fb0
# bad: [f0de88303d5e7e04a1224bc7a00512b5a1c4fe7a] net: make is_skb_wmem() available to modules
git bisect bad f0de88303d5e7e04a1224bc7a00512b5a1c4fe7a
# bad: [c411baa463e85a779a7e68a00ba6298770b58c4c] netconsole: move push_ipv6() from netpoll
git bisect bad c411baa463e85a779a7e68a00ba6298770b58c4c
# good: [fba362c17d9d9211fc51f272156bb84fc23bdf98] ptr_ring: move free-space check into separate helper
git bisect good fba362c17d9d9211fc51f272156bb84fc23bdf98
# bad: [d0273dbe8be1640e597552f81faf1d6c9997d3e3] ipvlan: use netif_receive_skb() in ipvlan_process_multicast()
git bisect bad d0273dbe8be1640e597552f81faf1d6c9997d3e3
# bad: [3803065cd6b0630d4161d86aa04e2d1db0f3a0b5] Merge branch 'tun-tap-vhost-net-apply-qdisc-backpressure-on-full-ptr_ring-to-reduce-tx-drops'
git bisect bad 3803065cd6b0630d4161d86aa04e2d1db0f3a0b5
# bad: [1d6e569b7d0c0b2736636749e4be0a27f3cefcb3] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
git bisect bad 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3
# first bad commit: [1d6e569b7d0c0b2736636749e4be0a27f3cefcb3] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present

-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/

