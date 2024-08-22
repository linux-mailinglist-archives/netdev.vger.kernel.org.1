Return-Path: <netdev+bounces-120916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6560695B301
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFDF1B21744
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F7183CA3;
	Thu, 22 Aug 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f+1ESPNR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAB183061
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322950; cv=none; b=J3Ez6tbjj5sIALOOeMOpG/VwuaT7THo9tgMhMetdWFJ2YwQYn+kE/KWdAsZM9U1fOx/uz1DT4/eXPYDSgzxTuSAiVETo8gBa7LeSholXSTIVFcF9pE1UWsa4BEvIq592F5YqA/pbpiC2hPEqnw4POGWvk5Ua+ALPt7RwuEXJt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322950; c=relaxed/simple;
	bh=Lhw+EJIzGQi4132lxIagTDi6xBVS/vZELXzYQ9g4xUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpntlfOQMpHQU7GlIE0gcpOY8hAVNxAcTdrP+cbWu8psc3+rwO8jy3A98nrtHCP3gEBa+naf9CKhK56iw7zoCDrl+meZ/VaHn01pKXvUK9otsoN6dLE6ruY5gvmGhCAeiFkd/Bv4YOHub22l2uu5VDI22b9GHlxBXnvgZybYeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f+1ESPNR; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-27051f63018so385021fac.3
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 03:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724322947; x=1724927747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xh6Hmi0uPWAq1EzRKIGF9fSV7CZNe7f3f2yDixp6Zko=;
        b=f+1ESPNR0F0NHCXoPBVRP9bD3dj0GP5CI4Ya3wwGTCvPgLzEfr/2AlOCMwBDP7AmMt
         Egiplq2yEZNCOOmv8niiIRlIz8q8DNQjFMKA6dr34L5tPFnWDR1+qRr+UXGbK4w7gha8
         COu5QHvCmY+ckGZiXBMvC2WkQ/9TDV4+zqry8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322947; x=1724927747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xh6Hmi0uPWAq1EzRKIGF9fSV7CZNe7f3f2yDixp6Zko=;
        b=VvmHIoW1QHIj5S7ivcpgF4FzlXm1btJfHZ4eXCQdS9q72Uz2eySXkNA3M5ESDVUFpV
         nlcMdCb/OALiJLFKoBZbFZOrFLh1zT8LKBiQovdGRgHAp45MfXfibSYTr0y/4y2Yilst
         wKYsUY0DmHZJ157Q1g691PuLS1jkLACulNWppoSf+hZ2gaZCeurcedL+lYG2yKF5Cjq9
         M48rEAZzRB/UAkzxlMp1XRK7MjTzBOfMHBaFdGX2XX3+q8w/EPGFt9T8eRIzRUYI5QC+
         eNs/ddkUs+sXW3kjjVpr7ViXbAKrW3K7l57I6KRr/SROY3KYZEy6aCZMem0FhRIbZCm1
         5cEA==
X-Gm-Message-State: AOJu0YwQY555U9KJfNhw+YDwSUGtg4bOOsim6BiKhCVcRbLNEUByUvvv
	Efl3S170DAqYwYXueEmODo2n9IeQp7rnSHI8cUTFX89Q27mKZ1ZaIkOKYKwLAxGCgRGrGV/L7EK
	eq5uYBrPDx3vTS/cC1L6N1sfaQTph3AdO2dEjjEAR8Yf//ob01fk2RmJX72g+36mAkOiDA+tPJt
	IF/lFbX88Pp93NT7/VbyZCyNMPsRFIQ+ZnUMwxpgZdMqJfJ+R8
X-Google-Smtp-Source: AGHT+IFyFFgszbcL4kWRtTovFaQ6X7mRv/h1Ji8NXSKpsGXdAc2qDJ3LvsdWCKtQY4VLRmP2FWN0QA==
X-Received: by 2002:a05:6871:80c:b0:25e:24a0:4c96 with SMTP id 586e51a60fabf-273cfbf00b2mr1616310fac.11.1724322947152;
        Thu, 22 Aug 2024 03:35:47 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cda0ada9adsm495546a12.26.2024.08.22.03.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:35:46 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/3] selftests: tc_actions: test ingress 2nd vlan push
Date: Thu, 22 Aug 2024 13:35:09 +0300
Message-ID: <20240822103510.468293-3-boris.sukholitko@broadcom.com>
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


