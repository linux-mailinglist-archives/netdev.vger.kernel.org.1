Return-Path: <netdev+bounces-281585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNw+HZET8GnXOAEAu9opvQ
	(envelope-from <netdev+bounces-281585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:55:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97E047C8AF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 020E5300BCA4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D062D97BA;
	Tue, 28 Apr 2026 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m26eo4X/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1770C2C0F69
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341326; cv=none; b=T6MZej7RN4oMghJYbqd6cdJKzqoN4g3pCdBQ06opOc4mqa608IuqWN7w3KCjvXMeC8+CfhbKz+6OuY4GUi/1ZsVIXkl1l8iWCN96x2ex6vm8T2AvDdxx7wKEWoys/pzmxi8TXjKjYBX/7eZ8WY8bXGZ7pW2u0sng2e9kg8fuOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341326; c=relaxed/simple;
	bh=Lp4FgAS5IXrLpC+iwjVCifRhAKPBEknYqsntLZxXErc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EHPoi/yeLY6NF1sRjJDwYCh7nsLXfq23+RiwRdsq77TKPRPpt5Eb9WWKBzVExbcmoLX8qo5z4M+L+5jsCH+AxY+UnClEgmJytRy8ucp3jwsynhME4EuqMf5NumzrGcy8/wlhAdz6DkQBv+CioSHYLM2hangL7jMy3+8vkZo3VtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m26eo4X/; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2dec803f9f0so6067532eec.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 18:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777341324; x=1777946124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1mCgWFWudVfBQtdDsUREHZ7Syu7GCFnDU4PVfnBvZk=;
        b=m26eo4X/hfhzyNDa3F0C5ud1PpOZDmKzk0DdF5If8/YqtGTPIr9Gcvkvda/b/v24bh
         1shMhAhrXfSonssEMWxB4vNcc+TCkdCsPeizc97JP3o+hAQt2rl/4E1Fdc7mKtBG5tLz
         IbFHXlzVzZMY/kaulEacOpssGhciHW8Eajx/7LCsQ+ZTLfXcCaLxySBUOL3MmICAx07t
         H8k0Z2tXEgBcrKNroQCFMaxGxSacg1lRhz5/iqp7j+Wz+cMWC6rrlL6vBAyKoi0r/kQN
         FbS03n7x6gBYiZpTSqOSSiX4dcaOCf4RJjmxa57K5h46geKkUEUg1v76nuXu7llAzcOc
         Iufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777341324; x=1777946124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1mCgWFWudVfBQtdDsUREHZ7Syu7GCFnDU4PVfnBvZk=;
        b=egOH3GiHxbIbbaJDvQbGqmP0f7bjSKhDhIw506kg8KC6hZ0z6Vh0rM3hPLJ8N8+4zg
         bmA1TAb5XRKL0kxiD98Fgaulh/rve8q1kyYcaT19W6vQZSQ5IYcnVnWlt47P6/AQmV48
         wjcuiZ1ODDBdQ86mrAWU1eWw2hj4CTTwXLbV/mYEp00t4mlxqGU0hNbYbOFywCtS1tO7
         o7aZId+mi7kOH64bvPt2OqyLwCaIC2s8Hv0ztUki5QAgaYQoM/6FIi85LckmmnMQvtt9
         Ffl+ZYpkG0Rq2mdUmFXCJmReP0S8M25Zpy6Xh6QC5c7fUHINaT72IqttOXNcvkyyfyd6
         Mqig==
X-Forwarded-Encrypted: i=1; AFNElJ+LU4H3aKuPTg3wUNFdf8wEJgtdgqdi+pbhYyVRNiGOdLAQWWMkfADA8pxo7g82gomaJ3Vu3eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWK1pgkS9psD4XNzPivT9JKnqksELFvuhXNffr46er9YRcmF64
	1+Xgb7e879KDpRvXGW94g+MLOzbsQykD+ICB8t6Wtj7nWAjjmUjCjl/c
X-Gm-Gg: AeBDies6y5pQTlXEMQE646vlWGl8gbus0gEbSUnOVRRmx9BN6nF02ACuiuk0sCEtfnM
	PrmMpb8qr9scRtYucid4D1Er2gXSJY8NhGBvgl3jKv+GSX6Irvp38y2hqpL3MVtgaZRw5CSc9OB
	dSJ3gLoYj0BNuUeXk+ROFHVq2P6UvWD1fFkLEhyEWD2UT69EInHBbLCa5CRIv7XnB6qW7cJIsAN
	H8gHCrnhec5ZeyXdYgNrTZ3d/++qtfueRkIWJv2HD17FMHqDWoGW9SNQBsU7C20RZmhCU3IeOeM
	h4PAq8Uc+Vas+u5HclEATq+SkLqOlDGldsiz5xri8qsUJrOlhXnOY2r6GotRS6BOMLDBayjR1dM
	m+ZstXUcW4Q20NPPr8NXx5ltjE2gHajU6LosUNVqWodRna7n536QK6bjdzUvl09a7d6Ltr6+0ik
	CvIgo5DRQt7w/WoW62MEAh1CoKcLN9G4YCgUEiUE6ZS3ifOgZdvcyguwM9G5jHmKCvhuw9R422x
	jq2t8DcU7xZ68vIUlWE9bTpGQ35mpgzVrdT1zpTkDdtUZPzV8sTpZmsST0P55DQ2LxM+qjvqOMG
	EGluO3Ft/K+pQI3yQeucRM6S1368gZ+bHZFo20g=
X-Received: by 2002:a05:7300:2d22:b0:2c5:6140:54d6 with SMTP id 5a478bee46e88-2ed0a3e8087mr459756eec.1.1777341324033;
        Mon, 27 Apr 2026 18:55:24 -0700 (PDT)
Received: from appmana-001.i.appmana.com (23-93-84-4.dedicated.static.sonic.net. [23.93.84.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed09f8a909sm1233947eec.4.2026.04.27.18.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 18:55:23 -0700 (PDT)
From: Benjamin Berman <benjamin.s.berman@gmail.com>
To: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] thunderbolt: fix wedge under sustained tbnet load on AM4 and AM5
Date: Mon, 27 Apr 2026 18:55:19 -0700
Message-ID: <20260428015521.3454006-1-benjamin.s.berman@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C97E047C8AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281585-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjaminsberman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Greetings Thunderbolt maintainers,

These patches for drivers were tested by me, Benjamin Berman, a
software developer, but they were authored by a coding agent that
had access to and ran the patches against real hardware.

The purpose of these patches was to fix Thunderbolt networking between
Thunderbolt 3 and Thunderbolt 4 (USB4) hosts on AM4 and AM5. I observed
these issues when using nccl across a Thunderbolt daisy chain: the
connection would drop abruptly, and performance was poorer than
expected. In any instance, I had to also update the NVM by exotic
methods on the TB3 controllers for AM4; AM5 generally ships the
Thunderbolt controller NVM in its UEFI patches.

Please advise on next steps for how to improve the patches. I can also
make my testing environment available, since it has a bunch of random
but useful Thunderbolt hardware.

Below is the generatively-authored explanation of the patch, and the
patch itself:

---

Two changes.

1. drivers/thunderbolt/nhi.c — tb_ring_poll_complete() gates the
   unmask on @start_poll rather than @running. Under load on NHIs
   with several rings in NAPI poll, a race with __ring_interrupt()'s
   unconditional mask leaves the ring masked: MSI-X stops, NAPI is
   not rescheduled, carrier stays up, no driver event fires. On NHIs
   without QUIRK_AUTO_CLEAR_INT, stale REG_RING_NOTIFY_BASE state
   blocks MSI-X re-arm. The patch gates on @running, adds a posted-
   write barrier, and clears the ring's pending bit before re-enable.

2. drivers/net/thunderbolt/main.c — TBNET_RING_SIZE=256 and the
   netif_napi_add() weight of 64 produce ~1 % rx_missed_errors on a
   TB4 transit under sustained tbnet bulk traffic. The patch raises
   ring size to 2048 and the NAPI weight to 256.

Hardware tested:
  ASRock X570 Phantom Gaming-ITX/TB3 (AM4), Intel JHL7540 2C TB3
    controller, NVM 50.0
  ASUS ROG STRIX X670E-I GAMING WIFI (AM5), Maple Ridge 4C TB4
    controller, NVM 43.83
  Monoprice USB4 Gen 3 40 Gb/s passive cables
  Linux 6.17.0-22-generic (Ubuntu HWE)

Workload: NCCL 2.28.9 all-reduce over tb-lo, NCCL_ALGO=Tree,
NCCL_PROTO=Simple, three ranks. Pre-patch the connection wedges
under 1 GB transferred. Post-patch a 192 GB run (3000 iterations
of a 64 MiB all-reduce) completes with mask/unmask counters
balanced and rx_missed_errors under 0.005 %.

Built clean against linux.git commit 3b3bea6d4b9c.

Benjamin Berman (2):
  thunderbolt: drop start_poll guard in tb_ring_poll_complete()
  net: thunderbolt: enlarge RX/TX ring and set NAPI weight for sustained
    load

 drivers/net/thunderbolt/main.c |  4 ++--
 drivers/thunderbolt/nhi.c      | 22 +++++++++++++++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)


base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
--
2.43.0

