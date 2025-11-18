Return-Path: <netdev+bounces-239663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17177C6B285
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C65484E0221
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB8431ED94;
	Tue, 18 Nov 2025 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9Mg6H7N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVBkJLqL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6FD21A459
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489725; cv=none; b=t5lyTgvIqORYcEyEA5cfvy/oJEuc5brwc6HJmmhCYWgQkM1ZMh6Tl5K/z3bk60pPeVtqb9ZORcsTDN1PMnJdpuHU+Urjs4qUNzXNusOiPUc6wXta0ee+MNM02cRPUxQItkUZyEB92hMUsnAdN4nHZJ15ir3lFZfoHxMIUAsUTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489725; c=relaxed/simple;
	bh=YGhta0kW3+b4SmVhV2dx87CrUNHDrRdDg6rFy1JQPPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTQRO7o3dheXRY4jv+V4si4uDNUTxchORRHld7MusaKAMFvd1kpFWhJNa+k6Ti1qVC+POjZk1MSVzKGzJUvwEi5eyCU6axLaYaAdRMZF8z2UV9K3vn3HH8Klr4k9MT0AJzIwFXygKLDmqMs2JSZLIG8CZ7DywkBYbHOF1u94X1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9Mg6H7N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVBkJLqL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8hCvDP1lcVVVyGawLGV3cwNq04e3vuB7+B7JvpDNs2E=;
	b=V9Mg6H7NOaG55DcyEO9phfDrAbVWH2JU57NambzPNLpX4s+rSZVarzaFfVLjHzN5JztpIX
	gxSJ6hDz187KzP0S0acnwdsx6mr9IKVmYQEI45TLmTeUDOEblUdS9Ttjy0g0mDicSHy+Ub
	h7SdGwdP9YGgjZKWJelNIqnO3axvZ4A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Uus_-Rc7P4qzwD4UgE-oow-1; Tue, 18 Nov 2025 13:15:21 -0500
X-MC-Unique: Uus_-Rc7P4qzwD4UgE-oow-1
X-Mimecast-MFC-AGG-ID: Uus_-Rc7P4qzwD4UgE-oow_1763489720
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779981523fso27645455e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489720; x=1764094520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hCvDP1lcVVVyGawLGV3cwNq04e3vuB7+B7JvpDNs2E=;
        b=CVBkJLqLXK6oqnNCfsYz4SPEX1jXnuG0EL6zaxkcsREa1hpeLLGXg/geXGXelW5Fz7
         xXswiB94vLQ3HIOfUh8ppkiJ9TOkQysTcrpG2ihKIUsZQmrDisg+1NfrTgZBlp30lgda
         k814L2Y6CLsNMg7g1oNo9vYEmuHnAAvSb/1ESUUMZsnkFhC6jLaha0cXJLHYKd7RW+PO
         2ksLv8O7BcneCpM7aKdiZglEj2aBPDSGQ7FJdFXDzHItkII1lBShcznURF4CoBRUmciw
         y5D4TWfYbXdWT6ExYuyRVmqFbCWu2s6LtgLUF+NR09ivY2E4a5wCM5zexKiJJtK0BXOJ
         7KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489720; x=1764094520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hCvDP1lcVVVyGawLGV3cwNq04e3vuB7+B7JvpDNs2E=;
        b=lUg24+QdhOJTvM9eUe+rRTZsCaeLtkEp0TdQZ3XK1AvyCKO51i0U/BcEpb7wm7Lg+q
         aDjpRE7wO9hmSjJNs2rDp9xOEwlHApkKseDHnCadVaiP3xjkhA9EKcymXASJ71R7e+AD
         bg01HmveHy0ZGd9r/ch0KwFMlWv0mrY03xzwVOPFgzvUS+1Lyks2CeUhIWH7Ufzw6AqC
         8+2J8G+sPqQQIiBJsGmlRC2kEDxYsBVyxiSfJe8STnrcLk/xBPHqSf+BaJ63ZVSUA/BH
         PeZIRqBVJyvy9QKpXlg8/JiO+DAuV9qpsaMJU5SwaaQXfzsdl/jWYkGKCeaz+ox68n2L
         ps6A==
