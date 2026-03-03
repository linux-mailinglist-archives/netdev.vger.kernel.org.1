Return-Path: <netdev+bounces-263410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLodEVBEp2kNgAAAu9opvQ
	(envelope-from <netdev+bounces-263410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:28:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A211F6C71
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F22BD3080136
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADD43A6EF2;
	Tue,  3 Mar 2026 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqHiOHPW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65838910E
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569528; cv=none; b=XnxITjRH3eMI8+dJ6ME5cH8CKnMBRU310j9ZATQ45UP1rQofOE68+0h6DpAme2qxvnLC1gr68UEAQ1lCzo89iW/x7X5NkV+tF2Sj1xgi0+CrWMU/TFKr5rqASS0qLM8RIie3+3+XdL9QcsBThP/hh8sCjOCR3kFrJyPDCuHjSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569528; c=relaxed/simple;
	bh=6d82rOTrjWGuDjTn5dtkw+p6k6cz3svMSlLg+cUPIj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m2xLpWFFKtl4w79t6s+vXb/3aAjubPtxlpHWTjqXRiqbLIVHH/DJnFHrbDwrrLUq3z3XazB+gtxgJUC3IAcOogw5j9RqXzeam6J1yCN6xowSbyeNjA2BZj/0DTjq9gRfydunlhjHSkaI4d0vyZRP3+Fht0B4FaFPHYaUyYdZmHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqHiOHPW; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5ffa4fa555bso80523137.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 12:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772569524; x=1773174324; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lnuSiM2rJtCjYn1EEcdYy6mdqZDfL0mUwzogqrGGRyA=;
        b=jqHiOHPW/ZhDT6GKsfThfDJkNMrnwK6+p+uvcO38LiRJp2iBLqx2bLpF0N+UwwFnGh
         8RqYVKZiGOurOSV/iB/ZX2BME+Kupg+FzuLs6wFCqc+3f8le3u3PcCPOkgI3ZmHcwV3V
         MSdndmMv14Ex+4kyWZ5aGcNg5dGNgGu8QcNWGetmWrmSNNzcYUoCDtTnI5rgT3g4kbB2
         8G7JosjhJcTBRfH0OTL7qZN1Gj22QcqCWZFRxF0c+xbmwodQd4J6tcT1Wl4UFVv5y36N
         YMOwZ7YtIjcN/MqxzzeCszUWgrFul5VIxiQRLJmMOr6VG7+qh8hg9cJ5e54KPXQPY9Zz
         iW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772569524; x=1773174324;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnuSiM2rJtCjYn1EEcdYy6mdqZDfL0mUwzogqrGGRyA=;
        b=j3FoKp8ADqO7dzfhCSvWpk/OfrqLBrR5qWtobieTTBjQtK49pMLkv4j9k7q4IALaMy
         3/XrbU8mwZZrLNPL3vVfWQl3Pqr3nF32MU3uD9F51EDvJByFXULG3hUwWDNVgyRi0A7f
         TbXDOpGXWF2Rln/XX4IVNOj4sN68ekJFFIZI7bl9ffKxQavy6ySeq9VdXRpoHaNG5FXS
         pLxDbRHRmMpdGXM3DZgd1xfatg72c6dQ94Je4/eu7JMq30pgheDHjk510yvDquuA9vHf
         US4ooDjkk8LSKMuXEPaVwDoy4zI23gQuaNItE0mKKvliFpS0gQFShLpovCV7C2e9Rko+
         04zA==
X-Gm-Message-State: AOJu0YyWNKIV3ZGO1ULPDfrKPLbWMpFYs8kIA3O0ZWXJDovEqmLUBRRx
	oTYHjktxy3Y25HUf3QQOmoQQJJ5T7p71gd6N/32VHxRcavDG2oqw0aIk
X-Gm-Gg: ATEYQzxmR2yLAfwla7ctU2T1xIbKQpWVV1X3aNXSgtNdXzBb4DJxPkbGM722sI0eq3l
	5BEMrI/4+XtBRBsy3qB9qXiz4DGsc/HlOhDyRobSfPPrLSrcWq/z32unot0MwLb3IBXTSFPLxnA
	Ckn9Bljmpp3s9vcysPrs38ZdBp7Z+lthYOrJROS0D4zI02MUj/WoomseW88TJMNFs/cPyfurfWw
	e9uyMChqIEQkzMZg7CWt6fx9fmBYH3GiF374uDhJSlP37GDT4+Xu2HLONXfDEA9bvFI2MXLHC+h
	z3fr6oScsRqLKH7Bd5bXyfVqYG2mQIKfL1BMMr0b3W1zpZ13lUVW+H0fmphIgjUbdoTRYsWsmbP
	XcYW9rh1Dusr9oMQQubC7Tu3pPplEq6ZlWbykmFcPPBdDwZRHA6AOhtUMMezBcKN01cjaPIk3d6
	0q5qM823Mi73d6hu6ovvEi+7rsHfD9RSiFeA2kxQ==
X-Received: by 2002:a05:6102:4422:b0:5ef:248b:d533 with SMTP id ada2fe7eead31-5ff32510a72mr8506479137.31.1772569524511;
        Tue, 03 Mar 2026 12:25:24 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.98])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df65b281asm15949188241.13.2026.03.03.12.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:25:23 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 03 Mar 2026 17:25:12 -0300
