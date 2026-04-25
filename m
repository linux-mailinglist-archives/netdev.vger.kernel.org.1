Return-Path: <netdev+bounces-281078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKk5NtwJ7GnNTwAAu9opvQ
	(envelope-from <netdev+bounces-281078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 02:25:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E42446437E
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 02:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76C6C300683B
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057E513DDA4;
	Sat, 25 Apr 2026 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCdO4Ntb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CBA2E65D
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777076695; cv=none; b=fVL8CmdUTmZpMqZK7cveRY+s85wYjtGyVa1Iq4wg070yjplnrqafLOnzGCSvsB7swUH8vNjg/Ak6K3resteyZwQJqqgTAjg1JFyHNG6eaY+ZR5Mmu1ey1TF+IJ1Ul6x0Pg/gtiBJQyDyFSl4LH6hbt+m04MTdn9BFM+VivzQ714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777076695; c=relaxed/simple;
	bh=WIiyS90pJo/dq1FBk/ThSR2bm4kIjajfTMjARat9LQM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j6XKgSBq4HfaD4UiuxZGHNsYJ3PnzkQfZMHceFaA31sdajgFXp0yWFVg+m2dyUQ1CyZlAWH+dcfIz0B+hg4rdVABBLDoFUCETvDNzGnobbgIc6htLRJEpavMtpDbN1tsZJWWz1PLNM/k2R/s165dMCKHF0n1iDY3hd8CW3Sinw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BCdO4Ntb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c79281bd14cso3303073a12.3
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 17:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777076694; x=1777681494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PYg1g2whAdToCIlCbKeMv8kVRwwvGZDddkpfcq7roXM=;
        b=BCdO4NtbnrvKNxthjoIzNIv9MiH2umkkpsBrD0n/AD2YSMn6gYps2w1S8QT/J1JYhd
         xsUJXKm7uP9dueAl8DOJbhnii6QVsQebh9djFjsvydca9veFIEJgJFg3gBkwWEMYBUOo
         fsK/i7lQxD5cjou5hnucdfPInhRD0deGfaJBCdp0Pp9wIHs2iXMW56ydwvEG1wVSqZGZ
         ssIkPKj5bz6yVv9OWwqyF+ciM43rUx5Ep61J5jHjeWvaXvl09/Hvbpvet9ZqObmlNPmL
         jwBm9ph7HHdB1OdEEBU19vWiDQnvvreJoKGTwG2xc/90VX7YGyIMvealrWmgLG2VJieU
         tHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777076694; x=1777681494;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYg1g2whAdToCIlCbKeMv8kVRwwvGZDddkpfcq7roXM=;
        b=KTdcOpEfsEx/c3wSrWhZDcZIclynUN9fUqhy4Lp4q3fLY/oU7nErdc+++WG9thZoRk
         Mu+EwHDW2wnAa38dSyHeyu4Cp1PuvfJHqXyQNogKBGWsPpC7gTQ89LOnTlcJeumHuf/X
         CR8C6aE9m2OqzF6VYo7LUEZooRNAmPjomz0RRhlxx5KE+ZXJajUBwYYxLDJy36RfLfYX
         TmE0cmwX2VuQZrVKOXw+VJ1kWIiyPcQ+375umfkCGhmpf3STihoadrgwAIzEjqAQvhVQ
         2cYuMGSd7CRfkQQp36PmJiKbezQp/Rdye2JXJAlXFKP5pLmTcOoZJ6ynKrIwYZQOlVca
         aZiw==
X-Gm-Message-State: AOJu0YxxyhJOb7OsM7+QtAjr8i+umNqfqDKFwdSZfw+MI8H4LCcWol9I
	gqDdhiwI1W8kGlrNAJ8e81jtBtbQV8xoZF12nkYPeZCMZ9SC+fG5r/O6WOmaqWjO0lShaeMTbMR
	byFGQOOlqQVyH72BjfAxHee2Vhl4bTVEhDwUdUdLT+3tyw3nPmBcp6z3cEdJdtcl+8kvOmJ7EED
	a13Xdf9wcf2MMp9BFU8hkVDnttL8EH98r8SjZwRgzLYt7ZAWBR7+HwCwvWbYHynEo=
X-Received: from pgde3.prod.google.com ([2002:a05:6a02:303:b0:c76:af01:d1a7])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:72a1:b0:39c:cdb:5d81 with SMTP id adf61e73a8af0-3a08d8a4436mr40480650637.32.1777076693728;
 Fri, 24 Apr 2026 17:24:53 -0700 (PDT)
Date: Sat, 25 Apr 2026 00:24:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425002450.163421-1-hramamurthy@google.com>
Subject: [PATCH net v2 0/4] gve: Fixes for issues discovered via net selftests
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6E42446437E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281078-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Pin-yen Lin <treapking@google.com>

This patch series addresses several issues in the gve driver. All four of
these fixes were uncovered by running the net selftests.

The series includes the following changes:

- Patch 1 adds NULL pointer checks for the per-queue statistics code to
  prevent crashes when the rings are queried while the link is down. This
  was discovered by the drivers/net/stats.py selftest.
- Patch 2 fixes an issue where interface stats would go backwards when the
  interface was brought down or its configuration was adjusted. This was
  also discovered by the drivers/net/stats.py selftest.
- Patch 3 ensures the driver falls back to the default minimum ring size if
  the corresponding device option values are exposed as 0. This prevents
  userspace from configuring unexpectedly small ring sizes. This was
  discovered by the drivers/net/ring_reconfig.py selftest.
- Patch 4 makes sure ethtool configuration modifications are done
  synchronously before returning to the userspace. This was discovered by
  the drivers/net/ping.py selftest.


Changes in v2:
- Link to v1: https://lore.kernel.org/netdev/20260420171837.455487-1-hramamurthy@google.com/
- Add a NULL pointer check in gve_get_ring_err_stats() (Sashiko)
- Use local variable to prevent inflates from u64_stats_fetch_retry()
  (Sashiko)
- Add u64_stats_fetch/begin to protect base stats (Sashiko)

Debarghya Kundu (2):
  gve: Add NULL pointer checks for per-queue statistics
  gve: Fix backward stats when interface goes down or configuration is
    adjusted

Pin-yen Lin (2):
  gve: Use default min ring size when device option values are 0
  gve: Make ethtool config changes synchronous

 drivers/net/ethernet/google/gve/gve.h        |   7 +
 drivers/net/ethernet/google/gve/gve_adminq.c |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 152 ++++++++++++++-----
 3 files changed, 125 insertions(+), 38 deletions(-)

-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130
branch: gve-misc-fixes

