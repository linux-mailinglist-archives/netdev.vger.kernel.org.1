Return-Path: <netdev+bounces-291435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPpYDZqnFGrtPAcAu9opvQ
	(envelope-from <netdev+bounces-291435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:48:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ADB5CE1E5
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFD0301AF42
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70734380FC3;
	Mon, 25 May 2026 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFWWkwsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A53E267AF2
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738492; cv=none; b=XYvX8+gOnwkCtyVnRTT0eSAmTPVP3JQ1tV+1n/BguatlJVFXXSsCsdri/zYpt23OVTsSi6pQHOnJvfzgkQJZamMHOPWMiCfVi0g5uobcCgbJ+wv77dJ/Gy0loBd2+UTI35u3+nqiwSDC5VO5kC3fA6xBfsX5KL6zaYkDLmZwBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738492; c=relaxed/simple;
	bh=IjYZ4Now6eHoY8KESuQemT5hJRb1hW4V6BZt4kkzde0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UTZ1Cfbm6Ls7MacmNkBL/GEBlaIEDE5P+Y6DN9UvO/2qKoG6DhH4bStaxbrUzjC8WVKyrOmPqtg65RtSBq97EETUsDEBKJGKte++1x1FOiE0Y0ZD7Q7xS2r86IU58J2KUkvsVGbzo+JY3adUzRobVy2smth3N4GHGfl+6Q+w7uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFWWkwsK; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-956849ae1efso2569068241.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779738488; x=1780343288; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LKIsXa2zmV8A2+l+hSBzlz8FvjZv+wXKu0GMbOfmlAs=;
        b=bFWWkwsKRKH3y/HbyMqK7GmFJhoPogGscXYS0DL0w7OE/kCc+MbywWtBzY+y+aIFJZ
         gIxHhuLvIFZDZdZJcjqvTdK9a9hOP8PS4MkHM1/yOnJsC46oluA67hBhTqYvi23oma+G
         BJcvi4C+cz+2CNaA5xccjV+0ysKnNSaijREAzhGYAANj7qmromYOoPGvrr+hpm2w9+bA
         HTwFG6Hj3HAqPy+CStnCIzEKwOdqHnBGIhfEKD+u4KGseKtmtiABvon/MhqgIvvclUP4
         TMIKhDBM4Mer+BZEuP97BTuVnDbFCWhw12/W1Bo6c6U3f0WQwaK5Z5/JgromZWPZS0rN
         wDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738488; x=1780343288;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKIsXa2zmV8A2+l+hSBzlz8FvjZv+wXKu0GMbOfmlAs=;
        b=DclGxhT3xQXo7/1zu5LKz3v+IfdibrM97/yPC1fnlvacVvJ14ffIa169HEJFzyG5l6
         aXsFsxQ8iy0pr5+yW3NYL1DjJ50cMAZki5dwTlIcdwM9oDxwnZ6CRUMyMF6xJsxx50li
         VdVnIBlkgpyvuXneJQphBlRHyRgiak9sM2t6cqd2wLwDUxvemgPNJ+jJNWp3d7UtOpqu
         KG/TjOkrR1SQoX3VHYWcpdVE1WN+bGTIU/Nzvx1+dB/5eFyDl1+8VOR1ADhWYsg/HWSW
         TaEDzxIPOsWSvLRE6xlhbBO68rM18xFUSRwPuNTPolvMk2Cr7iyyX+DS9oOW+Xts4mIx
         xgCg==
X-Gm-Message-State: AOJu0YzBPBpzQBoehjrJRpN+L0Vm8NNNT7i2E1DYP7vZCYCgJlSaqVhH
	cyOTc2/vpOTjuvJGKmbxhIsdW4EEXMjaJKCpziLszGU8fk8trUhhVU8e
X-Gm-Gg: Acq92OF82NHqyKMGPWM8L+L7FFtz7MZCDpEfCVs2m5NEgqKV5MYLVqXKcrwyKAhW472
	wOGCh2rAGDB0YnATKWvwWlLmvz/y+wuhX9qoFtLhrOcJbAB1ex9W09TsgeSnXFttoj74Am4MWVP
	mABDAnRIwtjC27y20PblL/1Ff4Aa0RuyiPxMh987hmELjC3sdUgyKDdZutpwN/ZsfOEUYTdUQ7J
	v1nWWgBDUmrV+AgD3ULEbXuVL8ZNU2FykvbKlZDawSPCTICT83IZCwjFaQWayt7zCgwE97xVn80
	aHKfFTJK5R+VE0/+GrlqJEKY1rxCbewlYLVfrdDlpCITLdzScg92sJ9r93o5OlGsHEqkBrfPsLt
	4cLGPFgFjEZD5gGMigsiL3lcwCPPf6jKzHPMOXucBA7b+XQR1RwfYvZJS4ln7A8QmBf8EH99+pd
	sVjbVDJ0lqRDxOqDzE7NESw+/3dm74z07WJMj/+w==
X-Received: by 2002:a05:6122:1804:b0:56b:9083:4331 with SMTP id 71dfb90a1353d-5866357e65amr7423315e0c.12.1779738488292;
        Mon, 25 May 2026 12:48:08 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96173af3e82sm11092456241.10.2026.05.25.12.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:48:07 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH v8 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Date: Mon, 25 May 2026 16:47:56 -0300
Message-Id: <20260525-realtek_forward-v8-0-5eb80a4675be@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGynFGoC/23Qy07DMBAF0F+pvMbI9vgVVvwHqpAf49aiTZATp
 UVV/h0TFoQky9HVufbMg/RYMvbk5fAgBcfc566tg306kHB27QlpjnUmggnNQAAt6C4Dfrynrtx
 ciZR7F8AZE7SWpKrPginf58Y30uJAW7wP5FiTc+6HrnzNT418zn9bgW9aR04ZlTJ5DTX3Bl9PV
 5cvz6G7zl2j+POKbX81iuoj0xKFYB4avvaw9HrroXoerQkqWeXAr71ceL7jZfXW66gdR0wxrL1
 a+mbrVfXBN8kwEbixYu31woud++mf/eve3rsINsDam6XfuZ+pHjhYplBwm/75aZq+AfwfKbk4A
 gAA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291435-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bang-olufsen.dk:email,msgid.link:url]
