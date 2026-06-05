Return-Path: <netdev+bounces-295621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lddrA49XImoVVQEAu9opvQ
	(envelope-from <netdev+bounces-295621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 06:58:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF71464514D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 06:58:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BU8SFUGO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295621-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295621-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6195F300CC02
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 04:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C43B2FF2;
	Fri,  5 Jun 2026 04:56:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8358B3B27C3
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 04:56:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635393; cv=none; b=CtApMtL10yqmxEs6c49WF0fX8jX+iB4Q/4y3bkHLZz0ii4exoh2v6RRW46ZHC9LQdFdjIi/OnYn17bsyYNY8hZrzVMruaVm9nDVDCPxyG/S9Lsk5opHEWKFMQEDLtlf0+CpCL1yEGhQN17VFLs3diE2babYg2JsZF2YDBYpH+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635393; c=relaxed/simple;
	bh=96bjfd3lCkW7A32odor9qR3sgJk0zXx9GncoH3t6rIE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uqMxjOzEU+AnmAgfpZE0rh6n3pzlSDX6uLLJcQvAEeKfbLPrImbgts5iz8i1Sl/cfp8VFl5f3i1kp5Uu3Dzm9p/Q1pxfY4G18f7G6IirZJpwZLYlScmWrrZESTiR7+MAdCYv1AovCOSlVqWrOkN/k+ywZtp8ernOpGS7C+Y5w0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU8SFUGO; arc=none smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e0b3db3499so11336217b3.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 21:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780635389; x=1781240189; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf/kFk2RHE0p3c1G3Os2k1x4Yw5FPnRBSHnDDUqWGec=;
        b=BU8SFUGOx8GuXFOE27sUeTBe0wHz9E4vS4H/ef/6T71TtvaBORGF7PgQb0sRgNxmRq
         9kCbQbR9zm6P5kxDmTlyp8Kz9C+0TR1ex/LguXcJTM4pi+sfjc7Ghrt2zl7jACmveQT9
         3XvQnWhkW/NzUYQGz2NMO77DiSwx28L0JIpe2VYGXfThREA4vPkQH+k+yuOrWzphYCB3
         Qu46tfOjODnH9f6ff+2PZPfLkPVWOZx5TlC2iBY1mQDp8NE9h+S744KGgmIjsvQWhHF0
         qnYiQ6mz6Wg7VlghfoxnUg8GrKLuiBSQYxgEHScs/dQrOFvYg9ACxSm4ZjpjOaajxZiT
         2Q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780635389; x=1781240189;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf/kFk2RHE0p3c1G3Os2k1x4Yw5FPnRBSHnDDUqWGec=;
        b=rgK4/Js9Tt9MKtQVJA+zT7nl8UaVh4nj4O4tzOJrT5FGXDYmU78zSwZh2mPsMnDYZ9
         /ADeGVtD2vO12lXmu3tIxxOJ+fMfCdOCbcMMttjDdzN65r0blXT4NqnCm2dBd23ltV3N
         5Be0kTcg5FoBq+B48I24Cq0vZ6LRN95J3jhJk/HKxHMGv+/9DBqwRRxtI6OQbfT7nILV
         bIh1LGf6gFxQiaAJyAIGvb/ve7jM2X49edbYuGPGd/Q8cmjmbjCyuJWuGlJe1bgZkSTm
         IWsfFdLZoQXaZL0hGAQonxTk/vvdcDE0Dym0GtJn4I/34wjFch5kpleyFO4QV12HkHiz
         +XJg==
X-Gm-Message-State: AOJu0YyYl0UOz3ZBOTosIDAvGRl4EMFOnlzVz52NUM9KVVGJQD9/yA/9
	RYqjqrnyklp+a+CPHHeBDO3N0BSh70w4bcDalx4n69FU8D2VmYs280R8YVHQ440rpjc=
X-Gm-Gg: Acq92OGFnh93JCb9gJxH1puDq3eoOmzOy0mAXJ2/7M4hGMmv5Imw6cm57H4UFsfEUKB
	4gU7lI7xac3HOTYe6gol8J8Xwesc3P8mJPaK7l1X6LtlwxycD/WwaHzk/Z8CoBFgRHUK+KKIfgY
	7GIjtfkzQ48O9cyk/qm//fcmZ63QsRz0uYY1TkXcTc94O+QUVioZZFaC85sw3S4X/m7rZEI66vS
	fMEyES+evjRFAAkdv+MSPICZKCkMDgm5rz3iSiFw/E82PPBgbFdK3rJXAuQa4bYU3KQs453E7Bv
	JNuuaUQGhik7CIISWWcvt1bV5ZlZkrYu7qFBzfSp5oJ4fCcfE8rRRFsdDlGg/h2lewmzfB54wrh
	L/rLIpEd1xleEEw1cCsU/lU/lv9hIMKAE+TtRN+cqwwK9rPKrHcz/KjjcnkBxRic38x0b9mwxM+
	HC+OiMOeQGnoGVGgJ7w4Kh7AQBjWR+8niDR6Yhjn8X0o4KMpnDPw==
X-Received: by 2002:a05:690c:4907:b0:7dc:aa85:5c67 with SMTP id 00721157ae682-7ed0a9d67dfmr20228067b3.11.1780635389359;
        Thu, 04 Jun 2026 21:56:29 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea215825d2sm45840207b3.16.2026.06.04.21.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 21:56:27 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH v12 0/9] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Date: Fri, 05 Jun 2026 01:56:08 -0300
