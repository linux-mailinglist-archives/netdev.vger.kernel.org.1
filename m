Return-Path: <netdev+bounces-267926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJFcC7DXtmlfJgEAu9opvQ
	(envelope-from <netdev+bounces-267926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:00:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3398029150A
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4251B3005317
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CB037189D;
	Sun, 15 Mar 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spusYAvD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5E371CF7;
	Sun, 15 Mar 2026 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590442; cv=none; b=q7LgPj4Vq6Y3SNARb3fwD+6O0PZwSeR83f2NvTaJZ8qFfU4hCDOqEzQQlb4dTZwFeznMXZSESzMYmksb8q9IwtcZC8v+eSJfIO1crjQeZCtOtdzjSq37OKxxog9Z0tMsK2UlJQo2OHg1sXBB8AM/q0Npur9o6P7KtnjnSpwmxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590442; c=relaxed/simple;
	bh=tRgcdVsDSdE+rnEVs3AS+mfn2di27+3LaftRgJ1FhhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPwDT7IPLqQjTC0scyHGlGflzn6QX9Z9+2MoBIxGre03LaxC8kqQcmwtVcZtoLPppF9p40KnIfTRcGYrGvHPuT9KMqXBt+m0qbokNfEbqmUwAS0SJ7ikmWfHe9f9DqhNnUuqYEZvnm+fV8v93/vatHl4ERqeo6qgMMXZH6fkcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spusYAvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43D2C4CEF7;
	Sun, 15 Mar 2026 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773590442;
	bh=tRgcdVsDSdE+rnEVs3AS+mfn2di27+3LaftRgJ1FhhU=;
	h=From:To:Cc:Subject:Date:From;
	b=spusYAvDovgUhHi53n0taCgFkuFcURaFdH5H/J7Lr4WFQsE/FJFStPZwFMi4gWZFr
	 3lRMUB/0lPN/FQGeS+nf5xZhzPW0dLH3S6GppYaAQPXejN1s9zhGnf9Seyg24veA1E
	 0mQgzhuGM1VxiRSnRDO2u6Mhtw6yCqdci8K3fLbt3nLTMQCqYSthFxq+PED7mFCzIL
	 OTwuZHRW7ISoAbhUq9W7ICJQH+RVCQK3J4bkVYn9KqwBCPwyH3VPNKX8isJbAnm0WS
	 Z/89uAghO1BGCp+Se6N0KAOPuP1MxCtT5z0sincY1BhXLH4TjucGbf5oPiA+BwKUP6
	 2t0gtyn6FmYng==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	petrm@nvidia.com,
	leitao@debian.org,
	noren@nvidia.com,
	gal@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: py: give bpftrace more time to start
Date: Sun, 15 Mar 2026 09:00:38 -0700
Message-ID: <20260315160038.3187730-1-kuba@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-267926-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3398029150A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After commit under Fixes debug runners in the CI hit the following:

  # subprocess.TimeoutExpired: Command '['bpftrace', '-f', 'json', '-q', '-e', 'kprobe:netpoll_poll_dev { @hits = count(); } interval:s:10 { exit(); }']' timed out after 15 seconds
  # # Exception| net.lib.py.ksft.KsftFailEx: bpftrace failed to run!?: {}

in netpoll_basic.py >10% of the time. Let's give bpftool more time
to start, it can take a while on a debug kernel.

Fixes: 82562972b854 ("selftests: net: pass bpftrace timeout to cmd()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: petrm@nvidia.com
CC: leitao@debian.org
CC: noren@nvidia.com
CC: gal@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/py/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 17adc2b67ee0..6c44a3d2bbf7 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -258,7 +258,7 @@ GLOBAL_DEFER_ARMED = False
         cmd_arr += ['-f', 'json', '-q']
     if timeout:
         expr += ' interval:s:' + str(timeout) + ' { exit(); }'
-        timeout += 5
+        timeout += 20
     cmd_arr += ['-e', expr]
     cmd_obj = cmd(cmd_arr, ns=ns, host=host, shell=False, timeout=timeout)
     if json:
-- 
2.53.0


