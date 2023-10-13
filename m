Return-Path: <netdev+bounces-40848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9087C8D5A
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 20:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B880A282E61
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B91D550;
	Fri, 13 Oct 2023 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCiRzGp7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9A219E5
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 18:55:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1A7BF
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697223311; x=1728759311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0RSE2m1qJJewzBhh8baHcItprfs+P0XVLoo8vZmUPLQ=;
  b=fCiRzGp7Pi4I0ErKlt6e1/XEv7ZeSvitOBGuvBywOS9E1CZ8IhEVIoIR
   saMc+V5aLoNsUwINZzsksBrs/NfHA4E1VdwAy5tyoG9E8dGbQdpdAAhtF
   zHUfxiux2kRUgcf40tGPJZGOLIRTWbpuNQdUYgMY2cS8FVg3o65Y5GbNt
   X7En+F6R2x9a9hk8/cRVXH4CnNcPWJLsF9H1gNuGjMt89jxv6QCDztdh8
   U1o6O6wJuAMFktzYIg+54HlQgCCOjf4rH51JgfcFz4pgXveWJYC/E2Tow
   mGC83fAXbC+HLKrA4i16KOKtJTyNEGyyAuBiPUeHRGNogFeOZBRnIIFY1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="451724791"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="451724791"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 11:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="898664852"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="898664852"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 11:53:19 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] net: stub tcp_gro_complete if CONFIG_INET=n
Date: Fri, 13 Oct 2023 11:54:50 -0700
Message-ID: <20231013185502.1473541-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A few networking drivers including bnx2x, bnxt, qede, and idpf call
tcp_gro_complete as part of offloading TCP GRO. The function is only
defined if CONFIG_INET is true, since its TCP specific and is meaningless
if the kernel lacks IP networking support.

The combination of trying to use the complex network drivers with
CONFIG_NET but not CONFIG_INET is rather unlikely in practice: most use
cases are going to need IP networking.

The tcp_gro_complete function just sets some data in the socket buffer for
use in processing the TCP packet in the event that the GRO was offloaded to
the device. If the kernel lacks TCP support, such setup will simply go
unused.

The bnx2x, bnxt, and qede drivers wrap their TCP offload support in
CONFIG_INET checks and skip handling on such kernels.

The idpf driver did not check CONFIG_INET and thus fails to link if the
kernel is configured  with CONFIG_NET=y, CONFIG_IDPF=(m|y), and
CONFIG_INET=n.

While checking CONFIG_INET does allow the driver to bypass significantly
more instructions in the event that we know TCP networking isn't supported,
the configuration is unlikely to be used widely.

Rather than require driver authors to care about this, stub the
tcp_gro_complete function when CONFIG_INET=n. This allows drivers to be
left as-is. It does mean the idpf driver will perform slightly more work
than strictly necessary when CONFIG_INET=n, since it will still execute
some of the skb setup in idpf_rx_rsc. However, that work would be performed
in the case where CONFIG_INET=y anyways.

I did not change the existing drivers, since they appear to wrap a
significant portion of code when CONFIG_INET=n. There is little benefit in
trashing these drivers just to unwrap and remove the CONFIG_INET check.

Using a stub for tcp_gro_complete is still beneficial, as it means future
drivers no longer need to worry about this case of CONFIG_NET=y and
CONFIG_INET=n, which should reduce noise from buildbots that check such a
configuration.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
I've only compile tested this.

 include/net/tcp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7fdedf5c71f0..32146088a095 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2081,7 +2081,11 @@ INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int thoff))
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb));
 INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *skb, int thoff));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb));
+#ifdef CONFIG_INET
 void tcp_gro_complete(struct sk_buff *skb);
+#else
+static inline void tcp_gro_complete(struct sk_buff *skb) { }
+#endif
 
 void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr);
 
-- 
2.41.0


