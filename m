Return-Path: <netdev+bounces-296517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U/DoIn+2JmqobgIAu9opvQ
	(envelope-from <netdev+bounces-296517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:33:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3058265633A
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:33:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aNWwivkF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296517-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296517-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA063037899
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E769379C44;
	Mon,  8 Jun 2026 12:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BAE37881D
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:22:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921333; cv=none; b=a3XV+GhXI3uicOdRoFwMYHqF+6owXR2sUPlutFJXrh1b2YHdvDgOFF4E69urtyQHJ3DwgGUaxSOfrAz0K4zWWZ6vNkDnGkIUyig5C4Hpj0p9PeXjZwvWIjOjH5nx66pCbDxAc3YeQx+GcNCq9CJhEmlZRSdQir99YJWYrLZC1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921333; c=relaxed/simple;
	bh=0EsdpCH8pHTvCMLVt3KknkhGO1YlifMiPnY7zkaWjT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n68M1KAfZFCwjELKYq5wHJc12S/fs6IXN0Z/mwqoTH74KyiTyQMPQ2fOOcCwi5yf75rdrXO3ATosQw/NzQFdM5UreUr4yjap0sowTPM1FloZrJ1IeUfMbOW8P28piC5i8225NADOOJjEJqUGUl7qciXtEVc+AJaSOJXC1+pDsvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNWwivkF; arc=none smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5175b6c4e19so47408831cf.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 05:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780921331; x=1781526131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajp3k/JE6ATQg+UyjC3GyoT0HgkEIVNSvEdv6MGdm7s=;
        b=aNWwivkFjHuMrzGm4hNujn7ZaG6tE9fLnd9kIalhDUPkkmH0hnTnzUmwIFpmWtYiOL
         kqPD8G5DmqP5iYi/B+KKbxGV1SzcSgRs4E/OyMVR9TQSsGwWZoWxPyGJb5scUnrty+NN
         74KUI5dnL2V8O2jdfds5lzjkMv/Ugt5AO7cKEa0Gsy3UknGVOPrbosZe0+5MwUI98GCs
         unlZ8BR1lwrCeP9yzhwF412XSz0bQ8rHnyrg+Gq1ahD4t1a40bIO3QLcc/ISrGTJa6mr
         9uiR2ytaZnuV97yHZKcBKHxHHHghjKOiN3YBV6eZ87EfM5Jy5TNfpTrov03C+ZOatAYF
         fing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921331; x=1781526131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajp3k/JE6ATQg+UyjC3GyoT0HgkEIVNSvEdv6MGdm7s=;
        b=a4i+fuDY5isE0+IHt/a1jbdUyKPyEu4XizLkX4XShEXFTqirNVAmVP/vFT73YGI/ib
         kDQ8zkCHLku2j54FWbU9dIu312Zcx4A+5J7O/Qb39zp9YgF2Rrj5j2HNJmitE78VKnJb
         vqQaevTCEK6004JtL01KGPjrmypxdTEssmMJsfHLZyC+01kVYS+hn4OxlOZpvhkowxho
         BPyVeEwmMoQbxc8La7qgn2fqoclMmIETfmY0Q/A63w3Ef1OWM047SNnwGpckZKSlwQoe
         6WbfHXQ+qwuYw9rjAX1GrJ8ddQvl9hLoy0/B37pmgz9qVqLVJ4l/9sZUt1tSMEtZ79dq
         F91g==
X-Forwarded-Encrypted: i=1; AFNElJ9B67Le7jh7RG7odjCxVf5s/YHqYCkK3dYk5QH/ydGTSr9BhosbV8TVWIeHSZzbl+4KrFEVaVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJZdqKEHMvBWQbU3feVK528F29v4+8qkuMLV5pH+29rlfhKzf
	9aOUcLwfkPAgh53vepkxHfNV23ULNbFh3E+hpd/RckUW9v380tcFCow5
X-Gm-Gg: Acq92OHLRHv1ajc3q1MGdjANlxcERel+bRagttnWqFeqC40c/j25S19stCWHcu8N7Lr
	c4izySI/eTDSaeYvLX5nzbXmHcICXDru+/qE0l2tNsAbUtyFun4aOMPbVPIzTMkusmz6TH6aCo7
	1PJch0UhnFiueP2qFMxJqEmuLosiffGtZpuxqEHwmCYbBDut5MuUkYsdSVWE//wnjfMhXkFLTvV
	jiyb6BBf9jSYGEqgXbBzFk50tPp1t6AttIV1V4Um9M0dTI5XkI0JhnY8fOqvhvwjltB4tszvWiI
	WISobDSIMXmZkQCJ2e6Kg8O75hRLIWGjgNIiaiFinaZyyGVlGSZH/yAtF+eGwhEsJazyULUTl64
	IU2yfTvT1vXgR9wZSrn8b2ce0iFaiYvTICf51GW1mdT0gl2YlVlrxnRnLy6Ndu3D01Nf9QMEjYs
	0MeBECYzvY1WtVI114lRO+dojxrT+NH/wyNF9l3ZuSqMeLXczTcgEC1gTQAx2AIODFZ0P43jIZe
	KaNLEfWwgsYM3tSMLqqPqtOJDN18mQ=
X-Received: by 2002:ac8:598d:0:b0:517:7590:228e with SMTP id d75a77b69052e-517959cb47bmr233971491cf.0.1780921330734;
        Mon, 08 Jun 2026 05:22:10 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517af149fa5sm46086911cf.3.2026.06.08.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:22:10 -0700 (PDT)
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
Subject: [PATCH net v3 0/3] tipc: fix netlink gate and receive-path bugs
Date: Mon,  8 Jun 2026 08:22:03 -0400
Message-ID: <20260608122206.458290-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296517-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3058265633A

This is v3 of the public TIPC series. The discovery-message length
patch (was patch 2/4) is dropped: tipc_msg_validate() already rejects
the short messages it was guarding against, so it was redundant. The
remaining three patches are unchanged in behaviour from v2 and address
the receive-path review feedback.

Patch 1 gives the TIPCv2 mutating generic-netlink operations the admin
gate the legacy API already has, so a local unprivileged process can no
longer change TIPC state. Patch 2 drops CONN_ACK messages that
acknowledge more outstanding sends than exist, preventing the
snt_unacked underflow. Patch 3 rejects peer bindings with lower > upper,
which would otherwise leak binding-table memory.

Changes in v3:

  - Drop the discovery-message length patch; tipc_msg_validate()
    already rejects the short messages it guarded against (Tung Quang
    Nguyen).
  - Patch 2 (snt_unacked): drop the conn_ack local and test
    tsk->snt_unacked against msg_conn_ack() inline (Tung Quang Nguyen).
  - Patch 3 (inverted ranges): restructure the declaration block, moving
    ua below key at the maintainer's request (Tung Quang Nguyen).

Changes in v2:

  - Patch 1 uses GENL_ADMIN_PERM for TIPC_NL_MEDIA_SET and
    GENL_UNS_ADMIN_PERM for the netns-scoped mutators.
  - Patch 2 validates msg_conn_ack() at the start of the CONN_ACK block
    and drops invalid messages instead of capping the value.
  - Patch 3 reorders the new u32 declarations in reverse-Xmas-tree order.

Michael Bommarito (3):
  tipc: require net admin for TIPCv2 netlink mutators
  tipc: prevent snt_unacked underflow on CONN_ACK
  tipc: reject inverted service ranges from peer bindings

 net/tipc/name_distr.c | 13 +++++++++++--
 net/tipc/netlink.c    | 12 ++++++++++++
 net/tipc/socket.c     |  3 +++
 3 files changed, 26 insertions(+), 2 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.53.0


