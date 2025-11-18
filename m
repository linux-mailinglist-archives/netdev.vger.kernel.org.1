Return-Path: <netdev+bounces-239329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C9AC66EB9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id ECC13291E1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBE7329C58;
	Tue, 18 Nov 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3dpsW5V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B846322C9A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431240; cv=none; b=MwvPGOOe3thkeuwkTax/UaD4sD42uZDRFOFsGAkPigR2vmHcIRJ9o9DBv6VaI3PQR0htiW7Rqb22p6i76KMnFQn23MRmT3X+s/B3R+XEGk8+MEmWn6FXWQWt0iiyUzgWL3d/eCBZex+xszRXA6LMtGGC6kFkrFQgSrjDHnLP8ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431240; c=relaxed/simple;
	bh=C74tPtLEcFlxKPQiq+20Ok+iNGw0X0cvYTmDWlPCWgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iVHR9os6oUCW/1ItT1yg4h0L7EaDLIk7bukuu/epMSpejeR5ksI8bJ7AsZHo1KqhYKZldzqRWmnE9fm+sFAix/eMtizdaKFHn9CrKgqFKErosj0GH1GhAzjRhj6A1sRzQ7Lhqx5O8bDpP52drv0p9moK3AnHtS/TMVTOi6ThTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3dpsW5V; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso4292963b3a.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431236; x=1764036036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p28zEBQeBUk36AvYw3frZ4faKmOpLSnPo9g0yADkH2g=;
        b=X3dpsW5VD1iHZMZBeS9LTTM+cu7GT7shshUYdIbgPDyWAkj5lxHNEk3tw8aCR33Y/C
         6MmtHlbuW87dR1DK5O+R+oya3a7iSkQZ6ZtOaVF09e2+l5eyL5DCpAAhj9C62oT53WbC
         WxJi55It+J/zb8LdF7I/f5qTPUHxFdTy8/8kSRgyPOx6IBK1sfVX+V6a140r52ZhvXCW
         yzQRcTqzWnzEPkBtEWBNnFYYQD3cK3KsHTMbnb8mZ18V8jLOQDoSlp9w/+bur2Gf1/dT
         r9ci3lwe6GC9ErU0M43rrZXabJGZUjl10sDzLf2WrsmuWCbrfN70zdtIIpYIVFJXqJcn
         +ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431236; x=1764036036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p28zEBQeBUk36AvYw3frZ4faKmOpLSnPo9g0yADkH2g=;
        b=CIR0EdZaTDa+IygBLOf3M0m/nA7nxVBR0HPH6uV04XLhVUmAr9A5E4XEbrSJfwSHjm
         U2FBHUOMS537l2CreL+KP1iIMq39b94jNiQPYd8IgO2dkv2kZ4eEEiEl6KltXsgx02Ep
         EMa97gcBGdCLo44FaOcK2gqq/vCe2u4xsX00fUxyUjkUAqNLfXFgB4uBe7NwnNie3BXm
         NcQzP4YK6vTfr308SFVTPocpVS4lD5dbRajKB9sNn+tj/Dt9g15GEEHvbJXLOrrYYVRJ
         i5EIstANgw1eORPCVqPOmpp6xCXHFhVpyAmbiWo7clNsYLGJYCNsfQMvaVBoYaAdFVe6
         NvrA==
X-Forwarded-Encrypted: i=1; AJvYcCVKO9mDKHSPvTlsnxWE47UeLYeyxv0R43+Wx4zw4G+ebqrnwqu4opz0rjFLxTgfDKOs9I8W3UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KGngAef3ZecUtgSPbYqeFXlTsFjCbb9n5JQBErsYPWxhDMdA
	H+vxDJthbCMGx4/YCisZUaAZDTB9OW6TIJDnVB4UjA9YORG0P5HDFEij
X-Gm-Gg: ASbGncuVYsbekq4hf4UenwMVN67yu664WkXE2Gld9uzqyBn0pPmlWPL40LH3mA+qoTw
	MqPntsSkwKHpWqXyPV71YpbnC72NKDOnjJ3hV5K15+cv10tQnC4kULT6MZv0bPryd30tvZmjE5O
	qFUy8dMp3k7DUbLGHYSP7RiF+DOWOOUXZ+xuj853smVmYdgs1D13wZtnw3Im4pF3d+e6997tcIo
	YZYo+SP9V2hq44JOP2iSPxRPGURZSpToOVYZEzIv+ZxCYvMmcwwmYuM/fDUZ9Ad4p0VfF2ud6AW
	e7oiGkXcnmt9KlFYxhkzzYIc6KceZsgb9xAZHGq3gpV9mJVlbBc/J58p4wQyrWX76CMNUQPVy33
	OVmxxARw8XaDPNfOsIuPJAPcyNTHYk5EDsYuQTzTP/A+N7cGVPyYGDaLoQM67LBJ0aVFhCnRDwg
	mcYwtCo1dizvJGXKWrJQRy
X-Google-Smtp-Source: AGHT+IEmbu2Oq+eI39o+T4uA9OHsNgBlxQx43D24whybJe4Uoof/z/T6SCWomsjNpxxj053tcafmCw==
X-Received: by 2002:a05:6a00:2d1e:b0:7b8:c7f7:645e with SMTP id d2e1a72fcca58-7ba3c07eeebmr20196264b3a.17.1763431235927;
        Mon, 17 Nov 2025 18:00:35 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92714e298sm14608613b3a.34.2025.11.17.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:35 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:29 -0800
Subject: [PATCH net-next v10 06/11] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-6-df08f165bf3e@meta.com>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
In-Reply-To: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
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


