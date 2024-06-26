Return-Path: <netdev+bounces-107031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8881D918B2F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D7B284B72
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF1190475;
	Wed, 26 Jun 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WRXd6wP7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F02419047F
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424316; cv=none; b=JTpGrZl3xz2EijBKLHSmQASjm/3WS+NJpjdod9cVWQPwkj/s2cAKiNJ8Q8kv4VkdUXyQ7A6580oZgk9yVeNGkeHvjlr0VwBSUkilsrQdF0nQvF4Yz9bD1xjuN3QBtutebz1zfoskMkbP2HOGBQv2y1qPlQ0C/d5YsbeQIFM1SkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424316; c=relaxed/simple;
	bh=qQcYNQDIl93d426H6W0LV+OLiu5ipr9C70Qiobm70ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRVKrntazAxvU2qr18F49GFvSL405jWqLTQj/JdBhSKkv0EFXNu46EEOCF6P7/2Oa4xD6wLjVa7ayWVCpHLfnVyKeW2T79cRvt1MtGVJLHuxAdcdeDYYOts4NgVzqcJtivj3gxeQMM4pcJ1hSI7xRKss1ZpAXca2y64qkvwuJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WRXd6wP7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6fe617966fso469836466b.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719424313; x=1720029113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=me0d/c9yK9kDvYxWMTTKweaXWR7ku/0DGTnTbgCrjkQ=;
        b=WRXd6wP7+Pzpk4/cKQiATILMxAgBDgtMymfhQ5yMz8lsPKDAdPnj+GWhT8Pe8Zfkoq
         +s9ydV9xrMLMpOO0xmb5Cue9pvxzhoQi6dobw2vjbFNLBGG7VB/app1I4Mk44gbnHf9W
         fUzDaDmmtjGwvi4/zs5egUjPH8QZSh/Qy44bJEx8N4uQetWpSetPJDQ7Ts1ufP6GqpVZ
         gP+VREp5JXzTfUyCwwFvlkqaBMnQm3C3XEQFP0sShaSBPZl/hSH0gZXbTwT6vH63yX0O
         56vxRQ3u4I8zSHbXFGY16f4FiPRFH8hKn8NXn60XN0IIBNnEgB3gXI8uTqyA4lrVeZI9
         aJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719424313; x=1720029113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=me0d/c9yK9kDvYxWMTTKweaXWR7ku/0DGTnTbgCrjkQ=;
        b=kcVZpPeeMvDFI24A/o2ddIE+RATaYpAINVcB11RFNo5W5xQyFEfHLH8X7ctG4tlYC6
         mOp2/6Js16TzNRYrybsdYRnTxBcXzvBgG3i2P1159tGxjcIoGz8H6ekUX0c+8dSSeiqf
         hgitAg37CRWL957FtrnA5M6YQR9ZCR2SP2z+A8ckUHVjr87vVHx2DXU4nUL8EN9K3+A8
         LxW2fs2pTlnWMFaSbiyzO6nkDyZTw6he0AduvenqoKIKR2cotVvlWEPdbT2IsdumzXTB
         NBMZUl6V0zQ94yIj/0A6z2EMGy1DxbYRPx7j+/JYvuIB3okEo/UMZ6jMYESFI+/dsxQS
         fIfQ==
X-Gm-Message-State: AOJu0Yz1aocFRC/VyimnjzRD3d/HbZFn/FkDxrsPE/52WnFllbOcpihC
	jkHzYUUhx2Ppj+v32LHVJ8r2xgdwI+5XigUHH35nAQKhdXD8gpnSdJe2L7/M1wUlREddSqJrb7f
	q
X-Google-Smtp-Source: AGHT+IH6ftAFwEOw+FA3a47tQv3goXoAoao2KSF/vqqq2FpJ7WSTwOjui2arYNy/DA0Yxa939k/vWQ==
X-Received: by 2002:a17:906:b892:b0:a6c:8b01:3f78 with SMTP id a640c23a62f3a-a7245b4cbe0mr591093866b.9.1719424313182;
        Wed, 26 Jun 2024 10:51:53 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7263b3d60esm237805166b.113.2024.06.26.10.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:51:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 26 Jun 2024 19:51:27 +0200
Subject: [PATCH net-next v2 2/2] selftests/net: Add test coverage for UDP
 GSO software fallback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-linux-udpgso-v2-2-422dfcbd6b48@cloudflare.com>
References: <20240626-linux-udpgso-v2-0-422dfcbd6b48@cloudflare.com>
In-Reply-To: <20240626-linux-udpgso-v2-0-422dfcbd6b48@cloudflare.com>
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
index 6c63178086b0..85d1fa3c1ff7 100755
--- a/tools/testing/selftests/net/udpgso.sh
+++ b/tools/testing/selftests/net/udpgso.sh
@@ -27,6 +27,31 @@ test_route_mtu() {
 	ip route add local fd00::1/128 table local dev lo mtu 1500
 }
 
+setup_dummy_sink() {
+	ip link add name sink mtu 1500 type dummy
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


