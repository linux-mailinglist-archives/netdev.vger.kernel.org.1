Return-Path: <netdev+bounces-255236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIpSH4MFfWmpPwIAu9opvQ
	(envelope-from <netdev+bounces-255236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:24:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BACBE17A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FB46300E15F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55944388847;
	Fri, 30 Jan 2026 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCShTE7D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B444387344;
	Fri, 30 Jan 2026 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801082; cv=none; b=HVSIZRRnd/BybdRUgJb58d3bOI1x0xNnJ2oMh+lnfVUOI8wcG9xzD3F9IwhP8izbnHGcgoP+cqy/lQZaBKnNyPZyRrguwLb2EKPbls4FZNIlgrZZvisY0v+7aYoooB6Hws5PuHsSXhVI34tRrJ0lsF2YdMfPvHEPlqMUKTrBHAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801082; c=relaxed/simple;
	bh=BtBwAyUIexVco1Hj3XxaIlRTjbQAF50GddzBng4Ume4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U3pvn3DqT/WvLbSpMfJuaBjKTO7LU+7abGy+z9/ZEPzk12G+g0IevnhVsWmfvwx+o+Ahzu1178N0AXoy0fD8Wn37iLseCJn07jvuWAqcXRsqa1oecfUJZtgIcCcQAVPsBe/yrAsWRu5ZaSNwfvbdmrInbDhkQlZmcGJJealDEW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCShTE7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292BBC4CEF7;
	Fri, 30 Jan 2026 19:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769801081;
	bh=BtBwAyUIexVco1Hj3XxaIlRTjbQAF50GddzBng4Ume4=;
	h=From:Subject:Date:To:Cc:From;
	b=SCShTE7D5kJ86xBGEfL13HkjzGii8I1s1/W++JOdFJiIPYT3ZlQiAnX5HwLGgLULe
	 MNocFk2NxfaYZk2g7AQRFfmfEA6HoNcW7NloNOVKjXpezUBBu7hSJLHdj0PMVLuozM
	 UINnZI6sWbBbaV8Hl2ol897DmDv4SrNPHInLEKWNaS2xA0EiM3+5a4JrLZrLnxSMVJ
	 PRPFA2M1ZJrZrMNY8ESmvq0qgBpU43q96MZQtYcXMzWBMlVF6dnzRnYkgtWX093NIc
	 Y9RK4+9bQOiIb4/E/GH6TWf+u/ggh8zYOegt342P6gcAtMDNyX25rTJLaxgcu5qM2k
	 nnVfqaXADVqBg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 0/6] mptcp: implement .read_sock and
 .splice_read
Date: Fri, 30 Jan 2026 20:24:23 +0100
Message-Id: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGcFfWkC/4WNwQrDIBBEfyXsuVtUbMCe+h8lB2u2ydLUiIqkh
 Px7Rei5hzkMj3mzQ6LIlODa7RCpcOLV16JOHbjZ+omQx9pBCdULqQx6yjVbxnfILmAKCzvCXo0
 PbaU17qKgbkOkJ2/Ne4ffBIZKZk55jZ92WGTjf9xFokBjtLNOi9FacXtR9LSc1zjBcBzHF4zXO
 jPFAAAA
X-Change-ID: 20260129-net-next-mptcp-splice-62db4a1a9c52
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Hannes Reinecke <hare@kernel.org>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BtBwAyUIexVco1Hj3XxaIlRTjbQAF50GddzBng4Ume4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJrWYunzOYLtDhreC9vE7fM68VRl0Rasw+d6jhQELOTw
 WZNyTmGjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInYeDD8s91woJztzZpzXF4K
 M64KC5a6aOWuEWA/3D7HQ8a+bZbCFUaG/7MmTz3+suHmjtneF29p7zSrTgkqWifhZXuSLWklu0s
 EEwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255236-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: F0BACBE17A
X-Rspamd-Action: no action

This series is a preparation work for future in-kernel MPTCP sockets
usage. Here, two interfaces are implemented: read_sock and splice_read.
As a result of this series, splice() with MPTCP sockets -- which was
already supported -- is now improved.

- Patches 1-2: .read_sock implementation

- Patches 3-4: .splice_read implementation

- Patches 5-6: validate splice() support with MPTCP sockets.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 4: Fix kdoc warning reported
- Patch 5: catch possible errors with splice()
- Link to v1: https://patch.msgid.link/20260129-net-next-mptcp-splice-v1-0-994cac40daa0@kernel.org

---
Geliang Tang (6):
      mptcp: add eat_recv_skb helper
      mptcp: implement .read_sock
      tcp: export tcp_splice_state
      mptcp: implement .splice_read
      selftests: mptcp: add splice io mode
      selftests: mptcp: connect: cover splice mode

 include/net/tcp.h                                  |  11 ++
 net/ipv4/tcp.c                                     |  13 +-
 net/mptcp/protocol.c                               | 218 ++++++++++++++++++++-
 tools/testing/selftests/net/mptcp/Makefile         |   1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |  79 +++++++-
 .../selftests/net/mptcp/mptcp_connect_splice.sh    |   5 +
 6 files changed, 308 insertions(+), 19 deletions(-)
---
base-commit: 6ad42b24413630199cb9f35d073f71768788f8dc
change-id: 20260129-net-next-mptcp-splice-62db4a1a9c52

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


