Return-Path: <netdev+bounces-215027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B17FB2CB5E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 19:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764BC5C2DE8
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51D430C36E;
	Tue, 19 Aug 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvjgj9z0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7AB30E83E;
	Tue, 19 Aug 2025 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625668; cv=none; b=c36KBtklJpej/78hGG0olA+zX6foVlQMd/LMkwDmqZlL9N9Eug5uP/d8/5j0xseO/0lRQ/Pc9tob8k6MY38oSn7d3/QoT/OVGOoiU87xMX5+Obfx37oiFqB1I5Fh23FOLuI6noUU6dlawBqrJUZm7nyffT7XxYKEIVaIRwnUy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625668; c=relaxed/simple;
	bh=zxOsO0U7uICU9UyC/BtygGo50pT3VEuJ8Qus3wpcaDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqhlWnehkBWqBmcPvQ6IKuvkeVw8RvsDPGHeA40IKIs0QgSm7IVWrrqNdSyPSNfVdmzaV+6fYWNLNaEF7N+C5wQ6UKi1xpH33b+l5sh3cjSpvHQB3EoS1T4/Nnw9DMpfSfPeHRfGFxfeg5NtcrApjcAFKzLl9pgZmVz34V+mc9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mvjgj9z0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso29424635e9.1;
        Tue, 19 Aug 2025 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755625665; x=1756230465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV8T1/e9vmT2yocc8WGsZXIRU5vCVTMY+wuZVgREffs=;
        b=Mvjgj9z0Yi8C4hlDRS4KUaO+gfvZoFvYnDGrJXkSHWp58v1WQZDlWNxkXynn5rQ6DE
         85gZArk5Q+rpNkJL47fnpAAOmtBID9LVfsr7NGDUdvjXYTnmlKcJknPArtjEGzdMPs9t
         LFCGTEmNGGL6VK9yQl3L9ejt8eT9v4Kf3b+JCbO49c716t0U3umrZtIq9h/GoCrpPCqy
         UvZhSlhJRt1vGMe5zAgkNh95g04tVknWtqQ4bh3mkHdVzJ27YgoTfKc72hktcjmH3cug
         6xsqLjtFUeW4CtQTXiThFzLCycZDduQm/lKUrFjIbZri2EXHKx198cRQnd0CzDE68278
         58sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625665; x=1756230465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jV8T1/e9vmT2yocc8WGsZXIRU5vCVTMY+wuZVgREffs=;
        b=IaMq8TR6gVpZTWm3tWNZiyo170n3RgskeckrxTvIIPoJ2tbnrmjcIZeRYs+zWtsM78
         58D4wnO2CMSFqpxwI8BCrUKCscA3rHeg20FE8Kk0skTZh2UCJl9NgrRBjgdOkElSQim/
         wGRPQSKWIXbBBWuE/Robe3YdjTEGNu4+ayRahldChli0ukpOsvOhENhtECG/gjxPbtJm
         pWuU3BzViy29FywWiIEceLcBcz5jwlEovEjKLS28Z59BfJqHKo1cCKrv2CSjhhvf4rXv
         jiuwo5HyOUpwxJ1GHdcxm3pH4h6JNqbB1llLhjBVzaUWi1Ym4L57sV4IXAzGfKHXbfeL
         w0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUunVwin6XRa0NoFZcM0HoAKdRl4sP2aqDKLfQEswKuTJzI5Tk35RCPoNx9NgnnkBIETrgwv44OEPc8a0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB8greBWwXbzfCvCc4wxm6aQPHsCt1wv5AuwNT22EU4PiIaUK0
	QsD7I1ulfULsmf9hKAVdz1ILv7BVeaLlUpmT9JLCyq1zKiE94mooBM74OtiFmEsR
X-Gm-Gg: ASbGnctrYH8Wla5XbsDfeHukpzd9+j2RR6h9VQUP3IAYVo071WTi6zvV6lMQHGop+Ss
	KjCi9VXzl7DIVNisHHiZb3yphmcsAcyuMmIsmNEA+3rp957XjNwtdfBPFaxF3SNwQYCQ2gDgW3L
	oaqk/Hbqg0PU+LPH30/zdhLsx2n49CE3NstoR8KSBdMzucGXeNw7klrB2shSpjQ3pYarEeikarC
	fGArEE0eOnahaxePMF2+Yg+IkuWSUvFfSq4TOFKCv1Tj4+9awS4RDg9lVNPHDBFVixrY/Zod41h
	qWk/4KeBbiGZVWGsmDUCqSzZ6jh9KGRlQOXWpyT5DyD74e5FJXZ4JPMp2EbwRZD5S7DTFA3m96+
	JSPBJvfyJIfQJs2wD3TTKsfNGa5x+GS+PQjc=
