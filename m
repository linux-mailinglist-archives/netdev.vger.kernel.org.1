Return-Path: <netdev+bounces-274906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIAkOw1pz2lPwAYAu9opvQ
	(envelope-from <netdev+bounces-274906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:15:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 666523919F9
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30C6D30333CC
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFBD374E55;
	Fri,  3 Apr 2026 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utWvnz6h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205135FF57
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200472; cv=none; b=u+iDkJWxRPPmilkyFnuPKn/l18sb+3hgYMfIvhi3DEdCBUc1AD3Vygwgwncg33RRlQkM6c+NAQKhsNYr48P5wMfXbFgG1mUdmJvUdxEEZXymRfC+SQodxUNkO1dUeZQIlvTDpDFYB63/04WJjZPWHvZegBSbRI8EgVC3uoHoaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200472; c=relaxed/simple;
	bh=EW8KYf1c/w/FYmF+mNEfWcWh1gUEZj8sImOt5w1jamA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NDZl1MMrMy1TxQoqgvc8+AozmkV8HbZLNIZc6d1rngN9TSuK1UxBKXRihUWMwDk1xZO8dV4xH/UmX3ngxLA6hNCrVDUB3uuDDommn9pN9BanYKxfrPrBOw2Oa87hzCQuWeVx3A6Y1QPrrH3GBz4PuAiH4/yIQy22pCdFihk5Rkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utWvnz6h; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c3b8880ca9so2138216eec.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775200469; x=1775805269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qj1IHyCeC9JWQmqj8CIl1mS6vkiwWXO8x4RE4Fp5E1M=;
        b=utWvnz6h4TzhM4M0JznbBdLdSgtekR+2EbBxCtZQygvweAhYXm95CG0O7QGqd7pYw8
         SaiIweZwaxlkeI7oUadz/VWH8ydHjv0cPdjQ7njvZlJl/TtJEmcXowBNXwVjE/9zaelX
         ioM7VmbCDKB97t2KUJ9IBD2BgQDtJoLHfzoWIIdxLEg6v9YjbCpgkjD9eyabW3onPzgq
         jUuOPqxtgCYyDuO43BuMSmDLQf/eDwAHZzbBwXIOAtakw9m+UU4MktX+UFkCayK8OuKz
         VzVWKSTkodEzDORtCzxyPY0QymvBRWuCg+gyAqZtXBTHZJeDUcQf7gzDTeFY49NbSP+J
         tYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775200469; x=1775805269;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qj1IHyCeC9JWQmqj8CIl1mS6vkiwWXO8x4RE4Fp5E1M=;
        b=jmRSvc+Gz5k5PqMyi9fUtpxqCvMRtkeTu++F/NN4WYJ5/zvHcjP8QTJ97q02SfJwPe
         aRG/mxP/eOxXRME6k1LF+eCRXufdhtOVMlN0XkeupwmD/pbUjHsAByH++7eskFAVdLpO
         WUrL4WwGyPM2BaA44LR9DMP+3EXYBh6o+PyXveIkeMwrumGCYyCVpDM4Ya6iqVVtu50V
         OEywpob6pbXL7jI5Kdx0Q4Y5UpA0sO4/jbQdAFnqhQOQJmOgPSixdDG5fJs2D5UyVfDe
         uNLltsyUU5v8x/YUc6FXvQj+pAvFUGpq4g4hI+1x/vK+rzG+hxDnkWB/+O+FAtun+YIa
         /4sw==
X-Gm-Message-State: AOJu0YxcxbZMDObzBzTG5q27cgXm810tbTulALBGjqO5JYCRg/h8DnzI
	bF4F/cs5U9G40Cg++TzyyUgCIBjk9+IRweSeY/Bb35gQs1xEPTpkewbFz9Vbt/Xu7iMtDk/pMIx
	APrvPdVPDkHYjCke5fxsLAw==
X-Received: from dycmz22.prod.google.com ([2002:a05:7300:ea16:b0:2cb:45a9:2264])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:c010:b0:2cc:600d:2ff5 with SMTP id 5a478bee46e88-2cc601c7db1mr293473eec.18.1775200468649;
 Fri, 03 Apr 2026 00:14:28 -0700 (PDT)
Date: Fri, 03 Apr 2026 07:14:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAM1oz2kC/4XNQQ7CIBQE0KsY1mLob23RlfcwLlr40J+0YCghN
 U3vLmGlC+NyMpk3G1swEC7sethYwEQLeZdDczwwNfbOIiedMwMBrWhExSP2MznLdaCEgZOLGFw
 /cVkbMEJ0jW4ly+tnQENrke/MYeQO18geuRlpiT68ymWC0v/VE3DBjRSqgkvVQTfcrPd2wpPyc 0FT/QnBb6jOEEplNKp6OCv4gvZ9fwMO+0FDEgEAAA==
X-Change-Id: 20260401-teaming-driver-internal-83f2f0074d68
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775200467; l=3241;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=EW8KYf1c/w/FYmF+mNEfWcWh1gUEZj8sImOt5w1jamA=; b=HBn+gRL/62VMxn6FPwumRTS2wPMpbEgcNcfaMow6hE9bt3+lUsQlUEW8ZIJfiOA0Sj7EtlKcv
 JHLH+UU2qxVA+EHDb6NPwmHkuk4UTIWvRkex+yxFW8NN7ZB6BxubRCk
X-Mailer: b4 0.14.3
Message-ID: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
Subject: [PATCH net-next v4 00/10] Decouple receive and transmit enablement in
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274906-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 666523919F9
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
making the final decouplement patch clearer (1, 2, and 3).

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
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

 drivers/net/team/team_core.c                       | 238 ++++++++++++++++----
 drivers/net/team/team_mode_loadbalance.c           |   8 +-
 drivers/net/team/team_mode_random.c                |   4 +-
 drivers/net/team/team_mode_roundrobin.c            |   2 +-
 include/linux/if_team.h                            |  63 +++---
 tools/testing/selftests/drivers/net/team/Makefile  |   4 +
 tools/testing/selftests/drivers/net/team/config    |   4 +
 .../drivers/net/team/decoupled_enablement.sh       | 249 +++++++++++++++++++++
 .../testing/selftests/drivers/net/team/options.sh  |  99 +++++++-
 .../testing/selftests/drivers/net/team/team_lib.sh | 115 ++++++++++
 .../drivers/net/team/teamd_activebackup.sh         | 217 ++++++++++++++++++
 .../drivers/net/team/transmit_failover.sh          | 151 +++++++++++++
 tools/testing/selftests/net/lib.sh                 |  13 ++
 13 files changed, 1096 insertions(+), 71 deletions(-)
---
base-commit: 8b0e64d6c9e7feec5ba5643b4fa8b7fd54464778
change-id: 20260401-teaming-driver-internal-83f2f0074d68

Best regards,
-- 
Marc Harvey <marcharvey@google.com>