X-Rspamd-Queue-Id: 80ADB5CE1E5
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

FYI: Sashiko (opus/claude) ignored v7.

Changes in v8:
* Patch 4 (Table lookup):
 - revert -ENOSPC suggestion from Sashiko. It is better for the caller
   to handle the semantic meaning of table query failures, as write
   operations are also used for deletion where -ENOSPC makes no sense.
   Physical lookup/hit failures in table_query() now simply return -ENOENT.
* Patch 5 (VLAN):
 - removed unused attribution to variable dp.
* Patch 6 (Bridge Join/Leave):
 - migrate the .port_set_learning callback definition from the bridge
   flags patch to ensure MAC learning can be explicitly enabled on
   bridge join and disabled on bridge leave, preserving bisectability.
* Patch 7 (FDB):
 - reroute fdb_add/del to l2_add_mc/l2_del_mc if the MAC address is
   multicast to prevent bit corruption in the unified LUT.
 - Silence -ENOENT (and -ENOSPC on write-based deletion) when fdb_del
   tries to delete a missing entry, as it could have expired in the
   meantime.  Repeated deletion calls are already filtered out by the
   upper layers before reaching the driver.
 - improved multicast deletion debug message to include the MAC address.
* Patch 8 (Bridge Flags)
 - .port_set_learning was moved to patch 6
- Link to v7: https://patch.msgid.link/20260523-realtek_forward-v7-0-313805e218f3@gmail.com

Changes in v7:
* Patch 2 (DSA helpers):
 - switch from dsa_switch_for_each_available_port() to
   dsa_switch_for_each_port() in irq_teardown() to properly dispose
   of unused ports' mappings.
 - reorder the !cpu->enable check in setup() to run before chip
   configuration.
 - add a detailed comment explaining the limitation of the unsupported
   cascading layout.
 - expand the commit message to document the pre-existing IRQ handler
   guard and the new -EINVAL probe failure mode.
* Patch 5 (VLAN):
 - replace br_vlan_get_pvid() with rtl8365mb_vlan_port_get_pvid(), which
   uses the HW info directly.
 - rename the existing internal static helper to
   rtl8365mb_vlan_port_get_pvid_idx() to cleanly export the new PVID
   retrieval helper.
 - add a logical guard check in rtl8365mb_vlan_pvid_port_add() to prevent
   accidental deletion of VLAN MC entries when reconfiguring an identical
   PVID.
 - removed spurious rtl8365mb_vlan.c.orig file.
* Patch 7 (L2):
 - clarify CPU port EFID and assisted learning comment in fdb_add().
 - comment that EFID computation in mdb_add/del is for debugging only.
