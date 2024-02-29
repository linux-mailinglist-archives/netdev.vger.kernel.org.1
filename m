Return-Path: <netdev+bounces-76253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2D586D02D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67751F2198E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234304AEF9;
	Thu, 29 Feb 2024 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCo5SMio"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00D4AEDB;
	Thu, 29 Feb 2024 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226612; cv=none; b=Fc0YUDNzYA26/CbVkdGsE4dlqIyb0n/90+dWQJBZhlXqxAUMtJcviw8of2XHNNdva+mXf5ufUjRhd1k4KbxxYuGLDeZQVczL2qUzvOw6PDAtYQmP6KGAe7y8LLIGGzb9kB8kTOAPFFo47QfpPeBx71AbQgJQnbD0McQlnxlOc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226612; c=relaxed/simple;
	bh=njvBPX1DNwe2cyt57j+VRCjmdV/1swUZKK6X2bpK9k0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/yG8Y0mOfEE1vC/0GzU/TUJRlAhKG4y5Xsm0g5xp8r2exuOvi6tVGOzwbvyyq4PyVKGCaoIViJEPqz0ZRC+3tHdNp3Aezo6pRUigHEVRs0JapX06ACcafcXcnUuNUtr3D5blOKqK7t6KnhtLSwTYTFd2d3dFSfXgIC+JqxbF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCo5SMio; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e571666829so795913b3a.3;
        Thu, 29 Feb 2024 09:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709226610; x=1709831410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOryb3yD/I0lOS8TxQqxl5yW4riCmRcOQm9ljmt/YNo=;
        b=eCo5SMioAujOQ9bUrRIDd27q63gkuRLbvk58jbh4FNAR514EgPWF+TegB4HWWSeIXd
         vUtrljRuDN9VuFaHJ3sg14g6KT0UfIeGTuZgwtBDGs8PHBbcIYEMXE2L/V/J9dLU0V9U
         5inN0f1BO35eXQf4WEOf1eGMACn7JMPGzH95k3e6zzBln0kCbs+TzhpUe+2ns03U4167
         AD1YjIK6Gdy51wEHea8+JKRHhQnDFuGr0EWqArqmlgCPx1TgTUe4HJ2fheppseMQpim3
         Cj9a0LUqgFZi/bznxJeaiPUjgPCLAT82z1+rdjJeAJuzEDnR49VCg68/RVTuxmhLMHqf
         VXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226610; x=1709831410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOryb3yD/I0lOS8TxQqxl5yW4riCmRcOQm9ljmt/YNo=;
        b=mAthmzAmyR2xnkXtsUxslV8BLvMAouKlMzbtD2Dbxo1AWs0VC5Nirsh7PVxLeGBOVV
         aEI1MU7eaX2X+V9AYwcS9Y3802rN/RpxoibNa/B1ojbOKXREodvzfZWco+L/HfrDTTOV
         beva2SbPb6htEVvLNHqy160oGDTNTcEfW0vF4WUTOnCKCKCKRIeBrqTqy8g4UyHZSyZ3
         nfnKRKlbSSbYz6Y+LtaCc9IkvklOdxHeH3mmOHfuXDe3458De8NftLlDMHSD/gFY2iXW
         02vPK1O+9OEVnfWCAcXIgPdX2P+rVwqg/jGuabVcIQtzQulcOJpMNwNNBO+rC/SdNEFR
         gy3w==
X-Forwarded-Encrypted: i=1; AJvYcCWhN1+jG6zXaJ/rjPHquPoFu81kFii4Cm5dbjU/QzXbgQ9uo1KUFmTg2N6aQPJDN0Aek6t236J+jl3FbzbGQ6RExZb2AoJZtKJbLN1lYEiiS8Fk
X-Gm-Message-State: AOJu0YwUhnS6IvQAE0HtNDzldpZgWbVvULIkeG3aEbwuTxDm64yH9q5Y
	6L428quyofVQ87x8HV9ICwZ+KgJ7oc3MdsZFgGOoGdOiWC3WNNIM
X-Google-Smtp-Source: AGHT+IFiFqkRrLNvmiYy2dmNCC4IYbhdfIar5pY3hpt0m1BbNY9+VLnghyMMeepiEN2ufH7p2QaghA==
X-Received: by 2002:a05:6a00:9383:b0:6e5:3b8e:bb6b with SMTP id ka3-20020a056a00938300b006e53b8ebb6bmr3901345pfb.7.1709226609927;
        Thu, 29 Feb 2024 09:10:09 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id b76-20020a63344f000000b005dc4829d0e1sm1558808pga.85.2024.02.29.09.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:10:09 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/2] tcp: add tracing of skb/skaddr in tcp_event_sk_skb class
Date: Fri,  1 Mar 2024 01:09:55 +0800
Message-Id: <20240229170956.87290-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240229170956.87290-1-kerneljasonxing@gmail.com>
References: <20240229170956.87290-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Prio to this patch, the trace function doesn't print addresses
which might be forgotten. As we can see, it already fetches
those, use it directly and it will print like below:

...tcp_retransmit_skb: skbaddr=XXX skaddr=XXX family=AF_INET...

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/trace/events/tcp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 7b1ddffa3dfc..ac36067ae066 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -88,7 +88,8 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,
 			      sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
 	),
 
-	TP_printk("family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s",
+	TP_printk("skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s",
+		  __entry->skbaddr, __entry->skaddr,
 		  show_family_name(__entry->family),
 		  __entry->sport, __entry->dport, __entry->saddr, __entry->daddr,
 		  __entry->saddr_v6, __entry->daddr_v6,
-- 
2.37.3


