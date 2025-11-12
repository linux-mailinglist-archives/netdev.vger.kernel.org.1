Return-Path: <netdev+bounces-237946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE2CC51F0D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7FC18E0A94
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2FE3009D2;
	Wed, 12 Nov 2025 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMO8Lprp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oUWVdXcu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF1274B28
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946396; cv=none; b=Ilo0uiOf/uj0oa3vxKpfMiSIx8UZWxaU1oeIlSkEMbkVZc9trcl7Wi6SjETLvdg8fB69kKXolfbkd8BJC0Gd0SH3gjxP0r3GwdtlNTp2XQaG0dLGc9IKw/VbePo1qMp8s1EVMIeh2bzwtMQWwMEULUBE8wi0d4zKVH08ZPv3UG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946396; c=relaxed/simple;
	bh=OKClyKv8Ey4yyuKqx+8b/7B4wt73VZkmnz6uZGpZgUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBIqS+gra4KIJtKaPYuHPmWc7rBIabjV3EFdfrEtBxT38XwRLLu3W3XGMkDFLDchBScsOgLfDntu1uXeiq8box4cFd+6vg/x8aiQCandL9XNVmLXKuHBcU2SiI1Xnf/zwk2DxR6otOhxGXlod51l5CITO3ni/hx+7Ke3efdp96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMO8Lprp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oUWVdXcu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5FDYwKVcD0dlATlv10YwLZFZcLbAZEaa4NsDrv83O14=;
	b=DMO8LprpeCMvGkiN1r2bMLNGq4XPClpPe1sKWaXDoTh+SeS096bb9V8UhnKS4i510hSXUT
	z35WTYT0vv+iLm5rRR2hg1QC/IUp2NMTpqZXtLviB9E/cy0LIdxyuM+onKozulBZaU6BvP
	I8/z31aEvgo2AdguN1ZFQHks3R7QmCE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-C3lABX7DMb6yW6FuTtG5Jg-1; Wed, 12 Nov 2025 06:19:52 -0500
X-MC-Unique: C3lABX7DMb6yW6FuTtG5Jg-1
X-Mimecast-MFC-AGG-ID: C3lABX7DMb6yW6FuTtG5Jg_1762946392
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b29da49583so141020585a.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946392; x=1763551192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5FDYwKVcD0dlATlv10YwLZFZcLbAZEaa4NsDrv83O14=;
        b=oUWVdXcuWlLdzSqM9bBs5gBvaZTB4jI8NQYQ7uwfDWEMuSVP8cQuE6OvPFne3IJYxH
         T2GNbC0iy7uXB2IpFxfxAh/dDxyh85SlEhBHGT9RoHsrR0b7BvLMwbE85+lYgzNvPfx2
         bbF/CIq0pvXXqzzIJmszgUNsB0MJj/VnnaxPIJFZM64lYBpt7p9dW25rnvQF4edmEm3Y
         bLTBYHRkOhEtGj4GV9CGNV+yQl4gwRca8yXIzMHW2jx8A7T9sHByWP3y+D1/k4xwb4RY
         UIQ/5S1x0eBsn8BnwSoNWIHa6l/w7QE2ckyjNU9qHVLv7aUV6fqGd9wgjt9/8sawTCcV
         4a6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946392; x=1763551192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FDYwKVcD0dlATlv10YwLZFZcLbAZEaa4NsDrv83O14=;
        b=RLvMhPtTMWvvhWdo7ohAOiUUGDP4wpBbZgy+zbIIC2Td+yMRONaYSgVKdU1gLFJvM7
         ZgoM0C6fTOk/4xA65KRuZV2wSyNDJzTBnUjtBqTxlcHQ1ENvS0Glzc/bSmjqj9P0xbCv
         2h5Z/aiWoouGOxCrd6p/CsNqalU939pgAqNhPJnX2Tj8maGcwQx8FcUe5KYo9QoL6HBn
         YOAJl8Fr344wxFf4Z2HEoiqFWUBbMq3hXqpjxhwD42R7eb4r4qjWWHZ5PJkhLqc+QzUF
         mI2NPjJyP1GkmwIpHRiswKOBOY76eG2uzAqEohBoDPjHxPd05z8G554tCJiV0HmVaTl3
         1M3g==
X-Forwarded-Encrypted: i=1; AJvYcCWtq65XxhOmF/ZSEAPsVHeSWBAU4fRH7hjp+smtZQd55RCULFkOIbmiIZzCTpk5woRoOIYgQwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjEmTvu86lmcJmmLqvOiTGyTZ0UWX5h3Vz87JB/dSLHk5v7JH
	74i2lvwEyhEYxMpcfRZ5PUO0nJJYoV6QQgHX5vETQSwBaBMTrLFFJowkDOXdp91Ur9jbN7cziRD
	4CEQkTdjeLLuZu3vgC5irL0rc0wRt6ieG57rJEzu2Q4lYI2Bx+0cvVph1Tw==
X-Gm-Gg: ASbGncvviKT5SZfvmCEp9ruxz3S2x5vGUsT18vqEybIvtnQeoQklFXrk/04TE4pIsqT
	qinK5ItJkutQ3mCwUk/oa/HswnhbXSjuyIS/kZ+56BJPf/cdyxwe9khFo0Hq2JWJeMPwDV9kwmp
	/0ZJ5u0Vv6d1LHVWfqy72Rrd02FS31/AqolVlyw2A2HcMsAiFET1IcFe485bpeLCnrBq/klQrLw
	v5/Hrt2vg58fNS5N/4BncOSMJvKFHDsEbpVYWx/ikbBDJRVEqpevhJsDZPzw0DFSfpm5xbV5F2B
	+8mM23+tNfrrGbHhlYgmsaKOd7/7zoVltvw58ob1dILoAgGtIlqVOnccCDgSUpgBBWRib01pn+n
	UfNvl2F4O19laqt2jXhpla+ahI24KV2o/OkmRqXcECpThj6NkBz0=
