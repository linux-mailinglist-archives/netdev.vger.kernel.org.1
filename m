Return-Path: <netdev+bounces-303314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DFvjCc//Q2p+nAoAu9opvQ
	(envelope-from <netdev+bounces-303314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:41:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEF76E6FBE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:41:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=BmWMhSDk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303314-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303314-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CF823046CDB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D8F3DF001;
	Tue, 30 Jun 2026 17:41:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021E3DCD8F
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 17:41:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841280; cv=none; b=mTIHaeg9x1MfXmKxPBE/iEkwC5L5IqIw7V7931ip4Y0MOTCl/FeD74p4P9B3CaVjhMpzSLwV/wZmzXSD74cUlkcBHdhgPZ54JbcpZnIaLBPkbeQmVFFfutlOsYq6/rdWM3lXQXd0LP0fz2pILAtzBMc6es6qVY1OIl436E7zl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841280; c=relaxed/simple;
	bh=QgZhmXXDk8xCmK1o0ocNcnCpwru8TZboIRGQ74nopQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFm/ut3h1YCeLZcNhS7eK7Mw8bO89FDTq7fRcEsjjqlqaJTwT9bCku72Mx8Re7v9QrOKqAMnQQp5uPIMsMzWnTwGmf1H2U4HtCJFUrB7Sl5PwEAEX1NzNRPCJBKKyZpGL/rYh1uJ9yDWBfEWaj9OJQxjXE6x24k5shD9DLANxrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=BmWMhSDk; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37fb434c547so2363209a91.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782841277; x=1783446077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4BuzdiFicaeGG3kstHee8NskPtG8012B2ydnzFh0pZ8=;
        b=BmWMhSDkVkWQLuNejCQ8QyV+vheCjTEj+DQFVI1/D5royKU/1FOh7T2S3IFx+SwBaw
         qBwRcTtht/6ZlNVSOGvSvicebtbZxjBeQgCHNRosnjeGHTSAebRKbZ1+iu/5BfFO98zz
         B7ItwULN/cDcnMkh9KnMBvwmuJZXsAB9USgq2kFbffSTKj/QWxj4fanwGTW50dr49tYJ
         2xcPNFJE3LOYD7iORZ96rwsTMPBpSKl90R2O6SLpGSurH32DT9E/i9yYPwpBjxKd1Kzz
         DHVPi8cK3oIBcHPeqOVCEF5twYw0YFzvxlzzbap9KJm4d0GDc1+4+VK8L68MPxpGFOK4
         V5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782841277; x=1783446077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BuzdiFicaeGG3kstHee8NskPtG8012B2ydnzFh0pZ8=;
        b=UmUtlJNDciIIp4Mvlk82Xs+jxuLHGOyxNMXjHGeC5xgf3nB/AiPsANb4Yhi5lcA3yZ
         CFSuFeCcJFD/GRREPwnFZ8nTDoEgl/HTCl3RxZ1koKXktGz0XLAbzNrPdTrjEGxCO9KH
         YSRFdO87s8zm1zl2g9g+ndECF8Qdzl8NrEb/bXU1K19/MdosbZzZe46Sq7iEi6scn3yR
         KnonmTsEOBeVDI8R12IgmpITPL535CLIPiuwUxtVzFqpzU6OyLPd1sh/Pdi0ZgNVD+MC
         lR58hxuRFI3Mc3fXrZMIF2vNP21CdTuO6c9A1XgMw7pnaiY1EIWYJgnlFN3ucHmyhLKt
         N3cQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpr/y+gStR5P900+AM8ls5XYivldd2pLJPqxgjewNgpax5h7dZ5Fpow5vI9YPkxY5EGFg0guq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw90uW+c+yIM0TizDlfM7S7nF4mRLvIb6He92cH2nK5t+gGoBe/
	XnzK+699sq5HIvqqsMDwFHBNMoJiqsknXXmAufx4TC7C3CsfFm7nFzxGtMmCaVQ7xS33k8LlC9g
	tbjHG8w==
X-Gm-Gg: AfdE7cnJkovpa09sFV3/dR1Y18MhnuNU5LflBEGjGjvqUM90o6wVeAwvzjh7xBS+S9T
	JFY7CzGIV+C8RhpKztwdYn5UB0mnKiFWyJ5h8lAXl1guMjBKDI7rb2AQGVnzGTr3MHxsQXu17B3
	+HTrjkkPa/KUmvi3iVrRB+ybuROqt4uNZVI3LYYhl/R9cfJtof55ttAyvLRwr3x5+6d6PJ2Ssyh
	yskjHsy5rT0R36Oho9BWoUKBKdBd2KXwlWjzqTGO+juR0u0jHFzfiil08Lr5pjF7Xk7cuNIqZIL
	NiynKMdxWxmYSHZ2awJSN82juTj3+IrNTkEP9h8y0aXhPCdRkrgAJ77HKpgXLj3iXV6c8a51Liv
	HIKEodq2tiRMHV60xH+k4id7M+K/Y1uxQ6eXrZPFIyX+JfUk5ul6cQxTJSxw76t4S9s6Iqk+mhA
	==
X-Received: by 2002:a17:90b:4f4e:b0:37d:8426:40de with SMTP id 98e67ed59e1d1-3808bd49c8cmr1301816a91.1.1782841276983;
        Tue, 30 Jun 2026 10:41:16 -0700 (PDT)
Received: from p1.. ([2607:fb91:1582:634e:f23c:351a:5288:3553])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3809641cdfcsm274353a91.12.2026.06.30.10.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:41:16 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: subash.a.kasiviswanathan@oss.qualcomm.com,
	sean.tranchetti@oss.qualcomm.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] net: qualcomm: rmnet: validate MAP frame length before ingress parsing
