Return-Path: <netdev+bounces-288563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NQtMOXoB2pFOQMAu9opvQ
	(envelope-from <netdev+bounces-288563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:47:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 254BC55A0E6
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DD4F300678F
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F5A2701CB;
	Sat, 16 May 2026 03:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljigUycJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2F2236EE
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 03:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778903224; cv=none; b=nYo3tK7WCGolxOWQMujBxx1bzGzkLPAXrkhYcMkPmWLV3nMX1xetBnorYOGZS4l1CsTANqrUDmE7soAlSqrZLCasAr2MQXSh1T6vMrDs+llCtGWu2c9eoOzNo107XKI2JN3esRARJWcRKjWFN79YvX00onPfTSTWCLHHj+aHUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778903224; c=relaxed/simple;
	bh=dsCddicPNz2vMoYz+r1VIeAagSjjACfz09Hzlv+yBO0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lox3kcbQK8IUeTYGmE7gFaYII1QMjfnUbj0dnaWjiX9bxhJJuqslQFOu68av+biRLFjaqQmBqDGQnyQr2A7wMsYdkGrEVMe0SrqbArqtbalp60xjUUgSxIHYt7GhruZfGVz3alIpVW1UhjXHZi4AGgK+niwr/gjYE3DtN8A46ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljigUycJ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b8e98fd885so8590966d6.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778903222; x=1779508022; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8WxhXuzauTUduVu+D8SXd21yI5sRtCuuFQxDxD9C2c=;
        b=ljigUycJg3mChpm66P5Cyrmrom5DAqd/un2WFq7SsN74KaDJ5jpaA3nO+SqrQCOICr
         yQBwA5dpY+capjwwTaVqLSMHbeOHeClzaSynnHmnw/bVdM7tpu8PCCWCWfX02oDo1z8w
         2awwYjT+DjbWZVEF6A2FRe4/W+4biYc4BB9ylu9vnmAC2p/AeOBBCBVO89hgTkN18Im4
         uJ5q7nCNVZnMzBmnX4acjvpaU6Vcf2MS9XtkSkBL+gHcHnrgI1T9oGnJUWaFfMSWF19h
         3HU/9+Xyq9g7XwSSragVSC0EXVIUREi3aZi8r95w63g4yuqHBMoj2YU0Yn+ZNNg6SSVc
         30PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778903222; x=1779508022;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8WxhXuzauTUduVu+D8SXd21yI5sRtCuuFQxDxD9C2c=;
        b=gIYJ64kewQotCZBCLzct7dNWCUaan/aIs2eafOBkVbkxzyhyAzZcmevRy2SO5BqpDQ
         rpeBGxFjtw0DeR0TMNuZPDY1k+fh3J1OtuYEce6WNPSrHn/MjfPl7lrJlF13iqZCPQc+
         osdH7nSZ+hBjhC+JKP8nph2486N0HAkeDCjUunSbI6df4+JpkqBTvkFwPmfKjt5Gziz8
         IMs82tS/WmAb4t5Aw4q/GKMyAlWkITHICbdZzcLptmcV2qcHfm5cu425Zn1y+1xToFfZ
         waV2ueku08q56vXaDR2vPq46raATouFmbw3bRPnQh58LC1bvHGRxsLBi0oDdRFLhqqZF
         Fn0Q==
X-Gm-Message-State: AOJu0YwKni5P1GnBHjWdfuuhADRllLuBcm/D/EXWa2bKiWODzK1LfpUy
	hN5AjF4D1kIsu2Pgq4ZFGzfCjzP+WrmUVVqZhzrLjdx3WUCQaMErpZF/
X-Gm-Gg: Acq92OGSUwE77WAFfHl3k7860V3leYgqqN8Dfk/7lid0PUkhj0YJ2lf0wtbZrfvpyeP
	AfCQJXMONfO871+8JWVxdUy9T/hREjpNyeg9eEc2Ja1ZFwhun8Mhv+QM8umtIjUsbeG7GiW5ygF
	81/zCliw/yDQmkq2TVCRW2pLUpZPFQU0wybXA7s3JekBOZneO4dLJDWvySDe2DNA4P5inp0M9IZ
	RZuSn8JD+MDHcD5HBtf8hSw46XJvMKA720X4863LrzLhN8C9W3P6vJY7R8zQcKqCL1T+O4JBbMt
	GMe3GBCY33Jl9x4b/HO7dzdA/Klx7K40dE85dt8iHbCavuK3ORqJePmGRTH5Af/oB1NWjX3oUnj
	KeV/+rCESr3puChHhASBcd0pud/tKlejroLJeHKnthP+z6DF7R+BjwRhej+H//7Q2LZ2PNSlHsv
	IQ9bRPjjFx8ouKnVFlEyM9ER20JEkzeU9i5BN+qLaj0ox1nIzyWg==
X-Received: by 2002:ad4:4eeb:0:b0:89c:d424:aceb with SMTP id 6a1803df08f44-8ca0f6d639dmr114801256d6.31.1778903221858;
        Fri, 15 May 2026 20:47:01 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908d1d2e7sm70874546d6.16.2026.05.15.20.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 20:47:00 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH v4 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Date: Sat, 16 May 2026 00:46:16 -0300
Message-Id: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIjoB2oC/2XOTQ6CMBAF4KuQrq1pO6WgK+9hjGnLAI38mEIqh
 nB3G1xIZPny8r2ZmQzoHQ7knMzEY3CD67sY5CEhttZdhdQVMRPBhGIggHrUzYiPe9n7l/YF5UZ
 b0FlmlZIkqqfH0k3r4pV0ONIOp5HcYlO7Yez9ez0V+Np/V4HvVgOnjEpZGgWxNxleqla75mj7d
 t0K4udTtv8qiOgLpiQKwQyc+L+HrVd7D9HzIs9sWuapBrP1y7J8ACiaSj84AQAA
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
X-Rspamd-Queue-Id: 254BC55A0E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288563-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bang-olufsen.dk:email,msgid.link:url,lunn.ch:email]
X-Rspamd-Action: no action

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
 drivers/net/dsa/realtek/rtl8365mb_l2.c             | 554 ++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h             |  32 +
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  | 589 +++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c          | 216 ++++++
 drivers/net/dsa/realtek/rtl8365mb_table.h          | 132 ++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           | 813 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |  25 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 536 ++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h                  |  27 +
 11 files changed, 2900 insertions(+), 70 deletions(-)
---
base-commit: edf4bee4215a173c0534d1851d7523d827149f9e
change-id: 20260323-realtek_forward-1bac3a77c664

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


