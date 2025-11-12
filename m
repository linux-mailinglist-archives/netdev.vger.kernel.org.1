Return-Path: <netdev+bounces-238024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68746C530BB
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB3FE541015
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EA033EAFD;
	Wed, 12 Nov 2025 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpjp/fgc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dE/eVZ9t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103B33DEF7
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958495; cv=none; b=PoYh5rPo8Y3pmxvvU8D1G1690k7PJCGmxXCiOrIJdm1qakifTOVRfZMEmdsg/K7QjO0UUz/EC2AJRJB4IsRpTnQNGM4tcY2g30gRE1Vh5tOIt9eM4c1Tx9NHMrmaZuLg3AyFp6VKTWNlQMrQZuLFb0BmziQu+QIoLvPdiZRk74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958495; c=relaxed/simple;
	bh=TDodib+DZd6+wcrvamz4Bkx/AnG7mEyHSEh0xxoCLHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ee6RZpcR+PKhrXIzsuCGF0w6Yg2knHRAdv5lLmgNhfC4nwyDb2FMKwz16mQK3BU5n/R1an6+yNlLjd7sEgeBjt32/SkPY2ase92d+VLrHmnvRT2KxmWPmFUqGXz4k1K47gJ6Wzv/D8in9fgcuKbVgVemMeGgrZZl6jKtBz+Hom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpjp/fgc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dE/eVZ9t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762958492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YgF5XOJVCvSo4xbeFnNtn2B9T9OShz14cXD3k7p95fU=;
	b=dpjp/fgcy6l4NmYsv9FKCRkKY1vCe0sOVfi2OjcReikVwCM2Bg8E1kAXj60k/WRFroPoFn
	HpbAjqzfLO7cDG9wRG17d1Nhb5smuRczubJDLZbtsbKCctM3EVQXgFYQVX4RXmGuj9iS/B
	8HFqdXXh+GuDauoSmmSdAIrRObPCTjA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-DY9pvlyBNranODpN0NXSgA-1; Wed, 12 Nov 2025 09:41:30 -0500
X-MC-Unique: DY9pvlyBNranODpN0NXSgA-1
X-Mimecast-MFC-AGG-ID: DY9pvlyBNranODpN0NXSgA_1762958490
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b1d8f56e24so239311285a.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 06:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762958490; x=1763563290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgF5XOJVCvSo4xbeFnNtn2B9T9OShz14cXD3k7p95fU=;
        b=dE/eVZ9thkmDhkMLCf/5YOUdUqqHsPKuBS5j+uGZ9K6V68mkXU1rDdFfCdM1CFRYiw
         lupTc38C/8Fd36gU9NZPF0G/BbEvDp2pbnXZkvbHukVIPQcbcIlUQ+K12K0WexuySEZX
         Aq04N/5/R6mHYyWubOX6DxXbFlWTCt5Gnt/+dlr/Gu3GVpKaE1kavb6EJPmMfKnRkQJW
         2INgzgldX2encu9QW/2z9o92avDbFbHjcohXhGqHlgIKA/6jbOqZ+F/+DhUhZ77KEUW9
         ZDpTESqZe8JrLb4jND948eLVgyUFxdjeJBdPoCd9ZHurf/KLyQkXyZBG9Whl3rHjsuQD
         MzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762958490; x=1763563290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgF5XOJVCvSo4xbeFnNtn2B9T9OShz14cXD3k7p95fU=;
        b=SciiZKyqbq6kzOtrj0X8AqKWV8rduYyR2GhWaDnab+gwntxc2KSysSc1GV1YtWG595
         GK74AOuYSdnw6gy/ago0fSTAoEKL5OHKTe4wbsRnEspPDNYSeXYuQ1lDb32tmPyvbb5j
         9FUm28s/au5WdLGw9zZoWRjrcAJq/xDBgHhOBDwLpEZjJG8xtpX4nK1+h+odNFBl9HWZ
         CDK/qDRp6cuN2VmbUYZj8nrR5eQxDu0KGb8Fs/vw7tZSRblYeck3nSrgVU9nr2GIni6+
         GNxAcnxTW2M37wIJvDVpwuiL5RPAwkeWjdC8bsk3juUD5vzY/4Q/f5k1U7k3YmSH8E4P
         tO9g==
X-Forwarded-Encrypted: i=1; AJvYcCWXTSUQZTMtMLAxFsrb2pBXbmOuNoRTKkUWeQvfbcnfY2tvUc9PPR2meTB3k4hDmu0pfIAlanY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhj3pbxo3xE0yrmIeVNZIEQ0zFdtf3BxMZQkRD+3Od0vjLV1B2
	oPOARA45CQZuqEoGPJ2ewRf/JXm0iO0Ap4geMQPCuL7pXJ96m+QXngsVhOH1UsEeP1L/UmDD/DK
	bcQEAIdfh0OpHrHc3ugKoXGe9sSc4k7WAtViPV6QYaZ9XySdv4Fm/qHa68w==
