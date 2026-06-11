Return-Path: <netdev+bounces-298405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vzJvOe9AK2rH5AMAu9opvQ
	(envelope-from <netdev+bounces-298405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:12:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A918675C7E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:12:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kxRqYwJu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298405-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298405-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A512930BA2FB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BB838C412;
	Thu, 11 Jun 2026 23:12:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84B31326A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:12:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219564; cv=none; b=fqdEuHFC3udr1Ld1SsAiWerKNwj0UimijvScdw/O1QAH3qa3P2z/zVC+s0p81GzSAB+ZvBQnkEAjoEqYGD0eocIoNCcUQXIskfTtdWW36NBl6pVroXmTaQSA7NwcLAcP5R3B9Sh4BHwNnf+YrFuAiWwKArQrK2ct6QKtx3q3rHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219564; c=relaxed/simple;
	bh=tkvVzvKSNkc15LVXz0upvAZulnl5lnii3UoMtZ9Yj7g=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=Sgnw2shgksbp1xAaYiMi+moI8a6cCVJ3g2vJxW8KNU0sBbB1fUI7pJwkjkHA1nKu8lsGcxTwWHgQKV2sPx8PE+bpB56nWjtUUYzaW88O1MAZMg89iWFxMkSzUMQ1k+Rn69YERHtWDMS2CMVQYxEIcfvTgOh4m4O5mhPsjM0166g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxRqYwJu; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-842358aaf36so185295b3a.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781219563; x=1781824363; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fij/oQvu/2UXmQt0RzKkHVGLvKBTwVHkKcJT+NiS0dg=;
        b=kxRqYwJu1PUHtQ2IuXuVNByC1WxOhaSVdkLOdPfiTeCPVM33Lx24P71LJ6b2sOODEG
         GBfj48BeFb0jpkaVHBfI+vRs14lw8acpJf1QTBULEUN90EycoL5sQS6wuBD8R1sUBjYz
         7QmdGfLSlV9AatHljkkUXezro7ssO1hCzofPbrgnUwrbp9BwXrDXo2vWl4tQt2FqSSua
         zzJtMCh2TJmtQH34VCPdJi42pYVBOWfoiP2VUFjD7N/FtTZ9tLkG16yd/AZlOTHm4AR3
         UtGy1HLl6PqfnifzUerr6quXt0sPk06swraDKP3xb7B3MZSTNnYLTp5PFmdpgjjO2IdT
         D+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219563; x=1781824363;
        h=cc:to:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fij/oQvu/2UXmQt0RzKkHVGLvKBTwVHkKcJT+NiS0dg=;
        b=C99Vs0SVCDQ7w7y1sp+/qzJbCxE6X8Mmzq4TjYH7Qd1en/1n0GvfdnGbOZgCRvI1e4
         j6ZNAE69cWIVuzNi0N1d4hqBN2EeDNdY1j4uPY4efC3pH6QlY8+gLbUKnjmhGMeq7zVD
         Zy/D0cyTQDpJqWrHdzCQKjXWTvekmZZbgpgK1pqMvxk66yrM54DpOlfM1j+KEWiT0g4Y
         7k1zUCIQnw/AQiKmRQvEATy0X9qZr2eDNMfcnFYvBe8HvlFtvTfkVZFtcIdYYs3MVylS
         CPZ6H6Q4/fWR6o3PxRWaYDrhB6IbKojOWYmjQLa1iNfVQRqt8QR7DoB3Q1jFM4NxP3g5
         /Knw==
X-Gm-Message-State: AOJu0Yy0u5nM+GiJos9Gddidii+EasM3AkdJlq6h0oHEb6O3tflIRIEP
	C0spUJehEbN0sBdN56+8wcTbUMWdEsZdyF72JK5wtbNkMAswaAHtQgiT10KPlAPCdng=
X-Gm-Gg: Acq92OGtep9yiEu6aldhc1I7g7v7rrAtVjaZU7dqYYN7lPeHH8E38dUBK2Zbwo7oJOO
	hkOIXcEKd/voJ48NMa86CRcx7CesnRsEv0A5Fd+BxI04o3B3vwjbu9IxOdPPd49lb4F+OEouUrR
	duZGT7Jak7+3nrkic0V/b0rSZJbP5Tv4ubcNpTvg2cgDqoHNhTA7GCods/NBXJHEycDgQh68ROT
	yD4QHhivIbjcrGIo6GIwZtQ05GiKVxwogbDvNCZ7wI3jv/8XY+0dF7yslSnn4JgzjC/QTllfsY8
	G8mxyJzwBEnzuNZk1oMZZpophYaeDzc/T7o6aoR9VzvBBQb3Hh+AjDhicMKDocHYTQvEXPdG36s
	A5sRehkcaMBL5nmN4YEtCKTX3T4a3obWzND5LcyEZWvpusX2xIhPCzVQ3cWFurQRfyJ0X6Ahm0S
	MwVaSam2ecS0mWiiQ8
X-Received: by 2002:a05:6a00:2351:b0:842:5712:c2c2 with SMTP id d2e1a72fcca58-8434ce5eaf1mr123505b3a.41.1781219562783;
        Thu, 11 Jun 2026 16:12:42 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afd100esm199571b3a.34.2026.06.11.16.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 16:12:42 -0700 (PDT)
Message-ID: <6a2b40ea.4dd82583.3a5c46.e5a2@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Fri, 12 Jun 2026 07:09:56 +0800
Subject: [PATCH] net: airoha: Fix debugfs new-tuple display for IPv4 ROUTE
 entries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298405-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mx.google.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A918675C7E

In airoha_ppe_debugfs_foe_show(), the second switch statement falls
through from PPE_PKT_TYPE_IPV4_HNAPT/DSLITE to PPE_PKT_TYPE_IPV4_ROUTE,
accessing hwe->ipv4.new_tuple for all three types. However, IPv4 ROUTE
(3-tuple) entries do not contain a valid new_tuple — this field is only
meaningful for NATted flows (HNAPT/DSLITE). For ROUTE entries, the
memory at the new_tuple offset holds routing information, not NAT data,
so displaying "new=" produces garbage output.

Split the fallthrough: display new_tuple only for HNAPT and DSLITE, and
add an explicit empty case for IPV4_ROUTE.

Fixes: 3fe15c640f38 ("net: airoha: Introduce PPE debugfs support")
Signed-off-by: Wayen.Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
index 0112c41..f9c12e7 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
@@ -121,8 +121,6 @@ static int airoha_ppe_debugfs_foe_show(struct seq_file *m, void *private,
 		case PPE_PKT_TYPE_IPV4_DSLITE:
 			src_port = &hwe->ipv4.new_tuple.src_port;
 			dest_port = &hwe->ipv4.new_tuple.dest_port;
-			fallthrough;
-		case PPE_PKT_TYPE_IPV4_ROUTE:
 			src_addr = &hwe->ipv4.new_tuple.src_ip;
 			dest_addr = &hwe->ipv4.new_tuple.dest_ip;
 			seq_puts(m, " new=");
@@ -130,6 +128,8 @@ static int airoha_ppe_debugfs_foe_show(struct seq_file *m, void *private,
 						       src_port, dest_port,
 						       ipv6);
 			break;
+		case PPE_PKT_TYPE_IPV4_ROUTE:
+			break;
 		default:
 			break;
 		}
-- 
2.51.0



