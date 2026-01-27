Return-Path: <netdev+bounces-253994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB3DM/QUeWl3vAEAu9opvQ
	(envelope-from <netdev+bounces-253994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:41:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A3B9A115
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E028B3034E00
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6E2356A28;
	Tue, 27 Jan 2026 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZFzzsc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5F36EA81
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542771; cv=none; b=b51zrfD/XL2ttcjVk5aEZnenUJmwIWGAY33QUdvnCv3uedA2qQ/L6+Ib1N2qDLFvlzoL5ZFiYqfADg9rfU06Li2k7jXMLw5BWsDqEIKcX1uTwm3qh04VaddmFLlGWmr93Rf+zPq1NW728Ded9Ju8z28nq33hpli92SnCIZp/5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542771; c=relaxed/simple;
	bh=g6k7zzUsrT7F487MO4zf2ZQi4xNe9hcuQHBGVzU3D4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cfFoXkrDq7NZUDZTuxzT+A+HYrSj5P57p935S5K3GCFSjvRc0pzhLetE7uF6UAtFnbp5seY/aRcw6KMer22Q4H+2as/uoLsp6Q9pXthXE2ciIL7bF/2aFxyiTRy5QRlVbAbKp+WW2kQ9kVOzKHO/vVL3bIiiRBx0nlaxiQ8w1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZFzzsc0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8707005183so930461466b.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 11:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542764; x=1770147564; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eSbmEUZcW8Nu0dPxbuGEHIOk7OwoB0RMeyMHkhwbJas=;
        b=nZFzzsc0hUHBBgS1vIhmtsIYXNEyZnoXazGfK2lLUYFCVotRAHgXY/M65lWfkIYggb
         O8VS4z+7kOYTx6Ucbq8YOYETcm3sF46Na9/MoOt7qluE99EyoA//PxuGMZOPT8O5Q+ri
         bORdpmYoIEycf9ejwKTyPa1w9y/YkbXrB/gF2JF2O44C9x1iNLn28fwYeTEU3yr2EVDV
         8+J4rtstSyN+76PsSt47nu7szCUgE1/n+FyyF1zQVcdUDQnjpP0PSnVuue5VtulrArcb
         PelPdlcNismPIIK+w8TVEBbd7aHiBNLOzl/y1dRYa91qEOhYvHx5dkOwdsWh4jeJjOe3
         sJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542764; x=1770147564;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSbmEUZcW8Nu0dPxbuGEHIOk7OwoB0RMeyMHkhwbJas=;
        b=PtfQwhE8gJFCZCIfBMRu6n121P2ML6qfPOO9fgfZ9WuBSvTI3TdrsqRjOKCx3minHi
         jck7/mlzp+A8gPyyU6OMeOsNP6/sjyuAZlBFxv3E8iRBu6xLHY+0W0KM/lBVGLzNdj5J
         jRP+P0z19c+5g7c1Af14Dsoz8txxeVLzoTG+zcZp/TJJNl8c07MdvNSWGAdsLktAQDYT
         lojufUAmEXAjdbk4GZZ2Pyu11CbBUjoJCpdEjIsLAw2lr7O10QeTm6OVQo53XhRYgPn+
         rq+kooedeIpiWeH+h9j9phNTqUjNN9fmpScNIav6yZsHOF0+PeleJqpdEvyr0sk6xqgB
         HQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUB8Q4BfRw/X9zdYTwWtbiaJbWHCqnB1GFrnLgamAXPPxUCRmKaM+Z1451N8rjn2v7WJi5Z8ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1Bhr6u5DSAS4hBcW+7R8Z9t5dl3EjFpGZ+f0p2UibQ2/uDBa
	bSwB24nobH+9gdLfnmu7RGfRzeGpHWsFMdHydxpIIECWYTdhjf7qLI99/VVWoWFb
X-Gm-Gg: AZuq6aJmR01lDf0E8S0XudgOKJMbHsZR0yDDtFB94h06fX5+p2NjOTZDthRczDPSbtI
	waM4c99qsRJVPkdR/DBSlGVq+HwbFUylV/NVCs9h8tiH4y737Yxeupvp/7/r5nYOzosgO0nI5Dm
	E0t0VcCiWFXZC4ZJ1my7/f2oUKfVmZ9zIbKjdDcABvG0qNqgiY/VImkd7/wMXSqMd9A4MXvRLX8
	KZG+1oqlo4jKs8j3QE9nicWQFsgCD087LJQ12NhmFIpY+/siiajEFt1m3EGwIaVBYZbhRdKxk3k
	sWDZSwFE3MJ6O13nvHMf/f6Jng9dwYv/2ntzYjeAP0N9+tbAa9XF1thEYSffjGsIvm1nK1XpPEW
	ECAiqaQUvXvPpesQpcPo81N0zNuUIdvt+LfRpZoSHcXKoVRwPV9LmAZzJseePE5P1xgECWhN0aM
	sH2T4pwE18pGw7+w==
X-Received: by 2002:a17:907:743:b0:b88:411c:fcbf with SMTP id a640c23a62f3a-b8dab28d5b8mr227101466b.12.1769542763675;
        Tue, 27 Jan 2026 11:39:23 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbefc6685sm22433266b.17.2026.01.27.11.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 11:39:23 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Tue, 27 Jan 2026 19:39:20 +0000
Subject: [PATCH net-next v2] netconsole: selftests: Move netconsole
 selftests to separate target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-netcons-selftest-target-v2-1-f509ab65b3bc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQrCMBBFr1Jm7UiTRouuvId0EZNJG2gTyYRSK
 bm7obh1+fi893dgSp4Y7s0OiVbPPoYK8tSAmXQYCb2tDLKV11ZIiYGyiYGRaXaZOGPWaaSML2G
 t0K7X8qKh2u9Ezm9H+QlVquKWYajL5DnH9DkuV3Hsv7r6W18FCrTdreudUkYZ+RgX7eeziQsMp
 ZQvLLOy2sgAAAA=
X-Change-ID: 20260122-netcons-selftest-target-b1dd1af7a25a
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Breno Leitao <leitao@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769542762; l=10027;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=g6k7zzUsrT7F487MO4zf2ZQi4xNe9hcuQHBGVzU3D4w=;
 b=ahjUZtSUNXgxupp+8CwZFXKv/EsOb7a5HAAKBYSHPvjFzPBo/mYk9B6b/bqQoz/YakGW4TIuf
 zqgLndsiBezASxDzT/OBG9f+JLjT+QhsMxYoJEwVqY5cxQiLlLFXfHW
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-253994-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 04A3B9A115
X-Rspamd-Action: no action

This patch moves netconsole selftests from drivers/net to its own target
in drivers/net/netconsole.

This change helps saving some resources from CI since tests in
drivers/net automatically run against real hardware which are not used
by netconsole tests as they rely solely on netdevsim.

lib_netcons.sh is kept under drivers/net/lib since it is also used by
bonding selftests. Finally, drivers/net config remains unchanged as
netpoll_basic.py requires netconsole (and does leverage real HW testing).

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
This was initially discussed in [1] when Jakub pointed out new tests
were failing on HW runs. I'm not sure if the CI is going to
automatically run these or if some changes are required on NIPA in order
to do so.

Link: https://lore.kernel.org/netdev/20260120172057.6600eefe@kernel.org/ [1]
---
Changes in v2:
- Removed unnecessary "*" on maintainers entry (Breno)
- Link to v1: https://lore.kernel.org/r/20260124-netcons-selftest-target-v1-1-d3937f44c4c2@gmail.com
---
 MAINTAINERS                                           |  2 +-
 tools/testing/selftests/Makefile                      |  1 +
 tools/testing/selftests/drivers/net/Makefile          |  7 -------
 .../testing/selftests/drivers/net/netconsole/Makefile | 19 +++++++++++++++++++
 tools/testing/selftests/drivers/net/netconsole/config |  6 ++++++
 .../drivers/net/{ => netconsole}/netcons_basic.sh     |  2 +-
 .../drivers/net/{ => netconsole}/netcons_cmdline.sh   |  2 +-
 .../net/{ => netconsole}/netcons_fragmented_msg.sh    |  2 +-
 .../drivers/net/{ => netconsole}/netcons_overflow.sh  |  2 +-
 .../drivers/net/{ => netconsole}/netcons_resume.sh    |  2 +-
 .../drivers/net/{ => netconsole}/netcons_sysdata.sh   |  2 +-
 .../drivers/net/{ => netconsole}/netcons_torture.sh   |  2 +-
 12 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3df85fd5acd..ee9c76cc0561 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18021,7 +18021,7 @@ S:	Maintained
 F:	Documentation/networking/netconsole.rst
 F:	drivers/net/netconsole.c
 F:	tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
-F:	tools/testing/selftests/drivers/net/netcons\*
+F:	tools/testing/selftests/drivers/net/netconsole/
 
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 56e44a98d6a5..450f13ba4cca 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -22,6 +22,7 @@ TARGETS += drivers/ntsync
 TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net
 TARGETS += drivers/net/bonding
+TARGETS += drivers/net/netconsole
 TARGETS += drivers/net/team
 TARGETS += drivers/net/virtio_net
 TARGETS += drivers/platform/x86/intel/ifs
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 3eba569b3366..8154d6d429d3 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -15,13 +15,6 @@ TEST_PROGS := \
 	hds.py \
 	napi_id.py \
 	napi_threaded.py \
-	netcons_basic.sh \
-	netcons_cmdline.sh \
-	netcons_fragmented_msg.sh \
-	netcons_overflow.sh \
-	netcons_resume.sh \
-	netcons_sysdata.sh \
-	netcons_torture.sh \
 	netpoll_basic.py \
 	ping.py \
 	psp.py \
diff --git a/tools/testing/selftests/drivers/net/netconsole/Makefile b/tools/testing/selftests/drivers/net/netconsole/Makefile
new file mode 100644
index 000000000000..b56c70b7e274
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netconsole/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_INCLUDES := \
+	../../../net/lib.sh \
+	../lib/sh/lib_netcons.sh \
+# end of TEST_INCLUDES
+
+TEST_PROGS := \
+	netcons_basic.sh \
+	netcons_cmdline.sh \
+	netcons_fragmented_msg.sh \
+	netcons_overflow.sh \
+	netcons_resume.sh \
+	netcons_sysdata.sh \
+	netcons_torture.sh \
+# end of TEST_PROGS
+
+include ../../../lib.mk
+
diff --git a/tools/testing/selftests/drivers/net/netconsole/config b/tools/testing/selftests/drivers/net/netconsole/config
new file mode 100644
index 000000000000..a3f6b0fd44ef
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netconsole/config
@@ -0,0 +1,6 @@
+CONFIG_CONFIGFS_FS=y
+CONFIG_IPV6=y
+CONFIG_NETCONSOLE=m
+CONFIG_NETCONSOLE_DYNAMIC=y
+CONFIG_NETCONSOLE_EXTENDED_LOG=y
+CONFIG_NETDEVSIM=m
diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netconsole/netcons_basic.sh
similarity index 98%
rename from tools/testing/selftests/drivers/net/netcons_basic.sh
rename to tools/testing/selftests/drivers/net/netconsole/netcons_basic.sh
index 2022f3061738..59cf10013ecd 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netconsole/netcons_basic.sh
@@ -18,7 +18,7 @@ set -euo pipefail
 
 SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
-source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+source "${SCRIPTDIR}"/../lib/sh/lib_netcons.sh
 
 modprobe netdevsim 2> /dev/null || true
 modprobe netconsole 2> /dev/null || true
diff --git a/tools/testing/selftests/drivers/net/netcons_cmdline.sh b/tools/testing/selftests/drivers/net/netconsole/netcons_cmdline.sh
similarity index 97%
rename from tools/testing/selftests/drivers/net/netcons_cmdline.sh
rename to tools/testing/selftests/drivers/net/netconsole/netcons_cmdline.sh
index d1d23dc67f99..96d704b8d9d9 100755
--- a/tools/testing/selftests/drivers/net/netcons_cmdline.sh
+++ b/tools/testing/selftests/drivers/net/netconsole/netcons_cmdline.sh
@@ -12,7 +12,7 @@ set -euo pipefail
 
 SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
-source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+source "${SCRIPTDIR}"/../lib/sh/lib_netcons.sh
 
 check_netconsole_module
 
diff --git a/tools/testing/selftests/drivers/net/netcons_fragmented_msg.sh b/tools/testing/selftests/drivers/net/netconsole/netcons_fragmented_msg.sh
similarity index 98%
rename from tools/testing/selftests/drivers/net/netcons_fragmented_msg.sh
rename to tools/testing/selftests/drivers/net/netconsole/netcons_fragmented_msg.sh
index 4a71e01a230c..0dc7280c3080 100755
--- a/tools/testing/selftests/drivers/net/netcons_fragmented_msg.sh
+++ b/tools/testing/selftests/drivers/net/netconsole/netcons_fragmented_msg.sh
@@ -16,7 +16,7 @@ set -euo pipefail
 
 SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
-source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+source "${SCRIPTDIR}"/../lib/sh/lib_netcons.sh
 
 modprobe netdevsim 2> /dev/null || true
 modprobe netconsole 2> /dev/null || true
diff --git a/tools/testing/selftests/drivers/net/netcons_overflow.sh b/tools/testing/selftests/drivers/net/netconsole/netcons_overflow.sh
similarity index 97%
rename from tools/testing/selftests/drivers/net/netcons_overflow.sh
rename to tools/testing/selftests/drivers/net/netconsole/netcons_overflow.sh
index 06089643b771..a8e43d08c166 100755
--- a/tools/testing/selftests/drivers/net/netcons_overflow.sh
+++ b/tools/testing/selftests/drivers/net/netconsole/netcons_overflow.sh
@@ -13,7 +13,7 @@ set -euo pipefail
 
 SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
-source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+source "${SCRIPTDIR}"/../lib/sh/lib_netcons.sh
 # This is coming from netconsole code. Check for it in drivers/net/netconsole.c
 MAX_USERDATA_ITEMS=256
 
diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netconsole/netcons_resume.sh
similarity index 98%
rename from tools/testing/selftests/drivers/net/netcons_resume.sh
rename to tools/testing/selftests/drivers/net/netconsole/netcons_resume.sh
index fc5e5e3ad3d4..cb59cf436dd0 100755
--- a/tools/testing/selftests/drivers/net/netcons_resume.sh
+++ b/tools/testing/selftests/drivers/net/netconsole/netcons_resume.sh
@@ -20,7 +20,7 @@ set -euo pipefail
 
 SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
-source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+source "${SCRIPTDIR}"/../lib/sh/lib_netcons.sh
 
 SAVED_SRCMAC="" # to be populated later
 SAVED_DSTMAC="" # to be populated later
diff --git a/tools/testing/selftests/drivers/net/netcons_sysdata.sh b/tools/testing/selftests/drivers/net/netconsole/netcons_sysdata.sh
similarity index 99%
rename from tools/testing/selftests/drivers/net/netcons_sysdata.sh
rename to tools/testing/selftests/drivers/net/netconsole/netcons_sysdata.sh
index baf69031089e..3fb8c4afe3d2 100755
--- a/tools/testing/selftests/drivers/net/netcons_sysdata.sh
+++ b/tools/testing/selftests/drivers/net/netconsole/netcons_sysdata.sh
@@ -18,7 +18,7 @@ set -euo pipefail
 
 SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
-source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+source "${SCRIPTDIR}"/../lib/sh/lib_netcons.sh
 
 # Enable the sysdata cpu_nr feature
 function set_cpu_nr() {
diff --git a/tools/testing/selftests/drivers/net/netcons_torture.sh b/tools/testing/selftests/drivers/net/netconsole/netcons_torture.sh
similarity index 98%
rename from tools/testing/selftests/drivers/net/netcons_torture.sh
rename to tools/testing/selftests/drivers/net/netconsole/netcons_torture.sh
index 2ce9ee3719d1..33a44adb6f8f 100755
--- a/tools/testing/selftests/drivers/net/netcons_torture.sh
+++ b/tools/testing/selftests/drivers/net/netconsole/netcons_torture.sh
@@ -17,7 +17,7 @@ set -euo pipefail
 
 SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
-source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+source "${SCRIPTDIR}"/../lib/sh/lib_netcons.sh
 
 # Number of times the main loop run
 ITERATIONS=${1:-150}

---
base-commit: 62777c8015f3d86ab7853790192b24f0cee8a647
change-id: 20260122-netcons-selftest-target-b1dd1af7a25a

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


