Return-Path: <netdev+bounces-237954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F826C51FF4
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059803AB7AB
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB230C347;
	Wed, 12 Nov 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAs6Fmxc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVQiZmhU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ECF2D8DB1
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946843; cv=none; b=pOVoEo5YOVhjBC45jI3yNV4kst+5//k6rIOk13NfybkvgkjW0gFLfh50ZA9NkRaBq4qqmyLB47OWaXYd9fdrdxWnxw0ZJ8nO87oPUNz6inDzloScqFboYK9ZRH+htD6PBTXnizJxTvjY/f4y0P/i9nh08y6m8Ft8upLEqQINjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946843; c=relaxed/simple;
	bh=4GFpYouVGxOOz3psCxGWSSpIfASjL19wnjG0Y6Ssa1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddXESq9GKY+DYrEtLugl9GOueeHLwsnHOfJ2ftKtgHoLOz8kvaDKIlwAK1WB04l5rtw839Zl8ZSv6bG62ACD1NpruGGputB7zMUxPwg3G2pW4Wqsdb8DrgNe4tHNuEYEF4vyeIXz2irUXHsBY9bHSOSTpEHg5L4i4mGUxWyo6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAs6Fmxc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVQiZmhU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVtwZ9kMXMWaALslBegZBLpPlSTJZmxBrzThhFU7zE4=;
	b=JAs6FmxczLOe9kGN/JS3KoHxZ3f59VGcHRYA6KFvO1zDf9+CXkjL40/1ueaehjmsgjM5Dr
	owTCm20AhsBDT/XplV5jpoImydfWz8TLceQyoHthjnNgEOLu7FGrdeVuetNxPQuqtlHRtw
	BVQMByBgrLpDkLeslQ0q7hqCAX8TpVA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-p1NFpOp_O0KjrLWsgEF3Lg-1; Wed, 12 Nov 2025 06:27:19 -0500
X-MC-Unique: p1NFpOp_O0KjrLWsgEF3Lg-1
X-Mimecast-MFC-AGG-ID: p1NFpOp_O0KjrLWsgEF3Lg_1762946839
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b19a112b75so182554885a.1
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946838; x=1763551638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVtwZ9kMXMWaALslBegZBLpPlSTJZmxBrzThhFU7zE4=;
        b=AVQiZmhU8u0y8kKLuKhgICMGBOH5N1aaHyiKYKSEB9wdjDDuVWOE1+QieO3fPPLfaX
         mdG9r6W6RtDKl6yQgZar7wNXUcX6PPwz9MId3rwiNoxKHWbku0YEHsrs/3YK1m5XcWHI
         eBPEdsyMo4i7Ob/V1QKh6yU8MjuTgMf8q2kCS6O6CAm5b+qKiAfV4K4FeQgDfjWoHcn2
         o/s8/CFSZ0sAztih/FbjshJQgAMIh+p4ZUq1/XPcsnf+wgDeRn+VW067EyV6tQvll+4a
         5kgRjk2KB2Xq1d1xy6YxAmGuoyV5kKurLIrHd+V7dzD+8seAXdYulWrym85LOXT05S00
         VuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946838; x=1763551638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVtwZ9kMXMWaALslBegZBLpPlSTJZmxBrzThhFU7zE4=;
        b=gOQTYowj5pwFfjkC8zyFHqOTl94Aj4xiPv3rGtz9M/6wN2r231k2hfIneAOJxMPTHv
         Ub/RxXoV3JA76wkqGlivcPuXXPiKALGlNeo9muAt01PxqXV7P+50KX56Io9254msokEF
         pGELfK3r5pddDY6Tdr+FK23Xe+G8LtEbGLSyjru5IIVIc+Mo6EEChUxUG3iYyf4t2v0u
         0Xg6bsuA5RSl7eClQwwqSkya3mD+iBTIvrUFd5yybiRYiXrnBCmPkD4nKFpWni9gtV1m
         jG8RaO9dMzX4s06Jatq+8UsZYvmyzpmo9Ug7wZE2QX/ER1LNdcA3b4qytm8ZlbytcvDl
         Xk2g==
X-Forwarded-Encrypted: i=1; AJvYcCWqNtjQiev0vA2oIAtVAMhyB1q7rsIYXPdcXIHainD9n4S3GCxaklP4XrKxt6uRXQv+cXeI//U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkxLNg4xHirt8hepEWpWO0EQOc6NTeA/jNrNbQoCAMCAwDY+Q
	iOuOL4Yg0XH2jCBrSVDyahPYo1Npv1k/VLdgbF2f/Xbn9qrmIBBZyx94MNwss4o+4P7y2iQYPme
	qfxYyNLpBsRlrXukYfxRppaJYeFm6wOuCyhLixtj0xdE/Xh7vsxmwL4CWMw==
