Return-Path: <netdev+bounces-235819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E59C36127
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 15:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6134188F7BA
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6333232D0F4;
	Wed,  5 Nov 2025 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YA6Oxx+Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lX/HD8u9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14896325718
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353154; cv=none; b=Hc+kEb3g21FPtqn/D6TXGvcpKfOceedp4GnnW6Le5G5oJeIXv8MZ08MVHiMXN9gtXC/y53wdrnXtGcdklNk8iQ1woq6T76ZUXSwccMtO7nw8J2EmlLqr8Q9+4VSyhcKnH4VGDiy3UPuGEOEnC5TmxhJrSVpD/8dXi4HxttMhKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353154; c=relaxed/simple;
	bh=RRH8LLT4tnEW2zr9zEsEkvqzLS8Y6JH+rXqaTOe68tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giWCzA/yNYX/n8/ibqydyWpX/r3jrOsE84OtrYA7aOr3Xi0vdNIvSwDFN03DRSOLgzg6VWa6eQzSG4cwCbwC04SCokcmzk96xxJFp9VUWb0iiOrpoj+1gEqlIpaZ8SxGJ19CX/sovZEJSu+khBXTH3qUWjYa/fP1XFy58H4VNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YA6Oxx+Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lX/HD8u9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762353149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kX3VzHZS/HGSzq6tZ4+jI+/5hajDd1Zm9Mx0FurYGLQ=;
	b=YA6Oxx+QR3BshDQUmyj+5twuG1vM1h5IusjFmx1QHZYecaIOiHsxzsn8q3duVtjoZ8mRaA
	qkmDDUztC+SqM2ziMa83Y51447n6ZqTJnt5FERd/oalU/tnjJKHswvFAdBYsEakLcWWP7y
	j3J6OIzOkCx/DFVUtbfSmkc54j+H6UA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-z43wr6BKPamtg2VQyurJjQ-1; Wed, 05 Nov 2025 09:32:28 -0500
X-MC-Unique: z43wr6BKPamtg2VQyurJjQ-1
X-Mimecast-MFC-AGG-ID: z43wr6BKPamtg2VQyurJjQ_1762353147
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47740c1442dso33245445e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 06:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762353147; x=1762957947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kX3VzHZS/HGSzq6tZ4+jI+/5hajDd1Zm9Mx0FurYGLQ=;
        b=lX/HD8u9AR9U/Ep9PpVlNwmA1tKoTONwTzUbF4DXMYq5vPRzCkhGBibl3cOt7lS7CP
         QfcBFq6bfYtNnefmPtWkCMLIYZMJn3m35vmS+7q9ehqDVeN+riMZ1X5TzlingFIRx7pS
         SoYsjxjXtxERIvpGHe3xMX2Jaxj2s7T6C13l/TK6ZTPjv2XI7yntrgWRNv37QFk/mmWf
         Fmuf8dAfC2qIHFLOVHhfv1cIrzxJwKv7v+cTIQffqeWISuWWKi1WLIyuePG+GsV85vcl
         2USWT2kBufXZ2ml5nYvm7aJ3WC7bp4wnpSJtU/GuVFWCwwmy/pNLZQdNliLOoyqYOpWb
         8XaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353147; x=1762957947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX3VzHZS/HGSzq6tZ4+jI+/5hajDd1Zm9Mx0FurYGLQ=;
        b=dxfngvZHGNsYjubwQkU6YUStB8M2bB4fOc2QP3lJ0he3/tTaGp2YJYOZzSl0/0lQ4x
         GzRFxH9STdX/+fMKz/YUWJW1mahhP6/WV/I4I7GQ6PpC8ROZtK2lSfZBHK2yxd7V0wDG
         4joz5nSGRkP93YQkgab6eWuXnrKNJ1S46KDXFp7qttNTT28DvqDyvCdK3rEWxlp2CExn
         oNYXuFWQdDr2lbhCl1/BhUSB+8Og7BQCEIQ7R/TOqSQ2XoE/HL5HsNwX0Zy4A3gkyn+l
         HAwZg6iXGnRZDinGQP47Z5xX0q4hsHuApINl69QSqgy8bV7ilIeANjlsZteIka46lIL2
         18wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnLmDdyGWozTsj0ICOhwZO8q3/ILxMdQXiCaWbPmBmjbOiPco879WyZgN47LhBZIEzCslg9XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJdtZGAFrCoPXpW+c3Tiy6d9CypBDBEiYbAp3IHz+rzrybyZiv
	OW/7gb5FTgJvHLu1QGXo6hNMPE3c8w92MV1SQIJv02EqHCcxWfnJ1On/ftiiVVbUucnorfuI+jQ
	IGZ6v8U8eFzyj57+nXzWU8OzDIxH3N2BvPb+y1lblOeJ3To0M5y9CPJDOhA==