Message-Id: <20260605-realtek_forward-v12-0-78eb7b31df72@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOlWImoC/23SS07DMBAG4KtUXhPk8TusuAdCyI9xa9EmyIlCU
 dW744YFVpylM/p+eyZzIxPmhBN5OdxIxiVNaRzKAdjTgfiTHY7YpVA+EEaZopzxLqM9z/j5Ecf
 8bXPowFnPrdZeKUGK+soY03WNfCMDzt2A15m8l8opTfOYf9a7Fljrf6kcmtQFOtoJEZ3ipe40v
 h4vNp2f/XhZsxb27yVtX7Ww4gNVAhmjjvew9bz2qvW8eAhGexmNtNxtvag87HhRvHEqKAuIMfi
 tl7XvWy+L966PmjIP2rCtV5VnO/NTj/5L387ZwI3nW69rvzM/XTwHbqhEBiY23tRett4UL9EZa
 oXS0jX/r6/9Tv998ViWCoxmoWfN/UCrAE53Fog+JgDCSUBlVR+aBKgT9lbwsYOSBkWj1KDR1An
 3+/0XWob/AD0DAAA=
X-Change-ID: 20260323-realtek_forward-1bac3a77c664
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, 
 Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295621-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:namiltd@yahoo.com,m:luizluca@gmail.com,m:abdulkader.alrezej@gmail.com,m:ynorov@nvidia.com,m:yurynorov@gmail.com,m:abdulkaderalrezej@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF71464514D

This series introduces bridge offloading, FDB management, and VLAN support
for the Realtek rtl8365mb DSA switch driver. The primary goal is to
enable hardware frame forwarding between bridge ports, reducing CPU
overhead and providing advanced features like VLAN and FDB isolation.

Some of these patches are based on original work by Alvin Šipraga,
subsequently adapted and updated for the current net-next state.

---
I attempted to reach Alvin for review of the final version but was
unable to establish contact. Any regressions in this version are my
responsibility.

Changes in v12:
* Patch 3 (DSA helpers):
 - Moved irq_set_parent() to the .map callback to fix IRQ routing for
   dynamically mapped ports.
* Patch 6 (VLAN):
 - Moved bridge isolation behavior description to the bridge join/leave
   patch.
 - Added comments justifying the state inversion logic in the
   port_vlan_filtering undo path.
 - Refactored port_vlan_del to fail-fast if PVID clearing fails,
   preventing partial hardware state deletions.
