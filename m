Return-Path: <netdev+bounces-239661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8203C6B267
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D638362AC0
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8835FF63;
	Tue, 18 Nov 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrxqIc0A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRGoU0qO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459313587AB
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489633; cv=none; b=uMnXMb1U6p85KQiKCwX1ydQ7wQSbclf96btxv/MQdNE7KQjhwRYH7kr/n0/SkJsugzZq3fE9QQsoismQakArhipORKNd0XvxHthvXCVB2EQ0vX+G09kAefs+ZvDOU5A2fFYfVdBsm4dd4b4unsSFh0tcxRDsJQQzb4b8LCeHRwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489633; c=relaxed/simple;
	bh=t3HokRBvzk92tWqhfXFr5XVYUp8FzOUrOhuoJpPP+58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMUm0j1kC84Yim130wCxbQOJR9REqW9Ma/dKsQQah47xbo3Isb758+ojrTg/zQTaJdG5WTN7F1GOa4UdK5FgkoItuaqkGVTNvsRQRri8uCsdd7M8K/C/C170dBXH4/H6W/2WT3BOZpE88GgxLhITwA/j4xcFXOw4IEEO8D+z8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrxqIc0A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRGoU0qO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cA4eJ9pim7VdQNrmudwFzP70yzHXe562WV92nI6SXhs=;
	b=RrxqIc0ANWWp4QhZm1rQo1Qd7Oy6bRkyG5HBWm9KaK5VexZ1AewVrQp3Bja3DjkuvsEpxA
	U1EoWuHhnaHWkYNNBXIwH/QVcdgRLm197bJIxquHkCjtyeY14FhZqm/Z91Yp0nz8R7grYN
	aeIS2T4eFj1BBSSG46od/F9p/lRHaXI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-CQ1faWqtPaSIzBCNEUGY7w-1; Tue, 18 Nov 2025 13:13:48 -0500
X-MC-Unique: CQ1faWqtPaSIzBCNEUGY7w-1
X-Mimecast-MFC-AGG-ID: CQ1faWqtPaSIzBCNEUGY7w_1763489627
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4776079ada3so57214455e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489627; x=1764094427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cA4eJ9pim7VdQNrmudwFzP70yzHXe562WV92nI6SXhs=;
        b=TRGoU0qOXQU59sd9K2fP/n2OpgYgX6vk4aAVcnK6n0PQLCVHrkDp8e4ccJuGIucWSp
         +wP4TRu3xEn7eVd2SxQRVijOMQaOUoklxK5v8PgBaXKFvPLuq4IeuQ2ZPtrSgZPgW908
         lyWelKTRtA0uC5MDuCXVkhqr3Z2w3v658u5zEpUB9ktjzE4GUpnAFWeCWyJ2mod1RDUt
         parzrgU6jAppwXYYgom3DVF4obWZoKkPGWjNknfxHFj2hHzxFVyobgdlbzdlfAfYs7co
         FplfLxKwERyMpF0W56IqeFCFqdgxrlZB3IZ75uzahJF7CBDlD67iTtrpbUdBjV8wU2Tg
         HO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489627; x=1764094427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA4eJ9pim7VdQNrmudwFzP70yzHXe562WV92nI6SXhs=;
        b=te6eJml0uVDqVqPHIYGOZwqoTz16H5dfXiPfLF55i4wAvBfFSCBadNAvuzFgLLbPbz
         oT1GYKqEeAw/Km78KpedPYHcwsd0nVrkU7STNrCO3sXFbgtcWbhSHHd1sUZP9Iy6nvTo
         0SfFGed83lW6GFn3KlCQqda/rQ1vwWuKiWdN/swm+nROP+DIH1PFtHnzhA5tZ53Rd0dN
         S5DYqNuc2p75S3jG6oPW17lgZdOi4T4220KPr9mI9AXvUEMu6LGYGpBMRf92Q/iR4Yvr
         z5UErcxnj99z6Ph/igYptLQkhdx25X+L9YqqZZ7sTXScaX83MgKZuPMvAUnjxp+K/eij
         /PgA==
X-Forwarded-Encrypted: i=1; AJvYcCXfQWg55I47E7QKAMbbpzAlp3eRnOJIsrN9BtrJfnHZAid1kgnGstCdISgcqIZn9tEjfAc3Bp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ed/ymzTi3KyVQxnmqL1Mm+VmqtCufVeKgHYjqzFcFDYI5nl6
	sWGvay4F2Zy4Ll7Hq9QI2Tf7G0uesuOAerTBSf1suulDIvInSlgRQgjZ0ATfRv+eg+mvdfLh+iV
	88oWdF6tonGCfandwFf1tGIaSTPwiiU4KfiFZMSKYY+kHhyn1uEnPRhzqBA==