Date: Tue, 30 Jun 2026 10:41:09 -0700
Message-ID: <20260630174110.2003121-1-xmei5@asu.edu>
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
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,asu.edu];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303314-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:subash.a.kasiviswanathan@oss.qualcomm.com,m:sean.tranchetti@oss.qualcomm.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACEF76E6FBE

When ingress deaggregation is disabled, rmnet_map_ingress_handler() passes
the skb straight to __rmnet_map_ingress_handler(), skipping the length
validation that rmnet_map_deaggregate() performs on the aggregated path.
The parser then dereferences the MAP header and csum header/trailer based on
the on-wire pkt_len without checking skb->len, so a short frame is read out
of bounds:

  BUG: KASAN: slab-out-of-bounds in rmnet_map_checksum_downlink_packet
  Read of size 1 at addr ffff88801118ed00 by task exploit/147
  Call Trace:
   ...
   rmnet_map_checksum_downlink_packet (drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c:413)
   __rmnet_map_ingress_handler (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:96)
   rmnet_rx_handler (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:129)
   __netif_receive_skb_core.constprop.0 (net/core/dev.c:6089)
   netif_receive_skb (net/core/dev.c:6460)
   tun_get_user (drivers/net/tun.c:1955)
   tun_chr_write_iter (drivers/net/tun.c:2001)
   vfs_write (fs/read_write.c:688)
   ksys_write (fs/read_write.c:740)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   ...

Factor that validation out of rmnet_map_deaggregate() into
rmnet_map_validate_packet_len() and run it on the no-aggregation path too.
The MAP header is bounds-checked first, since this path can receive a frame
shorter than the header.

Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Suggested-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: Validate on the no-aggregation path by reusing the deaggregation
    length checks (factored into rmnet_map_validate_packet_len()) instead
    of adding separate pskb_may_pull() guards in __rmnet_map_ingress_handler().

 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  |  5 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  1 +
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 72 ++++++++++---------
 3 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index 9f3479500f85..d055a2628d8c 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -126,7 +126,10 @@ rmnet_map_ingress_handler(struct sk_buff *skb,
 
 		consume_skb(skb);
 	} else {
-		__rmnet_map_ingress_handler(skb, port);
+		if (rmnet_map_validate_packet_len(skb, port))
+			__rmnet_map_ingress_handler(skb, port);
+		else
+			kfree_skb(skb);
 	}
 }
 
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
index b70284095568..60ca8b780c88 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
@@ -59,5 +59,6 @@ void rmnet_map_tx_aggregate_init(struct rmnet_port *port);
 void rmnet_map_tx_aggregate_exit(struct rmnet_port *port);
 void rmnet_map_update_ul_agg_config(struct rmnet_port *port, u32 size,
 				    u32 count, u32 time);
