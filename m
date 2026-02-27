Return-Path: <netdev+bounces-261696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDZSDt8RoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:39:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BFD1B24FC
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F3D3306CDF0
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801903328E1;
	Fri, 27 Feb 2026 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etSEospf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E63328E7
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163547; cv=none; b=TU6jrXGlf43QpDx0ERVXNxJM2ygHYYPwlJNksaoz0+tadJXo3gJ+WQmXuk9xyZ2sAkzozC/mO4sMv061qnK5P8WeyoJzzPTHXxXpS85wO4/uppFtE714FjRuU6loYpDlrye8YHED9qCauN0N6rrYtbEh2W8N0iAGzE2rMh9kLzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163547; c=relaxed/simple;
	bh=jDaxjRDUAGrHBTqMyeE08aNABU0cMA5Rcr0LSfv5Ing=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Iw6MvBZJEqP2S/LskoR+Tx2JC6nbeKga43C/OHWHeW3i2Q8oG1EiUjHBOMr/G63zHejm4mzOY9UJsOJMeDqBKg8yJbFsae9aPstHRRCsUJqTquQBQ04+5YpDpxIm916mnk4FuF9MYZw9OoV3M8C2bWR7kGjSlGx85y8KTshSpu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etSEospf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a90510a6d1so11895345ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163545; x=1772768345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b/byyZUPVol87JdHaoieBf6NtzQza2+/1ObOKsezQXg=;
        b=etSEospffXcOVyFOV9BH+k5H7D9A+7hx0ejEnw8t0kqz8S825k7bvKqd2i54dOxqTK
         oMjSQ9qC/AYRhWkXLReKbuBPVGGqXhCDbiYmh0z86qBfm2nLw0eOsILuV9PmQwX87Xch
         GZm2JFuPAtFtlcarmLTkZg+ly+MlcbBqVP+jf8yjwNzkA4GWvIytW4bx6UBKI8+irAl/
         XBRjwdTA4yhxuE+N5PBOajMFOml43d27ziFwL/O4rjttw0RZdKEBmmd8oMeNe8CGPeue
         H1QBJ0WGcxvU1GJdlrUQn0eyZqg4m5IxR/FhzpiOqnIYndbeDz8uiZayUq7h+D6k3oPx
         qMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163545; x=1772768345;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/byyZUPVol87JdHaoieBf6NtzQza2+/1ObOKsezQXg=;
        b=U6XzE5KJx/+CsbtkxfFLiW62fwWP04afnO+BhHqlLlXCR97nC2hpDcMfzMMf1/ofK5
         /ZkC/q5qbgYnql0CQo/PtXNWc97TtVn7cShbJFYeaqYBsJ6Go98qofJn/Z7KIbp5ISaE
         X1QUBQ2Ldqf7u8ApJBJlKqml6Ua+1nAcsE8stTR9OF1IIzpBRFJSoD1VTL01vpBBoSrM
         k0dpeAFJyl1fO/Ta0ikO8POoCEYNygQUzq+a1oymegW6sGPQonyRCsgFqWzD7zbpeSyw
         ceHxO6XtBLipQ6+3ceQwIXJF7lwO4ki6wRtIZ39lexfM+JPi7pBAGSrnObgvWr7FU+AY
         h0xw==
X-Forwarded-Encrypted: i=1; AJvYcCVP4YRiv2QRf0m3gCmduDDxWihRB2M1vRpN6w2ZZXmLF/sy3sHQ+Jii7nZYR5kcVIotfBofbE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq2P27/YSK1J0cmGZHpihsCu9HbMN3rhA7rEblgKLAQShlE6xt
	GBmBNuaakYTJKLERhWkd1O1KSHXwO+y6KYQHG2NuIeow35leV45KDmiN7a9U0CihoNmjgCD7Oar
	aR76ZPA==
X-Received: from plbld14.prod.google.com ([2002:a17:902:face:b0:2a7:7822:9011])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc47:b0:2a7:bd50:27fb
 with SMTP id d9443c01a7336-2adf79834e8mr47369895ad.16.1772163545437; Thu, 26
 Feb 2026 19:39:05 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 00/15] ipmr: No RTNL for RTNL_FAMILY_IPMR rtnetlink.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-261696-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 98BFD1B24FC
X-Rspamd-Action: no action

This series removes RTNL from ipmr rtnetlink handlers.

After this series, there are a few RTNL left in net/ipv4/ipmr.c
and such users will be converted to per-netns RTNL in another
series.

Patch 1 adds a selftest to exercise most? of the RTNL paths
 in net/ipv4/ipmr.c

Patch 2 - 6 converts RTM_GETLINK / RTM_GETROUTE handlers
 to RCU.

Patch 7 - 9 converts ->exit_batch() to ->exit_rtnl() to
 save one RTNL in cleanup_net().

Patch 10 - 11 removes unnecessary RTNL during setup_net()
 failure.

Patch 12 is a random cleanup.

Patch 13 - 15 drops RTNL for RTM_NEWROUTE and RTM_DELROUTE.


Changes:
  v2:
    Patch 1: Add ipmr to .gitignore
    Patch 3: Add READ_ONCE() for mrt->maxvif in ipmr_rtm_dumplink().
    Patch 10: Use a local list in ipmr_free_table()

  v1: https://lore.kernel.org/netdev/20260226023637.1335854-1-kuniyu@google.com/


Kuniyuki Iwashima (15):
  selftest: net: Add basic functionality tests for ipmr.
  ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
  ipmr: Convert ipmr_rtm_dumplink() to RCU.
  ipmr: Use MAXVIFS in mroute_msgsize().
  ipmr: Convert ipmr_rtm_getroute() to RCU.
  ipmr: Convert ipmr_rtm_dumproute() to RCU.
  ipmr: Move unregister_netdevice_many() out of mroute_clean_tables().
  ipmr: Move unregister_netdevice_many() out of ipmr_free_table().
  ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().
  ipmr: Remove RTNL in ipmr_rules_init() and ipmr_net_init().
  ipmr: Call fib_rules_unregister() without RTNL.
  ipmr: Define net->ipv4.{ipmr_notifier_ops,ipmr_seq} under
    CONFIG_IP_MROUTE.
  ipmr/ip6mr: Convert net->ipv[46].ipmr_seq to atomic_t.
  ipmr: Add dedicated mutex for mrt->{mfc_hash,mfc_cache_list}.
  ipmr: Don't hold RTNL for ipmr_rtm_route().

 include/linux/mroute_base.h                   |   9 +-
 include/net/netns/ipv4.h                      |   6 +-
 include/net/netns/ipv6.h                      |   2 +-
 net/ipv4/ipmr.c                               | 261 ++++++----
 net/ipv4/ipmr_base.c                          |   4 +-
 net/ipv6/ip6mr.c                              |   4 +-
 .../selftests/net/forwarding/.gitignore       |   1 +
 .../testing/selftests/net/forwarding/Makefile |   4 +
 tools/testing/selftests/net/forwarding/ipmr.c | 455 ++++++++++++++++++
 9 files changed, 634 insertions(+), 112 deletions(-)
 create mode 100644 tools/testing/selftests/net/forwarding/ipmr.c

-- 
2.53.0.473.g4a7958ca14-goog


