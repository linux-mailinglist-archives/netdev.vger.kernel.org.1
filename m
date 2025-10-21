Return-Path: <netdev+bounces-231468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E1CBF961C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D60EF505BF3
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2B42FBE0F;
	Tue, 21 Oct 2025 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6J/Aftu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6992F5333
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090451; cv=none; b=DY6ljCka3752Ac6SPbKiNcbYVMIFVvK0nYYEssl4gE4ReldeUB0abYnFACGjeHKQBpBoj5LJVXo57Ysut1zh5WyVKBoKrVyZDNME6es/rpwATOpiewLfs3WuriBf/wkPn7EYsn9NyvHLHPq70uVz//cMEnf27oBH3jNGp1YpmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090451; c=relaxed/simple;
	bh=aux3K1IYIyz9wrqrgYN0zmRynTiqRa/rFWmvtJNo/MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYI6JjUAUHULh2jt0Ldw99Yz08tm0bgNx2UorrQaTDc4LKd183TCOxNBqca+ex0+Fw5fCx8n8Bylbf95+VhQDT0fmZRfl6SdSBM033Mm6UQvbG0cFMDxPJzy9G45N39AxcIOdxZWu0TfBdsATeczhStVDU1W+T/DoD6m2gMqqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6J/Aftu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b67684e2904so4422355a12.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090442; x=1761695242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkE1wm12EpboPq+xR0aDSe3dF2N2c2mo+B2K7wyT4X8=;
        b=C6J/AftuMusU8Mrlz5RZP9zd3cowo+Dg8ucaMJ5+lmjqC6A7BJ0CG7rav3J/C5SiXD
         tuytImbpcR0mTyq1QkzhVrjtZc/gB3iuGeqOYoi8AcgIxViVgm4zYih7wSD79MmnsHGo
         8ECrUsXacQ0rjTNMTT3oSS5KHtJqDBt85RMUzhshDzWiS0zZT0WffYfiYVp8g9kxISg5
         +yyU/SjNYUjfKPc2GID8TAK7e9P73uKKWRLH/vIKjLSfqI2ykYedX+ymITRkmhOMojBU
         1ET+y4bgjY3oBvMAWEbcfVwl9YdS8adLFnI7+hVOK5y3iAaBFhYWZPmqTMwNxGB54lMX
         VuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090442; x=1761695242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkE1wm12EpboPq+xR0aDSe3dF2N2c2mo+B2K7wyT4X8=;
        b=SyxfKuWKWQ+Byam5HX3GTmMHkMImNKBuJUYDelXOsvSbmQTzNMMKEYP0OkShpdCusG
         RvoixREwxanv4spJolVoGY5FeMPVRCyVCDTx6ivRCDzkCZY+/zBXKeaGvQ1Z5Z1/eRX3
         XEwkkxppBfo98qkijv5P9+FPZ2LcIAmWs0DDEgCh7Lk9DMmVEMFL7kZWzs/suxS2Rjzb
         UHNYJijJEpeOFRCIxKHDflJMpZqVk5EKJ5qb7bjYXhmeyz9Bfl61IRTK+e3C9d2dw8cL
         Hx6rvLegS6JFBOeK0E30D4yDcOspVN5FPGj12HAHdD5h+XmNJnRiciAtIXP+CLjdFeqK
         lRjA==
X-Forwarded-Encrypted: i=1; AJvYcCW4fsS6ljyVVeC8aiNHoB6z4VzjMz8TOJFjc0egqn34ktHt9+N4SZaJhZQRYxEqYDoC2qiegBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0V0Tj7HiVqHPvNQDniEEfKO7EhAbesi9wn0zaPu9jETukpTJ8
	1oqtqkyQWzHKaZ3DlPfeMy3T4fHXV/GcSksyKq7hlMsg46nIZ115YBaF
X-Gm-Gg: ASbGncsG6YLsgB7zttAqHAJWjHDqTorLtY+pepecQfrI8Pi0ijKtxQq37vKr2md2Fo9
	Hr8A/477H5t9Ozwf/1C97y/g1Fs3q0Fn3xaf9ZRYSXhU+7OIFhEn+7nCjybtjnkl2CEhvDCV7oN
	ayOgF4DRp4iLLGSSsyxQQ3U7Ycr4VkAW+PDuV64kUny9Xka8a7AFqN+UttU6SHVNb+qaA3Zmt4I
	sv4RsG6oXRh47tEzc1yOtG9jqHLXdH+r66dLYULGB4t9rSGI1B5FaidRq07SdMsfDv/BBUh5OyH
	WF9cK40e5n5Va7qmJ5XM8WcCca+9qHlz7kwzV3oA8OZLj3gewTTICCWwEXMXFitRowtIIV7VDSf
	9G6KlvUU7QjKzhtd2Ya3bz0shZIPAQcoBNEI9cwqGb0K3MhX53DbsX7iemPpK6E+u3CHZQsyt
X-Google-Smtp-Source: AGHT+IGJHLCu0MjtQBg0SHgooNwgM1vSlSfWRfiRu2HNlz5nsiqtV1uW/yPe7aUNptDiEFDTA5YlTQ==
X-Received: by 2002:a17:902:ea05:b0:267:f7bc:673c with SMTP id d9443c01a7336-290cb27af4cmr269152055ad.44.1761090441540;
        Tue, 21 Oct 2025 16:47:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b35dadsm11933323a12.26.2025.10.21.16.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:21 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:07 -0700
