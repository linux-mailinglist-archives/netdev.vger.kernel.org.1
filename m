Return-Path: <netdev+bounces-100925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEA58FC8B9
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD604B2127E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A3518FDCB;
	Wed,  5 Jun 2024 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="S7eWnebj"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCA714A4F4;
	Wed,  5 Jun 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582435; cv=none; b=pPfSoLw2PtFkamRxTdfC829Wi4d5aSJMXD0l++IcJdXM1KOULIYN92mg6D3rrGmTyDWZxleiyLSFS66vAYpbumPiBepz5t86kbcFTx6KhdpZ1cdFVmyIQTFt7bEQlUUs58Q9VDeA4irO4lYGR2wGdY8YFuBq17+ao49DKQPFVQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582435; c=relaxed/simple;
	bh=ik7O5D1/zfrU5PaNGdXm7WqPHSu6IAEY0lgHj8rkt14=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M9uOVym77G5N4FX5s7BtMRjF4/cQQOy2KPlSmuAzeNXylBgv3LWNV/kgBIts6DMJf/f4ZkmrlV67LE0xGUWBLNlIGSTQssiSvMzEr41s4o5roRygUiASoLL9TJJbYHNZwHqAVDwEwhaPk1xiaGmHor3iFOjKyeRq+1QmureoHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=S7eWnebj; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 97472100003;
	Wed,  5 Jun 2024 13:13:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1717582404; bh=0/SSnP2FmJDTn4D/XDM1bjJhKm4OlkcBcXnMVeCu4GU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=S7eWnebj243qAdwLvX/2889sWAI05xibP/b6g+UGGNXeb1Vhia9+L058lm2o5z9qJ
	 2WwDEj5su5BMfpHf1/jnm3NYEoNNC/4E50DYgGgBfgFfSuZiD36jCvpumIhUOlBSml
	 PRmufnT2JVUr/yjU7OPibisWWPl047oAhYakJEYhOCrAS71uFYA35o6v4ISb4kq6Lc
	 Uf7IT7y4kZJyF6Tc7MFxkVT+mJzWyTkb0WOUOd3Z8HgM6sSS8j79HF/CoQRVAV6B5A
	 ebPMHHEYnIh+5ro8qF+lfEAF0doNqiTu5u7s73K2HSIbVXbF/ivJUGandRh7f7/acD
	 MMP++fzDP/vJw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed,  5 Jun 2024 13:12:03 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Jun 2024
 13:11:42 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Kees Cook <keescook@chromium.org>, Justin Stitt
	<justinstitt@google.com>, Felix Manlunas <felix.manlunas@cavium.com>,
	Satanand Burla <satananda.burla@cavium.com>, Raghu Vatsavayi
	<raghu.vatsavayi@cavium.com>, Vijaya Mohan Guvva <vijaya.guvva@cavium.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v3] liquidio: Adjust a NULL pointer handling path in lio_vf_rep_copy_packet
Date: Wed, 5 Jun 2024 13:11:35 +0300
Message-ID: <20240605101135.11199-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
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
X-KSMG-AntiSpam-Lua-Profiles: 185735 [Jun 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/05 09:22:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/05 07:06:00 #25449783
X-KSMG-AntiVirus-Status: Clean, skipped

In lio_vf_rep_copy_packet() pg_info->page is compared to a NULL value,
but then it is unconditionally passed to skb_add_rx_frag() which looks
strange and could lead to null pointer dereference.

lio_vf_rep_copy_packet() call trace looks like:
	octeon_droq_process_packets
	 octeon_droq_fast_process_packets
	  octeon_droq_dispatch_pkt
	   octeon_create_recv_info
	    ...search in the dispatch_list...
	     ->disp_fn(rdisp->rinfo, ...)
	      lio_vf_rep_pkt_recv(struct octeon_recv_info *recv_info, ...)
In this path there is no code which sets pg_info->page to NULL.
So this check looks unneeded and doesn't solve potential problem.
But I guess the author had reason to add a check and I have no such card
and can't do real test.
In addition, the code in the function liquidio_push_packet() in
liquidio/lio_core.c does exactly the same.

Based on this, I consider the most acceptable compromise solution to
adjust this issue by moving skb_add_rx_frag() into conditional scope.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1f233f327913 ("liquidio: switchdev support for LiquidIO NIC")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1->v2: Fix incorrect 'Fixes' tag format
v2->v3: Add explanation why this should be fixed,
 add Reviewed-by: Simon Horman <horms@kernel.org>
 (https://lore.kernel.org/all/20240308201911.GB603911@kernel.org/)

 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index aa6c0dfb6f1c..e26b4ed33dc8 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -272,13 +272,12 @@ lio_vf_rep_copy_packet(struct octeon_device *oct,
 				pg_info->page_offset;
 			memcpy(skb->data, va, MIN_SKB_SIZE);
 			skb_put(skb, MIN_SKB_SIZE);
+			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+					pg_info->page,
+					pg_info->page_offset + MIN_SKB_SIZE,
+					len - MIN_SKB_SIZE,
+					LIO_RXBUFFER_SZ);
 		}
-
-		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-				pg_info->page,
-				pg_info->page_offset + MIN_SKB_SIZE,
-				len - MIN_SKB_SIZE,
-				LIO_RXBUFFER_SZ);
 	} else {
 		struct octeon_skb_page_info *pg_info =
 			((struct octeon_skb_page_info *)(skb->cb));
-- 
2.30.2


