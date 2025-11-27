Return-Path: <netdev+bounces-242188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3BC8D352
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 08:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3093A3B1B6D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 07:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D9D328610;
	Thu, 27 Nov 2025 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WikHZaK9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ABB325725
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229677; cv=none; b=BCjSLJG6I0iFxXQpAM8G9o4vN8xGfIwbZgWkWSzQER0mnxCuO2hW4iPpCG4kjdQEvEd9AYd5xehb7RsxbTWuDrKf39snhAwNT98VmeZZyle9trIT6z3VJ4GY++xhPOdgIL6jOUqXqr7WdlGzyZg/HOWvXkrZ+YJ3ACTL8/dPo24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229677; c=relaxed/simple;
	bh=VXSznUA/qrGw37DlDQ/ITpl+vbnJQhBZAvRQarakHeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huFAkGBHGXnuYj9YW/DwHKJXKXycmxRrpVjKpbHQ7WDnrV7hQLSf3i3fAcpSRKqbHdetPdR/P2igoxvy+dnHdA+iDWS4p+4JdzCUyS/DZhwmQkAu3X5gz4CIRLVToc7b7J/IMp5jHOHv+kMpR2wxkR8GBdUVp/k4+mqF5LA/9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WikHZaK9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so640113a91.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 23:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229671; x=1764834471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81Yb0D7xNXy+MdzfxaynPdllQZqiJyMZrUjJeETwoWg=;
        b=WikHZaK9uCb14sc9tWk1a8ahDKOQyP5MPHTQTTvBDi5x3sUPb7U0JOZRLNS5T0fKdv
         7Yl5tInXpO1ZnwaO/cmAkRQ3YIcCRZRfELueqV2YwpDOLKlkSEm/NA1KMa1h026h1PYD
         QrjmMSLDKVFZIyPue1ElrVhA8L6B/3Ax3o+XOfIY3U8GpPI6CHlLlxItXVa6WINpVrmy
         3nu/f/yncbUbXh/iMp+7XAN3CP3/kHXuuHIf6ibWBdFeDqnKuX480DQxAxHZM9zpBn+p
         Z8hdNBq/XGmEBjp9rNP9w3ZoepkYXgmil3X6/0CVnrR5Ve4F8PVl0eQ8OJ1+yH74JIuy
         vmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229671; x=1764834471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=81Yb0D7xNXy+MdzfxaynPdllQZqiJyMZrUjJeETwoWg=;
        b=tTWVwI71QTmiPVF3empgRsmNh8HD4d6bxADfrKrYF/m8j14g/uxt+/thkLSVuAVIdQ
         PCNzTIEsxN5ueul919ugaMKw9scMKou8C00bZhzAN+B54Pf4nFAjwHV2T4gAAAYDvYkc
         hNqGwjGrF3JXUXGaY9K+bNjMl2POuf0D9puZrKhv/yPA279d/PMG5rsZyNfWOQcD0QNv
         N3uZS93jeFBX6P1jbLQXtrBdWfixHz9N+TgAuJHyeWYLdO2BEb3woL1I0U8TMuCHTcVs
         n/DkGnoVraHD0JosfudWY0C8TNFra9JkYfWExRQXRXl9JAYK9tiDFPsa1KjlAizplckH
         0Gew==
X-Forwarded-Encrypted: i=1; AJvYcCVLPE6sVBKyl95rzGW0Qqmqg9DZQVDs7ERCzMsq5PCwrB8NW0ocgD/RMWEuGiTllcPTYaAKDwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIhssHFv6PtNv0u9V5lil2k6vIhZlwGHZFguW6/2Cf05FGDYHH
	BscQ44eAR079i56b9Q/17hAujZ57pEiPsbVqVzXIBOzCAz03merYb69d
X-Gm-Gg: ASbGnctZ1vGvAXUjl2tOJFHKNe5qv8hqjOMy+xBCHu4nNqyvHR2Z1ge/z6HvtLlcmmg
	PnxyClBndkmUa5l0sNje1W8nmTf/3qbAlMUe8t127heNqcOEL/fqskLjJUjBxe8Mg2hMnGteFeI
	2yKiRjUNpQQLZUjmT1dxHn0csCx4pKBuvC+KDRh01eR1IlhBI62RucBsXkAuP2kK4n+hg2cfRvk
	5T/cSZ8GNIL6mfCsUot4KRALCKF0+ohdZi8XSgGMLvKrCSs1dNCZW3yn4YsRqlh9K7WFxRsFzZJ
	qq01wbdHQLlrNC+b+Aev1jzOLACGLmgxNazWRSL7ZbEzJ6P8Qo/pRPtGeuWDlBrlwH+4qMXB4eZ
	xVLoS/VQLjl1cVxMmT+njnv9Po00U4bjL1lG8Qyzvu70miCiLBhwEeXELUqdOUcXRWua4HAH/Cp
	8okmTHCqRkKJ9nLQUYjig=
X-Google-Smtp-Source: AGHT+IHm9n1hN/MXgqh8Fst0OOiMbfzgNDndic/dBuz4wSklQZaHZ2bC0MkEgH2q8ls+YwLmQfHTOg==
X-Received: by 2002:a17:90b:4c48:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-34733f3f6d5mr19204188a91.36.1764229670667;
        Wed, 26 Nov 2025 23:47:50 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a0e65sm989665a12.27.2025.11.26.23.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:50 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:37 -0800
Subject: [PATCH net-next v12 08/12] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-8-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
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
 Shuah Khan <shuah@kernel.org>
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
index 1623e4da15e2..e32997db322d 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -191,7 +191,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh ss; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -346,21 +346,32 @@ wait_for_listener()
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
@@ -368,23 +379,25 @@ wait_for_listener()
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
@@ -431,7 +444,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${ns}" "${port}"
+		vm_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail
@@ -472,7 +485,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${ns}" "${port}"
+		host_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail

-- 
2.47.3


