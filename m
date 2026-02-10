Return-Path: <netdev+bounces-258007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKTpLuKDimmfLQAAu9opvQ
	(envelope-from <netdev+bounces-258007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 02:03:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AB8115E47
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 02:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BBCD3007AE3
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 00:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F6F25B1D2;
	Tue, 10 Feb 2026 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x8iaGZIV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D93242D66
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770685183; cv=none; b=eACUVjnHs84UgvW53B7EXJo+Q7dw4aUUipCZx3Ww9WqhF96K8zCf5luIHx69ekWRspGLTj/Rr7SJzhvPIE1UhzhtNEjI58UhP+dIPabcd/ETkJ8t+CgS5RUVoXSOUIGFzWqeuG4mXCLGUXptg5eW1jsfQSVi0Kl4rc6rInTgO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770685183; c=relaxed/simple;
	bh=rX1FE3i5slVrCvxi5yfMhbxhuZWwNhm0BeNvs15Cr7w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RhS24u0FPDX9KPRBdZN+5JCfAsO7KuM2n2SZ1tO3qGUDUnGSzvoF37fj56LtO4dC2TZkQ2PiAhpXzyH2qb492liwPsh4yMphZrDuKnTkA9fdsrFyubwe4mBWKn4uExyRxZQ+JZ5JtwNwqBMGyyIaURYyFuC9iAsYis+oxihk6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x8iaGZIV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34e5a9de94bso8110215a91.0
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 16:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770685182; x=1771289982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kCxe4KUTZpsszSXX1fJw0CECWXD0bnRktmIBoClkf/A=;
        b=x8iaGZIV4VxBFHR7dBfutt/274STYH875f5oT5G76dr6DcOaNvlRHfINoq7jkoBOHI
         12QoH/t3nMK7x+ubS0uhCTbTtcuxPYVRgLf2p7sOT7IkUpfN513061nj+Hy6hMuo/IDc
         fBKKL4ZRXdsfgEJsmYVDMLsawwz0SBqs+BqTZeU5XF8y9yqRlOOs7YtT+6fju3S7kyiC
         cYttb/nVx0NGA03s0WEu2PhMB0xvY8GCFEhGTleY62SWsWJ7FNxWUCjhWZ3E9YI1CdRy
         hwLacnoDkGhjJjglSlkUP39DKxveQIs5inf8joHNl4a2CoaFicDxZACToOvXi9DfIMVQ
         6rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770685182; x=1771289982;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCxe4KUTZpsszSXX1fJw0CECWXD0bnRktmIBoClkf/A=;
        b=IoddAOTD4phXkmDHnZP0nGyps/a3kcA5NBVfY57/f5//bmYaKkXWMwjEXAv4cv70w/
         XK+yP2PYcSeB2110fKrbJR3HRvzK4Hl67SlCXT5rEdtG5O8I4uAFF7eM6ie/vCsjGUPa
         8K7h0QG5m4TlnbLU0i+YOlme6fs0AfGt/sk3sPh2c95Zucyf7CnGdZDl0UemW73Rg8D+
         8CB4aQi7XTpdJom10NQ3agNKq8DOjxPBm7UGG98LjcZB1wDQsn83AFb2XidwHBvRxpDG
         rWMPHKIVrwL0dz0DAGzr8HsWfbslg5eGpwtlNRIfrN4Gp8euvUk4EtjZiIYq4PFFNoWM
         DQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCV5fHQWJ7YkKQ1p915mckVp1fAnOzGo/qr/x+873BPuDjW099Z3WEvqvjMIpYODbTcHSKhoUGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32Q4H07Mlu1rP+VJvLEOTlmhj3qjqDrIBI/lrLJkMI8oYN3Oj
	XxndArDseuJPQJwEkWJEiKZcijVq6zqo9COsu8SPQuU6p9QBZQatzkxoePB+h1dppyL6PJefrVF
	5Gsb1WboPGhtTBD5TYQ==
X-Received: from pjbgj1.prod.google.com ([2002:a17:90b:1081:b0:352:e5f6:780a])
 (user=treapking job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5546:b0:356:3cfd:3ee1 with SMTP id 98e67ed59e1d1-3563cfd4172mr4606434a91.23.1770685182177;
 Mon, 09 Feb 2026 16:59:42 -0800 (PST)
Date: Mon,  9 Feb 2026 16:59:36 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260210005939.3230550-1-treapking@google.com>
Subject: [PATCH net] selftests: netconsole: Increase port listening timeout
From: Pin-yen Lin <treapking@google.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258007-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[treapking@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netcons_basic.sh:url]
X-Rspamd-Queue-Id: 25AB8115E47
X-Rspamd-Action: no action

wait_for_port() can wait up to 2 seconds with the sleep and the polling
in wait_local_port_listen() combined. So, in netcons_basic.sh, the socat
process could die before the test writes to the netconsole.

Increase the timeout to 3 seconds to make netcons_basic.sh pass
consistently.

Fixes: 3dc6c76391cb ("selftests: net: Add IPv6 support to netconsole basic tests")
Signed-off-by: Pin-yen Lin <treapking@google.com>
---

 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index ae8abff4be40..64d3941576d5 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -247,8 +247,8 @@ function listen_port_and_save_to() {
 		SOCAT_MODE="UDP6-LISTEN"
 	fi
 
-	# Just wait for 2 seconds
-	timeout 2 ip netns exec "${NAMESPACE}" \
+	# Just wait for 3 seconds
+	timeout 3 ip netns exec "${NAMESPACE}" \
 		socat "${SOCAT_MODE}":"${PORT}",fork "${OUTPUT}" 2> /dev/null
 }
 
-- 
2.53.0.273.g2a3d683680-goog

base-commit: 6d2f142b1e4b203387a92519d9d2e34752a79dbb
branch: net-upstream