* Patch 8 (bridge flags):
 - added missing '\n' in rtl8365mb_port_pre_bridge_flags() dbg message.
- Link to v6: https://patch.msgid.link/20260521-realtek_forward-v6-0-d391bbad38c3@gmail.com

Changes in v6:
* General:
 - added missing Reviewed-by tags across the series.
 - removed redundant parentheses around the dp macro evaluation ((dp)).
* Patch 1 (err_ptr):
 - updated the commit message to document the use of dev_err_probe().
 - fixed a minor typo (failed map IRQ -> failed to map IRQ).
* Patch 2 (DSA helpers):
 - fixed a space typo (Cascading(DSA link) -> Cascading (DSA link)).
 - added a safety check to abort configuration early with -EINVAL
   if no upstream (CPU/Link) port is active (!cpu->enable).
 - fixed error handling inside port configuration loop that was not
   using out_teardown_irq.
* Patch 5 (VLAN):
 - added a vlan_lock mutex to protect read-modify-write ops in vlan4k
   and vlanMC, used in vlan_port_add/del.
 - set framefilter to tagged-only only if vlan filtering is enabled and
   PVID is not active (checked both while changing vlan_filtering or
   adding a PVID port).
 - added rtl8365mb_vlan_mc_get_pvid() helper function.
 - added rtl8365mb_vlan_port_get_framefilter() and made
   rtl8365mb_vlan_port_set_framefilter() and enum
   rtl8365mb_frame_ingress public.
 - explicitly reject requests for VLAN 0 with -EOPNOTSUPP.
 - fixed string formatting bounds for the vlanMC overflow.
 - rtl8365mb_vlan_pvid_port_{add,del} error handling now attempts to
   return to the previous PVID state.
 - rtl8365mb_vlan_pvid_port_del with vlan NULL (without informing the
   VID) is not needed anymore.
 - added kdocs to public functions
* Patch 7 (L2):
 - removed check for -ENOENT on L2 write as the table access already
   returns the expected error.
 - increased L2 polling timeout to 10000us, matching the table polling.
 - improved l2_{add/del}_mc debug messages while strictly respecting
   the 80-column limit.
 - if an unexpected dynamic multicast group exists while adding a new
   port, promote that group to static.
 - improved comment about how HW deletes a multicast group.
- Link to v5: https://patch.msgid.link/20260519-realtek_forward-v5-0-cb9f702c1782@gmail.com

Changes in v5:
* General:
 - Removed Alvin from Co-Developed-By and added myself.
* Patch 1 (err_ptr):
 - fixed error message on failed IRQ mapping
* Patch 2 (DSA helpers):
 - fixed missing irq teardown when DSA link port was detected.
 - added missing \n in error message when DSA link port is detected.
* Patch 4 (Table lookup):
 - fixed RTL8365MB_TABLE_ADDR_MASK mask
 - added a check for busy table access before preparing and issuing
   a new command (protecting from a failed previous access)
 - increased table timeout from 100us to 10000us
 - changed -ENOENT to -ENOSPC when writing to L2 failed
 - moved RTL8365MB_TABLE_ENTRY_MAX_SIZE to table.h (as kdoc mentions it)
* Patch 5 (VLAN):
 - removed duplicated filtering registers macros
 - removed wrong comment on undo_transparent
 - forced the removal of a possible PVID state if an added port
   is not PVID
 - added vlanmc->priority_en to VlanMC reading, although always zero
 - use VlanMC member just for tracking ports using PVID and do not
   try to keep it in sync with Vlan4k. rtl8365mb_vlan_mc_pvid_members()
   is not needed anymore.
 - changed rtl8365mb_vlan_mc_port_set signature to receive vid and pvid
   instead of the vlan struct to avoid null pointer dereference
* Patch 7 (L2):
 - removed addr from rtl8365mb_l2_del_mc when -ENOENT is returned by the table_access as it is undefined (noticed by sashiko)
 - added RTL8365MB_L2_TABLE_SIZE and use it instead of RTL8365MB_LEARN_LIMIT_MAX when needed
 - extended RTL8365MB_LEARN_LIMIT_MAX comment to cite that the exception RTL8370B might not even be a RTL8367C member
 - moved l2_lock init to rtl83xx.c as it is a field in a common struct.
 - fixed fdb_dump kdoc, now returning OK when the table is empty
 - expaned L2 commit to cite unicast/multicast table key
   differences
