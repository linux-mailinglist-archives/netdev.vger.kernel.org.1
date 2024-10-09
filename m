Return-Path: <netdev+bounces-133658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86429969D3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5FC283912
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601FB192D76;
	Wed,  9 Oct 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b="faH9qiFC"
X-Original-To: netdev@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033C191489
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476374; cv=none; b=Ezjk6NiWwHKZaLX2RNjdKcRoQUaKW4DtR1HDCGS68agq0tLl1VG/QID588bYDYPQZDEPrfw3nej5svtvgrUkuoKj1DFuZVvYX/rlD+cCzi2+txNAWH7fjo9qdJu2R/QETIQ9B0H7PQSlXgP/AX7D2Wf8Xda/KlvgLErFSC5QRiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476374; c=relaxed/simple;
	bh=d6ay2TUruC9yqDBWws+/8cTQ7mGk/PaE5kxom9IoQKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VY0+OAYKs5Ldo9BMzkunwiACTpBPskYmxheiCJdGG/BFLCYf/6sm9Yd4MMfTibjaEtb2GfmNQe/+yeTrMJl20soCLZdjqMa8RVKFteA5poU0wzg0nSUapE/zDUrwTVgLz31DuMTQFQ3ZBddP57O7HjO8gw3vfMjKfesAyDBpa3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc; spf=pass smtp.mailfrom=unstable.cc; dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b=faH9qiFC; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unstable.cc
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 3E0304097;
	Wed,  9 Oct 2024 14:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728475983;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=Rsx9pyIlDAvRerj0eNyEOrpwOnSTcJOrqf060J9gMFg=;
	b=faH9qiFCtOso9sO5rw8cbEk1C/JSZ116x1RM+zsmln75UbzfGVecLkK62WxYqvaV
	6xYf8fKoEDwj77KvFFkWbKMZF9AhcqWiu8QC85kK6XD3ygqqc3qDLpQW20CboyJsFvJ
	XPUotsa5fg0o0XljU2Jc1QxMrmwlSMZC2ZkkLN/LCdQSr8YF4r2jEaU6RCyaTOHmXMc
	7Ya70O0TPojstqc78CeOJ1Y1bWQFaLutvQ391Nyjy5VKlMJ7Gqm7k1MDVSsq7Ui/U2W
	dFk38VCKV2mmOUO6k23RgR6pD+bgju6qEpmLX+mN8PInYLdKUmXfH3f4Tipf5xYgvcc
	XVgtcHt6VA==
Received: by smtp.mailfence.com with ESMTPSA ; Wed, 9 Oct 2024 14:13:01 +0200 (CEST)
From: Antonio Quartulli <a@unstable.cc>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	donald.hunter@gmail.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	Antonio Quartulli <a@unstable.cc>
Subject: [PATCH] tools: ynl-gen: include auto-generated uAPI header only once
Date: Wed,  9 Oct 2024 14:12:35 +0200
Message-ID: <20241009121235.4967-1-a@unstable.cc>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:375058688

The auto-generated uAPI file is currently included in both the
.h and .c netlink stub files.
However, the .c file already includes its .h counterpart, thus
leading to a double inclusion of the uAPI header.

Prevent the double inclusion by including the uAPI header in the
.h stub file only.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 drivers/dpll/dpll_nl.c     | 2 --
 drivers/net/team/team_nl.c | 2 --
 fs/nfsd/netlink.c          | 2 --
 net/core/netdev-genl-gen.c | 1 -
 net/devlink/netlink_gen.c  | 2 --
 net/handshake/genl.c       | 2 --
 net/ipv4/fou_nl.c          | 2 --
 net/mptcp/mptcp_pm_gen.c   | 2 --
 tools/net/ynl/ynl-gen-c.py | 4 +++-
 9 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index fe9b6893d261..9a739d9dcfbd 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -8,8 +8,6 @@
 
 #include "dpll_nl.h"
 
-#include <uapi/linux/dpll.h>
-
 /* Common nested types */
 const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_PHASE_OFFSET + 1] = {
 	[DPLL_A_PIN_PARENT_ID] = { .type = NLA_U32, },
diff --git a/drivers/net/team/team_nl.c b/drivers/net/team/team_nl.c
index 208424ab78f5..b00fec07a8ca 100644
--- a/drivers/net/team/team_nl.c
+++ b/drivers/net/team/team_nl.c
@@ -8,8 +8,6 @@
 
 #include "team_nl.h"
 
-#include <uapi/linux/if_team.h>
-
 /* Common nested types */
 const struct nla_policy team_attr_option_nl_policy[TEAM_ATTR_OPTION_ARRAY_INDEX + 1] = {
 	[TEAM_ATTR_OPTION_NAME] = { .type = NLA_STRING, .len = TEAM_STRING_MAX_LEN, },
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index ca54aa583530..c59264f71ef6 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -8,8 +8,6 @@
 
 #include "netlink.h"
 
-#include <uapi/linux/nfsd_netlink.h>
-
 /* Common nested types */
 const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1] = {
 	[NFSD_A_SOCK_ADDR] = { .type = NLA_BINARY, },
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index b28424ae06d5..a5c6ca79c7a4 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -8,7 +8,6 @@
 
 #include "netdev-genl-gen.h"
 
-#include <uapi/linux/netdev.h>
 #include <linux/list.h>
 
 /* Integer value ranges */
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f9786d51f68f..c65a82593e76 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -8,8 +8,6 @@
 
 #include "netlink_gen.h"
 
-#include <uapi/linux/devlink.h>
-
 /* Common nested types */
 const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY, },
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index f55d14d7b726..8d18c0a0ca04 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -8,8 +8,6 @@
 
 #include "genl.h"
 
-#include <uapi/linux/handshake.h>
-
 /* HANDSHAKE_CMD_ACCEPT - do */
 static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HANDLER_CLASS + 1] = {
 	[HANDSHAKE_A_ACCEPT_HANDLER_CLASS] = NLA_POLICY_MAX(NLA_U32, 2),
diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
index 98b90107b5ab..7d3e107eacda 100644
--- a/net/ipv4/fou_nl.c
+++ b/net/ipv4/fou_nl.c
@@ -8,8 +8,6 @@
 
 #include "fou_nl.h"
 
-#include <uapi/linux/fou.h>
-
 /* Global operation policy for fou */
 const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] = {
 	[FOU_ATTR_PORT] = { .type = NLA_U16, },
diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
index c30a2a90a192..d85c4540d6e8 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -8,8 +8,6 @@
 
 #include "mptcp_pm_gen.h"
 
-#include <uapi/linux/mptcp_pm.h>
-
 /* Common nested types */
 const struct nla_policy mptcp_pm_address_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
 	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 9e8254aad578..341be0a4bcb7 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2683,7 +2683,9 @@ def main():
             if args.out_file:
                 cw.p(f'#include "{hdr_file}"')
             cw.nl()
-        headers = ['uapi/' + parsed.uapi_header]
+            headers = []
+        else:
+            headers = ['uapi/' + parsed.uapi_header]
         headers += parsed.kernel_family.get('headers', [])
     else:
         cw.p('#include <stdlib.h>')
-- 
2.45.2


