Return-Path: <netdev+bounces-304689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rbRENrimSGo4sQAAu9opvQ
	(envelope-from <netdev+bounces-304689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 08:22:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 743F1706DC3
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 08:22:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aY66fWrH;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304689-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304689-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDD6D3019499
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 06:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD17E389DF0;
	Sat,  4 Jul 2026 06:22:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC261D5174
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 06:22:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783146163; cv=none; b=djg3/DGTnYPriwDG0qeVAKcCcLVhqf6FBUKmLqRfSrjvbLXiQlVdrdS+s5+z59FhB/ObjKjm3qOOAwTUOeQPy9RYaMs7Iej2ZyXmRylVCoo/6wcdPu42bo6Z6Bxlt9iA7HA4IkOjVEMrHSlQ7iRbxPzmNWwRgZf96g7d2C/cWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783146163; c=relaxed/simple;
	bh=PnJrAFYi+mj1ieNKLV2GXIZw3gO7mdCTwfIOv48ITqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLC0JqcRyVrPgQSDK6/o2IsYDyNfmdOR4ifn7khQuWQUf7IZWuJX9wQAm/RpW9dkfVJdzbdkGNWUARt1pCuR3zHlebQywvSFnHCF1ibYv2Qp5mHu/c1u+j5lwJnUwzKHFRCzoqnQ54q3fNe9+ZnknmHM7HBQdMRvU/40Rz7ZszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY66fWrH; arc=none smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c96c92c0980so636347a12.3
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 23:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783146161; x=1783750961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q6Y3yMjx6909BBBSsLtnHC5GrGrYvCid6v9Tt9MQtbg=;
        b=aY66fWrH/A0Lz1YSnOhkTehXX6xaOSlCmRsfhgIrFwnw6q1SGuBnl2eMNEUphg8ts5
         0umS7/ynuDFzRXalHs+8BHFtknhdHPbMQh3gCSgeTuIrlY91V+oXa05/k0T9A96+7K+L
         4xb+v+frU+LicBtc5U98rL8O4JsDi5iqFDskq+rv0ExB7vQ6bKTiSuPS5j5N3iBUsl6D
         TZ6mZ6Wi8FA6I9JjMcM7hvtruuFc1J4jYyb6db7cQ+ZIQZalRssiKSg9ZA0XupPjLWnz
         mZnvpHSi2cG2g1dRnNu/hdqNmdx93AMJfxU/zle+oPCKUBQpYnLGhCouB1hRoQBEp64U
         sz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783146161; x=1783750961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q6Y3yMjx6909BBBSsLtnHC5GrGrYvCid6v9Tt9MQtbg=;
        b=ftPSsP8rzz/49wSYwN2aBunny6yhEniiUgeeNSp/5db7FPY5MseDfQFxyPMsV2dkZ4
         wQGD1doAt8D6ahoTkHj6CbMShj7Sc6nLKsHWbjVO9U53NHItSX/lwfruf52qFhxW0/Mk
         /LNQhFmQzMz7fXvYrsMRPm+jT952dI0PP55RPj/RnL8jqMjVEb93/53HerPYaOqsGMS1
         30rzqHiwq8iS0bBCuZEV3DmxpqkHFyqFM+ib71kE3MspVaKCDy+nI+hZiI8Re0GSf8vI
         SM7iBE1L85jDB651GlnC8x+T6wUvl0pWV95j8NCaOaSjBrtNuJGHQ4M9kkOGC+UK0/BS
         lkOw==
X-Forwarded-Encrypted: i=1; AFNElJ86PJRS/b7mi8Dasl8GBtvklEk1Wr6gpWnasr5x9clWc//ZCs6DJpqu2UJTjenCL+0k0xoBdnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yan1JIyE7v/zBRVZIg7xZM1UwZ5MVuusaiZQGGlGQurVt9wL
	oYkIg15rBqknJo6xc3KgW0DanBEqZMmlDsvqlecJtZKEcC54Tpw3J2fi
X-Gm-Gg: AfdE7clr9c3U9+H5BOX8tY/Ugt2nTeL6CuX6PGLArymsfS4D80NI7J+oqRppJQLhO3p
	MJRBLWa2xQ/ubWgzStHzFal007jx6rI/hEk4IP/rE+ycoMv+08KZD7MiVEkauYPVx2hnXb02l0g
	Qv3FHkLoZyma4w/rl3ERP6Zil76bKRiHIedFELSiLc58hAsEN4SRRWzQGdtftWU7zr+3O/1V0LQ
	kgZimPRD08qnpDwsTT0CyFSOEYyELUED572lnrH7nhBnx4+9G6DDOgEbH2WE9vXob/AIPrmrtoP
	bn99O8mhQEplfDoJSy0mYb9eA2IRwh2ewrjQEW8QMCMNK+DhAMYCafiUR3yRZPZ3YfwBDFgztfJ
	Z9KoFc77TzNF/GexDHpdduHLlw3Y1CvzafpJBeEY2SyGO17rpWsPgHBaR+y3C9oydq+mRLu0oYL
	w7XvvoVDQID19jb7CTOdOgE1julfFUI20ot3ZSXLdknPc0SWMTVrEo1Fy4Qg==
X-Received: by 2002:a05:6a21:390:b0:3bd:4698:e7c4 with SMTP id adf61e73a8af0-3c03e5747ccmr2328719637.42.1783146160612;
        Fri, 03 Jul 2026 23:22:40 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f44581df4sm3898287eec.16.2026.07.03.23.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 23:22:39 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH nf] netfilter: ipset: skip extension destroy on hash resize replay
