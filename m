Return-Path: <netdev+bounces-121506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE45A95D7B8
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A491F24D5B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B098194A5B;
	Fri, 23 Aug 2024 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="LB+5OwfW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB95194147
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444173; cv=none; b=WObu546yO6eOlAJz2mRmlPM06PQXKToaAk2f0LxO/UW9sGDhjy+Io5nIZJoy/BTG8ATcJs8yDEfSU0UCQ7Wf+fiq9znjA6/J6PDjikXsOx+vWoLXuBQOK68xLJ7NLYh4dWOIUYKt40rsLMsZ8RjI7UTsScwWUYeedczhiINY7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444173; c=relaxed/simple;
	bh=YyZztFICIyC3NZU6IESwORkmV0LZE0KdGN1JMoaO8nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=USxr+POm+4r/wWIUN3hOcIbEfxP/9ZJTmQuxSt60IouJZAJeMkPDvC/oUJaZkAVJBPJVeP2dnvfHSe1YvU2ZqGqjzlMWShgltqp1ruNQ18Oj03v1vZEumgktL1ZUSmxwEryQ7pevaTOU48YJo5t9meQ24XmIEqvvFlxxD19s6QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=LB+5OwfW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7141285db14so2176268b3a.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444171; x=1725048971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unAO7QbRteOSBlEV71R1L2OjksXxItVIlCBySIstqU4=;
        b=LB+5OwfWbuX+fSMgNmAgqiqONrwjdcTsP8+YDD0uMqmIr4qxXA4nNaTA0eZ98Ibb3b
         Sy0fNCuBjit01I/DsjD8VmLIh/XAXuNjixvYepy6rt8WbEvUufsX6MHTAQh4NgLButw7
         /1ov+ALWmTT35d4EbOFcukRkTPGyKe0UsuCQbHEI8ubOBNqHzuRMeleRxRap4RrgJl9/
         ew5p6VKzRuG5b5Etskvw6NHO6jY+I0omK13UNvE4zREjkSEIh9tj4X9pmJhvHPkaHFqs
         0alOQl8xjuHJLcl/Z7Xzgj3nfISL6EunsD0GjPNPuvxLkzsgnbFJUCQqTtNKk1jPkVvM
         Sxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444171; x=1725048971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unAO7QbRteOSBlEV71R1L2OjksXxItVIlCBySIstqU4=;
        b=DI2V6t8UnkkGwoBBRpYdHErfKSbjk7apxcpkU5MSgKmJoGGZ5GOFf4Jmx1wf2gspaV
         qB5LbPaJN2xzb9cWst7sIXdOyrd2srJTYMlULkl+X+F3KGzqdB4R/9XMum/EqWfxjXhs
         R88wEud5jdpc0DsMNuPU1jfjFnAuTghWiHmFXqAkR+AarkgeySo9Jfy11cRPror8/mq1
         EgfIYPyPyKJLe97fG3gMNzYuQRswfxRmKh/9FEVS44Oe7KY9jLhGhW4CX/j9XBYPcxPR
         PQAuWJU4tyVbubXeQIMCpelqZ/e5PaUwW2AALV3d1YQJcuBgjI7oSOMvO/tPeFHXkd36
         QRfw==
X-Forwarded-Encrypted: i=1; AJvYcCXiXeNYeOjbR1VmwylJwANdGbWdbGoB2otLWTFhP+JX3pRzA2ISk5On8jolD8DhLnvny7e5AqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLcaL3Au/DyHNr4/sGYS+cvtZifpvW95JpFQYG0m1St6Y6FVhc
	oqMgNtbBj/k0ji0VEzFhSImezfs/Pu5TOMsymoxfrrlD2A1fvC54dcWfbl+ZxA==
X-Google-Smtp-Source: AGHT+IFpdEBxZYkyTsBV3dhEjE1uuP4JaCzJT+eNqeHnK5vx3bQT1Y6VxZXRElD59737tCcmEKDppQ==
X-Received: by 2002:a05:6a21:339a:b0:1cc:961f:33c6 with SMTP id adf61e73a8af0-1cc961f36e0mr2268260637.19.1724444171029;
        Fri, 23 Aug 2024 13:16:11 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:10 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v4 03/13] udp_encaps: Add new UDP_ENCAP constants
Date: Fri, 23 Aug 2024 13:15:47 -0700
Message-Id: <20240823201557.1794985-4-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823201557.1794985-1-tom@herbertland.com>
References: <20240823201557.1794985-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add constants for various UDP encapsulations that are supported

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/uapi/linux/udp.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index 1a0fe8b151fb..bf15c4ded3e8 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -35,7 +35,12 @@ struct udphdr {
 #define UDP_SEGMENT	103	/* Set GSO segmentation size */
 #define UDP_GRO		104	/* This socket can receive UDP GRO packets */
 
-/* UDP encapsulation types */
+/* UDP encapsulation types
+ *
+ * Note that these are defined in UAPI since we may need to use them externally,
+ * for instance by eBPF
+ */
+#define UDP_ENCAP_NONE		0
 #define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* unused  draft-ietf-ipsec-nat-t-ike-00/01 */
 #define UDP_ENCAP_ESPINUDP	2 /* draft-ietf-ipsec-udp-encaps-06 */
 #define UDP_ENCAP_L2TPINUDP	3 /* rfc2661 */
@@ -43,5 +48,17 @@ struct udphdr {
 #define UDP_ENCAP_GTP1U		5 /* 3GPP TS 29.060 */
 #define UDP_ENCAP_RXRPC		6
 #define TCP_ENCAP_ESPINTCP	7 /* Yikes, this is really xfrm encap types. */
+#define UDP_ENCAP_TIPC		8
+#define UDP_ENCAP_FOU		9
+#define UDP_ENCAP_GUE		10
+#define UDP_ENCAP_SCTP		11
+#define UDP_ENCAP_RXE		12
+#define UDP_ENCAP_PFCP		13
+#define UDP_ENCAP_WIREGUARD	14
+#define UDP_ENCAP_BAREUDP	15
+#define UDP_ENCAP_VXLAN		16
+#define UDP_ENCAP_VXLAN_GPE	17
+#define UDP_ENCAP_GENEVE	18
+#define UDP_ENCAP_AMT		19
 
 #endif /* _UAPI_LINUX_UDP_H */
-- 
2.34.1