X-Gm-Gg: ASbGncu5Q45m6D+QbS6rH4iMh7VNay8msYzzm/jCNPGwHpp68uQ+8WjZHsm+4S/sQZj
	gkFVyrnXMb/cxkDhCGY2hIIEaLVo6saDzQ2XlJQ75HcHcQJ6LQFOSi+nDcEmHtKDDckuw5h0KIC
	VDESwOj3xgSWCMbwdBEcT9OWGm9N9x6+rNFtO0MD40KGkfg/to5mz2wIEtUqp07PE5qO7Olpx11
	kzToPvCQDKmyHimXyGX/t8Pgd+knXSqxLJHr2DDYPQ/BHOw7N0Imz00qzkE8GnFXvz9o12imm5m
	37RL/gaLnfHQ8QxuDt4yL4fSE0qc/HmsaF1+DagqacxML3H/iRMv4S8LcXkj/sdNfVvPSjoKnlY
	=
X-Received: by 2002:a05:600c:8b88:b0:471:145b:dd0d with SMTP id 5b1f17b1804b1-4775cde3b1cmr24454625e9.24.1762353147137;
        Wed, 05 Nov 2025 06:32:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWyogJkKQrbfKs51nTFgSZd3l651tt4j8gql/Hcm4StJEJE6IWfnkUPmlhXIXKjxU9KUzKHg==
X-Received: by 2002:a05:600c:8b88:b0:471:145b:dd0d with SMTP id 5b1f17b1804b1-4775cde3b1cmr24454345e9.24.1762353146660;
        Wed, 05 Nov 2025 06:32:26 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558d983fsm43454025e9.8.2025.11.05.06.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:32:25 -0800 (PST)
Date: Wed, 5 Nov 2025 15:32:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 04/12] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <3osszz3giogog7jzs37pdqhakcrveayrqu6xduztuwrftkwrad@gjj3cyvmypw3>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-4-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-4-ca2070fd1601@meta.com>

