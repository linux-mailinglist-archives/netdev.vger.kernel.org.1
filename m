Return-Path: <netdev+bounces-79501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C45879892
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 17:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FD428185E
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636B87E585;
	Tue, 12 Mar 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WfeGElob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4EF7E561
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259813; cv=none; b=ANoEO582/OVhkkYDW8Cn6fsCm74qS9PgQhy+aGKzknI71wIskRcMjrFr5Qm8Sj0dXigyrKY2OYAmOo5as0CNwMqbHh4iA0tSHiv2BMQ3VgV17jn42keGE8gWosArHA6Gi7kgo2Zgm9vl2hGfWKD4NF8SMIDkA85Mz1wND9MCl08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259813; c=relaxed/simple;
	bh=Fc7O8sfBRRb8zOY1eOkMRYKNnB5ApRvE6ZnNgsRMbYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AAmEDVdp1fd+OnFI3HSaY21vumA/n9+u82wD0czknwnIU5slh1EOh+SfeCts2JIIAzgXF+UFF9tF3+Sj5463Zdd+7s9is11cpcMZzIGNZyfg/5VMUb0vcoj9ZDuV8VVtBTW0ycfHtZEHErguVlraZGe1061xPp7HiBkl8ozof/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WfeGElob; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41330d48a29so9465075e9.3
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710259809; x=1710864609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wNUX9DZCZhkOtkzBdWY6lDTHbYdRFBZXQzvAC4CccA=;
        b=WfeGElob94iVcNvEUrLD+hD8IJpTbHvgaI3ykcUz8EI9MyeYXhnmblK0VLvuzDGKsL
         oKXQtHwEO1cmNl5w4j2qseyBWbAazM1QmqOzgOthxNx3OKFIaDhZvU42AKfwwmZPg41m
         LTLf0BDBJ99PkNAT0M+hff4C6aieJsbpfwCIIKuxlr8cN0lFON4R11oxp3GvHnXUbfSA
         xr1NKAzkqFqX7YSCTYWTrypKMyBQ8XsxnNzDIEFQ8cl5BSKKXdD4lH6W7ylDOYOIm8Sg
         D/U7aPYXT43vgaGjOPX2iVG0G1YsD/AvjjK9SJtEZ/ckdrLLgN6USca979ApfivmtwpI
         ILeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259809; x=1710864609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wNUX9DZCZhkOtkzBdWY6lDTHbYdRFBZXQzvAC4CccA=;
        b=g4yARKAU7Voh0g78V1ERNXFQbC4UO/Q42jifxHcTROePlTHDA9c3v/FTdESe3SVYnU
         T5LYcjD+FvWygR1y/caQL/7OhHyTjgloNLE30EdomCqRAOIdzQNTweZOa9OKeKxfVh/R
         kE1oeWrmXiRd5KyJLelOcRVa6elRWfDH2sCPZykqrgBLQOJP7kG05Z4ddoC4o/1bWgNS
         FihxCOtBl2N6jVhNmn8qY1HBlr1gs49PjuYGpGRBGo9kieJMceVB2Of9ZGgvgFR66o6x
         c7h3LP0FAncds+T0luuNGAeHQmxqSh31GQyMrF3OWrNoSLXBEmvi7guBPC7s1KnsIyrP
         vv8g==
X-Forwarded-Encrypted: i=1; AJvYcCX/axtR/9vl0PnI4QM0yop8jqYyHAR/uvaold9lDRG6aFkvub27jO9r8yTGw3ZFrK93NRMnnxwPNHTTDPs8pXpRo9isbLD+
X-Gm-Message-State: AOJu0YyhMBVvCB/j6lw2HjjcybzONvLEtbPpfVBw7V4CvC12g/EWTfBl
	jT1bVauOasF8jd9SMBTPaf4ahb2MLNtiMt5brK9Aw4LRHSycCwj0OlkOOyhpB58=
X-Google-Smtp-Source: AGHT+IF+bWouiIFf+uP88Mr8eQSuWHP1533kqdq4LfgBW7SC7cEl/s7h/DffeGifPPsn3+G8rECSuw==
X-Received: by 2002:a05:600c:4690:b0:412:95fb:e41 with SMTP id p16-20020a05600c469000b0041295fb0e41mr1840249wmo.24.1710259809271;
        Tue, 12 Mar 2024 09:10:09 -0700 (PDT)
Received: from localhost.localdomain ([104.28.232.7])
        by smtp.gmail.com with ESMTPSA id fl8-20020a05600c0b8800b00413e523b7f9sm474253wmb.43.2024.03.12.09.10.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Mar 2024 09:10:08 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net v2 2/2] selftests: net: veth: test the ability to independently manipulate GRO and XDP
Date: Tue, 12 Mar 2024 16:05:52 +0000
Message-Id: <20240312160551.73184-3-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240312160551.73184-1-ignat@cloudflare.com>
References: <20240312160551.73184-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should be able to independently flip either XDP or GRO states and toggling
one should not affect the other.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 tools/testing/selftests/net/veth.sh | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 5ae85def0739..3a394b43e274 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -249,9 +249,9 @@ cleanup
 create_ns
 ip -n $NS_DST link set dev veth$DST up
 ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
-chk_gro_flag "gro vs xdp while down - gro flag on" $DST on
+chk_gro_flag "gro vs xdp while down - gro flag off" $DST off
 ip -n $NS_DST link set dev veth$DST down
-chk_gro_flag "                      - after down" $DST on
+chk_gro_flag "                      - after down" $DST off
 ip -n $NS_DST link set dev veth$DST xdp off
 chk_gro_flag "                      - after xdp off" $DST off
 ip -n $NS_DST link set dev veth$DST up
@@ -260,6 +260,21 @@ ip -n $NS_SRC link set dev veth$SRC xdp object ${BPF_FILE} section xdp
 chk_gro_flag "                      - after peer xdp" $DST off
 cleanup
 
+create_ns
+ip -n $NS_DST link set dev veth$DST up
+ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
+ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
+chk_gro_flag "gro vs xdp while down - gro flag on" $DST on
+ip -n $NS_DST link set dev veth$DST down
+chk_gro_flag "                      - after down" $DST on
+ip -n $NS_DST link set dev veth$DST xdp off
+chk_gro_flag "                      - after xdp off" $DST on
+ip -n $NS_DST link set dev veth$DST up
+chk_gro_flag "                      - after up" $DST on
+ip -n $NS_SRC link set dev veth$SRC xdp object ${BPF_FILE} section xdp
+chk_gro_flag "                      - after peer xdp" $DST on
+cleanup
+
 create_ns
 chk_channels "default channels" $DST 1 1
 
@@ -327,11 +342,14 @@ if [ $CPUS -gt 2 ]; then
 fi
 
 ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp 2>/dev/null
-chk_gro_flag "with xdp attached - gro flag" $DST on
+chk_gro_flag "with xdp attached - gro flag" $DST off
 chk_gro_flag "        - peer gro flag" $SRC off
 chk_tso_flag "        - tso flag" $SRC off
 chk_tso_flag "        - peer tso flag" $DST on
 ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
+chk_gro "        - no aggregation" 10
+ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
+chk_gro_flag "        - gro flag with GRO on" $DST on
 chk_gro "        - aggregation" 1
 
 
-- 
2.39.2


