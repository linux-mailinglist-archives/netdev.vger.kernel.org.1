Return-Path: <netdev+bounces-291033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IJLBnVBEWrsjAYAu9opvQ
	(envelope-from <netdev+bounces-291033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:56:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1974D5BD58F
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5158630091DE
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 05:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C683191A5;
	Sat, 23 May 2026 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb6oqxc9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC0231C91
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515751; cv=none; b=gFQPTO12g0n6sxTKDbgj6H+4565FfA20p0e/Kre5nj/DVYZ/OX/jYSBAzFaev5VOWTnrRLgKt86A3mXTqzgXTtpLESIi+6rG+0aU713GnUXMiWaEi45xJ9/s8jsnhP0Qge8K7edro8bVbUrD6r9XD9UNx6rRJhmOvjTDdvU65NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515751; c=relaxed/simple;
	bh=gZKGeD+BsVfehkrv0x7PERoVV8jw+ORk6JhYPSpIRKQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GYcSaBhoJJwBMVaHzoirgLCynC5ADa5h734DyLSmVX4kPy7tGRHLlbSEdLMPf1znOpAyyl64ifTp5OAzsi2QG5y9MYTBew7nfPiwVywTOg1/SEG0AIeMxjip1MZvI8MRZ0P8heWM8bFzxcS/Jp3eqv5KPk4rkRTVt+zDVePDCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb6oqxc9; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-575602688deso2847036e0c.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 22:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779515747; x=1780120547; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UjLwJorAZkPyWQrkOH/qrDHPXo2tCuqHOO36wsy7/8M=;
        b=kb6oqxc9G/CUgAXgaA3tQlpU5jVBJIb69QUSfLhvbHgxSzj/I6t7USQT4x0xHI0s9g
         NkHTDnFBOziNtMS23bkgfGjTWKnUuSzDrbujv+BbO2dqG5Fm5Snp2+LdMESL0+lK70YL
         FVfqXUZtY0jMS17XFwIjWJt9AT5kTUn5YnYxJJZPwvaSNy4xaldE/vIkdbze9k1ueKpS
         FkAlEPRXgyQEq2VjRMYQ/tMndDNaGcckdSXlqSViJfywprW159rSX1sIxs5Qx+t5wGGM
         3Vr1N+la794EK0W46Fy5sh5C+V4MDfTMt1sqQ4cukAn6dHLLDLDRQEcDR9+v3kkaSkMs
         z+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779515747; x=1780120547;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjLwJorAZkPyWQrkOH/qrDHPXo2tCuqHOO36wsy7/8M=;
        b=YQMfMc/noha/KXZKa65QYUWhgUgte8dxNZKqxawKhKYB+xrG8h+ZbWuSbkfbpGYNci
         9vM7sQdFt08vhWZLAz0GszL8g328sqszfWRW1VHLcPqpbtZ5/A38YSJEiI0jTUeUDn1Z
         vKSaXwmP5upVmZCAV1VXemmM+ya5Ome3iqPHK6xCpWixcVwPLv0MR/fF67+FN3vSbglD
         sPuwzDh4LmMJkYWVtpGGZJ8sUBQF0zc6Z5Uy6l0ba5YOZbUZgZnF1/gcU/NaCqyCiCDc
         ngd8j+eSn78YlEXg4ZE46KfjOWRYKXrlPKpgz2E5WLFl63790Ns2MclBAXYHbB507EIP
         m+PQ==
X-Gm-Message-State: AOJu0YzZIo2/qlUFI+G0IhWFFe44lgEsTqLhrv/wnv2gPzgNS0gfqW52
	Awa9F4k93S2WkAGLedb0p1BlMN5XeERsixiM5a4aGHhdyMaXdVfQ9j+G
X-Gm-Gg: Acq92OEswRcF5JtbGSn0JnYZW/hLcS2rsLWl2a0coqb+WfKPf6Yn0Z3sfqO2HrX9dlF
	k2Fg3zhcLFdpdXVkAHxM+4CVdDbbguqvmrQyQ+0HN4TL1jscZ/3yNYoP3xNJOapu4Fo5iXPxo0g
	27h3yVZM9si/YLiijAWHtZw8348EbgaT3TO2uJyea773Ztvka91UyQoYTqNPat0QjbtbPx68/sZ
	PmQvT1U5QwYdaFM7Xc9TMMb6xs8R8eKoIa0IvewD8Ot8lY44qQZ87VZE0EFoTPspwpduCFMY7QD
	T0zZe9xvXWx/KoX/xVmRvRitXaNtPc61yuX9be7VZWGgfe+ATYF0w1Lc5OtYChxtJQgp5lSC+uw
	No0JrOLCGlHgxVZbotS8N7eQ5jDMe3+enJUqp+TwGTfcdXCbdfoJgVtfEBDw6jG4C9H9BbR8CXv
	tgaT//pwgwh37etBVheJD+9+QbmnH9KYFWsp5MrXVWuejfFS47ew==
X-Received: by 2002:a05:6122:32c5:b0:575:3433:bb34 with SMTP id 71dfb90a1353d-586607b6fdemr2959594e0c.7.1779515747449;
        Fri, 22 May 2026 22:55:47 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f973300dsm5023718e0c.18.2026.05.22.22.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:55:46 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH v7 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Date: Sat, 23 May 2026 02:55:33 -0300
Message-Id: <20260523-realtek_forward-v7-0-313805e218f3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFVBEWoC/23Qy27DIBAF0F+JWJcKGB52Vv2Pqqp4DAlqYlfYo
 qki/3upuyiysxxdnQszdzJhTjiR4+FOMpY0pXGog3k6EH+2wwlpCnUmggnNQADNaC8zfrzHMX/
 ZHCh31oM1xmstSVWfGWO6rY2vZMCZDnibyVtNzmmax/y9PlX4mv+1At+1Fk4ZlTI6DTV3Bl9OV
 5suz368rl1F/HvF9r8qovrAtEQhmIOebz20Xu89VM9DZ7yKnbLgtl42nj/wsvrO6aAtR4zBb71
 qfb/3qnrv+miY8Nx0Yut148WD++nf/eveztkAnYfWL8vyA8D8AOD4AQAA
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291033-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:email,msgid.link:url,davemloft.net:email,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 1974D5BD58F
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
 drivers/net/dsa/realtek/realtek.h                  |  47 +
 drivers/net/dsa/realtek/rtl8365mb_l2.c             | 547 ++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h             |  32 +
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  | 669 ++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c          | 223 +++++
 drivers/net/dsa/realtek/rtl8365mb_table.h          | 134 +++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           | 961 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |  41 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 536 ++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h                  |  27 +
 11 files changed, 3148 insertions(+), 73 deletions(-)
---
base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
change-id: 20260323-realtek_forward-1bac3a77c664

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