X-Forwarded-Encrypted: i=1; AJvYcCXjM3+gvUq3qQ6LFKh1z9C1oSyghvXEibj77r7EKOhZBz1Vr2WSWhCws2xW6OKZX/zSVkOneQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/tJiQbs1onoHb/6MeQk/hfnWHe4g8ngHz7KGfI/jicNFChYQ
	UqKRtLBHTaAkF17FfiiMxEpf6E8rMfse9tPwI9q1wLtGG4kp88hnQr+l8ZHCy7r0rP4n5kse7En
	degoJCwCoo3GYcS4vHWZOh4C9n89ZUBS4wkNgzaVfTTZpxCAN8X4yeRqn/g==
X-Gm-Gg: ASbGncv7amGrg3sT3f0b8kzO1r4nfEM7HwkRXgiWN6Msn/UCL+aD3HJCh8S0JLq3RTf
	+KZs8W6Lr08Yy1iXFSVIwTUZI27HW/M5VwAdHzbwXc8hSLJRG7EXyX9gaYfquiAsR0DYij21ZG1
	eSqM0NoILoQ2M46z41X5jgIpRvKI2M2RQPHIV+4ut+0ERw6hHULToRkXBFn87JFE0TPZGAokzhP
	cePmzCUGiLCzJd60FAbf6ExuN5PyZW/8mjTFmqk0/WQBalbXgsudKS9x3cCIrRIT0J9tkwy9GYL
	XTJvuqNW4Y+uiKvFM0Ap4OqMqvAPs+rulWdvkVwbw9YsVOazOI6NYf33qxM10xQya6WWo2zJ9cT
	0aZ46mfral3gvr2k9lr26azS7cuKs0/m1kC7ptLrTUCW1YcDMb8u0mg8t6Is=
X-Received: by 2002:a05:600c:c4a3:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-4778fe5e7cdmr164502365e9.15.1763489719633;
        Tue, 18 Nov 2025 10:15:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfuWO7ymzC7S4lGS/d5WJH0do2fVutQaFIsNpqkzPny/YMVNelQ+cmhITZxd98fOQ66p7FrQ==
X-Received: by 2002:a05:600c:c4a3:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-4778fe5e7cdmr164502015e9.15.1763489719097;
        Tue, 18 Nov 2025 10:15:19 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e982d6sm33750293f8f.21.2025.11.18.10.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:15:18 -0800 (PST)
Date: Tue, 18 Nov 2025 19:15:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 10/11] selftests/vsock: add tests for host
 <-> vm connectivity with namespaces
