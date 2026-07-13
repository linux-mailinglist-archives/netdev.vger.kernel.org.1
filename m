Return-Path: <netdev+bounces-307242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 17/+H98PVWocjgAAu9opvQ
	(envelope-from <netdev+bounces-307242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:18:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F035474D81A
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:18:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lsivhO4L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307242-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307242-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41B6B30309B8
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5134E409624;
	Mon, 13 Jul 2026 16:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0D339872
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 16:18:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959488; cv=none; b=aRWO93rqTHziCCr0Fr0MTaFXpjkiX9/Z5zNe2YPKibACoZgtjlTXVlt03IV07Bzn6G7zbggDIBr12JXxw3NYaL/G2NbvYi+HGMbfVNVGBi0CHFOpMVihOEibDOt+DeLEM2uWq9kriDT4RvbiT8DlQmF3feKPafgRutBpL812Puo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959488; c=relaxed/simple;
	bh=tGG0MiHN5UuJi2ociiaK6WiVbWCScdsB+jhAN+MFscQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CauDdLpCYuMQnYezAV882y0Bn5tOi3/oYo5NNLef3wUgyFMuL2+Tz31aeBBaK/eR2SsmVpNNgfvIr8PevJOpJ6S7ZY++gabAN+5+AxdI7ABV6RVbaFZ80D878XrRyOAy+jN4aSg1shbOb49uGovdybS6XpGx6O1NCf2hfvdDNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsivhO4L; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848743155bcso32860b3a.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783959485; x=1784564285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gC15aP2K1fPrSjv7xk93lFLdSIjrxFOeu3cF6pP3adg=;
        b=lsivhO4LBOM5Nhbaonp9n+St27MCZMo9bAjhWVroii5p8C00WXOuktYah8qzD5yRHy
         Us2fDKfnbyk+OywKaZz9ZMFqc6pn9cvIcJv7addycGgTeFnOVPF54cpzm8ywV0ebZyZ6
         eCNMIO6pyyYx0K2YlYMv3X1npmmGnQvxUmcr0edGXlbYLwT2enMvTBLdjKimJpI9/rBJ
         CX12HcSACJS6Ga5uni1heEvaDfl1CJHiqqi/NCKEl+wA0FV03xU04qjRQCHFw5Pp1Duy
         37EotHlmGD+KrK0glX2Ce6wkZDCtzB6h+KkBRMCPn6gpSOB92h/iGFdAmlrLYZXT3VNA
         R1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959485; x=1784564285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gC15aP2K1fPrSjv7xk93lFLdSIjrxFOeu3cF6pP3adg=;
        b=NmoKiaFvDfyhvcg8cYBZMUSILs2JPpnwGC+yAXVzIAj1Jyn7tYn1eFO7ryPSNcjUBY
         sLzPYFC3nuQv9IDmvRJy2pCWJflZbr0eklhGWZOJLFASvODilffhCe2NzZUXyCIYXs3c
         0WjE33GvYxquhykX+Oeuw90Ax0f7XHSM3JNZfZBK6JcWdSpwNm37WfMizRqYTcO+ZV/2
         w84K9HTiWk/mwSwcbBA5kYeKGouHbgBwqQm4ERrnA/Lsb+1OpU1SNRzo63+spoE7A+VI
         5VWAXhPpRTU6aBmEJuu5FyN8v1efpMcvPKzsxH11MxyvqY05wGRQdFV8kwv+0kKGagbu
         eKSg==
X-Forwarded-Encrypted: i=1; AHgh+RqS3rwBj9XgLgZAelhg1hQGphygPWsxfXyGvPlK48KxJXOYPdnxVQ+PP5HN/zMjHcDQf4YDOxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQTtSm3q9XtSbhRn5UtJi3Bz4cmtQ6MAm/XHYkMot4+FohT/Ma
	Ox9FWq6EWrX9n5tXpWzZUND/gcdQ0G+zLa1TTzwYeVBrsGpGnk4G93Ua
X-Gm-Gg: AfdE7clQC/go43xlDB238cranAeeIeRIl7DWlZtjCQq7elIQ4ZzJMJ2D2ky4l0OoL8w
	JYcszoRdxHK4T0b4+xUsfmC5kkRTXK9fb8U5tD0HwMEVsmDIoFj80aE6s40z5+2028aTOVpJed5
	T24sw3F9fIQD+T9JnhiRAIBKYxrpZvLu2TNvcD3wR+3b3vSROB1CGBB/9YGnAELwnAULNJ7W+DL
	uE/0PeO2BUE0yhAfDlOErYTktnFrak7wnM9uJDy9AiwYDJ2DPKLml1fPAi/wb+cZp1kWYDo7nib
	Ycs1aFApGQX/OtYBuusn3ZtUd53Re5JF1Hi/lxY8Btq4PpAOgFrf+Do29n3o+Jf+zFaJc2UJAVT
	RxnbPevXHeyACFguqmh2mNOD5zncdQiAYNmFPAPM9r9+6k9ZXWgDxfb08uNgRB26AezoOXBO5RT
	Taed8E/Ew4VEzCTeZbuq4NDYrJBVTjp2Fo9bsP+YqsUUN5u/mLJQ5xqSPOgQ==
X-Received: by 2002:a05:6a21:4cca:b0:3b4:8a40:85ed with SMTP id adf61e73a8af0-3c11077686bmr9741481637.7.1783959485390;
        Mon, 13 Jul 2026 09:18:05 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313cb804197sm23026406eec.13.2026.07.13.09.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:18:04 -0700 (PDT)
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
Subject: [PATCH nf-next v2] netfilter: ipset: skip extension destroy on hash resize replay
Date: Mon, 13 Jul 2026 09:15:28 -0700
Message-ID: <20260713161527.3529006-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <PASTE-JOZSEF-MESSAGE-ID-HERE>
References: <PASTE-JOZSEF-MESSAGE-ID-HERE>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,asu.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307242-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:kadlec@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F035474D81A

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
v2: Rebase onto nf-next; drop the second hunk (already fixed there).

 net/netfilter/ipset/ip_set_hash_gen.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 5e4453e9e..bc909ae2d 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -1080,7 +1080,9 @@ mtype_del(struct ip_set *set, void *value, const struct ip_set_ext *ext,
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

