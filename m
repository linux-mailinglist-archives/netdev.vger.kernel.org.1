Return-Path: <netdev+bounces-120917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C4595B302
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349141F24046
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C841802DD;
	Thu, 22 Aug 2024 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lo+uXTIB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999B17DE16
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322959; cv=none; b=S6nSc46vf3ZY7a7OxLhsCq0TzJZQgYSL+BMEANFsMu6bqAbaWz4QmDk8pebgrFg7K2hLHGy55RoDvRlygPm14NTXqQuoL01erV3i9Azvrgewn43nS6MCT6hn7izlxZ2j0ScHJ0ej9Z1GbmYd8gjE8j+K8dqus9PLC++4YmbRf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322959; c=relaxed/simple;
	bh=2rvQ16eUsSUI86NjGJaanw+rVAkWujnMIDdufrVcTt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nd5XOxBx0YaoHD2aeg67WelH+AOElzJWE2PJIJhbvMfas/I2aim+cToBJK/a5xHa4hu9MaF+b3A1TSB6uHCvSEvcEevRsOGC5qlFB2qk/1bLavV9jaAq9uO+bb/958MSzEWXHAil//DqWoKN0VM6snmmuESKF4L5k8i5EafxlQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Lo+uXTIB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71431524f33so567692b3a.1
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 03:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724322956; x=1724927756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64T1/IUPdIC0djcgy0Ye7/9E+JF1//L5kmNcl5se5Cc=;
        b=Lo+uXTIBeKLslR3JKxyFzWYSYgDkon1gzlEwJI+BPqsPq4j0R3v9XbZR4evExYG1+H
         +YqYz/z/69z2F8hwnLXXM81b4JemC5mPcs0HEQYfI1lbZzZjwUu7E/KyVgzJuXN8xDmC
         48HP7JSq0htAWihG1CLWe2fBr6qpSTjSTUXlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322956; x=1724927756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64T1/IUPdIC0djcgy0Ye7/9E+JF1//L5kmNcl5se5Cc=;
        b=CLZjb2hRpxiAa4E1tDVW9RFhMJ+jzoA13XMSMu5CEXp2l2TMr6LgSu4TQY1Fhh263k
         dx5braZ7fU5q2AFh/sQsXWPUdXZIX0ln/gqIZmWf06ilDLuBBqNKhNknu4eMcUqkNOEW
         Gd93g44ReBscrwd9qIeLcnQyOWKYy+aSQB+sS63r1IHOOvE1pK78P6kmiHWhIHZ1wTKL
         ZwUNus0h9ule48JgZPj1ZNKD4HKea+gq5hKmu3uEQshUUhowCT4zRTN8GO69G2kqvsNZ
         i6ckgylocXm7OCkhcnxsK62XFT/xFhWxADZvDZheA8zSBFTO46SzQzRXD2OI0+GRGIWr
         68Tw==
X-Gm-Message-State: AOJu0YznNpFAtQz+EiiQYvXZ47rOmO4hkeBp73ThzXWhtiILxrorrLN8
	9eR6EuRQ3Hd8QcdPneqVQm8JxbpKJS5KaczVZdFFSQnZaMVoh9AfVNW+3Xduim4rndhgzaZoc8F
	AsHX6HhcAyuefjR5drnFG6tOsEG62i/iraFuoZu6gmUDyNQPIS9lS8OCD+A9lEHDrn0fSk5pK1I
	AgIKMaySKa+6UC+BVkB6Q3evw8FcTlPYrp5TINsxhFb3Vn5KNq
X-Google-Smtp-Source: AGHT+IHt2vhhJAtEaBoeBrRYdL7PbiDDkNn7hW3X4P73ka/bjZzAK1s2CAECy3+HIWcXI+USM1sUDw==
X-Received: by 2002:aa7:88c9:0:b0:704:2563:5079 with SMTP id d2e1a72fcca58-71423551f72mr6747326b3a.27.1724322956316;
        Thu, 22 Aug 2024 03:35:56 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cda0ada9adsm495546a12.26.2024.08.22.03.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:35:55 -0700 (PDT)
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: netdev@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Howells <dhowells@redhat.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Ido Schimmel <idosch@idosch.org>
Cc: Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: [PATCH net-next v4 3/3] selftests: tc_actions: test egress 2nd vlan push
Date: Thu, 22 Aug 2024 13:35:10 +0300
Message-ID: <20240822103510.468293-4-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240822103510.468293-1-boris.sukholitko@broadcom.com>
References: <20240822103510.468293-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new test checking the correctness of inner vlan flushing to the skb
data when outer vlan tag is added through act_vlan on egress.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 .../selftests/net/forwarding/tc_actions.sh    | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index f2f1e99a90b2..ea89e558672d 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -4,7 +4,8 @@
 ALL_TESTS="gact_drop_and_ok_test mirred_egress_redirect_test \
 	mirred_egress_mirror_test matchall_mirred_egress_mirror_test \
 	gact_trap_test mirred_egress_to_ingress_test \
-	mirred_egress_to_ingress_tcp_test ingress_2nd_vlan_push"
+	mirred_egress_to_ingress_tcp_test \
+	ingress_2nd_vlan_push egress_2nd_vlan_push"
 NUM_NETIFS=4
 source tc_common.sh
 source lib.sh
@@ -265,6 +266,28 @@ ingress_2nd_vlan_push()
 	log_test "ingress_2nd_vlan_push ($tcflags)"
 }
 
+egress_2nd_vlan_push()
+{
+	tc filter add dev $h1 egress pref 20 chain 0 handle 20 flower \
+		$tcflags num_of_vlans 0 \
+		action vlan push id 10 protocol 0x8100 \
+		pipe action vlan push id 100 protocol 0x8100 action goto chain 5
+	tc filter add dev $h1 egress pref 30 chain 5 handle 30 flower \
+		$tcflags num_of_vlans 2 \
+		cvlan_ethtype 0x800 action pass
+
+	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q
+
+	tc_check_packets "dev $h1 egress" 30 1
+	check_err $? "No double-vlan packets received"
+
+	tc filter del dev $h1 egress pref 20 chain 0 handle 20 flower
+	tc filter del dev $h1 egress pref 30 chain 5 handle 30 flower
+
+	log_test "egress_2nd_vlan_push ($tcflags)"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
-- 
2.42.0


