Return-Path: <netdev+bounces-283397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UqseGobs9WnYQQIAu9opvQ
	(envelope-from <netdev+bounces-283397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:22:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2504B1E59
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E12D6300E3B2
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 12:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124FA33C192;
	Sat,  2 May 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvRzGExi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD2C32A3E1
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777724546; cv=none; b=rZp3L96CjiYmdIfMnvlfBYIAFkgUFGFujegnIF21Y9V7XHfgxvqHLpV+mjTvY2dL24C+91fkKaXdF2/OYodfBXNxEED9RtATLwyxVVfnwU+hb6ZgTSr609KNRwbdhtpHbswkn9LjWDmOrUUlQJnqvcdO+3EyTdBYpT2VRe9OXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777724546; c=relaxed/simple;
	bh=eNgPQCfzBOg0fqoatydEMR2gASJHTKxfsAmSc/DzQck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ix6JI+XTUXTh7/LnXh3tag/vFyg+ISpsB8BrMA7h44R9x02F7qYhGgG6Qwr1ljSWRWekmIHEbbs3KvKiTDRpVjCn7NpLjzzjj0q80E9yezZq8XSJApe6bBt/EYDNe213ivDyh0v3XfR8AroCY0lM6CraYmMczvp7RDY2y+ocz8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvRzGExi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891f625344so27554055e9.0
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777724542; x=1778329342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iK1LIqf5TWkNLZJw4cxgH7vA0Wpgf+PvbVG/5GG9MDY=;
        b=qvRzGExi/tC3CClAvZ+wE3pqfczn/IAhGMsor0hlUXKd6DiFN2AknexlCXotwx07q5
         x1lqmFBlZ9/ylOYneOFjfv0j7QjhfATWADKOKtEP322YK2yTcALjprDwDf15lqHQZkaE
         uMXO90wn8XjLSmPpJihI/qWKa6efLkWRodr7Nl88/CybOhmyqSQ72FP2f30GLBWFP2OG
         NRwTulKbuidxsaXIzXHDpjpUVGqhMsivfa63P7fdx/Bf08Mu5M9Yy5bXEp/BHb2973HN
         14PCmadQ1cnoFojrJuPKktxmG8g0h7fAlqZwnFpfv8MKfGFT9TE/1MUEZQfTza4ICeSy
         vqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777724542; x=1778329342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK1LIqf5TWkNLZJw4cxgH7vA0Wpgf+PvbVG/5GG9MDY=;
        b=PbOaFy4PwNpm7p52Bv8crpRvDSuacyspSb3iQeT0NxfHQQnBokiC/5zzqu+GajImEI
         jJHHnO3xJFfCQfBlYwxFjIvgmCA32mQcyZnhu8RH3ESz7BrZaaXJSxQWm4dmSDJNBVo1
         adXhHM2gf4JxwKb7+AZPQz8KYlRivwg6R0cwG07p8Z//c+xoWuNAc63EMsz23ssJdghi
         IDZpsk3oVWgdz4YE5StblZIVtYQru/XJB7jL+urXnCNjn4KHSa3vvmhCKKVGEbuzSPQG
         aMz4RNYrC6UzZLUJeqioxVn/36OotG7WSIRNTu7zn5Z4vLkRrQKT4BQovsxvmtR4sC+D
         AV4g==
X-Gm-Message-State: AOJu0YxhuGg0PQBPLm1SEiWgz2yZ7WM/g1thxOPkXHIa/UVpJSzhVcwG
	IXGfjljzP87vUWsW33gFdqYtgticBtQhvfYaMrh56KXG4mp0ogAeKzxGQMwcu1xgZSsI3Dokwe4
	=
X-Gm-Gg: AeBDievGZYW1hXxPcaImQjB6/j56Hv80BEfOOV+vmt535lxCQhVbcodTs0YKX2Ssiht
	fB9rk1fe1yqWNH9KvVw8STBkw49T7l+TIl0+32lze0r2t8ANgVvS/uyj9qxk94n30Zn1YSEpiwD
	dNdvpd1NQ02To1j+57Twqp+5t7SGH+rt6M+wHK/qEgMkoQ7mC5dyTMlwW4Iru55ABvVWRpngd02
	vyHA/5AxUTRLffjaZNuZzLm44qIBs+xbYjuWk3i1u/Y5nCT2eC7S846NXvqOIr71GttBraUoV0p
	z9QWgafiUvM36X8Z/fV814t9sw8IXysXCY2Hl2tZHk+8FpIRX1EzScVYNf+58B6v+5O7XEnCkq+
	n5joCxkAI0B3AsL89fxLCjDK09n17vsOZNxjoj/RcGRky0HeBn5Gqh2H9A3hKjKZPgH/73xkchi
	drnEoVx/C1WRPTrTrwdfat0twuFhF+Pm+bFJdYU5nWTNSoAD8LW8XOveFsEUHLAlVJcDhEAAI=
X-Received: by 2002:a05:600c:c170:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-48a970ab55bmr41491275e9.5.1777724542426;
        Sat, 02 May 2026 05:22:22 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm111764855e9.10.2026.05.02.05.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 05:22:22 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vastargazing <vebohr@gmail.com>
Subject: [PATCH] selftests: net: fib_nexthops: detect kernel splats from torture tests
Date: Sat,  2 May 2026 15:22:19 +0300
Message-ID: <20260502122219.262611-1-vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA2504B1E59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283397-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The four nexthop torture subtests delete and re-add a group member
while ping -f and mausezahn keep traffic flowing through the same
group, so on each iteration the read side runs nh_grp_entry_stats_inc()
while the write side goes through remove_nh_grp_entry(). That is the
exact race fixed in commit b2662e7593e9 ("net: nexthop: fix percpu
use-after-free in remove_nh_grp_entry").

The reason it never tripped these tests is the assertion. Each subtest
ends with "if we did not crash, success", so a KASAN splat without
panic_on_warn=1 lands in dmesg and the test still prints [OK]. The UAF
above would have been visible to a KASAN run of fib_nexthops.sh; the
torture loop just did not bother to look.

Drop a marker into /dev/kmsg before each torture subtest, grep for
KASAN/UBSAN/KCSAN/KFENCE/Oops/"kernel BUG at" lines once the load is
killed, and fail the subtest with the offending lines printed if any
match. The check is skipped when /dev/kmsg is not writable so the
existing pass behaviour is preserved on restricted setups. No new
TEST_PROGS, no new test mechanism, just close the assertion gap.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Vastargazing <vebohr@gmail.com>
---
 tools/testing/selftests/net/fib_nexthops.sh | 69 ++++++++++++++++++---
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index ac868a731694..41c8767fc310 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -128,6 +128,47 @@ run_cmd()
 	return $rc
 }
 
+# Helpers used by the *_torture subtests below. The torture loops drive
+# concurrent nexthop updates and packet flood, but until now they only
+# checked "did the kernel crash". A KASAN/UBSAN report without
+# panic_on_warn=1 lands in dmesg and is silently ignored. These helpers
+# place a marker into /dev/kmsg before the load starts and grep for
+# splat lines after it stops. If /dev/kmsg is not writable the check
+# is skipped and the previous pass behaviour is kept.
+torture_dmesg_marker=""
+
+torture_dmesg_baseline()
+{
+	torture_dmesg_marker=""
+	[ -w /dev/kmsg ] || return 0
+
+	torture_dmesg_marker="fib_nexthops-torture-$$-$RANDOM"
+	echo "$torture_dmesg_marker" >/dev/kmsg
+}
+
+torture_dmesg_check()
+{
+	local since
+	local found
+
+	[ -z "$torture_dmesg_marker" ] && return 0
+
+	since=$(dmesg 2>/dev/null | \
+		awk -v m="$torture_dmesg_marker" '
+			$0 ~ m { f = 1; next }
+			f { print }
+		')
+
+	found=$(echo "$since" | grep -E \
+		'KASAN:|UBSAN:|KCSAN:|KFENCE:|Oops:|kernel BUG at|general protection fault')
+
+	[ -z "$found" ] && return 0
+
+	echo "    Kernel splat detected during torture run:"
+	echo "$found" | sed 's/^/    /'
+	return 1
+}
+
 get_linklocal()
 {
 	local dev=$1
@@ -1333,6 +1374,8 @@ ipv6_torture()
 	run_cmd "$IP route add 2001:db8:101::1 nhid 102"
 	run_cmd "$IP route add 2001:db8:101::2 nhid 102"
 
+	torture_dmesg_baseline
+
 	ipv6_del_add_loop1 &
 	pid1=$!
 	ipv6_grp_replace_loop &
@@ -1348,8 +1391,9 @@ ipv6_torture()
 	kill -9 $pid1 $pid2 $pid3 $pid4 $pid5
 	wait $pid1 $pid2 $pid3 $pid4 $pid5 2>/dev/null
 
-	# if we did not crash, success
-	log_test 0 0 "IPv6 torture test"
+	# Pass only if we did not crash AND no kernel splat appeared.
+	torture_dmesg_check
+	log_test $? 0 "IPv6 torture test"
 }
 
 ipv6_res_grp_replace_loop()
@@ -1387,6 +1431,8 @@ ipv6_res_torture()
 	run_cmd "$IP route add 2001:db8:101::1 nhid 102"
 	run_cmd "$IP route add 2001:db8:101::2 nhid 102"
 
+	torture_dmesg_baseline
+
 	ipv6_del_add_loop1 &
 	pid1=$!
 	ipv6_res_grp_replace_loop &
@@ -1404,8 +1450,9 @@ ipv6_res_torture()
 	kill -9 $pid1 $pid2 $pid3 $pid4 $pid5
 	wait $pid1 $pid2 $pid3 $pid4 $pid5 2>/dev/null
 
-	# if we did not crash, success
-	log_test 0 0 "IPv6 resilient nexthop group torture test"
+	# Pass only if we did not crash AND no kernel splat appeared.
+	torture_dmesg_check
+	log_test $? 0 "IPv6 resilient nexthop group torture test"
 }
 
 ipv4_fcnal()
@@ -2123,6 +2170,8 @@ ipv4_torture()
 	run_cmd "$IP route add 172.16.101.1 nhid 102"
 	run_cmd "$IP route add 172.16.101.2 nhid 102"
 
+	torture_dmesg_baseline
+
 	ipv4_del_add_loop1 &
 	pid1=$!
 	ipv4_grp_replace_loop &
@@ -2138,8 +2187,9 @@ ipv4_torture()
 	kill -9 $pid1 $pid2 $pid3 $pid4 $pid5
 	wait $pid1 $pid2 $pid3 $pid4 $pid5 2>/dev/null
 
-	# if we did not crash, success
-	log_test 0 0 "IPv4 torture test"
+	# Pass only if we did not crash AND no kernel splat appeared.
+	torture_dmesg_check
+	log_test $? 0 "IPv4 torture test"
 }
 
 ipv4_res_grp_replace_loop()
@@ -2177,6 +2227,8 @@ ipv4_res_torture()
 	run_cmd "$IP route add 172.16.101.1 nhid 102"
 	run_cmd "$IP route add 172.16.101.2 nhid 102"
 
+	torture_dmesg_baseline
+
 	ipv4_del_add_loop1 &
 	pid1=$!
 	ipv4_res_grp_replace_loop &
@@ -2194,8 +2246,9 @@ ipv4_res_torture()
 	kill -9 $pid1 $pid2 $pid3 $pid4 $pid5
 	wait $pid1 $pid2 $pid3 $pid4 $pid5 2>/dev/null
 
-	# if we did not crash, success
-	log_test 0 0 "IPv4 resilient nexthop group torture test"
+	# Pass only if we did not crash AND no kernel splat appeared.
+	torture_dmesg_check
+	log_test $? 0 "IPv4 resilient nexthop group torture test"
 }
 
 basic()
-- 
2.51.0


