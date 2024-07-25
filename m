Return-Path: <netdev+bounces-112942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD7293BF74
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D04B283B74
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34892198A31;
	Thu, 25 Jul 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eaE0ptpg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B013197A77
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721901373; cv=none; b=cewo0T9xNd2lMeDssCHLF5nx6KrQMer6ZvwfxkGXL+vE8jdnhDJ2e8x/BjCQK+rRl30+w2cTxrQJsFrRgnv2FJFIRi7AC8V6nho1lKknNrmcb++aNjtlp0g1JVFX3nGujl1sUJ79CTrqNug9kBT3qz/fyCjbgJpDCc+j6UMdJm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721901373; c=relaxed/simple;
	bh=qPQTSM7IcfbUzuoV8DlDFOjOuB8GTsu7TDwQZxQLYpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tGn85glK1y37ce7685enM1Su1VSeCatipfA5lN337SwrXiOsCgvr9lS8Sy2y440CdXkEZ6BmpXXilsomfjxTZPa8xs6sZPYrWPgQTDcb7BC0QFV2V6WTim7ehBgFZadH6tj+ZTbce1GZdUqt8nWdC3c5yFM6J/QlJZ4U8ddw/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eaE0ptpg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a88be88a3aso897842a12.3
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721901370; x=1722506170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PfwETKfdGwDLGlkZQb23VY4DnXQY3KKUWxXEbNcWpo=;
        b=eaE0ptpgX5LcBCtjkq1pinWqdGCMlsjxyThTuw6nyCHdTPQ5TdrHeDdb0ZkTkscpne
         dNbPPdr6Rui7etrX6OUcUY1UC1a8DtmShfDh7iUNw48lp2mwN9yvhm2eSb5IqdLw/43X
         JkM3NeXBRKHW7KCsaIl/MCL84wGcCgw7bthHTpumHjaJKKaOUuCHSL27V9rYkBJSIwvl
         3wLdWDv3xjIzzuctTlRimO6AzGRt0LMXoq9PR03yt382z64WaPXFfh+ZMmKYnhgjmF9l
         sqTDc4cAQNdbBQzgJ/PujJ7sCe4Tw4OFbBFzMuJJUrHMLobU2QLA9EA4JbIhN+QRBSZ7
         WuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721901370; x=1722506170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PfwETKfdGwDLGlkZQb23VY4DnXQY3KKUWxXEbNcWpo=;
        b=H+6xAta2plPy3GsLVi7tzCsl0CKh/oU3bcoLVodhoyOpyZDTI8YUasJnEITU45OPfF
         9wz4UbUlvP84KqN8GBdxF3e9EwxTcT6kGDG+p5e6ZDZQmYiZTUkODQxxvUz+3FbsPo0X
         1IrDQOlRfsFoOwWo0vyXpU6JCyErJzscMo+Y4nj1G8Jtmmt/7VYk2GxUTmSUzmoE2O2q
         aGk4DTaurJqoH0zbm+i3W085bX8aX5mw52RU4UnPURJhUmXj86/PUg9/wP22VdD8sMK1
         BYPuJzJaz23vayKbTVYWwvM4aCuqvH73OlsjHuSuaQz3L/+fiyW6RlIFycSQmsNykULA
         u7xw==
X-Gm-Message-State: AOJu0YxE7W5+ErrWEO+K9p4ri6k5KOQnKu2vHbWNrfxEc8ZfkfUiiV+9
	DWHCDHvq1pMXsgcSh8wkhwqpYtceWbJ34h8lwNZxETOxRClVizvUzW7nMM+1RjM=
X-Google-Smtp-Source: AGHT+IFRiD+3+eLwraxYgKmhpwisv5E0bwNTomP69s0eZy5RgcbjeWPlW7l2e3UQXT/saW4nNhsMBg==
X-Received: by 2002:a17:907:948f:b0:a77:cf9d:f495 with SMTP id a640c23a62f3a-a7acb4a223bmr125163466b.40.1721901369741;
        Thu, 25 Jul 2024 02:56:09 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad426aasm54553566b.105.2024.07.25.02.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:56:09 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 25 Jul 2024 11:55:55 +0200
