Return-Path: <netdev+bounces-184695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE3CA96E6A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB40440A79
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D359428A40E;
	Tue, 22 Apr 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+fXDe1B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1F428A406
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332001; cv=none; b=CLAPJE03w1nqahVYhziPF+OtDP2m+G2GoRqgfghqMoCGgV6/mrDfqvn4eMGBhJDri0BVxMpujFW1U71ZI2A/Vh9CclPpmrkaTl3l3P1a7rGqBJBRfWCcxH/8p7AB7nvRpIXe8RJGbyta0DcHmgqalKRBTqIzzXnJpl+RL1mAwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332001; c=relaxed/simple;
	bh=M6d1S89oQ8KKhSFBdUQlu8mYSr7uPlmGaYATeQ5gVA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvFh1uyw/2fsB+Z15IvGZTC4PoAaWGgFXd6HaCwnJnV+bNU4gT+GvWwBbb/35eXQi/nhq0ATGhfXX/UV1jh9CXxKWSy3R+qzFWbAFSWgt3fAZYpvY3KSio3m6+Y2BW8C5jbmksFmWOh4wumd+fnOAHU0nf+CkqkH6xmVWUWr3uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+fXDe1B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745331998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqPwMyeJhci4KUlqDI+gm8trymVFebxrwW5ZqMWRc8E=;
	b=O+fXDe1BELip9MHKRS/vEIBKqrbYaOYAE4GAta86IQOrzvEIluNlNe5B+yUzTd5WJszmqI
	KgLDI+QRQSRpYuwN8PZuOhEC2oB3nkJBvjbSkADAUmF5yRE79ueoxYlST+8+DSHYamxuOu
	Eu6n3RYIzZ/ddBLcTHvu7jdoiQGLZ48=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-X2i7OY-7N0-T64Q7EFoOIg-1; Tue, 22 Apr 2025 10:26:36 -0400
X-MC-Unique: X2i7OY-7N0-T64Q7EFoOIg-1
X-Mimecast-MFC-AGG-ID: X2i7OY-7N0-T64Q7EFoOIg_1745331995
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e6d978792dso4521176a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 07:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745331995; x=1745936795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqPwMyeJhci4KUlqDI+gm8trymVFebxrwW5ZqMWRc8E=;
        b=E7VDIwjtqGJ4q+T93ukvor6GlG3bNQj82QxD4xGMByCXnHH9m+vd3VZFqmAHasQFyM
         SILWCbdRTLhuGN5Do0Gl2ViDjIVszrcRmQP22T6/50WlJRulkElHhjGz/DhNUiAAhR2U
         +PrxT15YEFNivPLRe9N01xNSZxZ5y/MQvf51+mbyC1EvUaR599rtnqw69T6C33AbPtpn
         0MJfzVDR9nly3qm7uBSJEsT/cIV+1QYsFgoO40HxY8Ft5sfqditugoqOD9whrpY9wswf
         n7ErS+l5+L2fNd3a1rdOkT6Alq3r83o6iqRCPSJGInTUkgRvVJf+/oEWzC9m6p7diMdW
         i12A==
X-Forwarded-Encrypted: i=1; AJvYcCU2vGW8Anp0S36U8KoyALh1FPkKGbU51zL29DIz3kE8ICTgXPvmbxcuQZTmXsk7YvIwZ9Ny8B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3WoYfIhFLR31t0gmzUtop9xMhbKEfZgw7Jsg/I+TxO1u6bBL
	8xKREWK9J2jifxLbEfbpJP2hhwS+M4ja6iza8wVdQCI1TPjFCI9kIKiRORv5qRVETwjk2HCsF+5
	bjZxg+bNZcIgSa6wgi8pY9RtP8EMz+h1JY+Qgtrc2wZY2UIUXz6oKdg==
