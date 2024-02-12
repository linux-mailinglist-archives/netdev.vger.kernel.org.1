Return-Path: <netdev+bounces-70905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E76850FD9
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC22281C29
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 09:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29664179B7;
	Mon, 12 Feb 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BebPc7ms"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA34179B5
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730802; cv=none; b=EMp8u0goX++efZ59s5EsHpM9voa3+mGm43/Y5gm5GVs55CrY8Fw+L4hlf2swzccr5WC9i4yElf5fn+Wc6pTRIabk96LEjiP0bLlPZTVC25hfM+DLfywietfLkEeUHFhbQYYgfzhB5uAH2cAvWw8vAeMWeh6rLcIcZy253qY4hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730802; c=relaxed/simple;
	bh=Sn6j7uRbtr+Zs52T1g5H45u38VnSWLoP+0PrQjRQ9cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hh9fen/UR8ZVt6n8wZRRxEye+aH5B5cuEUGmQdGP8BKgvAyfUdQ2/a1lyvRb/sYWYXJKxfbyngAAlYLYJ8AeDY0FBASvJJX5K2ZBJ47F+BvVDgTZbnt4Fcu+MmwDiRAjeu6Tpe1CXc5+pUBwKkq5VNxjzpBqwnqsgn1YOriMZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BebPc7ms; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707730799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+1llvXaFfVdkLMBqpMg4IJmT7opjM+I2i8bbnTsk+qE=;
	b=BebPc7msEi4plp5ve0ICOPkjQvrcVNezRru/eJtLkHLa8NpSAaEBhH0kH+zTkhXKjM3Vvw
	RUopWgvvth45F8Dh3JaHmfrr88nnIzu0dA+FrfPEdhd18BEKLsCO5pX5nxK8EEPVQq5XIw
	ahfEwdnNVTkpEvpMZo8R+m8cXtxC4KM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-JLYJC3UgOc2U2kzlv_1qAQ-1; Mon,
 12 Feb 2024 04:39:52 -0500
X-MC-Unique: JLYJC3UgOc2U2kzlv_1qAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AB6C3814E90;
	Mon, 12 Feb 2024 09:39:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EFE621227939;
	Mon, 12 Feb 2024 09:39:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Coco Li <lixiaoyan@google.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 net] selftests: net: cope with slow env in gro.sh test
Date: Mon, 12 Feb 2024 10:39:41 +0100
Message-ID: <97d3ba83f5a2bfeb36f6bc0fb76724eb3dafb608.1707729403.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The gro self-tests sends the packets to be aggregated with
multiple write operations.

When running is slow environment, it's hard to guarantee that
the GRO engine will wait for the last packet in an intended
train.

The above causes almost deterministic failures in our CI for
the 'large' test-case.

Address the issue explicitly ignoring failures for such case
in slow environments (KSFT_MACHINE_SLOW==true).

Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - dump the error suppression message only on actual errors (Jakub)
v1 -> v2:
  - replace the '-a' operator with '&&' - Mattbe

Note that the fixes tag is there mainly to justify targeting the net
tree, and this is aiming at net to hopefully make the test more stable
ASAP for both trees.
---
 tools/testing/selftests/net/gro.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index 19352f106c1d..02c21ff4ca81 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -31,6 +31,11 @@ run_test() {
       1>>log.txt
     wait "${server_pid}"
     exit_code=$?
+    if [[ ${test} == "large" && -n "${KSFT_MACHINE_SLOW}" && \
+          ${exit_code} -ne 0 ]]; then
+        echo "Ignoring errors due to slow environment" 1>&2
+        exit_code=0
+    fi
     if [[ "${exit_code}" -eq 0 ]]; then
         break;
     fi
-- 
2.43.0


