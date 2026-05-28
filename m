Return-Path: <netdev+bounces-292552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBDRJKuyF2p+NggAu9opvQ
	(envelope-from <netdev+bounces-292552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:12:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADE05EC201
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72A90300D1CB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7A3309F1D;
	Thu, 28 May 2026 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfZcZaK3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B92EA172;
	Thu, 28 May 2026 03:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937961; cv=none; b=KcVoZJJAllLap4cH2pxyrqV9GElonW6xe7g0rnWwmacC+XEox7PFkjqhKS8V0hh513waXxM7FrusGML4y6ysZB48zadgteF9v/+VP8UM8nvyFI7HUNYMMEoTagpla+YVLJnPDB/NdVWk4KgIiOGszxMOD7MK1eE5fOYsJBJCiO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937961; c=relaxed/simple;
	bh=sf61uxk63D01Q3MAkUWNDamhBPyWgx2sOEyadYaJBRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cd/HDfz11W19CeuUr3Uoejrmf7Daey2jM+xRE+V4c8514HsDM1YWZtP/hDJ3vxjf8yTxEqXVUKriO1WibyltXHi2nU+bFy0xLZHDCKfDrCJub4ApHmb6g/B+eW30chtW2OztAgaBXFDJ8Ak2i9Bk0suRTuHb3qhH0BQSJjMFGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfZcZaK3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24761F00A3A;
	Thu, 28 May 2026 03:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937959;
	bh=X8P7GTkuXAPaVRxKv5xYTCC9g55wmFj/P0mjoLQc7GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jfZcZaK320BXXBcEP9/C0gIQk2/GjUKvxQFJCanDywu0D8urfH6ymh6j0klmGa7BB
	 UTKQveCaBrlZNH9ead2ZzryN+b2LAtrb3gLmkGcpGXj7zPgM2YcrpwOEcAC5VZFtpy
	 uQAht0lGTY5UbCvRr3M8oxB57iFyBnGmhRUcByuhpPWk/DkIQIXObAGViUk75ZZaaG
	 u11Urb8cMPkHjO3pkRBGcQNfu4s+/lzcYdu5XSWKzeQzbUXC+Ms3cYbcVdNIKKLA/V
	 a3TqWqHJhctIx4VebsqSQNeW0mmzf9Kxgd3/phn+KM32X0g0b1exifeJjgUak1o0EH
	 Ixg/vWq8HJQGQ==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH 10/11] selftests: mptcp: add nvme over mptcp test
Date: Thu, 28 May 2026 11:10:44 +0800
Message-ID: <6cd098ba688fb8b761f00b7e03fd0459b4fe8ac1.1779934709.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779934709.git.tanggeliang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292552-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email,linux.dev:email,suse.de:email,purestorage.com:email]
X-Rspamd-Queue-Id: 2ADE05EC201
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Geliang Tang <tanggeliang@kylinos.cn>

A test case for NVMe over MPTCP has been implemented. It verifies the
proper functionality of nvme discover and connect commands to establish
NVMe over MPTCP connections. The test then evaluates read/write
performance using fio, and ensures proper cleanup with nvme disconnect.

This script accepts two positional parameters:

  trtype - Transport type (mptcp|tcp). Default: mptcp
  path   - Number of multipath (1-4). Default: 1

This test simulates four NICs on both target and host sides, each limited
to 125MB/s. It shows that 'NVMe over MPTCP' delivered bandwidth up to
four times that of standard TCP with a single NVMe multipath configuration:

 # ./mptcp_nvme.sh tcp
   READ: bw=112MiB/s (118MB/s), 112MiB/s-112MiB/s (118MB/s-118MB/s),
		io=1123MiB (1177MB), run=10018-10018msec
  WRITE: bw=112MiB/s (117MB/s), 112MiB/s-112MiB/s (117MB/s-117MB/s),
		io=1118MiB (1173MB), run=10018-10018msec

 # ./mptcp_nvme.sh mptcp
   READ: bw=427MiB/s (448MB/s), 427MiB/s-427MiB/s (448MB/s-448MB/s),
		io=4286MiB (4494MB), run=10039-10039msec
  WRITE: bw=387MiB/s (406MB/s), 387MiB/s-387MiB/s (406MB/s-406MB/s),
		io=3885MiB (4073MB), run=10043-10043msec

It reflects that MPTCP has the same multi-interface bandwidth aggregation
capability as NVMe multipath.

