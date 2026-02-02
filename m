Return-Path: <netdev+bounces-255846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO/0LlaOgGkl+wIAu9opvQ
	(envelope-from <netdev+bounces-255846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:45:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B88CBE1E
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFF6E3030EFA
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 11:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461C3363C6E;
	Mon,  2 Feb 2026 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZmBZI++"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182403624BC
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770032628; cv=none; b=XWfqxnUoyUU+Ke6VHJQvKlae9s5zmRRgpFHPwBYXBNmpljGU5dEmwTfuKK402byKHdXGHKJPopLmbVMxZZHV0/8kYaxWuvIFpCW8nHylIOAAO+jWAKWhDI9oNTee+y3X1QuAmv43ubxgVVJ3ev+qYvdwZ8epzlPisF0t5R3aGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770032628; c=relaxed/simple;
	bh=4kAMjAlfHV5FL+KQNiAU/dddvVYtgDqX2k0UR9Pe2Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUDH7+P3gYR7YHWiuoaaYZS5km8+i2rZK7f9sVbft8yEwzfTuztAWEg0lbK/mnFD+nkujipzD9faZMEWmKgQXxswX0fY/iZWkMXXcT1YG8+KE884CFnxnyoRksqxKe+XoGad8WkgEOeVCvmskXBnAOkDAM00ozgIiLglxWmQPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZmBZI++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770032625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8KIicsK93MGllIH0s+WH+EggiXfnu0nHP9hncCx9kQ=;
	b=fZmBZI++tUrQwWwmtx//9Kp6FFt5oxCg+98pizUHKEbhU8oxXiRdAoEB3xdT81jIS74Kg4
	N+DyR6dzF7aSGPHeIVmT3ERwxTWiPVQZU/5pRp/fA8tyXXfMW84zIHLZ35icOwCzW5ZE4w
	lZktfeb04jFoZVQLg2C2kzie720bwNM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-QL_P_QWINkCy3hh90dBo8A-1; Mon,
 02 Feb 2026 06:43:43 -0500
X-MC-Unique: QL_P_QWINkCy3hh90dBo8A-1
X-Mimecast-MFC-AGG-ID: QL_P_QWINkCy3hh90dBo8A_1770032622
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32BC31956059;
	Mon,  2 Feb 2026 11:43:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.250])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17B811956053;
	Mon,  2 Feb 2026 11:43:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	linux-kselftest@vger.kernel.org,
	aleksander.lobakin@intel.com
Subject: [PATCH v2 net 2/2] selftest: net: add a test-case for encap segmentation after GRO
Date: Mon,  2 Feb 2026 12:43:15 +0100
Message-ID: <768ca132af81e83856e34d3105b86c37e566a7ad.1770032084.git.pabeni@redhat.com>
In-Reply-To: <cover.1770032084.git.pabeni@redhat.com>
References: <cover.1770032084.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255846-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[udpgro_fwd.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10B88CBE1E
X-Rspamd-Action: no action

We had a few patches in this area and no explicit coverage so far.
The test case covers the scenario addressed by the previous fix;
reusing the existing udpgro_fwd.sh script to leverage part of the
of the virtual network setup, even if such script is possibly not
a perfect fit.

Note that the mentioned script already contains several shellcheck
violation; this patch does not fix the existing code, just avoids
adding more issues in the new one.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - fixed comment typos
  - dropped unneeded 'nodad' from del command
---
 tools/testing/selftests/net/udpgro_fwd.sh | 64 +++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index a39fdc4aa2ff..9b722c1e4b0f 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -162,6 +162,39 @@ run_test() {
 	echo " ok"
 }
 
+run_test_csum() {
+	local -r msg="$1"
+	local -r dst="$2"
+	local csum_error_filter=UdpInCsumErrors
+	local csum_errors
+
+	printf "%-40s" "$msg"
+
+	is_ipv6 "$dst" && csum_error_filter=Udp6InCsumErrors
+
+	ip netns exec "$NS_DST" iperf3 -s -1 >/dev/null &
+	wait_local_port_listen "$NS_DST" 5201 tcp
+	local spid="$!"
+	ip netns exec "$NS_SRC" iperf3 -c "$dst" -t 2 >/dev/null
+	local retc="$?"
+	wait "$spid"
+	local rets="$?"
+	if [ "$rets" -ne 0 ] || [ "$retc" -ne 0 ]; then
+		echo " fail client exit code $retc, server $rets"
+		ret=1
+		return
+	fi
+
+	csum_errors=$(ip netns exec "$NS_DST" nstat -as "$csum_error_filter" |
+		      grep "$csum_error_filter" | awk '{print $2}')
+	if [ -n "$csum_errors" ] && [ "$csum_errors" -gt 0 ]; then
+		echo " fail - csum error on receive $csum_errors, expected 0"
+		ret=1
+		return
+	fi
+	echo " ok"
+}
+
 run_bench() {
 	local -r msg=$1
 	local -r dst=$2
@@ -260,6 +293,37 @@ for family in 4 6; do
 	ip netns exec $NS_SRC $PING -q -c 1 $OL_NET$DST_NAT >/dev/null
 	run_test "GRO fwd over UDP tunnel" $OL_NET$DST_NAT 10 10 $OL_NET$DST
 	cleanup
+
+	# force segmentation and re-aggregation
+	create_vxlan_pair
+	ip netns exec "$NS_DST" ethtool -K veth"$DST" generic-receive-offload on
+	ip netns exec "$NS_SRC" ethtool -K veth"$SRC" tso off
+	ip -n "$NS_SRC" link set dev veth"$SRC" mtu 1430
+
+	# forward to a 2nd veth pair
+	ip -n "$NS_DST" link add br0 type bridge
+	ip -n "$NS_DST" link set dev veth"$DST" master br0
+
+	# segment the aggregated TSO packet, without csum offload
+	ip -n "$NS_DST" link add veth_segment type veth peer veth_rx
+	for FEATURE in tso tx-udp-segmentation tx-checksumming; do
+		ip netns exec "$NS_DST" ethtool -K veth_segment "$FEATURE" off
+	done
+	ip -n "$NS_DST" link set dev veth_segment master br0 up
+	ip -n "$NS_DST" link set dev br0 up
+	ip -n "$NS_DST" link set dev veth_rx up
+
+	# move the lower layer IP in the last added veth
+	for ADDR in "$BM_NET_V4$DST/24" "$BM_NET_V6$DST/64"; do
+		# the dad argument will let iproute emit a unharmful warning
+		# with ipv4 addresses
+		ip -n "$NS_DST" addr del dev veth"$DST" "$ADDR"
+		ip -n "$NS_DST" addr add dev veth_rx "$ADDR" \
+			nodad 2>/dev/null
+	done
+
+	run_test_csum "GSO after GRO" "$OL_NET$DST"
+	cleanup
 done
 
 exit $ret
-- 
2.52.0


