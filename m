Return-Path: <netdev+bounces-297661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ln2EDy1bKWpeVgMAu9opvQ
	(envelope-from <netdev+bounces-297661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:40:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B86695CB
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:40:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DcBS9hHy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297661-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297661-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D0E7303609F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6E4071F2;
	Wed, 10 Jun 2026 12:40:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960773DEFFE
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:40:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095210; cv=none; b=V9tgFl9LOGyhjvgFRDZHQk+zWSiyFwJl6RaEcSGD4JwfeCYE60AdiLmqIQKP5A90C4o7ih3o5UWByojbO0jst9Tt+zdcS8brXP19lgjOTMUTqankGDmPbxRH7A5gtGGckDkkK543KgmLE7hWnPvmf+24kD+5rUtdScJHhTTZ2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095210; c=relaxed/simple;
	bh=+skWT8NryATf+XyKQMJXMXUusm5T6cV0uPARsNdQuAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEwxLBa9J/pFidvRJaWWp5S5oyL5aZKom0PE53Owx8A39Bqjf3UXLzdYWfd9eDR4b5uVXzdYbv9PRWHLrVSGelFDLgVlMQu6E+774VoQbAnRAJh8qq0OdOsXYFLGkkX8yyJ+MQuAYckSXotgShEsrNdYtuSgfWKYy5N7H5uYr8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcBS9hHy; arc=none smtp.client-ip=209.85.222.182
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-91562bf6c12so807013785a.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095207; x=1781700007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xfq8PCJ4BjOQoktbE1QkQOK7RW+LQsYtRE6liOdqkoA=;
        b=DcBS9hHydr7Qy5KUD/yjLhJ1AzwcTp7EdlnhkNWimSrNX85Bx9OWrlbAAJOa/fqy6Y
         2VU8UmQAtlrnXQUJ2yXD4wEMdjIeQiVEkack8Ij8LHRZ64EflvrFolnrAbfDG8+l+wN0
         xNPBWv8ibBO5BV7O+ggUdkE161UQ+7Bl1Mwy+XF/IOiU8zOwZqvzBINy8z+4QiC66LT2
         rDMu1UimPU6FqEODcDNY5bVhGMa/Q+sdPzrqym9J3xiwY2Qa1nD/0ryRQM7JEwlfh+Kc
         VrndosZa1TIwjSLxpuXtHHGTFruTLnDCkPVFIsfQlBOlTGGPffwzLIVYZCc9kSyqfSEb
         QV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095207; x=1781700007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfq8PCJ4BjOQoktbE1QkQOK7RW+LQsYtRE6liOdqkoA=;
        b=fMPjYAfHOmz9QVi6J2lsFG6eTdGZ5YBrHZZCRghBApPIe5U1fCmplnZuAyvtLeJBIr
         YwFU0/GKVuLx40J3IzAaSkaHhoMOF/lV285yzt74ks6nn8cIWM9Dcq5tUrY/IStUl/1R
         RJE65ggYDbsHlDugy62ZDJPOJtCImwAzugbBx3/xDX8ZNMLMsdWK0uYwrRQqX3ulTAXW
         /W0tdXZ2qSHlQy2spyTbDmU9ExEjMOD51O0EdG60dA3Qvx1opqERN/s/xLYLXO7qXMRS
         WY9EcBwdmYQyderZEGtgTG1oId0zKYGAl51o5IWy3QZn0JjOXhKC0uH6itYS5CEFhOFT
         dFLg==
X-Forwarded-Encrypted: i=1; AFNElJ9YDFa591mNyz3YJgeTPVYdqE2VpuEFdFtuNaMGs8jTud40p19X0InkROqODnQaOh0H6Fp0khQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEn4118bQVrymACEp86ii5sQ79xx1e0gasaOPPjSlSEJsNTq3q
	ze5L4+SQ4+rUfUwfyQSOTSjNVSywqk0cCNqNd+AmuPD9yQVn/Zl3Vz3+71ZzmkV8O1g=
X-Gm-Gg: Acq92OEyrCYOESC1SJwsPThvMblKUHemd0HwpFk7QdCg5KZWxDGJrdf0LVp5f6oKcrr
	HnpImWxtNPwmLyxOGqyEZpBSph2XxlBWw18w6qLnS/7jFGR1gMLhWcIGwk1/8DOVERLgXEWL6QH
	nFzPvlLao+E+YS5JDf6hjnBBWXQe31XbIZWKrOKZn5NzAAr93PxlIYO+VAkGvyFhAd0l/roD8am
	GQFdGxJ1BVa1EhSW14dLs3fTdRO4iwGAB0sFsXzPUchMKuOecVSYdezTgWx/riyrG/2nFBQThiN
	XTAfY3jb82PnIyiR6Veoi/372m902u+BaAFQFxblp80cu74XAwsNDfaZ8sI1e2VU5bIdh00jqxJ
	TZKNqlmwufRZoZ7cUzBsCKrzPrexH49Y5dbz88ZdpCVeGJxbmjSXlDhNFdiKqpIaPtQ2yt0ejSk
	Sj8/41uPErX+p7o0rNqT7xwK0E3J8m0OiLRJxoJNvHzeFIydCLSdVZS7UNysvXPMni471u18o0g
	n0acdNqkPN1cXqJ3ZeJDPXUvdu8Xw8=
X-Received: by 2002:a05:620a:6cc7:b0:914:c82c:79fe with SMTP id af79cd13be357-915a9ccca05mr3979896485a.27.1781095207439;
        Wed, 10 Jun 2026 05:40:07 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a237330sm2499096885a.16.2026.06.10.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:40:06 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 0/3] tipc: fix netlink gate and receive-path bugs
Date: Wed, 10 Jun 2026 08:40:00 -0400
Message-ID: <20260610124003.3831170-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297661-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:tung.quang.nguyen@est.tech,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F6B86695CB

This is v4 of the public TIPC series. The only change from v3 is in
patch 1: TIPC_NL_MEDIA_SET now uses GENL_UNS_ADMIN_PERM like the other
mutators, instead of GENL_ADMIN_PERM, so the whole series uses the
namespace-aware CAP_NET_ADMIN check that matches the legacy TIPC netlink
path. Patches 2 and 3 are unchanged.

Patch 1 gives the TIPCv2 mutating generic-netlink operations the admin
gate the legacy API already has, so a local unprivileged process can no
longer change TIPC state. Patch 2 drops CONN_ACK messages that
acknowledge more outstanding sends than exist, preventing the
snt_unacked underflow. Patch 3 rejects peer bindings with lower > upper,
which would otherwise leak binding-table memory.

Changes in v4:

  - Patch 1: use GENL_UNS_ADMIN_PERM for TIPC_NL_MEDIA_SET as well,
    rather than GENL_ADMIN_PERM. This keeps the same namespace-aware
    CAP_NET_ADMIN check that netlink_net_capable() performs on the
    legacy path, so CAP_NET_ADMIN holders in a non-initial user
    namespace (containers) keep working (Tung Quang Nguyen).

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

-- 
2.53.0


