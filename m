Return-Path: <netdev+bounces-307249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MY6wLp4TVWrojgAAu9opvQ
	(envelope-from <netdev+bounces-307249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:34:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C26D74DA60
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:34:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MJqBkbip;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307249-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307249-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8A3C300B479
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA80436355;
	Mon, 13 Jul 2026 16:34:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57397330D28
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 16:34:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960474; cv=none; b=f2DHMVebXGBWYy8OoPwJ3nvJALvClXy/HEybi1M2sQtOIIoL3L3s1rGqZ6OsjFRyjvpvwY9RsfYVjyndlz/o1umoZp5NHwQjSUd7m3nseuoviTimeJ6jYx2Ey3Yo7kRzp8rk4i6aWvxp4OM37pEHj/4Qlj3uEkmsFSQ5OqdQr9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960474; c=relaxed/simple;
	bh=i2xJ03C51CJD6Lr8+AW4JJYOEHv1to9FFj52n/dJlPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ckj6JnlmbFMHHiC9Scozf8wH/H8PsTOOzK4MWrwbiwEAT8pVOQfri2Xjk+D0q+/VRnGPoiaKJ0cCAgMwMnSfe2xLcNy6ZJWhgBvPNzVW+KbKPmmZsGG0+Bqray/0EjGbVWx+19aNEe5idWbgElH2Ligak/9IqbEzX8I/BKXo+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJqBkbip; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2823245a91.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783960473; x=1784565273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RM63TYqsinly5sLCnipxpmwH364OMd0EzvumJ2wtwGE=;
        b=MJqBkbip0Za3MaR0Zx95OsKhK1bU75OK/7+yRSRE6kubuolvfDcqlh6bykbZexxNBv
         OMqyHRmtwEvHie5Qk8FFIxVeToSwJEW+LE9rUz/apZ2GKlowFvSHW+Tu1l8ydA95NXOZ
         wfMSN3xKzXUtzpnWDbqr9VzKmW0emuY7j3+WEwhPBzaZV0XAXT6XBviUKiQgZgxQLpO3
         6B/9ydbyR4cll5OewHxo02istppt009xDt/uT3juZLQa0lPVMY1H8EOIgWWjVQQcP+JW
         pPnAY+5Dz6qoi0hIbLY/W4GOO5ncnoYuIocyHiA3lt8ZiakwD3upIvHIcXKODALpgj4c
         RPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783960473; x=1784565273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RM63TYqsinly5sLCnipxpmwH364OMd0EzvumJ2wtwGE=;
        b=fyri+cKBAQ6V9hFyojGQ7RrVXNG5Zo2v0SopxV4uM1BUcQrIj2vCH1PuYcAu1T0SNB
         LOT6vMqJ0DJXO5cFH2E+6oPEiCpZRq5CiPvMsWagZwZuJfjTDLLaFezZ5DBm0awIjk/8
         aAheRmlb+u6/nYzUmQyXvcZ04teIePJzKwKX4NFnAcoi1259aY4VtHw2R+dLAaMuyoYC
         ItdjHOU4gNf5AzOuPNdbHoXYCsMJw8qwa983RiNwLZGfVbSMT5WT8MIsJw6LASR4S64o
         P6CliIRZlLgjGLh4dbYw8fe7+5X8LD+pmZXT1vEfHdFna6qc8E8FIWiHjRWP++NAZIvP
         LIAw==
X-Forwarded-Encrypted: i=1; AHgh+RoMFBvLfPJGAE1+74ZGMV9R2A10Sxn1myxk3Tq1j3nb1Ag7C2x2ybo8+SzIa+SBjb1n3S6oi98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMyonBEwU6JG9pn1myRw6VLDolDrRFmM0+OZ7kHAKPRutNy0Uy
	xTUFRJOgqsc2AlnJK62CMYxRONUwuUzJ3sIknHf6q/smLAxPCNZMfEkk
X-Gm-Gg: AfdE7cn0U1vJBIK8jYH66bMka/kDF/UdsTPAf0r9MQuX/Xf8wDPj+Kh1K8b4Wj2nUbK
	Nz4q1GiqdmqwKL70wFLFBHxZrC9OGQ6R3mwGRSGo7+h7T145L22iC9sQFingSdLL6MtzEubAjJa
	Su7Ol9YhItkCkR+cgQbg8y9SO+F+vNB4bvjS2AvvFKF1eCiqtMzZmX23EXqLuq/AtmUUbjzwli1
	42OVd3D52yRDfDkfdPza6ABz49ZyNhsOEoYDKOJF2GbzPm2sKWITo37iWmxB+EJ8lGGxfBn5HBR
	3UP183JpX2DfL6lv0Ta72ca3rioIYWHL9df3PVmR76RZxoD4Wb+G9XbBT+pmPtSmEdEipF0LyJ9
	5IZYfzPjD970/UDqLfFgMf0GTDHzBvluY9ZcxLUeDb0inPEIxsSdGhL/Eo41zDYe+P3t7TiAZEb
	nCO7hgUxq7LNcMR9hLKZsw62Buoef6WKmQqyyDBV+DAdlkQpWklmUpE3BmBwhVZNY8Qx3W
X-Received: by 2002:a17:90b:510a:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-38dc7a3e3a9mr9034978a91.15.1783960472613;
        Mon, 13 Jul 2026 09:34:32 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm81674219eec.14.2026.07.13.09.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:34:32 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH nf-next v3] netfilter: ipset: skip extension destroy on hash resize replay
Date: Mon, 13 Jul 2026 09:33:55 -0700
Message-ID: <20260713163354.3533575-2-bestswngs@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-307249-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:kadlec@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C26D74DA60

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
is NULL.

Reachable from an unprivileged user namespace.

Fixes: f66ee0410b1c ("netfilter: ipset: Fix \"INFO: rcu detected stall in hash_xxx\" reports")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v3: Repost as a new thread; v2 was sent in reply to v1.
v2: Rebase onto nf-next; drop the second hunk (already fixed there).

 net/netfilter/ipset/ip_set_hash_gen.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 8231317b0..d15530241 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -1112,7 +1112,9 @@ mtype_del(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 			mtype_del_cidr(set, h,
 				       NCIDR_PUT(DCIDR_GET(d->cidr, j)), j);
 #endif
-		ip_set_ext_destroy(set, data);
+		/* On a resize replay the extensions were already destroyed. */
+		if (ext)
+			ip_set_ext_destroy(set, data);
 
 		if (t->resizing && ext && ext->target) {
 			/* Resize is in process and kernel side del,
-- 
2.43.0


