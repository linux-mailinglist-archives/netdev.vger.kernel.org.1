Return-Path: <netdev+bounces-274382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AAiOqYLzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:24:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E62783846E6
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DB103002B40
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 06:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A20C37CD50;
	Thu,  2 Apr 2026 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjKfYoGb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FB937C0FF
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111073; cv=none; b=JcskgY8Ot1MG2bEdzKV6BhrcFHOdkqetdSAHoSdXtFwqr7aN9McrmRA5LnW1dtT+ncNezg/NxDYSSAJmg04xXp6iVF3p8hitWd49T7unAGjt8S/pV6nRjCeMXVm9d3+UHHwR5BCq7SQxknxPzs6Q29JLXPVIfUau0Zifa32cNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111073; c=relaxed/simple;
	bh=jNNY6xH+1KGT9YM6pvXjPQXXBllRdf1QVqkq35Y6vJ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cM4qlKm7vy7ozaflfXDwIRlNQdJLzZsSXbHek4R/PtbRk4/BWtmaDRtcE7cjzSCZyeha/Xo/yVuSTjM632veYzBtlKfhOoKdDyozJSE9dnWYJNr2oo758l8LxQkRjvr5QAA16zd9OF7HSitfd7h+hasQahgrpwnqFQB/PFt5FmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QjKfYoGb; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c4cfe08c9dso3727521eec.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775111071; x=1775715871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kHhJ1PGkTf+U3ICNlGbkmQaGPWwbR8hI+GskGCVVpx8=;
        b=QjKfYoGbbzBG0nbPHOTamLhb68BKznRS47UOFt8vDlV62DzBUkpmfj6vUHLBo4jqMQ
         H2ELEjMWqStzU8cICCmpIGMZB+7EQlTa5dji9lC0ZnWRTEJEKQPe8zKtRyvSyknfVQlB
         eiTVIaOaZzhRCWR43aVr1QYFV2XdEcJkc90ZXyF0/pBWkEAOlaF6rJ4Huyz3mZTWHF5y
         PflAn+/0D3J4s+BitHSvv4AwGGCUWsoM2dsSBfv8q0IuCvSdI/rk+R11aosE5q5dj44k
         o7iWtP6W9lLRRubZAiJNbkMH9dodMhnvmp2mt2nmVxVIu6wJ7jorP8Azxcfu9k6xcsl/
         6Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111071; x=1775715871;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHhJ1PGkTf+U3ICNlGbkmQaGPWwbR8hI+GskGCVVpx8=;
        b=U2+nWHqonKYkCPKRfNwZNfHQ3rqIIsuky1H741Lz8Bl7QKEKgwLd/ciSKGsBn4E+zS
         sgQ5zkb8F4cfA8N1RQYAox971qkSs7//+TS0TWDSK98+jjxGBQgXHSRLFTC1cjqVK7ZH
         a25GyRYtiGs7apPHy5Fh4CygYgCkvoDLTUxFO4pVL6g1jpBg84olarhRae4MYv3bgXLC
         GiG0O8tZMp0ChEiUOoaraZTqSVLR6nlJOSzHseU8wu4Ls/anfqFSoJG5N97BlL3L8b3t
         +mAd3VFDhv1syUJtsOyXe8r+enzhNsO+3jf+rWAAYEfpKM9lGF6Qo62/9PMmxDQNbosz
         VCgw==
X-Gm-Message-State: AOJu0YxkTjUNpnaLdi5GHqM4/btOGDpC/w80bscS8miqmBNW/6vr/hCw
	OwmESacOWOjkegaBk0/zFw6kpsuwbCJ7WHUH7/9SFB5yVWNyghAN8Y8vKzJ71Sfn1+nw1fn32QP
	iOQWYtN+0CzmC+F1fuOoVXQ==
X-Received: from dybhk14.prod.google.com ([2002:a05:7301:288e:b0:2c8:6bd1:63ba])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:d519:b0:2c8:409:a9bb with SMTP id 5a478bee46e88-2c92db5659bmr3891805eec.0.1775111070700;
 Wed, 01 Apr 2026 23:24:30 -0700 (PDT)
Date: Thu, 02 Apr 2026 06:24:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI0LzmkC/4WNQQqDMBBFryKz7pQxitqueo/iwuokDmgiSQgW8
 e4NXqDLx+O/f0BgLxzgWRzgOUkQZzNUtwLGebCGUabMoEg1VFOJkYdVrMHJS2KPYiN7OyzYVVp
 poraemg7yevOsZb/Kb7Ac0fIeoc9mlhCd/16XSV3+bz0pJNQdjaV6lK1qPy/jnFn4ProV+vM8f +PG4QXJAAAA
X-Change-Id: 20260401-teaming-driver-internal-83f2f0074d68
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775111069; l=2821;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=jNNY6xH+1KGT9YM6pvXjPQXXBllRdf1QVqkq35Y6vJ8=; b=0iQ9V2HUcMbmnnk8AcjAiGI57v+Zdo9KC7s9bBkzcWiyLcDH6ly2Q4tfB82N9u4IwUmFGvH18
 /ng1pLe+ey5DPTujJw9pJLNKva+sHedDvB8PqzHibKg7iTcFo0YxLd5
X-Mailer: b4 0.14.3
Message-ID: <20260402-teaming-driver-internal-v3-0-e8cfdec3b5c2@google.com>
Subject: [PATCH net-next v3 0/7] Decouple receive and transmit enablement in
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274382-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E62783846E6
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
works as intended (4, 5, and 7).

There are three patches with small fixes as well, with the goal of
making the final decouplement patch clearer (1, 2, and 3).

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
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
Marc Harvey (7):
      net: team: Annotate reads and writes for mixed lock accessed values
      net: team: Remove unused team_mode_op, port_enabled
      net: team: Rename port_disabled team mode op to port_tx_disabled
      selftests: net: Add tests for failover of team-aggregated ports
      selftests: net: Add test for enablement of ports with teamd
      net: team: Decouple rx and tx enablement in the team driver
      selftests: net: Add tests for team driver decoupled tx and rx control

 drivers/net/team/team_core.c                       | 241 +++++++++++++++++---
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
 13 files changed, 1100 insertions(+), 70 deletions(-)
---
base-commit: cee10a01e286e88e0949979e91231270ca9fdb8e
change-id: 20260401-teaming-driver-internal-83f2f0074d68

Best regards,
-- 
Marc Harvey <marcharvey@google.com>


