Return-Path: <netdev+bounces-245922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C8BCDAF25
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 01:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AB67309C319
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 00:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D260A256C8B;
	Wed, 24 Dec 2025 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI7djxw2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB5323183C
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536145; cv=none; b=CU0hAjTx7erBQVPFP/DvT3eHg7End//BZPdO+Uz3sVHio02496qOsL1wMdNfaqMaWDBGWlxibqDrGvzyVI7TcOqdw8o7X6L5P9BsAYGgdO4MPyoKuddNSS9h16mWerbnZHZPTuOwBUfpob5mN34yb4DBgVkUP5cNwPYmwhXlkxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536145; c=relaxed/simple;
	bh=A/Re4uBOGGe0FAXjhpo7AUAS6ISO6mznmR48rNydg0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G10OTnlkBWeVdVc3WFHooX3Vo1/HvjaEA86pcXm6clvNrFm8jBoFbu3hZCSROIf5+qg1HBtUqxwD12lfO2r7iEiL4/4/MrxxzX87qES9kHZ7E7MJlP5F10p6rmTsr8082Lo7WtCFRAy1GXvn4O9A775f0K6M5YMdjVR6Hrob3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI7djxw2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d67f1877so68970285ad.2
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 16:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536142; x=1767140942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMAS5pTBRt+D+YQ3hZNF0StDlF0aWH+C/CFg55tOZdw=;
        b=LI7djxw2SmbC7GAb2AzCJnlQBmGO0eXeEqgStf9bN+I4jrDTU/oE6tWx6YTV2FkGbL
         Em5CwYkq7sYmK9K29/5Miz663ffMPAQI/byO13LCStjUkK8B9uF+fV5QyK2CHoOKYSzt
         lGXu5R9UCkmUTfwgFy4i7pZeovHIx1Uffih+LouEpY4Iu/PdXOZQTcONUyr2Mzda5OVz
         V+D3v9pmsLkDSrUfYNOpBGGWh4XMvXEwIJJTw6q/XK7erS5N0Dtdo9DAQ/C5QqvekCBt
         9fE1wK5BfE7iLk8xzodLITz/PgHNqHDq/m48oayuoXCt2XP+pj7WOqO6rgkt7umZ/uJZ
         6/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536142; x=1767140942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMAS5pTBRt+D+YQ3hZNF0StDlF0aWH+C/CFg55tOZdw=;
        b=Ix5WvmXPS2j8wsjQJBHWUFezrf8VCsqE1F0QqnOUWGVTcJJ9iA4yYBJqbyfDBP3zLh
         pdYOV865atNSPLQt2wr++BPVF/oTeDpDzIRtdMQhhYTS9HLilmJOArmnpgpJeUrixnOA
         BgDsMT+ptYrl6obGQYut8LtzIE+y5GA45DE/SeGZl1l5WmWsIWSgqUKMW9o7EGc+/yue
         pK8UeJHdLYHB3wCq21336EMg/S7dMMErCLHCq/LBYbkyzFLUFBZ6MRuJq/zh7oqI2Sav
         F2Jcp9J7ccPBD9ljqPj/qusHeTea5o349eQRWZo7IZ7UbFvEdfXl1ge5jLz+LJNS6GLF
         s9mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG3Y8zbQYLAX2Li/1+JkzPIZdQ2j24eeh7hNZ8mkD5qgAyl0Xb/CANGrjf3oJFqGzHTL6BxP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IXxMMChfhMtLWHw38IpbKWTKN53b+tU9uuxYZUrlG4EaNXOJ
	DyH76VPc2phCPc38r7zG5AwTtQkGd/ldBhdXpy82xF0yv+wNuhUSNAde
X-Gm-Gg: AY/fxX7R3FAN268IChcme0ncibQy+TsCGuscjHSrUO0H/5tYCBFue8MuaWlkqVThbp5
	looShYxZjGcQJF7+gnvdS71BTgefE4bVAHB8plAb4FmClfdNBP5SQjM/tC+qaMG3n9b4Kdr8q+K
	LcYsOFD5o7pmarwHEI5HjWRHdahQXVSi7aKHxi0wVHQhnmuMJAOvVHgVHqWeYD9OIXSz7jEe88v
	sYEVE7BWXxhNLiCHQUFnihPtvBLHOWB1OASuB5o7Y1pc4s7Ze5Y+PGYFdvpBq3/7g+puLbVv2f0
	b5mHqY/Tw1/9RyXgKh4dBxNyRPee0FANC33w5djR7jAOfqAwsvTc90xXEkGa3447Bz2L0j6DzUu
	zbRKYMKQ48zeOoFEarhL2kUgJonf2BCIbMQhxHl6Xw0lgY6WeC6HLUBm28kt7Fjy3zcR8ITexGD
	/1YFlvJ8mJetNGeIr3X0zH
X-Google-Smtp-Source: AGHT+IGk5LVdk+TERc/fw8l5nIc94qgaWAolimWSUPj2FUxbokwJ6dSPaiM4BcignHXWPYwD+sNmTw==
X-Received: by 2002:a17:903:b8b:b0:297:df4e:fdd5 with SMTP id d9443c01a7336-2a2f2327264mr159417125ad.23.1766536141803;
        Tue, 23 Dec 2025 16:29:01 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c828dbsm135979755ad.22.2025.12.23.16.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:40 -0800
Subject: [PATCH RFC net-next v13 06/13] selftests/vsock: add namespace
 helpers to vmtest.sh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-6-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The add_namespaces() function initializes global0, local0, etc... with
their respective vsock NS mode by toggling child_ns_mode before creating
the namespace.

Remove namespaces upon exiting the program in cleanup(). This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test.

This patch is in preparation for later namespace tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v13:
- intialize namespaces to use the child_ns_mode mechanism
- remove setting modes from init_namespaces() function (this function
  only sets up the lo device now)
- remove ns_set_mode(ns) because ns_mode is no longer mutable
---
 tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c7b270dd77a9..c2bdc293b94c 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -103,6 +104,36 @@ check_result() {
 	fi
 }
 
+add_namespaces() {
+	local orig_mode
+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+
+	for mode in "${NS_MODES[@]}"; do
+		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+
+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+}
+
+init_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
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
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -110,6 +141,7 @@ vm_ssh() {
 
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
+	del_namespaces
 }
 
 check_args() {

-- 
2.47.3


