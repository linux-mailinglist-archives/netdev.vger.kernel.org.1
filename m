Return-Path: <netdev+bounces-183261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B42CBA8B7F1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D66190526F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B663323D2B1;
	Wed, 16 Apr 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="TpKukT0E"
X-Original-To: netdev@vger.kernel.org
Received: from mr85p00im-hyfv06021401.me.com (mr85p00im-hyfv06021401.me.com [17.58.23.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533D238D5B
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804599; cv=none; b=YiPX51s12XpkZ19lPxhBKiLNZNB+MSg7pngyTfpXkLd5H23L7AeDHnFL7Zf2UkJBq3wlxGfFfqbNlVrmE+tKoKvkU/OEOOPAXVMyXlT33vCms6cGXNpqxm/P08asjJSX/g7sDzdz52txMdjug0Ah8I7yMU/ojmGRh6iQ03718Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804599; c=relaxed/simple;
	bh=Asr79hdBye6/Op9VxsHlmcZ3XemC/tJ6P+2y6kQWoGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MaK1N6lpIG98sZoFRu08PpWdsPgcaSc37FdH7rTBwAj46rFHptkEIaEAvnY/vViz/v36e9UJ8nq5u4S/YO8Ke5cbdKtbusEZOdY6IZxfBmdIuWiUNQYCQOWJxhusari96qbnJeRe4rhp2l3vh71BgEN2EmKVEZHFPPnhOWQ56B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=TpKukT0E; arc=none smtp.client-ip=17.58.23.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=eTmy3xbSTVwp/Klv3cmmlto0T8mRPmeNQAXdIWymQp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=TpKukT0E/8X23sGaBuvkxn032l1VtAxslAw4Yc9EXO6PjDXCs2gA1WkcdyYwbXvSd
	 oVhdTh2yaQ/Fn37iRSvqfZGLsVh0Yg7eOWJeWsEkhVQHvyUiBV+CqqXx7gNgRh2Bz5
	 4VxmDxn9Y3Y59zCEsBoDjOUwZV0f1n5IdQo4qUhQgnhvsi1UcknzbL0pzXc3Mi+ZpZ
	 yxgjpE2BMLuYzrkmw5AdP7MI2Qb+GhTe7G66ncDX0MBpmEmmS120vf3Cpza7fm80eQ
	 yF/AwyUH3vLMh/Q8fStGR0l1VFj8v4NoJbjGDtBBUPgdcv0Lub8asMdvPftVMdciUT
	 fzs09XnggCRbQ==
Received: from mr85p00im-hyfv06021401.me.com (mr85p00im-hyfv06021401.me.com [17.58.23.190])
	by mr85p00im-hyfv06021401.me.com (Postfix) with ESMTPS id 0E396303839E;
	Wed, 16 Apr 2025 11:56:35 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06021401.me.com (Postfix) with ESMTPSA id 3ED2E3038222;
	Wed, 16 Apr 2025 11:56:33 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 16 Apr 2025 19:56:23 +0800
Subject: [PATCH net-next] net: Delete the outer () duplicated of macro
 SOCK_SKB_CB_OFFSET definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-fix_net-v1-1-d544c9f3f169@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOaa/2cC/x2MQQqAIBAAvxJ7TlBLxL4SEZJb7cVCJQTx71nHY
 YYpEDEQRpi6AgEfinT5BqLvYDutP5CRawySS8VHIdlOefWYmLbWDUpxbYyEVt8Bm/pPM3yBx5x
 gqfUFHSZdD2MAAAA=
X-Change-ID: 20250412-fix_net-7aad35507992
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: cjJbOoO6Ma8pLZKNJ6EhNXDo0KX-361Z
X-Proofpoint-ORIG-GUID: cjJbOoO6Ma8pLZKNJ6EhNXDo0KX-361Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504160098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For macro SOCK_SKB_CB_OFFSET definition, Delete the outer () duplicated.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/net/sock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 694f954258d4372ed33d6eb298c4247519df635c..778e550658a73d9ce3016233bb9062b0f5011e0a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2605,8 +2605,8 @@ struct sock_skb_cb {
  * using skb->cb[] would keep using it directly and utilize its
  * alignment guarantee.
  */
-#define SOCK_SKB_CB_OFFSET ((sizeof_field(struct sk_buff, cb) - \
-			    sizeof(struct sock_skb_cb)))
+#define SOCK_SKB_CB_OFFSET (sizeof_field(struct sk_buff, cb) - \
+			    sizeof(struct sock_skb_cb))
 
 #define SOCK_SKB_CB(__skb) ((struct sock_skb_cb *)((__skb)->cb + \
 			    SOCK_SKB_CB_OFFSET))

---
base-commit: ba5560e53dacefddf8c47802b7a30b2e53afdcb8
change-id: 20250412-fix_net-7aad35507992

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


