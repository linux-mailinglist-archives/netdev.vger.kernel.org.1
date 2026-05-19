Return-Path: <netdev+bounces-289270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9725BO/tC2pQRQUAu9opvQ
	(envelope-from <netdev+bounces-289270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:58:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4C5774C1
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23CFE3047BD3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84BF3093DF;
	Tue, 19 May 2026 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2ABm2JD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB742EDD7D
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779166696; cv=none; b=Kkkhjh147jo0gL5XVaZ8yh28GnqERSFMv9ZbCNWaYZuHA8IDy8uhbN+UW8ouuOcJihutcOq+UEZ/PXMuhvmNC5zQfgQoPs5uGpTy56vhz1ZHfLf/IHg3i+3dPqDpHEI0J9avFEGWaS27b9+sInprAhYI6FezRH4a4gB4MpB/m0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779166696; c=relaxed/simple;
	bh=KJXO7/rOTG6BeeYL0LfEfBJbokPx/cBlBbaUTj0pr24=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G1F1ALqbqcQCaX5jQaVwTU74NCbZbAsf3whAkJWpVWQkTbmFbOexXFmY2N9EWp+u8P27lBWxk8fNz8Rc2H1zBhcBczEwMkPT8FLzs0dn5ayCZznuazYH4pcWNRp9pohu74qNZwWlGEQ7rBYQTECu7ENXHx2xUx3qZj2QWLmDpSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2ABm2JD; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-90ea08cc5ceso564461785a.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779166693; x=1779771493; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xx56vMqzDIyLCnIS01xeQI9ZapGjWmBkyJ9Xo7JzsbE=;
        b=s2ABm2JD54tlZerjHNm0PDP3FGivvWztIZrrPqjtyZOXXNdMFSjtKARVwaM4yYrNyQ
         yifP47859fhhjg+HNtdzvmVQJ5NPE8RnaNvFXTErdQN1YyqMYaE482MQocJfkuoNLWjP
         W17qN6mEKvt0/OrC5h9ujMI/eTo/XNLdWWzbc9uM9ooe4vgDbRQRCzAnTcBZm2IEKnK/
         3qEepvfAzBXBXD+w0/xY2R0NfTbzU6J5Z1Jv8e+7/crcnc+X/p87fNQ7SxT+mZliSfPv
         Q0tDN1tzFxdMBHvr4MWYk2CI6xXXtOGtR/2AYpy25nPKiUit9iBGFULIeAAqjj1OaP3/
         +n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779166693; x=1779771493;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xx56vMqzDIyLCnIS01xeQI9ZapGjWmBkyJ9Xo7JzsbE=;
        b=fkr7ocoXR4gBxLEFcjt8+4O+ri8A0cVUFmVapUoWozjTZELSUopgq6JFsmrKO269s2
         57MbNnQ07kMrf3yoH18hJFeZOIQOCUedpWsiWM/R+HV3QswGu198aKlNawyKF6OXZkmw
         Z+lAsQpxee+pYcPXAww5MxEy86PsLYMYUZnEsvzII5tRocvBrUkEfqN574sz/UpWXvZj
         aL104og5137Hpt1vApsr+YPVnJrAd6M/V67e6MulyxVBk5cHtYFGArSSmXz4Wpom1vvx
         4Z+8tH7iZNWeuSvIE345ZruG4th8pv3HNtKyIDuSVP5tcN58FbEn1i/LeRQAB5EFnKzr
         /OlQ==
X-Gm-Message-State: AOJu0YzEssOCrU8lGaaeiFlQ3uHmp3zMVq1DAp/moXl2J0mBG/ucoR8f
	ThcNoa3S1I5scZWPFHaSEC6hpMwsWfx6sKer/zWW3S9wXP/Wx3Sel0e2
X-Gm-Gg: Acq92OG3vH5gOHLUZJXxlr5dsuITXa7E3aNWBNMDI9rNccba0cmpt9fGTmnruQbYYd9
	QI9ny1U8vKnp9+IRWLteNlDOnFfqkHpbFyQtUSfHg8BX7BTDpg8w7Ciw7qcUZjh3X0wsaubMrXq
	OV76L5lyk5u5Pj2vbjMvwgJoo9umjMvFXTVi988+BNsQPJNid8rJTccnyu8IvmXKGNMKn/9IKdm
	Ahic89DunuI4eC9JROWAa2Gj0MPofn5K0bAdt3CiObhVhhKni3qK5m4uTOZzJQCIvaf2ENGHNM9
	YmLzmJay66SxixeTziShgZp9M31HUWXG8xZOqWr3nVQcPwi8rL3viDPes6ryBXy38cf4QWsv4I/
	RALlNldonSxorPiKB+haYcea/19PVnF9QhVhEdAGdpPPZKKZb58Sa/1GjM1oqlaTIC73Xyiv52B
	QkkxABlJZKCY6NFuUegS2timeji+L/p+Qyq9Dn+qI=
X-Received: by 2002:a05:620a:258d:b0:8cf:c513:349c with SMTP id af79cd13be357-911cdd431f7mr2636693285a.9.1779166693131;
        Mon, 18 May 2026 21:58:13 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9114edfd3ebsm1588593185a.23.2026.05.18.21.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 21:58:12 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH v5 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Date: Tue, 19 May 2026 01:57:55 -0300
Message-Id: <20260519-realtek_forward-v5-0-cb9f702c1782@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANPtC2oC/23OTQrCMBAF4KtI1kaSTJpWV95DRPIz0aC2kpaol
 N7dUBeW1uXj8b2ZnrQYA7Zkt+pJxBTa0NQ5FOsVsRddn5EGlzMRTCgGAmhEfevwevJNfOroKDf
 agi5Lq5QkWT0i+vAaFw+kxo7W+OrIMTeX0HZNfI+nEh/77yrwxWrilFEpvVGQe1Pi/nzX4baxz
 X3cSuLnC7b8KonsHVMShWAGtnzuYerV0kP23FWlLXxVaDBzLyee//Ey+8oopzRH9M5O/TAMH4I
 Yvr14AQAA
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289270-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,yahoo.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,armlinux.org.uk:email,davemloft.net:email]
X-Rspamd-Queue-Id: 79B4C5774C1
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
 drivers/net/dsa/realtek/realtek.h                  |  42 ++
 drivers/net/dsa/realtek/rtl8365mb_l2.c             | 553 +++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h             |  32 +
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  | 593 ++++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c          | 223 ++++++
 drivers/net/dsa/realtek/rtl8365mb_table.h          | 134 ++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           | 754 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |  25 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 536 +++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h                  |  27 +
 11 files changed, 2851 insertions(+), 72 deletions(-)
---
base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
change-id: 20260323-realtek_forward-1bac3a77c664

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


