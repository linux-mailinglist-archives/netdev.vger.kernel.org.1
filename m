Return-Path: <netdev+bounces-306434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z/B9GCZ1UGplzQIAu9opvQ
	(envelope-from <netdev+bounces-306434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:29:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9946737228
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:29:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=fBjFVnXe;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306434-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306434-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A9B03051D0F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D0936C9ED;
	Fri, 10 Jul 2026 04:25:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E9136DA04
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:25:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657508; cv=none; b=W6aUGncixHtqBID2nFtwNBQjYE7egx/zwtXl5p8UwBSZQvxDiVT4f3OMrcBIYhJApq5jySccHZxHV+9PhdvlWd2E28KI3VU8318bUNFldELaHEcVsA83b1hUBEJGryvBmCQ5QrnJ/ZcluVB5hRUMYOtfG6PazUjoo9g6EJ0EjRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657508; c=relaxed/simple;
	bh=pxVfFdGMeoPFAzQz3b0G659QHf4W+V36L+U/AiiMtCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+ZcjpgBLUIeLOMgLcdEt7vxojjEPlwFdCnqwc+ZG4Ze8QmuJ7duMVVKZPNeOD+sbTLoD5APfIWOYDGE6TEpsTv/9ZYZtEiBKzRNvYrkokfBqw3DRkLyTyjvzVjohVBPWU76UcfCDVg9Ygo2j1/b3D6beBcRGBSRaJyDdbuRUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fBjFVnXe; arc=none smtp.client-ip=74.125.224.100
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-66628618509so659417d50.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657506; x=1784262306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eyZBNWjXiJYpw4AXLf7sO6co+G6RVyUUgZr2HtNEmKY=;
        b=WOIs9DEZ+d5Zz3ThFMfLFzDnxYr+HoQtECOTR+uTjONtxYsffs3Y9nG5ZXQXGu0GZB
         WX1odCbmsNYON1YnnuuAnidpKKbiuWMG0pqtSmpcu4P3WN5mBAKqVFQe0QDscFRaIvdm
         qNRFE3/XSYIEDUCgT+7DEdvT1o0ZOU0Juh+lZHtLDDwTata+RfzFY1v2TFfwpBWz5hF5
         ZCLOEE7iH8o4uCEy895uBu7Yq1fV5prxVBk86m9yrPEnyecn6NF4qpUu7tDkc4QRFNPe
         UTXpZ+WE3d26C3hQ3o1AgydX7ZJ6uTS7PBWn2Z7Snuc2hIyl3Cy5XSEM+55wHn14C1qW
         6TCg==
X-Gm-Message-State: AOJu0YwoH5yyLU3iDMmYuHKrMwluffni0lc+2l7hF/0aAMh2SyudnpHB
	uCBZeMJWu4sU7QnCybAdA4P8jYBd6kZPh9Ja+fyMfZGcC0c3GKSOKpmZgQsJG7jYVlH9NxS4Cm9
	2zZ+whZXSgVDp7KYJpNS7EoFL7XERiKOxo5j8UmYJXwT7QoDSLonCJBzpWoK1WxBLaxI6vJoOCQ
	7I5kC59HKBFCaU1BFhdW67KMss131CkmcpxsPfXi+z+vhPGeR2cO4zqNbjpACSElRbeTHPGqwBi
	uNstcDwRZo=
X-Gm-Gg: AfdE7cn8RgNOvzsDeJ9kbIGWHAvrVVFks0ZXZDH5qmJhValzBwwwGqumxD/8U0mtlBu
	OPLGOgMyA68sas5b+JxDfBreqRJrxNvLHk2N0fr/iJknlQsPHjX4Ik2aYlfQf7+UH+c361hnZE8
	lZGGkgQzBF77a7LPiuAHZLumYLHqJvlTxuwsuVsizFCJqfLh3PxvJIBMhVbgxblocS/ZoqiBVYU
	b+BEpgcWQ6eiwhyxT5GlBvV81GtCQYrBKTxRXd5B0u4CHqSud3noVNoGIoXdSiW2i4Vsw/mpHyD
	Ic3nw39LqOqQMObVmQ86ZoL6gfl9DX6h5aYkKywiAxETC7MP1sPoQ9xLiV2qhhGLZKgxBX6vG7F
	IQR/n0c9GijpyVONrghyZB9n9ARRdqVKGaLQ/4QQANDHkMnPeApmuYjeGtaoPHWhp8/O3+SyTEv
	h06U80MCfRAPT4UYjtEYxXuhV4MRI2gUpmL35acRtw0oi3PQ==
X-Received: by 2002:a05:690e:4882:20b0:667:c1b3:d4bc with SMTP id 956f58d0204a3-667c1b3e300mr1658720d50.40.1783657506003;
        Thu, 09 Jul 2026 21:25:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-66787772ad1sm507345d50.5.2026.07.09.21.25.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:25:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37d4f23eb37so1043981a91.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657505; x=1784262305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eyZBNWjXiJYpw4AXLf7sO6co+G6RVyUUgZr2HtNEmKY=;
        b=fBjFVnXeGFbyfr4/rO12P1unOdi2qjYcJ9NwppmyJoew0MzjuEwGU//C6Q3lFQwG7N
         +Wwe/TQ+3MhY367LCpzFmfutAkgFQ5ej0JcsLum2LnKbHjRBVDw7y56pHiIXe4jxDnk8
         KqPhRhnkjLZz070mKvqYlA33tOFExHYCmkhmQ=
X-Received: by 2002:a17:90b:2d48:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-3893fd5fc2fmr10752686a91.11.1783657504845;
        Thu, 09 Jul 2026 21:25:04 -0700 (PDT)
X-Received: by 2002:a17:90b:2d48:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-3893fd5fc2fmr10752657a91.11.1783657504497;
        Thu, 09 Jul 2026 21:25:04 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:25:03 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v5 14/15] bnxt_en: Add support for inline transmit BDs
