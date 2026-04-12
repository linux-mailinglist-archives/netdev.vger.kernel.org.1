Return-Path: <netdev+bounces-277797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG/GAIql22meEgkAu9opvQ
	(envelope-from <netdev+bounces-277797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:00:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3134F3E41A7
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3621C300E267
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24B02FD681;
	Sun, 12 Apr 2026 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m30I/4sO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F026EEC3
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002438; cv=none; b=NrmVbHen/o24ytGXc+zuxrdrQI52fy7zEkn0a9zzXSHW/pTSKnH0E4cGj1ukRaXr+VCCohH+QrRrMSqpjEfGLh5NrONV1xIRJp+Y7l47nUriJlfpBsehhCcXcFwIP20Mu7gzx9LOH+7diK2Tf9052+gZM9y/OWxRtifGbmkhhZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002438; c=relaxed/simple;
	bh=/sqScrnw3ggo4gUALiOlFcqYn0WWnguQdDnIl/9up9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NsF8s/Xu6gwtMKYXYf9m5jgZicb7PD7qhxBRAwuvkpq/Gt7AHf++8Oo9xdgsI5sLmwAayF/hvlc++0AI7Zp5LksEdRjKt5V+GiffhDVAguIzJT+9i/gZuEhtePjnZl+mDseV7rspJNB6H5ycg/ZsUeAbSHlhWTDGlJhpd8KiYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m30I/4sO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d7605ec91so278846f8f.3
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776002436; x=1776607236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OBLPLzgMTGCkIPvjqhv1Ou+HTen4SAjdH1A4wTecJ/M=;
        b=m30I/4sOYT0SmbIfDGQkVHndhSlDVIHvR6JkTSYD0gvKYg0cuJwE+PqkuCWvDvQAh+
         TZm/Hygev7n2B6fFQnaBFTdUliQud5LzrLWm2pGSxu2zPmkEm99tWQINFnK4Viz2ohm9
         ql5D1fDiaKE7WoIRxoPFQktFbXniIhrt5OnIPIZyq1iQ+iGT0nUFzKSEFT54xGves3Ac
         OoCIQHX6+x0BrncqZWJp+ZgI5WIZz3ol2tMgL+PruFUW85zwUxIaqT6HV6fr8x08BLhp
         bvXyuwyhYpCeDuy4ZyfGXoBJYVWP7DIXCkEBke12TVXw8gpvxmOPhC3yoDhU9J4Xmcf7
         H9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776002436; x=1776607236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBLPLzgMTGCkIPvjqhv1Ou+HTen4SAjdH1A4wTecJ/M=;
        b=MiQmK0eGDTdraEtYmwGpgcAg89gAOwjv1+/IMM3ymhSrdxObmaG9+8Og2V1MCYeIN/
         V9Ts38FbvtSp0qj3R+84imGTECqcAiUHqr2k67a58M7d6Imq1dBCpI8k59VMsnwGggPm
         PnZGdibVzV3BAH2N+/Rpicc2H3rxGz0xYcNEXfwf4XTjp+DtgTU1dvn0KqnKr1UYDo1u
         NN3Zyu4ICYvj+7A7RQfsSh5NKuwkXjRbG6ToRkzmfLw0DvmqTwXi58/xvMkiMk3NVp9W
         JV8XmVGYbyB8H5314r4C/uQ8KzYdQoZGOJhhdtKon4vjkf3esbXY04zYNDH+7Tpozr/y
         lY+A==
X-Forwarded-Encrypted: i=1; AFNElJ9rn4Phzwq3/dxjASm6a/zvJMvW+mUjH3+ci67tsXK9coKdwPCGcMYq1g2oVLyxbBImQT9BFk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1J8jWuSFOlM176j2SjGW4B7aEQa82bqVpX47ZZteRXXmVlik
	/LloKdumBnYr26TkUFSyFgLXwSwDi29hnSjokVJmhPxZDrVsQqddyqSp
X-Gm-Gg: AeBDievDVagZriLEyv+cuxWNaZ4hi/kgOWWvZ5ojuADrBmz0GLNKdh8yZETtI+CzBVp
	Q57dnGF3IGD5/lrepzDOAMBBFY3aAyLB/Fz1IFdDY6NqeeA6d5mzi2hbc+tAW3Dc9TMAbYRHPeV
	1CsOZuQeDFqYe4ufzeKSE2qWcaic/EpcvCiF8cO8d3XVSL70H80YCiT9SesIcC42GAHeqjNTej8
	NTeUm+jTB07kMBPeRBvLVfbANsFPmHxXs5oYzy/8R4NOf8deod850aCKfTQC6k6SXIPirAWDzom
	4Fy7VgQqgR19OdC7KFDwUmLYMrzzMjb7iDFe/vgbhAOef4VmUsh47t1Ftieyg5IYZpacrOPl3t8
	+WcQw/mm7PZKnIOUKkzSZuXCFNWA4kOvewo3wAzqZNTDaAj9UPR0w1vfvfjFz4II2/LKvD2WRAv
	opV2gxtH2/Lx0K9+eXcvtTQEJNLmBO8f1ozv162GDxuBdJzF4V
X-Received: by 2002:a05:6000:1a8d:b0:43c:fde6:212d with SMTP id ffacd0b85a97d-43d642cd3ddmr14625503f8f.33.1776002435503;
        Sun, 12 Apr 2026 07:00:35 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:6956:2074:5220:4650])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50015sm26127538f8f.27.2026.04.12.07.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 07:00:34 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v3 0/5] net: phy: Fix phy_init_hw() placement and update locking
