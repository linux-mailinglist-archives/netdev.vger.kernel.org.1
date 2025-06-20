Return-Path: <netdev+bounces-199752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AE7AE1B4B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6074A7612
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47028C871;
	Fri, 20 Jun 2025 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VWYv0w5E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3AF28B4F0
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424242; cv=none; b=AeRD7+diThjeARFNCQ0kqxOsFXZmUfzR6Zwdx/m3UynXuk1Q5V3dmQJ3ALexbpq2H5eXQK7w4dsXIk0sL8SpbOZxlkx5BMdyQ2dFtAZWe3PTKXI6GhL6gEVI3/5ioM/uEBnMHdZyykem4VOCP/WDuFVkx9iCxyrv+MV2EdhL2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424242; c=relaxed/simple;
	bh=ZyoTYsQDNqC4ASdY8p85g50AZ3yiJ1AdxeTRJtDg77U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7aN28a87esNODHoxP515EE8KYn20OmRXD/dfcHdzjvBykDiPxJTMeXehg4d+X5NRuCEHXaZErhIpAOAURX2t8NWYl8YoNDT8XoLI+6tx2a3g/YwVFGHlhqneg5Vi8E8TnNJLlepFwpllbbk4EQvRrvsHo01DlkXgySfcz0rWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VWYv0w5E; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4eed70f24so295256f8f.0
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750424239; x=1751029039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzeSMYEXqxw9EDBrJFxz07iXPEJN1v7Rpat5YouCMlM=;
        b=VWYv0w5ECnxvvSntBqxXAG/2y9MUQWDCC5BNtmI3W3KrEtTA0pYDPslmuxKCmzN8yF
         dT2XT/6v/oKTamH+yASQt4MAm9UJyRi7Lw9EDEAAl+VP8brhjrwhVTqjc0OI3NhQepTk
         E3x7hlsBpmXSbK7qA/cMoY7rIFCYYNwiDO8Z9pm1nJkWOPQhjNsFrYu2CR/pKPHOsERp
         gosVz4Henc0Ad+iB9RTcHABS2OkgrkjtrL+ft9abPQVItpyL9zCIBRj49Sd8irPBYDLv
         vr4XJxaS2SkYbJRE6NCngaPSi+mcfKPy8aeiwj+bb9Lh4V+qRY3xrND/5pI5QNCNvOXz
         BMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750424239; x=1751029039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzeSMYEXqxw9EDBrJFxz07iXPEJN1v7Rpat5YouCMlM=;
        b=sCgPWCw1N5349oz4h34/P4eQPpoJDEB4tjxdZDqFfDKTeW60o/jnnjcpnUGXqtgXQg
         G+mm1epnXXRmDn8h/q3l2MFfqF5Hy2QHj1jOLJZ3nsGFcis0+ld5ihU9tGFT+hwkWyw/
         b/4WKBPskEJlkhIpS5MCfdDjpcUe7fG5zerO9UbLDfRIAHNHJAe1XXbJsiLme0SArtFP
         J6LzhGqjQlqvy8iS5XkThvU6dNTnsFIFWIvf5NiUM90zwbQ+PId9O+hzmgFbchAkNHK8
         tq9fJ6Gf0kuNWRRiePfM7HyNO/F5Rm3DFTwJOS5XUdLe6QXdHTfhmVbfhls2Grmf+/oj
         BCSw==
X-Forwarded-Encrypted: i=1; AJvYcCVMrQ410tlRv8pGHvV4J2jv1tbzsW5hC14RG1QZnKWg8/1Fale15WsSYhW1BimZtZdAO1Gf+qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3FrJ4hdo3X710BQ8HFXtHVq5MCwzmXmfjw0++FiINgQoNOJcB
	oVvA9qGk/16fEnOk5mTolHn1wHMRl955+Ue8hMa7kF6jpkyWTFTLIqqcIJBKzTgq9GU9ZYZuCA0
	wQiAw