+u32 rmnet_map_validate_packet_len(struct sk_buff *skb, struct rmnet_port *port);
 
 #endif /* _RMNET_MAP_H_ */
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 8b4640c5d61e..305ae15ae8f3 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -333,54 +333,62 @@ struct rmnet_map_header *rmnet_map_add_map_header(struct sk_buff *skb,
 	return map_header;
 }
 
-/* Deaggregates a single packet
- * A whole new buffer is allocated for each portion of an aggregated frame.
- * Caller should keep calling deaggregate() on the source skb until 0 is
- * returned, indicating that there are no more packets to deaggregate. Caller
- * is responsible for freeing the original skb.
- */
-struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
-				      struct rmnet_port *port)
+u32 rmnet_map_validate_packet_len(struct sk_buff *skb, struct rmnet_port *port)
 {
 	struct rmnet_map_v5_csum_header *next_hdr = NULL;
 	struct rmnet_map_header *maph;
 	void *data = skb->data;
-	struct sk_buff *skbn;
-	u8 nexthdr_type;
 	u32 packet_len;
 
-	if (skb->len == 0)
-		return NULL;
+	if (skb->len < sizeof(*maph))
+		return 0;
 
 	maph = (struct rmnet_map_header *)skb->data;
+
+	/* Some hardware can send us empty frames. Catch them */
+	if (!maph->pkt_len)
+		return 0;
+
 	packet_len = ntohs(maph->pkt_len) + sizeof(*maph);
 
 	if (port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4) {
 		packet_len += sizeof(struct rmnet_map_dl_csum_trailer);
-	} else if (port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) {
-		if (!(maph->flags & MAP_CMD_FLAG)) {
-			packet_len += sizeof(*next_hdr);
-			if (maph->flags & MAP_NEXT_HEADER_FLAG)
-				next_hdr = data + sizeof(*maph);
-			else
-				/* Mapv5 data pkt without csum hdr is invalid */
-				return NULL;
-		}
+	} else if ((port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
+		   !(maph->flags & MAP_CMD_FLAG)) {
+		/* Mapv5 data pkt without csum hdr is invalid */
+		if (!(maph->flags & MAP_NEXT_HEADER_FLAG))
+			return 0;
+
+		packet_len += sizeof(*next_hdr);
+		next_hdr = data + sizeof(*maph);
 	}
 
-	if (((int)skb->len - (int)packet_len) < 0)
-		return NULL;
+	if (skb->len < packet_len)
+		return 0;
 
-	/* Some hardware can send us empty frames. Catch them */
-	if (!maph->pkt_len)
-		return NULL;
+	if (next_hdr &&
+	    u8_get_bits(next_hdr->header_info, MAPV5_HDRINFO_HDR_TYPE_FMASK) !=
+	    RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD)
+		return 0;
 
-	if (next_hdr) {
-		nexthdr_type = u8_get_bits(next_hdr->header_info,
-					   MAPV5_HDRINFO_HDR_TYPE_FMASK);
-		if (nexthdr_type != RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD)
-			return NULL;
-	}
+	return packet_len;
+}
+
+/* Deaggregates a single packet
+ * A whole new buffer is allocated for each portion of an aggregated frame.
+ * Caller should keep calling deaggregate() on the source skb until 0 is
+ * returned, indicating that there are no more packets to deaggregate. Caller
+ * is responsible for freeing the original skb.
+ */
+struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
+				      struct rmnet_port *port)
+{
+	struct sk_buff *skbn;
+	u32 packet_len;
+
+	packet_len = rmnet_map_validate_packet_len(skb, port);
+	if (!packet_len)
+		return NULL;
 
 	skbn = alloc_skb(packet_len + RMNET_MAP_DEAGGR_SPACING, GFP_ATOMIC);
 	if (!skbn)
-- 
2.43.0


