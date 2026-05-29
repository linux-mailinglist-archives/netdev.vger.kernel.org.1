Return-Path: <netdev+bounces-292962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DOOMWUWGWoMqQgAu9opvQ
	(envelope-from <netdev+bounces-292962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:30:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 617F75FCFB8
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB6F53039B65
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF6372ED2;
	Fri, 29 May 2026 04:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7KFeLLs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E89730CD82
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029026; cv=none; b=I4OxTB7NzmBSvNwDEtm5rN+sphWP8+xPqJfsYThBpfO5VRvekFLddL6tGW+m4U3vQBws327VA9oGeCJwPamHCmCwxKySFdJVpiUw8gXdZ7uDa46OV/UwPl3bepLkXq83xPCIU+8lnzcc3rkxU3tFIvG0h4UNBj0uuzTfj9QQBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029026; c=relaxed/simple;
	bh=eYavSebY9Sq54hMQWQkuR+dTYH1nqRehQAJGS1UVFps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GAYrOC5eRVzltxwRwCMd5TZ9xyLnTmH0n+Q8oOrYYsY700qz+leyh9Dnaa/l4MKPNrtNaiPe1/xdVbJAaGa9rStD8UJAMjuV3+DzHWLoRaGIfBY6I131xpH4ZuICQEK4AcNnbDtOdC5UDRJsQWgKbEz4VGMJdtrE2RUz1hbUi10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7KFeLLs; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-512f09ecc67so93700691cf.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 21:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780029017; x=1780633817; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYXuTTxULeo5zOvEhaKXydXesgfl2DIjZ4x2QSXcuuY=;
        b=O7KFeLLsd4QCjULUBee3K2AnYAmIDSrPMHjs4oSrNPT5W3Jv2ELtpcjEF/Mi2v6mg7
         AFZpGF8casWaFNH6s46htv9i9pajufFqR9JCrxuilg49tAn4bg/Wih1mV65k9BV9cnWd
         8tjGsGoagKA/348Cmxq6QCJrTvUx/D9hVfe/Go0CXTz9ORcsqZkNI7BZsN4Bdix0v11h
         Pkjj4Eh2BDHxVz/TFpnPraDiNq+H/tdNxr60N7a4qSFB8RjwWKUQeQ8F1jFswwR2NFSb
         ONC1hL84aHjI4jUSTwX5E5jF+1iNBvcVMUiU3ObzaAdwNeDtaiBf7Bt71JArQy7foUmH
         OQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780029017; x=1780633817;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYXuTTxULeo5zOvEhaKXydXesgfl2DIjZ4x2QSXcuuY=;
        b=Cd+T+AtCk0D9cZU47PYjYWHlLSIToZX1iVecDP2XaosG7p0CfGPDonHCPbD5apOzfe
         zL9eea4siZQ/uI9S6rRTiuHhZ/+odW7vbFSPnI2RF8OTVTvvp2TwNBsZ8eR1Djhcomhq
         o9Bf5WMhLDmQ3RlfN6oSKHl+MfZ6nEKirV9uy722MjVttrpkwHGUV9YZ1ovmYawoJ61D
         +tspj7USV06ITDyDy+T3SRzNOhwfShB2AFT6Mn6lQ/U7W3/PC31yxEYYw0yGDiXGZj1o
         KQ+AZmMArKlJM5gvcn0Bk96t9LRGkKETJmZK9yC5jZUJSIyAiPAvnSjlB2lEyFFjI8Ph
         Ifdg==
X-Gm-Message-State: AOJu0YzBlISfGzp6BMRm3Zud6c1uCj+aeA8MCS38zDf6GKBqNr2rVWgR
	Z4GLdUATbqwHxgPK9AnJukV2kAhIuyQH1lWYQA3iN8G6n8qYVCfIEYvY
X-Gm-Gg: Acq92OHHmz5gQCd/WPx9OkjbSL93q1PeYWv3ixV9ad/pCFQRY9yiD5kKLDeY4GU6u8k
	JBnTSn38zQSISgzhaS+9dXye1tlKA8pere41zANkIQl+fGgOv4yOWHqBcIZ17MKWT1ZiTFfQ/E5
	0E5gzT/r4oyqLi+ixUzWJSyWedHKsl3NrkoNOf1Td8NWli8IEFBdyK4Uo22imdyPQ8cDkH9lXYD
	wbpoczk9EpUglukrf9IxHqZuzhZw/tNQUhji+pmtZCSgzOSzWFIh/EY7c0kdghb77y/wp5yCmNT
	lix+0YTTk17jAYd36kdN9hnsJQj+UUvN9K5KdIxv0gHsB5+auuikNf4bSps6ZEOUIPHQhTWOz3A
	PxO6Wog6U/hqPu3ZXUDGMksxHmJY/7XNco9tY6avZN34tQVKjB/uhQnezphlNl0sZitY0yRbkJm
	/YBOEqp6VziDXKEiFVKZ1bgZWFhe8t8eLvx0MVxLhqvAxI2R6rWQ==
X-Received: by 2002:a05:622a:17ca:b0:50f:f0be:dc7b with SMTP id d75a77b69052e-5172dd04c9fmr16118081cf.39.1780029016767;
        Thu, 28 May 2026 21:30:16 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5172ebc7d23sm9260991cf.29.2026.05.28.21.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 21:30:15 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH v9 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Date: Fri, 29 May 2026 01:29:45 -0300
Message-Id: <20260529-realtek_forward-v9-0-e7c61872d923@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADkWGWoC/23RS07DMBAG4KtUXmNke/wKK+6BEPJj3Fq0CXKiU
 FTl7piwwCRdjkbfb8/MjYxYMo7k6XAjBec85qGvRfdwIOHk+iPSHGtNBBOagQBa0J0nfH9LQ/l
 0JVLuXQBnTNBakqo+CqZ8XRNfSI8T7fE6kdfaOeVxGsrX+tTM1/5vKvBd6swpo1Imr6H2vcHn4
 8Xl82MYLmvWLP68YvtfzaL6yLREIZiHjm89tF7vPVTPozVBJasc+K2Xjed3vKzeeh2144gphq1
 Xre/2XlUffJcME4EbK7ZeN17c2Z/+mb/O7b2LYANsvWn9nf2Z6oGDZQoFt2nnbevV3tvqFXrLn
 NRG+X/3W5blG1dUhDJ4AgAA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292962-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,davemloft.net:email,msgid.link:url]
X-Rspamd-Queue-Id: 617F75FCFB8
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

Luiz Angelo Daros de Luca (3):
      net: dsa: realtek: rtl8365mb: use ERR_PTR
      net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration
      net: dsa: realtek: rtl8365mb: add bridge port flags

 drivers/net/dsa/realtek/Makefile                   |   4 +
 drivers/net/dsa/realtek/realtek.h                  |  47 +
 drivers/net/dsa/realtek/rtl8365mb_l2.c             | 566 ++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h             |  32 +
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  | 681 +++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c          | 214 +++++
 drivers/net/dsa/realtek/rtl8365mb_table.h          | 138 +++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           | 953 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |  39 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 568 ++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h                  |  27 +
 11 files changed, 3196 insertions(+), 73 deletions(-)
---
base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
change-id: 20260323-realtek_forward-1bac3a77c664

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