Date: Sun, 12 Apr 2026 15:00:22 +0100
Message-ID: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277797-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[bp.renesas.com,armlinux.org.uk,vger.kernel.org,glider.be,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3134F3E41A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

This series fixes two related issues in the PHY subsystem: incorrect
placement of phy_init_hw() in the resume path, and drop/update locking
in several PHY drivers.

Patch 1 identifies that when mac_managed_pm is set, mdio_bus_phy_resume()
is skipped entirely, meaning phy_init_hw() which performs soft reset and
config_init is never called on resume for that path. To make both paths
consistent, phy_init_hw() is moved into phy_resume() so it runs
unconditionally. As a consequence, the separate phy_init_hw() +
phy_resume() call sequence in phy_attach_direct() is collapsed
into a single phy_resume() call.

Patch 2 removes the now-redundant explicit phy_init_hw() call in
rtl8169_up(), since phy_resume() already handles it.

Patch 3 removes manual mutex_lock/unlock(&phydev->lock) from four
functions in the MSCC PHY driver. In vsc85xx_edge_rate_cntl_set(),
the lock wraps a single phy_modify_paged() call, which is already a
fully locked atomic operation that acquires the MDIO bus lock
internally, so the additional phydev->lock is unnecessary. The
remaining three functions — vsc85xx_mac_if_set(),
vsc8531_pre_init_seq_set(), and vsc85xx_eee_init_seq_set() — use
phy_read(), phy_write(), phy_select_page(), and phy_restore_page(),
all of which operate under the MDIO bus lock, so taking phydev->lock
around them provides no additional serialisation. Error-path labels
are updated accordingly.

Patch 4 fixes lan937x_dsp_workaround() in the Microchip T1 driver,
which was incorrectly taking phydev->lock. The function performs raw
MDIO bus accesses and must instead hold mdio_lock. The phy_read() and
phy_write() calls are also switched to their unlocked __phy_read() and
__phy_write() variants since mdio_lock is now held explicitly.

Patch 5 refines the placement introduced in patch 1 by moving
phy_init_hw() from phy_resume() down into __phy_resume(), so that it
is called with phydev->lock already held. This is necessary because
many MAC drivers and phylink reach the resume path via phy_start() ->
__phy_resume() directly, bypassing phy_resume().

v2->v3:
 * Moved all the patches into series as the order they get merged
   matters, otherwise a git bisect could land on a deadlock.
 * Updated commit description for patch#2 and #3.
v1->v2:
 * Updated commit description.
 * phy_init_hw() is moved from __phy_resume() -> phy_resume() to make it
   lock-free.
 * Dropped redundant phy_init_hw() call from mdio_bus_phy_resume() and
   phy_attach_direct().

Biju Das (5):
  net: phy: call phy_init_hw() in phy resume path
  r8169: Drop redundant phy_init_hw() call in rtl8169_up()
  net: phy: mscc: Drop unnecessary phydev->lock
  net: phy: microchip_t1: Replace phydev->lock with mdio_lock in
  net: phy: Move phy_init_hw() from phy_resume() to __phy_resume()

 drivers/net/ethernet/realtek/r8169_main.c |  1 -
 drivers/net/phy/microchip_t1.c            |  8 ++---
 drivers/net/phy/mscc/mscc_main.c          | 41 +++++++----------------
 drivers/net/phy/phy_device.c              | 14 ++++----
 4 files changed, 22 insertions(+), 42 deletions(-)

-- 
2.43.0


