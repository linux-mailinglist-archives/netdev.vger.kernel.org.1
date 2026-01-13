Return-Path: <netdev+bounces-249271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE9D16718
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE0FC305854D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F094340D82;
	Tue, 13 Jan 2026 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJW025XU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBC328246
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273989; cv=none; b=WEzOfZKnyd9hf2ASD8i9rHd1vaq2dmUZYGo7bPl1K/zB+jfNrDK019alm/USAdJdEamho3KTiUE2GoOy5XpLcWqujWZrVbXZe0XQvzIQPYz65His7vNnz3I/gyL4cn39uofW0jFSMxcKovcG6eDHzqHlX5j7Svjyh6ov3jraYE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273989; c=relaxed/simple;
	bh=P4erHizl27nbkGk13UaQgtaMcmfPrCQL8OW5nr9GtQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aA/KHWLcbZtBQjNrh2KY0rmaIRbE7F9yu4Mh5md4d3iqPj3Pmu4Er7t/pqwtP5kPvtaH4EdwL8YmsLUIr7+gdQQmK8WS2znKWtTx+DibU4Z8j3VfgwVlFN8lZgHuhAnCEWWGD8dgl+juaABVyf8HCX0rMaOtXeqZ2DUU9dT85t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJW025XU; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78c66bdf675so70730917b3.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 19:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273984; x=1768878784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=dJW025XUyS0hkypO5syqIx9fQbwC2g43y7fdpET5hJo6tRLKtoZLLyvWIeCSiPStdU
         2xPXuzf50clQcMeyqG9H6Q4NUf923gNDmUOmn0nSpM0M0bJsXajOEM/UGVppFQ0WE9Pa
         CX89EQ4o8X2rCeKP3szDc+ZVpheLMX3/xwI9172ilwMH82KqmeHzkqWjANgqcQ3Ptr6W
         h7IXBkV/lWV/UsDJd7iPkCGESrRmqxnnGvWLkO1C6c9ONTVEM0ujojcMgYG0S6vdFkJv
         mrbaAI19Si6DhtVClx5cwhxB7e+kfv1Vmv/vrANEQD+57C/3aq6amTXAUFm4qsmiAdRn
         /mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273984; x=1768878784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=fN8DpI7GrE5N0l+qbBKKMXTPkPyDi1NbOOCSA2AiuZxFjk5FlsUP/KGbhMZRVyi9WU
         pl6sXcrniy0Qg91fwcsufCrBwgm+4Fu85zBNfAOC18wqQJaLhAKBnnWjmUBCqKbbsK+S
         prPcTTQhZrd5ycep/Gq+ERNkR0gASygLlnwX66s+V/XWF+f1EwvxCDgrFHdbIMfPy2o0
         AIcuH1/Qvq20tg4Ky+rch9VMaVMhWyWywrSBKvhk/LKkr3+yDbpMX63wOwXMGZAcrOEw
         dS6KX6D4/pVDuE06kwdd9OFcy5Us1xm5nUQPYjqk9n9n4yJJItdvkB8DZ51ICQMhCqHj
         F3vA==
X-Forwarded-Encrypted: i=1; AJvYcCUBNUrPV9lj6x5XsAlWTObVFWzUKFR2M3vkqcFUKYsGkyZ4Mi1lCrvb2U6vN6UNXsPoS7MsCzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7EfyMwAq4ji7rHPqcgykac+R+C7JHjiWYyUh2XcOOV0uW7zP
	7iAOIstoum1rLjiLQI5HUT0TzemmOlbljlurYTFiiqSgB3ohfs2tR+pl
X-Gm-Gg: AY/fxX7S1+bmiXcaM4N8eO8AGjat/F3swxiRapao6JPPldwSyNeswc+D2gVMaXAvw6p
	rgXfIDOrOSXLgko5MdVMDBs73lbkwQgGHBK3xn+8VUpASMHYeCZb5wiUQ/eXglorRfKsGe+z63Y
	FJ77G1qqBgcUKmAtE3AdnNmMfuhPUrQYLp2J0zSqg5DLkzArOu2fqAeSXJIX/XMlEfAeFJDTC+j
	bHmNgXYE0QexugGPBgDvd9LrVQ84GBVEktbdTKsoEpzHtn1AYLgSwMpx36IySSIaF1QHN54yagQ
	aG2Lv1ZUaR5yYclnYMe5+ISkoE5a9MyxBMXi4PrPoPycwEbRfs00rBevRHFdrWVDhNjQvFKcVp8
	2KbBaszxwTga00025ehNROraiqJeUd5nPS5IQpi72x/MuR5QosKHc5AyOibqTJNzsGPizd4hFj3
	Kyb/xgHGgKJg==
X-Google-Smtp-Source: AGHT+IEy9Q+Bs+OJz9UukhXskoJRq1Ip3lDRk/f1Rv+Si7ZL/p4TbWg6hnGyyFmzcwY6bJqShwt21A==
X-Received: by 2002:a05:690e:14c9:b0:63e:3b29:f1e1 with SMTP id 956f58d0204a3-64716c04ccfmr15374186d50.36.1768273984459;
        Mon, 12 Jan 2026 19:13:04 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d89d4besm8862008d50.13.2026.01.12.19.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:13:04 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:17 -0800
Subject: [PATCH net-next v14 08/12] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-8-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
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