* Patch 8->7 (FDB):
 - Reordered the patch before the bridge support to avoid flooding
   CPU-destined traffic to all ports.
 - Documented the is_static = true trade-off for DSA-assisted learning
   entries.
 - Removed the artificial l2_table_size limit in fdb_dump, relying safely
   on the hardware wrap-around.
 - Reverted support for multicast addresses in fdb_add/del, delegating it
   strictly to MDB operations.
* Patch 7->8 (Bridge Join/Leave):
 - Reordered the patch after FDB support to avoid flooding CPU-destined
   traffic to all ports.
 - Log hardware errors during port_bridge_leave to avoid silent failures.
- Link to v11: https://patch.msgid.link/20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com

Changes in v11:
* Patch 2 (unsupported topologies):
  - Moved the check for DSA links to an early pre-flight phase before
    configuring any ports.
  - Omitted "Link" from the missing upstream port error message. If
    cascading is supported in the future, that message will be updated
    as well.
* Patch 3 (DSA helpers):
  - Reworded the commit message to clarify that unused ports are
    explicitly blocked.
  - Reworded the commit message to explain why all IRQ mappings need to
    be cleaned during teardown, even for unused ports.
* Patch 6 (VLAN):
  - Added the same VID==0 guard for the vlan port del path.
  - Reworded the VID==0 error message, mentioning it is reserved by the
    driver and not "unsupported by the HW".
- Link to v10: https://patch.msgid.link/20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com

Changes in v10:
* Patch 2->2,3 (DSA helpers):
 - Split the unsupported topology checks into a new preparation patch.
* Patch 4->5 (Table lookup):
 - Fix port mask size in the table lookup command.
* Patch 5->6 (VLAN support):
 - Only remove a failed rtl8365mb_vlan_pvid_port_set() from
   VlanMC if it wasn't already a member.
* Patch 6->7 (Bridge Join/Leave):
 - Bridge join should only enable learning after efid was set. If not, a
   learned MAC could be leaked to EFID 0.
- Link to v9: https://patch.msgid.link/20260529-realtek_forward-v9-0-e7c61872d923@gmail.com

Changes in v9:
* Patch 2 (DSA helpers):
  - Switch to dsa_switch_for_each_port() in the irq_setup error path.
* Patch 4 (Table lookup):
  - Convert kdoc to standard comments.
  - Fix doc description for L2 write operation return value and
    data/addr on errors.
  - Removed misleading comment on RTL8365MB_TABLE_CTRL_PORT_MASK.
* Patch 5 (VLAN support):
  - Do PVID first in port_vlan_add() to avoid reverting vlan4k changes
    if it fails.
  - Do not use dsa_switch_for_each_port_continue_reverse() after the
    loop ends (use-after-iterator).
  - Simplify PVID helpers to receive VID instead of switchdev vlan.
  - Avoid redundant writes in the PVID error path.
  - Convert kdoc to standard comments.
* Patch 6 (Bridge Join/Leave):
  - Do not use dsa_switch_for_each_port_continue_reverse() after the
    loop ends (use-after-iterator).
- Link to v8: https://patch.msgid.link/20260525-realtek_forward-v8-0-5eb80a4675be@gmail.com

Changes in v8:
* Patch 4 (Table lookup):
 - Revert -ENOSPC suggestion from Sashiko. It is better for the caller
   to handle the semantic meaning of table query failures, as write
   operations are also used for deletion where -ENOSPC makes no sense.
   Physical lookup/hit failures in table_query() now simply return -ENOENT.
* Patch 5 (VLAN):
 - Removed unused attribution to variable dp.
* Patch 6 (Bridge Join/Leave):
 - Migrate the .port_set_learning callback definition from the bridge
   flags patch to ensure MAC learning can be explicitly enabled on
   bridge join and disabled on bridge leave, preserving bisectability.