On Tue, Nov 04, 2025 at 02:38:54PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Change QEMU to use generated pidfile names instead of just a single
>globally-defined pidfile. This allows multiple QEMU instances to
>co-exist with different pidfiles. This is required for future tests that
>use multiple VMs to check for CID collissions.
>
>Additionally, this also places the burden of killing the QEMU process
>and cleaning up the pidfile on the caller of vm_start(). To help with
>this, a function terminate_pidfiles() is introduced that callers use to
>perform the cleanup. The terminate_pidfiles() function supports multiple
>pidfile removals because future patches will need to process two
>pidfiles at a time.
>
>Change QEMU_OPTS to be initialized inside the vm_start(). This allows the
>generated pidfile to passed to the string assignment, and prepares for
>future vm-specific options as well (e.g., cid).
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v2:
>- mention QEMU_OPTS changes in commit message (Simon)
>---
> tools/testing/selftests/vsock/vmtest.sh | 53 +++++++++++++++++++--------------
> 1 file changed, 30 insertions(+), 23 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 03dc4717ac3b..5637c98d5fe8 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -23,7 +23,7 @@ readonly VSOCK_CID=1234
> readonly WAIT_PERIOD=3
> readonly WAIT_PERIOD_MAX=60
> readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
>-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
>
> # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
> # control port forwarded for vsock_test.  Because virtme-ng doesn't support
>@@ -33,12 +33,6 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
> # add the kernel cmdline options that virtme-init uses to setup the interface.
> readonly QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
> readonly QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
>-readonly QEMU_OPTS="\
>-	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
>-	 -device virtio-net-pci,netdev=n0 \
>-	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
>-	 --pidfile ${QEMU_PIDFILE} \
>-"
> readonly KERNEL_CMDLINE="\
> 	virtme.dhcp net.ifnames=0 biosdevname=0 \
> 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
>@@ -89,17 +83,6 @@ vm_ssh() {
> 	return $?
> }
>
>-cleanup() {
>-	if [[ -s "${QEMU_PIDFILE}" ]]; then
>-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
>-	fi
>-
>-	# If failure occurred during or before qemu start up, then we need
>-	# to clean this up ourselves.
>-	if [[ -e "${QEMU_PIDFILE}" ]]; then
>-		rm "${QEMU_PIDFILE}"
>-	fi
>-}
>
> check_args() {
> 	local found
>@@ -188,10 +171,26 @@ handle_build() {
> 	popd &>/dev/null
> }
>
>+terminate_pidfiles() {
>+	local pidfile
>+
>+	for pidfile in "$@"; do
>+		if [[ -s "${pidfile}" ]]; then
>+			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
>+		fi
>+
>+		if [[ -e "${pidfile}" ]]; then
>+			rm -f "${pidfile}"
>+		fi
>+	done
>+}
>+
> vm_start() {
>+	local pidfile=$1
> 	local logfile=/dev/null
> 	local verbose_opt=""
> 	local kernel_opt=""
>+	local qemu_opts=""
> 	local qemu
>
> 	qemu=$(command -v "${QEMU}")
>@@ -201,6 +200,13 @@ vm_start() {
> 		logfile=/dev/stdout
> 	fi
>
>+	qemu_opts="\
>+		 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
>+		 -device virtio-net-pci,netdev=n0 \
>+		 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
>+		--pidfile ${pidfile}
>+	"
>+
> 	if [[ "${BUILD}" -eq 1 ]]; then
> 		kernel_opt="${KERNEL_CHECKOUT}"
> 	fi
>@@ -209,14 +215,14 @@ vm_start() {
> 		--run \
> 		${kernel_opt} \
> 		${verbose_opt} \
>-		--qemu-opts="${QEMU_OPTS}" \
>+		--qemu-opts="${qemu_opts}" \
> 		--qemu="${qemu}" \
> 		--user root \
> 		--append "${KERNEL_CMDLINE}" \
> 		--rw  &> ${logfile} &
>
> 	if ! timeout ${WAIT_TOTAL} \
>-		bash -c 'while [[ ! -s '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'; then
>+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
> 		die "failed to boot VM"
> 	fi
> }
>@@ -480,8 +486,6 @@ do
> done
> shift $((OPTIND-1))
>
>-trap cleanup EXIT
>-

Why avoiding the cleanup on exit?
Should we mention this change in commit description?

Thanks,
Stefano

> if [[ ${#} -eq 0 ]]; then
> 	ARGS=("${TEST_NAMES[@]}")
> else
>@@ -496,7 +500,8 @@ handle_build
> echo "1..${#ARGS[@]}"
>
> log_host "Booting up VM"
>-vm_start
>+pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"
>+vm_start "${pidfile}"
> vm_wait_for_ssh
> log_host "VM booted up"
>
>@@ -520,6 +525,8 @@ for arg in "${ARGS[@]}"; do
> 	cnt_total=$(( cnt_total + 1 ))
> done
>
>+terminate_pidfiles "${pidfile}"
>+
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>
>-- 
>2.47.3
>


