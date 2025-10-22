Return-Path: <netdev+bounces-231829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA82BFDD40
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF7E24F9790
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A1234C810;
	Wed, 22 Oct 2025 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="hOiDqnde"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171D2EBDEB;
	Wed, 22 Oct 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157642; cv=none; b=G5Fksr+QEDvkwYiMK4OE3AYUm5GSqWt3lJVIDby2nhLlMvfIj1o7GScSEGD9qOXzUQjniNGM+dM6QfJs3ay/Mn3HSgXGL7/1QYtpa/sYuZICzFkI1EfLWYLhVSMWgfY2NSNkzLAN/tXMBu16Sy9nmkjVyqqWEgq27RSIn9VTVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157642; c=relaxed/simple;
	bh=NgDePtBbene/8a4nTruU8kuIN+TmkEF5/1EK9+oGnz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTQoDJio2q+lU+NXbvhvDMmIAdpIwVS2QimxAxJm9CD8cKANLzZQzVd4zv4WpaJI3ENM4QT1Phv72M2ce5uAj+KUkrz+n7agO/nQlBRSm0Uth0q0qrJfukUKrcMso62upaJzHNCSZl+q2Q7Kk9rNCS+oBi470gBrGvjGUuh8aEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=hOiDqnde; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761157634;
	bh=NgDePtBbene/8a4nTruU8kuIN+TmkEF5/1EK9+oGnz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOiDqndeK1Ti+NJ48nv/TyxZf3fmxptP1cSP4/EtPl5GeZYfAq9QworgSEtqTrvgv
	 m3mfHLm2GsMHa/2aM34g/g83ArWWkfdys+vtY17bviZE9Tq9wphuZk1yD1tcJEFlSW
	 srEEcXWqZ2dVXYy/X1WNeX2jXIr/UjQngidKx9iUFDPHxPcO7pDxWinUZC3LGSr3JV
	 VHYWCzarVM1vLvzZjga/TPlX6QWHFgjpw1d+CNBzCNIeFkLLmN2dcEfCO50ntA0JgS
	 T59ZrpVQHAuxRv8dOPU5MG14mJVao+gt4OhMlyX9N+cB6G/I2avDQUsu0OcrZHPH79
	 lrQDpXISYwKow==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7A56E600C1;
	Wed, 22 Oct 2025 18:27:14 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id BCBC12026D9; Wed, 22 Oct 2025 18:27:09 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 6/7] netlink: specs: rt-link: set ignore-index on indexed-arrays
Date: Wed, 22 Oct 2025 18:26:59 +0000
Message-ID: <20251022182701.250897-7-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022182701.250897-1-ast@fiberby.net>
References: <20251022182701.250897-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Most of the indexes in rt-link indexed-arrays have no special meaning,
they are just written with an iterator index, which refers to the
order in which they have been packed into the netlink message.

Thus this patch sets ignore-index on these two attributes.

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━┳━━━━━━━━┳━━━━━━━━┓
┃                                     ┃ out/ ┃ input/ ┃ ignore ┃
┃ Attribute                           ┃ dump ┃ parsed ┃ -index ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━╇━━━━━━━━╇━━━━━━━━┩
│ IFLA_BOND_ARP_IP_TARGET             │ 0++  │ yes(1) │ yes    │
│ IFLA_BOND_NS_IP6_TARGET             │ 0++  │ yes(1) │ yes    │
│ IFLA_OFFLOAD_XSTATS_HW_S_INFO       │ (2)  │ -      │ no     │
└─────────────────────────────────────┴──────┴────────┴────────┘

Where:
  0++) incrementing index starting from 0
  1)   When parsed the index is unused.
  2)   IFLA_OFFLOAD_XSTATS_L3_STATS is used as index in
       rtnl_offload_xstats_fill_hw_s_info().

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/rt-link.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 2a23e9699c0b6..d2aaacd29f9f9 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1256,6 +1256,7 @@ attribute-sets:
         name: arp-ip-target
         type: indexed-array
         sub-type: u32
+        ignore-index: true
         byte-order: big-endian
         display-hint: ipv4
       -
@@ -1330,6 +1331,7 @@ attribute-sets:
         name: ns-ip6-target
         type: indexed-array
         sub-type: binary
+        ignore-index: true
         display-hint: ipv6
         checks:
           exact-len: 16
-- 
2.51.0