* Patch 7 (FDB):
 - Reroute fdb_add/del to l2_add_mc/l2_del_mc if the MAC address is
   multicast to prevent bit corruption in the unified LUT.
 - Silence -ENOENT (and -ENOSPC on write-based deletion) when fdb_del
   tries to delete a missing entry, as it could have expired in the
   meantime.  Repeated deletion calls are already filtered out by the
   upper layers before reaching the driver.
 - Improved multicast deletion debug message to include the MAC address.
* Patch 8 (Bridge Flags)
 - .port_set_learning was moved to patch 6
- Link to v7: https://patch.msgid.link/20260523-realtek_forward-v7-0-313805e218f3@gmail.com

Changes in v7:
* Patch 2 (DSA helpers):
 - Switch from dsa_switch_for_each_available_port() to
   dsa_switch_for_each_port() in irq_teardown() to properly dispose
   of unused ports' mappings.
 - Reorder the !cpu->enable check in setup() to run before chip
   configuration.
 - Add a detailed comment explaining the limitation of the unsupported
   cascading layout.
 - Expand the commit message to document the pre-existing IRQ handler
   guard and the new -EINVAL probe failure mode.
* Patch 5 (VLAN):
 - Replace br_vlan_get_pvid() with rtl8365mb_vlan_port_get_pvid(), which
   uses the HW info directly.
 - Rename the existing internal static helper to
   rtl8365mb_vlan_port_get_pvid_idx() to cleanly export the new PVID
   retrieval helper.
 - Add a logical guard check in rtl8365mb_vlan_pvid_port_add() to prevent
   accidental deletion of VLAN MC entries when reconfiguring an identical
   PVID.
 - Removed spurious rtl8365mb_vlan.c.orig file.
* Patch 7 (L2):
 - Clarify CPU port EFID and assisted learning comment in fdb_add().
 - Comment that EFID computation in mdb_add/del is for debugging only.
* Patch 8 (bridge flags):
 - Added missing '\n' in rtl8365mb_port_pre_bridge_flags() dbg message.
- Link to v6: https://patch.msgid.link/20260521-realtek_forward-v6-0-d391bbad38c3@gmail.com

Changes in v6:
* General:
 - Added missing Reviewed-by tags across the series.
 - Removed redundant parentheses around the dp macro evaluation ((dp)).
* Patch 1 (err_ptr):
 - Updated the commit message to document the use of dev_err_probe().
 - Fixed a minor typo (failed map IRQ -> failed to map IRQ).
* Patch 2 (DSA helpers):
 - Fixed a space typo (Cascading(DSA link) -> Cascading (DSA link)).
 - Added a safety check to abort configuration early with -EINVAL
   if no upstream (CPU/Link) port is active (!cpu->enable).
 - Fixed error handling inside port configuration loop that was not
   using out_teardown_irq.
* Patch 5 (VLAN):
 - Added a vlan_lock mutex to protect read-modify-write ops in vlan4k
   and vlanMC, used in vlan_port_add/del.
 - Set framefilter to tagged-only only if vlan filtering is enabled and
   PVID is not active (checked both while changing vlan_filtering or
   adding a PVID port).
 - Added rtl8365mb_vlan_mc_get_pvid() helper function.
 - Added rtl8365mb_vlan_port_get_framefilter() and made
   rtl8365mb_vlan_port_set_framefilter() and enum
   rtl8365mb_frame_ingress public.
 - Explicitly reject requests for VLAN 0 with -EOPNOTSUPP.
 - Fixed string formatting bounds for the vlanMC overflow.
 - rtl8365mb_vlan_pvid_port_{add,del} error handling now attempts to
   return to the previous PVID state.
 - rtl8365mb_vlan_pvid_port_del with vlan NULL (without informing the
   VID) is not needed anymore.
 - Added kdocs to public functions
