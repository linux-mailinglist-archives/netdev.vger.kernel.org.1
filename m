Return-Path: <netdev+bounces-250661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 372BFD38865
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 22:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B62C9302C902
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD5434AB19;
	Fri, 16 Jan 2026 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZwkSOaH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B63090DB
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598954; cv=none; b=qh5KcfMcsV2/ZOpXW6hctEE7YtQ2BPFiDblThLNBdOP1ub+QiUYKHvWF/pElHDYd6fKzOnCaqry8SeDbP/6PnVkiBiSxn6/xKiUQ1ivkhsRtSzMZoSfmW4ss0GDOOvDumrns8VBZHRh3RzgvUq3gyZsotFlcKqsJl9qI7qL5RvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598954; c=relaxed/simple;
	bh=P4erHizl27nbkGk13UaQgtaMcmfPrCQL8OW5nr9GtQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h4oatbLRq1n5BAoVyZSiaTmnVaMWz01MxT0+n2Sv10xB27oi8XtwS3WCXF+hBcEDO2kqkf/p5c5jaBf3kgGF1jTt4uJSDsUDccWAPAXH7oPHCrpzD5CR7UANpWq+OvIPBctn8HWxqAyydWi594CU00/gSDFsSBS7Ul4PAaHkNiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZwkSOaH; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78fba1a1b1eso40461057b3.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 13:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598950; x=1769203750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=KZwkSOaH++WfAsT49gS6t09jAWBAhA1owZm4eUIbZ52rNMphxh4zJkKjRoPpCXrHw9
         ZQObJOt/c/5VwQN7p0orGkYUlA/SCKzMqYuRAu6HjXgP19Z8zWwQ4DlDHu46wqVCGx+i
         ydGgwgrmfKnv72aWDp0eDHC8i4t/jkIy4tIvKRa7vmTZfEGt045PtpaVBNQmT0VhnA4m
         HTfXawhEkjdQGoj9w3pBumXqeRSOxCwVWCoS45AL7uGhPwEEzxWNKzYVzfpC5RyRu/eW
         JpYAwZuGbPZshge3y01Q9NbRfCJuSJHQOwpkuEPzXy4WUrGsnW/gZdtgRid1ySQnyHr2
         Gdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598950; x=1769203750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=jPzi1kfhZnwJavTdT+DCqVnM4W53M7Sc1DaSIgGL9S9UH3QROJBNxFfSZsjBHWqpmg
         KGu/1tnRFThbJKjhn65QDqteNILe3Iru9xoNNFan6a927DRVu1yzhjhTs6o8rNTIAAgo
         gdr5QNzX4MwSkIFmr3uVXOvYgrL/lER6w0etQGj8I0eYIXp0hdPhuJyrnTgTVjCuqIzw
         2lSIU/HyaOou65hN0rgobuHCdMg6Qh9vln9EO8OqrnQ15VxxVR725gWHyGthHHgoIHD8
         gVWRVHHkL+3lBYCACifOpOWf651PYFzduKxK+3pu0DohPOwuzvZkOcpkOOIrgPT05oHx
         ZKhg==
X-Forwarded-Encrypted: i=1; AJvYcCW0zAP72WmE+HI5GOdMTaJa+l+Kd9SUU2ZnOzO37waN5sO49m1mmL/POPhoNnl73c8Vf8Wd+sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vCD6Q6JxiQPyn3PBB8I4d0CWNO4j9gRm8jYTeBiYcrnz5JVE
	7sVZ6S0siaZyvKCSh7/PHdFzXMz5BWrIAP4cqApkNx18W6cnkcRUjqyX
X-Gm-Gg: AY/fxX44h/9A+UX/jpVdUnjpWVuHcaeAolZ5Vevxladt3U528mkU7mULVPH3oFLjtRl
	jynf+d+sJmDwSAzpZuggJAi3N5fU8BN+cO6Irvq9/p3oCS3FUUkfcpwufBUidDdT/Rp5iIYmQIv
	slaSJ8zqEIr2ZH+0MKQXUJQVlWJ0KTx0TP7kFPtZPyIhQgZeySXNMFpqEkePdogxZH88unBeH7i
	FfzswNxoIQOoKxadpIhQOEoHykYWVsxzkfcjsHoaaNWfAsU7Nqn8SB6NHj0Wcl9W+UdhViEmq33
	VotsmKx0tApTjlptq2j52kC9TKNr85lo3gM3xXw87qjmbknf9TqNPpNg+p7GUSo6usuv0jU6NSa
	FBHNwiAA3xBw27j6wiUMcUTD0pn4UwKe4YLq1Mm/RzWM1YSBKrxaVRdpc3Wf9WV6wWmLscoqGXC
	OvOYdE/1yy
X-Received: by 2002:a05:690c:dd4:b0:793:baf5:ffcc with SMTP id 00721157ae682-793c57be153mr40080797b3.2.1768598949786;
        Fri, 16 Jan 2026 13:29:09 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66f6f97sm13467037b3.16.2026.01.16.13.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:09 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:48 -0800
Subject: [PATCH net-next v15 08/12] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-8-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Replace /proc/net parsing with ss(8) for detecting listening sockets in
wait_for_listener() functions and add support for TCP, VSOCK, and Unix
socket protocols.

The previous implementation parsed /proc/net/tcp using awk to detect
listening sockets, but this approach could not support vsock because
vsock does not export socket information to /proc/net/.

Instead, use ss so that we can detect listeners on tcp, vsock, and unix.

The protocol parameter is now required for all wait_for_listener family
functions (wait_for_listener, vm_wait_for_listener,
host_wait_for_listener) to explicitly specify which socket type to wait
for.

ss is added to the dependency check in check_deps().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 47 +++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4b5929ffc9eb..0e681d4c3a15 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -182,7 +182,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh ss; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -337,21 +337,32 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
-	local protocol=tcp
-	local pattern
+	local protocol=$4
 	local i
 
-	pattern=":$(printf "%04X" "${port}") "
-
-	# for tcp protocol additionally check the socket state
-	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
-
 	for i in $(seq "${max_intervals}"); do
-		if awk -v pattern="${pattern}" \
-			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
-			/proc/net/"${protocol}"*; then
+		case "${protocol}" in
+		tcp)
+			if ss --listening --tcp --numeric | grep -q ":${port} "; then
+				break
+			fi
+			;;
+		vsock)
+			if ss --listening --vsock --numeric | grep -q ":${port} "; then
+				break
+			fi
+			;;
+		unix)
+			# For unix sockets, port is actually the socket path
+			if ss --listening --unix | grep -q "${port}"; then
+				break
+			fi
+			;;
+		*)
+			echo "Unknown protocol: ${protocol}" >&2
 			break
-		fi
+			;;
+		esac
 		sleep "${interval}"
 	done
 }
@@ -359,23 +370,25 @@ wait_for_listener()
 vm_wait_for_listener() {
 	local ns=$1
 	local port=$2
+	local protocol=$3
 
 	vm_ssh "${ns}" <<EOF
 $(declare -f wait_for_listener)
-wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
 EOF
 }
 
 host_wait_for_listener() {
 	local ns=$1
 	local port=$2
+	local protocol=$3
 
 	if [[ "${ns}" == "init_ns" ]]; then
-		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}" "${protocol}"
 	else
 		ip netns exec "${ns}" bash <<-EOF
 			$(declare -f wait_for_listener)
-			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
 		EOF
 	fi
 }
@@ -422,7 +435,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${ns}" "${port}"
+		vm_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail
@@ -463,7 +476,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${ns}" "${port}"
+		host_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail

-- 
2.47.3


