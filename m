Return-Path: <netdev+bounces-307117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GQb+Bd63VGoHqAMAu9opvQ
	(envelope-from <netdev+bounces-307117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:03:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90402749981
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:03:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b="LUa/Gu5Z";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307117-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307117-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C8C53061959
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC13E5A2B;
	Mon, 13 Jul 2026 09:59:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E63E5585
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:59:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936764; cv=none; b=Tu4ZFiirbCR3mdKT4FGFhXqYmT8/vlcG7sbXKRUX45DambqRw4aK547/3TMHW6cNYoVTYqgoC2ESkMrvf8MFEVfbl02XkmBtRNvlHzNO+9LaVkPHwya9PmUlPCIyg3m1Q0m8q3AtF8HlI2tQvjyoMHFFeKzihdzWTRA4vtE/W50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936764; c=relaxed/simple;
	bh=LA7wMZh7wJW7zKJdgEo3kzYUfAFMoTptp6YhxtUQJcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POLTYhpILYYBt2/Jpng256IOyeH40qNwAYwxmSrdfBAWUBfxBQvAud3Gy9Ra4KxFmpWbxFOBOC4+7+t+5t2IL199/KDYdKxiupfrZiqZb2ewp4YSIZUY4FwQ8JQVNESllFnNW12sJe3aZgXxpJGiFKjePAG/LLgyoLU1cJTXJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=LUa/Gu5Z; arc=none smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c1805b8a7so29876721cf.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1783936762; x=1784541562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hs8qr6RQnmSpKBHIaxXg7wFtv+zX+5SylTG991lre7o=;
        b=LUa/Gu5Z0UVW9aZ8Jpz8/b+NV0/eoLRG0rQW7D0/u589VSrlz6O0K41WR9ABdezT8i
         UqIKlft/nFeNNV0BO01TEC5auY3zXWpCRM6gSmIqpR5wAQO3WtIacTpvjOldoyzH+SlX
         P9vD0OMeovfEwpW6w5FDH/BIBUSrKq9qhwxTLziZLw6GRe7qLZE0N1IqkF2zqE8uM/yH
         KVQ3PNUNlI4UeUuqn9QDgRpUtRMFrdIXnnSFzc/Nq/cTB3XhTgmhwhAHDAeV0Pn1aKbb
         FgBsMFOESSDlLQnX99Rqy+d9A34FpBjZIhFYPr3h6v2FHK/9P/OwLxC/TzE1etFjXQfY
         vcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783936762; x=1784541562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hs8qr6RQnmSpKBHIaxXg7wFtv+zX+5SylTG991lre7o=;
        b=U+oYBcDmgMsXIlqmM/q4Q7P+WNGaoRwnc0P3UIaJzYXHe23JAC4eqacXs4Vbh89cZ/
         RS3VY4IhRAdysPqYIY3MH51iP8MyYcwlP3a5ps+Dd39bOJ7auYaBa083KCUZkgIRGCS7
         ftHBmD8i5xmpkMPHk8UVwzipYkL9OAUgkXtC3CrA0mowYb/M1SWiwSWh8o5iCa/PYj5l
         yt3DhHRqLy812kkDennljUvk21Numl1uLg7XNzRQfyHj39RPlAjiY1GI1bwcmgKfxNlY
         1b/ATlku2LrjPu+W4kzJydVMCUT+W/u6tU2ZzeP+cMyHnZJfIqrLyCsxDapAIiMYPQY5
         intA==
X-Forwarded-Encrypted: i=1; AHgh+RqM8jcglNniZCvNmduLcjZhgsEjMw5QYhIZ5lGTU81fkJs/vnpR1ZPofIMwRoe4VcP4MxjbS0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIw1VEbgB+bgORJur0LpUyJ/d8jH6h2iPeVmP0RTplTR0lQajq
	sfQYWCKffjgTR9j8jxVXzxEbYOCLS7EXW1fMMvOYluYB/Zv4DEDWfqOVjtFbMcc5b5Mkd2tCAlo
	yPPfn
X-Gm-Gg: AfdE7cnBNS3f/RyRs9SPv6L7adJDOq2OKK3rUlG4ohkUs3YUtnh1vbL1ArvElCSFU+i
	bzQ4rOf7Phk5xbT9T6NOly+keJmJXMTZgZwctPNYvIo6fVOoNZ4EO1OPJINtTdqzplI/JiNg7Bb
	sgvrtP/odD2BIJUpOlD/xQafg+vD4VPLfMGPUL47lvjVwfZaPARRW3V0s8Ru3bx1vh/AEnLRaG+
	Zi5iwn+aygwmTC+qy5V0K/PMKmZw8uluHtfBV5Zh1XKFf2RE7oHiX/L6hlVfMjrDwjUoeiFfmHn
	oJSC5r511kWcPVtQ1jOR+F3pJBy2L/PiCInzxcmiQenwfBByW2/39gqOCtVPDm+oZLCNV64g8va
	gYheT0T4x+99e+fu1oRbgAp3i6f/IpznLr41/6knR9qJFf+SoWLy03fJNcx9Nug7v88SpXiAO17
	9yOdt3ONpuTGRQ8zEQNgBy6dNSjOXm
X-Received: by 2002:ac8:7d0e:0:b0:51c:7b12:5fd5 with SMTP id d75a77b69052e-51cbf349147mr86478831cf.81.1783936761618;
        Mon, 13 Jul 2026 02:59:21 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-51caae20a40sm80619171cf.15.2026.07.13.02.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 02:59:21 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: David Lee <david.lee@trailofbits.com>,
	Florian Westphal <fw@strlen.de>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Phil Sutter <phil@nwl.cc>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: ipset: do not update comments from kernel-side hash adds
Date: Mon, 13 Jul 2026 09:59:15 +0000
Message-ID: <20260713095918.173450-1-david.lee@trailofbits.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307117-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[david.lee@trailofbits.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:david.lee@trailofbits.com,m:fw@strlen.de,m:kadlec@netfilter.org,m:phil@nwl.cc,m:dominik.czarnota@trailofbits.com,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david.lee@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,trailofbits.com:from_mime,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90402749981

mtype_resize() copies comment pointers with memcpy(), not the comment objects
themselves. During the window after an entry has been copied but before the
table swap and backlog replay, the old table is still published for
packet-side updates while the replacement-table entry already holds the same
ip_set_comment_rcu pointer.

If xt_SET --add-set ... --exist hits that old entry in this window,
mtype_add() calls ip_set_init_comment() even though packet-side adds carry no
comment payload. That call frees the shared comment through the old entry, so
the replacement-table entry now holds a stale pointer. When the queued add is
replayed on the new table, mtype_add() calls ip_set_init_comment() again and
strlen() dereferences the stale pointer.

Fix this in mtype_add() by skipping ip_set_init_comment() when ext->target
marks a packet-side add. Userspace adds still update comments, while
packet-side adds can no longer free comment storage shared with a resize copy.

Fixes: f66ee0410b1c ("netfilter: ipset: Fix "INFO: rcu detected stall in hash_xxx" reports")
Cc: stable@vger.kernel.org
Signed-off-by: David Lee <david.lee@trailofbits.com>
Assisted-by: Codex:gpt-5.5
---
A reproducer triggers a KASAN slab-use-after-free in strlen() from
ip_set_init_comment() during hash_ip4_resize().

Trail of Bits has a privilege escalation PoC for this bug on a
custom kernel, which can be shared further if needed.

 net/netfilter/ipset/ip_set_hash_gen.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 8231317b0f1f..b2d77973272d 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -1005,7 +1005,7 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 #endif
 	if (SET_WITH_COUNTER(set))
 		ip_set_init_counter(ext_counter(data, set), ext);
-	if (SET_WITH_COMMENT(set))
+	if (SET_WITH_COMMENT(set) && !ext->target)
 		ip_set_init_comment(set, ext_comment(data, set), ext);
 	if (SET_WITH_SKBINFO(set))
 		ip_set_init_skbinfo(ext_skbinfo(data, set), ext);
-- 
2.43.0

