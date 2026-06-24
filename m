Return-Path: <netdev+bounces-301801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p4f9LxRePGpcnQgAu9opvQ
	(envelope-from <netdev+bounces-301801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:45:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213E26C1CE2
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:45:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b="a2xcvEO/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301801-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301801-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EC04304D47C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2C23B4EB6;
	Wed, 24 Jun 2026 22:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136026ED25
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:45:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782341123; cv=none; b=JziKK+aQeFM0MX0iBKE3SpjEoFgntnEIYNN9rMEqabWeJnoVMhPPvKSlOSLO89o1yETufQ0uyQnMv0Ry4G8zHQtIj0SpTDho8ktVxcLFbjteYLFCpgy+vUFOsVUZr3vz0EzEU4TnoVdz/Z8I3o8GKXGKrHuSc+NB1EhPgS5dexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782341123; c=relaxed/simple;
	bh=F9Kyj9psFA3CcUgAE4ZqMqWA0H5hu/8LTdI7oKfL23g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtlKcB9NgB4+EKMXuAqvgv4QG8EODGRPyoG0G3mrB/FRx0SLl+J5JLI9AZ9Diuwz8a8Q+9vwU/qu5GVIwGzjL5DdDprqfckPsTbEsAWKi5dXMftPhudDF+3PMGzvtZzd1VziXItSOHgEXa3WbBpkjTmkI9CxJJm2sZJl0yvPlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=a2xcvEO/; arc=none smtp.client-ip=209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c07680fdd12so206993266b.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782341119; x=1782945919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIv0SNIrWvan8AixNggFQO+S0jupCa7X1WRFdoPzAug=;
        b=a2xcvEO/u4eMoyWkO3g0O7rq+d9euVX2ADJCaP/pZ4WgBapkIx/rDC6K/KXetrPMhP
         jU3xc8B4zLOTTpXJi4CZyHi40VaU47033EoIZKc+coaYkpp6ovw7K77PHqfODQOwgXsf
         0ca4VgEO+MGh6dQ+wIO/03bN7MYaUDKRptbgQFmm9b4exAznwjVqhex3t9No0VnW0QMZ
         CUqDsjx2GgMyQAbAV3iTfpfqa8RqOBHo+ZcZEp5kjrJylOSoIW16Z7gy9Why6/Z/Lswm
         uIb1ngm+sNdr+2puiZwtz1y8KgnSsD4JCXFkm1w5XxbYllaM6JeZDr3zeuxhssPtnYwb
         WWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782341119; x=1782945919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIv0SNIrWvan8AixNggFQO+S0jupCa7X1WRFdoPzAug=;
        b=Jcshv/a+ACqlGqccPUytS6Ri1tgr4WUls6K2N+ROcD2VKlvuiSEFoTAUWu3Y5Tmsxw
         D9QamTivDKTacKDXCwEsMvaaTgw1Y8PT/G1H1piU168jfqgoO+fuRBi7NrdpLXVCFi1r
         RW6nyCiYaXjcnOAIjfJMGMMm7tkGSOW7EXS1wtNrd9RPJocNRx4NyrzS3gt8zrGgbQPr
         7edVo7l+xsA8ZlQuDfpYJRU050gdqbOBmbL7yQYJq9HDp9Q3cnhmvoVAikkjFz0UkflM
         QO7Tots0hCthe2h2FTOaIcW6thMEsKueeD26aMcCWkcBKcTAgLPKEL4B3u0TEIvyzlVt
         6dTA==
X-Forwarded-Encrypted: i=1; AFNElJ8lquqZ8JwNnrioUxR90rskYG8vff62Ker+9yqnBjQIagXxGuzFFjaN9kbK8+TIVbG1Y1MwQ1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEUPg/HjhfhR+04CDkzuQGY7dq0AF0rzaVr8JCg/+R+GRQnYY
	v2Dh/J65myHFAAYDiVEAad1ACZ+tcb2w1/E3fm4xycrjuNIKPVHt/xHWmck6zmilVx9W
X-Gm-Gg: AfdE7clLCP4MS8CnZY/Z8FZ4gjbQnLFHrF0RodzZQDuEpSDW9n4EeoQcmWnNk2scoBa
	9NdcPirMQYMHD2X41okMV+sT8enO/onbcX/bwiY3zKW3y/W0MugLJLTBggP3U1AHiORvfrgzijE
	jmRlU0LWefg+2NVi0wS2XOefzF1Z2RnTSfg03jny8I+TZ9BSOrNIPvErWlVo3ZmOpU7E7Tz1bjy
	uYZsYYsTGWXy0PphJe/lc/cNOkGnunnLlZi9BQZbUc6enejCjwb7oqGsjIXmtPy5I1HFfUaL/hy
	gUXQO3IhzeNZnznLm+jLaTSsqICGtjwnmaVKFfgBsBqBmEXXcQ8KFHgjtFnvAQ5eb8pFSeK+tIE
	7tbLkSokqNPDEtjErTmIzXcRQVwG8YEBLKfHj3mk48bNKu455cvIIgZMaeLw4voEHhphd1yLUFe
	lkxTvqgtNNoV4=
X-Received: by 2002:a17:907:6d07:b0:c02:6fbc:203b with SMTP id a640c23a62f3a-c10801b77fbmr541038366b.46.1782341119093;
        Wed, 24 Jun 2026 15:45:19 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe6220esm51310366b.45.2026.06.24.15.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 15:45:18 -0700 (PDT)
From: Samuel Page <sam@bynar.io>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] nfc: nci: fix uninit-value in nci_core_init_rsp_packet()
Date: Wed, 24 Jun 2026 23:44:55 +0100
Message-ID: <20260624224455.999374-1-sam@bynar.io>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301801-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[bynar.io:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzbot.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,bynar.io:dkim,bynar.io:email,bynar.io:mid,bynar.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 213E26C1CE2

The CORE_INIT_RSP handlers walk the response using length fields taken
from the packet itself, without checking they stay within skb->len:

 - v1 computes
	rsp_2 = skb->data + 6 + rsp_1->num_supported_rf_interfaces;
   from the on-wire (unclamped) interface count and then dereferences
   rsp_2, and memcpy()s the advertised interfaces - both can run past the
   received data;
 - v2 walks supported_rf_interfaces[], advancing the cursor by an
   in-packet rf_extension_cnt with no bound.

A short CORE_INIT_RSP therefore makes the parser read past the packet
(into the uninitialised tail of the RX skb); the values are stored into
struct nci_dev and consumed while bringing the device up:

  BUG: KMSAN: uninit-value in nci_dev_up+0x10f3/0x1720
   nci_dev_up+0x10f3/0x1720
   nfc_dev_up+0x187/0x380
   nfc_genl_dev_up+0xdc/0x1a0
   genl_rcv_msg+0x5d4/0x9e0
   netlink_rcv_skb+0x28f/0x530
  Uninit was stored to memory at:
   nci_rsp_packet+0x68f/0x2310
   nci_rx_work+0x25f/0x5d0
  Uninit was created at:
   __alloc_skb+0x540/0xd40
   virtual_ncidev_write+0x65/0x210

Validate the response length before parsing or storing the
variable-length parts, rejecting truncated responses with
NCI_STATUS_SYNTAX_ERROR.  In v1 the check is done before
num_supported_rf_interfaces is stored into ndev, so a truncated response
cannot leave ndev->num_supported_rf_interfaces holding the unclamped
on-wire count, which nci_init_complete_req() would otherwise use as a
bound for the fixed-size supported_rf_interfaces[] array.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Cc: stable@vger.kernel.org
Tested-by: syzbot@syzkaller.appspotmail.com
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
v2: validate the response length before storing num_supported_rf_interfaces
    into @ndev.  In v1 the unclamped on-wire count was stored first and the
    length check returned early on a truncated response, leaving
    ndev->num_supported_rf_interfaces > NCI_MAX_SUPPORTED_RF_INTERFACES; a
    subsequent CORE_INIT completion then walked it in nci_init_complete_req(),
    which the syzbot CI run on v1 flagged as a UBSAN array-index-out-of-bounds.
    https://ci.syzbot.org/series/2a9a8657-37a3-4dce-8cb5-2035027791dd
    v1: https://lore.kernel.org/all/20260623222402.175798-1-sam@bynar.io

 net/nfc/nci/rsp.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb862825c5..6b2fa6bdbd14 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -50,11 +50,25 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
 	const struct nci_core_init_rsp_1 *rsp_1 = (void *)skb->data;
 	const struct nci_core_init_rsp_2 *rsp_2;
 
+	if (skb->len < sizeof(*rsp_1))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status 0x%x\n", rsp_1->status);
 
 	if (rsp_1->status != NCI_STATUS_OK)
 		return rsp_1->status;
 
+	/*
+	 * supported_rf_interfaces[] and the trailing nci_core_init_rsp_2 are
+	 * addressed using the on-wire (unclamped) interface count, so the
+	 * response must be long enough for both before any of it is parsed or
+	 * stored into @ndev - otherwise a truncated response would leave
+	 * ndev->num_supported_rf_interfaces holding the unclamped count.
+	 */
+	if (skb->len < sizeof(*rsp_1) +
+	    rsp_1->num_supported_rf_interfaces + sizeof(*rsp_2))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	ndev->nfcc_features = __le32_to_cpu(rsp_1->nfcc_features);
 	ndev->num_supported_rf_interfaces = rsp_1->num_supported_rf_interfaces;
 
@@ -88,9 +102,13 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 {
 	const struct nci_core_init_rsp_nci_ver2 *rsp = (void *)skb->data;
 	const u8 *supported_rf_interface = rsp->supported_rf_interfaces;
+	const u8 *end = skb->data + skb->len;
 	u8 rf_interface_idx = 0;
 	u8 rf_extension_cnt = 0;
 
+	if (skb->len < sizeof(*rsp))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status %x\n", rsp->status);
 
 	if (rsp->status != NCI_STATUS_OK)
@@ -104,10 +122,16 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
 
 	while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
-		ndev->supported_rf_interfaces[rf_interface_idx++] = *supported_rf_interface++;
+		/* one interface byte + one extension-count byte must be present */
+		if (end - supported_rf_interface < 2)
+			return NCI_STATUS_SYNTAX_ERROR;
+		ndev->supported_rf_interfaces[rf_interface_idx++] =
+			*supported_rf_interface++;
 
-		/* skip rf extension parameters */
+		/* skip rf extension parameters, bounded by the packet */
 		rf_extension_cnt = *supported_rf_interface++;
+		if (rf_extension_cnt > end - supported_rf_interface)
+			return NCI_STATUS_SYNTAX_ERROR;
 		supported_rf_interface += rf_extension_cnt;
 	}
 

base-commit: a986fde914d88af47eb78fd29c5d1af7952c3500
-- 
2.54.0