X-Gm-Gg: ASbGncsAXWZHO3HUdNnHLWGYgqCtFqxWQ2AB01CuSHE6Pb139GYsXFBGekP5IyEXof2
	RwqFhX24P5h8M45cT22aIqlKlUn6GM9J+Y+Zw5itTjX6iXeykcSzrjOPJGk32dKunhpSPfiYHuk
	VU9X0M36nbLT9+ifYPOsMnpBiW0fFkD/yUJGc8CZ5jIoYriZHGva1mV7kWfVDuQI8kOzM07HGDX
	sZdRWMpfhZGR+U0iCbZ1D74fQorLaQ00PyRxrz1mYI53naMq9lRZ6etXedEAQn00DD4J1iHxW+R
	iRcp0ySrLXM9+YKl/5jt8RG3O1F8EJClG0MuCJOqdjKO6iMRel4EeKOe92rGpDksBsU5UDHBPB5
	rJpXkgbWF1tEwl7rIe07DzSrJrUf5usVtqIBNhd38Bh9rsmtazDKfw/dqUOk=
X-Received: by 2002:a05:600c:4fd2:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-4778fe4fa18mr162302405e9.2.1763489626897;
        Tue, 18 Nov 2025 10:13:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJW+/iuChgFRraW70MIR1TDXfcEwMvm+w71wLHAdMua0RyeIpmzX027JJ8Fn6LsaDHZf5jnw==
X-Received: by 2002:a05:600c:4fd2:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-4778fe4fa18mr162301985e9.2.1763489626387;
        Tue, 18 Nov 2025 10:13:46 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1022a32sm5350695e9.8.2025.11.18.10.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:13:45 -0800 (PST)
Date: Tue, 18 Nov 2025 19:13:31 +0100
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
Subject: Re: [PATCH net-next v10 08/11] selftests/vsock: add tests for proc
 sys vsock ns_mode