X-Google-Smtp-Source: AGHT+IHMqwdHLa809CtLhJdzk/Jh+JBj770G0jJA+aVXN+7wj7JZNMuXNeRiwwNxT2lMT5fTnTKzJA==
X-Received: by 2002:a05:600c:470f:b0:458:bf7c:f744 with SMTP id 5b1f17b1804b1-45b43e0d57emr30448365e9.32.1755625665028;
        Tue, 19 Aug 2025 10:47:45 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b410sm232181565e9.24.2025.08.19.10.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 10:47:44 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next v3 2/2] selftests: net: add test for dst hint mechanism with directed broadcast addresses
Date: Tue, 19 Aug 2025 19:46:42 +0200
Message-Id: <20250819174642.5148-3-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819174642.5148-1-oscmaes92@gmail.com>
References: <20250819174642.5148-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for ensuring that the dst hint mechanism is used for
directed broadcast addresses.

This test relies on mausezahn for sending directed broadcast packets.
Additionally, a high GRO flush timeout is set to ensure that packets
will be received as lists.

The test determines if the hint mechanism was used by checking
the in_brd statistic using lnstat.

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 tools/testing/selftests/net/Makefile      |  1 +
 tools/testing/selftests/net/route_hint.sh | 79 +++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100755 tools/testing/selftests/net/route_hint.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b31a71f2b372..eef0b8f8a7b0 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -117,6 +117,7 @@ TEST_GEN_FILES += tfo
 TEST_PROGS += tfo_passive.sh
 TEST_PROGS += broadcast_pmtu.sh
 TEST_PROGS += ipv6_force_forwarding.sh
+TEST_PROGS += route_hint.sh
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/route_hint.sh b/tools/testing/selftests/net/route_hint.sh
new file mode 100755
index 000000000000..2db01ece0cc1
--- /dev/null
+++ b/tools/testing/selftests/net/route_hint.sh
@@ -0,0 +1,79 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test ensures directed broadcast routes use dst hint mechanism
+
+source lib.sh
+
+CLIENT_IP4="192.168.0.1"
+SERVER_IP4="192.168.0.2"
+BROADCAST_ADDRESS="192.168.0.255"
+
+setup() {
+	setup_ns CLIENT_NS SERVER_NS
+
+	ip -net "${SERVER_NS}" link add link1 type veth peer name link0 netns "${CLIENT_NS}"
+
+	ip -net "${CLIENT_NS}" link set link0 up
+	ip -net "${CLIENT_NS}" addr add "${CLIENT_IP4}/24" dev link0
+
+	ip -net "${SERVER_NS}" link set link1 up
+	ip -net "${SERVER_NS}" addr add "${SERVER_IP4}/24" dev link1
+
+	ip netns exec "${CLIENT_NS}" ethtool -K link0 tcp-segmentation-offload off
+	ip netns exec "${SERVER_NS}" sh -c "echo 500000000 > /sys/class/net/link1/gro_flush_timeout"
+	ip netns exec "${SERVER_NS}" sh -c "echo 1 > /sys/class/net/link1/napi_defer_hard_irqs"
+	ip netns exec "${SERVER_NS}" ethtool -K link1 generic-receive-offload on
+}
+
+cleanup() {
+	ip -net "${SERVER_NS}" link del link1
+	cleanup_ns "${CLIENT_NS}" "${SERVER_NS}"
+}
+
+directed_bcast_hint_test()
+{
+	local rc=0
+
+	echo "Testing for directed broadcast route hint"
+
+	orig_in_brd=$(ip netns exec "${SERVER_NS}" lnstat -j -i1 -c1 | jq '.in_brd')
+	ip netns exec "${CLIENT_NS}" mausezahn link0 -a own -b bcast -A "${CLIENT_IP4}" \
+		-B "${BROADCAST_ADDRESS}" -c1 -t tcp "sp=1-100,dp=1234,s=1,a=0" -p 5 -q
+	sleep 1
+	new_in_brd=$(ip netns exec "${SERVER_NS}" lnstat -j -i1 -c1 | jq '.in_brd')
+
+	res=$(echo "${new_in_brd} - ${orig_in_brd}" | bc)
+
+	if [ "${res}" -lt 100 ]; then
+		echo "[ OK ]"
+		rc="${ksft_pass}"
+	else
+		echo "[FAIL] expected in_brd to be under 100, got ${res}"
+		rc="${ksft_fail}"
+	fi
+
+	return "${rc}"
+}
+
+if [ ! -x "$(command -v mausezahn)" ]; then
+	echo "SKIP: Could not run test without mausezahn tool"
+	exit "${ksft_skip}"
+fi
+
+if [ ! -x "$(command -v jq)" ]; then
+	echo "SKIP: Could not run test without jq tool"
+	exit "${ksft_skip}"
+fi
+
+if [ ! -x "$(command -v bc)" ]; then
+	echo "SKIP: Could not run test without bc tool"
+	exit "${ksft_skip}"
+fi
+
+trap cleanup EXIT
+
+setup
+
+directed_bcast_hint_test
+exit $?
-- 
2.39.5


