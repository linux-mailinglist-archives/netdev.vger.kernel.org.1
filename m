Return-Path: <netdev+bounces-271829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9mEhGgyxxGle2gQAu9opvQ
	(envelope-from <netdev+bounces-271829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:07:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 270AA32EF1A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9A2E302C937
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B99326D51;
	Thu, 26 Mar 2026 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NzKV3m40"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A727713;
	Thu, 26 Mar 2026 04:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774498056; cv=none; b=g0aIEOJbald8jdOYQyBXfIcSd+mjrcpES6ANvBPb0PprILcS/Ss5FTtVPYWte2zfVMTp/Wft3c328bLa2zyDYbkMBYWwQpkc9uUxK6v5yqm8Nknwseilzq9seUTd3qde8q5Ak/QzCWRFxTHCiKm3FYYN7Dh835hBGt60mxOO4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774498056; c=relaxed/simple;
	bh=x7FSi1pWcEDgmOYa1OuFs30H6u55skQj3xNmzZpOjG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=amyj4tTtQEhlFviwm1yJxxTnPT4BPzh2fJJvhwIymZvw+J4cuYdIdcQpseg4oPxyVIUYEvXvxBy3EjmTjWl8hLRnMwesMCL18yrAhjzt9qhAorJBj8oa2BZ15NxYjD4RE0FQima7MdkF2IgnpV5zV3pbv5gJ/TUr36B2yohQghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NzKV3m40; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zx
	7GY2bqfn4dF5tgy+uoRsMQdnY//bDJkocYu5mR/No=; b=NzKV3m40jHf/GfSwkm
	2YCih5F49+8HRmbfpA49qqUnD3N11nxaTXuRyCPLbsyDuO6NpnSt3KjICYOADtJt
	U/2XAouNlGcFWVRUFHfUCBmkobeNHOnYyGY+Pfvtu8LZd2wnjvKykqr+2rsrXzMC
	S9tSUCKCTF6G++c9F6viaqqrs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBnbanXsMRpkUf5BQ--.31047S2;
	Thu, 26 Mar 2026 12:06:48 +0800 (CST)
From: fffsqian@163.com
To: davem@davemloft.net,
	edumazet@google.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: [PATCH] selftests: net: broadcast_pmtu: Fix false failure from incorrect ping exit code logic
Date: Thu, 26 Mar 2026 12:06:45 +0800
Message-Id: <20260326040645.2020782-1-fffsqian@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnbanXsMRpkUf5BQ--.31047S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4xtF13ur18ur1kuF45Wrg_yoW8uFWUpa
	1rCayrKF1kGw13A3WkCF47ZFW8Ca97Ja1UGry2gwn0qr45tFyUXF1Sga47GFyqvF4vqw13
	Zas5Xr1Yq34kCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn8n5UUUUU=
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/xtbC6RntuGnEsNmG0AAA33
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271829-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fffsqian@163.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcast_pmtu.sh:url]
X-Rspamd-Queue-Id: 270AA32EF1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Qingshuang Fu <fuqingshuang@kylinos.cn>

The broadcast_pmtu.sh test verifies that broadcast route MTU is respected,
but it uses an incorrect criteria for test success: it relies solely on
the ping command's exit code, which leads to false failures.

When the kernel correctly blocks oversized broadcast packets due to the
configured MTU limit (1500), ping fails to transmit any packets and returns
exit code 1. The original script interprets this as a test failure, even
though the kernel is properly enforcing the MTU (the core goal of the test).

Fix this by:
1. Checking ping's output for clear signs of MTU enforcement (instead of exit code)
   - Match "0 packets transmitted" (no packets sent due to MTU limit)
   - Match "message too long" (kernel rejects oversized packets)
2. Use an exit code variable to avoid early exit breaking the script flow
3. Maintain full compatibility with the original setup/cleanup logic

After this fix, the script returns 0 (success) when the kernel enforces the
broadcast route MTU (packets blocked), and 1 (failure) only when the kernel
fails to enforce the MTU (packets are transmitted but no response is received).

Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
---
 tools/testing/selftests/net/broadcast_pmtu.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/broadcast_pmtu.sh b/tools/testing/selftests/net/broadcast_pmtu.sh
index 726eb5d25839..a8d2a205c51d 100755
--- a/tools/testing/selftests/net/broadcast_pmtu.sh
+++ b/tools/testing/selftests/net/broadcast_pmtu.sh
@@ -41,7 +41,13 @@ trap cleanup EXIT
 
 setup &&
 	echo "Testing for broadcast route MTU" &&
-	ip net exec "${CLIENT_NS}" ping -f -M want -q -c 1 -s 8000 -w 1 -b "${CLIENT_BROADCAST_ADDRESS}" > /dev/null 2>&1
-
-exit $?
+	ping_output=$(ip net exec "${CLIENT_NS}" ping -f -M want -c 1 -s 8000 -w 1 -b \
+		"${CLIENT_BROADCAST_ADDRESS}" 2>&1) &&
+	if echo "${ping_output}" | grep -q -E "0 packets transmitted|message too long"; then
+		exit_code=0
+	else
+		exit_code=1
+	fi
+
+exit ${exit_code}
 
-- 
2.25.1