X-Gm-Gg: ASbGncuZxxR8ysqCWbIXmjFMNsvIWMWfRREligSrv4ok+G2vBgSdvdJng2A/mDyoVpr
	T5GSAWbjyZ4DO52CFlONEP4/gEsjX+XbFaHbCRz8tiZx03Egd7NiPoEb6CbMGTci2VvBvL9c3YM
	bcAYtuVJJwBsTwDDQ0tmHDO6T+7aDR4UKfgh2OOnb5oVbx/LtUKzyoa17wJo9VuKdsTrz8GQXDh
	5uddxI7vXv/2aZZN3CsxLuVEEm0vQcH1JXX/6ygFPCm97gl492w8/6oaRDRezcIPGSB0pScNLAL
	eV9SME9naKT9ZNE5aze3Ol5dxXr7CYaP8JBaQ4tfQ5IahpxmHaoC2b1ZfYaLoL/RNCYxokNeSjG
	EsEhZro9rfJyVRxk/6O5Jh7MRz/9cWCmMVmcnuzkX5lwe8O/Bbzs=
X-Received: by 2002:a05:620a:370e:b0:8b2:4a19:881f with SMTP id af79cd13be357-8b29b7649ccmr424657485a.29.1762958489404;
        Wed, 12 Nov 2025 06:41:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAxwJ06ScQZOrSAKaHN+tdx6s7DKjmYnbHPCAgBLzkrBYXoRsdJglGU1gKWLjPqmNEQ9AEmA==
X-Received: by 2002:a05:620a:370e:b0:8b2:4a19:881f with SMTP id af79cd13be357-8b29b7649ccmr424651485a.29.1762958488718;
        Wed, 12 Nov 2025 06:41:28 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9ff16fsm200475785a.41.2025.11.12.06.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:41:28 -0800 (PST)
Date: Wed, 12 Nov 2025 15:41:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 13/14] selftests/vsock: add tests for host
 <-> vm connectivity with namespaces
Message-ID: <7yhu6bdhqyueh6l3svxfxpg33jgibdbjrhxksccsrjp5efdsyk@jzicgr2ywlrx>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-13-852787a37bed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251111-vsock-vmtest-v9-13-852787a37bed@meta.com>

On Tue, Nov 11, 2025 at 10:54:55PM -0800, Bobby Eshleman wrote:
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
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v9:
>- consistent variable quoting
>---
> tools/testing/selftests/vsock/vmtest.sh | 463 +++++++++++++++++++++++++++++++-
> 1 file changed, 461 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index cc8dc280afdf..111059924287 100755
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
>@@ -573,6 +648,389 @@ test_ns_host_vsock_ns_mode_ok() {
> 	return "${KSFT_PASS}"
> }
>
>+test_ns_diff_global_host_connect_to_global_vm_ok() {
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
>+	unixfile=$(mktemp -u /tmp/XXXX.sock)
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
>+	for pid in "${pids[@]}"; do
>+		if [[ "$(jobs -p)" = *"${pid}"* ]]; then
>+			kill -SIGTERM "${pid}" &>/dev/null
>+		fi
>+	done
>+

In run_shared_vm_test() we are also checking oops, warn in both host and 
VM, should we do the same here in each no-shared test that boot a VM?

I mean, should we generalize run_shared_vm_test() and use it for both 
kind of tests?

Stefano

>+	terminate_pidfiles "${pidfile}"
>+
>+	if [[ "${rc}" -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_diff_global_host_connect_to_local_vm_fails() {
>+	local ns0="global0"
>+	local ns1="local0"
>+	local port=12345
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
>+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
>+	echo TEST | ip netns exec "${ns0}" \
>+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]]; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_diff_global_vm_connect_to_global_host_ok() {
>+	local ns0="global0"
>+	local ns1="global1"
>+	local port=12345
>+	local unixfile
>+	local pidfile
>+	local pids
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
>+	vm_vsock_test "${ns0}" "10.0.2.2" 2 "${port}"
>+	rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pids[@]}"
>+	rm -f "${unixfile}"
>+
>+	if [[ ! $rc -eq 0 ]]; then
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
>+	vm_ssh "${ns0}" -- \
>+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pid}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]]; then
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
>+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
>+	echo TEST | ip netns exec "${ns0}" \
>+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]]; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_diff_local_vm_connect_to_local_host_fails() {
>+	local ns0="local0"
>+	local ns1="local1"
>+	local port=12345
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
>+
>+	vm_ssh "${ns0}" -- \
>+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
>+
>+	terminate_pidfiles "${pidfile}"
>+	terminate_pids "${pid}"
>+
>+	result=$(cat "${outfile}")
>+	rm -f "${outfile}"
>+
>+	if [[ "${result}" != TEST ]]; then
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
>+	local ns="local0"
>+	local port=1234
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
>+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
>+	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
>+	rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	if [[ $rc -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_same_local_vm_connect_to_local_host_ok() {
>+	local ns="local0"
>+	local port=1234
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
>+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
>+	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
>+	rc=$?
>+
>+	terminate_pidfiles "${pidfile}"
>+
>+	if [[ $rc -ne 0 ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
> namespaces_can_boot_same_cid() {
> 	local ns0=$1
> 	local ns1=$2
>@@ -851,6 +1309,7 @@ fi
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


