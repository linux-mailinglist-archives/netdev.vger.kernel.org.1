Return-Path: <netdev+bounces-167204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDBDA39221
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 05:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94380189438B
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 04:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2C1ABED7;
	Tue, 18 Feb 2025 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxjElHep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC981E
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739853153; cv=none; b=r3FO+zDdJVfZ9XD3UOcKhP89eajyQStsw9EIgt1puDEBjd34PpAlBlrZX84xYfQMMrgmzGt2ah33S/lZpD7F4fdNsbkSA0YWrGRgJzcnSDQlwKTdzJnr3Q4iiPYcNE2HZAmUNkGESczN+NYBGp044K5gGVT6cUxpzRxVXZdFS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739853153; c=relaxed/simple;
	bh=Xvkq8uTdPCJXApQqsNTYajyVZLVKJG8z8rsV3kajv/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbbgxFKpkZDHWYDdGkiJHXL8lgOlXwvdvrruvksGYu91GqpX8Bj8cg/WXIJ5l4Iz8FljGCuMaX7mM+qa3zWNGGAS6qZxhCVObJRaRiyycpqccr+hJk4JDqtRDxow9FiifZMv9ZAZz5TaujGxUZkxur/QKxI7LKiNLplLdIN3b0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxjElHep; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f61b01630so92945655ad.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 20:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739853150; x=1740457950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9cc3S0M29XarWk16c0bKedE92oIPNNchrVRuGkZCz4=;
        b=lxjElHeprVQfuhCsizn8YT76ll3ujS8v2034s3UbpZsNq+ZJpELgO66C3z5LK29xmu
         JoIq80f+DNjryWJYXZEuqHKpp+xaIfYuo1eOT3f48XMzpjWYvnnTVwExDbbOoM0LbL42
         VGzAEamyqJvtanxH54Bnf/Dn27ca3+YisGqGn9ArsVXR5LgzSo23TGDp+pd7CPMghPRY
         AyDFuUaFldut3oegslEppeNrfdKnr1Qo2bKV1l3J8o7XbsgKPs4zVQ0/Ul+FTYaSpOTQ
         PbygRsIMzptB7evsvkvm6tIdR92AAu0mO3/Bd71Rfzmh9ih765+7ikY5a/X1DrSZ7Sc+
         CKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739853150; x=1740457950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9cc3S0M29XarWk16c0bKedE92oIPNNchrVRuGkZCz4=;
        b=OQ9fkpzHz890QwG+ZKiISLOF/jc0JW4cmChLU2nFadMNLh09OAoIZxFi4fd43OLk7W
         wWWlZm6DsiUsFz3NGqXaogclcZaXRvZbTvYGEaU1gMTrBdAWMME3TwXTO0F4Ly8Ef9zv
         1FIu+3vvcCRYyM5EIuebYcWycQfh8D4LtJlQHmGM/O5ZBormx3cd0IkGyj62J1zULrpZ
         Fk6fxwKtqGT01989KgJPOMlS1R5IQ4+O3yUBbghTxGHuPms2SKyZs09xv442JDLewkB/
         Mbj05uQSNcSqL0b04G4B7gQtHpmyyIFkCkpXUbnedEaHH++vXiIImHPU8r1kJsSF3wlf
         xz1Q==
X-Gm-Message-State: AOJu0Yxln1blo6QMbMDBHN/yoKbaVPfqo6fG9voq/kmfON1CMWWrCofK
	zZbC8lTaRRG07ljVX5Vcyr15t439SyQ1ai4OlECYQkMOf1/+hv4RCfvpyw==