Cc: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  12 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 329 ++++++++++++++++++
 4 files changed, 350 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 22ba0da2adb8..7b308447a58b 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -13,6 +13,7 @@ TEST_PROGS := \
 	mptcp_connect_sendfile.sh \
 	mptcp_connect_splice.sh \
 	mptcp_join.sh \
+	mptcp_nvme.sh \
 	mptcp_sockopt.sh \
 	pm_netlink.sh \
 	simult_flows.sh \
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..e59cf7398f19 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,11 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_NVME_CORE=y
+CONFIG_NVME_FABRICS=y
+CONFIG_NVME_TCP=y
+CONFIG_NVME_TARGET=y
+CONFIG_NVME_TARGET_TCP=y
+CONFIG_NVME_MULTIPATH=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5ef6033775c8..e08854ba42bd 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -530,6 +530,18 @@ mptcp_lib_check_tools() {
 				exit ${KSFT_SKIP}
 			fi
 			;;
+		"nvme")
+			if ! nvme --version &> /dev/null; then
+				mptcp_lib_pr_skip "nvme tool not found"
+				exit ${KSFT_SKIP}
+			fi
+			;;
+		"fio")
+			if ! fio -h &> /dev/null; then
+				mptcp_lib_pr_skip "fio tool not found"
+				exit ${KSFT_SKIP}
+			fi
+			;;
 		*)
 			mptcp_lib_pr_fail "Internal error: unsupported tool: ${tool}"
 			exit ${KSFT_FAIL}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_nvme.sh b/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
