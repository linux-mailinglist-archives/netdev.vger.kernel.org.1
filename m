Return-Path: <netdev+bounces-256486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO2+EHyAgmnAVQMAu9opvQ
	(envelope-from <netdev+bounces-256486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 00:10:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D90DF958
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 00:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 408AA3003BE4
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 23:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EE831A56D;
	Tue,  3 Feb 2026 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="l8gfBS9K"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C82FF14C;
	Tue,  3 Feb 2026 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160242; cv=none; b=D+GSXkhi5Fo6ex2wTZwvdyA+nd3VLnvQu2uNiOtgfgxJqecKkbR7qJUlqi8Dc54voLNG64S+Og80xaVDIHQnvQib4LRsbsIXZEvepFd5/ZNgZS4QkUqgJ9zu5ObOYn+k8OeRhHmaA9cqFWrhpx2FDAN8mQnKlOEnpedfGYOh95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160242; c=relaxed/simple;
	bh=lUcJN1jg+zED3Isc1cH6enOy5dSIioTA0MdAfnTcs98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaY1aXm+7BIgB72tw1BzBzELgUmjw5NHkfnyI1GOjnipfjWm40HvuuLW2VOGafv5q5rUTkx9wZcRRUY7CJMgfwClb0NpK0yjaBBKgzqPuB8qyg6REVanVYXPMX5ows71O1OTMXuVgVsh32QVdkKfTTEdo0Jhqb2GfbnaPee0H3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=l8gfBS9K; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613JpgK0687507;
	Tue, 3 Feb 2026 15:10:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=iPTUI/xKO457I8R5No/8MzqCrUFsTAdriLc9ADEbvic=; b=l8gfBS9KNJ/T
	pU6Yeu70JSIZsSIvStcvRJ0k8Sa9b+YM0sCFzWTrwUHJDzK6HbIDz30Z4j9q0skP
	gi+p9hWYpplzKwBonB1ayFbYV/G+yHvp9nAVEc6FFafVz4BYNcPoWzknUKxYejuE
	UUNAyvqfbS9kePKIswjNyAon1sLbwIJgDEP7ncn7nDbXkfTGTiP9ZDLKTnlaBkJl
	j1QMlOFuDjNCvcpLy9OX3Hb/1CyNKCVG38P0eX1pvOrT37O2kV8j3I7vNQIIMEwP
	f/U/3eEh9H8BBGq2WMruhITLs90Hkjg9xZqp1FMeq4J8SmU2nrTS1KwJBjOpsCSH
	bPUzVSg9nA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c3m8n5091-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 03 Feb 2026 15:10:26 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Tue, 3 Feb
 2026 23:10:24 +0000
From: Vishwanath Seshagiri <vishs@meta.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei
	<dw@davidwei.uk>,
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas
	<ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>
Subject: [PATCH net-next v3 2/2] selftests: virtio_net: add buffer circulation test
Date: Tue, 3 Feb 2026 15:10:19 -0800
Message-ID: <20260203231021.1331392-3-vishs@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203231021.1331392-1-vishs@meta.com>
References: <20260203231021.1331392-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=HuB72kTS c=1 sm=1 tr=0 ts=69828062 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=LsufUKy5yQhhIYM6NHsA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 3msDK3jTq51rh2EBv2oVqDqs2UqkK-O5
X-Proofpoint-ORIG-GUID: 3msDK3jTq51rh2EBv2oVqDqs2UqkK-O5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDE4MiBTYWx0ZWRfX82in5AS0COhG
 eHbJL0XVYtMQ5Twj4aFEziEBCrsawHTKFl6+GGCmqqks2CeHkIMoMuwrDpbizJ41iR/tUhGuU8t
 zvkGDc33mFuVotnPyoTubumk5+WmESHHjfSnelCaaZUr4dE44oX1MaYWcOy3+ZnfYSx0q4VYGkW
 rmNWwNjBF9whsTOgb2c7QS4FZetHgHbIMaIYvQdfpd8Hf03/SO/XOg/kpasRplUMF66pfM3eYrf
 adrwGaq2vO+8udNi3E83YtkrYEmmqHwAYAsx4FfPitQOq/B6oggYmRFuNHOi3lkEMkVdxel2mhR
 iuAFTAcCdBHHkF03Q4hJ/TN/ikwcmZyVg/Ua7yc3n4O9uR/0QnHlUWminq8j1u4C650mG1wUoZJ
 g/FQtAqTydBnTAgsKCj+JjfD3y2drA7bePvllZOynhDx2UiJVJNf95yDdaBxV78tZRda4yAWPyI
 xwF6ltCUtCXkLpC911Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_06,2026-02-03_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256486-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid]
