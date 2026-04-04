Return-Path: <netdev+bounces-275416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g1ZHFDeY0WmdLgcAu9opvQ
	(envelope-from <netdev+bounces-275416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 01:01:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFA539CCD2
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 01:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B117430071D2
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 23:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4023A21FF2A;
	Sat,  4 Apr 2026 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I89J+RDn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6F1EA84;
	Sat,  4 Apr 2026 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775343668; cv=none; b=lUybSt3HO/0NkgOd3siF6doOsau92Ncb/phxA7XSipdfNyH80Cu2Xs/Z4ZZ0yI7XQ5Yen/Jd3mob/FpnCxk95ni4AEechlAjtU52SxtN8AOGwlt7IuwoggoQZUjFwxiuYCllWkqSrTrLZ3+AyZ3XZ9Ymrt+/Bzqx8yOTwxaK/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775343668; c=relaxed/simple;
	bh=TQ2wXMvDctGe1B4QAE0hv9o3OLuDViTCM9NvemtJWY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAS+9dxtFaQNheEFXalunJybAX729D+aNT+pOeF9Vdk5luHPxFowkWyOYgKmFgXkIA4Co85AW6Fi4TJRHuzRIg11qvw51v1TFmEfHI1v/lpUjDdHF9vh4REfzsIWM+OAJLDt5UQsh4toGF6VOo8xWsLMbgBKQt7bFmCO+vgRYJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I89J+RDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3F6C19421;
	Sat,  4 Apr 2026 23:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775343667;
	bh=TQ2wXMvDctGe1B4QAE0hv9o3OLuDViTCM9NvemtJWY8=;
	h=From:To:Cc:Subject:Date:From;
	b=I89J+RDnWLr5lXMBrKGChRbkMMn9f5Rsf9GaTLOGSSnajdyJ0G1/MHBhzOQ/y6P5v
	 58ZHBoGb36BMdWLcSnJAlfcSdqtlm+hzoRP1xznvn4rn2o3/5KHi8T2rpGv1WUTT0z
	 Vq1VS9HmD3+E8ggFFDI3t10+BI2C13uhu7SAwX407irOUMwQISV5QG2GLsBOLtXGMG
	 4430/NajH3JnKN5qAMrwKGGj1ASRHjS8ilpYwQmoOLjuIQFW90cGRqK/nqASxlOTqb
	 Ol5YT6blM5vatYpQteWEA90ttv1C8VqiljPL8tUgkIIblzNyJGlgURvnWx8NvhElw1
	 muwGQ1KBIUgWg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	leitao@debian.org,
	shuah@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: adjust to socat changes
Date: Sat,  4 Apr 2026 16:01:03 -0700
Message-ID: <20260404230103.2719103-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,debian.org,gmail.com,fomichev.me];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-275416-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Queue-Id: 9AFA539CCD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

socat v1.8.1.0 now defaults to shut-null, it sends an extra
0-length UDP packet when sender disconnects. This breaks
our tests which expect the exact packet sequence.

Add shut-none which was the old default where necessary.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: leitao@debian.org
CC: shuah@kernel.org
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: sdf@fomichev.me
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 6 +++---
 tools/testing/selftests/drivers/net/xdp.py                | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 02dcdeb723be..a9a01a64b7b3 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -251,7 +251,7 @@ function listen_port_and_save_to() {
 
 	# Just wait for 3 seconds
 	timeout 3 ip netns exec "${NAMESPACE}" \
-		socat "${SOCAT_MODE}":"${PORT}",fork "${OUTPUT}" 2> /dev/null
+		socat "${SOCAT_MODE}":"${PORT}",fork,shut-none "${OUTPUT}" 2> /dev/null
 }
 
 # Only validate that the message arrived properly
@@ -360,8 +360,8 @@ function check_for_taskset() {
 
 # This is necessary if running multiple tests in a row
 function pkill_socat() {
-	PROCESS_NAME4="socat UDP-LISTEN:6666,fork ${OUTPUT_FILE}"
-	PROCESS_NAME6="socat UDP6-LISTEN:6666,fork ${OUTPUT_FILE}"
+	PROCESS_NAME4="socat UDP-LISTEN:6666,fork,shut-none ${OUTPUT_FILE}"
+	PROCESS_NAME6="socat UDP6-LISTEN:6666,fork,shut-none ${OUTPUT_FILE}"
 	# socat runs under timeout(1), kill it if it is still alive
 	# do not fail if socat doesn't exist anymore
 	set +e
diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index d86446569f89..7e635487d517 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -70,7 +70,7 @@ from lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     cfg.require_cmd("socat", remote=True)
 
     rx_udp_cmd = f"socat -{cfg.addr_ipver} -T 2 -u UDP-RECV:{port},reuseport STDOUT"
-    tx_udp_cmd = f"echo -n {test_string} | socat -t 2 -u STDIN UDP:{cfg.baddr}:{port}"
+    tx_udp_cmd = f"echo -n {test_string} | socat -t 2 -u STDIN UDP:{cfg.baddr}:{port},shut-none"
 
     with bkg(rx_udp_cmd, exit_wait=True) as nc:
         wait_port_listen(port, proto="udp")
@@ -271,7 +271,7 @@ from lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
         # Writing zero bytes to stdin gets ignored by socat,
         # but with the shut-null flag socat generates a zero sized packet
         # when the socket is closed.
-        tx_cmd_suffix = ",shut-null" if payload_len == 0 else ""
+        tx_cmd_suffix = ",shut-null" if payload_len == 0 else ",shut-none"
         tx_udp = f"echo -n {test_string} | socat -t 2 " + \
                  f"-u STDIN UDP:{cfg.baddr}:{port}{tx_cmd_suffix}"
 
-- 
2.53.0