new file mode 100755
index 000000000000..5b1133dbc2d5
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
@@ -0,0 +1,329 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/mptcp_lib.sh"
+
+ret=0
+trtype="${1:-mptcp}"
+path="${2:-1}"
+nqn="nqn.2014-08.org.nvmexpress.${trtype}dev.$$.${RANDOM}"
+ns=1
+port=$((RANDOM % 10000 + 20000))
+trsvcid=$((RANDOM % 64512 + 1024))
+ns1=""
+ns2=""
+temp_file=""
+loop_dev=""
+
+export trtype path nqn ns port trsvcid
+export loop_dev temp_file
+
+usage()
+{
+	cat << EOF
+
+Usage:
+
+	$(basename "$0") [trtype] [path]
+
+	trtype   Transport type (tcp|mptcp) - default: mptcp
+	path     Number of multipath (1-4) - default: 1
+
+EOF
+exit ${KSFT_FAIL}
+}
+
+validate_params()
+{
+	if [[ ! "${trtype}" =~ ^(tcp|mptcp)$ ]]; then
+		echo "Invalid trtype ${trtype}. Must be tcp or mptcp"
+		usage
+	fi
+
+	if [[ ! "${path}" =~ ^[1-4]$ ]]; then
+		echo "Invalid path count ${path}. Must be between 1 and 4"
+		usage
+	fi
+}
+
+# This function is invoked indirectly
+#shellcheck disable=SC2317,SC2329
+ns1_cleanup()
+{
+	pushd /sys/kernel/config/nvmet || exit 1
+
+	for i in $(seq 1 "${path}"); do
+		local portdir=$((port + i))
+
+		rm -rf "ports/${portdir}/subsystems/${nqn}"
+		rmdir "ports/${portdir}"
+	done
+
+	echo 0 > "subsystems/${nqn}/namespaces/${ns}/enable"
+	rmdir "subsystems/${nqn}/namespaces/${ns}"
+	rmdir "subsystems/${nqn}"
+
+	popd || exit 1
+}
+
+# This function is invoked indirectly
+#shellcheck disable=SC2317,SC2329
+ns2_cleanup()
+{
+	nvme disconnect -n "${nqn}" || true
+}
+
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317,SC2329
+cleanup()
+{
+	if ! ip netns exec "$ns2" bash <<- EOF
+		$(declare -f ns2_cleanup)
+		ns2_cleanup
+	EOF
+	then
+		echo "ns2_cleanup failed" >&2
+	fi
+
+	sleep 1
+
+	if ! ip netns exec "$ns1" unshare -m bash <<- EOF
+		mount -t configfs none /sys/kernel/config
+		$(declare -f ns1_cleanup)
+		ns1_cleanup
+	EOF
+	then
+		echo "ns1_cleanup failed" >&2
+	fi
+
+	if [ -n "${loop_dev}" ] && [ -b "${loop_dev}" ]; then
+		losetup -d "${loop_dev}" 2>/dev/null || true
+	fi
+	rm -rf "${temp_file}"
+
+	mptcp_lib_ns_exit "$ns1" "$ns2"
+
+	unset -v trtype path nqn ns port trsvcid
+	unset -v loop_dev temp_file
+}
+
+# $tc_args needs word splitting to pass multiple arguments to netem
+# shellcheck disable=SC2086
+init()
+{
+	local tc_args="rate 1000mbit"
+
+	mptcp_lib_ns_init ns1 ns2
+
+	# ns1		ns2
+	# 10.1.1.1	10.1.1.2
+	# 10.1.2.1	10.1.2.2
+	# 10.1.3.1	10.1.3.2
+	# 10.1.4.1	10.1.4.2
+	for i in {1..4}; do
+		ip link add ns1eth"$i" netns "$ns1" type veth peer \
+					name ns2eth"$i" netns "$ns2"
+		ip -net "$ns1" addr add 10.1."$i".1/24 dev ns1eth"$i"
+		ip -net "$ns1" addr add dead:beef:"$i"::1/64 \
+					dev ns1eth"$i" nodad
+		ip -net "$ns1" link set ns1eth"$i" up
+		ip -net "$ns2" addr add 10.1."$i".2/24 dev ns2eth"$i"
+		ip -net "$ns2" addr add dead:beef:"$i"::2/64 \
+					dev ns2eth"$i" nodad
+		ip -net "$ns2" link set ns2eth"$i" up
+		ip -net "$ns2" route add default via 10.1."$i".1 \
+					dev ns2eth"$i" metric 10"$i"
+		ip -net "$ns2" route add default via dead:beef:"$i"::1 \
+					dev ns2eth"$i" metric 10"$i"
+
+		# Add tc qdisc to both namespaces for bandwidth limiting
+		tc -n "$ns1" qdisc add dev ns1eth"$i" root netem $tc_args
+		tc -n "$ns2" qdisc add dev ns2eth"$i" root netem $tc_args
+
+		tc -n "$ns1" qdisc show dev ns1eth"$i"
+		tc -n "$ns2" qdisc show dev ns2eth"$i"
+	done
+
+	mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
+
+	mptcp_lib_pm_nl_add_endpoint "$ns1" 10.1.1.1 flags signal
+	mptcp_lib_pm_nl_add_endpoint "$ns1" 10.1.2.1 flags signal
+	mptcp_lib_pm_nl_add_endpoint "$ns1" 10.1.3.1 flags signal
+	mptcp_lib_pm_nl_add_endpoint "$ns1" 10.1.4.1 flags signal
+
+	mptcp_lib_pm_nl_set_limits "${ns2}" 8 8
+
+	mptcp_lib_pm_nl_add_endpoint "$ns2" 10.1.1.2 flags subflow
+	mptcp_lib_pm_nl_add_endpoint "$ns2" 10.1.2.2 flags subflow
+	mptcp_lib_pm_nl_add_endpoint "$ns2" 10.1.3.2 flags subflow
+	mptcp_lib_pm_nl_add_endpoint "$ns2" 10.1.4.2 flags subflow
+}
+
+# This function is invoked indirectly
+#shellcheck disable=SC2317,SC2329
+run_target()
+{
+	cd /sys/kernel/config/nvmet/subsystems || exit
+	mkdir -p "${nqn}"
+	cd "${nqn}" || exit
+	echo 1 > attr_allow_any_host
+	mkdir -p namespaces/"${ns}"
+	echo "${loop_dev}" > namespaces/"${ns}"/device_path
+	echo 1 > namespaces/"${ns}"/enable
+
+	# Create ${path} ports, each on a different IP address
+	for i in $(seq 1 "${path}"); do
+		local portdir=$((port + i))
+
+		cd /sys/kernel/config/nvmet/ports || exit
+		mkdir -p "${portdir}"
+		cd "${portdir}" || exit 1
+		echo "${trtype}" > addr_trtype
+		echo ipv4 > addr_adrfam
+		if [ "${path}" -eq 1 ]; then
+			echo "0.0.0.0" > addr_traddr
+		else
+			echo "10.1.${i}.1" > addr_traddr
+		fi
+		echo "${trsvcid}" > addr_trsvcid
+
+		mkdir -p subsystems
+		ln -sf "../../subsystems/${nqn}" "subsystems/${nqn}"
+		cd - >/dev/null || exit
+	done
+}
+
+# This function is invoked indirectly
+#shellcheck disable=SC2317,SC2329
+run_host()
+{
+	local traddr=10.1.1.1
+	local devname
+
+	echo "nvme discover -a ${traddr}"
+	if ! nvme discover -t "${trtype}" -a "${traddr}" \
+			   -s "${trsvcid}"; then
+		echo "Failed to discover ${traddr}"
+		return 1
+	fi
+
+	for i in $(seq 1 "${path}"); do
+		traddr=10.1.${i}.1
+		echo "Connecting to ${traddr}:${trsvcid}"
+		if ! nvme connect -t "${trtype}" -a "${traddr}" \
+				  -s "${trsvcid}" -n "${nqn}"; then
+			echo "Failed to connect to ${traddr}"
+			return 1
+		fi
+	done
+
+	for i in $(seq 1 10); do
+		for dev in /dev/nvme*n1; do
+			if [ -b "$dev" ] 2>/dev/null; then
+				if nvme id-ctrl "$dev" 2>/dev/null |
+				   grep -q "${nqn}"; then
+					devname=$(basename "$dev")
+					break 2
+				fi
+			fi
+		done 2>/dev/null
+		[ -n "$devname" ] && break
+		sleep 1
+	done
+
+	if [ -z "$devname" ]; then
+		echo "No block device found for NQN ${nqn}" >&2
+		return 1
+	fi
+
+	echo "nvme list"
+	if ! nvme list; then
+		echo "nvme list failed" >&2
+		return 1
+	fi
+
+	sleep 1
+
+	echo "fio randread /dev/${devname}"
+	if ! fio --name=global --direct=1 --norandommap --randrepeat=0 \
+		 --ioengine=libaio --thread=1 --blocksize=128k --runtime=10 \
+		 --time_based --rw=randread --numjobs=4 --iodepth=256 \
+		 --group_reporting --size=100% \
+		 --name=libaio_4_256_128k_randread \
+		 --filename="/dev/${devname}"; then
+		echo "fio randread failed"
+		return 1
+	fi
+
+	sleep 1
+
+	echo "fio randwrite /dev/${devname}"
+	if ! fio --name=global --direct=1 --norandommap --randrepeat=0 \
+		 --ioengine=libaio --thread=1 --blocksize=128k --runtime=10 \
+		 --time_based --rw=randwrite --numjobs=4 --iodepth=256 \
+		 --group_reporting --size=100% \
+		 --name=libaio_4_256_128k_randwrite \
+		 --filename="/dev/${devname}"; then
+		echo "fio randwrite failed"
+		return 1
+	fi
+
+	nvme flush "/dev/${devname}"
+}
+
+mptcp_lib_check_tools nvme fio
+validate_params
+
+if ! temp_file=$(mktemp --suffix=.raw /tmp/nvme_test.XXXXXX); then
+	echo "Failed to create temp file"
+	exit 1
+fi
+
+trap cleanup EXIT
+
+if ! dd if=/dev/zero of="${temp_file}" bs=1M count=0 seek=512; then
+	echo "Failed to create backing file" >&2
+	exit 1
+fi
+
+if ! loop_dev=$(losetup -f --show "${temp_file}"); then
+	echo "Failed to create loop device" >&2
+	exit 1
+fi
+
+init
+
+run_test()
+{
+	if ! ip netns exec "$ns1" unshare -m bash <<- EOF
+		mount -t configfs none /sys/kernel/config
+		$(declare -f run_target)
+		run_target
+		exit \$?
+	EOF
+	then
+		ret="${KSFT_FAIL}"
+	fi
+
+	if ! ip netns exec "$ns2" bash <<- EOF
+		$(declare -f run_host)
+		run_host
+		exit \$?
+	EOF
+	then
+		ret="${KSFT_FAIL}"
+	fi
+
+	sleep 1
+}
+
+run_test "$@"
+
+if [ "${ret}" -eq 0 ]; then
+	mptcp_lib_result_pass "nvme over ${trtype} test"
+else
+	mptcp_lib_result_fail "nvme over ${trtype} test"
+fi
+
+mptcp_lib_result_print_all_tap
+exit "$ret"
-- 
2.53.0


