Return-Path: <netdev+bounces-253095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIR8Ec0UdWlPAgEAu9opvQ
	(envelope-from <netdev+bounces-253095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:51:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA27E8E3
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7868F3010D82
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6B273D75;
	Sat, 24 Jan 2026 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6CekC0U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056AA226CF1
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280714; cv=none; b=gqQYad+fScpWwHIycQiG0w6w2N2NF3mbQ8wWTxilQk9fcwRSn+JvVlHv0pmKBn/ZLJ0V/ufyvvgoZ33EQDkEdfxaNDtphTEgnlluJBRZ71sdh3ILwkcoBHhKHfHN7z/G15ZHRZGCpE3ZYxCV8XiY37tb2JsJbQ0VrGCu/yzo/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280714; c=relaxed/simple;
	bh=hACeFLmB7JO7jj9lR2cviMtZn9mZeZtTO0aBpjglBOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ViDmozY26Sz3cKJZHcbm7NumEaPG6e96gtEApjSHkeRbpeIEMFGJtUQu6X/4ICx6ITXakLx0LOjL1TUpd043TIRJcusS1mNSuatkpKQzx9tVNStgOcuiaWmof2CWoTGnMagZppD1XSU7XqmwPAXU2NEGV17S+nGSP5r1/Wo4RhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6CekC0U; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48058548779so2685045e9.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 10:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769280711; x=1769885511; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zDWnFF3L77mStDU/jp9FeJ9XntgIY7dtEZmIsI8Hxi4=;
        b=h6CekC0UvvN8AJg5yhWhWIBncToPdY68Lj1OZhc07ovxIiFpvOI/1b4MwQjOup5MqA
         wZJzIiLYkYvadSyJTXN9diXVe67bgB0wLMAgGtJ2E7pJwoPVCJTpMZScJRlXNcoMVFkb
         cbxI7E4J8RVYx9/5yDhqeWTSVenbp5xMnSyK69TMsTkXh1YzJE+T7NC3yxC9GfaFeHQv
         zQV33g8b7nPsHtgDk66B8+XxBOo9ihwQh5UsO54qx2WqedKYE7Q28qWUl1OSKqLL44EU
         laxmkwRp0HfLEqMOOtfp+Xnd5Q/NhOEp2koxLWLFZ8qorOkLb37oDgtvU9IZjlwuPpA5
         EkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769280711; x=1769885511;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDWnFF3L77mStDU/jp9FeJ9XntgIY7dtEZmIsI8Hxi4=;
        b=unA4rq61anOFCikiYnINpqPfv8GPyEy4h8tLvdZhHHZ8eXltDuXg4UetdEa1GAUIzv
         IOUrDb/Onq/ugwu6aFt/AMjnk9VCHZFgHaI7VZ6ZYuV0RQG5G8NgtRT1mLr/v2uwINKG
         HPFF1/v1hnToD/S+3O8Wb9XsBiWeUc+kmcPKKloH1xQNPJbN5C1V+VNTIS4HKcfstbIu
         89Soif/H8Annu37lJD0jt9F3azjGv9MZ7HZwo+2v7T4+xZFy+OqGvu9P/HKJN6M2oOr1
         m6j7MbJBKVRlL/MNBE7UxFJO8uDNBKNOU1HsKp4CVzMdkKgAOOzDnUCXuDGoY223Zivs
         h74Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT63SXR0qUCOGwwgJL4Yspo8w7rS7rodaKwqv9nkjAd81yBx010D7FexpEcjaq+wBIIbOOkr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyiTcUCG6OQDh4bkyITbcrcCAxYdY4a41HTtbmliX7NTPtD1YC
	PCcVyGqCZrMayuDvviaXjxbZ933oqYEjfVskdwA5uUxPiTyMAvtvODFv2x8G5VSZ
X-Gm-Gg: AZuq6aIFoo1h0gwKwqFUzaz5dwVAtQTl1FWomGwDJn62IgYiMFirSvTwHCfKA2U4wcI
	ihzf4CtEt2F8NwE1B0lRV5ZVaMQjHTqwhWj4pqRagKPJD6ddFC6N4ciPcp8891eZ8XjrnRWvJMv
	V8DqOvGTKLBoIBupGQkmjWsjqnTYOOZ2yM7dakhMCjzCFIJ4lYpaZ9xLfT8C+oBhHbQS8Eg/BWm
	vvV9Z1fjkdiuiieMICs4Dd8aPzCShphMSH4VW8KAO72WGkVyt7bZbY7QKuIIZ20av3nTnDxxd30
	1XrgpDXGGXtoHPf/wZfnkbnrGajwr9NOoOqKL17itnVpDDYnyft8wGsEFy2sLWOprZC+92S0uGs
	cQbR3BxH3ZANZYLPO3TIfeWZfDGXiZ6BkMa5QzltQv5Boz1Mom61/mLzWcGSctDqlNkK01sbnYD
	pkJZcg56d5fRsKwYk0hSTqeREo
X-Received: by 2002:a05:600c:198d:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-4804c9af7f2mr109144515e9.22.1769280711140;
        Sat, 24 Jan 2026 10:51:51 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85cff5sm140700785e9.7.2026.01.24.10.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 10:51:50 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sat, 24 Jan 2026 18:51:42 +0000
Subject: [PATCH net-next] netconsole: selftests: Move netconsole selftests
 to separate target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260124-netcons-selftest-target-v1-1-d3937f44c4c2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDQAxA0atI1g04gVbwKsVF6mQ0IGOZBBHEu
 zd0+RfvX2DSVAzG7oImh5ruNSI9OphXroug5mignl59IsIqPu/V0GQrLubo3BZx/KScE5eB6ck
 Q+tuk6Pk/vyFQwNNhuu8fbrsOK3MAAAA=
X-Change-ID: 20260122-netcons-selftest-target-b1dd1af7a25a
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Breno Leitao <leitao@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769280710; l=9802;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=hACeFLmB7JO7jj9lR2cviMtZn9mZeZtTO0aBpjglBOc=;
 b=DXU3lwfOweYqoWeAkeP7qWj5RfJr+V85r1lfLzoicK0dCq/YFPnCTooBC0p3KA58C5wEzlcJ3
 U9QMbnGWX6gDw4u2135HQCRp1+I6QxadMSq+owllJw710vCMoULTG/r
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253095-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netcons_fragmented_msg.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netpoll_basic.py:url,lib_netcons.sh:url]
X-Rspamd-Queue-Id: C5BA27E8E3
X-Rspamd-Action: no action

This patch moves netconsole selftests from drivers/net to its own target
in drivers/net/netconsole.

This change helps saving some resources from CI since tests in
drivers/net automatically run against real hardware which are not used
by netconsole tests as they rely solely on netdevsim.

lib_netcons.sh is kept under drivers/net/lib since it is also used by
bonding selftests. Finally, drivers/net config remains unchanged as
netpoll_basic.py requires netconsole (and does leverage real HW testing).

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
This was initially discussed in [1] when Jakub pointed out new tests
were failing on HW runs. I'm not sure if the CI is going to
automatically run these or if some changes are required on NIPA in order
to do so.

Link: https://lore.kernel.org/netdev/20260120172057.6600eefe@kernel.org/ [1]
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
index 92768bceb929..d92927ce87cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18016,7 +18016,7 @@ S:	Maintained
 F:	Documentation/networking/netconsole.rst
 F:	drivers/net/netconsole.c
 F:	tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
-F:	tools/testing/selftests/drivers/net/netcons\*
+F:	tools/testing/selftests/drivers/net/netconsole/*
 
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
base-commit: b00a7b3a612925faa7362f5c61065e3e5f393fff
change-id: 20260122-netcons-selftest-target-b1dd1af7a25a

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


