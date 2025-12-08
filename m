Return-Path: <netdev+bounces-243990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75ACACDA3
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 11:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 724A1301B2F1
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2B2E7F0A;
	Mon,  8 Dec 2025 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="WwEjNKYq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630D25EFBC
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189501; cv=none; b=auhVU6qbWdLSGbprMWZsFes5lKN52X9ResJCnL1c7SHcKqH/e4D5spGwXijreE5Kq33Mt09X59zLgk3AxdbjQcto+er1v9iSaUUbrr+UTzimOxOQ9cXGzkpB3t5MQb8khJBOtAmsnQmzjqalrvJl9Pk9DLRDLVFQzV/t5bSnW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189501; c=relaxed/simple;
	bh=urBRI5mQ3W6jRHj9HJf6Zts2GffxIzosvB/Sars+UlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPTqmZeKKQARZoARBmQm7PxxEPaJT+GzfWftDeycjZfqsfthUi8MnCouzmU3fBM8xB/1aG8x7citXeSwIub0gLho3A27F26O3bRcVRNSwnwlg2Wt+c9Ay+FxGVdmHvvrK8lPZvDWDBqbYVZVY91HoTrY0ek1FtCj8ENFeW0Xmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=WwEjNKYq; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-47928022b93so9710635e9.0
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 02:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1765189498; x=1765794298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aiAd0xgp/TJjgAbPV/mUk0PsFman1gkyYkC62biNpF0=;
        b=WwEjNKYqk/1BdGqgaij1WopNmBV/5csUyin2FeizhXvCGaD/SbGzsmD0LJYIlPAyVM
         mHU3ZuTfSfJXJ03i8iwPdv7L8Hfqy+IRRIzfljBYVk11qrK+Xnocrj+NCxeFDs+DVCJW
         izXmikKsLN+fuk+4dT+9nX8pqW/0x5hSoTxhligoCdsqXQT9Cjhg1CskB2RpPeCjSK1D
         qWCgC/jAIPdCgu5WvySeONqHM4LGi4MloxtQn1ATin1marHpb7VdC6bDhfRFX/lKoOxs
         zezulYqhIY/LDRH9xyh5yJvO+1kJ01oS9iYeh8p9hJtKuKNNBX7XEexvyLK7cmq6POaq
         rlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765189498; x=1765794298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiAd0xgp/TJjgAbPV/mUk0PsFman1gkyYkC62biNpF0=;
        b=Pcqo9EOLm2IV2PYx9K6RBSZkZf6SQwyfG7WAwoyvGRlxw3IL7sT7zh32NcvQ+mGvUm
         LPAPT08YzXc80ZCswGh0VO1ZtYqXyuwmGxK+2g/gS+At4l/Zg+8rfnTiYTttTMMfJSIh
         2N/at+eE3tMAxVKFHtLy+9qIl8Uvk/QHjHIoDw87QPSwwFzvcsIHb5X2TlJF+bRS7clb
         E6PolgYGFzgyIizCaB9c3EBu6JejhRk1DBskuaIW65SpGIfxwmxXu7EvMCvztGxt10Vv
         G5fEXGpKzRWgFXO/X4Ak0Xh3SZS1NMYCPEAW6qL6wz9naUmHW+3d+sTCgA9GCxM1fYQV
         LFFg==
X-Gm-Message-State: AOJu0Yxn4sRk0A9DTSe3D+IMnpnsKViJOnaE+uxn4KxwtltuJZkV3gJ6
	emiZPAgpCLmYCwpC8fLz1vPtihBiCBK+O9wtERqeN07nhfRa62DhX1XU7dsemVbhmXK3jaSgKkz
	zJCGgWkHn1V4CfjEtP70qR/9FwbpobaF452ZO
X-Gm-Gg: ASbGncsdz3pXoNZDAb+XKw2iFaKOgFzUAci2XXypZC9JO5j/s5i6h9ZH5C8T3hBFTUJ
	geZbSkwG0nvHgQl+c9N5bvJhnN5iHpuy6v8Okzy1qgG+GhcHGeNtRtifvht2NH5UvO83QzvCuoq
	NDHKOahpE/Pp1QbtQrnWPJETl6cqT/HfIlIBbq9E8HqoXoamRq5RsVDdlLBoKcjNyFMOZ1SEh5b
	MbiMHuMSiR/vHoA6emI//AyvRWEMHvnDUEDiswSTH66wmiPdK/cci0Ap7E+RFLIpkOhAkHYiCEE
	VxDCOZPTPbYehGVpd88cATf/2iWTgxyNpFioJPf2JNkMlLnP1SP5V0m1GRWxwFvGjF4dldng4tY
	uF8U6mo3w7vmL78lyXe24zKeIDP7SlToDRvwtxS9B0/SPqtfTjaUFpuO2Ko6LOgtW
