Return-Path: <netdev+bounces-297807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DxxMJhG7KWrncQMAu9opvQ
	(envelope-from <netdev+bounces-297807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:29:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D093866C827
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:29:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=uIw34r4q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297807-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297807-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0D6831944B1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2D73750B6;
	Wed, 10 Jun 2026 19:29:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578CE374A1B
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:29:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119745; cv=none; b=k9jkkvyF5Jw/t0JfA4v+I/MgymJ5ZjGySvuOQWWgVkefKC/wGvGgllFVpB99g9ayr/op1dd0fQJOAXwT8CPm+kRlWdbuAL++a4GwFfD/DTIGTxBrbjQybzAoOfKpA2kZL1mNvTmeJtrqwq19GDqyjyWFAYI5XPLZKMpt+iI4dHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119745; c=relaxed/simple;
	bh=UXjsMRBIGtnENR76PmKsSOXCNBZAvU4wJVyztGxqb44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1qc03ft8NCfGl1nfqyMKLZu43Wp2R+ax0XWjAJOWDpl05RkjehcFln968tYY6o6k4vX0F/oJl8B+kTYhw+FjzIKm8OZ0NNJEpZ/+Hzy/TV040jj3l4S1j3ZeGF0P0vlUwtFzFKgoy/acleUUpgoXRTDJ0+7nlRjdgHEqfYMsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=uIw34r4q; arc=none smtp.client-ip=209.85.221.174
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5a7c7e13b84so4002487e0c.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781119743; x=1781724543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dyTk5P2i9L+atMfkkVoon1P3jPaWn6qDjhn8VCypaz8=;
        b=uIw34r4qzn5GGfeO94yIauhOup5ZGdyNj8FmR9vPcK/fIVceOXN34BKZHvfK6Me8RZ
         Yzas2m5jw0ezsd6qyCnzV0C5cYeHR8yIcKdw0tBkhNmDb3WxLMyHB8eNKvDfBPwFhOkp
         J4DZy+NBqP0ltz8W2gyXzsAvzGIlvcQYbhu+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781119743; x=1781724543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyTk5P2i9L+atMfkkVoon1P3jPaWn6qDjhn8VCypaz8=;
        b=PX9NliaSDc1eZn/NuTRe+oz4w7xeKtWqash/66A2vhg83scEQ8u+IefqJiNMV43Otu
         L0RM/Bcb5UvGv+L3zoOb1hyYHEdVQ7jtTWtPh848vu7hSqKXpQT8VkDICbOXpAdnL4Ym
         aLxai0YmQgqmYzxVDrZy+3oCj+4WNAQbz3L2ZDlYPaDwQP0S+6Z9mQj+xn1ljIOUJHcY
         UobASzcCv+kpTmvTq/T1OgBDAqFB/BeSHWW2NBojEGeZQx42wNuj4F7SbZY+oBwyP42N
         cOSmlcH0QcAH2WNjVu849VMRfdQy0VYWelJvJ3PJiJhhWrRygryLrEqtBsaejYj5wd1i
         ZDZw==
X-Gm-Message-State: AOJu0Yzywr0TchFUlF0eccaNyqwISjhGKcQyV92yZ8Hzeh2QxVwFc9f7
	j6fBMfm9J7SxWCdjPtuvb8OclVCbG4K/zfAcYpH9vHySSccSE77vMKsc72AekK0ut+xjnHzrlNw
	yXfg/dw==
X-Gm-Gg: Acq92OFW9pxfKe4C4uE2VRWUvQ+1lHjONB4hGmqKtbUTtENueS7uCUGXiwWfwBhdLp9
	8fiQtV5RdCnH3SPblxykUJBr4bCjeNhqOIzdB80RB4HMhQSbJ5gu0ZV6PImcjCuvYy4h8P1jK2/
	Fmkw5rO5026cVHYc3J6d8H5Qg+VYAKf9D6dtAMkDXFUHzNLeEL07G0WpgSxMat7lcdZpk61Xsvk
	Z85ynR5nHHNxUTqDa5R7PbhzhIkDVSJJ91ygKCooh99A6x5jNioeKgooXtnP5okoeAEhevPLfYU
	6HYT2PikrbWznWGVSLB4jrOWUIjtGNP1HZsQcq/z7E0dTWUmmZH7ozbI8xA00kmqravVilL1nvJ
	lS4oJItKCBUB5H96O+k2moXPQPp4wvXYoBdCeBcBNX/PCHAN4CiytNqj6Ov/D+CySD7XhI9zBXl
	nXtnh+bJzoeDF2jG3tL1Gif84DWoduf0nb4Q==
X-Received: by 2002:a05:6122:1796:b0:56b:579c:82e with SMTP id 71dfb90a1353d-5ac4e3c9db7mr15678614e0c.5.1781119743096;
        Wed, 10 Jun 2026 12:29:03 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6dc3d3fsm21848563e0c.5.2026.06.10.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 12:29:02 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	anirudhrudr@gmail.com,
	pctammela@mojatatu.com,
	ij@kernel.org,
	henrist@henrist.net,
	chia-yu.chang@nokia-bell-labs.com
Subject: [PATCH net 0/4] Avoid mistaken parent class deactivation during peek
Date: Wed, 10 Jun 2026 16:28:51 -0300
Message-ID: <20260610192855.3121513-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:anirudhrudr@gmail.com,m:pctammela@mojatatu.com,m:ij@kernel.org,m:henrist@henrist.net,m:chia-yu.chang@nokia-bell-labs.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297807-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,mojatatu.com,kernel.org,henrist.net,nokia-bell-labs.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mojatatu.com:dkim,mojatatu.com:mid,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D093866C827

Several qdiscs (fq_codel, codel and dualpi2) may drop packets while
peeking at their queue. When that happens they call
qdisc_tree_reduce_backlog() to notify the parent of the backlog/qlen
change. The problem is that they do so *before* reincrementing the qlen
that peek had temporarily decremented.

If the qlen momentarily drops to zero while peek still has an skb to
return, qdisc_tree_reduce_backlog() ends up invoking the parent's
qlen_notify() callback even though the child is not actually empty. The
parent then deactivates the class, while the child still holds a packet.
For parents such as QFQ this desync corrupts the active class list and
leads to wild memory accesses and NULL pointer dereferences (see the
per-patch splats). For HFSC it might lead to stalls [1].

Fix all three qdiscs the same way: only call qdisc_tree_reduce_backlog()
once the qlen has been restored, so the parent never observes a
transient empty child during peek.

Patch 1 fixes this for fq_codel, patch 2 for codel, patch 3 for dualpi2
and patch 4 adds test cases for these 3 setups.

Note: Patch 1 is one of two fixes for the stall reported in [1]; the
companion fix is "net/sched: sch_hfsc: Don't make class passive twice",
sent separately.

Note2: A possible cleaner fix is to create a new helper function for peek
that only calls qdisc_tree_reduce_backlog after reincrementing the qlen.
This would be called from the 3 vulnerable qdiscs, however we thought this
might make it harder for backporting so, if people agree, we can submit
this cleaner version to net-next after this one is merged.

[1] https://lore.kernel.org/netdev/CAN2cbVe79oj0O9==m4+4x3v+O+qzRagA=2=wkrp9i9=CqYvyZA@mail.gmail.com/

Victor Nogueira (4):
  net/sched: sch_fq_codel: Do not call qdisc_tree_reduce_backlog during
    peek before restoring qlen
  net/sched: sch_codel: Do not call qdisc_tree_reduce_backlog during
    peek before restoring qlen
  net/sched: sch_dualpi2: Do not call qdisc_tree_reduce_backlog during
    peek before restoring qlen
  selftests/tc-testing: Verify child qdisc will not mistakenly
    deactivate QFQ parent

 net/sched/sch_codel.c                         |  48 ++++-
 net/sched/sch_dualpi2.c                       |  41 +++-
 net/sched/sch_fq_codel.c                      |  41 +++-
 .../tc-testing/tc-tests/infra/qdiscs.json     | 184 ++++++++++++++++++
 4 files changed, 305 insertions(+), 9 deletions(-)

-- 
2.54.0


