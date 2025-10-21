Return-Path: <netdev+bounces-231458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 542CEBF957E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2154D18C87E9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089572F39A0;
	Tue, 21 Oct 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H92IHcDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB42D0C62
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090440; cv=none; b=lBWzdgSJNf6oOqhLYoomkvBf7DanBSdvjaSBGTUfTvbwSeU660o3rnqOoI0Am28+JWF50Ql8DbvPV1JVYRCdu8p7AMOrDUILVTIMxqz4ApCncy6L78/tJCZVFdoNQ+VuCJbKcysjb1WWspeNW6NhuEpiC/4bHrb8Ss7MQ1YCqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090440; c=relaxed/simple;
	bh=X9WzUQups8TkdsWmkHEfnPyp3k1TVWabO4OwH0YlSZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmB84i7EmUKHsrcilte9tXZc4PJUOyUsM+7+nwlS1CHrvCE4wXV81gDy9Dgt+8tg949+OSoO0fpUECVUHiQpzeNzMW74u0vj6J3nmmDtFGXWQ+zwcxTp1kTKuI0nn8edqzashcFroKb0PPnmY1IEydqNRdvCAG4t9LQLTJJ1WDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H92IHcDq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6cdd7e5802so105757a12.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090434; x=1761695234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExL6guYlGMpC9HoFsJPCjZr8NPSDth7dE4rzR6CctFc=;
        b=H92IHcDqAOBl+0N4MTZ+rK0vKqOC/cVUE2BVySlhzWIYtSKBRbnZLDQZztI0Nw2Ycp
         i7Md4C8ArGNcoGruR8l5xxve9Ak7vuSKxxVuOHriYtweHZgLp5spVyDheuCxj/e0UbLS
         FLLg96sJIAne/k0FFHiP3y+ExhV1V0Fr2P2cvoWH0fEkkcnNsTReFskJYCmgcUGuMuOx
         LZzAW1Xxwkzg2o4jhAxpUOaWK59ghe/JDPr/SiCmRF6esklRVVs0jXc6Bdj3XJN6yXti
         2lmNVsc8eTF2zHXqG9BPIYBnaZtVcKyWKVZdT8bUvVSLCh+Bi35gsnEnHuLLbi+AeK8k
         0QRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090434; x=1761695234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExL6guYlGMpC9HoFsJPCjZr8NPSDth7dE4rzR6CctFc=;
        b=h0U0bFS6p3RlAe7DpqKFuqsrkpnh8bBwn65qt0ADJ54z6xp+v6qCYDaXMwrx9Wybt2
         muDW1ZKXTD0EKIt6uZfhaSl0sQc7BYzy/4BebZSy4Ad3Skx42dCa01BzM02vWb82uaVq
         9vvsI5fi1H+KSTqS8PN1ZtUZ4RJGvhY6WstZy4ctgTp/H7CvP1g5a3VUxIsUv3n3gXkL
         6jrSjKLUZ49AYnKEBTQype2s1PCJy5UQXSWA2EYpIsOkflXYWy0nPi10eME0VE24CQJu
         9b+tfeii32Vr506VodIWCmrxYQEARWD//+hdofnEJimCPtgZXMQe72ICDm+GaaKDfCY8
         uJww==
X-Forwarded-Encrypted: i=1; AJvYcCVbr9j1XEbJm3A/8hFdjK6K8KcbgzhxmSyY2fUe9h+n1lU4OdI/xYNBO1wN7ygE9R0M+amzK+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYXj53TbFGyauJSL5ogbhd7XDK4tMjSbJIrlHzc22g78wlDiy
	VwCR18pzOGQTEd95bvvcdwtSba9oURVCQI/04ymYp/i76vpXrQDGowiW
X-Gm-Gg: ASbGncv7aicDpl51tRzsAxYBqy1OUeV6I4Bo50ZQ4oul5V9dM2+vnVF6HJiIC6jhjpd
	IvJMvxsglf7H5BiToGq2L/Esp5kY8K+fV+KBIRKbRGmbhU2XBA62gs8nSVs2HaO9v5Cw3Gc+Ka6
	3w+ysRtBxCyWt97z7NE4w5L8hI0KuhUlegTGlPzhfIiUTvKlBpIWBHWSxZ451p6qNfzwvb7rayY
	XD+WTV0HZRvgspUDYbOb+KpLnRaFo/7ETSqRAfuC1/qEJORQvZ++veGE7lR8cULe++3xS6+75R3
	ZrN0nkf7RvZmj/GHV21jhldoMT14QPj011hyIR/6ndJtkuoGhsPUjymzUFpjSGGTh6nUEX059+j
	TWPk5DoFKdGJ+qn72g8M4l/Kz4bJYB5PeFGHmRaEsyyYljg7XfNta78Dgs+90Q0r64xHHEHTh
X-Google-Smtp-Source: AGHT+IGFjlVJaAVI5l1l9XcDArSqr800gCJXUHbkf8qJCt41RTFarYvpfL88FKlbpibTKt7cQQNqLw==
X-Received: by 2002:a17:902:f548:b0:276:76e1:2e84 with SMTP id d9443c01a7336-290c9c8941dmr231390815ad.3.1761090434188;
        Tue, 21 Oct 2025 16:47:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcc1sm120666255ad.82.2025.10.21.16.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:13 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:59 -0700
Subject: [PATCH net-next v7 16/26] selftests/vsock: add namespace
 initialization function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-16-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The init_namespaces() function initializes global0, local0, etc...  with
their respective vsock NS mode. This function is separate so that tests
that depend on this initialization can use it, while other tests that
want to test the initialization interface itself can start with a clean
slate by omitting this call.

This patch is in preparation for later namespace tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4ee77e6570e8..914d7c873ad9 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -46,6 +46,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -100,6 +101,45 @@ check_result() {
 	cnt_total=$(( cnt_total + 1 ))
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

-- 
2.47.3


