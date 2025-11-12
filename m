Return-Path: <netdev+bounces-237846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF15C50CF0
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C755189C805
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CFE2E2665;
	Wed, 12 Nov 2025 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8FpJ83o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE482ECE9B
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930548; cv=none; b=s7PlgJDTcDFAGz0Ol32dJ7T181faoOnf/93IzS+3mqzGXxdP4G85VcD2PkF4UscRbt9UAKubMgg9TqsLP5cc87ES8RpjYK/LHXcPVfAofbEj7VCiVXRduBPE6x18pOeo5HrgumvrOI8Y5xS6uS8RpotfoIVB2CRcvSni5EwlO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930548; c=relaxed/simple;
	bh=C74tPtLEcFlxKPQiq+20Ok+iNGw0X0cvYTmDWlPCWgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+r8wqSjId2zliGYba8FzjSuYouvaYotXCVm3AHv7iwnQ7F1laN7CD+DnTasjVLO4fWxmxJwGvZFZ6/0DjOvTYbs/y4dNKb98ORO82spOrRMknRjY6KwY7tj+s+5tX3vMj2L8AzFjkKPqyRENJHrjI5c7kydBx6DDjzyfTNTKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8FpJ83o; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso457880b3a.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 22:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930543; x=1763535343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p28zEBQeBUk36AvYw3frZ4faKmOpLSnPo9g0yADkH2g=;
        b=H8FpJ83oCTjDCtUaw+fmE8WHeuhylz2VYw4N4J+VORPN1FDWxMFnFnXyCHGolV7a8W
         mOZKDkqdaOah8gGxs9o8NVGOC+vsmbSKaey7M9tgTC5dysVgwCf3659YCEdQDbngAQkK
         bKgyteTVUrgQzjSFEBUzzwtLhJGKeQ7n6HbHAMhC8uaQJIOK0I968xMA4NOydOBupgZS
         ut4lUAABAZGV6NLXRVL0hsunKhHU/1mZrT6DiNr/wemxD5DusLAJrInrDj5ZPssQ7v0e
         523TMllidl0rBwuMNfAmwIbLch6REZ2vaW+WScAwg+L45PSGfuBwAD07Or9Oq6qc8XoI
         HvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930543; x=1763535343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p28zEBQeBUk36AvYw3frZ4faKmOpLSnPo9g0yADkH2g=;
        b=DOnO2uMziIQxQ6S5v9u8JqPHMs9lVbFjEfitGHKuvScJuI7uTho2Pu6ARoNfOEqfgo
         Nenoeu1LqG2Bk0wG8guJVtDBZ0FtFm/qX61GrhB5qrAUqDlo9udblDR2w6IYMNd8i2eL
         wZyxyJWO+m21Kb1h/IK1EXSr3T1JZPmscxjm2CTvYmYnNx/24bKLyBASXJK6xfAtv+mI
         m7iAYqE3yyP+Ys4wLxxIscUQchxLgZ1/9IBXBtAFZHYluTooGNOpTQmi8/gzspsjbpFO
         TWOkRbs8i7jg5ZbHwP7gMPz4RmAL55UFWfHKJvKFR5Z6STRJm2OEz9CLlEQ5VBRgtRS5
         bHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMcRy7vdFd7bleaMFsr9/3QDotrmudwKr3NIPrzxlCDBzjHwyuv2tdSxNNiWf7kU4ZBJQHP6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdlT/5op/eMgiEj4c5ACJjm3D+fNAAQBHX0XDtM9oOtjHUk0Ss
	WijN7c2zO1SaOAe89O5BuII1C3QHhzLCEJe4mFgm/Focb/KdX6wyb+A/
X-Gm-Gg: ASbGncsJLjzLHB1PYs8kT45fSHnkrzU+SSJ2dMxCKosXybl4qXmJIavSw+1zQ6XK2w4
	lfvWkhxKfOy3HqTFPjOW8Zj0GM8bhyI3wfEQonjffx5DC8zo6WJ0oxFCujJXJibKGeb0BpsYLdP
	RpU8oVVsWjNscCG+4BQFChia8z4yA32LRaLmjLXRh37tqo6nQzfc5JJiFGb9MArkYs2zROQLRZ4
	ab3GJgqI1QGyz6HV2op0Orkskm5spJOJIRvRhEAEN+hvONJHTcKL5OZcjb2BcUq3jwzDxjdPkwU
	xM70rdwT1lrHE5TZUbMjX3vM9YloANsK565uulAH3xzrmDLNw9qf/+Ki9tpzKT9Awgi512xEW1O
	+0865YVoLsKMgdbl21RE0kz6yJTsFATh3lJW/BhQYuD/409V7VJnPg9Z3e6PAt/NPOqQAnAhM
X-Google-Smtp-Source: AGHT+IFrcYVq4LOZXvV70I3sEePi3UmNsOLwpVBty9xgqUole9nqmJJSBTG6gPimY2LrfYFWsxLRzg==
X-Received: by 2002:a05:6a00:1896:b0:7a2:7cc3:c4f0 with SMTP id d2e1a72fcca58-7b7a2a96c07mr2022312b3a.1.1762930543350;
        Tue, 11 Nov 2025 22:55:43 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b783087c6csm1699020b3a.12.2025.11.11.22.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:43 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:51 -0800
Subject: [PATCH net-next v9 09/14] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-9-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The init_namespaces() function initializes global0, local0, etc...  with
their respective vsock NS mode. This function is separate so that tests
that depend on this initialization can use it, while other tests that
want to test the initialization interface itself can start with a clean
slate by omitting this call.

Remove namespaces upon exiting the program in cleanup().  This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test. In that case, this patch prevents the
subsequent test run from finding stale namespaces with
already-write-once-locked vsock ns modes.

This patch is in preparation for later namespace tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c7b270dd77a9..f78cc574c274 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -103,6 +104,45 @@ check_result() {
 	fi
 }
 
+add_namespaces() {
+	# add namespaces local0, local1, global0, and global1
+	for mode in "${NS_MODES[@]}"; do
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+}
+
+init_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ns_set_mode "${mode}0" "${mode}"
+		ns_set_mode "${mode}1" "${mode}"
+
+		log_host "set ns ${mode}0 to mode ${mode}"
+		log_host "set ns ${mode}1 to mode ${mode}"
+
+		# we need lo for qemu port forwarding
+		ip netns exec "${mode}0" ip link set dev lo up
+		ip netns exec "${mode}1" ip link set dev lo up
+	done
+}
+
+del_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ip netns del "${mode}0" &>/dev/null
+		ip netns del "${mode}1" &>/dev/null
+		log_host "removed ns ${mode}0"
+		log_host "removed ns ${mode}1"
+	done
+}
+
+ns_set_mode() {
+	local ns=$1
+	local mode=$2
+
+	echo "${mode}" | ip netns exec "${ns}" \
+		tee /proc/sys/net/vsock/ns_mode &>/dev/null
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -110,6 +150,7 @@ vm_ssh() {
 
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
+	del_namespaces
 }
 
 check_args() {

-- 
2.47.3


