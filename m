Return-Path: <netdev+bounces-273880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APFzNiudzGkDUgYAu9opvQ
	(envelope-from <netdev+bounces-273880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:20:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4115B3749FE
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 330D43026C1C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 04:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECED36B07B;
	Wed,  1 Apr 2026 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDJeW9ux"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1873535CB89
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017178; cv=none; b=RQ/kiDuV8lpGHpIxaGs22wbd2yCjj9NkKuM3KmKv2edKsjeEx0WVXQitxhWOXJssVIG/GaTb6z4PnxGV3ksH7spH49qETh7R+wTexZKP4juuasjqJTtYSBnP+96P72v6t4AWn7WDBg+G40vkLa9h5dIhUFaq3QywJbux+882J28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017178; c=relaxed/simple;
	bh=Xvd1LcX3lj4iVmPIf6vyiuh8vdYoE6izvFfaKScNjkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMNbZ/NP1Vu512gisEJZixDEFDMjgV4HfJjvcd9XgUB+0Mj13PrOZu8RwxuQ0xTosJiTslqdPVVh62UQmWUjxK2Ud9P+WK8Bh2A0HrWDTs7+vQLyZaxM2AyNVi9Ug/HFngIZRsbLHyXNMxWFF1Uqw255EAm9CAAfWd0OAVImjF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDJeW9ux; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d7f92bde91so4227818a34.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775017176; x=1775621976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFONURkaqW7NTmmG72z2KFu2mOMfbPaei0blX1R+FTo=;
        b=bDJeW9uxl7HclUYx/Zb38APCy2NlhrWY3XXlGUr93+m7wJc2ESC59G8hyp99XXrZk4
         3r6olg4V9EpFY+uKdHBDN/Ui1pEWfJ8/grwWSTqj2iNO/a21xkQfbDGFz+Ps7ox5MkxS
         ZmVQOoscC6n6eGolTRUL88b7vZdhwkRWQWUo9CfoAPFHXbEJKKsNQRsrBjbIZpQxysSb
         ndw4V5hPIGtIsEKoOe2H8GC1ic0F2UwRDm+4PbLI+ljmidJTqL22ezvwJqM468RgT6gC
         cLLeNsb2uBrgU/QICbffasfpzp3X06CTpj/GAROxdYynSeJs3Ig8ZMayq7FYhGpxKueI
         6NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017176; x=1775621976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFONURkaqW7NTmmG72z2KFu2mOMfbPaei0blX1R+FTo=;
        b=KLlsU6V8EDolVxoHrPYen0qZF+twLLHs2sNP5GkeYNLWOwMfxzKXK2UCxEsJs66JwD
         N8qXd9QPIYFk5zNQPXosq4CQUx49OUvx1SnRuih5YDEkOAyQiWsVLCp2rZ8tFjUGtjc3
         yaBfONPicVsyPozJn83L7yVEaT9nEdoi44HqOKoa8psY9dEifIrjRuwcLygXNjOZjiUP
         yW67R9bJIHVVArX9O+FKtxr0jsykHBGo4+6GJ6QjcCngMgWgTcqu7Ex1cWDU/oFeBSBA
         50mnXgUOtRPn8yVhdq8usGZV2eF/3Oe8ILWXGMfCLJ4kAtgSj0ulb5zlFy1QFFK4qpeJ
         zfLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8LZxhTkOcNDmWdGqgsM9QlAziU4wYmk79VMJj4HJEquO1KxatQp0+VXYMoAuTbalXvD16y2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO27XZy8ESQxHcqTVr5pOgwuS8Lv8nqu2RR/uq9hp8H4qf0pbL
	y+HLXxLpp2rsxx/mNnonQFmrxbu87LYEPX68ieLTgTN8eGwxJP+6dXdW
X-Gm-Gg: ATEYQzyvhOT+oA8E2LPDifV8bix6DnVCheX8dvB+VVmhx4d+bw7/CO28pfROvt7wMl9
	zK8oTZTadspokmVL70GHEqlwwkH+Cr4xEqiRn5Sfkfwym8338AzL59ifcrb1nDXID1BdjnHlr+F
	xe0R4i8GfGSxMd315vQ1fkAFjG7Yg2OiW/UnvwkMqhq4+lEp0H+v4vWPaTwRRinAv/sWYX44GuJ
	YGOH2sfsGgT3T88w654xgcwu6/llSno0aJzk347nxPOXnBw1bSUNYJEqDe9gTSoqWN3IHJb/tD2
	15P6OYkvlVuccnMg5uQKplrtgAvenyrGHRVCIQqrS91pOFIX2Fdeg04KJGiZ270yZ/zyrJgAR8l
	0mOoJVg6GjflyN9hwvxMjAdMpCSylaHaPbdpnx1q8qfUQfTGahDNRjUw7K3PJWxOR2WAcWULj2e
	qg050V9+1N2/WzkFvOAE39pTZKAodIeZ69UNZWBwzftfZ0gS8fVvrYSOtR2QU=
X-Received: by 2002:a05:6830:43a9:b0:7d7:fada:89ca with SMTP id 46e09a7af769-7db99343898mr1622685a34.15.1775017176031;
        Tue, 31 Mar 2026 21:19:36 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7da0a335440sm9588380a34.4.2026.03.31.21.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 21:19:34 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH net v4 0/2] stmmac crash/stall fixes when under memory pressure
