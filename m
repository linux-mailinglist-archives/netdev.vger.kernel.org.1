Return-Path: <netdev+bounces-273897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL1nHRW2zGnMVwYAu9opvQ
	(envelope-from <netdev+bounces-273897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:07:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D2C3750B2
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0EDA307B205
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 06:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2E43314C2;
	Wed,  1 Apr 2026 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CtSCfDq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E772C236B
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775023544; cv=none; b=DJ0Wc+IFZuL1GRJQy1ASkZ5Q5b7WNeQj1U61X7lsfKCUJotweGxEVpa1d/Q8zivig36BarGeLduM5jqvhpLlU1s/jXSVhyXyf6lyPM6EI/x7KZL2o0GLOdUdwqrrBMHrHk1NZBBLVU9SSe6XrDP/AbwMF1qvQFte3dlMyVmTERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775023544; c=relaxed/simple;
	bh=15hnnoslM5ivK5iHcnK9XCmoGjgYdOmkj5nkTKztHis=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ntTMddudu3qaYnaxB4FXjmCCYKb+M6TTaDrhgMJvLHqtpvXr51W7QTI6Ul8ESpWPZO0Uy63NBdPAU3J5WsvAMICfocZCkK5twwtExZL1k+V9kbfKHk73B8Z5BR8zgm1szjix7tpd00Qbo9n2dS33Im7uWKFBK41ItUYKao0QDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CtSCfDq4; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c5b48baf75so6451690eec.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775023540; x=1775628340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iHiW2fA6FQ0gm2ne9i1cNEZehf2oFJcgxVJhfgdRX+k=;
        b=CtSCfDq42IRjUvgb5MQgH6FcQCPwhDSL2JNfp74Z+w4SZpw9MH1XRcWPoN/Yj9CNJr
         R7e4bwDwyDz/YT+/tyMNe+5SkZ5S9AdG/LZBIzTwh5gd66aJbhoHnsQdVcCV6PyZpPwo
         IjUcC6M0/2sGUAaEPNPlXefmYm4NQOIq7IfJ2vfvCWTDWBcWSdScEF3zNZAnvI/8WNDG
         aNqlGNA2k2qt8s/71UcOB/hYA5W9sOXsbmFQUm/oThp0TIFZ3m/sHcoB6NNK/nzCNFpM
         YCfklEdvA6+Yj1jQBb7IwjcH+TbqLTGKAbNv+o6lmYxukP74xAJE6GkO8RcRI5CrmWQu
         o5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775023540; x=1775628340;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHiW2fA6FQ0gm2ne9i1cNEZehf2oFJcgxVJhfgdRX+k=;
        b=Vm2wMV9zD40kvcgEbSC5RA8+gnxsqoCOlL9yMcws0pisODNs0203tR37SKRakzSx09
         SL1W77oN8IWOwQjKGGGIYQTmO5RBgON+A9yTZtHvyBq7VZlC3xbXdQyenbA6E/WYNB7+
         ve5g2tbldE6IPuL2NM/RSAKfhxLNy0kMmLAnsPUzns82o4b9IQn2gW0AaVPkWvjQJGcj
         lI+NNaEKzEqLnCAhxqVnBrh1aEreCnQlKL1AzZBXVbQ3qw7nQViYCgNQrlqTfsu8WM1k
         XvUrd9D6ejnXec2Eyp0JYm07GiPYgoGsDMxGWcUPqJDRTtHxQ5A/JiMZkp10WqIJncoI
         La2w==
X-Gm-Message-State: AOJu0Yz75k6xMk0z8HugI+H7IlwDi5AENbe7gv1KX6Xfu3PohPuwtjnw
	8YG3WAGDNVSIB3mgHiih70o3qu11g03Rfhif6nbNTOm0q6s62M32bmzDpH4ZWQa98HUwObs969r
	6QFVA/JoXjyaVkSzaJCd5SQ==
X-Received: from dyx7.prod.google.com ([2002:a05:693c:8207:b0:2be:710c:1d1])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:cc12:b0:2c4:ec89:be7 with SMTP id 5a478bee46e88-2c9328a61eamr1278254eec.23.1775023539614;
 Tue, 31 Mar 2026 23:05:39 -0700 (PDT)
Date: Wed, 01 Apr 2026 06:05:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKS1zGkC/x3MQQrCMBBG4auUWTswxtIWryIuQvOnDtRRJqEUS
 u9ucPkt3juowBWF7t1Bjk2LfqwhXDqaX9EWsKZmChIG6eXKFfGttnBy3eCsVuEWV55uOWSRsU/ DRK3+OrLu//ODDJUNe6Xnef4Aj72PIHMAAAA=
X-Change-Id: 20260401-teaming-driver-internal-83f2f0074d68
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775023538; l=2643;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=15hnnoslM5ivK5iHcnK9XCmoGjgYdOmkj5nkTKztHis=; b=fQbE9ksUrfC8qptLzLiYHMfnYBevOZ6D8FSBuBZVce8T2nj/RRv72+dlwQziYQCVdsxPfxqu2
 CyMX2suukVqBlTKD1kTCjz5PEhdPAa7vOfYZq32rv6ZDrX4j9+v4qOO
X-Mailer: b4 0.14.3
Message-ID: <20260401-teaming-driver-internal-v2-0-f80c1291727b@google.com>
Subject: [PATCH net-next v2 0/7] Decouple receive and transmit enablement in
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273897-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5D2C3750B2
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
 .../drivers/net/team/teamd_activebackup.sh         | 207 +++++++++++++++++
 .../drivers/net/team/transmit_failover.sh          | 151 +++++++++++++
 tools/testing/selftests/net/lib.sh                 |  13 ++
 13 files changed, 1090 insertions(+), 70 deletions(-)
---
base-commit: f1359c240191e686614847905fc861cbda480b47
change-id: 20260401-teaming-driver-internal-83f2f0074d68

Best regards,
-- 
Marc Harvey <marcharvey@google.com>


