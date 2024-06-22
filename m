Return-Path: <netdev+bounces-105863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A074B913505
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 18:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39591C2195C
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D7B16F0F9;
	Sat, 22 Jun 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="F/HUKKk6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF082566
	for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719072906; cv=none; b=PPn57wZ33jHDahWFiRBJMszB3BeYdDXd7ECR7/UjXVYYAJlAjBmsaFYBrr4jeJ4PqMGVYEkwH1dn4USjRsJRqqTm1f2IhvH652sgIJyztFAnvcKKXkd4dcb22ATUzIY85cLwZj3UG6cdcJdMLy/1k8tt+Ub/yz/72jF5cEE78NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719072906; c=relaxed/simple;
	bh=V6VHdjx21u7TNG3LmrR7wPBRD/1dr+Nh/7f0ubgbtOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWKs+UjdjnJigpkR+gGf142b8FSEbB5qn+SwHH/S5xuTFt3EtLzqrk/1cooblV8QTUq1dy5E+0s67HD8u4Jl1ZC4mEp6K39nQHE65iZu58Jm8+JaZuWjdm48PS+VYZYoqeAw3J35+q8k2uu3gvPi3nTaRhXYWT9fegpelwlEAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=F/HUKKk6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f177b78dcso328192666b.1
        for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719072903; x=1719677703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCumI6uI/kOKmfPqsLFeHRTgS10pS7GjNwgID8SeUms=;
        b=F/HUKKk6KYHE+fIRqN7201XewiQhGHt7uPPldPiC4LVBhgXey+4fablcVZ4QMrE498
         MGpxgP2fFWm/wRlNinRgsvoh4vI6TJSbecNKu0M7e0BnnwRXHcbpx0BmzqWtmqhrz3mN
         tws8MYiivPgZZiHrgA495FBpsQreqgGfMGeHUiLZTUhhHl+S2OcWrB1+wTDZwfqWPGod
         gz4pCSXtJgO4N7+aaxL8hYItg437FPH5JE+9HgbF+7ZydAzRZAOM0FRN+oOwZOaPpIEH
         oFscTYHAn0YtR/axIPhCoQTlqKwVY9FcD5YlwB0K4QheblUKDwHyq89XQkKZQK2MKpOm
         C2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719072903; x=1719677703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCumI6uI/kOKmfPqsLFeHRTgS10pS7GjNwgID8SeUms=;
        b=PrN6yiP+v1FM+ZYLKSKo5VShtgZbQ/P02LJT1PD5A6YK7xIh4NGf5fNKfVNnkKIqvE
         Pzgrb5rlL08tWJInNrjiW0P1xQepGz2HbWC95SSZjiDvdWT+7GlCjraZh64bzI69OFeC
         LiNrruQUEl8FA6dN4g4ECSHjZja2Getw3E1yKDF3HrNxBificYvN364D/I7ov+//0CFA
         P5lS9EkcAHrMTjBiduzCgVX9yz0++gRlTc/WkGnOnv3Ss2YS7cHjGI79CwQl3uOOkQoZ
         KGFdxzFyQ6zXCRPOPgptNQrtCrcOX8b4rhBj2xRe5mPlldyJ4lQKprDnE1+lv8VYLFl6
         BRcg==
X-Gm-Message-State: AOJu0YwAPOBtYozn2vl8jmACc82JHS2UPiFuWcp8KxL5pPurkLYwnERT
	gjwZLHHAyHdArRfPn8hw/wyagJM9F7+7rvBBB2cGdxuklyTi8aR59QSr34PS0VE=
X-Google-Smtp-Source: AGHT+IEPA+aakvpwdJcZMS0ArrDYX2R3VaVUNT6hXNz4WdLTC2WwR6W2IYIyI+8T0U4+gUDgvzzsIA==
X-Received: by 2002:a17:906:af97:b0:a6f:5609:9552 with SMTP id a640c23a62f3a-a7245c85b6amr11798666b.10.1719072903389;
        Sat, 22 Jun 2024 09:15:03 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72440ebcc1sm22838566b.180.2024.06.22.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 09:15:02 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 22 Jun 2024 18:14:44 +0200
Subject: [PATCH net 2/2] selftests/net: Add test coverage for UDP GSO
 software fallback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240622-linux-udpgso-v1-2-d2344157ab2a@cloudflare.com>
References: <20240622-linux-udpgso-v1-0-d2344157ab2a@cloudflare.com>
In-Reply-To: <20240622-linux-udpgso-v1-0-d2344157ab2a@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.13.0

Extend the existing test to exercise UDP GSO egress through devices with
various offload capabilities, including lack of checksum offload, which is
the default case for TUN/TAP devices.

