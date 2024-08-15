Return-Path: <netdev+bounces-118676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3DA9526C3
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 02:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274D9281CC2
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AF7A32;
	Thu, 15 Aug 2024 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi7276ja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794D1878
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681186; cv=none; b=kFspo+xJ/aMpVT7sSittFtp3pApxf7O/ihp7qxXQvw+kUml0dK7DJ6yoo4U0F0QEPQqDpD6Jkcb6LaFJ83u5wGIXgikZnKyhnps0YPy9yS6yJ5hmd15pjEdWlh/1RZ+u3wNigK80PbJapxXrSo5/wRrtn/KsJxK9WVI1KQ+fFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681186; c=relaxed/simple;
	bh=Kn4Tbh9cEFtChNo9SEH/kumMDHT2X8Gb2tgDv8B+6M4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZF3oAcptKP/7VJp5qJb0vxGsqDBExOGxIuZ9jVLA28de3wr5R548gh1H40o/SFMmI8Rm9VcWJdxGQ9GAayxPX73bra8i3LkfwMbEEDzONm3oUZ0Se8GoEwy5aTEmTh7qFtyHkgx58neXdDHFL5sxtiZpxORQJ/AuAiGMflXn85A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mi7276ja; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-396e2d21812so1876605ab.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 17:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723681184; x=1724285984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md0s5iUdURNHRxf3x9cdpW+6TFBpfJS5CRN6qgPKa70=;
        b=mi7276jaQMFNo0SflvtV/crNzfqzt7Hmwuq0Y9qRf9o7cyIUiGJKBtJqoHo9Rt7oZx
         LSXYXd5qp/RIqkqZBFwBaUCVVUyZ/Azg79gN7bPT5Pq6d/dC99ePjLLggr8ML1LVfoM6
         GfLReuk31Xapv+4nB1+RenF03+8S6PHhjT8kR8nRCs7EyDcZFy0wVCMLqwuvyZbbdX4M
         TCj9RUEBlMKAwm+u3mRKejQr1h5u2Yk7XKOHVfja4HRUaHM1Tlvx8+PI2XhxeaYiiLoN
         K+Dc+vKz9pjHIFXau/P/5lwGs0emW/Fm9XIQ1pME03xBmOJEMLpgyp9OPoRcJCRnhiYH
         6BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723681184; x=1724285984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md0s5iUdURNHRxf3x9cdpW+6TFBpfJS5CRN6qgPKa70=;
        b=BmUvnehtjweHZZ5eizzE5g43OAREr6urJ934Yes5VcFhe+FwhYC+ZK167nlR9HJZBb
         qBCgOMaHTpUwEf3l3bUx44sgJYpjeAVZw3Gmdlv6RnFA3Ez+p7NPBi60LTSMSs2hgk2u
         CS+fNvAhY2aqMCw1PyEROVrgvhKcM61n7bnC+16jU7oLxiNuXTGqBFP9UkNndVrgIyxl
         7vJ+IdlMnlyfZmhLVcU1iMMT7njxurY0WJbqXiGb0SotxNwpAckmDuwc3sHebLrpz5Lb
         pD9b/MxaHY8axCxWYtSECKrJtK+FYASWWrI9ptsNKOGjjB9TBqBwNUNLPRRP6WqCqcYR
         sYRg==
X-Forwarded-Encrypted: i=1; AJvYcCUeF0SkWTArXe4YVTgpgD/WFYR7nCYWDnOy8ylGwzPuSduKEf/vYNVtti0DpLSCvtDmtUKdsg4ZPG9JpHIDzaxYoLUKk7iM
X-Gm-Message-State: AOJu0YxNGYKgWPXYFlF3sAJDaZqMzj31vdAoYsgleP75CaMweVWCWebA
	P0RxlvRUV8zL2FuYw/9ANfW8/C365KINy0UqPUL7uQ8GZSbQ8NOAAqbKug3Z
X-Google-Smtp-Source: AGHT+IGDm5bMUViOYmdb8xnyCCmFCrnDmU7FdPFN1O5KjPGi+i4gWWO3IOPn7e7OP4Hag2Tu6R+gMA==
X-Received: by 2002:a05:6e02:1c0e:b0:398:81e9:3f9e with SMTP id e9e14a558f8ab-39d1245c2d6mr61794825ab.12.1723681184354;
        Wed, 14 Aug 2024 17:19:44 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1ed74e0dsm1244935ab.78.2024.08.14.17.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:19:44 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net v2 2/3] tcp_cubic: fix to match Reno additive increment
Date: Wed, 14 Aug 2024 19:17:17 -0500
Message-Id: <20240815001718.2845791-3-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815001718.2845791-1-mrzhang97@gmail.com>
References: <20240815001718.2845791-1-mrzhang97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add new field 'cwnd_prior' in bictcp for cwnd before a loss event
Suggested by Neal Cardwell
https://lore.kernel.org/netdev/c3774057-ee75-4a47-8d09-a4575aa42584@gmail.com/T/#t

The original code follows RFC 8312 (obsoleted CUBIC RFC).

The patched code follows RFC 9438 (new CUBIC RFC).

"Once _W_est_ has grown to reach the _cwnd_ at the time of most
recently setting _ssthresh_ -- that is, _W_est_ >= _cwnd_prior_ --
the sender SHOULD set α__cubic_ to 1 to ensure that it can achieve
the same congestion window increment rate as Reno, which uses AIMD
(1,0.5)."

Thanks
Mingrui, and Lisong

Fixes: 42da09fdf2bb ("tcp_cubic: fix to match Reno additive increment")
Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
Signed-off-by: Lisong Xu <xu@unl.edu>

---
 net/ipv4/tcp_cubic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 11bad5317a8f..7bc6db82de66 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -102,6 +102,7 @@ struct bictcp {
 	u32	end_seq;	/* end_seq of the round */
 	u32	last_ack;	/* last time when the ACK spacing is close */
 	u32	curr_rtt;	/* the minimum rtt of current round */
+	u32	cwnd_prior;	/* cwnd before a loss event */
 };
 
 static inline void bictcp_reset(struct bictcp *ca)
@@ -305,7 +306,10 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 	if (tcp_friendliness) {
 		u32 scale = beta_scale;
 
-		delta = (cwnd * scale) >> 3;
+		if (cwnd < ca->cwnd_prior)
+			delta = (cwnd * scale) >> 3;	/* CUBIC additive increment */
+		else
+			delta = cwnd;			/* Reno additive increment */
 		while (ca->ack_cnt > delta) {		/* update tcp cwnd */
 			ca->ack_cnt -= delta;
 			ca->tcp_cwnd++;
@@ -355,6 +359,7 @@ __bpf_kfunc static u32 cubictcp_recalc_ssthresh(struct sock *sk)
 			/ (2 * BICTCP_BETA_SCALE);
 	else
 		ca->last_max_cwnd = tcp_snd_cwnd(tp);
+	ca->cwnd_prior = tcp_snd_cwnd(tp);
 
 	return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);
 }
-- 
2.34.1