Date: Tue, 31 Mar 2026 21:19:27 -0700
Message-ID: <20260401041929.12392-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273880-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4115B3749FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi netdev,

This is v4 of my series containing a pair of bugfixes for the stmmac driver's
receive pipeline. These issues occur when stmmac_rx_refill() does not (fully)
succeed, which happens more frequently when free memory is low.

The first patch closes Bugzilla bug #221010 [1], where stmmac_rx() can circle
around to a still-dirty descriptor (with a NULL buffer pointer), mistake it for
a filled descriptor (due to OWN=0), and attempt to dereference the buffer.

In testing that patch, I discovered a second issue: starvation of available RX
buffers causes the NIC to stop sending interrupts; if the driver stops polling,
it will wait indefinitely for an interrupt that will never come. (Note: the
first patch makes this issue more prominent -- mostly because it lets the
system survive long enough to exhibit it -- but doesn't *cause* it.) The second
patch addresses that problem as well.

Both patches are minimal, appropriate for stable, and designated to `net`. My
focus is on small, obviously-correct, easy-to-explain changes: I'll follow up
with another patch/series (something like [2]) for `net-next` that fixes the
ring in a more robust way.

The tx and zc paths seem to have similar low-memory bugs, to be addressed in
separate series.

Regards,
Sam

---

[1] https://bugzilla.kernel.org/show_bug.cgi?id=221010
[2] https://lore.kernel.org/netdev/20260316021009.262358-4-CFSworks@gmail.com/

v4:
- Changed patch 2 to tolerate dirty stragglers up to a critical threshold (the
  same threshold tolerated by the zero-copy path), to avoid nuisance looping
  during OOM conditions (thanks Jakub)
v3: https://lore.kernel.org/netdev/20260328192503.520689-1-CFSworks@gmail.com/T/
- Rebased on latest net/main
- Changed patch 2 to require that stmmac_rx_refill() *fully* succeeds before
  exiting polling, to reduce the chance of rx drops.
- DID NOT use the CIRC_SPACE() macro as suggested by Russell: I fear that the
  perspective shift (first think of the dirty descriptors as the "work" that
  refill "consumes" -- therefore the "space" is how much stmmac_rx() may loop)
  is too counterintuitive for a stable fix, but I'll do it in v4 if reviewers
  insist.
- Updated the recipients for the series, which was invalidated in v2 due to the
  `Fixes:`
v2: https://lore.kernel.org/netdev/20260319184031.8596-1-CFSworks@gmail.com/T/
- Completely rewrote the commit message of patch 1, now assuming the reader is
  generally familiar with DMA but wholly unfamiliar with the stmmac device
  (thanks Jakub!)
- Added missing `Fixes:` to patch 2
- Moved patch 2's `int budget = limit;` decl per the reverse-xmas-tree rule
- Dropped patch 3: this was a code improvement not appropriate for stable
- Generated the series with --subject-prefix='PATCH net'
v1: https://lore.kernel.org/netdev/20260316021009.262358-1-CFSworks@gmail.com/

Sam Edwards (2):
  net: stmmac: Prevent NULL deref when RX memory exhausted
  net: stmmac: Prevent indefinite RX stall on buffer exhaustion

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.52.0


