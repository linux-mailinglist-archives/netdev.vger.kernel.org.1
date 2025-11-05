Return-Path: <netdev+bounces-235816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B354C36106
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 15:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3630F561DFC
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48943318146;
	Wed,  5 Nov 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBjFk+zP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nZD7MODi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790CD1A3172
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352761; cv=none; b=lYXl/fQFffJb90mpF9NxL3klHQQJhhPHMKB7u4GsiMCYRJw56XPwrWwtQoaijjg0933LO3Nfo4Q/vUhdh4wJQTDQST/+fc8BCnng33qmlf67o80V258j1Dr5K68iQ9Im1C4kWZbrZxoGW1BfocCwlU5hvA0ElGSm3QotugpFogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352761; c=relaxed/simple;
	bh=N+EK1Kxp8qxWEiuKYA9xEBkqzBsi1k8ar4ofTabGyVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rICmrvkGeVfFwoAElmjdIB3X3aZA1FjZ7y/cdlm48nMYl8ul8ZQd11gxKmbgpv5qo2rOsJUHRcjA2SBExmu9mQaJa+m9xeVzLGuTq9rlBP/ZQr8ovR7UIUgITFLaEm7fhGY9FGfRoIowdRUJCMwMqcFral9yOhX8XOvPW43XVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBjFk+zP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nZD7MODi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762352758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Haea4m2+uFf7hS1qpomFR5hmGiTU6exHIPsfHUZpCc=;
	b=OBjFk+zPD55jWgWWRQilLghbPsg8CcQG9w6OujDjGIPPvqmKrkBi4+1rouacFOFESgYDyU
	rEk4mNPiOEtoF3aIwuKFxtgxp4JO5kASh7+eJ1Bt9QpYSyTuNJsIHyKFNYBAeocsskpeXC
	5Nhxs1ISbGB6eurPjudGFjqJNYeMAms=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-KwON1gBHM1yzTDMal-45tg-1; Wed, 05 Nov 2025 09:25:57 -0500
X-MC-Unique: KwON1gBHM1yzTDMal-45tg-1
X-Mimecast-MFC-AGG-ID: KwON1gBHM1yzTDMal-45tg_1762352756
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429b7b46eebso5830550f8f.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 06:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762352756; x=1762957556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Haea4m2+uFf7hS1qpomFR5hmGiTU6exHIPsfHUZpCc=;
        b=nZD7MODiR7PEoyl0xE+E7GzTQDbHsIPZXYgjMhphS5ciuwvbGP8KZ6jiBLfZbfc5L9
         D2Wsmao3dnrm3y/4WezUDOoXATfLUeFyOuXHU2cVyl1+ch2Z69iBEEAtufEdDmM4o1oi
         yYJAUr2F31G5hmvEhG/EFWKde8uCrR8QPPyECY2QKtIWsDMPUzAYlDml6FysL97zcI4t
         DSME7lOKR31VKT+WQbQKHESSeDBXsd8iCHj6iJyu00+sNNiJsu0hu9R3eFYyDotZaL93
         uEVE8FbodTLVsuox8GCzeqLnj0R7Ri7O+xxy5JUx+EFIuu0lx57wZAXqyhamXmBaWtms
         vLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352756; x=1762957556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Haea4m2+uFf7hS1qpomFR5hmGiTU6exHIPsfHUZpCc=;
        b=Wx74lnIqSKhHrI7Uz4p7GdhGa5PNXX5kiGDgtYagJRunA1YfF5xSdU7LCa1BGCckjF
         l4lmTV3ANrnHhIosXH328ZmzMQnRHS3slkpvp8jVbNqALBWeDQi2Z5y/c3wSQBJBETNC
         oTwl0VnNj8Rc56PtgBgZMEbjFSL+Ya225a8h7Hr2Z89Po43amIxuZl6cHezqyhBzl48T
         5kOIa5UBJ1+DA36GeYkwB9JQZSPdjaJY4Mt4ofelya/cOLfrG5K4IDQnXsd/hvTUUJ+c
         3fMhATchLyFbR6AM/UpflIekRqmb27LiRSpxUJtoA0T8zd9XEvyr0n9t5GxSg/A0OBE3
         TQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCVDkZJz0fhGbBeKRQM8zF3NEE4gNPwLmC36pXHz3PR0iMEqlvJ3hSOJsT/d0IUeJoWXbO/6lDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy94vnNi69zTPJSZLNTky15wFg/nzTQagvCDOrqInXqQRKM31CU
	R50zR6WHLHarL1ZYgYDfZ29eJDFvCe48585GaFJZyQdRj++SMCXc1zMpnuKVxrb9o8aeanv5HQZ
	OGWoIBdUcdyFksQyd2SdiyA3DVQ3UFNCBVu0kf5rRxDEx1qVLnzFq84cRvw==
X-Gm-Gg: ASbGncsMinplYIromjSCL4cJQp1feg2v7F0KlJdp9BAqKcNdR9+1AlFRlX/uONFJPS6
	yMEj0WJwvMJqu1d9tkaxt0FRPxSke9KmFbAjSsSEWsXwHbRoQel1BAEIFfdFZoOSY+bFD/Xg5LS
	4EDOKJJTazY5C2l3crUDjSEpfESqnqrl6/Tmk4eKKFz8AQe1yrgH7Fuy9+1aG9ul4PpQH0eZBep
	cwk+W2UsBTTMsJqwfruQe2q4DBPetS99sss72jmjEn9rDRhdSjnxgGNbu9uYeE2Rkm7qY45SVF5
	pQGR57wn/UREoXw/SYm3KZDRn1RnzdjNRLt8shX5mRWYAvfOvazYdNEpwMusfgMgs3nk0zztOC4
	=
X-Received: by 2002:a05:6000:40da:b0:429:ce02:c895 with SMTP id ffacd0b85a97d-429e330c220mr2577744f8f.50.1762352756184;
        Wed, 05 Nov 2025 06:25:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4x/Sllh30KcFpre6XL8hFdFV5BshGdQVTU/zf2P/M8C1K9+V8heW7EYih3ymwmEoRBZPFvA==
X-Received: by 2002:a05:6000:40da:b0:429:ce02:c895 with SMTP id ffacd0b85a97d-429e330c220mr2577713f8f.50.1762352755717;
        Wed, 05 Nov 2025 06:25:55 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc2007afsm11067852f8f.44.2025.11.05.06.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:25:55 -0800 (PST)
Date: Wed, 5 Nov 2025 15:25:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <bvzstd363kuvzfnxg6r3dfxtkqswcdz677rpvutgugfep5ecsx@6rlyaud34g7e>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-3-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-3-ca2070fd1601@meta.com>

On Tue, Nov 04, 2025 at 02:38:53PM -0800, Bobby Eshleman wrote:
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
> tools/testing/selftests/vsock/vmtest.sh | 130 ++++++++++++++++++++++----------
> 1 file changed, 91 insertions(+), 39 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index da0408ca6895..03dc4717ac3b 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -273,7 +273,77 @@ EOF
>
> host_wait_for_listener() {
> 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
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
>
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
>+			return $rc
>+		fi
>+
>+		host_wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"

IIUC host_wait_for_listener() doesn't have any input parameter, should 
we add them if we need to call in this way?

Stefano

>+		rc=$?
>+	fi
>+	set +o pipefail
>+
>+	return $rc
> }
>
> log() {
>@@ -312,59 +382,41 @@ log_guest() {
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


