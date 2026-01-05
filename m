Return-Path: <netdev+bounces-247086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925DCF459B
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69D4F3005F3B
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A62A3090CD;
	Mon,  5 Jan 2026 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="IJ58j31C"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2005a-snip4-3.eps.apple.com [57.103.89.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB58280CF6
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626313; cv=none; b=PnSrP8znOrGO5dzI+RxaVUsA3OszCOVUuml8gFaZjoH+wqkuomYXeUpJjM5u74ANb36WY0gxtzpIWErIwHLsuT1g+CqkaKvFco/h0OEgcSQjEz07Weo5IdrWnGBFZp8EcW3jc66bWNgEjKkdmcBNhIIJWYDSySQ8CTeLm0QJaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626313; c=relaxed/simple;
	bh=SVxOsw2k3KVq6Ted7fFwk6/YKVJHu8/dTlrsg5slf3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z74+c0lSVI0TgFWxOEMXaic+CrjVe215SlC+iB3Y2fiG5tOkqHvp15s/EvzXzTV81lsRPJ8gGZZndseejROVqprDHUDBbOGFSsHf2jrpCb9tNQtUvenqqsYhZLeuZPuPzlkOszq3knf0AnqQyJ/v6ZNoYNMc5QPo7LfUyQUKMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=IJ58j31C reason="key not found in DNS"; arc=none smtp.client-ip=57.103.89.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id 10AC918004B9;
	Mon,  5 Jan 2026 15:18:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=YISc121iEw1U0K84tC+9FLPepOG5WP12STjtWNLyhzM=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=IJ58j31CzJZat2P0Nu4KBdMBxE/fAgmRrhe2p8rnvFYnoXtjLs4yHoFR8QOQFI1aKQjZYSqzWBZjd9n/DCDs4DJ5NqJ94q9qWo7MqxecUdYmSyBvN95DyIufmT8H/cnf6tvyursVrMz2sPPI+B4Xx69k9R0FMpY0cxmQFqDfXxe4/ut6LSkEHBu1bYME3DXOfeb/Fvh7yIRekvQrSR1BKs0jAoKxtIqmw5DJ57fiyXY3+pzZK5kKgRfY+Axe1Vbkb2ya3CAYhm4/XCTDBvsVjOoKLHRWnx/KEmpY21F6+Fs0CfpBOyI8KJ7no5eaKvVieoG9Oa07t7Bw+UI8aAvmBw==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id A220B18000AF;
	Mon,  5 Jan 2026 15:18:26 +0000 (UTC)
From: Yohei Kojima <yk@y-koj.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] net: netdevsim: fix inconsistent carrier state after link/unlink
Date: Tue,  6 Jan 2026 00:17:32 +0900
Message-ID: <602c9e1ba5bb2ee1997bb38b1d866c9c3b807ae9.1767624906.git.yk@y-koj.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1767624906.git.yk@y-koj.net>
References: <cover.1767624906.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEzNCBTYWx0ZWRfX+5JGg4Jb4fJE
 zQl9WnkzRvGIG/vg9AgoFz1mKbCecm+fV7GOBqmynoxydF02nkEx7WVIkfKmP0AbAHTyTZqO5HN
 7YnTWnapEm3dMbg+p/1IdU3zO/ORt2l61tJvxuMEhf+K8f3sRGZZhkIetbxtkiSv5I+PLBDFZYJ
 TfyhgvPpQ9QohY4dvoRyPpqYrv8KT8JdrJKHI0mx0VNib+A1or6sVfH1wfAaQm995jgxH5TdiTm
 cylVSADca4DPKzMR9aJuZ/WFrxfYexB02EWGMF4OHY5pZplMgtXOiZ/uLjOW8OBre7uGJdcWgQh
 3S/c1lnkIUllM9pkUgw
X-Proofpoint-GUID: GTo9MAcgiIL292q951e2ibbNGduPR6Fw
X-Authority-Info: v=2.4 cv=Zqfg6t7G c=1 sm=1 tr=0 ts=695bd646 cx=c_apl:c_pps
 a=2G65uMN5HjSv0sBfM2Yj2w==:117 a=2G65uMN5HjSv0sBfM2Yj2w==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jnl5ZKOAAAAA:8 a=xNf9USuDAAAA:8
 a=7gZhQl7Q0LLefV5nMKsA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-ORIG-GUID: GTo9MAcgiIL292q951e2ibbNGduPR6Fw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 clxscore=1030 phishscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601050134
