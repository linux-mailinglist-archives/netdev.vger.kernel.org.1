Return-Path: <netdev+bounces-119674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847B99568FD
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C80E283FDB
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51487166F14;
	Mon, 19 Aug 2024 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TvgbulfJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654915535B
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065607; cv=none; b=hl/jCioNEet5DWC7w/Nsy2YhUpLksO54vtE52OJtHWcaUdTU217UPH3JWADNsb9pZail5UHw9eVAnX9TFCDBUe3/jpK1Ec1pRQkIwsOeOMD/KdXDUIk3LoiCGt6cv4/gqpdvFwD8uPFSzyqKL98ZixmxTRpRdPy9IFE2MWY0Hq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065607; c=relaxed/simple;
	bh=Lhw+EJIzGQi4132lxIagTDi6xBVS/vZELXzYQ9g4xUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okNCSBHb52weGWsLjn9EywY3UfTo5ANgWkWHhtZan3k68onkJ7QL5q/F1hbHgR6RDYE+nF4gEQpukQ6gqPyYDW9j5NaVvEzw1d08Uwvoezj/YSnXEfx5rHMqrMywixxApopr8nOalIFiJUTFQHk2/DEL5HYDRIpV+2WqEmn/FvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TvgbulfJ; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db18c4927bso2423728b6e.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724065604; x=1724670404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xh6Hmi0uPWAq1EzRKIGF9fSV7CZNe7f3f2yDixp6Zko=;
        b=TvgbulfJoFKDwpe7ELkATfqdylcUtoV1+aIspqKfLNG6ux9Q2yxKMzV1PeA/u+o6o4
         yDhs3rr1RRPN4IJQ/4GYDWO0B7qffSLvZyS42a8dRLdhRqfpfZN0RWN1vtDvnG0ZC4uk
         LvNf+CioP+ucNQQm7pd1d3LwSr871e3ZmMfLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724065604; x=1724670404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xh6Hmi0uPWAq1EzRKIGF9fSV7CZNe7f3f2yDixp6Zko=;
        b=NY7d15IP4KIf3hOc8cHxUPIj4RxEcBL65wHfl2GBonK63b98xVoAtl+sduKH+5lQQL
         kwCTMAoLU837TPhhpyj7e7kqF6MD4OmcwIoFaHMe/mnhQNdKm/3poZc+MU8Ubi7Bk2YM
         rBD1MJqrupmCLYuACaMMTxt4AqkR1BUbG1lmZMaWY7/IjALS3tqXoXBk1uzqHiCFjjMG
         mtj8YVxzPZcasN/PKlVbeMGvFSG223DZLDtB1/bNuL+MqJFMKm314tW6/zzTfJoT23UO
         g7K/XYyuNruQli9XlAOaoP5xgM8hbwI9cN3uNDStam5QJkjuW1AGPJYvER4RXnv5ZdUg
         s/iQ==
X-Gm-Message-State: AOJu0YyftrRrAwVitdSSD0AmRm3M7g52M9afII2pFigGshnBAS3cELpR
	YGrxPgHeqK0pYmYl9GUP/RVwQdKrqbZY7JXkjXCZBWZd51bixeKXrMpNmz9WIkO9TQJJOilri0L
	bxPRXiIJw1ckL8X+YCkedhbp4FkWuLGgqGU49adYT4i9N4EexrHfohHqLFxH3gLQ7sBOk8pdwuY
	sI8B0aVi5BJqJa53FvvqFum/6FGFVNegY/J3m771YYUIDEDIAq
X-Google-Smtp-Source: AGHT+IE+X5bjrPIc6dlUIfZARh7SlbjlQC2o0TRImlG0FurgQAEpEvOAKrGZOopcNXk8byaVSFqOfA==
X-Received: by 2002:a05:6808:222a:b0:3da:ab89:a806 with SMTP id 5614622812f47-3dd3ad5239bmr11164075b6e.25.1724065604014;
        Mon, 19 Aug 2024 04:06:44 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a072237sm38751911cf.86.2024.08.19.04.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:06:43 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/3] selftests: tc_actions: test ingress 2nd vlan push
Date: Mon, 19 Aug 2024 14:06:08 +0300
Message-ID: <20240819110609.101250-3-boris.sukholitko@broadcom.com>
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
data when outer vlan tag is added through act_vlan on ingress.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 .../selftests/net/forwarding/tc_actions.sh    | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index 589629636502..f2f1e99a90b2 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -4,7 +4,7 @@
 ALL_TESTS="gact_drop_and_ok_test mirred_egress_redirect_test \
 	mirred_egress_mirror_test matchall_mirred_egress_mirror_test \
 	gact_trap_test mirred_egress_to_ingress_test \
-	mirred_egress_to_ingress_tcp_test"
+	mirred_egress_to_ingress_tcp_test ingress_2nd_vlan_push"
 NUM_NETIFS=4
 source tc_common.sh
 source lib.sh
@@ -244,6 +244,27 @@ mirred_egress_to_ingress_tcp_test()
 	log_test "mirred_egress_to_ingress_tcp ($tcflags)"
 }
 
+ingress_2nd_vlan_push()
+{
+	tc filter add dev $swp1 ingress pref 20 chain 0 handle 20 flower \
+		$tcflags num_of_vlans 1 \
+		action vlan push id 100 protocol 0x8100 action goto chain 5
+	tc filter add dev $swp1 ingress pref 30 chain 5 handle 30 flower \
+		$tcflags num_of_vlans 2 \
+		cvlan_ethtype 0x800 action pass
+
+	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -Q 10 -q
+
+	tc_check_packets "dev $swp1 ingress" 30 1
+	check_err $? "No double-vlan packets received"
+
+	tc filter del dev $swp1 ingress pref 20 chain 0 handle 20 flower
+	tc filter del dev $swp1 ingress pref 30 chain 5 handle 30 flower
+
+	log_test "ingress_2nd_vlan_push ($tcflags)"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
-- 
2.42.0


