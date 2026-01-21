Return-Path: <netdev+bounces-252094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJU1HWhQcWkvCAAAu9opvQ
	(envelope-from <netdev+bounces-252094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:17:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 641D45EA86
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16B636A3E5F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232844CF36;
	Wed, 21 Jan 2026 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX+Ki3ni"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1755243E9EC
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033535; cv=none; b=Ao4wXyHhT2ITFW54MEGO+IK0r4MvR/6r2qaPeUUyNx4uxhotmYmG5Q9u3HXSoA+P7b3UCnBOSpAA0Nkv1JojkShmbGHAE4XCBTk6zDKB7b7EUVPhA3oSw8wz2qRHKad04a9t8eIW/RDOtpKe1NIMlZcd5jC8R5APKH6fE/yp8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033535; c=relaxed/simple;
	bh=P4erHizl27nbkGk13UaQgtaMcmfPrCQL8OW5nr9GtQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTwTW2vAWce+cx5F24tC3w76jZDEj4ZDfVSV/QJfX09Ziez5ag/bcMecGLWOhpGuqQMK2kWmEdzayWHxx7LxcZcCMcz16pRt6ikO0os5o9Llvi9EMvW0HgBOmkmCPsVs9chyZMBben2QjB2Gkwk9NeSQQ5XjDoFtSXzG4cPsrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX+Ki3ni; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6493937c342so463791d50.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033526; x=1769638326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=GX+Ki3ni1gmYlUQWy3Q3fjHsgnMlGoIplsLk7tFb7aOkP+FjHR5a4F4aXX/xSZCpHV
         7NKUmvCEUFVJZKJaL/FdMIw+coVyyvllvtq0yiyueCKEEN+NEztXmyDsW298+9uiQzVQ
         Kn1ihdkV24XHlonR2x2EoU9kTxbDhVX6DIYA2KoP/1trI3i5+wquN+pcI1srfD7bWYxl
         VI7EZXTi0SrL4pkRknKLtbf5vi6+24AmJzrLjq5tO+p/jChRu1oN7pJmvaLajtfUsuDG
         ufCQWkc4TLtPxsgXcA9oC+OmCXI2NCnMlwuqiTrQ8hw62g2+Z+G251i2OXEb+FGRfAt0
         vKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033526; x=1769638326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=OXZ4ppiceoAvD7EL3cDZ/dqeycakoFDoeZp098xyWqEoHZRf8592AotsU2pZp7k7tL
         Gc0F6FwK5qXX74iPgzmdvRRKjylWVdMpP7kY4vQkr7ipxLBkfusFOPsu2Ed0NWTVEjTw
         M61cjbixYsqdiaz9kVWK3K+vHC+mllSv59KYqjTf4wBYbvhwpaRgXoM9F38nezMxwJqu
         816eqn9/T/RGMNz/SS/DAlyq4FafYcgXSs+v+5qLXu2powDv2XaUdINNkSU/atYynZjg
         Ti7lveYkO0SoyQRbm48n11ZkVPyiS7I5ykCpNi8gn0FVO61vUR0CteligAtyHTfH/Er9
         4Vdw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Li5sZsLo+PVZXy3+b0tPm/KurAPMfJ/fj6qM5S3T0hTVJ1PetcH3oluiiVyzp5AdcYyagsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfg+IpERnn1rWL+lHKA51M37ta/1Dju3pA9KRG8aZT+u1VeAhG
	lAsLDrK+atTg18O+yDEnUilxpobGXmRVPqWzjCSYwOeCWgy7JqZic6+D
X-Gm-Gg: AZuq6aI3ph/QOElICHIwl0y+kHEN2hO+y5glASX/yfy4ytMTdutG47V7n3MA0qUaylz
	745ERP+gVWumLzE4wJrb6PmAvExFtcVo8mmsgfbF2G9Uo/ADC/Uf/UNp9a+5kbLWPBpGbLzfZRi
	UUzg56pbIpxhbfqIrVPMwxy7Wv0zSo6Zig/RWd72sAPhdMNBnbl8vJ5T9atmmeOE0BJPETfmW7V
	5nqC5xm06xv190v5RFzBToTK7R70A8XeTZpueMZT+vszGnZ10392KjDzDJ9rducWrY8+Lea5aHV
	ffW0VDGr8Jd6SaQInX0ulvDbhfpEHZe5s8U3nVk3vpBJTKIwuPXqBn7Gnhh/CXkRWhnvGU9B2NQ
	P5NqdzztQwHyFsULmvWkNVSbxqQDDR6bbx2OLLWpebr7zbSLKW7yhu3zsX/2YRmweI3ptmiRTMa
	OFwtzcOMIF
X-Received: by 2002:a05:690e:b4d:b0:649:3f08:edc with SMTP id 956f58d0204a3-6493f080f88mr4683116d50.41.1769033526167;
        Wed, 21 Jan 2026 14:12:06 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170acbdbsm8409641d50.13.2026.01.21.14.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:05 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:48 -0800
Subject: [PATCH net-next v16 08/12] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-8-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,sargun.me,gmail.com,meta.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252094-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 641D45EA86
X-Rspamd-Action: no action

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


