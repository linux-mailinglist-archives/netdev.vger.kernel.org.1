Return-Path: <netdev+bounces-101848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5C3900442
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2071C2440C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38E5193098;
	Fri,  7 Jun 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xW73f3YE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A3E4AEC3
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717765016; cv=none; b=YTXM4+czaDNEPXEAit8x105t/5STGDP3IPF9n27NKJF9PsKsUeblzWtQr5CP2qY1yTUhVqJ4otauOc7Q65fSLI5lsHcAPVA+tDhbgFsb8YT/5KnBQDyJ+iDwQqz/F9ti0ITwNtSz4BN6dmtCv2uvJ/cLoGlelgTJQdCmdulOBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717765016; c=relaxed/simple;
	bh=RbeqGF2xB7GhuVAcCrOEunVD3heQnHWmDCG8uR7HKhw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GflhMsCz+cIIr3PRt0rA3Ybky+JTK6gJh9Wff+0i8qHjhEmQHhaDb0t4dEBaqkQoN7szjjf7u+L3nCyADckG1/pJY5syA5Kn+hVFleJSmtMuTCA7quEwt+fVK2qUSXXU4Gh/Q0gi+swieHX2em1akxrSce77Juno1Y9mMyUz2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xW73f3YE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a0827391aso38018827b3.1
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717765014; x=1718369814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FLspjLa1ycUNoXxTBTEPqDBS4VgOXYjGb9BeM0Yhjl4=;
        b=xW73f3YEbrSovX67kA33RdpSbvCD24nS05XYIbF3+VJUmIpY3rMggyrwXo2bNJjvsF
         Pukz6AitmD7ffREtTPDFpaCyJKMFOHXBdlCsgxm6CnYe85HyHYDB56grd0A5aA8MrdAb
         oUuuW0BJnMqQrjkHRhAWyFqML5sS1UP80tky6YsbmlLbpzgLCgaD1+VLQMGrEDaOe0Ip
         dEgJR4C5NHWQpgWdo92FIe1ryusLehW0kIXhYyRCGbA4maB2iQQePQ10kJhZKvKDDetz
         P3U2kDgk0ddA5nQMIgb5twx3VdgMCJrzTtai6HtiB+KvkBWadHkSwQJ4RCJ5IxsK1JEv
         eQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717765014; x=1718369814;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLspjLa1ycUNoXxTBTEPqDBS4VgOXYjGb9BeM0Yhjl4=;
        b=RbcwRIGceFgTecoGR4MoRqaxOW6IfD0+LuOYEeURrwnG/TbE6rfxwk7cckw7E1OCD3
         AWSXo0rmc0c+XaRaFn0I8mBGV+pbaVyQIfMR4luMh+pKIPOgCabdkVLoN/Rh7882VA27
         +D1qQDaxUgRU3zanKkPyL5tGc/mjwJRPL02s5rv4xUsXgwspRJXwZtuoKL0zr0+X5gI/
         CLsRX+tfZDOLrYZWWWQlEpr1pFVzrV28RbYYqJrn+DzFeN7D1NY8uyEP0IbAmxU15l2A
         0wkMmsZAjACTp4jlcR/5yCI42A3TqCiOTFlb6Ie5M5BYsyOos648JKaLNSNZrXDPmyCq
         nnMg==
X-Gm-Message-State: AOJu0YydSVVvcYQ/zhFFsoAVibJSH1wlgvy4CkfTNfTC01EWaCK/NCbC
	BUVqxs0oViJRWCfnY4N+4RuYAYRRGIseABWW8wFMhcOKomTBoHwtVLvZ+ir4JCGqR/faSN8TgOg
	E4JthGHz83A==
X-Google-Smtp-Source: AGHT+IEdAELVTYWOaMWidyUqQCyeQ2c4ifmFiUya+GUj8LrnTQSe21Y4XfJFrPXFz6rYxungYzU5sd9swXMAqQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:d87:b0:61b:e2ea:4d7b with SMTP
 id 00721157ae682-62cd558c242mr6711017b3.1.1717765014293; Fri, 07 Jun 2024
 05:56:54 -0700 (PDT)
Date: Fri,  7 Jun 2024 12:56:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607125652.1472540-1-edumazet@google.com>
Subject: [PATCH net] tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Due to timer wheel implementation, a timer will usually fire
after its schedule.

For instance, for HZ=1000, a timeout between 512ms and 4s
has a granularity of 64ms.
For this range of values, the extra delay could be up to 63ms.

For TCP, this means that tp->rcv_tstamp may be after
inet_csk(sk)->icsk_timeout whenever the timer interrupt
finally triggers, if one packet came during the extra delay.

We need to make sure tcp_rtx_probe0_timed_out() handles this case.

Fixes: e89688e3e978 ("net: tcp: fix unexcepted socket die when snd_wnd is 0")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Menglong Dong <imagedong@tencent.com>
---
 net/ipv4/tcp_timer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 83fe7f62f7f10ab111512a3ef15a97a04c79cb4a..5bfd76a31af6da6473d306d95c296180141f54e0 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -485,8 +485,12 @@ static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	const int timeout = TCP_RTO_MAX * 2;
-	u32 rcv_delta;
+	s32 rcv_delta;
 
+	/* Note: timer interrupt might have been delayed by at least one jiffy,
+	 * and tp->rcv_tstamp might very well have been written recently.
+	 * rcv_delta can thus be negative.
+	 */
 	rcv_delta = inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
 	if (rcv_delta <= timeout)
 		return false;
-- 
2.45.2.505.gda0bf45e8d-goog


