Return-Path: <netdev+bounces-268487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHnCNygSuWmFowEAu9opvQ
	(envelope-from <netdev+bounces-268487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:34:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2523E2A5BAE
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5D9A30420B5
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B422E33BBD0;
	Tue, 17 Mar 2026 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5HbCTFU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98238CFE4;
	Tue, 17 Mar 2026 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736426; cv=none; b=osUZkYn3GS3pVcSsAyZogFhDphZqs/Up+Lqo3ZPZYeUsRMQDDQI6FgHVVV8muIoU3KKJDaHizaQLAKy+Eky0sz7K6wFa0kZjEgjiBBfHMj8BL3oURZCqaMHqV6LGmzz1jnnYE6IstTYiOe5/kVEpnQhgJKSzyIuVEHLUN0XteDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736426; c=relaxed/simple;
	bh=qMEDh19S2IxsnzaDOCfwxKcmOXxAXTg1gJxujDJWFuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AuYF/QYuWALuJo422vvkvLuFa47SGAjPkE94Ejx0MAtbeMx+YmbEwMZiZO9FUZlGhb7EmGxbryTMnXZ+8zC1G+e42o3V+dXbF207a9UW70d3NIVQUsaZm9WjTG9pnasboj3ZiLwcFE8YV/OfG1TdivFzwyVKnlp/gYqdCj+1uKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5HbCTFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC9BC2BCB0;
	Tue, 17 Mar 2026 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773736426;
	bh=qMEDh19S2IxsnzaDOCfwxKcmOXxAXTg1gJxujDJWFuU=;
	h=From:To:Cc:Subject:Date:From;
	b=X5HbCTFUov6428X/j4+guO5bZ1gT63Ske57pyVXAREs+wpZUpVJwcUnTd9SLVuySS
	 Flmw/zsFSYgVuyisfdjs3mbUojgItejTKXxKAHlbo/RfeVsx0c0jMBIkQICS3+YYTa
	 NnfWCH5IhCRgDOgAk+X+tvLTggjqfV3LfKzv3NSbX9igcTd1h+5uRnBa6v0bkOXXk5
	 zgfJjNjHOdNzPQrkH8pBFtKLXT0iyzWifPFiYiY0/yqpMwlFd/jsfQBkFsxv97Y/ab
	 lu+mYE5u+AtM7tXsIK9UwGvAJtAYpve89ujsXRtUpUJ9T/yk+byR6YgCIpAGwtzhOV
	 rAB3g+ZToWnvw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v5 0/3] ethtool: Dynamic RSS context indirection table resizing
Date: Tue, 17 Mar 2026 09:33:33 +0100
Message-ID: <20260317083339.2811865-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268487-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rss_drv.py:url]
X-Rspamd-Queue-Id: 2523E2A5BAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi!

[ Michael and Pavan, I removed your Tested-by:/Reviewed-by: although
the changes were pretty small. Please re-add if you're still OK with
it. ]

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

Both ethtool_rxfh_can_resize() and ethtool_rxfh_resize() now take a
user_size parameter: the number of indirection table entries the user
originally provided. When shrinking, the table will not fold below
this floor, preserving user intent.

The user_size is tracked in ctx->indir_user_size for non-default RSS
contexts and in dev->ethtool->rss_indir_user_size for context 0. It
is set when the indirection table is configured via netlink or ioctl,
and cleared to zero on reset-to-default.

Patch 2 uses them in bnxt_set_channels(). Validation runs before
bnxt_close_nic(); actual resize is deferred until after. RSS table
size only changes on P5 chips with older firmware.

Patch 3 adds HW tests in rss_drv.py (devices without dynamic table
sizing are skipped):
  resize_periodic - fold/unfold with a non-default [3,2,1,0]
    sub-table (user_size=4), verifying exact content preservation
    (main + ctx)
  resize_below_user_size_reject - periodic sub-table with user_size
    between big and small device table sizes; verifies that shrinking
    below user_size is rejected even when the table is periodic
    (main + ctx)
  resize_nonperiodic_reject - non-periodic table blocks channel
    reduction, with an extra periodic context to exercise
    multi-context validation (main + ctx)
  resize_nonperiodic_no_corruption - failed resize leaves table
    contents and channel count unchanged (main + ctx)

Running the tests:

  # On real hardware
  sudo NETIF=eth0 ./rss_drv.py

Changes v4 -> v5:

 - Track user-provided indirection table size (user_size) as a resize
   floor. Added indir_user_size to ethtool_rxfh_context and
   rss_indir_user_size to ethtool_netdev_state. ethtool_rxfh_can_resize()
   and ethtool_rxfh_resize() now take a user_size parameter and reject
   shrinking below it. (Jakub)
 - Propagated user_size out of rss_set_prep_indir() and stored it on
   successful set in both netlink and ioctl paths.
 - resize_periodic test now sends a 4-entry sub-table (user_size=4)
   instead of replicating to full device table size
 - Added resize_below_user_size_reject test to verify user_size floor.
 - Removed "Open items" section - user_size tracking is now implemented.

Changes v3 -> v4:

 - Rebased onto net-next
 - Added Reviewed-by: from Michael
 - Added missing Cc: to make the pwbots happier

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


Björn Töpel (3):
  ethtool: Add RSS indirection table resize helpers
  bnxt_en: Resize RSS contexts on channel count change
  selftests: rss_drv: Add RSS indirection table resize tests

 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  38 ++-
 include/linux/ethtool.h                       |  11 +
 net/ethtool/common.c                          | 150 +++++++++++
 net/ethtool/ioctl.c                           |  15 +-
 net/ethtool/rss.c                             |  24 +-
 .../selftests/drivers/net/hw/rss_drv.py       | 233 +++++++++++++++++-
 6 files changed, 450 insertions(+), 21 deletions(-)


base-commit: 348baefbb635cbb448e154f38c93657d4cf23936
-- 
2.53.0