Subject: [PATCH net 2/2] selftests/net: Add coverage for UDP GSO with
 egress from tunnel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-udp-gso-egress-from-tunnel-v1-2-5e5530ead524@cloudflare.com>
References: <20240725-udp-gso-egress-from-tunnel-v1-0-5e5530ead524@cloudflare.com>
In-Reply-To: <20240725-udp-gso-egress-from-tunnel-v1-0-5e5530ead524@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.14.1

After enabling UDP GSO for devices not offering checksum offload, we have
hit a regression where a bad offload warning can be triggered if egressing
through a tunnel device.

This can happen when the tunnel device has checksum offload disabled or
when IPv6 extension headers are present.

Extend the UDP GSO tests to cover the egress from a tunnel device scenario.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/net/udpgso.sh | 41 ++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/udpgso.sh b/tools/testing/selftests/net/udpgso.sh
index 85d1fa3c1ff7..3fb6fea06b28 100755
--- a/tools/testing/selftests/net/udpgso.sh
+++ b/tools/testing/selftests/net/udpgso.sh
@@ -28,9 +28,13 @@ test_route_mtu() {
 }
 
 setup_dummy_sink() {
-	ip link add name sink mtu 1500 type dummy
-	ip addr add dev sink 10.0.0.0/24
-	ip addr add dev sink fd00::2/64 nodad
+	mtu="${1:-1500}"
+	prefix4="${2:-10.0.0.2/24}"
+	prefix6="${3:-fd00::2/48}"
+
+	ip link add name sink mtu "${mtu}" type dummy
+	ip addr add dev sink "${prefix4}"
+	ip addr add dev sink "${prefix6}" nodad
 	ip link set dev sink up
 }
 
@@ -52,6 +56,25 @@ test_sw_gso_sw_csum() {
 	ethtool -K sink tx-udp-segmentation off >/dev/null
 }
 
+setup_ipip_tunnel() {
+	setup_dummy_sink 1520 10.1.1.2/24 fd11::2/48
+
+	ip tunnel add iptnl mode ipip local 10.1.1.2 remote 10.1.1.1
+	ip addr add dev iptnl 10.0.0.2/24
+	ip addr add dev iptnl fd00::2/48 nodad
+	ip link set dev iptnl up
+}
+
+test_tunnel_hw_csum() {
+	setup_ipip_tunnel
+	ethtool -K iptnl tx-checksum-ip-generic on >/dev/null
+}
+
+test_tunnel_sw_csum() {
+	setup_ipip_tunnel
+	ethtool -K iptnl tx-checksum-ip-generic off >/dev/null
+}
+
 if [ "$#" -gt 0 ]; then
 	"$1"
 	shift 2 # pop "test_*" arg and "--" delimiter
@@ -99,3 +122,15 @@ echo "ipv4 sw-gso sw-csum"
 
 echo "ipv6 sw-gso sw-csum"
 ./in_netns.sh "$0" test_sw_gso_sw_csum -- ./udpgso -6 -C -R
+
+echo "ipv4 tunnel hw-csum"
+./in_netns.sh "$0" test_tunnel_hw_csum -- ./udpgso -4 -C -R
+
+echo "ipv6 tunnel hw-csum"
+./in_netns.sh "$0" test_tunnel_hw_csum -- ./udpgso -6 -C -R
+
+echo "ipv4 tunnel sw-csum"
+./in_netns.sh "$0" test_tunnel_sw_csum -- ./udpgso -4 -C -R
+
+echo "ipv6 tunnel sw-csum"
+./in_netns.sh "$0" test_tunnel_sw_csum -- ./udpgso -6 -C -R

-- 
2.40.1