Date: Thu,  9 Jul 2026 21:23:59 -0700
Message-ID: <20260710042400.3996847-15-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710042400.3996847-1-michael.chan@broadcom.com>
References: <20260710042400.3996847-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-306434-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9946737228

Newer chips (P5_PLUS) support inline transmit BDs that contain extra
data.  One such use case is to transmit out-of-sequence kTLS packets
with encryption enabled.  To account for these inline BDs during TX
completion, we add the inline_data_bds field to struct bnxt_sw_tx_bd
(tx_buf).  tx_buf->is_push will always be set when sending these
inline BDs as the operation is similar to push packets.  tx_buf->skb
will always be NULL as there is no associated SKB.

The next patch will make use of this feature.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 15 ++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index af11f0744d0a..44b0787fef89 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -848,7 +848,7 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		head_buf = tx_buf;
 		skb = tx_buf->skb;
 
-		if (unlikely(!skb)) {
+		if (unlikely(!skb && !tx_buf->is_push)) {
 			bnxt_sched_reset_txr(bp, txr, cons);
 			return rc;
 		}
@@ -860,13 +860,22 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		}
 
 		cons = NEXT_TX(cons);
-		tx_pkts++;
-		tx_bytes += skb->len;
+		if (skb) {
+			tx_pkts++;
+			tx_bytes += skb->len;
+		}
 		tx_buf->skb = NULL;
 		tx_buf->is_ts_pkt = 0;
 
 		if (tx_buf->is_push) {
 			tx_buf->is_push = 0;
+			cons += tx_buf->inline_data_bds;
+			tx_buf->inline_data_bds = 0;
+			if (!skb) {
+				/* presync BD */
+				cons = NEXT_TX(cons);
+				continue;
+			}
 			goto next_tx_int;
 		}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 5b6f629d7bcf..0a60055b3e17 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -917,6 +917,7 @@ struct bnxt_sw_tx_bd {
 	u8			is_push;
 	u8			is_sw_gso;
 	u8			action;
+	u8			inline_data_bds;
 	unsigned short		nr_frags;
 	union {
 		u16			rx_prod;
-- 
2.51.0


