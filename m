Return-Path: <netdev+bounces-73662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45BE85D75E
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2C0283D2C
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D369B482E2;
	Wed, 21 Feb 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9/EZGah"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8339446DB
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516068; cv=none; b=HMhVX06fegRPZONWP+rq5ATDIJwfjGr6dwRoPzkQdX8RvGMwEWEMkct2x0pfOejTlV3qbztQpeXfPazhn2kQE4sO+A6AXxGFMX/x1KRugxCNxz6OObGlQQkIGQVrqiWI2anPkr8cFoDTiAph8+WRUIR0nsFm/Kp0Ahvzn63nt2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516068; c=relaxed/simple;
	bh=JBY/mQDw97iHpPVXUG6l2AiWrlYst7bhafK07ofrkEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pE8HsYlQ/bOmseFCAWu+NMHzfE5iAPwlyVBXyHfLuSLZRtipelk6NATZf3qDo//k0ppLUb3kBFYBzYBJ+692gu4XUi0WTgXiDAMTuoLsF6OODid+dVrEgSc3R/QGZ7/n26aNkhAwfy15hQA2SkodXRFlKSv5nLBnV00EFvhdqjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9/EZGah; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708516052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYtHO8q8zxUSZSdp33YY0/GjFEJNFZGA2uUDD/K00Mg=;
	b=P9/EZGahEDbOjzdODTvVyW5J+1O6QctMdJfDev+dkbAFRHCeU3vx81K/Sx7VYBw1BQEAsY
	t4rOL9iN6texcwy/bp9jS0sW3xi6nu4wjq7DnyH7NlqTBhnCQv64n7bFQRxGpVDJHXx193
	+UU7+gfqyvwi6ahKrTeCPT18d24sSus=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-l1e2WZA9PjmHEE1vlZXNnA-1; Wed, 21 Feb 2024 06:47:29 -0500
X-MC-Unique: l1e2WZA9PjmHEE1vlZXNnA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5638785A588;
	Wed, 21 Feb 2024 11:47:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87354C08496;
	Wed, 21 Feb 2024 11:47:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] selftests: mptcp: explicitly trigger the listener diag code-path
Date: Wed, 21 Feb 2024 12:46:59 +0100
Message-ID: <1116d80f808ea870f3f77fe927dbd6c622d062ae.1708515908.git.pabeni@redhat.com>
In-Reply-To: <cover.1708515908.git.pabeni@redhat.com>
References: <cover.1708515908.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The mptcp diag interface already experienced a few locking bugs
that lockdep and appropriate coverage have detected in advance.

Let's add a test-case triggering the relevant code path, to prevent
similar issues in the future.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 60a7009ce1b5..3ab584b38566 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -81,6 +81,21 @@ chk_msk_nr()
 	__chk_msk_nr "grep -c token:" "$@"
 }
 
+chk_listener_nr()
+{
+	local expected=$1
+	local msg="$2"
+
+	if [ $expected -gt 0 ] && \
+	   ! mptcp_lib_kallsyms_has "mptcp_diag_dump_listeners"; then
+		printf "%-50s%s\n" "$msg - mptcp" "[ skip ]"
+		mptcp_lib_result_skip "many listener sockets"
+	else
+		__chk_nr "ss -inmlHMON $ns | wc -l" "$expected" "$msg - mptcp"
+	fi
+	__chk_nr "ss -inmlHtON $ns | wc -l" "$expected" "$msg - subflows"
+}
+
 wait_msk_nr()
 {
 	local condition="grep -c token:"
@@ -279,5 +294,20 @@ flush_pids
 chk_msk_inuse 0 "many->0"
 chk_msk_cestab 0 "many->0"
 
+chk_listener_nr 0 "no listener sockets"
+NR_SERVERS=100
+for I in $(seq 1 $NR_SERVERS); do
+	ip netns exec $ns ./mptcp_connect -p $((I + 20001)) -l 0.0.0.0 2>&1 >/dev/null &
+	mptcp_lib_wait_local_port_listen $ns $((I + 20001))
+done
+
+chk_listener_nr $NR_SERVERS "many listener sockets"
+
+# gracefull termination
+for I in $(seq 1 $NR_SERVERS); do
+	echo a | ip netns exec $ns ./mptcp_connect -p $((I + 20001)) 127.0.0.1 2>&1 >/dev/null
+done
+flush_pids
+
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.43.0


