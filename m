Return-Path: <netdev+bounces-266448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAvdI3DhsGkuoAIAu9opvQ
	(envelope-from <netdev+bounces-266448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:28:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FD425B957
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAC9D3020EB7
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009630FC1A;
	Wed, 11 Mar 2026 03:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax647F5x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDBB2F616B;
	Wed, 11 Mar 2026 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199725; cv=none; b=n9BCTydvG6aapfRME3qT4hj2uGdhi0kCrcThi0iCdhiZyAwKLPQjRrjMEk1lr8WfFoEjEMIIK09AL2VfnXlhQ4zlN22YN6BUC3FbiE4vQthRdYgzMHAu3BWSJtOQsfklxKq7eiowRQb3CR+FpSbee3s0gfllRbKwlUkuheZupsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199725; c=relaxed/simple;
	bh=LZpW7//jVbQ3b28dY4yr/U1hAe/Gvc+12IE+cO/BbYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IA9cYoKMcRbdhQrCzQMoPmo/QILu0ZoqPveQ3QsgxefrG7mI256WslCDKTzPWiUQOSZQEyLR7npxNFKqOt/sLKp8FTbuu5KH4FTEmC3YFZBZ2uYUsrSA6USvFNAXKpBzSyRmEtTM34xa6cxhAZcZF1O0q9KTp2wc0AKKf54C8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax647F5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3866AC4CEF7;
	Wed, 11 Mar 2026 03:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773199724;
	bh=LZpW7//jVbQ3b28dY4yr/U1hAe/Gvc+12IE+cO/BbYk=;
	h=From:To:Cc:Subject:Date:From;
	b=ax647F5x+qT+685CLwN1MKr3OcgXFbyaifB+B6bjq1ONl/JG9B0VJM8OrU3Betb1X
	 DlREqI+cI4KM2TeQFB2mVIV6bpcT0o8hNStVwJBO3kHkqVSU3s6AOlLYvJFTb1qPq8
	 Nrm3NQNi1tysSRREZ29fpotkn4k67PlQFgRZb7e0hQNlTig8ej7jPBT+OADMGmy6lI
	 tLnNddnGMhSgL/SSmz9X5wuz1V/dHsLPClt31I1L97A6IuFKxtAdw/H4grMOsdRVAn
	 p+0qanvC1kuvdjyQTSrNIKmLfskneUqMupzN02ZtqxaTw/akY2lCD/iz+1kLLI+ILp
	 1vmw/8TEbDnmQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/4] genetlink: apply reject policy for split ops on the dispatch path
Date: Tue, 10 Mar 2026 20:28:35 -0700
Message-ID: <20260311032839.417748-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F2FD425B957
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266448-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Looks like I somehow missed adding default reject policies to commands
in families using split Netlink ops. I realized this randomly trying
to dump page pools for a specific device and always getting all of them
back. The per-device dump is simply not implemented so the request
should have been rejected. Patch 2 is the real change, the rest is
just accompaniment.

v2:
 - add patch 1 to avoid breaking devlink
 - add a lot more tests
v1: https://lore.kernel.org/20260307204425.1900467-1-kuba@kernel.org

Jakub Kicinski (4):
  genetlink: use maxattr of 0 for the reject policy
  genetlink: apply reject policy for split ops on the dispatch path
  selftests: net: make sure that Netlink rejects unknown attrs in dump
  selftests: net: add test for Netlink policy dumps

 tools/testing/selftests/net/Makefile          |   1 +
 net/netlink/genetlink.c                       |  20 +--
 net/netlink/policy.c                          |   4 +-
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ynl.py     |  10 +-
 tools/testing/selftests/net/nl_netdev.py      |  32 ++++-
 tools/testing/selftests/net/nl_nlctrl.py      | 135 ++++++++++++++++++
 7 files changed, 186 insertions(+), 21 deletions(-)
 create mode 100755 tools/testing/selftests/net/nl_nlctrl.py

-- 
2.53.0