X-JNJ: AAAAAAABw8wxKkH38tEO1aIPKKXnC5qt0sRs8Nn01BA+aZmaKvGPKn/nsFht75n4+wCKWhLsdWBxvmqDBa4CfMtUhjo21JArfqJ6u0v2cGdmPG74VsSgHDTbE81BAbc2oXl+IpunLFX4zey2tIiVspTe4v4sqeoT1bzWzGlFwp7RZelDpsNxIgmWhMj4u9a/yt7R1+KFmMBXnuQqlO8PSJ1Z+9MoSSBr14bOQdRP8deX5A6c9xBemnTfavwIzRIKLaKQHeQdWrcZOUYjxbdMp8bgJ9Y0fJx70yjZrL6VHJSzocfqJpCIILmVg7QpV/fHvK5XByVmw6KamcILmEjjX9TuqG7+fPvhy9X9L8EtbGTc2lax7fG5tlTE7WG0pqfQA4Lb2ACWfTm5XgAyY+BJ0THkVt2MIpAeAsNT1yr64ag1NAef30uXEYnniAyd9Q4dza99vqJIQB3rCr24HNq8cDq+KGO2zi9vFAiUkQJ2c2DhBLPfJzll34rJqOkq0/KsArEq2U/KaDNtnMqSqzHR9AWN1EUo9E5WQPY61WbxH3etJdtSTJjoURcrw7T8qq8p9Y1HeLHziHdPV5vJzqJtBZk/a2upGrMy9xX2stpXzjSXHn6HBExe4Lv+rMP8ofBiwqgv+UT8t1fuNqGiobzFptPEn3C3IvqAx+gkbmRlIzriwkGcciwYwp2w2IMXbVTEH0EUhczbMI+h0UyFSOS2OlyYSsWW1PNFb1PFe/NXJd+p870qXIXV2Kbi09KIIGlvDaIDEjMDhgPGQPS08yrBAG6lXTXE0E+Vf4LMw+MX5Q==

This patch fixes the edge case behavior on ifup/ifdown and
linking/unlinking two netdevsim interfaces:

1. unlink two interfaces netdevsim1 and netdevsim2
2. ifdown netdevsim1
3. ifup netdevsim1
4. link two interfaces netdevsim1 and netdevsim2
5. (Now two interfaces are linked in terms of netdevsim peer, but
    carrier state of the two interfaces remains DOWN.)

This inconsistent behavior is caused by the current implementation,
which only cares about the "link, then ifup" order, not "ifup, then
link" order. This patch fixes the inconsistency by calling
netif_carrier_on() when two netdevsim interfaces are linked.

This patch fixes buggy behavior on NetworkManager-based systems which
causes the netdevsim test to fail with the following error:

  # timeout set to 600
  # selftests: drivers/net/netdevsim: peer.sh
  # 2025/12/25 00:54:03 socat[9115] W address is opened in read-write mode but only supports read-only
  # 2025/12/25 00:56:17 socat[9115] W connect(7, AF=2 192.168.1.1:1234, 16): Connection timed out
  # 2025/12/25 00:56:17 socat[9115] E TCP:192.168.1.1:1234: Connection timed out
  # expected 3 bytes, got 0
  # 2025/12/25 00:56:17 socat[9109] W exiting on signal 15
  not ok 13 selftests: drivers/net/netdevsim: peer.sh # exit=1

This patch also solves timeout on TCP Fast Open (TFO) test in
NetworkManager-based systems because it also depends on netdevsim's
carrier consistency.

Fixes: 1a8fed52f7be ("netdevsim: set the carrier when the device goes up")
Signed-off-by: Yohei Kojima <yk@y-koj.net>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netdevsim/bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 70e8c38ddad6..d16b95304aa7 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -332,6 +332,11 @@ static ssize_t link_device_store(const struct bus_type *bus, const char *buf, si
 	rcu_assign_pointer(nsim_a->peer, nsim_b);
 	rcu_assign_pointer(nsim_b->peer, nsim_a);
 
+	if (netif_running(dev_a) && netif_running(dev_b)) {
+		netif_carrier_on(dev_a);
+		netif_carrier_on(dev_b);
+	}
+
 out_err:
 	put_net(ns_b);
 	put_net(ns_a);
@@ -381,6 +386,9 @@ static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf,
 	if (!peer)
 		goto out_put_netns;
 
+	netif_carrier_off(dev);
+	netif_carrier_off(peer->netdev);
+
 	err = 0;
 	RCU_INIT_POINTER(nsim->peer, NULL);
 	RCU_INIT_POINTER(peer->peer, NULL);
-- 
2.51.2


