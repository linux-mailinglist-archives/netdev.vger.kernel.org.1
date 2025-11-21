Return-Path: <netdev+bounces-240662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA07DC776CB
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 10A8B295D1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 05:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1252FE564;
	Fri, 21 Nov 2025 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAUOO0WH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D52FB0BD
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703901; cv=none; b=ncF4jp3ImslSb8OQSSWBxKzJRjPLB7Wgycuzt5GBN8FoUm0lVNUyYVW/5f2dk16ZfDCJHAthKaXkajvpGTMAs2VZU/mSecZPRCjN9WSAFKcM1YtEg22K0lI+4WpvOmjgL5TiQ97A8XqVCbhl6lfhv4jxV57E8qN15bh0keDuu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703901; c=relaxed/simple;
	bh=uK+7wonqeqIE2+4J4eSHlB1BJW2sPOHiw05XtJHZdQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hWltsLpcJH8/2xte0o3GXa4Ola579gW9NLe5u+IntnD3nC9aJ7s2gQBepc831YVGOn5tTUeZbHC/ms3LEaDTW0jWDbGSLZ//NEPvH9Z7lP2yN+u/PyBjqZyOpy9qJnTEPHv0XYdXGIPRVSWm9jwYqYEUVjrb/7K9NcIXXZggTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAUOO0WH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-299d40b0845so26505245ad.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 21:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703897; x=1764308697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSkbmakY8QtibtOCdba8TmlxElnFph3vUeoyjgD6/iw=;
        b=QAUOO0WH3+qgxCZ6gMwgQYIf1kk8I60OZx+Wxe2+vqswILHB94RidaRv6PgCam5Q/2
         0QeqACwTPcokwZ1EwCE9dam0p5utVtxibxiUmQQP4AH9iFGNKaLyhRpYOEnHT9bSW9w3
         nhpWiRmeFGT2pphlhz6ckYZJZlrPTLQUtOx6da7bJ2js+q7FehULpnpD7Lku6lz3sXbN
         KC2TRvN/VeTSxcaaEOdNbgXjk0EKihxBvkR8mfc8eU2hGDUwvoJ3m3eWqgcg3guyA7O9
         MWl5ys8XEXnSXyMtIMLQuXdf5YL/w78Un6fNQG9qKtkWEIG1PTstwa2KYP0Ip0sZFAzt
         99RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703897; x=1764308697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fSkbmakY8QtibtOCdba8TmlxElnFph3vUeoyjgD6/iw=;
        b=Qnh+iNHh/fMlO5Z2evwxb41GP61ugor983y6Qaqb7//b4GsKxwgxLgVoxNaGJTGiAG
         FFdDdUqCdcV1c8m6IA3KAj8gVKsx4rqK2VtM4bV6Yq7nNKekHL9nT5w9whDlPPCVwZIe
         gylSj274e0Eq3dlmkE9AySfTwqmOwVjPlkbRHXKUqxa1/gMcvztIiqcllmlKWiw9Lz7d
         SJwgCjOLURN8bca/R3g9y5GALONNBFJtm0YdZWyuojRwyVeqXJJVx5gJNNyi6yfZO8IG
         e4P+c67MjTeYQT72c6dJsrIkmdEgwD7tf8J8FAvPR9GUo05LT+EEcFzgsuvEQZGfn1K3
         bxLw==
X-Forwarded-Encrypted: i=1; AJvYcCWLIks8zcSo8tAgX2yXk7GNDk7b46BuLxDsZvqSRqSAHQ3YD8+zhoc4dnTEFRx+vu1zlodXAKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCphrupDkmtFhtb0sfMbNvjZsEDOX6aBKu8phrqqaounjT1ly
	8hHDyQ3nkV1V+64wShXwMSDDKeFTDYVWAGnv9D09TUwIbXaoBtmMDdWy
X-Gm-Gg: ASbGncumTC4seCC6NQYv51V/iMt5rStpWkbb7c/0xpHBH4lisFZnk/lf0n52Ys+LTwK
	5qsDI0NNCO+hMd/rUTNU3Pj1NQ0NRx0wU09HVCagIGgAp367+lhWN+mPI4ohq72zFtc+3w9uAgg
	LOJMQpu4TwaDAAf3y5pwuXvaeYdsDo1lxwow9C5c6U+ZGHZKmWBIFymHfk8v9N8Pl2Y0VU5S9K5
	+pTl3beZjzbetBjauahiA25GYwwUUkONOWHJ7ArTki5if1rNTgKerMgPKd0rob749KRwUOsGBsC
	/LYDVo+FxWoY2LVU1gx+1eXxJ+82+JCnHF3213R7bLqJgbch9B/RvERsrpZiwQeDrXOI6lMBCQN
	btJOIb4Z0kMrf2XLBKvAbYTf43W+HoFyVADnwtbNtOA4u9cN/4sj0rrFZCTB9MS6nOQZ/JizfZb
	qUwdQk5pfhuhkqYjOBZU4=
X-Google-Smtp-Source: AGHT+IGGsDu1q3vm1jDYt6q/UI5NUFr2N2GTMwEvCBun/hcx13LSj7midmn1ev74SGvBLriqPu/3+g==
X-Received: by 2002:a17:903:2ac5:b0:297:e59c:63cc with SMTP id d9443c01a7336-29b6bf19ef0mr14465525ad.35.1763703896832;
        Thu, 20 Nov 2025 21:44:56 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25c104sm44306755ad.54.2025.11.20.21.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:56 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:38 -0800
Subject: [PATCH net-next v11 06/13] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-6-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
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
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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


