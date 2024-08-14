Return-Path: <netdev+bounces-118469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AAE951B61
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41C21F2407F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0551C1B1417;
	Wed, 14 Aug 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aRU2vFcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD41AE867
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640825; cv=none; b=pVzMDgxOzrkdyn9UiQ6O3pUKSUOeGLP5AcK5mxETPkovC/QClBiB9HtODvq0ZViat/k8kVBY3zeKQqkaORbfv12z47w8wgs+NxP1Z/BMIyWGUqBDtUswi7RG7M8hUs5Yd1DyxNp+a4CkU270JJd8Xt7ndKy0shaSzcxWVlfwZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640825; c=relaxed/simple;
	bh=yNH29HNWWHeCPSbBtmTNpA5OZ2ZJrWr5Qtn5n6iU4M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnO92y4qzES+C8d/qhHW3UjCICtdoouj0+nciulmdh0RKWuMZP7xhz9gBoa++w1Bw21o1HbTvaWPKjbuvoYiiWWiUN0AqAnZesZsNAjxEF11NCLV7ZUh6a0mL+wZvfE+ThpzNc0JaUdjLaVHAyxx7CxRp82JtvZg4XLQrt73bHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aRU2vFcz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-710bdddb95cso3989961b3a.3
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723640823; x=1724245623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSb9nL1NXkMQuWYyldqJJuCwmx8megk+Vrk+Mj+E3j4=;
        b=aRU2vFczBN/+4KXandcBv3F/uoMfA++xZ4hNNViuM5FH4piwJjTn/lU1nrzTxYT8ha
         y2R1xJbcDTOxKiUIiqASGBApU65JJQvQj1OpPKjf72lAaWgD7/0UNlVv0xlthuen4JEi
         geXzDkeV4ebZjNH9CkyvFhASk6Po7BHWCPUBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640823; x=1724245623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSb9nL1NXkMQuWYyldqJJuCwmx8megk+Vrk+Mj+E3j4=;
        b=P8olhYvqgE0r8L3pr3bQraAAtNkeBeupAS6OfsmRqhr/rTW5sK4OoEO3/F4OdWtFo3
         KsCgK1d8VP8jK5qnqzDrTU+jyO1egEDP6h4okQYPXczEVniUxkpsngaqZFgdBKMbpyP0
         qFzrj9Lt1fhVp330+W4EqCTCva/+uRg+YfNyno9isA0/UpQ/k6Z2f9dbShZaILGXctNL
         VWPWcntJp14Ctjbz8MF5hiv4sK21DJ5kGRgFa6xdX8Grt54ACD6vSlav1LAKnTNOh5BR
         LspMdjvyy6QXE6SVDPcfRQKeJrXlko0R3WdT8o8pQYympR0McsB6i10n5vXL5Ud99/5g
         MxvA==
X-Gm-Message-State: AOJu0YxF46LIDKYZfH52UVIs2/mAxO6ePBeU5R3aatpk3UPliL1Spcl2
	bFEjhvKBC7MT1V9u6bErLETgTNiryMKbqTAnarSE1B2zbsp53EbIMo/O+qKA/Szbv3cLLOvzb7K
	Ei7Rhq9/epRWMMYOcNNbcRdbn4gGVTvKoRzGuZC9toVSQFguVBA3aZeSNw6Bo6pvr38CPb2vo6W
	je0dRAspRK4pFm5dBclfh08eZvwu9d0xbFrz+gkAFkfXeFgbnf
X-Google-Smtp-Source: AGHT+IEkBg5i98a9ytQQCQyqXg1DzSuk0W8IzE17ZS/37iNXx3VWz2bq0aqk6VvSyTCs0yrl9lTPBw==
X-Received: by 2002:a05:6a20:c78e:b0:1c6:fc56:744 with SMTP id adf61e73a8af0-1c8eae97a21mr3243317637.31.1723640823317;
        Wed, 14 Aug 2024 06:07:03 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-711841effe9sm4904543b3a.31.2024.08.14.06.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:07:02 -0700 (PDT)
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: [PATCH net-next v2 6/6] selftests: forwarding: tc_actions: test vlan flush
Date: Wed, 14 Aug 2024 16:06:18 +0300
Message-ID: <20240814130618.2885431-7-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
References: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new test checking the correctness of inner vlan flushing to the skb
data when outer vlan tag is added through act_vlan.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 .../selftests/net/forwarding/tc_actions.sh    | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index 589629636502..65ff80d66b17 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -4,7 +4,7 @@
 ALL_TESTS="gact_drop_and_ok_test mirred_egress_redirect_test \
 	mirred_egress_mirror_test matchall_mirred_egress_mirror_test \
 	gact_trap_test mirred_egress_to_ingress_test \
-	mirred_egress_to_ingress_tcp_test"
+	mirred_egress_to_ingress_tcp_test vlan_flush_test"
 NUM_NETIFS=4
 source tc_common.sh
 source lib.sh
@@ -244,6 +244,26 @@ mirred_egress_to_ingress_tcp_test()
 	log_test "mirred_egress_to_ingress_tcp ($tcflags)"
 }
 
+vlan_flush_test()
+{
+	ip link add x$h1 type veth peer x$h2
+	ip link set x$h1 up
+	ip link set x$h2 up
+
+	tc qdisc add dev x$h1 clsact
+	tc filter add dev x$h1 ingress pref 20 chain 0 handle 20 flower num_of_vlans 1 \
+		action vlan push id 100 protocol 0x8100 action goto chain 5
+	tc filter add dev x$h1 ingress pref 30 chain 5 handle 30 flower num_of_vlans 2 \
+		cvlan_ethtype 0x800 action pass
+
+	$MZ x$h2 -t udp -Q 10 -q
+	tc_check_packets "dev x$h1 ingress" 30 1
+	check_err $? "No double-vlan packets received"
+
+	ip link del x$h1
+	log_test "vlan_flush_test ($tcflags)"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
-- 
2.42.0