* Patch 7 (L2):
 - Removed check for -ENOENT on L2 write as the table access already
   returns the expected error.
 - Increased L2 polling timeout to 10000us, matching the table polling.
 - Improved l2_{add/del}_mc debug messages while strictly respecting
   the 80-column limit.
 - If an unexpected dynamic multicast group exists while adding a new
   port, promote that group to static.
 - Improved comment about how HW deletes a multicast group.
- Link to v5: https://patch.msgid.link/20260519-realtek_forward-v5-0-cb9f702c1782@gmail.com

Changes in v5:
* General:
 - Removed Alvin from Co-Developed-By and added myself.
* Patch 1 (err_ptr):
 - Fixed error message on failed IRQ mapping
* Patch 2 (DSA helpers):
 - Fixed missing irq teardown when DSA link port was detected.
 - Added missing \n in error message when DSA link port is detected.
* Patch 4 (Table lookup):
 - Fixed RTL8365MB_TABLE_ADDR_MASK mask
 - Added a check for busy table access before preparing and issuing
   a new command (protecting from a failed previous access)
 - Increased table timeout from 100us to 10000us
 - Changed -ENOENT to -ENOSPC when writing to L2 failed
 - Moved RTL8365MB_TABLE_ENTRY_MAX_SIZE to table.h (as kdoc mentions it)
* Patch 5 (VLAN):
 - Removed duplicated filtering registers macros
 - Removed wrong comment on undo_transparent
 - Forced the removal of a possible PVID state if an added port
   is not PVID
 - Added vlanmc->priority_en to VlanMC reading, although always zero
 - Use VlanMC member just for tracking ports using PVID and do not
   try to keep it in sync with Vlan4k. rtl8365mb_vlan_mc_pvid_members()
   is not needed anymore.
 - Changed rtl8365mb_vlan_mc_port_set signature to receive vid and pvid
   instead of the vlan struct to avoid null pointer dereference
* Patch 7 (L2):
 - Removed addr from rtl8365mb_l2_del_mc when -ENOENT is returned by the table_access as it is undefined (noticed by sashiko)
 - Added RTL8365MB_L2_TABLE_SIZE and use it instead of RTL8365MB_LEARN_LIMIT_MAX when needed
 - Extended RTL8365MB_LEARN_LIMIT_MAX comment to cite that the exception RTL8370B might not even be a RTL8367C member
 - Moved l2_lock init to rtl83xx.c as it is a field in a common struct.
 - Fixed fdb_dump kdoc, now returning OK when the table is empty
 - Expaned L2 commit to cite unicast/multicast table key
   differences
- Link to v4: https://patch.msgid.link/20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com

Changes in v4:
* General:
 - Fixed comments/kdoc wording identified by Sashiko.
* Patch 1 (err_prt):
 - Added missing %pe/ERR_PTR conversion identified by Sashiko.
* Patch 2 (dsa macros):
 - Reorganize port setup initialization, collecting ports in upports_mask
   and downports_mask.
 - Include a fail fast during setup if DSA links ports are detected.
* Patch 4 (table):
 - Added missing return value check for regmap_bulk_read in table access
   (spotted by Sashiko).
* Patch 5 (vlan):
 - Added undo steps to rtl8365mb_port_vlan_filtering (noticed by
   Sashiko).
 - Removed residual double max packet configuation (noticed by Sashiko).
 - Added meteridx and policing_en to rtl8365mb_vlan_mc_read, although
   always written as zero in rtl8365mb_vlan_mc_write() (noticed by
   Sashiko).
 - Explicitly comment that VlanMC[0] uses EVID==0 (Sashiko was worried).
 - Always undo previous PVID setting before applying a new one. It might
   exhaust VlanMC entries if the user keeps changing PVID without removing
   the port from the previous PVID VLAN (bug detected by Sashiko).
 - Fixed a bug where a missing VLAN MC entry during PVID assignment would
   return success instead of an error (reportd by Sashiko).
