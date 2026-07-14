Return-Path: <netdev+bounces-307575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hzDHMemMVmqo8wAAu9opvQ
	(envelope-from <netdev+bounces-307575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:24:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 457F775835B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:24:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YkTuqxEL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307575-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307575-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F01F4310A426
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368F03ED5A6;
	Tue, 14 Jul 2026 19:23:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC04B37B01F
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:23:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056995; cv=none; b=hzeIiHhYYbIPKJFeyK3YOvmojdKYKsbT0Bsf7lblvHoHdeelEtVgc6jN0dAhnFtXPUOqmaO/iSHQtS6uPIr+wS8NROek+tJs0pQ5eUnLpPktjJStX1ym5vRsQ3YiweVy+iUB9Vq4kGGjMsggTvm7AdrJvwx1qr9o0lWqIyfC+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056995; c=relaxed/simple;
	bh=fFBHdwS5m7mtCvyv1Trv/atViqR0huglkyQkqJ5emVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqTvNnyF/uVYZkL6K3441rGcSNAOwbZJEQjgVquo9IvKI8ZG5rKafZ0b1aF1ruOp0N60rWuOust3dNwEi83P9E+zjE4+gM8CDENccmnpKM+oLlisg929CI45c6BARRsbfqqBl1CGoARtx+MH2lgaIhZ8nguzAh8DGUcfkNpP7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkTuqxEL; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38101f85591so1051331a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056993; x=1784661793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4YxMZuS3O1N4LeRTy/92z3+raTT8LPy5OGFMt00nrLg=;
        b=YkTuqxELhYg+2qo2cr34ZYEiG2vBnymqgci+NkLWkkOs2p7m49Qd5hBDAPCV2Prbvs
         SKhv2hW24MNDAstrOB59oPXQIz6lj8T9cKc43xZYGXieLwZL6kizKsecH3VH6cXic1NQ
         rBevHGFSKiwf+ZTtcau5IAxm/Gsu2InnEo9lnt+BlFdWNUQeum+zLp8PDfBhoHRrO+4m
         NIy06ypLlT8i1eC6jZadUFxtAjouHnHxWwTYxHbYD/id+Ot/2Qkf4x6JhLY/Y9/MPwBD
         vC7QEfECzQRvWNaaBkv83tPfQJTCLm0kolU9ZruiDhiPpXGDzu81QCbE/g3+bUX3Qaph
         SW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056993; x=1784661793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4YxMZuS3O1N4LeRTy/92z3+raTT8LPy5OGFMt00nrLg=;
        b=AiFQfcWxuzrxwy34HQnkFsYJkQvBhjvan3yY2nIwBPywdh+w68Zi8i2fdA0FFikNou
         Rg4diff/AGH0WoX/8D672RqC4GqopwRkJT/OrUZKnKDymx+uvCNZfZQ9rjZesRzCZ4WL
         qVUZLoRav8lMCMNrrCyIQgLpSrDBAUobDarQWUCOI0orQBtPfGBaedcdPILV/m41GIsi
         /yE4pkfYPyvuKoB5nj129W49kTv8dkeFNzwFoCSSAdoC8r9ks34EdgqhxwkoU24LcZ7s
         oyLHn7eK3YYN2fwRVrFRSIUEH9DU/8T5f+s5vSKnk8hEa0r/qPNieDrXmGVBw6Ad04AP
         LFLA==
X-Forwarded-Encrypted: i=1; AHgh+RpZffpgmB6nwiIoRSTVes+1aVvO1B74TA74bEfThY+0w4zeaX10EKKbFJmfySBV5yilP7Q96s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJe9mO1hrW34SH01GFNi7eTxqqFdYFEB3LoO/LJ8Siik92j+Jy
	3GokET7zl93lZJQKOpqSO2EX15YF8lI+7ZsIUm9VgK3/HCOIvuHAw1Lb
X-Gm-Gg: AfdE7cltsuMSz/4vB9d8h1e8Xo/G2Abx5u0iN7M1/yZ4OA8xYW8p7K6hwLReJlnh3Vv
	XGb1gLK3fD2UrDhb/sY8/lkxqINgq9Dgib8v/1lwFWA6VerLdBvB9pbMxnMVHIcUr6xFMfUIbgR
	wnPKYt2kSHZKxjh6pOStIQoIqIDVwKtGQj6OEGPlO0N+4F56OXFR7Z1j2t4Mc9mGlyvojEC1I4T
	tZhXL/0W7QSZvoIVtfkcDeQDh3kIYbsRaG9EkkV7mVLd24TPNaHMACzi3sV7Y6hdzMTKU58vok1
	dXxei090VaTNsYGLs2uWwM3jfLTBhV1pjFJb4Mua7/AdbgYQgVZZyRgtql9g2UR6cT1Z5/ieNe8
	9ED4C7YB4Rx/muob9dMKYgUDwwn6S1JJ9gU6zTamSBmkxlsog5wTJKwmkCthtDEYwDludbkB/rW
	Ez+2xeZoGk6LGH5nqg5NgBdBHoQ2UFG8M4WIno6kew/A8w+5G6IOK5kX+jY1WXTGMx86KEC+n+2
	YrT8ll3pi5p7M7BrTsg0aY=
X-Received: by 2002:a17:90b:3c0f:b0:37f:f089:c81b with SMTP id 98e67ed59e1d1-38dc8071aeamr11838700a91.3.1784056993076;
        Tue, 14 Jul 2026 12:23:13 -0700 (PDT)
Received: from lab-kiba-ocxma-dut-01.. (191.68.231.218.rev.ocx2915.net. [218.231.68.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e16e1d2e8sm1979029a91.0.2026.07.14.12.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:23:11 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	marcin.szycik@linux.intel.com,
	netdev@vger.kernel.org,
	Takeru Hayasaka <hayatake396@gmail.com>
Subject: [PATCH iwl-net] ice: fix empty PTYPE set for GTP RSS profiles
Date: Tue, 14 Jul 2026 19:22:30 +0000
Message-ID: <20260714192302.631428-1-hayatake396@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,linux.intel.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307575-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:marcin.szycik@linux.intel.com,m:netdev@vger.kernel.org,m:hayatake396@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hayatake396@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hayatake396@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 457F775835B

Configuring RSS for GTP flows via ethtool, e.g.

  ethtool -N <if> rx-flow-hash gtpu4 sde

is accepted but has no effect: the hash of GTP-U packets does not
include the TEID, so all traffic between a given SGW/PGW pair lands on
a single Rx queue. The GTP RSS configurations the driver installs by
default at VSI init are affected the same way.

ice_flow_set_rss_seg_info() does not set IPV_OTHER on GTP segments, and
such a segment carries no L4 header bit either. ice_flow_proc_seg_hdrs()
therefore takes the "no L4" branch and ANDs the PTYPE set with
ice_ptypes_ipv4_ofos_no_l4, or ice_ptypes_ipv4_il_no_l4 for the inner
segment. Neither holds a GTP PTYPE, so ANDing with ice_ptypes_gtpu
leaves the set empty: the profile matches no packet at all and the
configured TEID field never enters the hash.

Set IPV_OTHER on GTP segments so that the tunnel-inclusive PTYPE sets
are selected instead, which do contain the GTP PTYPEs.

Verified on E810 (kernel 7.2-rc2, COMMS DDP 1.3.63.0) by reading the RSS
hash from the Rx descriptor: GTP-U traffic varying only the TEID goes
from one constant hash on a single Rx queue to 4096 distinct hashes
across all Rx queues. The same holds for inner IPv6 (gtpu6) and for a
PDU session container extension header (gtpu4e); plain UDP flows are
unaffected.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 121552c644cd..2156bf246921 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -2088,6 +2088,14 @@ ice_flow_set_rss_seg_info(struct ice_flow_seg_info *segs, u8 seg_cnt,
 
 	ICE_FLOW_SET_HDRS(seg, cfg->addl_hdrs);
 
+	/* A GTP segment has no L4 header bit: without IPV_OTHER the "no L4"
+	 * PTYPE sets are picked, and they hold no GTP PTYPE at all.
+	 */
+	if (seg->hdrs & (ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_GTPU_EH |
+			 ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_GTPU_DWN |
+			 ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_GTPC_TEID))
+		seg->hdrs |= ICE_FLOW_SEG_HDR_IPV_OTHER;
+
 	/* set outer most header */
 	if (cfg->hdr_type == ICE_RSS_INNER_HEADERS_W_OUTER_IPV4)
 		segs[ICE_RSS_OUTER_HEADERS].hdrs |= ICE_FLOW_SEG_HDR_IPV4 |

base-commit: 1cd23ca80784223fa2204e16203f754da4e821f8
-- 
2.43.0


