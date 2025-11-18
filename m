Return-Path: <netdev+bounces-239664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D61DC6B2AF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9555D4E3005
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B51E3612CB;
	Tue, 18 Nov 2025 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVeDAYrW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUx8QKNE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7183612E3
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489769; cv=none; b=rDXDkjar2sgGXyyBbaf2p/BqmoNKNbLfIs1CxZSFaf1fnYMttNvQL+xPLfZ+ngeO0YowGmJM8/Mwgx7t+iAftoEZBOD2e4j2xJjNzcd8FZCfe82Y+e7y11H1XDLlSV6M5OB1aJg2GhxyDch81898nVeCHaS4rXHTzkfu6rCEeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489769; c=relaxed/simple;
	bh=z9jngTjYXX2N3hDh12UT7kNeVGRmibW/GBVfuJWh90U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuAbYUEnHOUJWOcu+FIPo6PLsRF38M0LCu+t2cxsMcS8nneLafh+bAfLP63vKf5m+ummLrYgd6W6lKHdLon/x85oHCVyjQWz1ocPUYZxIm2R4eATnTF8AxGZ3P3SByCZCEKfcNB9AbU29tombrhTdN2JRU0a57/b0grxPXscJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVeDAYrW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUx8QKNE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PCsmT1+txPJIS2fQNp3IVXkXdkTCnaVV7j7GhmxtV/c=;
	b=MVeDAYrWio+sxriG6j3hOXlGnB4LCcD19keNlX0KPVji+32yJ2oFtFJb2TRdAr1Heo43Ck
	SLfRPQGrAybeKcMjiJIhnzcPVJeRVMPGyFI3CfnUgDU9YasZPv7M9eId5xXoaqIAnlAbTF
	gSjKZcDch9ydFxIk2Q0iJoEgK/DLT1k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-kxwPwj0BOC-HurkNp-r_ew-1; Tue, 18 Nov 2025 13:16:00 -0500
X-MC-Unique: kxwPwj0BOC-HurkNp-r_ew-1
X-Mimecast-MFC-AGG-ID: kxwPwj0BOC-HurkNp-r_ew_1763489759
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64160e4d78eso5191478a12.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489759; x=1764094559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCsmT1+txPJIS2fQNp3IVXkXdkTCnaVV7j7GhmxtV/c=;
        b=AUx8QKNErEgQv+mOvNtKSJyIqMXXtm+uHgDK9O1XHiF54XBZ0Spm52tcmMJz1xfwc8
         2RCqBZnEa0rhBRDCbGfIRWI2HBQziQQrGD2MtwZ29AMUpLC5UMjZanNs7NNRhQd0Ogwj
         zjuQXNhqjWiv/LdbN7snWjAN6XvekH1KP4KuFIiBmXHPSADxohoUjy5gf5+aPHBvR13V
         vz98b4x3syXPQ8M+ObY172k2odyTlg9MNDOhmS5tjch2WNMxLw8wAYvDTE6yO1R/1KPc
         dkwNhs56iukswuq+iyKiKqtt36fX0eW4tRwLRCxSoxf6OcKKsFfh+F32Dh6D68Wrs89A
         snMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489759; x=1764094559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCsmT1+txPJIS2fQNp3IVXkXdkTCnaVV7j7GhmxtV/c=;
        b=l/9Lv1hb/ZQDWrqrlWQhi0Wd91oSMVhPxIyJ7RwKHWndTClWXcbxy1cvY8fUAc491R
         aCJ2//HrzlIS0QTMnpu7B8tdpttgDp+lBq8v5KDlv3rxM7rTTfkwUgLZsNtzUme1EYhp
         0h6HJIiFC9zSTZE5CMX7JGyR+3JHFKrnltT31vC4MKE3ZCTWyq3nK4AqHnSQzmUw3C45
         6zEHh95kfjZXOui/C7Hf8m9dHx0Cv0GlExwPKYVd8X9hndx4sYLweHxCTyspLR8qfWyk
         bNJJcrKRaJAPO2Yao8YT7kDHPMZMim0vb0w2T3ycGMUfkjHxJc8bMdhS52oN83GYaiae
         amgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX59FxHEWfH/EjtsxScj9q9W6+yRjKuXqXKGhhO14wcBwVRyDmQfUsDr/Zl0B5A/eU0iRz7h7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN++U0zC6Y+ExemiV3gi6LQBUl1LEKHDiLGgbS8QrKDJnsxS0u
	ZXAbePq5Q5qAYF37oUKhfoeNGENcygfpL75dG2BAUdjHc2cF8hle1coYTpMOdj03Gz03PeU+mWa
	PMyhYwfMMTZoa+xBkrolCn3k9LpAmFPt5/zy9BxV445iyeqyPVHL9HVVH5g==