Message-ID: <4xfytzvgzk55cl4xbe7if56yodshsevfgvc34ubiwb5ozr6arn@nksp3rfq7jm6>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-8-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-8-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:31PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests for the /proc/sys/net/vsock/ns_mode interface.  Namely,
>that it accepts "global" and "local" strings and enforces a write-once
>policy.
>
>Start a convention of commenting the test name over the test
>description. Add test name comments over test descriptions that existed
>before this convention.
>
>Add a check_netns() function that checks if the test requires namespaces
>and if the current kernel supports namespaces. Skip tests that require
>namespaces if the system does not have namespace support.
>
>Add a test to verify that guest VMs with an active G2H transport
>(virtio-vsock) cannot set namespace mode to 'local'. This validates
>the mutual exclusion between G2H transports and LOCAL mode.
>
>This patch is the first to add tests that do *not* re-use the same
>shared VM. For that reason, it adds a run_tests() function to run these
>tests and filter out the shared VM tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v10:
>- Remove extraneous add_namespaces/del_namespaces calls.
>- Rename run_tests() to run_ns_tests() since it is designed to only
>  run ns tests.
>
>Changes in v9:
>- add test ns_vm_local_mode_rejected to check that guests cannot use
>  local mode
>---
> tools/testing/selftests/vsock/vmtest.sh | 140 +++++++++++++++++++++++++++++++-
> 1 file changed, 138 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 1a7c810f282f..86483249f490 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -41,14 +41,40 @@ readonly KERNEL_CMDLINE="\
> 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
> "
> readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
>-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly TEST_NAMES=(
>+	vm_server_host_client
>+	vm_client_host_server
>+	vm_loopback
>+	ns_host_vsock_ns_mode_ok
>+	ns_host_vsock_ns_mode_write_once_ok
>+	ns_vm_local_mode_rejected
>+)
> readonly TEST_DESCS=(
>+	# vm_server_host_client
> 	"Run vsock_test in server mode on the VM and in client mode on the host."
>+
>+	# vm_client_host_server
> 	"Run vsock_test in client mode on the VM and in server mode on the host."
>+
>+	# vm_loopback
> 	"Run vsock_test using the loopback transport in the VM."
>+
>+	# ns_host_vsock_ns_mode_ok
>+	"Check /proc/sys/net/vsock/ns_mode strings on the host."
>+
>+	# ns_host_vsock_ns_mode_write_once_ok
>+	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
>+
>+	# ns_vm_local_mode_rejected
>+	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
> )
>
>-readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly USE_SHARED_VM=(
>+	vm_server_host_client
>+	vm_client_host_server
>+	vm_loopback
>+	ns_vm_local_mode_rejected
>+)
> readonly NS_MODES=("local" "global")
>
> VERBOSE=0
>@@ -205,6 +231,20 @@ check_deps() {
> 	fi
> }
>
>+check_netns() {
>+	local tname=$1
>+
>+	# If the test requires NS support, check if NS support exists
>+	# using /proc/self/ns
>+	if [[ "${tname}" =~ ^ns_ ]] &&

If check_netns() is based on the test name, IMO we should document that 
on top of TEST_NAMES.

Thanks,
Stefano

>+	   [[ ! -e /proc/self/ns ]]; then
>+		log_host "No NS support detected for test ${tname}"
>+		return 1
>+	fi
>+
>+	return 0
>+}
>+
> check_vng() {
> 	local tested_versions
> 	local version
>@@ -503,6 +543,32 @@ log_guest() {
> 	LOG_PREFIX=guest log "$@"
> }
>
>+test_ns_host_vsock_ns_mode_ok() {
>+	for mode in "${NS_MODES[@]}"; do
>+		if ! ns_set_mode "${mode}0" "${mode}"; then
>+			return "${KSFT_FAIL}"
>+		fi
>+	done
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_host_vsock_ns_mode_write_once_ok() {
>+	for mode in "${NS_MODES[@]}"; do
>+		local ns="${mode}0"
>+		if ! ns_set_mode "${ns}" "${mode}"; then
>+			return "${KSFT_FAIL}"
>+		fi
>+
>+		# try writing again and expect failure
>+		if ns_set_mode "${ns}" "${mode}"; then
>+			return "${KSFT_FAIL}"
>+		fi
>+	done
>+
>+	return "${KSFT_PASS}"
>+}
>+
> test_vm_server_host_client() {
> 	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
> 		return "${KSFT_FAIL}"
>@@ -544,6 +610,26 @@ test_vm_loopback() {
> 	return "${KSFT_PASS}"
> }
>
>+test_ns_vm_local_mode_rejected() {
>+	# Guest VMs have a G2H transport (virtio-vsock) active, so they
>+	# should not be able to set namespace mode to 'local'.
>+	# This test verifies that the sysctl write fails as expected.
>+
>+	# Try to set local mode in the guest's init_ns
>+	if vm_ssh init_ns "echo local | tee /proc/sys/net/vsock/ns_mode &>/dev/null"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	# Verify mode is still 'global'
>+	local mode
>+	mode=$(vm_ssh init_ns "cat /proc/sys/net/vsock/ns_mode")
>+	if [[ "${mode}" != "global" ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
> shared_vm_test() {
> 	local tname
>
>@@ -576,6 +662,11 @@ run_shared_vm_tests() {
> 			continue
> 		fi
>
>+		if ! check_netns "${arg}"; then
>+			check_result "${KSFT_SKIP}" "${arg}"
>+			continue
>+		fi
>+
> 		run_shared_vm_test "${arg}"
> 		check_result "$?" "${arg}"
> 	done
>@@ -629,6 +720,49 @@ run_shared_vm_test() {
> 	return "${rc}"
> }
>
>+run_ns_tests() {
>+	for arg in "${ARGS[@]}"; do
>+		if shared_vm_test "${arg}"; then
>+			continue
>+		fi
>+
>+		if ! check_netns "${arg}"; then
>+			check_result "${KSFT_SKIP}" "${arg}"
>+			continue
>+		fi
>+
>+		add_namespaces
>+
>+		name=$(echo "${arg}" | awk '{ print $1 }')
>+		log_host "Executing test_${name}"
>+
>+		host_oops_before=$(dmesg 2>/dev/null | grep -c -i 'Oops')
>+		host_warn_before=$(dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
>+		eval test_"${name}"
>+		rc=$?
>+
>+		host_oops_after=$(dmesg 2>/dev/null | grep -c -i 'Oops')
>+		if [[ "${host_oops_after}" -gt "${host_oops_before}" ]]; then
>+			echo "FAIL: kernel oops detected on host" | log_host
>+			check_result "${KSFT_FAIL}" "${name}"
>+			del_namespaces
>+			continue
>+		fi
>+
>+		host_warn_after=$(dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
>+		if [[ "${host_warn_after}" -gt "${host_warn_before}" ]]; then
>+			echo "FAIL: kernel warning detected on host" | log_host
>+			check_result "${KSFT_FAIL}" "${name}"
>+			del_namespaces
>+			continue
>+		fi
>+
>+		check_result "${rc}" "${name}"
>+
>+		del_namespaces
>+	done
>+}
>+
> BUILD=0
> QEMU="qemu-system-$(uname -m)"
>
>@@ -674,6 +808,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
> 	terminate_pidfiles "${pidfile}"
> fi
>
>+run_ns_tests "${ARGS[@]}"
>+
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>
>-- 
>2.47.3
>