X-Gm-Gg: ASbGncvrFdWKlvFTOz9uFjEVJmnWlkVoFyNoX4Y+OuPafj3vp+60URawyY7Y4BO1Z7b
	UIoUAOYTwL9y2UXcVnRb21gdNvUdWnjlI7f2OzvNeXy5O1DuPQqNJzYh/imEzyZPxEUrq7B4t5H
	m5KNpvNlauPYQD5tKwbP8rUn4/1Ng7RKdkp10+AImiGCPfqhYf0BvEvl84mbCvl1SPdDgNNz0hR
	riK2wIYIw2OIwKFrEyA9KXmz9lHLMM2Hsk4QZ5/iWsT2YiMxiXTKbdSRp5KYKRFcMgUjg2I/kGL
	UOlXsEkehuZA97v+3rM5lmpO5P8Vd3PtS9Vc1LgHcOMKQ4Y8iZpmXpsNKSX4TR6WJn2yJkbgw+T
	N50V3pk+S36nREWiaIugF614sVw95xke0n2twjfOkAbM0MyOyn70=
X-Received: by 2002:a05:620a:7107:b0:8a7:2373:1c75 with SMTP id af79cd13be357-8b29b7cd25amr301639785a.49.1762946838677;
        Wed, 12 Nov 2025 03:27:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiq2o9VPSKEA3WnYmptOCbMHYXZ1Xc1tiIgbtvh2JnbBd2gww/tn2z5FSFACTcc8Z6rSWeNw==
X-Received: by 2002:a05:620a:7107:b0:8a7:2373:1c75 with SMTP id af79cd13be357-8b29b7cd25amr301636985a.49.1762946838217;
        Wed, 12 Nov 2025 03:27:18 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a84b075sm176497985a.7.2025.11.12.03.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:27:17 -0800 (PST)
Date: Wed, 12 Nov 2025 12:27:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Message-ID: <z2lxg6zlt5l3f2fhx6lwfeiu2tclm4o4et5wykraonyfjlayos@oatpvj3hk6om>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-8-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-8-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:59AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>In preparation for future patches that introduce tests that cannot
>re-use the same VM, add functions to identify those that *can* re-use a
>VM.
>
>By continuing to re-use the same VM for these tests we can save time by
>avoiding the delay of booting a VM for every test.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- fix botched rebase
>---
> tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
> 1 file changed, 50 insertions(+), 13 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 2dd9bbb8c4a9..a1c2969c44b6 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -46,6 +46,8 @@ readonly TEST_DESCS=(
> 	"Run vsock_test using the loopback transport in the VM."
> )
>
>+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+
> VERBOSE=0
>
> usage() {
>@@ -461,7 +463,44 @@ test_vm_loopback() {
> 	return "${KSFT_PASS}"
> }
>
>-run_test() {
>+shared_vm_test() {
>+	local tname
>+
>+	tname="${1}"
>+
>+	for testname in "${USE_SHARED_VM[@]}"; do
>+		if [[ "${tname}" == "${testname}" ]]; then
>+			return 0
>+		fi
>+	done
>+
>+	return 1
>+}
>+
>+shared_vm_tests_requested() {
>+	for arg in "$@"; do
>+		if shared_vm_test "${arg}"; then
>+			return 0
>+		fi
>+	done
>+
>+	return 1
>+}
>+
>+run_shared_vm_tests() {
>+	local arg
>+
>+	for arg in "$@"; do
>+		if ! shared_vm_test "${arg}"; then
>+			continue
>+		fi
>+
>+		run_shared_vm_test "${arg}"
>+		check_result "$?" "${arg}"
>+	done
>+}
>+
>+run_shared_vm_test() {
> 	local host_oops_cnt_before
> 	local host_warn_cnt_before
> 	local vm_oops_cnt_before
>@@ -537,23 +576,21 @@ handle_build
>
> echo "1..${#ARGS[@]}"
>
>-log_host "Booting up VM"
>-pidfile="$(create_pidfile)"
>-vm_start "${pidfile}"
>-vm_wait_for_ssh
>-log_host "VM booted up"
>-
> cnt_pass=0
> cnt_fail=0
> cnt_skip=0
> cnt_total=0
>-for arg in "${ARGS[@]}"; do
>-	run_test "${arg}"
>-	rc=$?
>-	check_result "${rc}" "${arg}"
>-done
>
>-terminate_pidfiles "${pidfile}"
>+if shared_vm_tests_requested "${ARGS[@]}"; then
>+	log_host "Booting up VM"
>+	pidfile="$(create_pidfile)"
>+	vm_start "${pidfile}"
>+	vm_wait_for_ssh
>+	log_host "VM booted up"
>+
>+	run_shared_vm_tests "${ARGS[@]}"
>+	terminate_pidfiles "${pidfile}"
>+fi

I was expecting something in case the VM couldn't be shared, but I think 
we'll add that later. It's fine for now.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>-- 
>2.47.3
>