Subject: [PATCH net-next v7 24/26] selftests/vsock: add tests for namespace
 deletion and mode changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-24-0661b7b6f081@meta.com>
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

Add tests that validate vsock sockets are resilient to deleting
namespaces or changing namespace modes from global to local. The vsock
sockets should still function normally.

The function check_ns_changes_dont_break_connection() is added to re-use
the step-by-step logic of 1) setup connections, 2) do something that
would maybe break the connections, 3) check that the connections are
still ok.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 123 ++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 0a5751c52fa8..f8fa8b16d6e3 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -62,6 +62,12 @@ readonly TEST_NAMES=(
 	ns_same_local_loopback_ok
 	ns_same_local_host_connect_to_local_vm_ok
 	ns_same_local_vm_connect_to_local_host_ok
+	ns_mode_change_connection_continue_vm_ok
+	ns_mode_change_connection_continue_host_ok
+	ns_mode_change_connection_continue_both_ok
+	ns_delete_vm_ok
+	ns_delete_host_ok
+	ns_delete_both_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -129,6 +135,24 @@ readonly TEST_DESCS=(
 
 	# ns_same_local_vm_connect_to_local_host_ok
 	"Run vsock_test client in VM in a local ns with server in same ns."
+
+	# ns_mode_change_connection_continue_vm_ok
+	"Check that changing NS mode of VM namespace from global to local after a connection is established doesn't break the connection"
+
+	# ns_mode_change_connection_continue_host_ok
+	"Check that changing NS mode of host namespace from global to local after a connection is established doesn't break the connection"
+
+	# ns_mode_change_connection_continue_both_ok
+	"Check that changing NS mode of host and VM namespaces from global to local after a connection is established doesn't break the connection"
+
+	# ns_delete_vm_ok
+	"Check that deleting the VM's namespace does not break the socket connection"
+
+	# ns_delete_host_ok
+	"Check that deleting the host's namespace does not break the socket connection"
+
+	# ns_delete_both_ok
+	"Check that deleting the VM and host's namespaces does not break the socket connection"
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -1141,6 +1165,105 @@ test_vm_loopback() {
 	return "${KSFT_PASS}"
 }
 
+check_ns_changes_dont_break_connection() {
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local pidfile
+	local outfile
+	local pids=()
+	local rc=0
+
+	init_namespaces
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		return "${KSFT_FAIL}"
+	fi
+	vm_wait_for_ssh "${ns0}"
+
+	outfile=$(mktemp)
+	vm_ssh "${ns0}" -- \
+		socat VSOCK-LISTEN:"${port}",fork STDOUT > "${outfile}" 2>/dev/null &
+	pids+=($!)
+
+	# wait_for_listener() does not work for vsock because vsock does not
+	# export socket state to /proc/net/. Instead, we have no choice but to
+	# sleep for some hardcoded time.
+	sleep ${WAIT_PERIOD}
+
+	# We use a pipe here so that we can echo into the pipe instead of
+	# using socat and a unix socket file.
+	local pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)
+	ip netns exec "${ns1}" \
+		socat PIPE:"${pipefile}" VSOCK-CONNECT:"${VSOCK_CID}":"${port}" &
+	pids+=($!)
+
+	timeout ${WAIT_PERIOD} \
+		bash -c 'while [[ ! -e '"${pipefile}"' ]]; do sleep 1; done; exit 0'
+
+	if [[ $2 == "delete" ]]; then
+		if [[ "$1" == "vm" ]]; then
+			ip netns del "${ns0}"
+		elif [[ "$1" == "host" ]]; then
+			ip netns del "${ns1}"
+		elif [[ "$1" == "both" ]]; then
+			ip netns del "${ns0}"
+			ip netns del "${ns1}"
+		fi
+	elif [[ $2 == "change_mode" ]]; then
+		if [[ "$1" == "vm" ]]; then
+			ns_set_mode "${ns0}" "local"
+		elif [[ "$1" == "host" ]]; then
+			ns_set_mode "${ns1}" "local"
+		elif [[ "$1" == "both" ]]; then
+			ns_set_mode "${ns0}" "local"
+			ns_set_mode "${ns1}" "local"
+		fi
+	fi
+
+	echo "TEST" > "${pipefile}"
+
+	timeout ${WAIT_PERIOD} \
+		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done; exit 0'
+
+	if grep -q "TEST" "${outfile}"; then
+		rc="${KSFT_PASS}"
+	else
+		rc="${KSFT_FAIL}"
+	fi
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pids[@]}"
+	rm -f "${outfile}"
+
+	return "${rc}"
+}
+
+test_ns_mode_change_connection_continue_vm_ok() {
+	check_ns_changes_dont_break_connection "vm" "change_mode"
+}
+
+test_ns_mode_change_connection_continue_host_ok() {
+	check_ns_changes_dont_break_connection "host" "change_mode"
+}
+
+test_ns_mode_change_connection_continue_both_ok() {
+	check_ns_changes_dont_break_connection "both" "change_mode"
+}
+
+test_ns_delete_vm_ok() {
+	check_ns_changes_dont_break_connection "vm" "delete"
+}
+
+test_ns_delete_host_ok() {
+	check_ns_changes_dont_break_connection "host" "delete"
+}
+
+test_ns_delete_both_ok() {
+	check_ns_changes_dont_break_connection "both" "delete"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.47.3