X-Gm-Gg: ASbGncs+LY4zyJWddKn/c0cdcUZN13qai9VtQUyqOfVGVK7JZOb6U+qg5bDDqaDnWQq
	x8VSJ+UGuooM/n1SlLmoYTkYAj2BDk2NSKDyQSxVIxzju7DaV6GbbVdmvWOzGNBxWqtkAEduGfS
	DT4k8S1nGB/PPj3KC9Dk3oA9lh8m8giVLL0m2B2iYLOtkBU4BWhEC4oieB/658dspukEIVsgj27
	+DgjcEPv9TCtm/KYz+qNcWE4rfoHNjNJW2OQX0VhLg/t7xD1OismOuw4P6Yz2W7jKnuSGfwoA1N
	Yv9C35WfY7JPyRE8
X-Received: by 2002:a05:6402:354a:b0:5f4:d605:7f5c with SMTP id 4fb4d7f45d1cf-5f6285e88ecmr15778317a12.22.1745331995016;
        Tue, 22 Apr 2025 07:26:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKjORuFshppR2yjmiSmezDLwuz8PRZXnGetSk/JwJMISEYBm3xAP4FBToVADLh2lmnIE8/TA==
X-Received: by 2002:a05:6402:354a:b0:5f4:d605:7f5c with SMTP id 4fb4d7f45d1cf-5f6285e88ecmr15778279a12.22.1745331994416;
        Tue, 22 Apr 2025 07:26:34 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f6255769besm6348822a12.24.2025.04.22.07.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:26:33 -0700 (PDT)
Date: Tue, 22 Apr 2025 16:26:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <tzgnx3ybadgrlzgdq5ps474xxsup4hlu6hsnyph67kiw3j2664@z5qx4aqtps4i>
References: <20250417-vsock-vmtest-v2-1-3901a27331e8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417-vsock-vmtest-v2-1-3901a27331e8@gmail.com>

On Thu, Apr 17, 2025 at 10:05:53PM -0700, Bobby Eshleman wrote:
>This commit introduces a new vmtest.sh runner for vsock.
>
>It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
>H2G, and loopback. The testing tools from tools/testing/vsock/ are
>reused. Currently, only vsock_test is used.
>
>VMCI and hyperv support is automatically built, though not used.
>
>Only tested on x86.
>
>To run:
>
>  $ tools/testing/selftests/vsock/vmtest.sh
>
>Future work can include vsock_diag_test.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>---
>Changes in v2:
>- add kernel oops and warnings checker
>- change testname variable to use FUNCNAME
>- fix spacing in test_vm_server_host_client
>- add -s skip build option to vmtest.sh
>- add test_vm_loopback
>- pass port to vm_wait_for_listener
>- fix indentation in vmtest.sh
>- add vmci and hyperv to config
>- changed whitespace from tabs to spaces in help string
>- Link to v1: https://lore.kernel.org/r/20250410-vsock-vmtest-v1-1-f35a81dab98c@gmail.com
>---
> MAINTAINERS                                |   1 +
> tools/testing/selftests/vsock/.gitignore   |   1 +
> tools/testing/selftests/vsock/config.vsock |  10 +
> tools/testing/selftests/vsock/vmtest.sh    | 306 +++++++++++++++++++++++++++++
> 4 files changed, 318 insertions(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index c3fce441672349f7850c57d788bc1a29b203fba5..f214cf7c4fb59ec67885ee6c81daa44e17c80f5f 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -25323,6 +25323,7 @@ F:	include/uapi/linux/vm_sockets.h
> F:	include/uapi/linux/vm_sockets_diag.h
> F:	include/uapi/linux/vsockmon.h
> F:	net/vmw_vsock/
>+F:	tools/testing/selftests/vsock/
> F:	tools/testing/vsock/
>
> VMALLOC
>diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/selftests/vsock/.gitignore
>new file mode 100644
>index 0000000000000000000000000000000000000000..1950aa8ac68c0831c12c1aaa429da45bbe41e60f
>--- /dev/null
>+++ b/tools/testing/selftests/vsock/.gitignore
>@@ -0,0 +1 @@
>+vsock_selftests.log
>diff --git a/tools/testing/selftests/vsock/config.vsock b/tools/testing/selftests/vsock/config.vsock
>new file mode 100644
>index 0000000000000000000000000000000000000000..9e0fb2270e6a2fc0beb5f0d9f0bc37158d0a9d23
>--- /dev/null
>+++ b/tools/testing/selftests/vsock/config.vsock
>@@ -0,0 +1,10 @@
>+CONFIG_VSOCKETS=y
>+CONFIG_VSOCKETS_DIAG=y
>+CONFIG_VSOCKETS_LOOPBACK=y
>+CONFIG_VMWARE_VMCI_VSOCKETS=y
>+CONFIG_VIRTIO_VSOCKETS=y
>+CONFIG_VIRTIO_VSOCKETS_COMMON=y
>+CONFIG_HYPERV_VSOCKETS=y
>+CONFIG_VMWARE_VMCI=y
>+CONFIG_VHOST_VSOCK=y
>+CONFIG_HYPERV=y
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>new file mode 100755
>index 0000000000000000000000000000000000000000..61dfcc06223fa7a30cb575cb3f2d01121b3ed3ce
>--- /dev/null
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -0,0 +1,306 @@
>+#!/bin/bash
>+# SPDX-License-Identifier: GPL-2.0
>+#
>+# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
>+#
>+# Dependencies:
>+#		* virtme-ng

Since it's the main tool used here (on my Fedora installing it,
installed all the dependencies). What about adding a check if the "vng"
command is available, otherwise failing suggesting to install it?

