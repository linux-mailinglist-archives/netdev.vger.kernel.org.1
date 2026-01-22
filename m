Return-Path: <netdev+bounces-252501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCGYLiFycmlpkwAAu9opvQ
	(envelope-from <netdev+bounces-252501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:53:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E0B6CBD9
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DEA13015735
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E2033E36F;
	Thu, 22 Jan 2026 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk+pFFPE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA736CE06
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107893; cv=none; b=jYYYuAMqSVnE2PEzHpAhqSi6Q+zR4nusE1lpZgOvuqarm6yp9MiOeuVaMP1zlxnZDhopXoyTd5Azowj2Bi4BnbRqmXjTNpFZ662AR994ioA48K7GLQZK8v60fCuyqu8R/cco5cL6yrCCQqbVlUz8oi8s70o5FbTLUQ0tqYd8dhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107893; c=relaxed/simple;
	bh=CGY3xTEUV2f2ErVVQRgiVBP18MvJrXYzsIOsVkiOrrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sP08QaqbaN5ireK+K8Zbq2QrIkR7cuLkfwVWZGKbHF5OQ148gcLKvLQl2BFonAQ7KsrNv0SfYBmY6l2jr54fJ+M7ADHbm+f2A54ScMsrFsGJGAtBy4rMesdEuhgBa6qKoAvNdhUnRukqhGK4dgHKEP48822NT0ZAI0mfS5qglaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bk+pFFPE; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so833087a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 10:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769107884; x=1769712684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4/X3ZC+jo4Q9uRVB8iuq+jnZRRd9l82X7BVIQyuAX2s=;
        b=bk+pFFPEeLscjvgVVJyh1986EFgmdwhHTeLlQMF4xnWAB+0A1iPTv/NVg6Ai9GLtyk
         gnmuXi/UEoeOsE8ekdwpDP91I1cHUl9QgninmzhbFjyuDzt5ZXnLNhCmxpF3a9iYTX3n
         I8kMezcya6IIibGzVEnt75IarJTGYCQIF33yXZvgwtbD+eHrm4uT1hjCwpSTvORa+mz4
         +XWgyAcVnQj8SZHtrSUH/9SR3Y8eeZF8UR08xuBiRyHUzWXndUPymE/ww1cSwRFzmDU1
         SRQ15XK+EHs4JTuN0fDqtO9X6USFSH+R7wbLLRcROOtelQ0rrZRvtgUrdmD+6Gfyjb0t
         vSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769107884; x=1769712684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/X3ZC+jo4Q9uRVB8iuq+jnZRRd9l82X7BVIQyuAX2s=;
        b=QnEc/oXArgseUboAE/w2gSWjUXLkS3Am7VokVXm++B0rKSv7vKoi2TS/8HwxJbcrIE
         0LEh2gyppKKRml2gJWm7STCJm5Q7GNI1GggUb4oSA4D8CYxofWyKZt5ROlwKxNkKmUvW
         grMwDG133SybkVUPI3EeVVr7jVW4s3JCbJNBd72mkpSOcy2VFAqzztcDMmUxDPNDxFUl
         QhIqGS7+zSJWBvI68yusI1CVMTQ5wAJJg0WfgkYXdnmm6Pchc8Es++VOUKNw2t0U6OZQ
         ZQHWGi1FKfwRhORBiu35RQqEpRw0K4mn+Ro9xYnBCuqN3uRbPbn4GMPWvxVzO+CJ/ldW
         PAhg==
X-Gm-Message-State: AOJu0YwHwu7+X2eyRtP0U45sMCnDJ/1o42svmj1wfaWPkG1SpKwE9G6/
	pQDod7kWasNf3cUG3PfIrydBzrJjCojZME/Ovv8bk9jh+DDPEO7vgj3aOG7uWw==
X-Gm-Gg: AZuq6aJ8Vpm2jSPUwN/33+Q3OyKBzBnZQqzpBAD8zBKh7iheBae3Ov1gZx+2HnJECyi
	rOtFXOzg8ZWvINl8GLso7lZuCgl/g4nUXArTtsyXWnO1fElJX/azBHpZ01LrsqS1BE00phY+Fu+
	EMVqngz6s7wYxjDNR9L8BXFnEkDAzWMdHfA1I8nNZfp59OA3rHYWAHJfA6yVsntyPUBs9jqrreS
	A46Z12OI3tuo43jMgBkaDx+qOTwJWg+hFQrJrKeiPUFitl3gAnN4uMqmj4nqSp/7ldOOdGU0bnF
	uX/16wdIpA/2Uk2N5A0x7wKnicQ0uzEVWGSI3gNeZnrcT9dh6bXZck1VBrTWhgE8Y9Z9PPzjJkZ
	gokamt8N/DsZ0Rl83pweUWeDWo/R1wIs8ouXubE034Uh7K9hT3Zc3BX1MMg2fVQLTdg/Q7TPXIa
	vtiGMreAisQkmfTHm0RThozArOb+yej5f1GVpa86pj/KMcAqzS20c9F89+8XgnKf74
X-Received: by 2002:a05:6a21:50b:b0:366:14b0:1a42 with SMTP id adf61e73a8af0-38e6f83d830mr472672637.80.1769107883534;
        Thu, 22 Jan 2026 10:51:23 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm72761b3a.69.2026.01.22.10.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:51:23 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: alacritech: Use u64_stats_t with u64_stats_sync properly
Date: Fri, 23 Jan 2026 02:51:07 +0800
Message-ID: <20260122185113.2760355-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,gmx.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252501-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22E0B6CBD9
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. Convert to u64_stats_t to ensure atomic
operations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/alacritech/slic.h    | 50 +++++++++++------------
 drivers/net/ethernet/alacritech/slicoss.c |  8 ++--
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/alacritech/slic.h b/drivers/net/ethernet/alacritech/slic.h
index 82071d0e5f7f..f5bb2d9a61be 100644
--- a/drivers/net/ethernet/alacritech/slic.h
+++ b/drivers/net/ethernet/alacritech/slic.h
@@ -284,7 +284,7 @@
 #define SLIC_INC_STATS_COUNTER(st, counter)	\
 do {						\
 	u64_stats_update_begin(&(st)->syncp);	\
-	(st)->counter++;			\
+	u64_stats_inc(&(st)->counter);		\
 	u64_stats_update_end(&(st)->syncp);	\
 } while (0)
 
@@ -293,7 +293,7 @@ do {						\
 	unsigned int start;					\
 	do {							\
 		start = u64_stats_fetch_begin(&(st)->syncp);	\
-		newst = (st)->counter;				\
+		newst = u64_stats_read(&(st)->counter);		\
 	} while (u64_stats_fetch_retry(&(st)->syncp, start));	\
 }
 
@@ -407,34 +407,34 @@ struct slic_oasis_eeprom {
 };
 
 struct slic_stats {
-	u64 rx_packets;
-	u64 rx_bytes;
-	u64 rx_mcasts;
-	u64 rx_errors;
-	u64 tx_packets;
-	u64 tx_bytes;
+	u64_stats_t rx_packets;
+	u64_stats_t rx_bytes;
+	u64_stats_t rx_mcasts;
+	u64_stats_t rx_errors;
+	u64_stats_t tx_packets;
+	u64_stats_t tx_bytes;
 	/* HW STATS */
-	u64 rx_buff_miss;
-	u64 tx_dropped;
-	u64 irq_errs;
+	u64_stats_t rx_buff_miss;
+	u64_stats_t tx_dropped;
+	u64_stats_t irq_errs;
 	/* transport layer */
-	u64 rx_tpcsum;
-	u64 rx_tpoflow;
-	u64 rx_tphlen;
+	u64_stats_t rx_tpcsum;
+	u64_stats_t rx_tpoflow;
+	u64_stats_t rx_tphlen;
 	/* ip layer */
-	u64 rx_ipcsum;
-	u64 rx_iplen;
-	u64 rx_iphlen;
+	u64_stats_t rx_ipcsum;
+	u64_stats_t rx_iplen;
+	u64_stats_t rx_iphlen;
 	/* link layer */
-	u64 rx_early;
-	u64 rx_buffoflow;
-	u64 rx_lcode;
-	u64 rx_drbl;
-	u64 rx_crc;
-	u64 rx_oflow802;
-	u64 rx_uflow802;
+	u64_stats_t rx_early;
+	u64_stats_t rx_buffoflow;
+	u64_stats_t rx_lcode;
+	u64_stats_t rx_drbl;
+	u64_stats_t rx_crc;
+	u64_stats_t rx_oflow802;
+	u64_stats_t rx_uflow802;
 	/* oasis only */
-	u64 tx_carrier;
+	u64_stats_t tx_carrier;
 	struct u64_stats_sync syncp;
 };
 
diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
index f62851708d4f..7488fb6ace0b 100644
--- a/drivers/net/ethernet/alacritech/slicoss.c
+++ b/drivers/net/ethernet/alacritech/slicoss.c
@@ -378,8 +378,8 @@ static void slic_xmit_complete(struct slic_device *sdev)
 	smp_wmb();
 
 	u64_stats_update_begin(&sdev->stats.syncp);
-	sdev->stats.tx_bytes += bytes;
-	sdev->stats.tx_packets += frames;
+	u64_stats_add(&sdev->stats.tx_bytes, bytes);
+	u64_stats_add(&sdev->stats.tx_packets, frames);
 	u64_stats_update_end(&sdev->stats.syncp);
 
 	netif_tx_lock(dev);
@@ -615,8 +615,8 @@ static void slic_handle_receive(struct slic_device *sdev, unsigned int todo,
 	}
 
 	u64_stats_update_begin(&sdev->stats.syncp);
-	sdev->stats.rx_bytes += bytes;
-	sdev->stats.rx_packets += frames;
+	u64_stats_add(&sdev->stats.rx_bytes, bytes);
+	u64_stats_add(&sdev->stats.rx_packets, frames);
 	u64_stats_update_end(&sdev->stats.syncp);
 
 	slic_refill_rx_queue(sdev, GFP_ATOMIC);
-- 
2.51.0


