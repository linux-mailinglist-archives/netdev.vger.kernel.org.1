Return-Path: <netdev+bounces-99452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D688E8D4F2C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1399C1C20E27
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F338182D11;
	Thu, 30 May 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QME9mlSg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE9182D0B
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083331; cv=none; b=TcRo7KdwF9ZYzVA7nxIzrMTWRw5/h6g9J/97i4cvEDcnG+cwQ+FEB9YdSkEEtzzmXVuT60oYQ74Mthng3m5MX0c+Vn/hbTn7RQXKr2xQLeqBn5JtLoKhuFnDe00H42JGv0fnip9u+SMOo+k/sooMjvpvSoYosNYtCQ5pYRWGs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083331; c=relaxed/simple;
	bh=nea5TuWjFrVOcHzwJEtkBW5b+tUjVdniOwNuZTUeAn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GumLdExH6ut6MRC1nLOMUxcKEl4KUc80SZ1C4+x5yV38805t4+kQyWW4iL8DQGbqLjR87oVJ2G36gnlw7p6R8viCsLlN2DmNvhgr3zmVVrlWA3Hx8XmvVgIUAC+d7l0oU0ihL3eKPRE2yqxvQ0gGXJDhepWPd6+qrkqBsUGyfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QME9mlSg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dee902341c0so1456747276.3
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717083329; x=1717688129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HE9C3gTRmlZVfG8dsrcNel8g5FJYCG3zsyhAm4+36wE=;
        b=QME9mlSgZmSBqyGtAhXCSnJYY1SC1pgYEo2Py1aJ4Goq6Icz/KMr0hv89cHT36FtGo
         PUgSpLvheuGhSGrPnEAniiqvhjt7QMtEgiCTYEOEpflxPM9do7E6jnLXcDOCkA2RI0Jq
         d2TXvMm7KOgPhkgOrnBiu8TcBsS87qfhoVC3YINijzToga7y6xrQIcaN0bwn0U0vcBfZ
         JYMeznHBa00WJ2+yCasphHYB0Ja3D2MO6YUh2jRIN8clWw08PpaFok/ChCVm73V43zQF
         QTzoFi0OQFeRxbXBcGeDG+L3CS/rgpkP8yR624X6qynlJVzRL3Cm3VRQOYmtbkdLYrSZ
         Y4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717083329; x=1717688129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HE9C3gTRmlZVfG8dsrcNel8g5FJYCG3zsyhAm4+36wE=;
        b=Dlm3EqOUa7dMSHMPm6Jc2ld8HILFWXYuoeZYeYHNhjHHp6F6hkhFOAhZ3HV+IbUVcY
         SU4ZL/V6lreYe3KbcIxIG/PGJ/arwvliAiC/S7w34gS3wHg+CtSHzX2o1eRb/LYRQjLh
         CRTODTp4QiL1Q3fMH3pTnMI1vFi9L+W1I4foG18YXjhtcVCi+gmNI9ikAm1FviTpoVcr
         la6K41GmVflcL22uFiNUpIQCUuQSAVFv9bxnUTPZe69VL8bLtkndRO4VIBbTFI471mtc
         ppPu5X4XNrppYfj7XaPvegNxnAhdS1Dih2CyUeidjZUQD9ZKVa6WfBeIbosSRyUUReJi
         HM4g==
X-Gm-Message-State: AOJu0Yz4opMftHe5h2VXKp+o2Z5Sg1Zr/WIX6Xyv2iT95IiR+jWV0y3o
	SzI9o3ApAMcV/ix5UrIMcbenNHP7h8UWVITd05syoT9HmLwCaDJiJ6dB/P1D9tFNgw==
X-Google-Smtp-Source: AGHT+IF5bb39EJJ0Y1X4uKRLiw1cWEbMnWlhPvxUrPdaEXv45tRjA4t2gRW6zYveaHlI+3af87rTx5M=
X-Received: from yyd.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:13c9])
 (user=yyd job=sendgmr) by 2002:a05:6902:c06:b0:dee:7bdf:3fc8 with SMTP id
 3f1490d57ef6-dfa5a5b2b0cmr169392276.2.1717083328779; Thu, 30 May 2024
 08:35:28 -0700 (PDT)
Date: Thu, 30 May 2024 15:34:35 +0000
In-Reply-To: <20240530153436.2202800-1-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240530153436.2202800-1-yyd@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240530153436.2202800-2-yyd@google.com>
Subject: [PATCH net-next v2 1/2] tcp: derive delack_max with tcp_rto_min helper
From: Kevin Yang <yyd@google.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com, 
	kerneljasonxing@gmail.com, pabeni@redhat.com, tonylu@linux.alibaba.com, 
	Kevin Yang <yyd@google.com>
Content-Type: text/plain; charset="UTF-8"

Rto_min now has multiple souces, ordered by preprecedence high to
low: ip route option rto_min, icsk->icsk_rto_min.

When derive delack_max from rto_min, we should not only use ip
route option, but should use tcp_rto_min helper to get the correct
rto_min.

Signed-off-by: Kevin Yang <yyd@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ipv4/tcp_output.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f97e098f18a5..b44f639a9fa6 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4163,16 +4163,9 @@ EXPORT_SYMBOL(tcp_connect);
 
 u32 tcp_delack_max(const struct sock *sk)
 {
-	const struct dst_entry *dst = __sk_dst_get(sk);
-	u32 delack_max = inet_csk(sk)->icsk_delack_max;
-
-	if (dst && dst_metric_locked(dst, RTAX_RTO_MIN)) {
-		u32 rto_min = dst_metric_rtt(dst, RTAX_RTO_MIN);
-		u32 delack_from_rto_min = max_t(int, 1, rto_min - 1);
+	u32 delack_from_rto_min = max_t(int, 1, tcp_rto_min(sk) - 1);
 
-		delack_max = min_t(u32, delack_max, delack_from_rto_min);
-	}
-	return delack_max;
+	return min_t(u32, inet_csk(sk)->icsk_delack_max, delack_from_rto_min);
 }
 
 /* Send out a delayed ack, the caller does the policy checking
-- 
2.45.1.288.g0e0cd299f1-goog