Message-ID: <s6zhozplsbiodcy77me7xhbhrbrozaanglbvcc474v6q77cc3w@ckaftl4qebwa>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-10-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-10-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:33PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests to validate namespace correctness using vsock_test and socat.
>The vsock_test tool is used to validate expected success tests, but
>socat is used for expected failure tests. socat is used to ensure that
>connections are rejected outright instead of failing due to some other
>socket behavior (as tested in vsock_test). Additionally, socat is
>already required for tunneling TCP traffic from vsock_test. Using only
>one of the vsock_test tests like 'test_stream_client_close_client' would
>have yielded a similar result, but doing so wouldn't remove the socat
>dependency.
>
>Additionally, check for the dependency socat. socat needs special
>handling beyond just checking if it is on the path because it must be
>compiled with support for both vsock and unix. The function
>check_socat() checks that this support exists.
>
>Add more padding to test name printf strings because the tests added in
>this patch would otherwise overflow.
>
>Add vm_dmesg_start() and vm_dmesg_check() to encapsulate checking dmesg
>for oops and warnings.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v10:
>- add vm_dmesg_start() and vm_dmesg_check()
>
>Changes in v9:
>- consistent variable quoting
>---
> tools/testing/selftests/vsock/vmtest.sh | 558 +++++++++++++++++++++++++++++++-
> 1 file changed, 556 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index a8bf78a5075d..9c12c1bd1edc 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -7,6 +7,7 @@
> #		* virtme-ng
> #		* busybox-static (used by virtme-ng)
> #		* qemu	(used by virtme-ng)
>+#		* socat
> #
> # shellcheck disable=SC2317,SC2119
>
>@@ -52,6 +53,19 @@ readonly TEST_NAMES=(
> 	ns_local_same_cid_ok
> 	ns_global_local_same_cid_ok
> 	ns_local_global_same_cid_ok
>+	ns_diff_global_host_connect_to_global_vm_ok
>+	ns_diff_global_host_connect_to_local_vm_fails
>+	ns_diff_global_vm_connect_to_global_host_ok
>+	ns_diff_global_vm_connect_to_local_host_fails
>+	ns_diff_local_host_connect_to_local_vm_fails
>+	ns_diff_local_vm_connect_to_local_host_fails
>+	ns_diff_global_to_local_loopback_local_fails
>+	ns_diff_local_to_global_loopback_fails
>+	ns_diff_local_to_local_loopback_fails
>+	ns_diff_global_to_global_loopback_ok
>+	ns_same_local_loopback_ok
>+	ns_same_local_host_connect_to_local_vm_ok
>+	ns_same_local_vm_connect_to_local_host_ok
> )
> readonly TEST_DESCS=(
> 	# vm_server_host_client
>@@ -82,6 +96,45 @@ readonly TEST_DESCS=(
>
> 	# ns_local_global_same_cid_ok
> 	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
>+
>+	# ns_diff_global_host_connect_to_global_vm_ok
>+	"Run vsock_test client in global ns with server in VM in another global ns."
>+
>+	# ns_diff_global_host_connect_to_local_vm_fails
>+	"Run socat to test a process in a global ns fails to connect to a VM in a local ns."
>+
>+	# ns_diff_global_vm_connect_to_global_host_ok
>+	"Run vsock_test client in VM in a global ns with server in another global ns."
>+
>+	# ns_diff_global_vm_connect_to_local_host_fails
>+	"Run socat to test a VM in a global ns fails to connect to a host process in a local ns."
>+
>+	# ns_diff_local_host_connect_to_local_vm_fails
>+	"Run socat to test a host process in a local ns fails to connect to a VM in another local ns."
>+
>+	# ns_diff_local_vm_connect_to_local_host_fails
>+	"Run socat to test a VM in a local ns fails to connect to a host process in another local ns."
>+
>+	# ns_diff_global_to_local_loopback_local_fails
>+	"Run socat to test a loopback vsock in a global ns fails to connect to a vsock in a local ns."
>+
>+	# ns_diff_local_to_global_loopback_fails
>+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in a global ns."
>+
>+	# ns_diff_local_to_local_loopback_fails
>+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in another local ns."
>+
>+	# ns_diff_global_to_global_loopback_ok
>+	"Run socat to test a loopback vsock in a global ns successfully connects to a vsock in another global ns."
>+
>+	# ns_same_local_loopback_ok
>+	"Run socat to test a loopback vsock in a local ns successfully connects to a vsock in the same ns."
>+
>+	# ns_same_local_host_connect_to_local_vm_ok
>+	"Run vsock_test client in a local ns with server in VM in same ns."
>+
>+	# ns_same_local_vm_connect_to_local_host_ok
>+	"Run vsock_test client in VM in a local ns with server in same ns."
> )
>
> readonly USE_SHARED_VM=(
>@@ -113,7 +166,7 @@ usage() {
> 	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
> 		name=${TEST_NAMES[${i}]}
> 		desc=${TEST_DESCS[${i}]}
>-		printf "\t%-35s%-35s\n" "${name}" "${desc}"
>+		printf "\t%-55s%-35s\n" "${name}" "${desc}"
> 	done
> 	echo
>
>@@ -232,7 +285,7 @@ check_args() {
> }
>
> check_deps() {
>-	for dep in vng ${QEMU} busybox pkill ssh; do
>+	for dep in vng ${QEMU} busybox pkill ssh socat; do
> 		if [[ ! -x $(command -v "${dep}") ]]; then
> 			echo -e "skip:    dependency ${dep} not found!\n"
> 			exit "${KSFT_SKIP}"
>@@ -283,6 +336,20 @@ check_vng() {
> 	fi
> }
>
>+check_socat() {
>+	local support_string
>+
>+	support_string="$(socat -V)"
>+
>+	if [[ "${support_string}" != *"WITH_VSOCK 1"* ]]; then
>+		die "err: socat is missing vsock support"
>+	fi
>+
>+	if [[ "${support_string}" != *"WITH_UNIX 1"* ]]; then
>+		die "err: socat is missing unix support"
>+	fi
>+}
>+
> handle_build() {
> 	if [[ ! "${BUILD}" -eq 1 ]]; then
> 		return
>@@ -331,6 +398,14 @@ terminate_pidfiles() {
> 	done
> }
>
>+terminate_pids() {
>+	local pid
>+
>+	for pid in "$@"; do
>+		kill -SIGTERM "${pid}" &>/dev/null || :
>+	done
>+}
>+
> vm_start() {
> 	local pidfile=$1
> 	local ns=$2
>@@ -444,6 +519,40 @@ host_wait_for_listener() {
> 	fi
> }
>
>+vm_dmesg_oops_count() {
>+	local ns=$1
>+
>+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
>+}
>+
>+vm_dmesg_warn_count() {
>+	local ns=$1
>+
>+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
>+}
>+
>+vm_dmesg_check() {
>+	local pidfile=$1
>+	local ns=$2
>+	local oops_before=$3
>+	local warn_before=$4
>+	local oops_after warn_after
>+
>+	oops_after=$(vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops')
>+	if [[ "${oops_after}" -gt "${oops_before}" ]]; then
>+		echo "FAIL: kernel oops detected on vm in ns ${ns}" | log_host
>+		return 1
>+	fi
>+
>+	warn_after=$(vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
>+	if [[ "${warn_after}" -gt "${warn_before}" ]]; then
>+		echo "FAIL: kernel warning detected on vm in ns ${ns}" | log_host
>+		return 1
>+	fi
>+
>+	return 0
>+}
>+
> vm_vsock_test() {
> 	local ns=$1
> 	local host=$2
>@@ -568,6 +677,450 @@ test_ns_host_vsock_ns_mode_ok() {
> 	return "${KSFT_PASS}"
> }
>
>+test_ns_diff_global_host_connect_to_global_vm_ok() {
>+	local oops_before warn_before
>+	local pids pid pidfile
>+	local ns0 ns1 port
>+	declare -a pids
>+	local unixfile
>+	ns0="global0"
>+	ns1="global1"
>+	port=1234
>+	local rc
>+
>+	init_namespaces
>+
>+	pidfile="$(create_pidfile)"
>+
>+	if ! vm_start "${pidfile}" "${ns0}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns0}"
>+	oops_before=$(vm_dmesg_oops_count "${ns0}")
>+	warn_before=$(vm_dmesg_warn_count "${ns0}")
>+
>+	unixfile=$(mktemp -u /tmp/XXXX.sock)

Should we remove this file at the end of this test?

>+	ip netns exec "${ns1}" \
>+		socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
>+			UNIX-CONNECT:"${unixfile}" &
>+	pids+=($!)
>+	host_wait_for_listener "${ns1}" "${TEST_HOST_PORT}"
>+
>+	ip netns exec "${ns0}" socat UNIX-LISTEN:"${unixfile}",fork \
>+		TCP-CONNECT:localhost:"${TEST_HOST_PORT}" &
>+	pids+=($!)
>+
>+	vm_vsock_test "${ns0}" "server" 2 "${TEST_GUEST_PORT}"
>+	vm_wait_for_listener "${ns0}" "${TEST_GUEST_PORT}"
>+	host_vsock_test "${ns1}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
>+	rc=$?
>+
>+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pids "${pids[@]}"
>+	terminate_pidfiles "${pidfile}"
>+
>+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_diff_global_host_connect_to_local_vm_fails() {
>+	local oops_before warn_before
>+	local ns0="global0"
>+	local ns1="local0"
>+	local port=12345
>+	local dmesg_rc
>+	local pidfile
>+	local result
>+	local pid
>+
>+	init_namespaces
>+
>+	outfile=$(mktemp)
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns1}"; then
>+		log_host "failed to start vm (cid=${VSOCK_CID}, ns=${ns0})"
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns1}"
>+	oops_before=$(vm_dmesg_oops_count "${ns1}")
>+	warn_before=$(vm_dmesg_warn_count "${ns1}")
>+
>+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &

Should we wait for the listener here, like we do for TCP sockets?
(also in other place where we use VSOCK-LISTEN)

>+	echo TEST | ip netns exec "${ns0}" \
>+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
>+
>+	vm_dmesg_check "${pidfile}" "${ns1}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" == "TEST" ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_diff_global_vm_connect_to_global_host_ok() {
>+	local oops_before warn_before
>+	local ns0="global0"
>+	local ns1="global1"
>+	local port=12345
>+	local unixfile
>+	local dmesg_rc
>+	local pidfile
>+	local pids
>+	local rc
>+
>+	init_namespaces
>+
>+	declare -a pids
>+
>+	log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
>+
>+	unixfile=$(mktemp -u /tmp/XXXX.sock)
>+
>+	ip netns exec "${ns0}" \
>+		socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
>+	pids+=($!)
>+
>+	ip netns exec "${ns1}" \
>+		socat UNIX-LISTEN:"${unixfile}" TCP-CONNECT:127.0.0.1:"${port}" &
>+	pids+=($!)
>+
>+	log_host "Launching ${VSOCK_TEST} in ns ${ns1}"
>+	host_vsock_test "${ns1}" "server" "${VSOCK_CID}" "${port}"
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns0}"; then
>+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>+		terminate_pids "${pids[@]}"
>+		rm -f "${unixfile}"
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns0}"
>+
>+	oops_before=$(vm_dmesg_oops_count "${ns0}")
>+	warn_before=$(vm_dmesg_warn_count "${ns0}")
>+
>+	vm_vsock_test "${ns0}" "10.0.2.2" 2 "${port}"
>+	rc=$?
>+
>+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pids[@]}"
>+	rm -f "${unixfile}"
>+
>+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+
>+}
>+
>+test_ns_diff_global_vm_connect_to_local_host_fails() {
>+	local ns0="global0"
>+	local ns1="local0"
>+	local port=12345
>+	local oops_before warn_before
>+	local dmesg_rc
>+	local pidfile
>+	local result
>+	local pid
>+
>+	init_namespaces
>+
>+	log_host "Launching socat in ns ${ns1}"
>+	outfile=$(mktemp)
>+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT &> "${outfile}" &
>+	pid=$!
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns0}"; then
>+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>+		terminate_pids "${pid}"
>+		rm -f "${outfile}"
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns0}"
>+
>+	oops_before=$(vm_dmesg_oops_count "${ns0}")
>+	warn_before=$(vm_dmesg_warn_count "${ns0}")
>+
>+	vm_ssh "${ns0}" -- \
>+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
>+
>+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pid}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]] && [[ "${dmesg_rc}" -eq 0 ]]; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_diff_local_host_connect_to_local_vm_fails() {
>+	local ns0="local0"
>+	local ns1="local1"
>+	local port=12345
>+	local oops_before warn_before
>+	local dmesg_rc
>+	local pidfile
>+	local result
>+	local pid
>+
>+	init_namespaces
>+
>+	outfile=$(mktemp)
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns1}"; then
>+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns1}"
>+	oops_before=$(vm_dmesg_oops_count "${ns1}")
>+	warn_before=$(vm_dmesg_warn_count "${ns1}")
>+
>+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
>+	echo TEST | ip netns exec "${ns0}" \
>+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
>+
>+	vm_dmesg_check "${pidfile}" "${ns1}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]] && [[ "${dmesg_rc}" -eq 0 ]]; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_diff_local_vm_connect_to_local_host_fails() {
>+	local oops_before warn_before
>+	local ns0="local0"
>+	local ns1="local1"
>+	local port=12345
>+	local dmesg_rc
>+	local pidfile
>+	local result
>+	local pid
>+
>+	init_namespaces
>+
>+	log_host "Launching socat in ns ${ns1}"
>+	outfile=$(mktemp)
>+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT &> "${outfile}" &
>+	pid=$!
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns0}"; then
>+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>+		rm -f "${outfile}"
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns0}"
>+	oops_before=$(vm_dmesg_oops_count "${ns0}")
>+	warn_before=$(vm_dmesg_warn_count "${ns0}")
>+
>+	vm_ssh "${ns0}" -- \
>+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
>+
>+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pid}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]] && [[ "${dmesg_rc}" -eq 0 ]]; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+__test_loopback_two_netns() {
>+	local ns0=$1
>+	local ns1=$2
>+	local port=12345
>+	local result
>+	local pid
>+
>+	modprobe vsock_loopback &> /dev/null || :
>+
>+	log_host "Launching socat in ns ${ns1}"
>+	outfile=$(mktemp)
>+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
>+	pid=$!
>+
>+	log_host "Launching socat in ns ${ns0}"
>+	echo TEST | ip netns exec "${ns0}" socat STDIN VSOCK-CONNECT:1:"${port}" 2>/dev/null
>+	terminate_pids "${pid}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" == TEST ]]; then
>+		return 0
>+	fi
>+
>+	return 1
>+}
>+
>+test_ns_diff_global_to_local_loopback_local_fails() {
>+	init_namespaces
>+
>+	if ! __test_loopback_two_netns "global0" "local0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_diff_local_to_global_loopback_fails() {
>+	init_namespaces
>+
>+	if ! __test_loopback_two_netns "local0" "global0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_diff_local_to_local_loopback_fails() {
>+	init_namespaces
>+
>+	if ! __test_loopback_two_netns "local0" "local1"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_diff_global_to_global_loopback_ok() {
>+	init_namespaces
>+
>+	if __test_loopback_two_netns "global0" "global1"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_same_local_loopback_ok() {
>+	init_namespaces
>+
>+	if __test_loopback_two_netns "local0" "local0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_same_local_host_connect_to_local_vm_ok() {
>+	local oops_before warn_before
>+	local ns="local0"
>+	local port=1234
>+	local dmesg_rc
>+	local pidfile
>+	local rc
>+
>+	init_namespaces
>+
>+	pidfile="$(create_pidfile)"
>+
>+	if ! vm_start "${pidfile}" "${ns}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns}"
>+	oops_before=$(vm_dmesg_oops_count "${ns}")
>+	warn_before=$(vm_dmesg_warn_count "${ns}")
>+
>+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
>+	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
>+	rc=$?
>+
>+	vm_dmesg_check "${pidfile}" "${ns}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_same_local_vm_connect_to_local_host_ok() {

I don't understand the difference between this test and the previous one 
(test_ns_same_local_host_connect_to_local_vm_ok).

Maybe there is a copy/paste issue and we need to invert server/client.

Can you check?

>+	local oops_before warn_before
>+	local ns="local0"
>+	local port=1234
>+	local dmesg_rc
>+	local pidfile
>+	local rc
>+
>+	init_namespaces
>+
>+	pidfile="$(create_pidfile)"
>+
>+	if ! vm_start "${pidfile}" "${ns}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	vm_wait_for_ssh "${ns}"
>+	oops_before=$(vm_dmesg_oops_count "${ns}")
>+	warn_before=$(vm_dmesg_warn_count "${ns}")
>+
>+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
>+	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
>+	rc=$?
>+
>+	vm_dmesg_check "${pidfile}" "${ns}" "${oops_before}" "${warn_before}"
>+	dmesg_rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
> namespaces_can_boot_same_cid() {
> 	local ns0=$1
> 	local ns1=$2
>@@ -861,6 +1414,7 @@ fi
> check_args "${ARGS[@]}"
> check_deps
> check_vng
>+check_socat
> handle_build
>
> echo "1..${#ARGS[@]}"
>
>-- 
>2.47.3
>


