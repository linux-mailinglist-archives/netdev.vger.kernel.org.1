Return-Path: <netdev+bounces-290642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CSHGBLBD2pwPQYAu9opvQ
	(envelope-from <netdev+bounces-290642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:36:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B020C5AE0EB
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76AC8302DF5F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D2E30594F;
	Fri, 22 May 2026 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtZel4hr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E61D88B4
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417101; cv=none; b=GieamSsDPWLBt1Ty1v02f/anSNCVRKmA0NTgtDHurgkYAxXwTeLhb2BSvls8xYDr+s5xTNls2i/gD9Y1YdsJF3I4SxMBrx/J8jLRG9gGty13r1ApXMPt9bhMyMfcMn+Ixm5L1BGgcgWb1BiDOhZjhNIYORrSKOrE4OBR9v+wT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417101; c=relaxed/simple;
	bh=qseiorYuVDFPkm4/vlgNOMLT4fONISZeJEEclAigqmY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eqWl2TFHYT8g0v97+d/3aWVbvn1m9dBzGaJerGM3ciQ399JABlSL/CPUAdCi91MYWlJ3iZ3WcqhZMUGJup4XCdHgTqjpXlCpooOHw+sSStpDjnlrTg+6mCA7Be+GF87MOl8M3p79gwug/txe9NjIiEEMROgJQY0C05ZBsvKROo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtZel4hr; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-575171b1ce7so2187886e0c.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 19:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779417097; x=1780021897; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4L5Ca9Ab0/hhfPlQcpuWEHRDwXT2MlJ5HyzYGtPxqM=;
        b=KtZel4hrJqcQnxFUJGAtX6G98dCo+gVIekwRebxhO5f1wtHaJ0vWbyiPBFdv49tWu6
         GS7oyoPHJwnY3PyopO7ymfL0tUqlbXXS/d7H0YoSsG6JGFylPFMpX0zyaPgTAUlJxeR3
         Ay8f3mL9QE9ksJ7DC5MSJ+HtPm6rI+Oee9IhFCYQxbR5siJvPRWjASgorCdNr9cmppUq
         iPLpuwK+6M3IK63j9AxkMUNxPHoFXhyuVSYNFusDD9wVbSXf/GMr3/SCoSMv3TYtrCua
         III42RNMTnZbx/JePuGTgKmEwIgkp8aU8bUoJpyRuQgCHLACuAznAWClfGvUmQTEgvZ3
         ZfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779417097; x=1780021897;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4L5Ca9Ab0/hhfPlQcpuWEHRDwXT2MlJ5HyzYGtPxqM=;
        b=dJp9PC+clH0TlPcx81JjuEAyPYMN7rU9pXWHmT+v31npR+ePENXPWreAvzmaQkjyHK
         eno1vF/ByLGbL3NZYfTYc1tZDjF0HCfd0xlNhGaPSsjoEACuIxytMdr6qMF9BTpUYWOi
         d+VsG+LBJ/9mj44B7wcgutx2Z102fzFWoVb9ph5QpE8zlZGtMFBScWQGftum0sg3qe9N
         2/Yeu79DZgXvMIDYpIbyA2xPm7WiQJdOSDFKp058yAL3dvJJQys6Uqc4Q+qG3KSvSB7R
         nc85x/QPdWGf/M4vnhADJdZ+kKwwJ9DM9yVmNkeZnaRm/tDdb0qAE72Rpj7ogd71lTTC
         yrow==
X-Gm-Message-State: AOJu0YxyDlKG1FBN57izIF2A1tG4zzSxTRb4Bz7tz3iQuCEb83Hj/vI4
	0FI2KMZLWDosP46Swf9Dod05GBF2jFn4uKo/v9oQKyxJo6HxM7nMk2R6
X-Gm-Gg: Acq92OEL+IHA2+Nu8jW6HbCjp8SgWo+F2ykhTK7qAa1QE1rNL5AZaXIETsA6uHaafwF
	nBglHcbFfFF2XgZqkcczNpsnzSFq02u7KTbc7im4uJ3IAACOY7hamG9KTc7kLLxut4xTRWlgcZ/
	Z1aGp5m/xYMkfKkkirVYDRE654dPhohxunYZoGGZsXQoU4RabdD83qoE57YM18vPeKJaHZVem65
	S0izkcIj4/SDBfUPHTXHltGtH+heOk0MUTV89DfGteDGKQ2Y1Wusu0cwi/bHBEbtst7HQuDwSbI
	VcR+Rt5+qxjkv9FilfgM0pEtVTWIy5UO60jXXOyzEwSCN50sHU7vNCfGU6ncl3+3FR3rIAMdzYb
	wtHAMyOmll7Bg1XP1964Msxgy17KOW+47ccTcZ7hjdz59rw4SmvvP2KPy7lE+KP5SPwxPQC54w6
	u5anwmpQw548XZmsCeg4ICeE4FZmgvYVRvh4S4DBs=
X-Received: by 2002:a05:6122:4fa4:b0:56c:d623:896e with SMTP id 71dfb90a1353d-58663a5c2bdmr955994e0c.14.1779417097430;
        Thu, 21 May 2026 19:31:37 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f2f791d1sm640709e0c.5.2026.05.21.19.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 19:31:36 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH v6 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Date: Thu, 21 May 2026 23:31:09 -0300
Message-Id: <20260521-realtek_forward-v6-0-d391bbad38c3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO2/D2oC/23Oy2rDMBAF0F8JWldFb9lZ5T9CKHqMEtHEDrJRE
 4L/PYO7qLG7vFzOnXmRAUqGgex3L1Kg5iH3HQbzsSPh4roz0BwxE8GEYVJIWsBdR/j+Sn35cSV
 S7l2QztpgjCKo7gVSfsyLR9LBSDt4jOSEzSUPY1+e86nK5/53VfLNauWUUaWSNxJ7b+Fwvrl8/
 Qz9bd6q4s9rtv2qCvSRGQVCMC9bvvZy6c3WS/Q8Njbo1Ggn/dqrhef/eIW+8SYaxwFSDGuvl77
 deo0++DZZJgK3jVj6aZrenHaALrgBAAA=
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
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, Yury Norov <ynorov@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-290642-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,yahoo.com,nvidia.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,davemloft.net:email,msgid.link:url]
X-Rspamd-Queue-Id: B020C5AE0EB
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
Alvin Šipraga (6):
      net: dsa: realtek: rtl8365mb: prepare for multiple source files
      net: dsa: realtek: rtl8365mb: add table lookup interface
      net: dsa: realtek: rtl8365mb: add VLAN support
      net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}
      net: dsa: realtek: rtl8365mb: add FDB support
      net: dsa: realtek: rtl8365mb: add bridge port flags

Luiz Angelo Daros de Luca (2):
      net: dsa: realtek: rtl8365mb: use ERR_PTR
      net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration

 drivers/net/dsa/realtek/Makefile                   |   4 +
 drivers/net/dsa/realtek/realtek.h                  |  47 ++
 drivers/net/dsa/realtek/rtl8365mb_l2.c             | 547 ++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h             |  32 +
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  | 657 +++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c          | 223 +++++
 drivers/net/dsa/realtek/rtl8365mb_table.h          | 134 +++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           | 936 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c.orig      | 847 +++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |  39 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 537 ++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h                  |  27 +
 12 files changed, 3958 insertions(+), 72 deletions(-)
---
base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
change-id: 20260323-realtek_forward-1bac3a77c664

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