X-Google-Smtp-Source: AGHT+IGN0Nr0UyrqdAVsQmSm+850c8k7Lsfg0eDE+JnAUC49/TgGJx4NszUepianRIGUrP1sqbVvIu+TGnh9
X-Received: by 2002:a05:600c:1f89:b0:477:a478:3f94 with SMTP id 5b1f17b1804b1-47939e35dc4mr49076335e9.5.1765189497976;
        Mon, 08 Dec 2025 02:24:57 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-479311ee36dsm102347265e9.15.2025.12.08.02.24.57;
        Mon, 08 Dec 2025 02:24:57 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id C8E6928026;
	Mon,  8 Dec 2025 11:24:57 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1vSYQL-00EB9P-ID; Mon, 08 Dec 2025 11:24:57 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Lebrun <david.lebrun@uclouvain.be>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net] seg6: fix route leak for encap routes
Date: Mon,  8 Dec 2025 11:24:34 +0100
Message-ID: <20251208102434.3379379-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal is to take into account the device used to set up the route.
Before this commit, it was mandatory but ignored. After encapsulation, a
second route lookup is performed using the encapsulated IPv6 address.
This route lookup is now done in the vrf where the route device is set.

The l3vpn tests show the inconsistency; they are updated to reflect the
fix. Before the commit, the route to 'fc00:21:100::6046' was put in the
vrf-100 table while the encap route was pointing to veth0, which is not
associated with a vrf.

Before:
> $ ip -n rt_2-Rh5GP7 -6 r list vrf vrf-100 | grep fc00:21:100::6046
> cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] dev veth0 metric 1024 pref medium
> fc00:21:100::6046 via fd00::1 dev veth0 metric 1024 pref medium

After:
> $ ip -n rt_2-Rh5GP7 -6 r list vrf vrf-100 | grep fc00:21:100::6046
> cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] dev veth0 metric 1024 pref medium
> $ ip -n rt_2-Rh5GP7 -6 r list | grep fc00:21:100::6046
> fc00:21:100::6046 via fd00::1 dev veth0 metric 1024 pref medium

Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/ipv6/seg6_iptunnel.c                                | 6 ++++++
 tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh | 2 +-
 tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh  | 2 +-
 tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh  | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 3e1b9991131a..9535aea28357 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -484,6 +484,12 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	 * now and use it later as a comparison.
 	 */
 	lwtst = orig_dst->lwtstate;
+	if (orig_dst->dev) {
+		rcu_read_lock();
+		skb->dev = l3mdev_master_dev_rcu(orig_dst->dev) ?:
+			dev_net(skb->dev)->loopback_dev;
+		rcu_read_unlock();
+	}
 
 	slwt = seg6_lwt_lwtunnel(lwtst);
 
diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
index a5e959a080bb..682fb5b4509d 100755
--- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
@@ -333,7 +333,7 @@ setup_vpn_config()
 		encap seg6 mode encap segs ${vpn_sid} dev veth0
 	ip -netns ${rtsrc_name} -4 route add ${IPv4_HS_NETWORK}.${hsdst}/32 vrf vrf-${tid} \
 		encap seg6 mode encap segs ${vpn_sid} dev veth0
-	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 vrf vrf-${tid} \
+	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 \
 		via fd00::${rtdst} dev veth0
 
 	# set the decap route for decapsulating packets which arrive from
diff --git a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
index a649dba3cb77..11f693c65169 100755
--- a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
@@ -287,7 +287,7 @@ setup_vpn_config()
 	# host hssrc and destined to the access router rtsrc.
 	ip -netns ${rtsrc_name} -4 route add ${IPv4_HS_NETWORK}.${hsdst}/32 vrf vrf-${tid} \
 		encap seg6 mode encap segs ${vpn_sid} dev veth0
-	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 vrf vrf-${tid} \
+	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 \
 		via fd00::${rtdst} dev veth0
 
 	# set the decap route for decapsulating packets which arrive from
diff --git a/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
index e408406d8489..7d7e056c645c 100755
--- a/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
@@ -297,7 +297,7 @@ setup_vpn_config()
 	# host hssrc and destined to the access router rtsrc.
 	ip -netns ${rtsrc_name} -6 route add ${IPv6_HS_NETWORK}::${hsdst}/128 vrf vrf-${tid} \
 		encap seg6 mode encap segs ${vpn_sid} dev veth0
-	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 vrf vrf-${tid} \
+	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 \
 		via fd00::${rtdst} dev veth0
 
 	# set the decap route for decapsulating packets which arrive from
-- 
2.47.1


