Return-Path: <netdev+bounces-131021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF598C671
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EDEB22155
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA5E1CDFCF;
	Tue,  1 Oct 2024 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz12xxEe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1901CCEF7
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813126; cv=none; b=WK6S4a4B4zPyO57Ni090X8WpPJai1tx3KwDAHV+JRYFCT88Ecu2lI+R9xyFJI59xUq7Rpae/rmizJjN/jB5IvAChPgkJ7w2B9568LRD9nqU3gP+N6YajhWn6/aIT7wL4OuDr8y4wySjLu3FKIkpt238CMYLE4b32Eu4DND8NiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813126; c=relaxed/simple;
	bh=MNhUx7+sOcsHoHKCioidpn2CiiHb1wJOEmhTksYx5fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h32lsRuiDJGjJVR0/fHEtGZq239PuhlEa59uqgHGPGLrv/eC/ms6yIsNEQBJvlAOq3Gljr/mR9g71dFy1Vn3RMqpEvzWz9JZZNXRWvtlS612+IwBiKutr47qDEAEy6pVdcDyXlGxtHTw4DKjyNCtsk/7Ydjix9L2PbC/OzrErGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bz12xxEe; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4a3b6b00515so75671137.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727813124; x=1728417924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19SXsrz++BxMBPxFEkCWpiQmItk8ImNTEAYXtBuYCms=;
        b=Bz12xxEeWYiL/iwKt1bmykeLktgowfyrfc1UoaDWQSp/KjH6x46xfCm2a6CC1u+i5l
         li3MZUSTQtvHcIkp7HJ5YBfKjrCAaBmlFHHKP3orG49ucX55Pp7gsbsIOkIGdOI9+CXO
         VVxNsNaQ6N/qRGz4uFrQW9hXSpBF+4E+CTy2qZCh/dqLWrk6j/vX2buRr8FDV694w2OT
         ceoAzKhE9vGQ5pz5G8BpgwLIUCLqSTxwHEEFGQ0cuYDeuTRBkVwSSS9JJrazPSJJgwxX
         fFd86hCEIrzYC6zoOfcJW6g+dqdrtM/2jLpaVuqZdPy3zwf503SvuebZJkF/NgtjZCp+
         c4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813124; x=1728417924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19SXsrz++BxMBPxFEkCWpiQmItk8ImNTEAYXtBuYCms=;
        b=JXtHOiDFN6g1FshW6oI7qvHxUleEGyzrEjYG+Pc2ICh0vLZaxMcaULmTxjVI5+adfP
         sJhhtRBXfoKyFbbRdMEr1w0ix3XfIM51dZLWdwJkp81kcSVP6zhXmLAu9wY83jANB/hD
         pp2ur2/mT0t/nrQ1WQW97OawsoIculoh/A+1lmUHGqwx1bl/1mCAtQE3nZhpbFWtTIKR
         OJDQ1jJzGCwYoQFkf1MayWmf4PsBZ7ghkOBzZeHopMFYUHN+RBMdrtjWGy+Yz4EzYF5E
         HOK/ffNIyDNWL9Ajh/65UPUxMrIRBriEqOPsWyQ6bhraf/VsjTY8ml7h5AoUpA11nfnD
         h5WA==
X-Gm-Message-State: AOJu0YxSP1w2QzL/QooPGgmqN78+Tp7DyrVF+CDiJ75XOl2C1pX34rO0
	6PpqJlnWH9F3SYaA8okKhUqEIUbyvaai3gxktqXGZ+ke7ySTF6d6yzziv2tQ
X-Google-Smtp-Source: AGHT+IESfpXLZ1nSsTcqKavfKC8uhSr3M4icROoTaoHgggVt6VaQ9WW4gwqvMKqZGpiiubiCkricfQ==
X-Received: by 2002:a05:6102:290a:b0:4a3:cebe:9dc7 with SMTP id ada2fe7eead31-4a3e6933a52mr461251137.6.1727813123766;
        Tue, 01 Oct 2024 13:05:23 -0700 (PDT)