* Patch 6 (bridge join/leave):
 - Added error unwinding path (undo isolation and EFID) in
   rtl83xx_port_bridge_join (noticed by Sashiko).
* Patch 7 (FDB support):
 - Added RTL8365MB_L2_ENTRY_SIZE macro.
 - Aixed RTL8365MB_L2_FLUSH_CTRL2_TYPE_BOTH definition (noticed by
   Sashiko).
 - Removed the union in rtl8365mb_l2_uc_key. Each field is independent
   now (bug detected by by Sashiko).
 - Fixed mc->member calculation. Now it uses bitfield to rebuild the
   Value (bug detected by Sashiko).
 - Return mdb_del without errors if entry is missing.
 - Improve debug messages for l2 operations.
 - Added comment about ds->assisted_learning_on_cpu_port and
   fdb_isolation in the commit message (asked by Sashiko)
 - Renamed some _MASK macros to _MSK to reduce the name length.
 ** rtl83xx_port_fdb_dump fixes:
  - Initialize entry as null (noticed by Sashiko)
  - Check return of cb() (bugfix reported by Sashiko)
  - Fix address overflow (noticed by Sashiko)
- Link to v3: https://patch.msgid.link/20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com

Changes in v3:
- Fixed kernel-doc warnings
- Removed unnecessary defensive checks
- Link to v2: https://patch.msgid.link/20260503-realtek_forward-v2-0-d064e220b391@gmail.com

Changes in v2:
- Added patch to use ERR_PTR()
- Dropped bitfield patch. Use FIELD_PREP instead. Suggested by Yury
  Norov
- tag_rtl8_4 patches were submitted on its own series (already accepted)
- Dropped rtl8365mb_vlan_mc_port_{add,del}(). rtl8365mb_vlan_mc_port_set
  is now called directly from PVID methods.
- Reordered methods in rtl8365mb_vlan.c
- Use dsa_switch_for_each_user_port() instead of simple for in bridge
  port join/leave
- PVID check now uses dsa_switch_for_each_available_port instead of
  dsa_switch_for_each_port
- Set EFID of user ports to 0 at setup(), although it is the expected
  state after reset
- STP patch was dropped and replaced by a more extensive one that
  disables all ports (including unused ones) before setting CPU and user
  ports. It also extended the CPU port isolation to include all user
  ports.
- Refactored bridge, FDB, and MDB port operations into the common
  rtl83xx module, introducing new realtek_ops callbacks to abstract the
  hardware access
- Collected Reviewed-by and Suggested-by tags
- Link to v1:
  https://patch.msgid.link/20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com

To: Linus Walleij <linusw@kernel.org>
To: Alvin Šipraga <alsi@bang-olufsen.dk>
To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Alvin Šipraga (5):
      net: dsa: realtek: rtl8365mb: prepare for multiple source files
      net: dsa: realtek: rtl8365mb: add table lookup interface
      net: dsa: realtek: rtl8365mb: add VLAN support
      net: dsa: realtek: rtl8365mb: add FDB support
      net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}

Luiz Angelo Daros de Luca (4):
      net: dsa: realtek: rtl8365mb: use ERR_PTR
      net: dsa: realtek: rtl8365mb: reject unsupported topologies
      net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration
      net: dsa: realtek: rtl8365mb: add bridge port flags

 drivers/net/dsa/realtek/Makefile                   |   4 +
 drivers/net/dsa/realtek/realtek.h                  |  46 +
 drivers/net/dsa/realtek/rtl8365mb_l2.c             | 570 ++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h             |  32 +
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  | 713 +++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c          | 214 +++++
 drivers/net/dsa/realtek/rtl8365mb_table.h          | 138 +++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           | 955 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |  39 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 563 ++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h                  |  27 +
 11 files changed, 3224 insertions(+), 77 deletions(-)
---
base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
change-id: 20260323-realtek_forward-1bac3a77c664

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