X-Gm-Gg: ASbGncuP+gHiWXquUvErs1lyMz5FhSacJ/7EHR+5EoKsCjXHzOxoU2z3MPlbfW0tLfD
	GD1Gc6703tjk3miI7mxfygKQG61aBBSEvwEAbuDAZXGJCyYa6aWmsDuMR5zUmEXJdrISaQ8IYP1
	I8Y/Meh2oMq644WeuYzfcpFGuefz/jcWKIqxs7B/rB7jpqQuw5LjlOK+oezvGRrjU9ORQ7wKWOM
	45e/1jlzex9yV80e++3OcoMEbCDp9/9HMIYvdYANbFTu1VWnYKT1sUl1ZiGSkk989FOmFlzpoQc
	C+ez8rZzM9NHYW5AFeeGou0QR+CYV5GngprQYOx7/GnWLF7ZLIEtx3Ts73dI/zoEvvXaj1c18gD
	MuyuD/+YwEndVqELfMxonlsksCQoKP/WytoIkCqwwlG5WbAvz0oxvj7uo69A=
X-Received: by 2002:a05:6402:42c4:b0:643:18c2:124e with SMTP id 4fb4d7f45d1cf-64350e0eedamr16148799a12.7.1763489758985;
        Tue, 18 Nov 2025 10:15:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoN0mxHlnHDgcN+NdZ5LOvg9qXOI9RJny5diigWO606GHOiHMHqYfRilSL5Y7K5784adc2+Q==
X-Received: by 2002:a05:6402:42c4:b0:643:18c2:124e with SMTP id 4fb4d7f45d1cf-64350e0eedamr16148731a12.7.1763489758430;
        Tue, 18 Nov 2025 10:15:58 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b28bbsm12919260a12.28.2025.11.18.10.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:15:56 -0800 (PST)
Date: Tue, 18 Nov 2025 19:15:50 +0100
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
Subject: Re: [PATCH net-next v10 11/11] selftests/vsock: add tests for
 namespace deletion and mode changes
