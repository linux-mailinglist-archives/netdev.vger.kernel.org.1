Return-Path: <netdev+bounces-136515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742789A1F7D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED792891AE
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1651DA0FE;
	Thu, 17 Oct 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="TY/gR5yr"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6921DA109;
	Thu, 17 Oct 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159792; cv=none; b=nXojA7L3TXvhIsQnAZhGD8hHdqa7pmKvmN1iINvvP534hzQCMue4+O7LrBkvv47usqoOsyvKtyDQg90anxydA1oyc2saOByJ5GIuUuL9JnCByXNsxcMUxCPJT8pZTPej+wS6gBxbf/M6p+lM2h5mbpLXvqRGrgHFpOgEKgMYLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159792; c=relaxed/simple;
	bh=+bhHXwcb55SnWiF8KaDD5/LiMHXYDze02UDytzKIZZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfiHB7HBD2CVpR5cMDoUNHrpZZTKhb8IYHyAp1U0Nf1FgtnfMTFAWOYc7cduQl8G+lVqur3TH3H1I5LcDjwj0ECPAkIp5CQ2+/hE8ilUcuzEhNFMZemdUMMfLu8V+YekzSnT4WId5eLohkI/jaZ/56zpzXxYxAZWXskVqVFq4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=TY/gR5yr; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 67F1D100009;
	Thu, 17 Oct 2024 13:09:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1729159772; bh=YIV/RAinDIcXSNrlNeJ40M/saxtLocKX7l7RCOBaBMs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=TY/gR5yr9kFqEDR7u185e1fpuS6dOrN0VWtxKK+OLNJrTEeURJzFUZZxk12Hwe6X7
	 Sxm8HYaA9GpE8zJ3zNDf9eGLfBLJ/rmGp6vmNtIXmMH10aAYb6CQFpc52hGhU2ip5t
	 F4DucqmOPukENxNiutu3joLqvXxZG5KCURrC8SwEKzskZTDM5EmbAeyFS4WznvmGbw
	 JIxxp4nusDpepsEcfRMyB9RNO5nU7x+Hw4CkDN4LuufToss2+PNeBSSrDRlugSciRS
	 HC8DiLXSIMHDZwDAB6QCdgLa16f35SDtYoh08ZLLHtmFkBoR2YxzdzWW5sNwiWDtxh
	 i1r9S27UT/+FQ==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 17 Oct 2024 13:08:30 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Oct
 2024 13:07:05 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Veerasenareddy Burru <vburru@marvell.com>, Abhijit Ayarekar
	<aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>, Sathesh Edara
	<sedara@marvell.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net v5 2/2] octeon_ep: Add SKB allocation failures handling in __octep_oq_process_rx()
Date: Thu, 17 Oct 2024 13:06:51 +0300
Message-ID: <20241017100651.15863-3-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241017100651.15863-1-amishin@t-argos.ru>
References: <20241017100651.15863-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188506 [Oct 17 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/17 09:58:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/10/17 05:21:00 #26765332
X-KSMG-AntiVirus-Status: Clean, skipped

build_skb() returns NULL in case of a memory allocation failure so handle
it inside __octep_oq_process_rx() to avoid NULL pointer dereference.

__octep_oq_process_rx() is called during NAPI polling by the driver. If
skb allocation fails, keep on pulling packets out of the Rx DMA queue: we
shouldn't break the polling immediately and thus falsely indicate to the
octep_napi_poll() that the Rx pressure is going down. As there is no
associated skb in this case, don't process the packets and don't push them
up the network stack - they are skipped.

Helper function is implemented to unmmap/flush all the fragment buffers
used by the dropped packet. 'alloc_failures' counter is incremented to
mark the skb allocation error in driver statistics.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
Compile tested only.

v5:
  - Update helper as suggested by Paolo
    (https://lore.kernel.org/all/cf656975-69b4-427e-8769-d16575774bba@redhat.com/)
v4: https://lore.kernel.org/all/20241012094950.9438-1-amishin@t-argos.ru/
  - Split patch up as suggested by Jakub
    (https://lore.kernel.org/all/20241004073311.223efca4@kernel.org/)
v3: https://lore.kernel.org/all/20240930053328.9618-1-amishin@t-argos.ru/
  - Optimize helper as suggested by Paolo
    (https://lore.kernel.org/all/b9ae8575-f903-425f-aa42-0c2a7605aa94@redhat.com/)
  - v3 has been reviewed-by Simon Horman
    (https://lore.kernel.org/all/20240930162622.GF1310185@kernel.org/)
v2: https://lore.kernel.org/all/20240916060212.12393-1-amishin@t-argos.ru/
  - Implement helper instead of adding multiple checks for '!skb' and
    remove 'rx_bytes' increasing in case of packet dropping as suggested
    by Paolo
    (https://lore.kernel.org/all/ba514498-3706-413b-a09f-f577861eef28@redhat.com/)
v1: https://lore.kernel.org/all/20240906063907.9591-1-amishin@t-argos.ru/

 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index a889c1510518..8af75cb37c3e 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -360,6 +360,27 @@ static void octep_oq_next_pkt(struct octep_oq *oq,
 		*read_idx = 0;
 }
 
+/**
+ * octep_oq_drop_rx() - Free the resources associated with a packet.
+ *
+ * @oq: Octeon Rx queue data structure.
+ * @buff_info: Current packet buffer info.
+ * @read_idx: Current packet index in the ring.
+ * @desc_used: Current packet descriptor number.
+ *
+ */
+static void octep_oq_drop_rx(struct octep_oq *oq,
+			     struct octep_rx_buffer *buff_info,
+			     u32 *read_idx, u32 *desc_used)
+{
+	int data_len = buff_info->len - oq->max_single_buffer_size;
+
+	while (data_len > 0) {
+		octep_oq_next_pkt(oq, buff_info, read_idx, desc_used);
+		data_len -= oq->buffer_size;
+	};
+}
+
 /**
  * __octep_oq_process_rx() - Process hardware Rx queue and push to stack.
  *
@@ -419,6 +440,12 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
 
 		skb = build_skb((void *)resp_hw, PAGE_SIZE);
+		if (!skb) {
+			octep_oq_drop_rx(oq, buff_info,
+					 &read_idx, &desc_used);
+			oq->stats.alloc_failures++;
+			continue;
+		}
 		skb_reserve(skb, data_offset);
 
 		rx_bytes += buff_info->len;
-- 
2.30.2


