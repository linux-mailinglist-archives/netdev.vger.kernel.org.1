Return-Path: <netdev+bounces-165614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B18A32C1F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6F418838D7
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AF3253B4B;
	Wed, 12 Feb 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dXNR2TcO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08269250C13
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378610; cv=none; b=oxPJowxGnyua3jupTIsNfkzxmqY+ReYyB+wuCIX8FOBYoxtylwRKU08tTVtoAyJxi+HZcss41UEe+AEIoOs+GxTDQQRNZQRTBDLd/IpWkzvAspnwe0EOQb7GY5uuDpGFLoNleGbo3Z7YSzIcUy4hrLpwUDRbn3TDEVpQVvKjY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378610; c=relaxed/simple;
	bh=+R+gsNAZJIFoPS+flzYsNbvb+00SPyBGEUfa6OYni80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jGlwc6KY5jxvC8lbdpj3WWfR32fPSKpUD0bBegcnrNwIkgbyiwnyNdnyFLtAgwmdYDKCiFb9U9BEF6Xw2xaBy5Cgmp8w4nD2ui5r52QFbhjBJwKiVF1WGme+nv7GMWsAywMOQAjtoqBDl3Al53AWHvosP9rUcE2A5ggxU1Cvsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dXNR2TcO; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4719a88385cso50032601cf.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 08:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739378608; x=1739983408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bc1KT6XJD9YQspXpLj+QAwa1Bq9Wsx7vCh0osrKULQE=;
        b=dXNR2TcOaih9Q2sIflI8FYXBJDLEJ9/35IMZm/rGxajjBDPOfC78Ad6FLdRFcvcqSl
         ohYAJSal7iF/eqyd5zwmPGL7v0rsR9Ua80UGmDPXF1L9qN+S5fC+h1rDRw/4/fKHM8aP
         8EhA0SVKFgd2aRRIOiYjNkHdrDhlZ0idfGVpg4kaiXITYmn0xYcskqY3IApZoBqOCg4r
         lWsTC/Npr5m3IdJc8bdccpRjoj+Khefu+DfwYpmut8Ras4e7BPHjUXayyKiv9FH8mJQ9
         3PveRVbFQprHvEkAcD2GoPiTW2ju+oyqcwcZjd39aUL9+Ri18tXrfSFz19sVdAq6n7Fl
         kfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378608; x=1739983408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bc1KT6XJD9YQspXpLj+QAwa1Bq9Wsx7vCh0osrKULQE=;
        b=w41YHOin6RKpVnYCuHuTF+4Gpn7Vrqgg6maGmWSeZTb87jNLROETDZpMmAMeYWC1Bp
         SKrzNyxs2pH2y+PgBEtXwan0doVS7XYub5ZDXpbps/P624AKaT/Al+H+5bMZcOjpPGSb
         WFkmB4Pcg6LtyqUHRLqTANsErnzVUBq77kpdUrf+Kdow7q+cz04jdvReuoWEryIQJa7H
         jA5QKohTVGvH8rQrjiynaIYO6xQ8T4fP/IGWlG+R0ebgB3EfGQDfNoOPJSWl8r3y/UgV
         2AN9vvFkGLva3wlAEEkd6GmdgQoayQGctNKR2zlAeu2ta2ig66vcU0VBeJarUSiScj/n
         mRGg==
X-Gm-Message-State: AOJu0Yx3NJVMFuwHr3dfMh0WEm11nlqHWdFN34DJpUPHAxl5bQNLiBOR
	P63iBzU35yaVUrZfkfMF6sdR7bc4ipX1zpW1PNdRCFqausawA0OKVOspbv1Q9TZLuKYqlIDsAku
	CvkHxNAmUqQ==
X-Google-Smtp-Source: AGHT+IEDqFXKNfPtsIkTGqPTI3vPASKrvRFwb9Oy0GfyaN1unvx8Mc4ze88HHpMQsKQH4Yc4yydUFWU5ji7ERw==
X-Received: from qtbfb16.prod.google.com ([2002:a05:622a:4810:b0:471:919a:e569])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1214:b0:471:b4b9:e6fc with SMTP id d75a77b69052e-471beda6de9mr863121cf.40.1739378607961;
 Wed, 12 Feb 2025 08:43:27 -0800 (PST)
Date: Wed, 12 Feb 2025 16:43:23 +0000
In-Reply-To: <20250212164323.2183023-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212164323.2183023-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212164323.2183023-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] ipv6: fix blackhole routes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Paul Ripke <stix@google.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

For some reason, linux does not really act as a blackhole
for local processes:

ip route add blackhole 100::/64     # RFC 6666
ip route get 100::
RTNETLINK answers: Invalid argument
ping6 -c2 100::
ping6: connect: Invalid argument
ip route del 100::/64

After this patch, a local process no longer has an immediate error,
the blackhole is simply eating the packets as intended.

Also the "route get" command does not fail anymore.

ip route add blackhole 100::/64
ip route get 100::
blackhole 100:: dev lo src ::1 metric 1024 pref medium
ping6 -c2 100::
PING 100:: (100::) 56 data bytes

--- 100:: ping statistics ---
2 packets transmitted, 0 received, 100% packet loss, time 1019ms

ip route del 100::/64

Reported-by: Paul Ripke <stix@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 78362822b9070df138a0724dc76003b63026f9e2..335cdbfe621e2fc4a71badf4ff834870638d5e13 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1048,7 +1048,7 @@ static const int fib6_prop[RTN_MAX + 1] = {
 	[RTN_BROADCAST]	= 0,
 	[RTN_ANYCAST]	= 0,
 	[RTN_MULTICAST]	= 0,
-	[RTN_BLACKHOLE]	= -EINVAL,
+	[RTN_BLACKHOLE]	= 0,
 	[RTN_UNREACHABLE] = -EHOSTUNREACH,
 	[RTN_PROHIBIT]	= -EACCES,
 	[RTN_THROW]	= -EAGAIN,
-- 
2.48.1.502.g6dc24dfdaf-goog