Message-ID: <snj3w4fhh2az6wp6kf7ca3bgd6jp2aawvyic7thdnoktdumbx6@zmjqiorc2uda>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-11-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-11-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:34PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests that validate vsock sockets are resilient to deleting
>namespaces or changing namespace modes from global to local. The vsock
>sockets should still function normally.
>
>The function check_ns_changes_dont_break_connection() is added to re-use
>the step-by-step logic of 1) setup connections, 2) do something that
>would maybe break the connections, 3) check that the connections are
>still ok.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v9:
>- more consistent shell style
>- clarify -u usage comment for pipefile
>---
> tools/testing/selftests/vsock/vmtest.sh | 123 ++++++++++++++++++++++++++++++++
> 1 file changed, 123 insertions(+)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 9c12c1bd1edc..2b6e94aafc19 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -66,6 +66,12 @@ readonly TEST_NAMES=(
> 	ns_same_local_loopback_ok
> 	ns_same_local_host_connect_to_local_vm_ok
> 	ns_same_local_vm_connect_to_local_host_ok
>+	ns_mode_change_connection_continue_vm_ok
>+	ns_mode_change_connection_continue_host_ok
>+	ns_mode_change_connection_continue_both_ok
>+	ns_delete_vm_ok
>+	ns_delete_host_ok
>+	ns_delete_both_ok
> )
> readonly TEST_DESCS=(
> 	# vm_server_host_client
>@@ -135,6 +141,24 @@ readonly TEST_DESCS=(
>
> 	# ns_same_local_vm_connect_to_local_host_ok
> 	"Run vsock_test client in VM in a local ns with server in same ns."
>+
>+	# ns_mode_change_connection_continue_vm_ok
>+	"Check that changing NS mode of VM namespace from global to local after a connection is established doesn't break the connection"
>+
>+	# ns_mode_change_connection_continue_host_ok
>+	"Check that changing NS mode of host namespace from global to 
>local after a connection is established doesn't break the connection"
>+
>+	# ns_mode_change_connection_continue_both_ok
>+	"Check that changing NS mode of host and VM namespaces from global to local after a connection is established doesn't break the connection"
>+
>+	# ns_delete_vm_ok
>+	"Check that deleting the VM's namespace does not break the socket connection"
>+
>+	# ns_delete_host_ok
>+	"Check that deleting the host's namespace does not break the socket connection"
>+
>+	# ns_delete_both_ok
>+	"Check that deleting the VM and host's namespaces does not break the socket connection"
> )
>
> readonly USE_SHARED_VM=(
>@@ -1256,6 +1280,105 @@ test_ns_vm_local_mode_rejected() {
> 	return "${KSFT_PASS}"
> }
>
>+check_ns_changes_dont_break_connection() {
>+	local pipefile pidfile outfile
>+	local ns0="global0"
>+	local ns1="global1"
>+	local port=12345
>+	local pids=()
>+	local rc=0
>+
>+	init_namespaces
>+
>+	pidfile="$(create_pidfile)"
>+	if ! vm_start "${pidfile}" "${ns0}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+	vm_wait_for_ssh "${ns0}"
>+
>+	outfile=$(mktemp)
>+	vm_ssh "${ns0}" -- \
>+		socat VSOCK-LISTEN:"${port}",fork STDOUT > "${outfile}" 2>/dev/null &
>+	pids+=($!)
>+
>+	# wait_for_listener() does not work for vsock because vsock does not
>+	# export socket state to /proc/net/. Instead, we have no choice but to
>+	# sleep for some hardcoded time.
>+	sleep "${WAIT_PERIOD}"

can we use `ss --vsock --listening` ?

>+
>+	# We use a pipe here so that we can echo into the pipe instead of using
>+	# socat and a unix socket file. We just need a name for the pipe (not a
>+	# regular file) so use -u.
>+	pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)

Should we remove this file at the end of the test?

>+	ip netns exec "${ns1}" \
>+		socat PIPE:"${pipefile}" VSOCK-CONNECT:"${VSOCK_CID}":"${port}" &
>+	pids+=($!)
>+
>+	timeout "${WAIT_PERIOD}" \
>+		bash -c 'while [[ ! -e '"${pipefile}"' ]]; do sleep 1; done; exit 0'
>+
>+	if [[ $2 == "delete" ]]; then
>+		if [[ "$1" == "vm" ]]; then
>+			ip netns del "${ns0}"
>+		elif [[ "$1" == "host" ]]; then
>+			ip netns del "${ns1}"
>+		elif [[ "$1" == "both" ]]; then
>+			ip netns del "${ns0}"
>+			ip netns del "${ns1}"
>+		fi
>+	elif [[ $2 == "change_mode" ]]; then
>+		if [[ "$1" == "vm" ]]; then
>+			ns_set_mode "${ns0}" "local"
>+		elif [[ "$1" == "host" ]]; then
>+			ns_set_mode "${ns1}" "local"
>+		elif [[ "$1" == "both" ]]; then
>+			ns_set_mode "${ns0}" "local"
>+			ns_set_mode "${ns1}" "local"
>+		fi
>+	fi
>+
>+	echo "TEST" > "${pipefile}"
>+
>+	timeout "${WAIT_PERIOD}" \
>+		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done; exit 0'
>+
>+	if grep -q "TEST" "${outfile}"; then
>+		rc="${KSFT_PASS}"
>+	else
>+		rc="${KSFT_FAIL}"
>+	fi
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pids[@]}"
>+	rm -f "${outfile}"
>+
>+	return "${rc}"
>+}
>+
>+test_ns_mode_change_connection_continue_vm_ok() {
>+	check_ns_changes_dont_break_connection "vm" "change_mode"
>+}
>+
>+test_ns_mode_change_connection_continue_host_ok() {
>+	check_ns_changes_dont_break_connection "host" "change_mode"
>+}
>+
>+test_ns_mode_change_connection_continue_both_ok() {
>+	check_ns_changes_dont_break_connection "both" "change_mode"
>+}
>+
>+test_ns_delete_vm_ok() {
>+	check_ns_changes_dont_break_connection "vm" "delete"
>+}
>+
>+test_ns_delete_host_ok() {
>+	check_ns_changes_dont_break_connection "host" "delete"
>+}
>+
>+test_ns_delete_both_ok() {
>+	check_ns_changes_dont_break_connection "both" "delete"
>+}
>+
> shared_vm_test() {
> 	local tname
>
>
>-- 
>2.47.3
>