Date: Fri,  3 Jul 2026 23:22:34 -0700
Message-ID: <20260704062234.2625208-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,asu.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304689-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:kadlec@netfilter.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 743F1706DC3

During a hash set resize, mtype_resize() copies each element into the
new table with memcpy(), so the new-table element shares the old-table
element's comment extension.  An xt_SET delete on the old table during
the resize destroys that shared comment via ip_set_ext_destroy() and
queues a replayed delete on h->ad.  After the table swap mtype_resize()
replays it with mtype_del() on the new table, whose copy still points at
the freed comment, so ip_set_ext_destroy() frees it a second time:

 ODEBUG: activate active (active state 1) object: ... object type: rcu_head
 WARNING: CPU: 3 PID: 5311 at lib/debugobjects.c:514 debug_print_object
 Call Trace:
  <IRQ>
  kvfree_call_rcu (kernel/rcu/tree.c:3825)
  ip_set_comment_free (net/netfilter/ipset/ip_set_core.c:397)
  hash_ip4_del (net/netfilter/ipset/ip_set_hash_gen.h:1098)
  hash_ip4_kadt (net/netfilter/ipset/ip_set_hash_ip.c:96)
  ip_set_del (net/netfilter/ipset/ip_set_core.c:813)
  set_target_v3 (net/netfilter/xt_set.c:412)
  ipt_do_table (net/ipv4/netfilter/ip_tables.c:346)
  __ip_local_out (net/ipv4/ip_output.c:119)
  icmp_push_reply (net/ipv4/icmp.c:397)
  __icmp_send (net/ipv4/icmp.c:804)
  __udp4_lib_rcv (net/ipv4/udp.c:2521)
  ip_local_deliver (net/ipv4/ip_input.c:254)
  ip_rcv (net/ipv4/ip_input.c:569)
  </IRQ>

The replay passes a NULL ext (the kernel-side delete that queued it
already destroyed the extensions), so skip ip_set_ext_destroy() when ext
is NULL.  This also avoids the NULL ext->target dereference that was only
kept safe by the new table's ref being zero.

Reachable from an unprivileged user namespace.

Fixes: f66ee0410b1c ("netfilter: ipset: Fix \"INFO: rcu detected stall in hash_xxx\" reports")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 5e4453e9e..bc909ae2d 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -1080,9 +1080,11 @@ mtype_del(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 			mtype_del_cidr(set, h,
 				       NCIDR_PUT(DCIDR_GET(d->cidr, j)), j);
 #endif
-		ip_set_ext_destroy(set, data);
+		/* On a resize replay the extensions were already destroyed. */
+		if (ext)
+			ip_set_ext_destroy(set, data);
 
-		if (atomic_read(&t->ref) && ext->target) {
+		if (ext && atomic_read(&t->ref) && ext->target) {
 			/* Resize is in process and kernel side del,
 			 * save values
 			 */
-- 
2.43.0


