Return-Path: <netdev+bounces-119675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C499568FE
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD219283F17
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F401607B0;
	Mon, 19 Aug 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WQ8qJGhM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA641607A7
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065613; cv=none; b=p9Rty5B8nyIf2n8dERDR8mfIBa2yHdbl1gMdRuLKM4ZTT44bG+2txEsmC1acnxy0LFQ1nMKD0UtjWm/xVij1VEElPslxq/rNKMJ0/aLXkBygHZWZ10FSqknEZqsU11tLVzbg+tWgX5Xqsvdp4VcAf3UZhJ1IvMbbtfEl7tIOtMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065613; c=relaxed/simple;
	bh=2rvQ16eUsSUI86NjGJaanw+rVAkWujnMIDdufrVcTt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbGuc/sBBgzhubRtwFesurUYFO91IcWs0FzcFz9RKP0416p9nilM/5GhFLXywoKCEndsVnGSUEb6qBGswpiSHb4TMwTNErday/uGluwVt5HS9BRdzPiSjBJjUmufd3DvchEZFb9QXM7CppYrGPDJbOebaJakD1NT9s5HuxO7zwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WQ8qJGhM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44febbc323fso22164451cf.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724065610; x=1724670410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64T1/IUPdIC0djcgy0Ye7/9E+JF1//L5kmNcl5se5Cc=;
        b=WQ8qJGhM7S3bBdyNs2jKqu+CRhf99jwbBDumgXSSFHuTVqIULXWLhbWE+JS8rOqSk/
         +HwNobIr51453zKyqgXFomrWQID4LDMlv/LZxlWkA0L09qr0p2vJdaC/Jz6L70Ax36+O
         uUHMF2m/Mm9qjKuM27ZaBS+8L/ZLZHiNATDJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724065610; x=1724670410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64T1/IUPdIC0djcgy0Ye7/9E+JF1//L5kmNcl5se5Cc=;
        b=h32k/v8lrmG+ABacGjfuxsaEQ9SH7ifnZJ75cvhLHrtO5QiCihsUFGq504GD5KdETg
         8nipCV6RDqgNcG9yxDboOL5jxNzihv343ZKP7w8gcaWPjymJMB0l0lQblpJN1HlA6J9E
         w4Wyt98zcoVHrwqsf0VZfToSpCIZGaDgi5PPbqr2a7QWetBqEgTqQmXhZRGp35aO+IYp
         zbvqYUyO5Y1OGMrfUb6EmHPdIOFyN8DbBtX9zAn3T5DaZOjowLDUdiUQ8HKhDfzwoSdZ
         yW+zTKGOJSl4kliI8rmyVM5U8TPqYBWWodAxqWHex0VE1sVpco2b347wzycozBYDrJOW
         uMXw==
X-Gm-Message-State: AOJu0YxDu4GJcez31ycmCK6Cc6on1dmSeilSaclaBUtMZnJ6o6BnT1yI
	NHvvaqaNU6ldxyo6KVhwrrIvWRYUgFKDgBCCVvSCdSb3YL+DYDgAAq/8ctzXWayUdj2bziD/gl9
	CCH2M80NxVJtghjdmlnh30aMOCs7LW4SaP4zuXAki0H2t2hmAYu1UEmJ4GJC36cry7C203qpMxe
	8GEzXWO7+kQXSm3n65vU/UjqNWEZq8DNyPw0TKrVAEg9R9bsn+
X-Google-Smtp-Source: AGHT+IHhXcmVZzxC9OyrMmo+i+21aEcmHiWzWpBDIOumSUc/Keo47NUe1J7/Nx9FGAV6+O/0xt9n7Q==
X-Received: by 2002:a05:622a:4d90:b0:453:6d98:4802 with SMTP id d75a77b69052e-454b68d3e71mr85095931cf.47.1724065610279;
        Mon, 19 Aug 2024 04:06:50 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a072237sm38751911cf.86.2024.08.19.04.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:06:49 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/3] selftests: tc_actions: test egress 2nd vlan push
Date: Mon, 19 Aug 2024 14:06:09 +0300
Message-ID: <20240819110609.101250-4-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240819110609.101250-1-boris.sukholitko@broadcom.com>
References: <20240819110609.101250-1-boris.sukholitko@broadcom.com>
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


