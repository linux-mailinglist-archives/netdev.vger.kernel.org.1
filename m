Return-Path: <netdev+bounces-276814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMRrC2QW12k1KwgAu9opvQ
	(envelope-from <netdev+bounces-276814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:00:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BC13C5D5F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEDE93011C78
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819DC363C72;
	Thu,  9 Apr 2026 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fr8YrZuU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C082B245005
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703583; cv=none; b=EQ9P8+CTAauQQhfeRRTF6DETHfKyXVS0EcxBopuyquyxDN2mIXVxQHhFfS6PueUSewuMGr6wereA2xHHA7GP9diah+FTtvTKAKCTrpTxeu5mEO23N+RszP99cwZF2zxnRZvqyPjfJCiSVopkGYEJ+rkqxGzKHkyFJFYmadczsuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703583; c=relaxed/simple;
	bh=5mAyQvSaOL2LoLC2WNanmYBqAdqTpdMJR9Ynzl7Y5hQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fCcfUGFUFkXODJEMZq2ZqEwXyWZ+Q8c8kGjKxZaREq+6df/F/6Rl0XxxnBx4yC/mnS97g5kP0DMsmbWCyDZT0h13LiDkZ2Ns7FJy2MEqgcXusE1p4hM+Ol0uO+igbNLAYUe6jLQRkX+IICLRCAdwUFxQM8atLMae1UiPFG3eQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fr8YrZuU; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12bf921cf49so8351536c88.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 19:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775703580; x=1776308380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/nwzMb669N5Zt3JV1uvWhd8BvB9PhfW85QQnH/tgbSk=;
        b=fr8YrZuUepOlz96upC2++CgvBbYv5Rr9grgeOjbCUnvnvbo5pHeFPZCj04nslXwinD
         6T/SS70YjjoSZ3cgxBGA3vSB8h26AOGkyE2Dhy+XzVDyzsHsiMB0b525xeS9OwYoEbf/
         vdEumkrYFLugnxrCgcfbe/sVtyUObs8cQ47flV27M62IYvxFq4WVnr0vFNBSEYn+oLAN
         ps0Uym3Oso5jRlpbRwTSIkOrCB027MCWIKYR6LCNZsA7SjZEs3wFzGGajDjUgjk/xfJe
         nC4BQzvfa2JEGVaPzOCkEEBf3HVnz1wSVTaEJmmeJEKKN4t3O7BXE4iqEbBq6tqDFe4P
         LYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775703580; x=1776308380;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nwzMb669N5Zt3JV1uvWhd8BvB9PhfW85QQnH/tgbSk=;
        b=ApoCC7Ou8Fh+ZMWQ2bvJIHnGlcsuwO+IJFM3oSeDkJSPdfmp9JcA/156o5lb0ZRbEl
         fbS4QSPxkYfPycr1oJHhOncYszKuYvpB5Wyjk6BblAgMvigxKDnch4QYuhGLraD5y/FW
         2YbiS3/sPUGSOBB7OW2/vgoKFKjegvYdwfbOA1HUKWGms8Uk4RBk019FyhmaAP5paTdA
         zCjiTKBEY6IlKYQQgR6HLZBf2By43LSPRRKsdv9nj3VXZCuorMejZcS5NhHIWzbxXyU7
         zsA8rRUh0sX/Wa8z1zGomJb58/GjXtDlW6DaKBQtRo1gCLyCUIBaXlNStjn4nAAwvsOH
         B7RA==
X-Gm-Message-State: AOJu0YwzHwpscBhnEYbu8XXGBdGG+5MNS1vBalTlC0HDyTF7Uq6HwLNq
	lujsSbOsPZk+ahSoI1vs66lUFsigUlVVPw8oXdY0JZN1sczbZXA5sWJBVULc8jIQhdNWrBQlGRx
	6KkUl57F8pbtpyQFOxLtsCg==
X-Received: from dldz16-n2.prod.google.com ([2002:a05:701b:4190:20b0:12a:adb8:138b])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:229:b0:128:d23d:81aa with SMTP id a92af1059eb24-12c28c0814amr828945c88.27.1775703579637;
 Wed, 08 Apr 2026 19:59:39 -0700 (PDT)
Date: Thu, 09 Apr 2026 02:59:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAoW12kC/4XOQW7DIBAF0KtErEuFZwDTrnqPKgsMg4OUQIQtK
 1Xku4eycmVZXX59zfvzZBOVSBP7PD1ZoSVOMaca+rcTcxebRuLR18xAgBZSdHwme4tp5L7EhQq
 PaaaS7JUbDBCE6KXXhtXre6EQH03+Zolmnugxs3NtLnGac/lpkwu0/l99AS54MMJ18NH10A9fY
 87jld5dvjV0wS0ExxBWiIwLnhwOysEOklsIjyFZIY8CISA6C2oHqS2kjyHVPrIYUBrbuT2kt5A 5hvQvpAbnXehBCfkHWtf1BavMsxDtAQAA
X-Change-Id: 20260401-teaming-driver-internal-83f2f0074d68
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775703578; l=4446;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=5mAyQvSaOL2LoLC2WNanmYBqAdqTpdMJR9Ynzl7Y5hQ=; b=OSUai0KexYfCxKfJZltwYsz8w8Ul22IpzSFUb8ivMSrPUs2ytRo8djOvYT6RcVDaI+m7JlGpb
 z2NHp6csL7GBik40h4wSccaDMDQqKOJff4BGst44oY984ygmJZbt3fH
X-Mailer: b4 0.14.3
Message-ID: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
Subject: [PATCH net-next v7 00/10] Decouple receive and transmit enablement in
 team driver
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
	Marc Harvey <marcharvey@google.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276814-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87BC13C5D5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow independent control over receive and transmit enablement states
for aggregated ports in the team driver.

The motivation is that IEE 802.3ad LACP "independent control" can't
be implemented for the team driver currently. This was added to the
bonding driver in commit 240fd405528b ("bonding: Add independent
control state machine").

This series also has a few patches that add tests to show that the old
coupled enablement still works and that the new decoupled enablement
works as intended (4, 5, and 10).

There are three patches with small fixes as well, with the goal of
making the final decoupling patch clearer (1, 2, and 3).

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v7:
- Increase the timeout to 300 seconds for the team selftests, since
  gracefully killing teamd can take 30 seconds to timeout.
- Link to v6: https://lore.kernel.org/r/20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com

Changes in v6:
- Make selftests use a TCP port with no associate service.
- Make selftests pass -nn flag to tcpdump, which will make it not
  convert port numbers to service names.
- Link to v5: https://lore.kernel.org/r/20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com

Changes in v5:
- Change teamd activebackup selftest in patch 5 to try graceful teamd
  teardown before using sigkill.
- Make the teamd activebackup selftest in patch 5 delete leftover
  teamd files during teardown.
- Reorder function calls in team_port_enable function in patch 7,
  since the enablement behavior shouldn't change.
- Make selftests use tcpdump instead of checking rx counters.
- Fix minor typos in patch 10.
- Link to v4: https://lore.kernel.org/r/20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com

Changes in v4:
- Split the large v3 patch "net: team: Decouple rx and tx enablement
  in the team driver" into 4 smaller patches.
- Link to v3: https://lore.kernel.org/r/20260402-teaming-driver-internal-v3-0-e8cfdec3b5c2@google.com

Changes in v3:
- Patch 5: In test cleanup, kill teamd to fix timeout.
- Link to v2: https://lore.kernel.org/r/20260401-teaming-driver-internal-v2-0-f80c1291727b@google.com

Changes in v2:
- Patch 4 and 5: Fix shellcheck errors and warnings, use iperf3
  instead of netcat+pv, fix dependency checking.
- Patch 7: Fix shellcheck errors and warnings, fix dependency
  checking.
- Link to v1: https://lore.kernel.org/all/20260331053353.2504254-1-marcharvey@google.com/

---
Marc Harvey (10):
      net: team: Annotate reads and writes for mixed lock accessed values
      net: team: Remove unused team_mode_op, port_enabled
      net: team: Rename port_disabled team mode op to port_tx_disabled
      selftests: net: Add tests for failover of team-aggregated ports
      selftests: net: Add test for enablement of ports with teamd
      net: team: Rename enablement functions and struct members to tx
      net: team: Track rx enablement separately from tx enablement
      net: team: Add new rx_enabled team port option
      net: team: Add new tx_enabled team port option
      selftests: net: Add tests for team driver decoupled tx and rx control

 drivers/net/team/team_core.c                       | 237 ++++++++++++++++----
 drivers/net/team/team_mode_loadbalance.c           |   8 +-
 drivers/net/team/team_mode_random.c                |   4 +-
 drivers/net/team/team_mode_roundrobin.c            |   2 +-
 include/linux/if_team.h                            |  63 +++---
 tools/testing/selftests/drivers/net/team/Makefile  |   4 +
 tools/testing/selftests/drivers/net/team/config    |   4 +
 .../drivers/net/team/decoupled_enablement.sh       | 249 +++++++++++++++++++++
 .../testing/selftests/drivers/net/team/options.sh  |  99 +++++++-
 tools/testing/selftests/drivers/net/team/settings  |   1 +
 .../testing/selftests/drivers/net/team/team_lib.sh | 174 ++++++++++++++
 .../drivers/net/team/teamd_activebackup.sh         | 246 ++++++++++++++++++++
 .../drivers/net/team/transmit_failover.sh          | 158 +++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh      |   9 +-
 tools/testing/selftests/net/lib.sh                 |  13 ++
 15 files changed, 1198 insertions(+), 73 deletions(-)
---
base-commit: b3e69fc3196fc421e26196e7792f17b0463edc6f
change-id: 20260401-teaming-driver-internal-83f2f0074d68

Best regards,
-- 
Marc Harvey <marcharvey@google.com>