Received: from ahoy.c.googlers.com.com (182.71.196.35.bc.googleusercontent.com. [35.196.71.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84eb504217bsm1237447241.14.2024.10.01.13.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:05:23 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Geumhwan Yu <geumhwan.yu@samsung.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net 1/3] tcp: fix to allow timestamp undo if no retransmits were sent
Date: Tue,  1 Oct 2024 20:05:15 +0000
Message-ID: <20241001200517.2756803-2-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001200517.2756803-1-ncardwell.sw@gmail.com>
References: <20241001200517.2756803-1-ncardwell.sw@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

Fix the TCP loss recovery undo logic in tcp_packet_delayed() so that
it can trigger undo even if TSQ prevents a fast recovery episode from
reaching tcp_retransmit_skb().

Geumhwan Yu <geumhwan.yu@samsung.com> recently reported that after
this commit from 2019:

commit bc9f38c8328e ("tcp: avoid unconditional congestion window undo
on SYN retransmit")

...and before this fix we could have buggy scenarios like the
following:

+ Due to reordering, a TCP connection receives some SACKs and enters a
  spurious fast recovery.

+ TSQ prevents all invocations of tcp_retransmit_skb(), because many
  skbs are queued in lower layers of the sending machine's network
  stack; thus tp->retrans_stamp remains 0.

+ The connection receives a TCP timestamp ECR value echoing a
  timestamp before the fast recovery, indicating that the fast
  recovery was spurious.

+ The connection fails to undo the spurious fast recovery because
  tp->retrans_stamp is 0, and thus tcp_packet_delayed() returns false,
  due to the new logic in the 2019 commit: commit bc9f38c8328e ("tcp:
  avoid unconditional congestion window undo on SYN retransmit")

This fix tweaks the logic to be more similar to the
tcp_packet_delayed() logic before bc9f38c8328e, except that we take
care not to be fooled by the FLAG_SYN_ACKED code path zeroing out
tp->retrans_stamp (the bug noted and fixed by Yuchung in
bc9f38c8328e).

Note that this returns the high-level behavior of tcp_packet_delayed()
to again match the comment for the function, which says: "Nothing was
retransmitted or returned timestamp is less than timestamp of the
first retransmission." Note that this comment is in the original
2005-04-16 Linux git commit, so this is evidently long-standing
behavior.

Fixes: bc9f38c8328e ("tcp: avoid unconditional congestion window undo on SYN retransmit")
Reported-by: Geumhwan Yu <geumhwan.yu@samsung.com>
Diagnosed-by: Geumhwan Yu <geumhwan.yu@samsung.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9f314dfa14905..4fba70113e893 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2473,8 +2473,22 @@ static bool tcp_skb_spurious_retrans(const struct tcp_sock *tp,
  */
 static inline bool tcp_packet_delayed(const struct tcp_sock *tp)
 {
-	return tp->retrans_stamp &&
-	       tcp_tsopt_ecr_before(tp, tp->retrans_stamp);
+	const struct sock *sk = (const struct sock *)tp;
+
+	if (tp->retrans_stamp &&
+	    tcp_tsopt_ecr_before(tp, tp->retrans_stamp))
+		return true;  /* got echoed TS before first retransmission */
+
+	/* Check if nothing was retransmitted (retrans_stamp==0), which may
+	 * happen in fast recovery due to TSQ. But we ignore zero retrans_stamp
+	 * in TCP_SYN_SENT, since when we set FLAG_SYN_ACKED we also clear
+	 * retrans_stamp even if we had retransmitted the SYN.
+	 */
+	if (!tp->retrans_stamp &&	   /* no record of a retransmit/SYN? */
+	    sk->sk_state != TCP_SYN_SENT)  /* not the FLAG_SYN_ACKED case? */
+		return true;  /* nothing was retransmitted */
+
+	return false;
 }
 
 /* Undo procedures. */
-- 
2.46.1.824.gd892dcdcdd-goog


