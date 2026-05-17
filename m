Return-Path: <netdev+bounces-288772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K7IM0sYCmr8wgQAu9opvQ
	(envelope-from <netdev+bounces-288772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 21:34:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6C8563924
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 21:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3DE13037421
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C57F3C3C0C;
	Sun, 17 May 2026 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SStaHulQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283333FE36
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779046157; cv=none; b=TPFrB2Npk9PE49tcQb6GUjMVuUO5+xNFK8OChoi0sBHprwZ/ZvvPgSympeaXOKgcFe7Sxr0Ldi2wGmZx23tNIfo4ZTqzOMQBIobKNsaNzmRRhx//Dm/4MVyRwZe6AJKg3FzxuF1vr/BokpIKP+1iCdW3G8Yaijdb0+xtcoVRZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779046157; c=relaxed/simple;
	bh=XMaBu37baw6KIwcyker2TZ4by6S6i/usQ/CcByiJLjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LjIEwPCcFaHUqacaeghlQaKgKYBFJv6WgshLRSXAyRhHHapScgHEkricgC7PQ77F+39i/r1C/JlxBb7F9C+v4yScGb88FE5C0h2KVXjHRYykYiW8xGiK4rC3ahRJPFnbRt9FhRX8dvCsGb/7lUnoPD+4abl2ArXy0KdQjmJG/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SStaHulQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3697421c2a8so554673a91.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779046155; x=1779650955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBYyQ0ZMS6FoSccvFn3m6zDlGuyQLI5sKd09gEPumuQ=;
        b=SStaHulQg0B/ka6SbV6mhR9S5f/wsRCmY6kdbF7PNUKJAnQY0wW5LBBZKy5EC64gt5
         vo8ZdpItmTKNuLC+US9H1yMgAjO1lpQKDzrnbbP2RyOtEpNaIXfm3VXOjmkO/I223D19
         NFDb31/4QOOgD/atAIXvQSsFpJd+B4/w9wAcMwvlNipb0Tqk5hWEhf4yMyZf9FfnInkQ
         CxDRUKxbVhZ0yV+oBKMDwhk2ExGrw09DSg307FLZg2/DwziOvkpwTmHJMOmBujb3BByl
         8Q+kdKf/W/TJWBuXeyOHIvC7YAOXP8/DGdD282JsfuriCTIUVHiSvV58tXcbPNEPms1m
         Iq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779046155; x=1779650955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBYyQ0ZMS6FoSccvFn3m6zDlGuyQLI5sKd09gEPumuQ=;
        b=sF1lVBqk+Ay4Svmwtmrg/nCXOBEkDfbyv9jDzUFL/AqmIfR8TLXm9y1mE/0k/8G1em
         uNzkqoZC+93B6N4FUFoINjT/3XNHbzvekwD7kRSOrxCsulgEYbtn1A0Z1q0ef9BzcKi4
         Eh9dgTzRs9sj+YE9HxQm/cAECXGqorMMdYWMzDuCbU9nDCbfxR+SQuBmWsa7u28ZoWsg
         jwnCT9vja8DNHwFVea9irantA2DSuKlDqdXr6odZxup+pS4Z4VODZ5inlxcUXAgV0Bwb
         ZpTfB/TaAHuQnK/5Nb/0Q7OiZzHOQVsFpTYCrHe6R94t2Yn9nFXNfh6jKrW7lbkKDcxr
         JD1g==
X-Gm-Message-State: AOJu0YzuBl/v6J2z0UKLQ65JPP3Z6OyNyHhCFu2XI+hTsAPc7eB7KqdO
	FqHQTP42DrJilDng7Y9q33/CaRzAcxL3H8fmsijJnUTXP5OAJsxWAV+yX1FzNg==
X-Gm-Gg: Acq92OGCP8bVL9wQISr/8IYWMOvlIKCHQFZ1zA7YURH3WIAK1DkiB6ASsjR3is6jvnv
	a8lqfAqdvJpoNhKkiXJ2E/HVh1cPgWb7NC8nw70YsbU8/hB2+0L5p0+QN+m6jFmt4nZUWlYyzdu
	EHB7qykL6SknbKYS1UCUmVReXWwATpNPFnwaC6fjf9GkplEFubn8meLXMFSLe6/qxg9D9ePfVtj
	GKxaB8auec63EVxBtLrxfnLd2OtfQiRzaMwezFrg/ksuPwb2Yp1F+kqV+xb+mWcn7QU1E6jD4ny
	wgsoesKx0kDmmJMIf/WlFTntX68NTf8tlZBWl1iJuQE649AnNFU1OM7zLYz48U4nGlPdiOQegoB
	P0lvuUvCEtP1NJrFxEejqOvgDufiunugxuIXHWwLOimm0KpPnLO1hIib1sW/fy4TpwAHWLYqAH0
	ntkRJcoQy1rquwP7NFAJWockJhrfwu9ZxOIJhuahTutgHWGTbqQuT4NExxYUArJSeyUadlk54Op
	Wcr2QolH17P2BSAAxctrZkSZS/R3xqLhOdCN+NTR5W0Cw==
X-Received: by 2002:a17:90b:5648:b0:35e:27ec:de0 with SMTP id 98e67ed59e1d1-36951b971e2mr11019754a91.13.1779046154970;
        Sun, 17 May 2026 12:29:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369572061b8sm3268188a91.3.2026.05.17.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 12:29:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
Date: Sun, 17 May 2026 12:28:56 -0700
Message-ID: <20260517192856.3925-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E6C8563924
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288772-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Collect received skbs on a local list during RX polling and pass the
completed batch to netif_receive_skb_list(). This lets the networking
stack process packets from a poll cycle in bulk instead of handing each
skb up individually.

Speedup tested with bidirectional iperf3.

Before:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   490 MBytes   411 Mbits/sec                  sender
[  5][TX-C]   0.00-10.01  sec   488 MBytes   409 Mbits/sec                  receiver
[  7][RX-C]   0.00-10.00  sec   176 MBytes   147 Mbits/sec  167            sender
[  7][RX-C]   0.00-10.01  sec   175 MBytes   146 Mbits/sec                  receiver

After:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   502 MBytes   421 Mbits/sec                  sender
[  5][TX-C]   0.00-10.01  sec   501 MBytes   420 Mbits/sec                  receiver
[  7][RX-C]   0.00-10.00  sec   212 MBytes   178 Mbits/sec  148            sender
[  7][RX-C]   0.00-10.01  sec   211 MBytes   177 Mbits/sec                  receiver

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 7af4b5e3f38e..bce1079fc06a 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -2894,6 +2894,7 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 	u32 bd_status;
 	u8 *bdBuffer;
 	struct net_device *dev;
+	LIST_HEAD(rx_list);
 
 	ugeth_vdbg("%s: IN", __func__);
 
@@ -2934,7 +2935,7 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 
 			dev->stats.rx_bytes += length;
 			/* Send the packet up the stack */
-			netif_receive_skb(skb);
+			list_add_tail(&skb->list, &rx_list);
 		}
 
 		skb = get_new_skb(ugeth, bd);
@@ -2960,6 +2961,8 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 		bd_status = in_be32((u32 __iomem *)bd);
 	}
 
+	netif_receive_skb_list(&rx_list);
+
 	ugeth->rxBd[rxQ] = bd;
 	return howmany;
 }
-- 
2.54.0


