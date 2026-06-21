Return-Path: <netdev+bounces-300872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +VBBH/i2N2q+QAcAu9opvQ
	(envelope-from <netdev+bounces-300872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 12:03:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C37BC6AA8FB
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 12:03:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AVFCCKRh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300872-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300872-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BE3F300D47C
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18365258EFF;
	Sun, 21 Jun 2026 10:03:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97F33985
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 10:03:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782036213; cv=none; b=a36O8toaZk6qxIZswGh1CRnQd0QaP0ZpV4ueX2fRhyQNP+92XmMG6k9D0wkA8A3BhKDeGJOogpXburnUBbmyOlfyYeuYmSwDWxnwSrrDgVm2o9XpabJSr3PTZIpRMj9LavIFWUJq/q7/UwFsAiwGbMs1mtezlbySEldqypNYGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782036213; c=relaxed/simple;
	bh=QqJNJYwIJcie7fqBqyRXz8QpehRU3AvMFP5BwdT7zUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNd+qVnqcjLbTFyzpFiCQNnBMoV5vVPqpYiUViIkLuLk23mi3hb9o4dmhUpepJkEqinPtNod9ua/ZuMlooWh9jJLz3iSshqSBeGOfD24Bt23qWInfuqd7r3Y1DdMHXYizvSo4nzOPMMZVY9x69Gt8dmg1sup0w+GffX6kfGT5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVFCCKRh; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49222b6e871so28853305e9.3
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782036210; x=1782641010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1jsygsKflHtT8Dpii+LPgGirHXn0vMlWJSTFYM1FeQ=;
        b=AVFCCKRhNmaWTqGetoqrlbZOtHwFPX0yno2n+yO8YlojgWskvO27LfS+eMouwnZyyu
         ScI1e6olNTUwFEgwWtX7+Xd/5svRz45o5qyugzVDCkPWUHOxXmjWvqBiHsy55TYhRUqL
         kmyUT1pdkZNg1r70Ih2xWKW1NlfuVfMdgvBXr/1q5tdFKVKxDR0s8oHZnzs5KVYhWPov
         JQQC7oMg5tMjORoJ++ksvVjxvyQZhtEbktnZXBwV80lid6ZNqbloEHhltE11CZit6LCj
         tQe1zSLe6PaiD89ID+HwXAQvdEjutTKJ0l6ROJqj8yTVY9lR4fnhi6gOKTUDh29cCc19
         ghBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782036210; x=1782641010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S1jsygsKflHtT8Dpii+LPgGirHXn0vMlWJSTFYM1FeQ=;
        b=lTJMNuLKc5zsj75IWdQxz3EvkDL4GhqGc6O/ysm0Sv2hNxivKgOUH3q9nK2U7MYOQv
         7ILC0yu71A1nXeF3jVFM0C6IF6hFOvuHMD2/sX8k/iU0Yq2SNo+wYB175816pU1AjSFU
         v/y4fg/36iSrLcIf4MNJEopK/lLcUdxLLWt8Xl7sQCpiHCi6IK7jUy/hRuLJ1orUpa54
         vL1S20EbJRwcyMZ+xdi+hMrvYkhVnOHvnszqKeCUCJIJMJrBt1Gk3e6BST8dU1UxwQIl
         45CrA+Ft4zSMJ9MVFXQ9f7KUCROzf6DPCxmT/X2gF6HzBK6v/ciM++whC65QAi3+Ah67
         cd2Q==
X-Gm-Message-State: AOJu0YwpNEDJN+E6S1F25xKQ1kwMWuicrbHvrWClF4YbQag5rucAvrsU
	pEH97HvW1E3OWdeySQj8buZ6aSm2iIOlJ8/lHoJbFZ4YRYusW7xGamxpu0CMukir
X-Gm-Gg: AfdE7cm7sZg21YAi1o3a2ZsVerFJ0mP5dpb9ik/e0R8QDfJDTz1Pw7FTFR6P8q7B84n
	lDqfkV/X9qCa3bA18hdkUvXidK2vkg1KU3Nx4cdcqfYwlbfigu2L+t3xIezmXZji2XcuTXXKeTj
	KBPiHtZMJ4sMGyCrfblOUU8FLBF2T8rqa4wXfFmsnXChGnP5ce2tWoloh6qlGUIV54UX51QWHLM
	Kl7cB5RbgIJzCAfslj9ysCQ34SXl9knjpNwylK4Ixuf1llWIk1VHFZ68JohxRIrHZY3/iYxuZjT
	W8WocNE/HDGG3xrhIZykOK279HdswoocJo4RKFsWkUGZcFxz3jTr9g/MG9DQE09fQk9YZ05emS9
	O9b3JDfFdh1FRQz9yAfQEIcMb+fHOVSXwOPAbr1bjI5gTD2B++CLvXNU1iyxd94HRQmAlg6pnX0
	aauySwONuHtbWQjbzwV5qUMsd+woESKPHUaX04xpJlBI1+uSTCLSJlIQCW0QH1mjpxYmASnmfTA
	q5r8AY=
X-Received: by 2002:a05:600c:4ec6:b0:492:259d:567 with SMTP id 5b1f17b1804b1-49242571623mr150138025e9.23.1782036209616;
        Sun, 21 Jun 2026 03:03:29 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f563dsm14400283f8f.3.2026.06.21.03.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 03:03:29 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: sd@queasysnail.net,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net v5 0/2] xfrm: fix async crypto (-EINPROGRESS) handling in validate_xmit_xfrm()