Test against a dummy device because it is simpler to set up then TUN/TAP.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/net/udpgso.c  | 15 +++++++++---
 tools/testing/selftests/net/udpgso.sh | 43 +++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 85b3baa3f7f3..3e74cfa1a2bf 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -53,6 +53,7 @@ static bool		cfg_do_ipv6;
 static bool		cfg_do_connected;
 static bool		cfg_do_connectionless;
 static bool		cfg_do_msgmore;
+static bool		cfg_do_recv = true;
 static bool		cfg_do_setsockopt;
 static int		cfg_specific_test_id = -1;
 
@@ -414,6 +415,9 @@ static void run_one(struct testcase *test, int fdt, int fdr,
 	if (!sent)
 		return;
 
+	if (!cfg_do_recv)
+		return;
+
 	if (test->gso_len)
 		mss = test->gso_len;
 	else
@@ -464,8 +468,10 @@ static void run_test(struct sockaddr *addr, socklen_t alen)
 	if (fdr == -1)
 		error(1, errno, "socket r");
 
-	if (bind(fdr, addr, alen))
-		error(1, errno, "bind");
+	if (cfg_do_recv) {
+		if (bind(fdr, addr, alen))
+			error(1, errno, "bind");
+	}
 
 	/* Have tests fail quickly instead of hang */
 	if (setsockopt(fdr, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)))
@@ -524,7 +530,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "46cCmst:")) != -1) {
+	while ((c = getopt(argc, argv, "46cCmRst:")) != -1) {
 		switch (c) {
 		case '4':
 			cfg_do_ipv4 = true;
@@ -541,6 +547,9 @@ static void parse_opts(int argc, char **argv)
 		case 'm':
 			cfg_do_msgmore = true;
 			break;
+		case 'R':
+			cfg_do_recv = false;
+			break;
 		case 's':
 			cfg_do_setsockopt = true;
 			break;
diff --git a/tools/testing/selftests/net/udpgso.sh b/tools/testing/selftests/net/udpgso.sh
index 6c63178086b0..7aad16750686 100755
--- a/tools/testing/selftests/net/udpgso.sh
+++ b/tools/testing/selftests/net/udpgso.sh
@@ -27,6 +27,31 @@ test_route_mtu() {
 	ip route add local fd00::1/128 table local dev lo mtu 1500
 }
 
+setup_dummy_sink() {
+	ip link add name sink type dummy mtu 1500
+	ip addr add dev sink 10.0.0.0/24
+	ip addr add dev sink fd00::2/64 nodad
+	ip link set dev sink up
+}
+
+test_hw_gso_hw_csum() {
+	setup_dummy_sink
+	ethtool -K sink tx-checksum-ip-generic on >/dev/null
+	ethtool -K sink tx-udp-segmentation on >/dev/null
+}
+
+test_sw_gso_hw_csum() {
+	setup_dummy_sink
+	ethtool -K sink tx-checksum-ip-generic on >/dev/null
+	ethtool -K sink tx-udp-segmentation off >/dev/null
+}
+
+test_sw_gso_sw_csum() {
+	setup_dummy_sink
+	ethtool -K sink tx-checksum-ip-generic off >/dev/null
+	ethtool -K sink tx-udp-segmentation off >/dev/null
+}
+
 if [ "$#" -gt 0 ]; then
 	"$1"
 	shift 2 # pop "test_*" arg and "--" delimiter
@@ -56,3 +81,21 @@ echo "ipv4 msg_more"
 
 echo "ipv6 msg_more"
 ./in_netns.sh "$0" test_dev_mtu -- ./udpgso -6 -C -m
+
+echo "ipv4 hw-gso hw-csum"
+./in_netns.sh "$0" test_hw_gso_hw_csum -- ./udpgso -4 -C -R
+
+echo "ipv6 hw-gso hw-csum"
+./in_netns.sh "$0" test_hw_gso_hw_csum -- ./udpgso -6 -C -R
+
+echo "ipv4 sw-gso hw-csum"
+./in_netns.sh "$0" test_sw_gso_hw_csum -- ./udpgso -4 -C -R
+
+echo "ipv6 sw-gso hw-csum"
+./in_netns.sh "$0" test_sw_gso_hw_csum -- ./udpgso -6 -C -R
+
+echo "ipv4 sw-gso sw-csum"
+./in_netns.sh "$0" test_sw_gso_sw_csum -- ./udpgso -4 -C -R
+
+echo "ipv6 sw-gso sw-csum"
+./in_netns.sh "$0" test_sw_gso_sw_csum -- ./udpgso -6 -C -R

-- 
2.40.1


