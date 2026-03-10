Return-Path: <netdev+bounces-265821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IKWBbVrr2m6YQIAu9opvQ
	(envelope-from <netdev+bounces-265821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:54:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B2D24328A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16E5230CF3F5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA4427AC48;
	Tue, 10 Mar 2026 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fyes+lfJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B39626F2B0;
	Tue, 10 Mar 2026 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104031; cv=none; b=D9ONdJq3CPrK/vHsPUq3cpIXiAJUWlqeD0/dUB1x8ZmoQE5W4thTeRPK4/E0oWjrk1L4BGCM4B24wyum+65yttndbG3PM7FKA1A8AbGiyLIE2V8cKGbXBZ6sH8ZawH8o/6kVkxQplZyBKDXzU/UsRgaHJBFdAnWNzMNMh1bHUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104031; c=relaxed/simple;
	bh=3Le3mBs7FcChT/7kjQb1K8IZV0TRw1CdA3Cz1ItHUqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1vjSVWnH/N47gACBvhIndYIopFubdBvG17xwjORgjeC/dAioMgRL+gn/ultDDm4J6RVih3apKJCd9GgEhg1iMHfdVpfg0q/QlEPKvlLhjTtw9fINdZjBf/EjBiwad4toQowvMwETBXSPlOM+ibP4DclhhArC37HWwGGoQ0dpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fyes+lfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF37DC2BCAF;
	Tue, 10 Mar 2026 00:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104031;
	bh=3Le3mBs7FcChT/7kjQb1K8IZV0TRw1CdA3Cz1ItHUqk=;
	h=From:To:Cc:Subject:Date:From;
	b=Fyes+lfJtFd/zZTAX430NwxvRNHAi7uxrPE7pV3UQ5sUZcHjMrMInzB86ROldDhTe
	 9nrss0aHuIAeoC8oTYNbK0h64Y6Mw6jymBnRM8JwAoZ8lBvMzChkRcZVFPdHMlvNL5
	 fhyTqlVzMbe5n/Kn5QJVQJYl/sHmEfkTJaqJbd+v1NVOKG7/oImkoagItJe/57Jndg
	 ZR53MpH/kl+WwS0eSbw39r1sQ23FKsKbnS+dPF070Q4wd8K2nbkxKHML645VJ9YQPX
	 /tSxorMvBdgR9/cS6G0nbDBJrKsPXqHdg+i1YtXkFkEMpbdYGP+oK4OV+dqUvTXMc8
	 K9n1jMU87FiHg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] tools: ynl: policy query support
Date: Mon,  9 Mar 2026 17:53:32 -0700
Message-ID: <20260310005337.3594225-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 41B2D24328A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265821-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Improve the Netlink policy support in YNL. This series grew out of
improvements to policy checking, when writing selftests I realized
that instead of doing all the policy parsing in the test we're
better off making it part of YNL itself.

Patch 1 adds pad handling, apparently we never hit pad with commonly
used families. nlctrl policy dumps use pad more frequently.
Patch 2 is a trivial refactor.
Patch 3 pays off some technical debt in terms of documentation.
The YnlFamily class is growing in size and it's quite hard to
find its members. So document it a little bit.
Patch 4 is the main dish, the implementation of get_policy(op)
in YnlFamily.
Patch 5 plugs the new functionality into the CLI.

Jakub Kicinski (5):
  tools: ynl: handle pad type during decode
  tools: ynl: move policy decoding out of NlMsg
  tools: ynl: add short doc to class YnlFamily
  tools: ynl: add Python API for easier access to policies
  tools: ynl: cli: add --policy support

 tools/net/ynl/pyynl/cli.py                |  12 ++
 tools/net/ynl/pyynl/lib/__init__.py       |   5 +-
 tools/net/ynl/pyynl/lib/ynl.py            | 216 +++++++++++++++++++---
 tools/testing/selftests/net/lib/py/ynl.py |   6 +-
 4 files changed, 208 insertions(+), 31 deletions(-)

-- 
2.53.0


