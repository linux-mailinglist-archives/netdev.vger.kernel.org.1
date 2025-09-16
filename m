Return-Path: <netdev+bounces-223793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9468B7E422
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258131C0404A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C2F2F99B0;
	Tue, 16 Sep 2025 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ypfy1gnj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032CD2F657E
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066246; cv=none; b=HF+KUem3JEsMC9s0VVxh2MeYWba0gW4AROUcJ8njYarwW/hBI0FgH5qgWs8Fs7Ym+nhy1d7suIHHD2KK82E3El/6WM+LLjZLg0MPJlCfY8L0UMwGZ8CpqC3ejlOJ4ekr86X8GeoBHVIKZ01eKcT/Rpdppa0vIzVBpM8n1UOkoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066246; c=relaxed/simple;
	bh=EcIbGeQZlwbG2n3LwrGpP4mEJH5ftJ79PCsbYjs89dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rV4317EmdwR/xpRVI/lA4zhStwI/WNj7CzyMnNNeTUklFXt8XDaRNHhCDdCC8TactfSuaDg6ynabZI4q56Mxg2SOZQHoxuggn+aEt7orJTELX8rtF3X2RXwphuS8IySvVtDU18bab58KRQjUHofnCKC1GtH+RnemwdNsUeFOn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ypfy1gnj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7728815e639so4256255b3a.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066242; x=1758671042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2evao2yHguRL1K3LeUb7zk3K6u4tPHmAj2zWCiTI2M=;
        b=Ypfy1gnjtI2K5v0rTj0AMhQZ5ILDP1nm8XZA20ZB5wU8GVuP6Yd63Vhnmm8Tl8Sfgs
         RwmcvqnI8+QqDbU38eYRwRmtmmtjk6u29gHYu8jkGt2L7gbA74YnfWHCUkZz8xGRGAjh
         fC6qBYk0nJjLhZmXEiBnTJnsXWwsQhDthXyLFrrr6KRNGHkCO3WJvX6PrqloDJDqWnld
         bIOQAfyxsCLN88etU6zVf9LuaZ72LB890AQdUIAGEwJoNFXDamoeG3Vhacqo+UdwN5lK
         ShAFey9dFzYFKXAjZ7R6BdcBHHCoDjWlUPoPlsIzqcNNIdyGU5eSrK1ih4DuDcjTpS7A
         M5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066242; x=1758671042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2evao2yHguRL1K3LeUb7zk3K6u4tPHmAj2zWCiTI2M=;
        b=Zadll8gEuJ03xc7LfgSGNB88kfWv4wPBKZAnj1nGxJKI0XtcpyFQ+RdZQNzixsPu6T
         HAydYhYrX8jxOemslr/1DZwQof37dfCG8qaSI+IlciySOCbZ3Zflbfq9AEK+DZSZkv1z
         MJf5Lw5Fg00FamiF83yML8iAUZ1raZGpXlyH5HJgFFoQ9tgIOXt482K3cZvgYtZaFixv
         jba4nrPzSBs2iFDIT+Lpmca51cxzRI1hNW9fOL57ifphRb94unhCE0y2x/gf9bSfgT0P
         vXAFIBIvS0ArUZKUMP28LnlBQA3/BNqoxbd7721WxQFg1bNPVBoeP0qtgzT4FVFc0VEd
         atPw==
X-Forwarded-Encrypted: i=1; AJvYcCVNqsE7kvKS0ND90iZPBMm7Y2RNdxod/TJb3KNf+fdvbFBZ6u9hpcBbdI/x9RAJxXtloWEBmls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbrNEFo4wjFVmm3e1FTM/sDQSkm6oxmVG5XUb2QXIVCC9R2ZaG
	CJf7X7VoKU8APYMvtKMkfpMinuw0dtbwnXcKT566C0/qYURuc3wWdy0u
X-Gm-Gg: ASbGnctzP095RqJD7lylt3DEq3QnEzOsskV/qPTD7wx9lKLcQNv5AsSiJqW00I6CEoI
	fjN2AdIEUvXPdupwX7mxhz/GwXmIGNdC3mlxVcdPskN0n67d/0YHSPBvdXq0QTrPguxS51THMn0
	Tga9u1KSdZsW+DstV8rBNM4QnIJSISnBN72z1JZmKYGAFPL35eQz/CMxtHy3/pUBOUzk/rWjd0c
	SNnPWxYUWL+ZQLfYHapHdkUZhkTsXu2tffhgmeEbPU36kT7b6xtDW5vUoz1Ugq8gbEORB7o3lcB
	9QOo9IsHr0JpWWS/jMlmAH4NUqG2Eu92t8caQCum73wu2aut6iDAAKL46ssze2/P3AGbpGiRbGY
	5r5Po59OLPWmqZUw6
X-Google-Smtp-Source: AGHT+IFnRN2kqEQWg3F1ajCbRwtqkrji7IA+bfyA4M8oQZqQSHuWScxk3g9jwjuxm36IJwivZampNQ==
X-Received: by 2002:a05:6a20:7f98:b0:250:f80d:b334 with SMTP id adf61e73a8af0-27a6fdc4458mr89552637.0.1758066242210;
        Tue, 16 Sep 2025 16:44:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54dd63d5e5sm3149345a12.4.2025.09.16.16.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:44:01 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:51 -0700
