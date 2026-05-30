Return-Path: <netdev+bounces-293328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBLWDNzBGmp88AgAu9opvQ
	(envelope-from <netdev+bounces-293328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:54:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9380A60C456
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D86B30277C6
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B42339F162;
	Sat, 30 May 2026 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bou28eEN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0CE35E1DF
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138302; cv=none; b=cZq3T/sDzrX8HUaVzOJ20A1T94mS53YjF1zKqsWrtkTMSYYI+YeZBMf5Pa3h2g5d/K2XqkUrnZx76Hoo5qq9UxDSSATWKCrAS1t0oK714yoZ+gwMuwRxVDfxQKS7JzxqVJ6QXMP1lc+LJJAauy28t9Ds/BH0RPQlFzFUvVVoCC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138302; c=relaxed/simple;
	bh=a77YT3II8PNyymh3k1k0ypXddLwDXMMVcr0JHUYItxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZWEusQl7dFDM9kxUEajEzcUvsBp8VwjXzc0oR6QGPGG690JDTd3s77xBf7WAlPLytVW874btr+qCazuQcZ+axUA+L0s8L7yxvV68+TjNGBf1g3y7x+DS/cDpJg95E002RGDeCvFSS7zzuZRnABmNLjFpupalVKG/wOfy8DB4buk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bou28eEN; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bf0b47d2f1so131625807b3.3
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 03:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780138298; x=1780743098; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8nmo+eA0UdsMCinJyGs1v9fEnB4ykx4y+4jwQg1V+O8=;
        b=Bou28eENXfv4nW3y6kOxe1nBrunt18vYTOzXKf1iIhKNwyiNj+vWvhLmsHk8bYN1sB
         8vlGgufzRcvVagqMvttOXWNdQHWhSdCX7KYzqyWDr8lvjURab0dmXX6tt55jg6Yioe1A
         JkMmaFRVs5d7hDAKEgeX6x2qPAk58oIhIva/k2BnoX3PSNYVL5vIzKxnGBvVRS9qynDq
         ZbUxaNTxR7kosbefKafIqIMZWjWm7lDhhNonWuKOwdx6EOYfktCNL6lphqe8ccmhFjls
         QzQg9PJUDar0eI0AglPhoEr6c6JJYkVsJW8OB8Tbge3yFnXKTbZYpbCyXymNlCx07ZbJ
         NRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780138298; x=1780743098;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nmo+eA0UdsMCinJyGs1v9fEnB4ykx4y+4jwQg1V+O8=;
        b=jxmw3tZiKrC//No4hRCjbN3HVZFhBhipn2/0kUbls6NSI1l7pQ6JdOlF85YmdQKbWh
         3rXg5LGkUtn//T3zeSVAVmpEttk9AcJCOykjUhySehJIcfiEuo97Tw+gsTn9IGJR2Ur6
         WmChWAsbOtP5hGqS+Qbx9sCFnxi1TlQHWAh+G+1klS+Vt3AyNMRtPKRoRBeQ6iJcy+xV
         7RV4XOQfZBK25ykDjpZ9SbHdqwalsNAUxt5ZAh1JS+4qpKFjM1W3/WSQhsIl2f8o/1ZH
         yDgpz2EOFUyz+voMnvbpIDZp8Y2RXQjir07KFbPRzltueNY4XQYdACK1pqekN/OBUdBn
         bDBA==
X-Gm-Message-State: AOJu0YxdbiyF4hkomwZCzEPj7wSwlVwBJa5ai43QJZeUgdadAjTySzdR
	74DPvUKez0z+dzY7RJ7PM6npUDzCN0578J/gub2bz9dyYRqbj4QK39C6
X-Gm-Gg: Acq92OHawtA2Xf/TF2u6t3KK1Qr5E1r6OkKOTrY/0BM4XgKD/tvTbU0GWpVLqdii1cM
	9FoqkLKLtZQKcTEVhhO4HTeNkK0F16KS8N6Bbg28Rocfp4n6+Xxq/moRZxj5ub8ODJ0DGJS/g8a
	StKC96qXQbW0DXdJLMe2Nbis97VVuv617CfifDNT0k0uYHyHhda/DnOg/MoX1iB734bxVU/pDfU
	EsQ35hW9Ct+GYG8qopezndbUHKkfeo3x36KiDjlh+Ho45ITYStq1v1cNWgnyagre5BEVEo14nsz
	nFvbr8gqv2Z9rr0OjZ8FKG/pWIamur4QyD+tRhZfA7cTxf+szhJ05D8Stli2Se+YrQqob5X2VDr
	mXhwJG7VMcuDhTpj/zJXj9ElvKhQ97vXgu998G4zfuBDOyvM2bhHd8OqE0upFNQ6ozItP27vMz0
	zOp3nhI02un3Fyc9A9wUpeJT+Wmh10pK2sDipFpCwQIcb+5XLEKA==
X-Received: by 2002:a05:690c:6701:b0:7dd:1e9c:96af with SMTP id 00721157ae682-7e05c664ad7mr28808947b3.30.1780138298339;
        Sat, 30 May 2026 03:51:38 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7e176d6ff86sm5579357b3.16.2026.05.30.03.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 03:51:37 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH v10 0/9] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Date: Sat, 30 May 2026 07:51:05 -0300
Message-Id: <20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABnBGmoC/23S207EIBAG4FfZcG0NZ6hXvocxhsOwS9xtDW3qm
 s2+u2O9EEsvYfL9MAM3MkHJMJGnw40UWPKUxwEXjD4cSDi54QhdjrhBOOWaCi66Au48w/tbGsu
 nK7Fj3gXhjAlaS4Lqo0DK1zXyhQwwdwNcZ/KKlVOe5rF8rWctbK3/pgrWpC6so52UyWuBdW/g+
 Xhx+fwYxsuatfA/r2h7q4Wjj1RL4Jx60bOtF7XXrRfoWbQmqGSVE37rZeXZjpforddROwaQYth
 6Vfu+9Qp98H0ylAdmLN96XXm+Mz/90z/27b2Lwgax9ab2O/Mz6AUTlirgzKbG29qr1lv0CrylT
 mqjfPN+fe13+u/RA34qZg2PPf93/v1+/wbA5cnEuQIAAA==
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293328-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 9380A60C456
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
      net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}
      net: dsa: realtek: rtl8365mb: add FDB support

Luiz Angelo Daros de Luca (4):
      net: dsa: realtek: rtl8365mb: use ERR_PTR
      net: dsa: realtek: rtl8365mb: reject unsupported topologies
      net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration
      net: dsa: realtek: rtl8365mb: add bridge port flags

 drivers/net/dsa/realtek/Makefile                   |   4 +
 drivers/net/dsa/realtek/realtek.h                  |  47 +
 drivers/net/dsa/realtek/rtl8365mb_l2.c             | 566 ++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h             |  32 +
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  | 680 +++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c          | 214 +++++
 drivers/net/dsa/realtek/rtl8365mb_table.h          | 138 +++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           | 955 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |  39 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 569 ++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h                  |  27 +
 11 files changed, 3198 insertions(+), 73 deletions(-)
---
base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
change-id: 20260323-realtek_forward-1bac3a77c664

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