- Link to v4: https://patch.msgid.link/20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com

Changes in v4:
* General:
 - fixed comments/kdoc wording identified by Sashiko.
* Patch 1 (err_prt):
 - added missing %pe/ERR_PTR conversion identified by Sashiko.
* Patch 2 (dsa macros):
 - reorganize port setup initialization, collecting ports in upports_mask
   and downports_mask.
 - include a fail fast during setup if DSA links ports are detected.
* Patch 4 (table):
 - added missing return value check for regmap_bulk_read in table access
   (spotted by Sashiko).
* Patch 5 (vlan):
 - added undo steps to rtl8365mb_port_vlan_filtering (noticed by
   Sashiko).
 - removed residual double max packet configuation (noticed by Sashiko).
 - added meteridx and policing_en to rtl8365mb_vlan_mc_read, although
   always written as zero in rtl8365mb_vlan_mc_write() (noticed by
   Sashiko).
 - explicitly comment that VlanMC[0] uses EVID==0 (Sashiko was worried).
 - always undo previous PVID setting before applying a new one. It might
   exhaust VlanMC entries if the user keeps changing PVID without removing
   the port from the previous PVID VLAN (bug detected by Sashiko).
 - Fixed a bug where a missing VLAN MC entry during PVID assignment would
   return success instead of an error (reportd by Sashiko).
* Patch 6 (bridge join/leave):
 - Added error unwinding path (undo isolation and EFID) in
   rtl83xx_port_bridge_join (noticed by Sashiko).
* Patch 7 (FDB support):
 - added RTL8365MB_L2_ENTRY_SIZE macro.
 - fixed RTL8365MB_L2_FLUSH_CTRL2_TYPE_BOTH definition (noticed by
   Sashiko).
 - removed the union in rtl8365mb_l2_uc_key. Each field is independent
   now (bug detected by by Sashiko).
 - fixed mc->member calculation. Now it uses bitfield to rebuild the
   value (bug detected by Sashiko).
 - return mdb_del without errors if entry is missing.
 - improve debug messages for l2 operations.
 - added comment about ds->assisted_learning_on_cpu_port and
   fdb_isolation in the commit message (asked by Sashiko)
 - renamed some _MASK macros to _MSK to reduce the name length.
 ** rtl83xx_port_fdb_dump fixes:
  - initialize entry as null (noticed by Sashiko)
  - check return of cb() (bugfix reported by Sashiko)
  - fix address overflow (noticed by Sashiko)
- Link to v3: https://patch.msgid.link/20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com

Changes in v3:
- Fixed kernel-doc warnings
- Removed unnecessary defensive checks
- Link to v2: https://patch.msgid.link/20260503-realtek_forward-v2-0-d064e220b391@gmail.com

Changes in v2:
- added patch to use ERR_PTR()
- dropped bitfield patch. Use FIELD_PREP instead. Suggested by Yury
  Norov
- tag_rtl8_4 patches were submitted on its own series (already accepted)
- dropped rtl8365mb_vlan_mc_port_{add,del}(). rtl8365mb_vlan_mc_port_set
  is now called directly from PVID methods.
- reordered methods in rtl8365mb_vlan.c
- use dsa_switch_for_each_user_port() instead of simple for in bridge
  port join/leave
- PVID check now uses dsa_switch_for_each_available_port instead of
  dsa_switch_for_each_port
- set EFID of user ports to 0 at setup(), although it is the expected
  state after reset
- STP patch was dropped and replaced by a more extensive one that
  disables all ports (including unused ones) before setting CPU and user
  ports. It also extended the CPU port isolation to include all user
  ports.
- refactored bridge, FDB, and MDB port operations into the common
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

Luiz Angelo Daros de Luca (3):
      net: dsa: realtek: rtl8365mb: use ERR_PTR
      net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration
      net: dsa: realtek: rtl8365mb: add bridge port flags

 drivers/net/dsa/realtek/Makefile                   |   4 +
 drivers/net/dsa/realtek/realtek.h                  |  47 +
 drivers/net/dsa/realtek/rtl8365mb_l2.c             | 566 ++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h             |  32 +
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  | 667 ++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c          | 220 +++++
 drivers/net/dsa/realtek/rtl8365mb_table.h          | 134 +++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           | 961 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |  41 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 575 ++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h                  |  27 +
 11 files changed, 3201 insertions(+), 73 deletions(-)
---
base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
change-id: 20260323-realtek_forward-1bac3a77c664

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