Subject: [PATCH net-next v6 7/9] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-7-064d2eb0c89d@meta.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Improve logging by adding configurable log levels. Additionally, improve
usability of logging functions. Remove the test name prefix from logging
functions so that logging calls can be made deeper into the call stack
without passing down the test name or setting some global. Teach log
function to accept a LOG_PREFIX variable to avoid unnecessary argument
shifting.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 75 ++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..183647a86c8a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -51,7 +51,12 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
-VERBOSE=0
+readonly LOG_LEVEL_DEBUG=0
+readonly LOG_LEVEL_INFO=1
+readonly LOG_LEVEL_WARN=2
+readonly LOG_LEVEL_ERROR=3
+
+VERBOSE="${LOG_LEVEL_WARN}"
 
 usage() {
 	local name
@@ -196,7 +201,7 @@ vm_start() {
 
 	qemu=$(command -v "${QEMU}")
 
-	if [[ "${VERBOSE}" -eq 1 ]]; then
+	if [[ ${VERBOSE} -le ${LOG_LEVEL_DEBUG} ]]; then
 		verbose_opt="--verbose"
 		logfile=/dev/stdout
 	fi
@@ -271,60 +276,56 @@ EOF
 
 host_wait_for_listener() {
 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
-}
-
-__log_stdin() {
-	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
-}
 
-__log_args() {
-	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
 }
 
 log() {
-	local prefix="$1"
+	local redirect
+	local prefix
 
-	shift
-	local redirect=
-	if [[ ${VERBOSE} -eq 0 ]]; then
+	if [[ ${VERBOSE} -gt ${LOG_LEVEL_INFO} ]]; then
 		redirect=/dev/null
 	else
 		redirect=/dev/stdout
 	fi
 
+	prefix="${LOG_PREFIX:-}"
+
 	if [[ "$#" -eq 0 ]]; then
-		__log_stdin | tee -a "${LOG}" > ${redirect}
+		if [[ -n "${prefix}" ]]; then
+			cat | awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
+		else
+			cat
+		fi
 	else
-		__log_args "$@" | tee -a "${LOG}" > ${redirect}
-	fi
+		if [[ -n "${prefix}" ]]; then
+			echo "${prefix}: " "$@"
+		else
+			echo "$@"
+		fi
+	fi | tee -a "${LOG}" > ${redirect}
 }
 
-log_setup() {
-	log "setup" "$@"
+log_host() {
+	LOG_PREFIX=host log $@
 }
 
-log_host() {
-	local testname=$1
+log_guest() {
+	LOG_PREFIX=guest log $@
+}
 
-	shift
-	log "test:${testname}:host" "$@"
 }
 
-log_guest() {
-	local testname=$1
 
-	shift
-	log "test:${testname}:guest" "$@"
 }
 
 test_vm_server_host_client() {
-	local testname="${FUNCNAME[0]#test_}"
 
 	vm_ssh -- "${VSOCK_TEST}" \
 		--mode=server \
 		--control-port="${TEST_GUEST_PORT}" \
 		--peer-cid=2 \
-		2>&1 | log_guest "${testname}" &
+		2>&1 | log_guest &
 
 	vm_wait_for_listener "${TEST_GUEST_PORT}"
 
@@ -332,18 +333,17 @@ test_vm_server_host_client() {
 		--mode=client \
 		--control-host=127.0.0.1 \
 		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
 
 	return $?
 }
 
 test_vm_client_host_server() {
-	local testname="${FUNCNAME[0]#test_}"
 
 	${VSOCK_TEST} \
 		--mode "server" \
 		--control-port "${TEST_HOST_PORT_LISTENER}" \
-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
 
 	host_wait_for_listener
 
@@ -351,19 +351,18 @@ test_vm_client_host_server() {
 		--mode=client \
 		--control-host=10.0.2.2 \
 		--peer-cid=2 \
-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
 
 	return $?
 }
 
 test_vm_loopback() {
-	local testname="${FUNCNAME[0]#test_}"
 	local port=60000 # non-forwarded local port
 
 	vm_ssh -- "${VSOCK_TEST}" \
 		--mode=server \
 		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest "${testname}" &
+		--peer-cid=1 2>&1 | log_guest &
 
 	vm_wait_for_listener "${port}"
 
@@ -371,7 +370,7 @@ test_vm_loopback() {
 		--mode=client \
 		--control-host="127.0.0.1" \
 		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest "${testname}"
+		--peer-cid=1 2>&1 | log_guest
 
 	return $?
 }
@@ -429,7 +428,7 @@ QEMU="qemu-system-$(uname -m)"
 while getopts :hvsq:b o
 do
 	case $o in
-	v) VERBOSE=1;;
+	v) VERBOSE=$(( VERBOSE - 1 ));;
 	b) BUILD=1;;
 	q) QEMU=$OPTARG;;
 	h|*) usage;;
@@ -452,10 +451,10 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_setup "Booting up VM"
+log_host "Booting up VM"
 vm_start
 vm_wait_for_ssh
-log_setup "VM booted up"
+log_host "VM booted up"
 
 cnt_pass=0
 cnt_fail=0

-- 
2.47.3


