Return-Path: <netdev+bounces-70916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0360D85108F
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 11:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358E21C20F85
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618718AEA;
	Mon, 12 Feb 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gepHi14n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FB6182A1
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733191; cv=none; b=DV7/mKGLl1jsdDSQuf3bM5S5m3l2p+4RM/Is0V2Fqqg4CG22IJ/LjNfU16oRAIYhEQLqGFsyMvMCRebd5aYR/sSMZIDzgusFkKO50RRnIek6aF1DXR7UA4ZGcaXPRrPj7SnkF83jYRl9TRhxrIPZAm+k+oZktfPEZb5/z4rV/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733191; c=relaxed/simple;
	bh=G1u5IgLvZZEE5qO/VlNIX+15/Yl7wlSKTZ7a+esQyIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdWAEVAlnZ8Ud9ogAWyy8Pp0AEKKBFB7ivhGjgHMQq3hnu88ig2RJzAErX8nDODw7mLgK00SUXGKO3BVUKAJktI+094RcZV6g4Ke4IspRHFFR9tO/vcfd4csTuXdMCUfGr+dUVcc4MGVJLGMGcUVarCcg5SOPR54usiS9SG06xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gepHi14n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707733188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cj7JHEQ3aEOOqtHo86kfYJieZSXleOCNgtlV9sLANrk=;
	b=gepHi14nvSWB3jMvYvL48i4GgcNe/Leovd0epAPE6yaOajFbighMFgqEucWX2ndzEbkbqd
	MoLGrjIEj9X+563P7tnw6VzbjtVQZdsbVmZQgWPoenBvweccb62aANvJzrWkp5v3aAMlSN
	TpTZxPWVhaS8bB1cPcG6MOPJnxrwDa0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-YtXNUmEzOyaGAmJGKmMF6Q-1; Mon,
 12 Feb 2024 05:19:47 -0500
X-MC-Unique: YtXNUmEzOyaGAmJGKmMF6Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F3901C172AC;
	Mon, 12 Feb 2024 10:19:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C23CF4AE3F1;
	Mon, 12 Feb 2024 10:19:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/2] selftests: net: more strict check in net_helper
Date: Mon, 12 Feb 2024 11:19:23 +0100
Message-ID: <192b3dbc443d953be32991d1b0ca432bd4c65008.1707731086.git.pabeni@redhat.com>
In-Reply-To: <cover.1707731086.git.pabeni@redhat.com>
References: <cover.1707731086.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The helper waiting for a listener port can match any socket whose
hexadecimal representation of source or destination addresses
matches that of the given port.

Additionally, any socket state is accepted.

All the above can let the helper return successfully before the
relevant listener is actually ready, with unexpected results.

So far I could not find any related failure in the netdev CI, but
the next patch is going to make the critical event more easily
reproducible.

Address the issue matching the port hex only vs the relevant socket
field and additionally checking the socket state for TCP sockets.

Fixes: 3bdd9fd29cb0 ("selftests/net: synchronize udpgro tests' tx and rx connection")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/net_helper.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/net_helper.sh b/tools/testing/selftests/net/net_helper.sh
index 4fe0befa13fb..6596fe03c77f 100644
--- a/tools/testing/selftests/net/net_helper.sh
+++ b/tools/testing/selftests/net/net_helper.sh
@@ -8,13 +8,16 @@ wait_local_port_listen()
 	local listener_ns="${1}"
 	local port="${2}"
 	local protocol="${3}"
-	local port_hex
+	local pattern
 	local i
 
-	port_hex="$(printf "%04X" "${port}")"
+	pattern=":$(printf "%04X" "${port}") "
+
+	# for tcp protocol additionally check the socket state
+	[ ${protocol} = "tcp" ] && pattern="${pattern}0A"
 	for i in $(seq 10); do
-		if ip netns exec "${listener_ns}" cat /proc/net/"${protocol}"* | \
-		   grep -q "${port_hex}"; then
+		if ip netns exec "${listener_ns}" awk '{print $2" "$4}' \
+		   /proc/net/"${protocol}"* | grep -q "${pattern}"; then
 			break
 		fi
 		sleep 0.1
-- 
2.43.0