Subject: [PATCH net-next] net: dsa: realtek: rtl8365mb: remove
 ifOutDiscards from rx_packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-realtek_namiltd_fix2-v1-1-bfa433d3401e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKdDp2kC/x2MUQqDMBAFryL73UC6RoVepRQJ8UUX7bYkQQTx7
 g39nIGZkzKSINOjOSlhlywfrXC/NRQWrzOMTJWJLfe2ta1J8FvBOqp/y1amMcrBJg4cXBddcOy
 opt+E6v/bJymKURyFXtf1A+YPfwdwAAAA
X-Change-ID: 20260303-realtek_namiltd_fix2-f72c45f4c424
To: Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Michael Rasmussen <mir@bang-olufsen.dk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: A4A211F6C71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263410-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Mieczyslaw Nalewaj <namiltd@yahoo.com>

rx_packets should report the number of frames successfully received:
unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
counter) is incorrect and can undercount RX packets. RX drops are
already reported via rx_dropped (e.g. etherStatsDropEvents), so
there is no need to adjust rx_packets.

This patch removes the subtraction of ifOutDiscards from rx_packets
in rtl8365mb_stats_update().

Link: https://lore.kernel.org/netdev/878777925.105015.1763423928520@mail.yahoo.com/
Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
I'm taking over the original patch submitted by Mieczyslaw Nalewaj
(with his authorization). The original message is referenced in the
Link tag.
---
 drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index c575e164368c..5c094fcafc21 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1480,8 +1480,7 @@ static void rtl8365mb_stats_update(struct realtek_priv *priv, int port)
 
 	stats->rx_packets = cnt[RTL8365MB_MIB_ifInUcastPkts] +
 			    cnt[RTL8365MB_MIB_ifInMulticastPkts] +
-			    cnt[RTL8365MB_MIB_ifInBroadcastPkts] -
-			    cnt[RTL8365MB_MIB_ifOutDiscards];
+			    cnt[RTL8365MB_MIB_ifInBroadcastPkts];
 
 	stats->tx_packets = cnt[RTL8365MB_MIB_ifOutUcastPkts] +
 			    cnt[RTL8365MB_MIB_ifOutMulticastPkts] +

---
base-commit: ed0abfe93fd135dac223e87a3c945017b1fa8bfc
change-id: 20260303-realtek_namiltd_fix2-f72c45f4c424

Best regards,
-- 
Luiz Angelo Daros de Luca <luizluca@gmail.com>


