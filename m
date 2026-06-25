Return-Path: <netdev+bounces-301877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A0uhIRrSPGpFswgAu9opvQ
	(envelope-from <netdev+bounces-301877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:00:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E90BA6C32F3
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:00:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="F9gQ/lq1";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301877-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301877-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC1DF3059016
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 06:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583D33C10A2;
	Thu, 25 Jun 2026 06:59:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE943C1978
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:59:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370788; cv=none; b=tSyQgPUu1g+h1U9ch3wtuSNBRnoBRQV5JF1cyfSCE9xmSXFt2sIiI+7BLuxXSRe4pkNesCcRKfkzo8DzgjIUPPN3jInImahFWUVLHHlOvtyaBOruC3DgphZ0BwRrcZ4U6dQyXp4wGJy9b/u33DTWFcIIBj+vv1ttLeenUlsiPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370788; c=relaxed/simple;
	bh=1OOLcsiFIR2dlSrE2K2e68Js2IG3OWAvrChBc7nDB5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mp+1+Tn8A6KME8QZY0KyNQpzIheNLUoqeB8i4cPyPDlByM/ZZ8W4wEbBeM2DACUDdq65G7H4ykSFePBYcVmaSrKSD1JzAdtAhEjkepJqLlr37aqSNNqSpQMLzdhrY+yGj99f5WmbQf9J25v9hh3LFW6GaA3c96dGGKCGPqmd0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9gQ/lq1; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-9157c8eb597so246728285a.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 23:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782370786; x=1782975586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfSV75fuPRCXtAVkDrt5T5e++jPy/e4MJCZJQmSabwE=;
        b=F9gQ/lq1uzd//QV4Pkgbkd1MNNV6fOCghjReVpEU4iIaiEiGmOvG1hRSWRSImz8EyP
         iljd6El1Vkb0UOBhZydaeh5aLoiQ3lbaFg0I96LRHi+Ydo/sG0bKeQbN089b1m1rphXT
         PVwx+JZV/okYnnxARhMWKVWzZZjxQ3rnSmfPut3xucDVsYYfiPl9Qf1KozyAm0GjHAYL
         V7qRcm31QNvA0ES1KP09szONM8hns8ZtYIbY/mL3TraQBS218ewi/dQWcwT/5VoB3XMO
         VQ5IMVrqdbffpLMPazaJjKozsIXjKBpHFfpVzjZGhRTBZi6WCY8ODSPognixmpQCCrBL
         OFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782370786; x=1782975586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfSV75fuPRCXtAVkDrt5T5e++jPy/e4MJCZJQmSabwE=;
        b=JZA5Kz5nMIpSgNSLUKN6Dm5wAFX6pvBfV4XGr2639mlw3iEsGm25Fwd85IFom89tHa
         jBj8O684r57Vo31XGln9zqBNbHwex0M1MBP8JOvpqGRBPZZhgnNAUSsTrPwtlYPP2VXz
         aKAvVw7VVGAv+GABHySD5jDcenM8irpZkiKVMUHM61hcIb8ka2qdrQSKPXHYWgKO7gVX
         blBWF+7TXymV81Kl4SjnSOzWbLN+i92C7J/eUaITosgXmZEIsrNUXpvaIn6pBeQHsM4K
         F6GC4l0vTHQtq2W6tv68qTyRHftTlqKEKpRuLqnEfn06CNYPQBReRTOzsbql3YBf7leJ
         oNZw==
X-Forwarded-Encrypted: i=1; AFNElJ+iCgYy/PuyWPs1fBRhpLsE09M+q6r/2KlQGpdP2pwxdxJBR5w6GZ0IqaRLD/Iu0BNH+rRjPYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygpyEAWhWzArel5JnWI9fNq1leRFaCKxzlaCWqusZsOhj4CnA0
	+gsEVPL2wV8wJ5TF36zkz3/XBFu/9gBBe69L/VJb4oH8U7EB3qpxh92tlXfecaJcRmAgQU4+DnZ
	nVozAJ/BcB9hsfQ==
X-Received: from qvbg7-n2.prod.google.com ([2002:a05:6214:83c7:20b0:8e5:cdac:f728])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2544:b0:915:8988:4e55 with SMTP id af79cd13be357-9293d9b5073mr156329485a.40.1782370785700;
 Wed, 24 Jun 2026 23:59:45 -0700 (PDT)
Date: Thu, 25 Jun 2026 06:59:38 +0000
In-Reply-To: <20260625065938.654652-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625065938.654652-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625065938.654652-4-edumazet@google.com>
Subject: [PATCH v2 net 3/3] net: udp_tunnel: use atomic bitops for missed bitmap
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yue Sun <samsun1006219@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fomichev.me,vger.kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-301877-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:samsun1006219@gmail.com,m:sdf@fomichev.me,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E90BA6C32F3

The 'missed' bitmap in struct udp_tunnel_nic can be accessed
concurrently:
- Writes (__set_bit) happen in the port add path (add_port), which
  holds the RTNL lock.
- Reads (checking if missed is non-zero) happen in the reset path
  (reset_ntf) via __udp_tunnel_nic_device_sync(), which holds
  utn->lock but does not hold RTNL after the blamed commit.

This setup creates a data race between concurrent writes and reads
on different CPUs. Fix this by using atomic set_bit() for writes,
READ_ONCE() for the fast-path read, and WRITE_ONCE() for clearing
the bitmap.

Fixes: 1ead7501094c ("udp_tunnel: remove rtnl_lock dependency")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp_tunnel_nic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 840be5d79fc0ac3142049dcb9f1105a5844da9ae..9a567a87635caaf76f5b88029a7f28a65c795efc 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -147,7 +147,7 @@ udp_tunnel_nic_should_replay(struct net_device *dev, struct udp_tunnel_nic *utn)
 	const struct udp_tunnel_nic_table_info *table;
 	unsigned int i, j;
 
-	if (!utn->missed)
+	if (!READ_ONCE(utn->missed))
 		return false;
 
 	for (i = 0; i < utn->n_tables; i++) {
@@ -353,7 +353,7 @@ udp_tunnel_nic_has_collision(struct net_device *dev, struct udp_tunnel_nic *utn,
 			if (!udp_tunnel_nic_entry_is_free(entry) &&
 			    entry->port == ti->port &&
 			    entry->type != ti->type) {
-				__set_bit(i, &utn->missed);
+				set_bit(i, &utn->missed);
 				return true;
 			}
 		}
@@ -488,7 +488,7 @@ udp_tunnel_nic_add_new(struct net_device *dev, struct udp_tunnel_nic *utn,
 		 * are no devices currently which have multiple tables accepting
 		 * the same tunnel type, and false positives are okay.
 		 */
-		__set_bit(i, &utn->missed);
+		set_bit(i, &utn->missed);
 	}
 
 	return false;
@@ -718,7 +718,7 @@ udp_tunnel_nic_replay(struct net_device *dev, struct udp_tunnel_nic *utn)
 	for (i = 0; i < utn->n_tables; i++)
 		for (j = 0; j < info->tables[i].n_entries; j++)
 			udp_tunnel_nic_entry_freeze_used(&utn->entries[i][j]);
-	utn->missed = 0;
+	WRITE_ONCE(utn->missed, 0);
 	clear_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
 
 	if (!info->shared) {
-- 
2.55.0.rc0.799.gd6f94ed593-goog