If it's not the usual way in self test, feel free to skip this
suggestion.

>+#		* busybox-static (used by virtme-ng)
>+#		* qemu	(used by virtme-ng)
>+
>+SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
>+KERNEL_CHECKOUT=$(realpath ${SCRIPT_DIR}/../../../..)
>+PLATFORM=${PLATFORM:-$(uname -m)}
>+
>+if [[ -z "${QEMU:-}" ]]; then
>+	QEMU=$(which qemu-system-${PLATFORM})

Where this variable is used?

Also, since we have other parameters, would it be better to use --qemu
for example to specify a path other than the default?

>+fi
>+
>+SKIP_BUILD=0
>+
>+VSOCK_TEST=${KERNEL_CHECKOUT}/tools/testing/vsock/vsock_test
>+
>+TEST_GUEST_PORT=51000
>+TEST_HOST_PORT=50000
>+TEST_HOST_PORT_LISTENER=50001
>+SSH_GUEST_PORT=22
>+SSH_HOST_PORT=2222
>+VSOCK_CID=1234
>+
>+QEMU_PIDFILE=/tmp/qemu.pid
>+
>+# virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
>+# control port forwarded for vsock_test.  Because virtme-ng doesn't support
>+# adding an additional port to forward to the device created from "--ssh" and
>+# virtme-init mistakenly sets identical IPs to the ssh device and additional
>+# devices, we instead opt out of using --ssh, add the device manually, and also
>+# add the kernel cmdline options that virtme-init uses to setup the interface.
>+QEMU_OPTS=""
>+QEMU_OPTS="${QEMU_OPTS} -netdev user,id=n0,hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
>+QEMU_OPTS="${QEMU_OPTS},hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
>+QEMU_OPTS="${QEMU_OPTS} -device virtio-net-pci,netdev=n0"
>+QEMU_OPTS="${QEMU_OPTS} -device vhost-vsock-pci,guest-cid=${VSOCK_CID}"
>+QEMU_OPTS="${QEMU_OPTS} --pidfile ${QEMU_PIDFILE}"
>+KERNEL_CMDLINE="virtme.dhcp net.ifnames=0 biosdevname=0 virtme.ssh virtme_ssh_user=$USER"
>+
>+LOG=${SCRIPT_DIR}/vsock_selftests.log
>+
>+#		Name				Description
>+tests="
>+	vm_server_host_client     Run vsock_test in server mode on the VM and in client mode on the host.
>+	vm_client_host_server     Run vsock_test in client mode on the VM and in server mode on the host.
>+	vm_loopback               Run vsock_test using the loopback transport in the VM.
>+"
>+
>+usage() {
>+	echo
>+	echo "$0 [OPTIONS]"
>+	echo
>+	echo "Options"
>+	echo "  -v: verbose output"
>+	echo "  -s: skip build"
>+	echo
>+	echo "Available tests${tests}"

“Available tests” made me think that we had a way to choose which tests
to run or if nothing was specified, run them all. But that doesn't seem
to be the case, so maybe better to rename it to something else or
support this.

Did you rely on any existing scripts? (If so, I would mention it in the
commit description).

>+	exit 1
>+}
>+
>+die() {
>+	echo "$*" >&2
>+	exit 1
>+}
>+
>+vm_ssh() {
>+	ssh -q -o UserKnownHostsFile=/dev/null -p 2222 localhost $*
>+	return $?
>+}
>+
>+cleanup() {
>+	if [[ -f "${QEMU_PIDFILE}" ]]; then
>+		pkill -9 -F ${QEMU_PIDFILE} 2>&1 >/dev/null
>+	fi
>+}
>+
>+build() {
>+	log_setup "Building kernel and tests"
>+
>+	pushd ${KERNEL_CHECKOUT} >/dev/null
>+	vng \
>+		--kconfig \
>+		--config ${KERNEL_CHECKOUT}/tools/testing/selftests/vsock/config.vsock
>+	make -j$(nproc)
>+	make -C ${KERNEL_CHECKOUT}/tools/testing/vsock
>+	popd >/dev/null
>+	echo
>+}
>+
>+vm_setup() {
>+	local VNG_OPTS=""
>+	if [[ "${VERBOSE}" = 1 ]]; then
>+		VNG_OPTS="--verbose"
>+	fi
>+	vng \
>+		$VNG_OPTS	\
>+		--run ~/local/linux \

this path doesn't exist on my machine, so I have:

   setup:	Booting up VM
   /home/stefano/local/linux does not exist
   Timed out waiting for guest ssh

>+		--qemu /bin/qemu-system-x86_64 \
>+		--qemu-opts="${QEMU_OPTS}" \
>+		--user root \
>+		--append "${KERNEL_CMDLINE}" \
>+		--rw  2>&1 >/dev/null &
>+}
>+
>+vm_wait_for_ssh() {
>+	i=0
>+	while [[ true ]]; do
>+		if (( i > 20 )); then
>+			die "Timed out waiting for guest ssh"
>+		fi
>+		vm_ssh -- true
>+		if [[ $? -eq 0 ]]; then
>+			break
>+		fi
>+		i=$(( i + 1 ))
>+		sleep 5

Can we have macro for this delay?

>+	done
>+}
>+
>+wait_for_listener() {
>+	local PORT=$1
>+	local i=0
>+	while ! ss -ltn | grep -q ":${PORT}"; do
>+		if (( i > 30 )); then
>+			die "Timed out waiting for listener on port ${PORT}"
>+		fi
>+		sleep 3

Ditto

>+		i=$(( i + 1 ))
>+	done
>+}
>+
>+vm_wait_for_listener() {
>+	local port=$1
>+	vm_ssh -- "$(declare -f wait_for_listener); wait_for_listener ${port}"
>+}
>+
>+host_wait_for_listener() {
>+	wait_for_listener ${TEST_HOST_LISTENER_PORT}
>+}
>+
>+log() {
>+	local prefix="$1"
>+	shift
>+
>+	if [[ "$#" -eq 0 ]]; then
>+		cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }' | tee -a ${LOG}
>+	else
>+		echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }' | tee -a ${LOG}
>+	fi
>+}
>+
>+log_setup() {
>+	log "setup" "$@"
>+}
>+
>+log_host() {
>+	testname=$1
>+	shift
>+	log "test:${testname}:host" "$@"
>+}
>+
>+log_guest() {
>+	testname=$1
>+	shift
>+	log "test:${testname}:guest" "$@"
>+}
>+
>+test_vm_server_host_client() {
>+	local testname="${FUNCNAME[0]#test_}"
>+
>+	vm_ssh -- "${VSOCK_TEST}" \
>+		--mode=server \
>+		--control-port="${TEST_GUEST_PORT}" \
>+		--peer-cid=2 \
>+		2>&1 | log_guest "${testname}" &
>+
>+	vm_wait_for_listener ${TEST_GUEST_PORT}
>+
>+	${VSOCK_TEST}	\

In same places we have "<tab><tab>\", in other just " \", both are fine,
with me but if you use tabs, try to align `\`, or just use a single
space. I'd also try to uniform: tabs or single space.

>+		--mode=client	\
>+		--control-host=127.0.0.1	\
>+		--peer-cid="${VSOCK_CID}"	\
>+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
>+
>+	rc=$?
>+}
>+
>+test_vm_client_host_server() {
>+	local testname="${FUNCNAME[0]#test_}"
>+
>+	${VSOCK_TEST}	\
>+		--mode "server" \
>+		--control-port "${TEST_HOST_PORT_LISTENER}" \
>+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
>+
>+	host_wait_for_listener
>+
>+	vm_ssh -- "${VSOCK_TEST}"	\
>+		--mode=client	\
>+		--control-host=10.0.2.2	\
>+		--peer-cid=2	\
>+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
>+
>+	rc=$?
>+}
>+
>+test_vm_loopback() {
>+	local testname="${FUNCNAME[0]#test_}"
>+	local port=60000 # non-forwarded local port
>+
>+	vm_ssh -- ${VSOCK_TEST}	\
>+		--mode=server \
>+		--control-port="${port}" \
>+		--peer-cid="${VSOCK_CID}" &

I'd use just --peer-cid=1 for loopback.

>+
>+	vm_wait_for_listener ${port}
>+
>+	vm_ssh -- ${VSOCK_TEST}	\
>+		--mode=client	\
>+		--control-host="127.0.0.1" \
>+		--control-port="${port}" \
>+		--peer-cid="${VSOCK_CID}"

Ditto.

>+
>+	rc=$?
>+}
>+
>+run_test() {
>+	unset IFS
>+	local host_oops_cnt_before=$(dmesg | grep -i 'Oops' | wc -l)
>+	local host_warn_cnt_before=$(dmesg --level=warn | wc -l)
>+	local vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
>+	local vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
>+
>+	name=$(echo "${1}" | awk '{ print $1 }')
>+	eval test_"${name}"
>+
>+	local host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
>+	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
>+		echo "${name}: kernel oops detected on host" | log_host ${name}
>+		rc=1
>+	fi
>+
>+	local host_warn_cnt_after=$(dmesg --level=warn | wc -l)
>+	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
>+		echo "${name}: kernel warning detected on host" | log_host ${name}
>+		rc=1
>+	fi
>+
>+	local vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
>+	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
>+		echo "${name}: kernel oops detected on vm" | log_host ${name}
>+		rc=1
>+	fi
>+
>+	local vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
>+	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
>+		echo "${name}: kernel warning detected on vm" | log_host ${name}
>+		rc=1
>+	fi
>+}
>+
>+while getopts :hvs o
>+do
>+	case $o in
>+	v) VERBOSE=1;;
>+	s) SKIP_BUILD=1;;
>+	h|*) usage;;
>+	esac
>+done
>+shift $((OPTIND-1))
>+
>+trap cleanup EXIT
>+
>+> ${LOG}
>+if (( SKIP_BUILD != 1 )); then
>+	build
>+fi
>+log_setup "Booting up VM"
>+vm_setup
>+vm_wait_for_ssh
>+log_setup "VM booted up"
>+
>+IFS="
>+"
>+cnt=0
>+for t in ${tests}; do
>+	rc=0
>+	run_test "${t}"
>+	if [[ ${rc} != 0 ]]; then
>+		cnt=$(( cnt + 1 ))
>+	fi
>+done
>+
>+if [[ ${cnt} = 0 ]]; then
>+	echo OK
>+else
>+	echo FAILED: ${cnt}
>+fi
>+echo "Log: ${LOG}"
>+exit ${cnt}
>
>---
>base-commit: cc04ed502457412960d215b9cd55f0d966fda255
>change-id: 20250325-vsock-vmtest-b3a21d2102c2
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@gmail.com>
>


