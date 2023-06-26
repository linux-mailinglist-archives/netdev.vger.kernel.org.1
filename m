Return-Path: <netdev+bounces-14070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A52B373EC47
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 22:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17981C209CB
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 20:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D3E13AE5;
	Mon, 26 Jun 2023 20:58:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA8125AA
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 20:58:57 +0000 (UTC)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68C612E
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687813136; x=1719349136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z9AeFae5oxfbMq2p6Y7QNUKQcwFZC9LZuHt5dWF0Nso=;
  b=ZjVQwpqj+sJTdALYY+TfkALGye4OCZAF5rZYuf3h2Uy1L5jVifKDjexi
   J1CIjXHU6X/fp1dsJFM9SbFx6+4Gi9B4CvCI7jPkGmDIBcBDepttk/mZN
   +lSzloYX094r8TzvhafLawq8kA5VF3boRPc6XVNVhFitq9KHGv0CUr67+
   U=;
X-IronPort-AV: E=Sophos;i="6.01,160,1684800000"; 
   d="scan'208";a="347934330"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 20:58:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 49AB7807B0;
	Mon, 26 Jun 2023 20:58:51 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 20:58:49 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 26 Jun 2023 20:58:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Konrad Dybcio
	<konradybcio@kernel.org>
Subject: [PATCH v1 net-next] Revert "af_unix: Call scm_recv() only after scm_set_cred()."
Date: Mon, 26 Jun 2023 13:58:37 -0700
Message-ID: <20230626205837.82086-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.15]
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This reverts commit 3f5f118bb657f94641ea383c7c1b8c09a5d46ea2.

Konrad reported that desktop environment below cannot be reached after
commit 3f5f118bb657 ("af_unix: Call scm_recv() only after scm_set_cred().")

  - postmarketOS (Alpine Linux w/ musl 1.2.4)
  - busybox 1.36.1
  - GNOME 44.1
  - networkmanager 1.42.6
  - openrc 0.47

Regarding to the warning of SO_PASSPIDFD, I'll post another patch to
suppress it by skipping SCM_PIDFD if scm->pid == NULL in scm_pidfd_recv().

Reported-by: Konrad Dybcio <konradybcio@kernel.org>
Link: https://lore.kernel.org/netdev/8c7f9abd-4f84-7296-2788-1e130d6304a0@kernel.org/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
To maintainers

Sorry for bothering, but can this make it to the v6.5 train to
avoid regression reports ?
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f2f234f0b92c..3953daa2e1d0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2807,7 +2807,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	} while (size);
 
 	mutex_unlock(&u->iolock);
-	if (state->msg && check_creds)
+	if (state->msg)
 		scm_recv(sock, state->msg, &scm, flags);
 	else
 		scm_destroy(&scm);
-- 
2.30.2


