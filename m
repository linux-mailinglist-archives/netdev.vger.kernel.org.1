Return-Path: <netdev+bounces-290239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /pvIGTqhDmpCAwYAu9opvQ
	(envelope-from <netdev+bounces-290239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:07:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A9659F4A4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13898304096E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2383672A5;
	Thu, 21 May 2026 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyJpMhWw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4E62BEFF6
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343670; cv=none; b=HP+H+ed1ER5DWFVPflgYsCzJlgos44j1ILb9E0cJ/iYe0X8pPJ6qapXOyYXqhAfoxmHotxVfwwhC1bzwmQsTHQt3Ra/x0o6nVCmPMzE34otPCC3x2/J0z6hevzhzKHnRNG3pA0/Skz67ZXeIiEzJkZTwZXYo7YHEPpeu284b3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343670; c=relaxed/simple;
	bh=YNg1uNMBpTq8tTzFkHLFh9Nff7Tta9n4b4enIBryprM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPpS5erGgQtYCWdRtDXKh5PUga2dWHNoYdIZi4DCWoB3OaQgwbveM7NFcochkJmF2yoYSb/Z5gI45qy6n3sdPspC2fwRgABeLqzmJAq5LlVhz9OXUGLLzoaO9N6k6fpNNYqXvuZruEaIojYialRqT6S3l0zmwb1O9arbHCm58WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyJpMhWw; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651bf695701so5500889d50.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 23:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779343668; x=1779948468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/4tpqxeEoNUq/Dqf4W4r6oPmkkXtFBFoEdxmJFSLDs=;
        b=TyJpMhWwHTpwGA5g/tD8DyVGWBhCd2D16hhTgfllsyTawwpDUEF2z34+sojqU3hnNf
         VuieXl7AbD5cm2ygEfCqtR64B13iZ3BThcO7ezdJUM+K3CF1JcHU2r5NtWbT6t+i8+Nw
         CJmmsGK9Z24NerrU2k1WEkluy1VyDwhkckQUaUq/q80pzKsgQcsWYRGtydIcDqN+0D/x
         R5ahWTMHyr1NlmypkXoJKNz28WQqNWmgUw453becPZgls051pBnlnehoX8rjY6HcHnSO
         57xy+bNUzMxSGEC6r15qLIR0cVhT6Hm3hMiJMizwnh0pe4DELN4YtudZ+SNdwkA/uVV8
         /0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779343668; x=1779948468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/4tpqxeEoNUq/Dqf4W4r6oPmkkXtFBFoEdxmJFSLDs=;
        b=mVsWDvE83YyG9mlml0Zyvoe3SQuz0N5UjwDd0JSQcCRz60pmoBDIQVT5DKThU31TPX
         DiFleoxHV0XfPSu4pN7j7myAzggCPft7JiN9mkDtVsqR0cQmBlyLPCXiKN2srTWLpjyP
         V8gYGqhThG2efo09Z4xRp1988C9b59ZOxQuFtZo6nwopeEP63StHXVwhUo58XtoKYQnd
         JWfYDHeVjWIYAuQE6MyPYQEIR5o8nd1o+rQjkzWELw5+iHIVjFKeREtmdFDw0BichZcj
         wEBsuO0qbfMUN640E979xb8V1ym0XQh40Yl6+wzvispQt7fOaO0afa3WKqn/U81bOcLQ
         l3mA==
X-Gm-Message-State: AOJu0YyRzwWlscc27aVUr6TKOxdhRggldo4ZwYiTWygRFAnDBTsEUUxv
	AdHuzG0/PXUQlEuZ6/hSsO4MDPe0bQrdvt+7ExnczJCt50Zh+aCndSSd3fP/6g==
X-Gm-Gg: Acq92OFvVRj0nndYF+mpfnI2q+4Fv4HcUowL+E9ELGSoX8ylErPbwFw6kksN2yPW8Ff
	wykJ2Bu8UPfulC/PjQ39lspcjV7suaDE5lq1BojQYummVGJHNn2/funN11kVNwQqQNve/m9ARL4
	7urGECfY+0eWBou97/tcxD3DGQ+c9puaM6e/bbOwdqBD8cO0Q03e9QgJa1tFfTSwSMoo1rLOCow
	nyOIgj+xHZgFVYaHdWskGwO46Bn16o0JKfvYT5URPxObLD4cNKtnl40zmrqcBOd4MZPKuhrUiPj
	x09+79A/GlVg1FjA+E1vNXVbGRgPLAGweB27XcDxHESvnx2+NedH2VZTRhDrH+CVuc7kfkXC9lI
	zNVasoxlfs3KPhEiNNenJhlBVJEDY5M8LxQlaLT7vBmExBHGI5FoadgZu0W1WIxqcDNj4sGreQQ
	sM0LKbV9MVWbHvZ1Cr/5xiJNAukAPKIKlyilu86L1WRtloIWyTH4nCY8yKIo2F+HpXX+x0P5kmx
	810nNyNY+sENOA3BQF1IvwH3LtEmIWjCrQ=
X-Received: by 2002:a05:690e:120d:b0:65e:b97:771c with SMTP id 956f58d0204a3-65eae0ca72cmr1176525d50.42.1779343667896;
        Wed, 20 May 2026 23:07:47 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0dbcda4bsm10325235d50.18.2026.05.20.23.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 23:07:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: ucc_geth: Batch RX packets before stack handoff
Date: Wed, 20 May 2026 23:07:29 -0700
Message-ID: <20260521060729.2293222-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290239-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 95A9659F4A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Collect received skbs on a local list during RX polling and pass the
completed batch to netif_receive_skb_list(). This lets the networking
stack process packets from a poll cycle in bulk instead of handing each
skb up individually.

Speedup tested with bidirectional iperf3 on a Watchguard Firebox T15-W.

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

It would be nice to use napi_gro_receive, but the tradeoff is lower
routing performance. There is no support for hardware checksum offload,
which really hurts routing performance.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add extra info in description
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


