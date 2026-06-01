Return-Path: <netdev+bounces-293498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHE7HTf0HGrxUQkAu9opvQ
	(envelope-from <netdev+bounces-293498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:53:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 747B9618EE9
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55674300252C
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 02:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A607222A4EE;
	Mon,  1 Jun 2026 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn4ikTJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C61FC0EA
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282416; cv=none; b=OrrRWLp+L2b0kvk0+IlMNedcAE4oQT6U4fuxUPVcBwlgyCcRLHZA60lJHx2PgXSnTfXZ9lacFSbwhoRUXXxXh6lAtIqBWO8D0uZhPNiUTaSDZAWihLU4DnOYmv5L/KtcupPQJOE4aqY3PUqay501JiS9+SIZfxHAkZn5lPxMVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282416; c=relaxed/simple;
	bh=Jt0x5MZUj7crJn6I5L7gSM5XnVOCm4+io6GwkBMRSLI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fg98Z0NoksFIMOwbTh17rG66nsNEcbefcp4YVeuptQqMKi/EK6/21aKI19PxCHHUMTdt5Il4D6BB1L8UjwrFxs7M3WxIaRbALcD2BHvDGRfMhQjLTsvlohuJqxUquIaqdSUItErSnUjCYWu5a+WPgMPFFk8NtIA4FVxrvyWnIG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bn4ikTJ3; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66039d3efcbso3635014d50.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 19:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780282414; x=1780887214; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CcWHkhlA5B+D//h3JctK9si/lHYtDF6arhaIgC/9O50=;
        b=bn4ikTJ3eFdL+soblMSuc/A9UCmCLjqmPthFuHEww4r2OjzOmBgeOYHlTi/TLdPp3l
         ev83ah5FsJfmYINARbRKEAF3/3WqmFyHq4j2AqeQ4SSwZk4If7t49ySI9+ZOdbyulJGj
         bILsIG2U7YIZH/qIS6fVBPg/tGUOP58KqW5WsVcwyryb6qLHV8bCRileqMXTEJaW3nD1
         TO8zp7ism4urSpYQMZ+OM4BRYRY0mZRbGPBKU84ehySnQegW3PPqTr+CfIMDZUjRWp1f
         y5afBWs3i9CSnzmQLzOpCJGqpye75tosfrciVK2p2JNOL/bvEDBKvf2BM36bxYsZztMv
         Lfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780282414; x=1780887214;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcWHkhlA5B+D//h3JctK9si/lHYtDF6arhaIgC/9O50=;
        b=gFw6UcAqmMLmzAR0Vbl/s7rcccUIltBTDLkELPD82FuReYc1U/Kp8Dca21lziUKxkV
         89/3BF6aIYs87M2nkHNjMp3Bcv41idux+bEp5o1mSCJ/N5FULVuEeNjMJBaNmPGKYb3n
         7pKZc+credaeKMU8L61c7Hl6aqNvB2vag1nvGu6K9IaxcV4rGNC0Y/XVZagV2CTUz/7T
         Qa7yYJTEQNkEryayHp5s6XZsVdyzXuYaWq83ZAUcvar2iKTSSFZCxYxsfkZy7ixWk5oD
         RHdN/P8Ir2ROa99eAdmSMYWVGWDXPd71rpE7sAaGoTUQtpArRsgOTgPcGGlwUy4fVmWs
         5vPw==
X-Gm-Message-State: AOJu0Yy9/LfCVouMmB6cVB1O880xx7QabdkOCDVeQ75HDkWWvYmSRImH
	h9aWWTX7YwMnkzL5I5/c30rcOZpQjonTICoEn5barhO3KSeDDdEbozbM
X-Gm-Gg: Acq92OGjSR5Xwvi4l/U745d+/Zz0B2fajmy802rUWgV9PpPcAVovojknCyku6ucnMfZ
	D+I+QAdjq9GXOXJVgtGVW0gnGTLh33GRHZLcVw8GtEYwlWFnTCFy/RcDxBcR22/W+0K6ppz5bTM
	8qUFCbnfTKXck2BsmvRoDHcwlB+0HqfG6fZn7KPFdNdLTZNf52B9W1lFpCN8C+w0YPvpVIUIdWs
	ovlZMbxe9pKw4KUqyn90RvvVWxkhixIKD24mWAayjIwYYocG+5gnY7nlI8boYOfD+7CtCXRnNEe
	VfcsWRaNOP6yQphiO/vpapxnvaKirMv+nU/cQDRAlZ4H6BnW5s6OlYZ97Gqb2QyKou6wFht6+wo
	FpJHVAm3fsjIbsWcL45Fz7EnCFMv0M4sVclCdHgBQilC2WlERVsQB6E8aFxkOZfJ2RIVYzD+W/W
	3nvqGIc/WA/rUrp2aseN76mGHl2HkOYB08OV3wuePkruGuN2faQg==
X-Received: by 2002:a05:690e:13c4:b0:651:c024:5733 with SMTP id 956f58d0204a3-6605ed7580amr8339602d50.13.1780282413583;
        Sun, 31 May 2026 19:53:33 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6606977ab05sm2952518d50.9.2026.05.31.19.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 19:53:31 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH v11 0/9] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Date: Sun, 31 May 2026 23:53:15 -0300
Message-Id: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABv0HGoC/23SS27DIBAG4KtErOuK4e2ueo+qqngMCWpiV9hyU
 0W5e4m7KDJewuj7YQZuZMKccCIvhxvJuKQpjUNZADwdiD/Z4YhdCmWDMMoU5Yx3Ge15xs+POOZ
 vm0MHznputfZKCVLUV8aYrmvkGxlw7ga8zuS9VE5pmsf8s561wFr/S+XQpC7Q0U6I6BQvdafx9
 Xix6fzsx8uatbB/L2l7q4UVH6gSyBh1vIet57VXrefFQzDay2ik5W7rReVhx4vijVNBWUCMwW+
 9rH3felm8d33UlHnQhm29qjzbmZ969F/6ds4Gbjzfel37nfnp4jlwQyUyMLHxpvay9aZ4ic5QK
 5SWrnm/vvY7/ffFY/lUYDQLPWvOB1oFcLrzgehjAiCcBFRW9aFOuN/vv3Chisr7AgAA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293498-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email]
X-Rspamd-Queue-Id: 747B9618EE9
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
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  | 684 +++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c          | 214 +++++
 drivers/net/dsa/realtek/rtl8365mb_table.h          | 138 +++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           | 955 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |  39 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 569 ++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h                  |  27 +
 11 files changed, 3203 insertions(+), 72 deletions(-)
---
base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
change-id: 20260323-realtek_forward-1bac3a77c664

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


