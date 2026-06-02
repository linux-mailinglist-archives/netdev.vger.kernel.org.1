Return-Path: <netdev+bounces-294232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SDSMKhrgHmq3XQAAu9opvQ
	(envelope-from <netdev+bounces-294232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:52:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFA062EB13
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:52:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Tnlab5dP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294232-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294232-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B342B30634BE
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901FA3ECBC6;
	Tue,  2 Jun 2026 13:36:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311D3E7BC4
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 13:36:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407381; cv=none; b=Tkgksw2eQwYqgL36fkICZgCnViDlAV+CH2Mbia4t1lFUPiomD/avkAep33fq71J/ouDK13kGH4Phkdt9l1Sc/XOOHJPaTvH+8E26w7nZFBqN5K965ju8/GZgrSrZ83677+5RAlwb4SsNbDHkuMEAEw+drdUxwMIDSYCWm7unKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407381; c=relaxed/simple;
	bh=c4o/bCu/h6uZYm+FOxrtLd0Q+cspTiS0IjGm8quOsE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OK5SUSAEkZfXKwlE59UUNoeyRRfX7prCiuwrv1cuTocBqneUf7EPsKSBRGZzzAhLgL2hKMsOjxwMaX/60EWvck8Cz3a4DR8Ov+fnxd6oWXUA/f683eGbXv0o9a9BzqJs7Zm18tqFxDtH4yx4twN5ZT3TxCrWsxfGj14Ik3ptnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tnlab5dP; arc=none smtp.client-ip=209.85.222.180
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9155183b42cso293847285a.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407375; x=1781012175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skC62kgHSJhELJGedMuEvE9z7SLN9uVB1FWz8qFfmZo=;
        b=Tnlab5dPfIT7Ej4Z6L65Wx1EUSUw+jpFhQAO35RhLScHcUXFFQNMDN0NyGhe0DEIV2
         j408eaKMd3uIv6aoONKlxkeg6CvY5bpXq5hIwxJ68cC3K9ahTrIaiTWDcRIe4LRiDpbR
         yZou1zvx+7JTJtAMgy+obOoCx16QVHKuKUg8ErrSuSv8LNMlr7UK8Sxw/vHbxHCGROTU
         ZbDWfA8q3SuL7dJpQ1IAG69S521vsxN6KazI2PZtRcsTdcJGPf5ZQSu5ZuVmC7VgO3cP
         HCOO9lAZqgl6dtBuDmY7Z4mnPhtOEXnvedzZwfWynAvGDBMJ6m72k11HC26sk8m8RWHH
         5zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407375; x=1781012175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=skC62kgHSJhELJGedMuEvE9z7SLN9uVB1FWz8qFfmZo=;
        b=KnzDVOLYP640eKegH6BqmdfCGP2UtU5cc81zBsXupasrIopDWv5lw76KZzKW/x4ss3
         gi8yOz93pFiZ4RHV45tzJQhEUo/elt6gWWvMPESrxKFEbYVmB0qVW0XGRrJTSBXkfZl8
         MLZZCRQxaZMiGnvN4wqqerAOIZlTJS1sPRLmQqGBAL3op2EeTrUNszXxOI2vPnQcL7oa
         NAJJt4BeOMGDC2+2kvdft7L0cG0oFTJFu2HzT4MSvrFlWy83RP1gcMI6/rxtD8vdqiu3
         u00qN5dq+fuWiOSa8IxztHQRb2N7+pyGbXY+GLSDPWPdL2fHaBrs5xslpp/B3jtSZWWt
         MQUg==
X-Forwarded-Encrypted: i=1; AFNElJ+vvbJDSl/loAOeHBrgwJ2tthgLArSx4ra2fWQA+OUTTIzSYX6/az9eBSoPoHShf3aSffm38oY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2qeckRstoUG7Khmhk+dvcU+jVrZJl0GacbTo9X+5fZdY0B+MI
	68F7AIFd+4t4Uw8Czi88VHgpLFnZKv/xacZNi/PeoGX8siUD0w78601I
X-Gm-Gg: Acq92OF0w5JwRbN62kDxZHsb+LDi1zp4990vccdp0vAf2I2mgljYj7wKqOBy3g9pdGA
	B8wyjQ/eIGXNKEE4uZXUrHg4xdtZiF/hDcFxKSBUqyVrundKzbicHwvL6793fhl5ZwIyNZazg8h
	KuhnUfe1jisTjOG+cgNU6A4uoVQ0tb0tmCqNu+/Qtb5DAnBpU+Hyd0VR02SNgno0FNH7ovkyMyo
	AlCavFeslNRgn4Tb0qRmTqE/o50FwpiSXflFNfey1xXeGu4cx9JKzffgtuI0ufjKzoaERJOKvdf
	zLZr54EcvRUMnl0ORGx6/zSPmxvQ4FJQUUsC4SDxwEtofOsnAiDZkSH9B/fKKP8GolblhS1a2Rw
	eXQLyehypzKGk900a/1AzuA910LGbXKeTLX+58OFkPnuRYaIqT+JXTJli8JAM8LsuT6mhsCPtff
	7k4B2l11d3kpMjNIoyIFcph2p5F+DvdM5CO91ubizDzXIGoM9TO7f2jYGRC7lS3rR9n/7M26A4w
	QaqykE7ulwxOPKy2MRFXacRHKeexeM=
X-Received: by 2002:a05:620a:2592:b0:912:5d2a:4bd1 with SMTP id af79cd13be357-91578039e1emr555840385a.40.1780407374609;
        Tue, 02 Jun 2026 06:36:14 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915721f7d75sm346036285a.18.2026.06.02.06.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:36:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 4/4] tipc: reject inverted service ranges from peer bindings
Date: Tue,  2 Jun 2026 09:35:55 -0400
Message-ID: <20260602133555.769727-5-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602133555.769727-1-michael.bommarito@gmail.com>
References: <20260602133555.769727-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294232-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BFA062EB13

tipc_update_nametbl() inserts a binding advertised by a peer node using
the lower and upper service-range bounds taken directly from the wire,
without checking that lower <= upper. The local bind path validates the
ordering (tipc_uaddr_valid()), but the name-distribution path does not.

A binding with lower > upper is inserted at the far end of the
service-range rbtree (keyed on lower) where no lookup or withdrawal can
ever match it (service_range_foreach_match() requires sr->lower <= end).
The publication, its service_range node and the augmented rbtree entry
are then leaked for the lifetime of the namespace, and there is no
per-peer cap equivalent to TIPC_MAX_PUBL on locally created bindings.

Reject inverted ranges in the network path as well. A peer node can
otherwise leak unbounded binding-table memory by sending PUBLICATION
items with lower > upper.

Fixes: 37922ea4a310 ("tipc: permit overlapping service ranges in name table")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/tipc/name_distr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index 190b49c5cbc3e..b4ff074a2babd 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -283,9 +283,18 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 	struct tipc_socket_addr sk;
 	struct tipc_uaddr ua;
 	u32 key = ntohl(i->key);
+	u32 lower = ntohl(i->lower);
+	u32 upper = ntohl(i->upper);
+
+	/* A peer-advertised binding with lower > upper can never be matched
+	 * or withdrawn and would leak the publication; the local bind path
+	 * rejects such ranges, so reject ranges learned from the network too.
+	 */
+	if (lower > upper)
+		return false;
 
 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
-		   ntohl(i->type), ntohl(i->lower), ntohl(i->upper));
+		   ntohl(i->type), lower, upper);
 	sk.ref = ntohl(i->port);
 	sk.node = node;
 
-- 
2.53.0


