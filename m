Return-Path: <netdev+bounces-270260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BzFJd8Uv2nQtQMAu9opvQ
	(envelope-from <netdev+bounces-270260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 22:59:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 427BB2E760B
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 22:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A577301F991
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27B831E83E;
	Sat, 21 Mar 2026 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Nc8YdjLt"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225530EF95;
	Sat, 21 Mar 2026 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774130374; cv=none; b=GgJQTSyZlU1skUv8fZKYIBNgXfQJ5S6lhr/pycaRXEytnIbzYmbA1tV/9JqF5rYVvx83Eo3nZVUlitm4ir1qGLpfDzdya1KyxCk47geFMUzrDhRmmCpmXdhhvtU+vFcQIo50T3Hwp/g2bcnFKQjXia1hjj/YTufwGbA0/O56FUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774130374; c=relaxed/simple;
	bh=fAwcoqurxOiP2mlKpuJQinVz/GPCAjW6iExhrTuyN0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHcYcZaKazsM3qOIBHNkMVBKFQtupOmo66YEpS8tbcFwtOxnhfm39qZvwrR6+ErgAkR3EjooYpRTQ8GSU0f3h3ukIkAxbP2K32w1JLudMbQLqhvO9fLA6+2tOHXOjscjOrrryqLAs+LFn5SOn7QJ4T8MysJAzBR186Vpo+2ZoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Nc8YdjLt; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=bW5DtRsamE95vGAdJSFvHf3U93xrRQ4W2Xdb4GAprTM=; b=Nc8YdjLtPx4P
	ZoUgrUH8FY64ykGRfJHs4IXyvyeUb1GOub3+Ju57TJBiLdlqJ0dsYiS2s7d+pbK1JAbprB4ent8wU
	+a3Ule8eZl4ISafrMYLPUxnE8ytQrny4wSw/kseXa9YlY93XaA5ZQSduG7bDesDDcUDd4zL5sF4du
	dKy4ha3Ocg4VNqIr06SDkN/Ty9dYCWyjbs97hNL4Heu2bjWmnmw4VfrG8R/N4IJWrV3DZDJcJsZwX
	6+N9ImyVKZxlxm4EoE5dE2lQ87HMs7dBOxc6RG/rvwXGFkZiDZnBeyfHd1jlL0dwl/R+16QcZPjUQ
	etk7c/qT4lZF2Y4lgOF2xA==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1w44Js-001ijX-30;
	Sat, 21 Mar 2026 22:59:12 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 62LLxHdE175500
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 21:59:17 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 62LLxHKn175499;
	Sat, 21 Mar 2026 21:59:17 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>,
        Ilya Maximets <imaximet@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@openvswitch.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH net-next v6 4/4] selftests: net: io_uring_zerocopy: enable io_uring for the test
Date: Sat, 21 Mar 2026 21:59:08 +0000
Message-ID: <20260321215908.175465-5-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321215908.175465-1-aleksey.oladko@virtuozzo.com>
References: <20260321215908.175465-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270260-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 427BB2E760B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The io_uring_zerocopy.sh kselftest assumes that io_uring support is
enabled on the host system. When io_uring is disabled via the
kernel.io_uring_disabled sysctl, the test fails.

Explicitly enable io_uring for the test by setting
kernel.io_uring_disabled=0.

Save the original value of kernel.io_uring_disabled before changing
it and restore it in cleanup handler to ensure the system state is
restored regardless of test outcome.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 tools/testing/selftests/net/io_uring_zerocopy_tx.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/net/io_uring_zerocopy_tx.sh b/tools/testing/selftests/net/io_uring_zerocopy_tx.sh
index 123439545013..8c3647de9b4c 100755
--- a/tools/testing/selftests/net/io_uring_zerocopy_tx.sh
+++ b/tools/testing/selftests/net/io_uring_zerocopy_tx.sh
@@ -77,9 +77,13 @@ esac
 
 # Start of state changes: install cleanup handler
 
+old_io_uring_disabled=0
 cleanup() {
 	ip netns del "${NS2}"
 	ip netns del "${NS1}"
+	if [ "$old_io_uring_disabled" -ne 0 ]; then
+		sysctl -w -q kernel.io_uring_disabled="$old_io_uring_disabled" 2>/dev/null || true
+	fi
 }
 
 trap cleanup EXIT
@@ -122,5 +126,10 @@ do_test() {
 	wait
 }
 
+old_io_uring_disabled=$(sysctl -n kernel.io_uring_disabled 2>/dev/null || echo "0")
+if [ "$old_io_uring_disabled" -ne 0 ]; then
+	sysctl -w -q kernel.io_uring_disabled=0
+fi
+
 do_test "${EXTRA_ARGS}"
 echo ok
-- 
2.43.0


