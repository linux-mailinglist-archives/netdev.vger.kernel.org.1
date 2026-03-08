Return-Path: <netdev+bounces-265299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBrUFbx1rWn/3AEAu9opvQ
	(envelope-from <netdev+bounces-265299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 14:12:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCA7230567
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 14:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16DB6300826B
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD3F364037;
	Sun,  8 Mar 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvWrcXtv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895030F812;
	Sun,  8 Mar 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772975545; cv=none; b=eETT/Eyxj7m2PIXjxz4bEgqtNdlohZYb8o7iALUXgbh1DVKsmJxYlUOoeDjDkKehCjJhGAj/vGSfVvJF45PurAazMComo/8FytIibpjc31bJNFOhx9h1o3QSbtlVWt+Q3l+4IEjRS6+cC7TM6JZJ1eq/kJqCxIW+sEiEZXC/A0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772975545; c=relaxed/simple;
	bh=RishPkSnif/6BFgHWRfH/UAt7vxgJLKCv2bHyf2A0Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C6ncG4XsD9Y6lN7xNbws4yYa3IjBf+m704v7QQ5+qzQxhvnqon7iyFncvVpmnnTKKbXe2NdmGnwl2KczReuFxtyuNdCCnrW8i8Z9a8eemyA/+YDk6H8zbyFQa4vQ8JyLqjjzh/T84N0J3TJ9TKMoMbhmBR3/sN6ompdc+K5SP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvWrcXtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5767C116C6;
	Sun,  8 Mar 2026 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772975544;
	bh=RishPkSnif/6BFgHWRfH/UAt7vxgJLKCv2bHyf2A0Hg=;
	h=From:To:Cc:Subject:Date:From;
	b=HvWrcXtvpmwROJ/Vtb0zqdn2X9T3gwNwrzdtBr/dDgfXB/rb7HcoxMFwnOistuqQY
	 xu796YG/ihAli8qG46pJQ4ag9mOPT/8+KTGVEfZ8ENzYlWVsr+CHQ/S914WkGJwLtv
	 kV2mhe1Dg4wmT4B93AW4dCG3Bb6qUPQWNKEpMXcFfC7cJPwSALGtw/uGRyH5jWdRpv
	 lopw/Eqx3WhP9zWG/1ZNdq1lxTQolnM0bzlkgsDgfZFes0dCGQFGLqGv7zzLLyOcUF
	 qQvQtJmmRTTH8tfZZXjTOrLEfxIkthqOKExaHtXKmhRH/opt7oBECGkZxN9pYHwX49
	 rEmda73j1aAgA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 0/3] ethtool: Dynamic RSS context indirection table resizing
Date: Sun,  8 Mar 2026 14:12:14 +0100
Message-ID: <20260308131218.3172332-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DBCA7230567
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265299-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.973];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi!

Some NICs (e.g. bnxt) change their RSS indirection table size based on
the queue count, because the hardware table is a shared resource. The
ethtool core locks ctx->indir_size at context creation, so drivers
have to reject channel changes when RSS contexts exist.

This series adds resize helpers and wires them up in bnxt.

Patch 1 adds core helpers:
  ethtool_rxfh_can_resize() - read-only validation
  ethtool_rxfh_resize() - fold/unfold a raw table in place
  ethtool_rxfh_ctxs_can_resize() - validate all non-default contexts
  ethtool_rxfh_ctxs_resize() - resize all non-default contexts,
    with locking and RSS_NTF notifications

Patch 2 uses them in bnxt_set_channels(). Validation runs before
bnxt_close_nic(); actual resize is deferred until after. RSS table
size only changes on P5 chips with older firmware.

Patch 3 adds HW tests in rss_drv.py (devices without dynamic table
sizing are skipped):
  resize_periodic - fold/unfold with a non-default [3,2,1,0]xN
    pattern, verifying exact content preservation (main + ctx)
  resize_nonperiodic_reject - non-periodic table blocks channel
    reduction, with an extra periodic context to exercise
    multi-context validation (main + ctx)
  resize_nonperiodic_no_corruption - failed resize leaves table
    contents and channel count unchanged (main + ctx)

Running the tests:

  # On real hardware
  sudo NETIF=eth0 ./rss_drv.py

Changes v2 -> v3:

 - Changed ethtool_rxfh_can_resize() to return bool instead of int;
   true means resize is possible, false means it is not. Inverted
   callers accordingly. (Jakub)
 - Added Tested-by from Pavan

Changes v1 -> v2:

 - Dropped netdevsim support and netdevsim selftest (Jakub)
 - Split ethtool_rxfh_contexts_resize_all() into separate validate
   (ethtool_rxfh_ctxs_can_resize) and apply (ethtool_rxfh_ctxs_resize)
   so drivers can validate before closing the device (Jakub)
 - Shortened helper names (Jakub)
 - Replaced scoped_guard(mutex) with explicit mutex_lock/unlock
   (Jakub)
 - Removed defensive zero-size check, bare expressions instead of != 0
   comparisons, ! instead of == 0 (Jakub)
 - In bnxt, moved bnxt_check_rings() before RSS validation and
   deferred actual resize to after bnxt_close_nic() (Jakub, Michael)
 - Added comment that RSS table size only changes on P5 chips with
   older firmware (Michael)
 - Use non-default [3,2,1,0]xN pattern set via netlink to distinguish
   correct fold from driver resetting to defaults (Jakub)
 - Check exact indirection table pattern, not just set(indir) (Jakub)
 - Use ksft_raises() instead of try/except/else (Jakub)
 - Removed queue_count=8 from NetDrvEnv (Jakub)
 - Added ksft_variants to resize_nonperiodic_reject for ctx coverage
 - Added extra periodic context in reject test for multi-context
   validation coverage
 - Added resize_nonperiodic_no_corruption test

Open items:

 - No user-controlled minimum table size yet. The plan is to record
   the user-provided indirection table length in the context (e.g.
   ctx->user_indir_size) and use it as a floor when folding: reject if
   new_size < user_indir_size. This way the user's original table size
   serves as an implicit minimum, preventing the driver from shrinking
   below what the user intended. Left for a follow-up.


Björn Töpel (3):
  ethtool: Add RSS indirection table resize helpers
  bnxt_en: Resize RSS contexts on channel count change
  selftests: rss_drv: Add RSS indirection table resize tests

 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  36 +++-
 include/linux/ethtool.h                       |   4 +
 net/ethtool/common.c                          | 143 +++++++++++++++
 .../selftests/drivers/net/hw/rss_drv.py       | 163 +++++++++++++++++-
 4 files changed, 335 insertions(+), 11 deletions(-)


base-commit: 0bcac7b11262557c990da1ac564d45777eb6b005
-- 
2.53.0