X-Gm-Gg: ASbGncvbJUBIHwwaj+5xHv72tS0oWQkiJA38IYx243xcy6LVrxBLDRrVVbEJ2rbOPHE
	11Hz1Tufv/vT5X5uX+ueqE95W8lfFcQfHcntacYpusMNE/bi/cF4X/y8J/PqyYWsLW8CAOKvE8r
	5IP6Jbl3G6TXXSrKTkb66PG716JUcmnp75tyxKXtjaJS8jzoSZ+7giGa7pExY3EKVPJ05rnX/4R
	7eI5rWzViabD5BBxFudIhwJCJ99dZCFj5irRsZuCbQbq//LhwPwNTfIuQrWmMKc6nY4CUkEJXp7
	FHOKkDh8G5AkQLsmHBAoasJzcc/usKVPxp5dMZ9CclYs
X-Google-Smtp-Source: AGHT+IGZDq0t68bwJV/7aryfXyU4n4p+gD+6mJZuUpTVdm0rlQ7AV9FqqJPKQ109iRPcpfi3SrsMBQ==
X-Received: by 2002:a05:6a21:4014:b0:1ed:a5f2:dba6 with SMTP id adf61e73a8af0-1ee8d7acd39mr19917439637.14.1739853150456;
        Mon, 17 Feb 2025 20:32:30 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:304e:ca62:f87b:b334])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326aef465dsm4907501b3a.177.2025.02.17.20.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 20:32:29 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	Qiang Zhang <dtzq01@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [Patch net 2/4] selftests/net/forwarding: Add a test case for tc-flower of mixed port and port-range
Date: Mon, 17 Feb 2025 20:32:08 -0800
Message-Id: <20250218043210.732959-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
References: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After this patch:

 # ./tc_flower_port_range.sh
 TEST: Port range matching - IPv4 UDP                                [ OK ]
 TEST: Port range matching - IPv4 TCP                                [ OK ]
 TEST: Port range matching - IPv6 UDP                                [ OK ]
 TEST: Port range matching - IPv6 TCP                                [ OK ]
 TEST: Port range matching - IPv4 UDP Drop                           [ OK ]

Cc: Qiang Zhang <dtzq01@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../net/forwarding/tc_flower_port_range.sh    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/tc_flower_port_range.sh b/tools/testing/selftests/net/forwarding/tc_flower_port_range.sh
index 3885a2a91f7d..baed5e380dae 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower_port_range.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower_port_range.sh
@@ -20,6 +20,7 @@ ALL_TESTS="
 	test_port_range_ipv4_tcp
 	test_port_range_ipv6_udp
 	test_port_range_ipv6_tcp
+	test_port_range_ipv4_udp_drop
 "
 
 NUM_NETIFS=4
@@ -194,6 +195,51 @@ test_port_range_ipv6_tcp()
 	__test_port_range $proto $ip_proto $sip $dip $mode "$name"
 }
 
+test_port_range_ipv4_udp_drop()
+{
+	local proto=ipv4
+	local ip_proto=udp
+	local sip=192.0.2.1
+	local dip=192.0.2.2
+	local mode="-4"
+	local name="IPv4 UDP Drop"
+	local dmac=$(mac_get $h2)
+	local smac=$(mac_get $h1)
+	local sport_min=2000
+	local sport_max=3000
+	local sport_mid=$((sport_min + (sport_max - sport_min) / 2))
+	local dport=5000
+
+	RET=0
+
+	tc filter add dev $swp1 ingress protocol $proto handle 101 pref 1 \
+		flower src_ip $sip dst_ip $dip ip_proto $ip_proto \
+		src_port $sport_min-$sport_max \
+		dst_port $dport \
+		action drop
+
+	# Test ports outside range - should pass
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$((sport_min - 1)),dp=$dport"
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$((sport_max + 1)),dp=$dport"
+
+	# Test ports inside range - should be dropped
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$sport_min,dp=$dport"
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$sport_mid,dp=$dport"
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$sport_max,dp=$dport"
+
+	tc_check_packets "dev $swp1 ingress" 101 3
+	check_err $? "Filter did not drop the expected number of packets"
+
+	tc filter del dev $swp1 ingress protocol $proto pref 1 handle 101 flower
+
+	log_test "Port range matching - $name"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
-- 
2.34.1


