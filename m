Return-Path: <netdev+bounces-105665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DDD9122FD
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E70281C07
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEAF171E54;
	Fri, 21 Jun 2024 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP1OFrpp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811FF16C841
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967958; cv=none; b=oxuAROOHW9aWHHrSFF5vEsLu+Tj5LY+HIegJLPlqIYoHQRMpW1l5BdpUIvRArthltS69j2MGqvrG/BsM8KfyxMn7un4y0/BCSh9gsikBcaAC3Juf36MczrAd8EAEg1+uzoUSs3ywhYgI4CYWDtUH2gZpi5WGsAuqa35lGV3RiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967958; c=relaxed/simple;
	bh=nW2L9ardY8sFysCWQdjWFkZgGQ3VI3qM6CRNfguqx+I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eaRaL3UvJpgslUFpOomjcJe4ZzT76FIdhB8TxeIz8MoY1yyBwh0dUyPZjm3lXcBRmkNzctzRihCywunVuEj4RAZFvnI8V3jYWFtPBFOzcZTdezIxY+21fmL+ayOFVI4p/q48Ufjg8vDgrLpO9tmz7T2wn7R0pYJfZWYbnbHUjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP1OFrpp; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-254925e6472so123613fac.0
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718967956; x=1719572756; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=soadLxU7yRtIH/N5DhuXa3usT5V9caMjork0UCMESQw=;
        b=dP1OFrppzgHX8i8bDIs0x24QetyHE6CAqr8vkgkd0oqwFfj5HporbmBvblzX2rdx5E
         c4jN5A8Hvy0yBLxpfN/3XxRe0KfT/nIl2fSumK3ixmQR+bMo+mbMTNkbtI8oP0gTqWi2
         nNxYNveHiZIYokmzMuCvgQT9XYr3NChStN8QYp9WfxpUeo82EM3Bq3l8HFWaLmU9pBmy
         RPomzH1WCNI6r7PiL0vcrOYZ59atVnI189E74RNrlU7FM1+41FINtb7R100eV0Snvc9a
         Aesvcc1HibrtDJML/8X1UGTFvB6mXGVS2Do024A77uUO7Tmssb9cAiTA/FfIjFYXsWm0
         Usnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718967956; x=1719572756;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soadLxU7yRtIH/N5DhuXa3usT5V9caMjork0UCMESQw=;
        b=IaN9PGJqsgEqgBohPcQkFE9n0XZ+G41MNrnE/KobfLwMwSSuntN2WS15tZ4uhFio1J
         iqfI7/BIAhh2NkmhchmC01vbhrwec/5mVEYq4JCd6RzVa6AvD/SY1cGVjECP9ALZ+bH+
         hdeNKtAdOJvqcBqpxmsArRrWL1CJwmP8Gdmt95OmdiycPeqTNmrZhrBkHpEyDkUftUMr
         E+qG5hn2PJ7HItZlLJks6BCMHxSka49/ghXdTNfoRJoSlLQgWhW8AIDvMyrv+B8sGCq7
         Bw3wIHQNe+qm5LpU95O/34dlsdIMUIp52NrpObFaD7Mn0HXRoDHhwm+CY/EQa3JMjXvp
         p1eg==
X-Gm-Message-State: AOJu0YzTRwJze14+eLTuoACE7OfaC/5VXeU5WkCg0azUew7TcQOLpl98
	hH/r89hO5kwYtLmugbk05VfhTOpOG3Cs5w24dS/1p0VJJ0hyvq+8UiVblZKHjTTT2G1VyU+0gOy
	SFxAJYm4BIsB9HQ9T6hmQIpw5L79Xql5l
X-Google-Smtp-Source: AGHT+IGiGQNjmaoe90RtrLgaBACY1zE7MGPvW91Q1x96Xjp0tlMx1B8xRxjD7FUhAdwpzhf5iUX1sU+LNmkmAHaJJR0=
X-Received: by 2002:a05:6870:200f:b0:25c:7c5c:2107 with SMTP id
 586e51a60fabf-25c943ec882mr8719212fac.0.1718967955988; Fri, 21 Jun 2024
 04:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michio Honda <micchie.gml@gmail.com>
Date: Fri, 21 Jun 2024 12:05:45 +0100
Message-ID: <CA+Sc9E2oKba+C2EhBvmyJQ5wVS5=S=ZVzP+Gt_-xsRNtMCm4tQ@mail.gmail.com>
Subject: [PATCH net-next] tls: support send/recv queue read in the repair mode
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From df3350858eda825014ac75dced0cede9de4de302 Mon Sep 17 00:00:00 2001
From: Michio Honda <michio.honda@ed.ac.uk>
Date: Thu, 20 Jun 2024 22:05:15 +0100
Subject: [PATCH net-next] tls: support send/recv queue read in the repair mode

TCP REPAIR needs to read the data in the send or receive queue.
This patch forwards those to TCP.

Signed-off-by: Michio Honda <michio.honda@ed.ac.uk>
---
 net/tls/tls_sw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 305a412785f5..25b239a9b748 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1973,6 +1973,14 @@ int tls_sw_recvmsg(struct sock *sk,
        bool bpf_strp_enabled;
        bool zc_capable;

+       struct tcp_sock *tp = tcp_sk(sk);
+
+       if (unlikely(tp->repair)) {
+               if (tp->repair_queue == TCP_SEND_QUEUE ||
+                   tp->repair_queue == TCP_RECV_QUEUE)
+                       return tcp_recvmsg(sk, msg, len, flags, addr_len);
+       }
+
        if (unlikely(flags & MSG_ERRQUEUE))
                return sock_recv_errqueue(sk, msg, len, SOL_IP, IP_RECVERR);

-- 
2.34.1

