Return-Path: <netdev+bounces-247121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D19CF4CD3
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67FA930A9F4A
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63A33438D;
	Mon,  5 Jan 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbCaU858";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbRlpZ/9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F512E88B6
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630551; cv=none; b=S+MgtAfLGRPWCz43g+N36gGCPEeLI4Cn4W0Bgj4EzCBYP0TvOlkFTCG77I6r40M2+W/WIhOeJWR4k3pBsviNzfmx5LpDyRLeHvbfNsfwmyv8qAHsN1F+gjknGJMgUsQlWDGT7YLIQcq6FjGJUbIyhWHXa5r8EVe9DdBZJIwfrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630551; c=relaxed/simple;
	bh=rbUYvg6F9g6C5QpjKMYJCtSkGKCJeTQyzPCcUAF2Y9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IylWEjP988dibOhMz6YImg8z79jZNINU5LJ907k4FWsgOk6nH8gu1ztbUFPl+tvBnPYh/7sQTsMyF6Uf5e5usnYAZx4oWr+uP6LdlBesuNt7t0n1GbAc5nLwlnE2AY/0mLl2091/EbthavYXq2BkJyAlGwfPfYdYzwhjkSWkDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbCaU858; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbRlpZ/9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767630547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8f0oVJfwepaLhAs/XrnNAR3XfAc5fTnXXEV2xUSnK4=;
	b=hbCaU858qw4lVeScwyz7Bp51jOVFwzxbxIzbhxk+c5LfPf4QTsZxyHsRS877kLMzNlv8ul
	+0dNcYpCGhDm+BDWMInuVnKl6lKEf1y+41h+x5Xe/CHc4fpD2v8HC9WZV+uYcLkOVaTAUF
	5idko9+IfZNWRvZ9dJ0goZ/90mUn/Z4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-sWyKATE0PZC6udlPuOhgVg-1; Mon, 05 Jan 2026 11:29:06 -0500
X-MC-Unique: sWyKATE0PZC6udlPuOhgVg-1
X-Mimecast-MFC-AGG-ID: sWyKATE0PZC6udlPuOhgVg_1767630545
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64d264e09c7so109142a12.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767630545; x=1768235345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8f0oVJfwepaLhAs/XrnNAR3XfAc5fTnXXEV2xUSnK4=;
        b=EbRlpZ/9vZBUD6X9NpqjuLSIE6HXRtV8uvQnmIhhlp2hLiU8qHyGZS0rvo68rCWGlx
         OIX2OvslCS3CKk8r+kaKuSS6XPoA4tOC2ruENm+KgiicUAPV117ppfR/Rm4zP66MUTGo
         O+rXe/tTE64v4F4kCug9xHO5ctzPfto5fYEIpSWH+uvMdJda0V7L55TCNG/LZMQEr87g
         7MAYKeAteuJHdGdy7/SAPkEf3yDCY2TuI9F74R6h7iZESsXAcRsLTsWAM+smwEYmnhSH
         O8oRF1v1ZDsyhepS6tr/1SZNC0TfOjIPX8Gh/+y+k2qMV2yBu+JYnxj5rpSz0yMrTLHh
         +fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767630545; x=1768235345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8f0oVJfwepaLhAs/XrnNAR3XfAc5fTnXXEV2xUSnK4=;
        b=nAhz3EhHiJyHsSdYAGeQh2SV63FzfxNzG/8QvESW/HNwGOtGVj5xfdM3nHD5p2aCAJ
         vZUDg+PvR0opIMWwEjJXut62sTbvZ3snOLjq0ZXAMJYca96O/tphesePzMRLkdx3m40R
         7IlpyZu09nxu2bNfn4NpiaX3XXQxqNhS+qjuVNCbjj2bKGo1MwoAAfyfwBh7KgnQYvGB
         zyd4KJEUAJlp0Pr7lgOdjdNtopxO051IPUJXBOz1QtRiA/my7TwK6eA4aZm4AdY4/iIL
         KWNFxwfhPBsjCdXeST3/j3hAEM8BX3pZHtBK5O6tAJSUZdK6SkkUrWA5OPoPAGO28a8Y
         polw==
X-Gm-Message-State: AOJu0Yy9uXywfzs1t1PMgQUshz73gSiIx+ouEnlj5o6zQB1ibOWvTi1C
	kvgqDLPcKXrjDCDOD6FUlsrraR0JarUefnY1/kbNtxk3WeuSbaXYyXkRK+OVMAE4odBCcEwU1tp
	KoBcC3svSZZ5TdU5OCvL5vBhqugGsc4X0gAQtV1aBIEUGPhrXu6u5RHLRPw==
X-Gm-Gg: AY/fxX6lnFsiiw9yBK6L2pTaDkcs3YLBwTuj/LAIZJkwTlCAPdBCF4g2Nj7V2eFRojG
	TSuICzaQtxLygaVoh5eRc+SdUpm21Zojc9ry4z1uIqRLRUmEWIxIxVdy+dmw+FU7IAyq2kZFpca
	HtMZIDSgaGlMy2izMrvp7V/ClOfmDwHo2138J/H1qBpQuWTEzN9TtaizZv0Fg9IqSHkJlDILHRX
	8U4Ro2AZJb2fNHEmsGJjcW1IAlhOB2ukPGJcBQy8/H0n+Mpa58RrChBTsv1T559w2iRN63Fus4y
	7Sb6Gx92fyPpWbNV/Ukq6cBjDRPwKLo34H2gD+leywXSvlaxc1v1nOrzYh9/BfHQCQu8NXgQqYg
	eYEgQDpjNfLG6TN5oADIm/WHIrAns0Yt9Gg==
X-Received: by 2002:a17:907:9415:b0:b84:1fc8:2fb3 with SMTP id a640c23a62f3a-b8426a55c62mr34718666b.4.1767630544869;
        Mon, 05 Jan 2026 08:29:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlqpXrfgTMbNwMhWhnEfop0ztZ5Q/o2tpo995xxii2SNAlcGWXQ5vYp8zVnnIwlhoNRjeXYQ==
X-Received: by 2002:a17:907:9415:b0:b84:1fc8:2fb3 with SMTP id a640c23a62f3a-b8426a55c62mr34717066b.4.1767630544478;
        Mon, 05 Jan 2026 08:29:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65076169f1fsm177231a12.18.2026.01.05.08.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:29:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 40A20407ED7; Mon, 05 Jan 2026 17:29:03 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH iproute2 1/2] uapi: update pkt_sched header
Date: Mon,  5 Jan 2026 17:29:01 +0100
Message-ID: <20260105162902.1432940-1-toke@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
References: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This adds the TCA_CAKE_STATS_ACTIVE_QUEUES define for cake_mq.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/uapi/linux/pkt_sched.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 15d1a37ac6d8..fb07a8898225 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1036,6 +1036,7 @@ enum {
 	TCA_CAKE_STATS_DROP_NEXT_US,
 	TCA_CAKE_STATS_P_DROP,
 	TCA_CAKE_STATS_BLUE_TIMER_US,
+	TCA_CAKE_STATS_ACTIVE_QUEUES,
 	__TCA_CAKE_STATS_MAX
 };
 #define TCA_CAKE_STATS_MAX (__TCA_CAKE_STATS_MAX - 1)
-- 
2.52.0