X-Received: by 2002:a05:620a:199f:b0:8b2:1fa8:4684 with SMTP id af79cd13be357-8b29b567d9dmr336594285a.2.1762946392106;
        Wed, 12 Nov 2025 03:19:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJO/67hI3KgrbQB/aVYyZeSEB0IiwCxk5hDgSYA6vjxGWk6oN9tzaQ+qo21OHmRNB+WCUySA==
X-Received: by 2002:a05:620a:199f:b0:8b2:1fa8:4684 with SMTP id af79cd13be357-8b29b567d9dmr336591285a.2.1762946391690;
        Wed, 12 Nov 2025 03:19:51 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e6f2fsm171012785a.33.2025.11.12.03.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:19:50 -0800 (PST)
Date: Wed, 12 Nov 2025 12:19:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <ydpi67iu224lkrmwzq7ibpupnllvwhsdp4nxtmdjsoyvotsdug@p3rtp4f4fulg>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-3-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-3-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:54AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
>the vsock_test binary. This encapsulates several items of repeat logic,
>such as waiting for the server to reach listening state and
>enabling/disabling the bash option pipefail to avoid pipe-style logging
>from hiding failures.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- remember to disable pipefail before returning from host_vsock_test()
>
>Changes in v3:
>- Add port input parameter to host_wait_for_listener() to accept port
>  from host_vsock_test() (Stefano)
>- Change host_wait_for_listener() call-site to pass in parameter
>---
> tools/testing/selftests/vsock/vmtest.sh | 135 ++++++++++++++++++++++----------
> 1 file changed, 95 insertions(+), 40 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 01ce16523afb..3bccd9b84e4a 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -272,8 +272,81 @@ EOF
> }
>
> host_wait_for_listener() {
>-	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+	local port=$1
>
>+	wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+}
>+
>+vm_vsock_test() {
>+	local host=$1
>+	local cid=$2
>+	local port=$3
>+	local rc
>+
>+	# log output and use pipefail to respect vsock_test errors
>+	set -o pipefail
>+	if [[ "${host}" != server ]]; then
>+		vm_ssh -- "${VSOCK_TEST}" \
>+			--mode=client \
>+			--control-host="${host}" \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" \
>+			2>&1 | log_guest
>+		rc=$?
>+	else
>+		vm_ssh -- "${VSOCK_TEST}" \
>+			--mode=server \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" \
>+			2>&1 | log_guest &
>+		rc=$?
>+
>+		if [[ $rc -ne 0 ]]; then
>+			set +o pipefail
>+			return $rc
>+		fi
>+
>+		vm_wait_for_listener "${port}"
>+		rc=$?
>+	fi
>+	set +o pipefail
>+
>+	return $rc
>+}
>+
>+host_vsock_test() {
>+	local host=$1
>+	local cid=$2
>+	local port=$3
>+	local rc
>+
>+	# log output and use pipefail to respect vsock_test errors
>+	set -o pipefail
>+	if [[ "${host}" != server ]]; then
>+		${VSOCK_TEST} \
>+			--mode=client \
>+			--peer-cid="${cid}" \
>+			--control-host="${host}" \
>+			--control-port="${port}" 2>&1 | log_host
>+		rc=$?
>+	else
>+		${VSOCK_TEST} \
>+			--mode=server \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" 2>&1 | log_host &
>+		rc=$?
>+
>+		if [[ $rc -ne 0 ]]; then
>+			set +o pipefail
>+			return $rc
>+		fi
>+
>+		host_wait_for_listener "${port}"
>+		rc=$?
>+	fi
>+	set +o pipefail
>+
>+	return $rc
> }
>
> log() {
>@@ -312,59 +385,41 @@ log_guest() {
> }
>
> test_vm_server_host_client() {
>+	if ! vm_vsock_test "server" 2 "${TEST_GUEST_PORT}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=server \
>-		--control-port="${TEST_GUEST_PORT}" \
>-		--peer-cid=2 \
>-		2>&1 | log_guest &
>-
>-	vm_wait_for_listener "${TEST_GUEST_PORT}"
>-
>-	${VSOCK_TEST} \
>-		--mode=client \
>-		--control-host=127.0.0.1 \
>-		--peer-cid="${VSOCK_CID}" \
>-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
>+	if ! host_vsock_test "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	return $?
>+	return "${KSFT_PASS}"
> }
>
> test_vm_client_host_server() {
>+	if ! host_vsock_test "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	${VSOCK_TEST} \
>-		--mode "server" \
>-		--control-port "${TEST_HOST_PORT_LISTENER}" \
>-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
>-
>-	host_wait_for_listener
>-
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=client \
>-		--control-host=10.0.2.2 \
>-		--peer-cid=2 \
>-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
>+	if ! vm_vsock_test "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	return $?
>+	return "${KSFT_PASS}"
> }
>
> test_vm_loopback() {
> 	local port=60000 # non-forwarded local port
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=server \
>-		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest &
>-
>-	vm_wait_for_listener "${port}"
>+	if ! vm_vsock_test "server" 1 "${port}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=client \
>-		--control-host="127.0.0.1" \
>-		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest
>+	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	return $?
>+	return "${KSFT_PASS}"
> }
>
> run_test() {
>
>-- 
>2.47.3
>


