Return-Path: <netdev+bounces-273465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DvgDG1dy2lJGwYAu9opvQ
	(envelope-from <netdev+bounces-273465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:36:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFB83642B0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF8A3012C5A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2388A36EABD;
	Tue, 31 Mar 2026 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIv+GCBA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A7536D51F
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935265; cv=none; b=PorWRL6c+wRcGBn8soirdDJc7/PgsaLCURdxCewYYaDyoePY9afAe62sTsRjFiBSs/pxeLrVNNtpcjNyMAF5iEoGuuz1OBMGFmXSFLpa9AJtvnBKJStyztxNyMXudrTt8oWRqi0UTmOG09W19R7wEPz14HPuKPvbK2Wgice1slg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935265; c=relaxed/simple;
	bh=LypP5TvHBGUpwgm9IIzSGl9rh7prtq+QWmrtNtjKXfI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KR2I8Uv49376xJQVhJLPnnKKMGVepmZeMvNjV58CmLfqsGW4ji7woifahkNf1raElZEBldq/xnWnqJdCUAj1L3T4c2/UNnc0dEdTRwZOh/V8lKaBYRkiORYea3fe1Qq+G53IgjA3KWJVAjeRotQ6qNA2qfTPeHnViFYJF24M8MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIv+GCBA; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c16233ee11so5556473eec.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774935263; x=1775540063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g7TxFxoQB12ZdFLHuJA4IXnVez6sPeZr+Rc57EvugjU=;
        b=uIv+GCBAJ3tu/UbiOJa54XBZXckS1esrHsS7I8CD4faT4u5lALmMdexuON9MqKN7gD
         XnqaCrh4pz3oFFQQpooes5S6wdVV6bHX6zwUEkfYuo1n/axLJJMzF5mpqpPisDAjjxys
         ++1MfOggsAn/5IlfyJox90DiWIzgM4w+7gaqGaxcFISDeYoQPRFtDUJXQkMvmfyibKcr
         frhee3tUaCbQ6uhpluqQfrcPWdWe1RE8TZl8A1AemnTDijwLaHFqdGbdavIzPkeMtYVu
         /EoJ1U/CbOysKB0Y7kbnNeAk8jNA81NLibJnGXJvikkkABq04jBtJgQK2kAvpi1I2KmT
         N0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774935263; x=1775540063;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g7TxFxoQB12ZdFLHuJA4IXnVez6sPeZr+Rc57EvugjU=;
        b=qU+I6c4U4aZLN5BlCU5sgENxx6TwEY01zQk/fGUA4BxAUG0M9zAIM7y6H9MyxIgvJs
         P6vpdJ20WQEadIRZwUbjGbXxZx9gHuuIefgocVp0lI4muFkSOKBVey996VqnjUP59fJB
         ArmkndJFmIzpAiypglZuzX1AcZi3fk5+ZN3Fy3pJmB9mhJvcFWTIkyu5LaNTSLc2GYgm
         1LmgLvZ7vxwJMxUwGk0xRqCTYmpmB/PEGf8r3me7y6+hiU8SGrq5zLNJR2BgW86pnu9z
         FNPm6w21KeNEEvF0HZybMylDyoDHW4LzkDfs43dBYSSJfhQIu0osL9EWPFp/Re7K6AC7
         iFEw==
X-Forwarded-Encrypted: i=1; AJvYcCV7mI7sxKI2h/FVQuRmPo4H1Ztl2oBOT7E/OIOLlLv3sAz1G2q3fGcZfXQf22mzZ7iLzMF/CCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmn/g+c2doYybPw20hsVziF+My5wsetFZtfeGlE1BT5ePIHoFu
	72/PlFrICiE11Fq2CNbPc2yMxkLrxZtSneaD6O3hixAAU1zMzx3C4N9j8XL2d2cG9K8SnOD3JSz
	SNaZ2iLVNylaOhsshdYJl7g==
X-Received: from dycmp17.prod.google.com ([2002:a05:7301:711:b0:2c4:e093:7c6a])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:3d19:b0:2c1:571f:b824 with SMTP id 5a478bee46e88-2c185efdd70mr6909484eec.30.1774935262628;
 Mon, 30 Mar 2026 22:34:22 -0700 (PDT)
Date: Tue, 31 Mar 2026 05:33:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331053353.2504254-1-marcharvey@google.com>
Subject: [PATCH net-next 0/7] Decouple receive and transmit enablement in team driver
From: Marc Harvey <marcharvey@google.com>
To: jiri@resnulli.us, andrew+netdev@lunn.ch
Cc: willemb@google.com, maheshb@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273465-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DFB83642B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow independent control over receive and transmit enablement states
for aggregated ports in the team driver.

The motivation is that IEE 802.3ad LACP "independent control" can't
be implemented for the team driver currently. This was added to the
bonding driver in commit 240fd405528b ("bonding: Add independent
control state machine").

This series also has a few patches that add tests to show that the old
coupled enablement still works and that the new decoupled enalbment
works as intended (4, 5, and 7).

There are three patches with small fixes as well, with the goal of
making the final decouplement patch clearer (1, 2, and 3).

Marc Harvey (7):
  net: team: Annotate reads and writes for mixed lock accessed values
  net: team: Remove unused team_mode_op, port_enabled
  net: team: Rename port_disabled team mode op to port_tx_disabled
  selftests: net: Add tests for failover of team-aggregated ports
  selftests: net: Add test for enablement of ports with teamd
  net: team: Decouple rx and tx enablement in the team driver
  selftests: net: Add tests for team driver decoupled tx and rx control

 drivers/net/team/team_core.c                  | 241 +++++++++++++++---
 drivers/net/team/team_mode_loadbalance.c      |   8 +-
 drivers/net/team/team_mode_random.c           |   4 +-
 drivers/net/team/team_mode_roundrobin.c       |   2 +-
 include/linux/if_team.h                       |  63 +++--
 .../selftests/drivers/net/team/Makefile       |   3 +
 .../testing/selftests/drivers/net/team/config |   4 +
 .../drivers/net/team/decoupled_enablement.sh  | 200 +++++++++++++++
 .../selftests/drivers/net/team/options.sh     |  96 +++++++
 .../selftests/drivers/net/team/team_lib.sh    | 145 +++++++++++
 .../drivers/net/team/teamd_activebackup.sh    | 208 +++++++++++++++
 .../drivers/net/team/transmit_failover.sh     | 155 +++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  13 +-
 tools/testing/selftests/net/lib.sh            |  13 +
 14 files changed, 1084 insertions(+), 71 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/team/decoupled_enablement.sh
 create mode 100644 tools/testing/selftests/drivers/net/team/team_lib.sh
 create mode 100755 tools/testing/selftests/drivers/net/team/teamd_activebackup.sh
 create mode 100755 tools/testing/selftests/drivers/net/team/transmit_failover.sh

-- 
2.53.0.1018.g2bb0e51243-goog


