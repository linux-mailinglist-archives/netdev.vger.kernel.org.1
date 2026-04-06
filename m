Return-Path: <netdev+bounces-275510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AByWAtUi02n1ewcAu9opvQ
	(envelope-from <netdev+bounces-275510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:04:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 605853A134E
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D52FF30057A2
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F87E3161A1;
	Mon,  6 Apr 2026 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOY9PGwL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC014A4CC
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775444690; cv=none; b=Mtt/Ljc9qF/6ZIkGdZ/vB+mfv6nDjkmmvWESIxcswaXpMqskKRZIlcRyTakfGefC+Z0XZZSfIDlHof7/0bBy/thO7fO5WKRmFnoVCXGzaHwuQyvlySfxTJYvQeJHV2LwGRyE7rUzmS2BB4qjzmC6L+1+SH9Jb87W6Vuz1BTRIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775444690; c=relaxed/simple;
	bh=os2axCD7KWEJ2zFtPn/3cysdH77SPlIUyOJdroZkBH4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZXe1/hqFH21KgF5ykkFwA3quzcgovfPQQI6Pbr8Enyqw379K6zCw27J/axItN3dZDv3awjlhh5SbyhtCdE0VXohCT4N0B9X/qhikrIWObe1a8dBk+ctkuJlXtvXvGZOU/5prxeX54UgmTlkhZw21Z7J1uGzhZJfC6BuIhGdGD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOY9PGwL; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12721cd1a2aso23289804c88.1
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 20:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775444688; x=1776049488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RKvbBGoqDQ/nccvfp7In4m/ADJBo3JF7iAojH/CusVY=;
        b=JOY9PGwLh/QQ6c2K5vwhTgMaN/1l9rXOQ3dKPy0KZuzY6GWry/0Sg5X83pIeFQOvyQ
         pWVTHpNc4XGg5CnNcb6V35NdQSYMZeT1iay5D9FpvXYndZoEnigBRDHWXKZnbJtyGvep
         JndqCWrecLHkTEcd3u+Qnue0nPFtGsQ4eXFKJek+525GuMpUJWAsEoFlg17E7oCy0MPE
         4GwqX+suqVY40CSZEPF0yu5JB4gDpY7jA9w6enWwljdCDtMbaNtWNN+s4WNkYE9jxQ8P
         JIGERL+cgO5f4bm+sodAIHDs50ZpQPu6AZhKl8sO+GpdQGEUUjqULjGKPYH6/WibMU7P
         pEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775444688; x=1776049488;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKvbBGoqDQ/nccvfp7In4m/ADJBo3JF7iAojH/CusVY=;
        b=KRnjK6HIXX92rGYRzCOmFwWCkAnI6bwApfnFOL0qOL54kxc+lFxrcA+5N2slwI8xqM
         GOkha/yHOG74PKxi++sVR8b9r/tGJxWEQlceolrucaO77ZgDp+lPlMJ7WXLOtBrIf+4N
         4O/3Lsjt+1bzC/vWhUZvN1nr8Ry8/qfKfIuiZtv7cRgu73MgNWMihXPhQ1vQdkEQe+To
         WLD+vG5LPLxCKwvocsUJf8Yo3/1M0cWtaGQJu7k/7eVPUYxtxqENL6M+Amj6s1NHC5ZG
         r/o0IOQJPg6vWFTpJE04995wix4SDdgqCEx9prmfSbXt7QzU/1PWSl+3icWPofI5DWjC
         /5Hg==
X-Gm-Message-State: AOJu0YzJcn5uKq4O/OkFuCmM7ZU6GIuVo8Ms8KOgrFQeo+AL66CEEAzZ
	T+zTIYhS1rmgm4bKaJEFSPXoCk/+dvKy51lUIq65y9qJ8xQuCaSsQUt1Mz5ePuA4WacMz2NvtFo
	MpXcFQdlDVs/ACpXR7zXWng==
X-Received: from dleb5-n1.prod.google.com ([2002:a05:701b:4245:10b0:128:d185:c6ff])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:61f:b0:128:cedb:33ba with SMTP id a92af1059eb24-12bfb6f506amr5475335c88.10.1775444687791;
 Sun, 05 Apr 2026 20:04:47 -0700 (PDT)
Date: Mon, 06 Apr 2026 03:03:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIgi02kC/4XNwQrCMBAE0F+RnI2ku62tnvwP8dAmm7qgiaQhV
 Er/3dBTRYrHYZg3kxgoMA3ivJtEoMQDe5dDtd8JfW9dT5JNzgIUHFWpChmpfbLrpQmcKEh2kYJ
 rH7JBC1apujTHRuT1K5DlcZGvwlGUjsYobrm58xB9eC+XCZb+r55AKmkbpQs4FTXU3aX3vn/QQ fvngiZcQ7ANYYao0daQxq7S8AOVawi3oTJDBhWCRdQtVF/QPM8fGkdw+1sBAAA=
X-Change-Id: 20260401-teaming-driver-internal-83f2f0074d68
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775444686; l=3844;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=os2axCD7KWEJ2zFtPn/3cysdH77SPlIUyOJdroZkBH4=; b=6qoJqycbWTs4TwEpZUEsidMSsle0xK00/QUiJRc7vpUPo0GazxeHHdwxIc0C/TS+IwgHrh9tJ
 CVOmgEjSDKyDKddy7eyOUcAcAGVKwC2ARFfGTjsGNCBlLoXiWlPTQ+1
X-Mailer: b4 0.14.3
Message-ID: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
Subject: [PATCH net-next v5 00/10] Decouple receive and transmit enablement in
 team driver
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>
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
	TAGGED_FROM(0.00)[bounces-275510-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
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
X-Rspamd-Queue-Id: 605853A134E
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

 drivers/net/team/team_core.c                       | 237 +++++++++++++++----
 drivers/net/team/team_mode_loadbalance.c           |   8 +-
 drivers/net/team/team_mode_random.c                |   4 +-
 drivers/net/team/team_mode_roundrobin.c            |   2 +-
 include/linux/if_team.h                            |  63 ++++--
 tools/testing/selftests/drivers/net/team/Makefile  |   4 +
 tools/testing/selftests/drivers/net/team/config    |   4 +
 .../drivers/net/team/decoupled_enablement.sh       | 249 ++++++++++++++++++++
 .../testing/selftests/drivers/net/team/options.sh  |  99 +++++++-
 .../testing/selftests/drivers/net/team/team_lib.sh | 172 ++++++++++++++
 .../drivers/net/team/teamd_activebackup.sh         | 251 +++++++++++++++++++++
 .../drivers/net/team/transmit_failover.sh          | 158 +++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh      |   7 +-
 tools/testing/selftests/net/lib.sh                 |  13 ++
 14 files changed, 1199 insertions(+), 72 deletions(-)
---
base-commit: 3741f8fa004bf598cd5032b0ff240984332d6f05
change-id: 20260401-teaming-driver-internal-83f2f0074d68

Best regards,
-- 
Marc Harvey <marcharvey@google.com>


