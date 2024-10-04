Return-Path: <netdev+bounces-132211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0856D990FA0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5421C23257
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D401D90A6;
	Fri,  4 Oct 2024 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLG9Sa3J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458E1D8A0C
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069413; cv=none; b=oGpSJT0sIZ+abEDyf+upnabdwQHESWV6dK0VO2tlF96+dVfxc0/76mo16iX8A/sQMM1qFWXQOTSR+WTJt8dkjz6C1ibFPXLAEyZAUE7Ftfm0HQ3ER9D0OgRVii8K/U5dNAzp8Rqb9q9k0xj5e06G1C7m8MSCGdZrKR99Uqdd0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069413; c=relaxed/simple;
	bh=N4M61e3JYLkPo6uIbpUbLgwLHGmqhlnd0TWTpFQokCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k2EK9nV5lUTxgkjwECFwB0sIjsjolvEcyOoNZyVXY23Bgyn1j/W2RM1BWtZuAWJz5yivqBYqTaVoDlOWupvhs+aX6+z/q1DasTr3pZDEjoNCYRq+CyF3VmZDeWGT7dADSx4MLTmOn3VF0fdp6suqdELcJAusjbJJEdu+1NYla0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLG9Sa3J; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25cc76cae1so4155094276.0
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728069410; x=1728674210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X02LKrEzBetALa4655biF39hq5nD0knlWwI7YeSXzOg=;
        b=CLG9Sa3JM7Oqh70IFJMPyGK68na7G6T+HbSE6HkrFKBiRomZHutXj5YwTNDOW9UXzp
         xm4p04Se5q5dG8w3foDXIvkY/pklWzodGL0IzMfJBfSq4Eg7OIong34fwP9nBJ2GkIm5
         BYPZ3VtZ20sExmetbUxmO2xZh5zm3X2eRbx9aZD1jUfqAlsMiGfvZlVuFWbC5EcDTkXH
         iwu0c6MYlt+3MZCj4ACDbT0/z4yGoPla0ae7x6PfuFYNqWqmcq2hPmgHuc4aXuOqonji
         Zv8YRdDU++PWCSKW0bxEK/hjU8YOdvpXlh311cRsV/a1pctiZmnY/IhqPeGUZErcOay2
         LTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069410; x=1728674210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X02LKrEzBetALa4655biF39hq5nD0knlWwI7YeSXzOg=;
        b=OvsbNBNKep3rzgU80NKOfFRDi8gSE7tbWf09G025jtTYRN0qtVzc76vPnmWfHhdL1f
         0VJrjCmfMYBelC3h9ktuvfPkDt+6rLIUBzsR9fYYUKmmOkrYrSXc0CVHF8fUrdo1rIIJ
         17bOgsEfDdqP5WO9chdfgnASomsh6ejPznnmAjmWxr6EEso6hKeS1HyUqL2jJnfuU3XY
         Wg6xvRL1GYrYLMIccdj6YDV4ZiJ8F2kXisIK6fWELB1YxpPfcx2WW6H+jdMUItYxGnvu
         fiq4Qp7xL9j3EHDQc7Y7TjxQGE2vYRjaZLnZv4PTMMDNJRwbR2S0H5+F3zaX9N7xFFhp
         HX8g==
X-Gm-Message-State: AOJu0Yzcr+aBKonRRMpecBk89IEyyj/ti+k8er4WZ+VcvmIPDWxb7KlJ
	Wa5ZsjGNMKrmzEJsW4vNLAXgf4ExfMNzcmlPFPcCUE1zNA2t/iVF3NgfZL5PPZDlZEYgXHYXT/x
	AyFbmPE+yag==
X-Google-Smtp-Source: AGHT+IFLrYh0eYD+e++ldgxfoKeFKOxDenCp5VtUXqKee7SXLWEHIkR6D3DYQvj6Opt7ErgePEsPJvDqZNQX5g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:b293:0:b0:e28:6ae8:9af1 with SMTP id
 3f1490d57ef6-e28930742b8mr41547276.3.1728069410549; Fri, 04 Oct 2024 12:16:50
 -0700 (PDT)
Date: Fri,  4 Oct 2024 19:16:41 +0000
In-Reply-To: <20241004191644.1687638-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004191644.1687638-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241004191644.1687638-3-edumazet@google.com>
Subject: [PATCH net-next 2/5] net_sched: sch_fq: prepare for TIME_WAIT sockets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP stack is not attaching skb to TIME_WAIT sockets yet,
but we would like to allow this in the future.

Add sk_listener_or_tw() helper to detect the three states
that FQ needs to take care.

Like NEW_SYN_RECV, TIME_WAIT are not full sockets and
do not contain sk->sk_pacing_status, sk->sk_pacing_rate.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 10 ++++++++++
 net/sched/sch_fq.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c58ca8dd561b7312ffc0836585c04d9fe917a124..c868b8b57e3489cd81efafa3856da09397059080 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2784,6 +2784,16 @@ static inline bool sk_listener(const struct sock *sk)
 	return (1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV);
 }
 
+/* This helper checks if a socket is a LISTEN or NEW_SYN_RECV or TIME_WAIT
+ * TCP SYNACK messages can be attached to LISTEN or NEW_SYN_RECV (depending on SYNCOOKIE)
+ * TCP RST and ACK can be attached to TIME_WAIT.
+ */
+static inline bool sk_listener_or_tw(const struct sock *sk)
+{
+	return (1 << READ_ONCE(sk->sk_state)) &
+	       (TCPF_LISTEN | TCPF_NEW_SYN_RECV | TCPF_TIME_WAIT);
+}
+
 void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
 int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, int level,
 		       int type);
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 19a49af5a9e527ed0371a3bb96e0113755375eac..e10e94fa5f9bc17a086173abaacb57269bc506a8 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -361,8 +361,9 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 	 * 3) We do not want to rate limit them (eg SYNFLOOD attack),
 	 *    especially if the listener set SO_MAX_PACING_RATE
 	 * 4) We pretend they are orphaned
+	 * TCP can also associate TIME_WAIT sockets with RST or ACK packets.
 	 */
-	if (!sk || sk_listener(sk)) {
+	if (!sk || sk_listener_or_tw(sk)) {
 		unsigned long hash = skb_get_hash(skb) & q->orphan_mask;
 
 		/* By forcing low order bit to 1, we make sure to not
-- 
2.47.0.rc0.187.ge670bccf7e-goog