X-Rspamd-Queue-Id: 06D90DF958
X-Rspamd-Action: no action

Add iperf3-based test to verify RX buffer handling under load.
Optionally logs page_pool tracepoints when available.

Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
---
 .../drivers/net/virtio_net/basic_features.sh  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
index cf8cf816ed48..fa98505c4674 100755
--- a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
+++ b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
@@ -6,6 +6,7 @@
 ALL_TESTS="
 	initial_ping_test
 	f_mac_test
+	buffer_circulation_test
 "
 
 source virtio_net_common.sh
@@ -16,6 +17,8 @@ source "$lib_dir"/../../../net/forwarding/lib.sh
 h1=${NETIFS[p1]}
 h2=${NETIFS[p2]}
 
+IPERF_SERVER_PID=""
+
 h1_create()
 {
 	simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
@@ -83,6 +86,84 @@ f_mac_test()
 	log_test "$test_name"
 }
 
+buffer_circulation_test()
+{
+	RET=0
+	local test_name="buffer circulation"
+	local tracefs="/sys/kernel/tracing"
+
+	if ! check_command iperf3; then
+		log_test_skip "$test_name" "iperf3 not installed"
+		return 0
+	fi
+
+	setup_cleanup
+	setup_prepare
+
+	ping -c 1 -I "$h1" "$H2_IPV4" >/dev/null
+	if [ $? -ne 0 ]; then
+		check_err 1 "Ping failed"
+		log_test "$test_name"
+		return
+	fi
+
+	local rx_start=$(cat /sys/class/net/"$h2"/statistics/rx_packets)
+	local tx_start=$(cat /sys/class/net/"$h1"/statistics/tx_packets)
+
+	if [ -d "$tracefs/events/page_pool" ]; then
+		echo > "$tracefs/trace"
+		echo 1 > "$tracefs/events/page_pool/enable"
+	fi
+
+	local port=$(shuf -i 49152-65535 -n 1)
+
+	iperf3 -s -1 --bind-dev "$h2" -p "$port" &>/dev/null &
+	IPERF_SERVER_PID=$!
+	sleep 1
+
+	if ! kill -0 "$IPERF_SERVER_PID" 2>/dev/null; then
+		IPERF_SERVER_PID=""
+		if [ -d "$tracefs/events/page_pool" ]; then
+			echo 0 > "$tracefs/events/page_pool/enable"
+		fi
+		check_err 1 "iperf3 server died"
+		log_test "$test_name"
+		return
+	fi
+
+	iperf3 -c "$H2_IPV4" --bind-dev "$h1" -p "$port" -t 5 >/dev/null 2>&1
+	local iperf_ret=$?
+
+	if [ -n "$IPERF_SERVER_PID" ]; then
+		kill "$IPERF_SERVER_PID" 2>/dev/null || true
+		wait "$IPERF_SERVER_PID" 2>/dev/null || true
+		IPERF_SERVER_PID=""
+	fi
+
+	if [ -d "$tracefs/events/page_pool" ]; then
+		echo 0 > "$tracefs/events/page_pool/enable"
+		local trace="$tracefs/trace"
+		local hold=$(grep -c "page_pool_state_hold" "$trace" 2>/dev/null)
+		local release=$(grep -c "page_pool_state_release" "$trace" 2>/dev/null)
+		log_info "page_pool events: hold=${hold:-0}, release=${release:-0}"
+	fi
+
+	local rx_end=$(cat /sys/class/net/"$h2"/statistics/rx_packets)
+	local tx_end=$(cat /sys/class/net/"$h1"/statistics/tx_packets)
+	local rx_delta=$((rx_end - rx_start))
+	local tx_delta=$((tx_end - tx_start))
+
+	log_info "Circulated TX:$tx_delta RX:$rx_delta"
+
+	if [ "$iperf_ret" -ne 0 ]; then
+		check_err 1 "iperf3 failed"
+	elif [ "$rx_delta" -lt 10000 ]; then
+		check_err 1 "Too few packets: $rx_delta"
+	fi
+
+	log_test "$test_name"
+}
+
 setup_prepare()
 {
 	virtio_device_rebind $h1
@@ -113,6 +194,11 @@ setup_cleanup()
 
 cleanup()
 {
+	if [ -n "$IPERF_SERVER_PID" ]; then
+		kill "$IPERF_SERVER_PID" 2>/dev/null || true
+		wait "$IPERF_SERVER_PID" 2>/dev/null || true
+	fi
+
 	pre_cleanup
 	setup_cleanup
 }
-- 
2.47.3


