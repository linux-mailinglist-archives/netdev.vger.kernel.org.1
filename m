Return-Path: <netdev+bounces-276245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEnmEhLD1Wkx9gcAu9opvQ
	(envelope-from <netdev+bounces-276245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:53:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3533B6521
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1352E303A3C6
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6358336606A;
	Wed,  8 Apr 2026 02:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n++Xug9R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4B1A239A
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616752; cv=none; b=BG2+xJvutj1af443q7BgJ6g29EggXZNwU5G3Gb93YcpG2aYaJbG0E6hJjLCRmaXTyZGuOTgvmQ5j7BYjtzjAi2M2o1X5xyCuIVRE3O4yR/iKB3+meExcXuECUWCKfXiQ5T/6FbmxmlbKqzx46m0Hk5706hBRvLrTfg1IqmtVxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616752; c=relaxed/simple;
	bh=lnkHt0LcGp7r0bgQPA+nYiHe7Bo6MDonp2asKzbl2pY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NKM4dzfkLrXiiofMFt8vEMs9A2L9TXEd0pzbKtQE8Jl2gQC3oyOixbk21Z82m4VmjKEEYUuyEwUE72aRxbINc2N1XgPipNOMVNlBuyhh9JqToF3xi4sU+bAzkXdXro5TVnT96AqwF9UL8dSY8sPnTS48kbvSuw99doFOLWT7doo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n++Xug9R; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ceef8e793fso10244027eec.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 19:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775616749; x=1776221549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=41nlgVSog5fOkOax/2zDhaWi/Izx635JwzvhBcYRItg=;
        b=n++Xug9RSVrngeBYlVqkPwX0tDNaHOAb8tebTesfxKwmLR0ZkFTL/vQx8jufC41ipr
         qxp9+k6NsrYV2clzdS7Z8seObzSr6ZOE1odhzE718mLCreIllFiX2AfZx+yaNuttdv78
         hcBb34loUwrh4CgpyMTQyisAKIt+LYBbVXGMYg6N+ZWSu8GJcNQ2eTObWnDAAwvfu0t0
         KAZC3qUDAvNDsliXF2cgeoD2J3SMoH3/lGYiC5fsmxD5c5JN4J/3h7jyJ9PJtK9XlAY+
         Fg2WAzJJ/X8TMchGfoBapSLXVTm/CYJJLmfymIYPD71Rvx/4JbEEiL2IT/CvQjoyUVpt
         Qg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775616749; x=1776221549;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41nlgVSog5fOkOax/2zDhaWi/Izx635JwzvhBcYRItg=;
        b=ARYqvtd1krmeKCL0yAv2UGUgsXSfwwaiNh+p2blr1H0ZZ/5v1nMqZ6rhTTO4SgjWJA
         +pysx8HNhGeQuy4DfAUVWygxxtsT1iZ2x0+VTiYQ7nDQ9YIYktGfKFy55MljebRojLKh
         JdMcr0aOPwICyC9sO+GPTwcfJPv4YHj7ia/ZUBC6PXUX9ZzIX1EdPoZ96cK0AtzRuqlm
         qUz3o4xD5+Rj3aZKytl7r+ZDs1IgmosnAmVH3+1wqpkrP0oVqk/Si+dTEAzKx6KFng6u
         J6dncyVV+6XtiylneaD51NQAjJg0FS1w/r2LuLdIIx2HeoHO86RLQSsb2TZWF//itx2I
         nd5A==
X-Gm-Message-State: AOJu0Yz/fiXj4+vs0bFPaGObE5RHtjx7tyc2/11Ij5sa9WFFJ8JHl/yS
	PVi95tgvWitDXJ1HTY1EVoGckBZk4fCMEf5tgsSrrrzrhXDKLo1qcmMRZN/oj+SrZKE0lZm7QsN
	LbZiAk8oBU6MgIutPD3Jubg==
X-Received: from dyclw17.prod.google.com ([2002:a05:693c:2111:b0:2cc:9943:d1b2])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:3c9b:b0:2d3:d3f:2429 with SMTP id 5a478bee46e88-2d30d3f2ce0mr394234eec.0.1775616749091;
 Tue, 07 Apr 2026 19:52:29 -0700 (PDT)
Date: Wed, 08 Apr 2026 02:52:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOPC1WkC/4XOwWrEIBAG4FdZPNdiZkxie+p7lB5cHbMDu1qMy
 JYl717xlLKEHn9+5vvnIVbKTKt4Pz1Epsorp9jC9HIS7mLjQpJ9ywIUTEqrQRayN46L9JkrZcm
 xUI72Kg0GCErN2k9GtOvvTIHvXf4UkYqMdC/iqzUXXkvKP32yQu//1StIJYNRboC3YYb5/LGkt
 Fzp1aVbRyvuITiGsEFkXPDk8Dw6eIL0HsJjSDfIo0IIiM7C+ASNe2g6hsb+kcWA2tjB/YW2bfs FQpzIn6QBAAA=
X-Change-Id: 20260401-teaming-driver-internal-83f2f0074d68
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775616747; l=4135;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=lnkHt0LcGp7r0bgQPA+nYiHe7Bo6MDonp2asKzbl2pY=; b=Qt4jVSAfS2f+ouFRqKGmtw1U2nCWBzh16Xipav3rRx17/cTy59G8vS6FV3nGNEXPUmpSrYL8l
 oMlGqLEDX3GBBCYtFOEgpVvIqEraWjWmOm95bS3ejDTng42vqut15se
X-Mailer: b4 0.14.3
Message-ID: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
Subject: [PATCH net-next v6 00/10] Decouple receive and transmit enablement in
 team driver
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>, 
	Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276245-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF3533B6521
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
 .../testing/selftests/drivers/net/team/team_lib.sh | 174 ++++++++++++++
 .../drivers/net/team/teamd_activebackup.sh         | 246 ++++++++++++++++++++
 .../drivers/net/team/transmit_failover.sh          | 158 +++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh      |   9 +-
 tools/testing/selftests/net/lib.sh                 |  13 ++
 14 files changed, 1197 insertions(+), 73 deletions(-)
---
base-commit: 2ce8a41113eda1adddc1e6dc43cf89383ec6dc22
change-id: 20260401-teaming-driver-internal-83f2f0074d68

Best regards,
-- 
Marc Harvey <marcharvey@google.com>