Date: Sun, 21 Jun 2026 12:03:25 +0200
Message-ID: <20260621100327.40203-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260603064659.3867-1-petr.wozniak@gmail.com>
References: <20260603064659.3867-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[queasysnail.net,secunet.com,gondor.apana.org.au,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300872-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:kuba@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C37BC6AA8FB

This series fixes how the async crypto path (-EINPROGRESS from ->xmit())
is handled in validate_xmit_xfrm() and its callers.

Patch 1 (previously sent on its own, v1-v4) makes validate_xmit_xfrm()
return ERR_PTR(-EINPROGRESS) instead of NULL when a packet is stolen by
async crypto, so __dev_queue_xmit() can tell it apart from a real drop
and stop reporting -ENOMEM on noqueue/bridge interfaces.  v5 also covers
the GSO segment loop, as Sabrina pointed out.

Patch 2 fixes a use-after-free found while looking at that GSO loop:
validate_xmit_xfrm() unlinks async-stolen segments but never updates the
list head ->prev, which validate_xmit_skb_list() later dereferences.

Changes in v5:
 - 1/2: also propagate ERR_PTR(-EINPROGRESS) from the GSO segment loop
   (the 2nd ->xmit() call); v4 only handled the single-skb path.  Restore
   the blank line in validate_xmit_skb_list().  Add the missing
   maintainers to Cc. (Sabrina Dubroca)
 - 2/2: new patch -- fix the stale skb->prev use-after-free (also flagged
   by Sashiko)

Changes in v4:
 - Drop bool stolen tracking and the ERR_PTR return in
   validate_xmit_skb_list(); use IS_ERR_OR_NULL() so stolen skbs are
   silently skipped (Sabrina Dubroca)
 - Drop ERR_PTR(-EINPROGRESS) handling in __dev_direct_xmit() (Sabrina Dubroca)
 - Move validate_xmit_skb() return-value comment above the function
   (Sabrina Dubroca)

Changes in v3:
 - validate_xmit_skb_list(): set stolen=true only for -EINPROGRESS
   (Sabrina Dubroca)

Changes in v2:
 - Reset rc to NET_XMIT_SUCCESS only when PTR_ERR(skb) == -EINPROGRESS
   (Sabrina Dubroca)

Petr Wozniak (2):
  xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
  xfrm: fix stale skb->prev after async crypto steals a GSO segment

 net/core/dev.c         | 10 ++++++++--
 net/xfrm/xfrm_device.c | 12 ++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.51.0