X-Gm-Gg: ASbGnctmJxQaiRtZH6+4FAH/5pnSQnIi9EUJ3ClU766lZCUOvvap4LJYf4RFBNl04Vc
	vPl2+/WKop12vV4wbLvWqNRUQ9p2sYJAq2ci1sIuZHGNR9lC/FjVZX/+y7vSCd/wx1+5g0avUij
	Rp6ZYBKJy52sOf40i5grKmrjB6hSwuXx6f+fPHWPCnV5juVssAn1/kUFbALw8QL34BDhNRcoQM1
	h3GM6hCq8Ds+1A4d9E/XuokKdA4eMGkh1miqIhBr0qiHnkBHVwX8hd1JLlMyBtgP/7wbTk/nDxK
	3kUqWqLEcnSYoUlRUV+6z4GlIHdI4MpBPZFwixM+BVjlADiO+skqd3ej7Wk3IpqSUaXYmmSdSXC
	38MrMFMVbXJuEcv2quvyz1rdDC/jtcGxuel/oFkxKJTNcFCU7kGUC
X-Google-Smtp-Source: AGHT+IEg1ePRqgAqTiaCaALU4AHtQC/KnDMq5o0Lao+2uolphJ/oiQH50dZWBNhS6gt7jRyQjFtv5Q==
X-Received: by 2002:a05:6000:3111:b0:3a4:eeeb:7e89 with SMTP id ffacd0b85a97d-3a6d12ae20bmr911198f8f.7.1750424238916;
        Fri, 20 Jun 2025 05:57:18 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e9844c3sm59336975e9.11.2025.06.20.05.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 05:57:18 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org (open list:NETWORKING [TCP])
Cc: David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH net v2 2/2] tcp_metrics: use ssthresh value from dst if there is no metrics
Date: Fri, 20 Jun 2025 14:56:44 +0200
Message-ID: <20250620125644.1045603-3-ptesarik@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620125644.1045603-1-ptesarik@suse.com>
References: <20250620125644.1045603-1-ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is no cached TCP metrics entry for a connection, initialize
tp->snd_ssthresh from the corresponding dst entry. Of course, this value
may have to be clamped to tp->snd_cwnd_clamp, but let's not copy and paste
the existing code. Instead, move the check to the common path.

When ssthresh value is zero, the connection should enter initial slow
start, indicated by setting tp->snd_ssthresh to infinity (ignoring the
value of tp->snd_cwnd_clamp). Move this check against zero to the common
path, too.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 net/ipv4/tcp_metrics.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index dd8f3457bd72..6f7172ea8bc8 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -473,12 +473,13 @@ void tcp_init_metrics(struct sock *sk)
 	/* ssthresh may have been reduced unnecessarily during.
 	 * 3WHS. Restore it back to its initial default.
 	 */
-	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
+	tp->snd_ssthresh = 0;
 	if (!dst)
 		goto reset;
 
 	if (dst_metric_locked(dst, RTAX_CWND))
 		tp->snd_cwnd_clamp = dst_metric(dst, RTAX_CWND);
+	tp->snd_ssthresh = dst_metric(dst, RTAX_SSTHRESH);
 
 	rcu_read_lock();
 	tm = tcp_get_metrics(sk, dst, false);
@@ -487,13 +488,8 @@ void tcp_init_metrics(struct sock *sk)
 		goto reset;
 	}
 
-	val = READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) ?
-	      0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
-	if (val) {
-		tp->snd_ssthresh = val;
-		if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
-			tp->snd_ssthresh = tp->snd_cwnd_clamp;
-	}
+	if (!READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save))
+		tp->snd_ssthresh = tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
 	val = tcp_metric_get(tm, TCP_METRIC_REORDERING);
 	if (val && tp->reordering != val)
 		tp->reordering = val;
@@ -537,6 +533,11 @@ void tcp_init_metrics(struct sock *sk)
 
 		inet_csk(sk)->icsk_rto = TCP_TIMEOUT_FALLBACK;
 	}
+
+	if (!tp->snd_ssthresh)
+		tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
+	else if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
+		tp->snd_ssthresh = tp->snd_cwnd_clamp;
 }
 
 bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst)
-- 
2.49.0


