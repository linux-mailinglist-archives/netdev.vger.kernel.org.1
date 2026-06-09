Return-Path: <netdev+bounces-296902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EnKxNnudJ2qxzgIAu9opvQ
	(envelope-from <netdev+bounces-296902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 06:58:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4A265C535
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 06:58:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T1cJ+ySA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296902-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296902-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69CF7304094A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 04:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA81DF25C;
	Tue,  9 Jun 2026 04:52:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076FB3B7779
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 04:52:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980730; cv=none; b=B0TAb+aGbeAo3rCnI6+WX5UbjeGWghqzCnox+kF+BDzB9XQxUdGJ0dkGyCuMz1MNutTYlMdWoqTm9nkXFdbPNTfx5HKziVyt4Iu2gxW9wy4erqdies7wVaNHPMBwc1aLECwtxkN32Z3LGs4YxNt+hmUPnsTCKuMzMLuuse9qk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980730; c=relaxed/simple;
	bh=Az/PU+nwyqLrmh7/9EyKVz81qoow2D4u8LWahqjeiU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqYKvCYXU6fKbFd4Lt8NT2PPQpr1jyS6bT6YtC8MJZ1fMfDA7U+6Q4NBtjQovvery/b7TlP9z3vDDqoKg366Z1WZg2L5Tvte9oGwBk8ugxX6NSnJ3J9Ua4Eet0DY0oT1iW5Cg0FS9V4H6Uq0rKhosWFrjPJLcgdUuUxgB9uC1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1cJ+ySA; arc=none smtp.client-ip=74.125.82.67
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-13809ed8fbeso1682352c88.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 21:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780980728; x=1781585528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/QOP26tti6ZWeoGWucRBqdehVqpkrxqrlNy5NBddKw=;
        b=T1cJ+ySAUy7A3qDIruWqrSioA/jcjV/5ZeyvOkbPnghi4iZmSOg+IvhxMcvK032nMC
         Tk/i0VBeeykVRLNc05iTzgPgO/hMHLD9LODOrtZpCkzRJ8wuS97TWevf0tVc+6+1YyVb
         UJFzhy5Ffarq6KpHX9CMoZa1zwTD5doBY0GgPO8G2Gi8PpJSG18dHmiFxUN8zeCfgPYl
         4pEtA9HjbTx3JbSVs6IP/NzFHpX1ZN5tN16TlcL9Irp2zhbYKYL+dWArfE3ae92WqF/H
         JUmzlH8hb2MnZrOShaAquG319ktoo+Tj37wdzyCzq3Y+G3EuINbfdFum/Suy7loLGhq3
         UU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780980728; x=1781585528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/QOP26tti6ZWeoGWucRBqdehVqpkrxqrlNy5NBddKw=;
        b=W48ayQ2HYhxwWHe9lbol2tytj1nAhWssOX1oi25MRXWUEhOUmKR3nI192Dug6YIXqR
         DiQ+5b8m9hDeaATDyibV84/bfs0Nez0V9onaWN+v1sVZMIZYnSobOnxyVTIH4avPfYaq
         RchLKwP9jQdO4ez5Pubnm3Pgmj1a2dMIMvwz8/f/G/9iQLhlp360xMKdAJMCg7qk4zzC
         iXBu7hHPp2blF4EVXvRRtbDazqbwiRRvyvSAsLHM/5bXNwYRriAGsfgOiHhAUaKdAVAp
         r41WT3xkN+yywk/PTf0wuQn2bjiueNJydh1OPgG3O3LyJ+FsWeU7XRr4/b7to34Vnd5J
         x7TQ==
X-Gm-Message-State: AOJu0YzoFuHjzNSMTsydh9YT3hkjsHpPC4O+vCbELubJXPrD2PEawQRA
	UNjhbvrN0O5wMgvLDpGCQPL/NwAAFORfEC2ejJbBsKWzEI9QCnOLIt0nby29F4Z5
X-Gm-Gg: Acq92OFR6UmR71fmQ1fCANXhMFpKFNc1whpuKXnRBki9OxkR44/PAH854D8dXLx/Sjc
	JwubCi9Vy+uheXgDLa/Emg2g0KQLiWcRvs3mVdFWDyuwJnsQc+6bYfNQdx10Mf6VnTv/GSqYjkU
	npuLE50wG1vZA/PcVP40e7HnPtqEgNGdZPF1zOovlbw3hdQ3mtumt+mzRibVbZ6Yapc3uVTRfkI
	cSBvzfhx5hoO0gBGJ7muk6lN0JYXrIIvosb7Rs/hnWRnuVAVlFmXrY+4edfHjkWjYZPgLX8mW3Y
	0m+hi2Ls1kx33e0udLS7DSVCpN4GxZ3FILzgXiA4yRliBA7eg0wC4eVhmKNHskbYG9pJZ2PrQ5G
	IQLw8dQt39PwbehzvdU6YI2gukm65WALAAqmj9XWz43cQedaCJnCCW58akMJLruDsvg3Ikt/U/5
	446C9ymFeLJaBD5vSnBqZV8mwvNY1wiH6o9VlEU3ALGzbqaJv6cl3VCfKuBse93FCLYPfoA/qbn
	g0sprccpytRoYgzYveS0451t/Fh8tXTlxkGcrwreZeu6QC9smitmPL594gC+OE5iYQYay4i8dS7
	je83BvARCwhdyLS8c+23Bjx2f4Eg
X-Received: by 2002:a05:7022:6081:b0:137:f764:85f5 with SMTP id a92af1059eb24-1380672a5e2mr10769686c88.32.1780980727950;
        Mon, 08 Jun 2026 21:52:07 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f53f06c4sm13771964c88.0.2026.06.08.21.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 21:52:07 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: fec: remove reference to nonexistent CONFIG_GILBARCONAP option
Date: Mon,  8 Jun 2026 21:52:00 -0700
Message-ID: <20260609045200.32606-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296902-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:enelsonmoore@gmail.com,m:wei.fang@nxp.com,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D4A265C535

The CONFIG_GILBARCONAP option has never been defined by the kernel, but
is referred to by drivers/net/ethernet/freescale/fec_main.c. Remove this
reference to eliminate dead code.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 6ebde65d7f1b..ced4dbf8cd90 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -218,7 +218,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
  */
 #if defined(CONFIG_NETtel)
 #define	FEC_FLASHMAC	0xf0006006
-#elif defined(CONFIG_GILBARCONAP) || defined(CONFIG_SCALES)
+#elif defined(CONFIG_SCALES)
 #define	FEC_FLASHMAC	0xf0006000
 #elif defined(CONFIG_CANCam)
 #define	FEC_FLASHMAC	0xf0020000
-- 
2.43.0


