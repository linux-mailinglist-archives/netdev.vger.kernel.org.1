Return-Path: <netdev+bounces-120724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1690895A677
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78267B215D3
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022EA175D4E;
	Wed, 21 Aug 2024 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="AgOe0Yg/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7629817108A
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275361; cv=none; b=tl/L+AWFRYTzP3nijFLyJznpSNLD5bEMIzX+i0Y3xqS8TZ+IQdIcaz8PtcCDVK3zZtDvkPugWtzUHMWBa5bfAQ0f949wThwSLOE9E4Z4Y3Gj/C8mF8qIAL1ZKo1MstYLAscDqzqDHTz87Ox0Z49jyRZ6GDZ7KtwPOQYVQ9N1uAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275361; c=relaxed/simple;
	bh=YyZztFICIyC3NZU6IESwORkmV0LZE0KdGN1JMoaO8nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8h8dxM2VE1jhdAtXIvZtXYPwGBH8OLa2fjtcwWqXV1Ek0O6SQ35hr2p4om3Gzno29vN+ogyUy2+a8MaMOISzV3iQjWKF9HQzs+iHrzFNOx/vcVNab0wJjD0AnnamHPzmQx0DqDPmw1inFHzwsr9WpOFO2jeu65E9XiwI2uF5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=AgOe0Yg/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-202146e9538so1217325ad.3
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275360; x=1724880160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unAO7QbRteOSBlEV71R1L2OjksXxItVIlCBySIstqU4=;
        b=AgOe0Yg/UQRH9HcPit0Cg55LN2wLZUXsNVnNFxlhjp9LRzdEWtVAjNIFRI3YXSYK03
         qtyhKKIsnvYWNlWwgm/o3TXgs8mUysJBdXzY9GOTuHcxp94RBodYMFSnltNsbaLCC7rh
         cZPeYpzXEnh+vBJ9HLnJbP+3UknlFYK8QQLSlmK8zCA64xRE+BKho1jukPQn5J2N9urg
         1b4OyV6DCpsQWeiWE0hjMyjyLQu9pNjltO9JQeb6yupq3Cab6MWgNqE289RDUSClsjZ2
         +cx3Q4ld9SqHLcY7Sy/Ky6CchywNT1OFj8wiX/sKjtMYEl9vDxFRmlxZG+KYXn0fnUa4
         NQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275360; x=1724880160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unAO7QbRteOSBlEV71R1L2OjksXxItVIlCBySIstqU4=;
        b=lQzL/kG9RIuYQiTjqz2PLRbs8ULc1mzxZdx8uDug4KtbX/nCb0VpzLg7309rpsZWfr
         fRt5EtmjGdNxduvivzqtY5wtFerYJDpXN35hoFzcs/3mPj5z2WhE2vxPeoLSbRoSu7Or
         HgIPYczVVhIRCE+2SISF5DEgvgJnddJMJnYjnGktFTWUGMSojDCClB7ZEuLvNUq6ySSE
         z/Bs+72IYqBWhThOx1eULof/2+TzNpnIslA51LfTtHq04pqrcXfvAfnvXcQGb31uZZ+z
         dUSwD+uKcNYr7nRPptdqzaAATahqJuP/uuY8BIXD7OJG420OPxUOz796v2j6OtdzY5S+
         mFeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaLo4iej74/70S4b8Pmsqp7tzxBy0pcXdvaP/7shhq4/OsqDtQ+E2QwcEkGrxrEWdyUFBdXZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykAssoOx8w0FxQ5QiNfLawD18z3oHzJlXn05pcjNv0ByRYYffC
	UGCzdrNzipAvRS+OoCycbBwspbBP7KonuehJMYMpcpY/kbzyhQoTIAtmMJ3W/g==
X-Google-Smtp-Source: AGHT+IF/vo8qcl2Pxv4IXJou7lTgtbtRPWvbCWbRhezEi6DmheA8SlWOzsD3aRS69DdxnDtrZanl9A==
X-Received: by 2002:a17:902:ec8e:b0:202:38d8:173 with SMTP id d9443c01a7336-20367d31799mr37659525ad.29.1724275359581;
        Wed, 21 Aug 2024 14:22:39 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:39 -0700 (PDT)
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
Subject: [PATCH net-next v3 03/13] udp_encaps: Add new UDP_ENCAP constants
Date: Wed, 21 Aug 2024 14:22:02 -0700
Message-Id: <20240821212212.1795357-4-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821212212.1795357-1-tom@herbertland.com>
References: <20240821212212.1795357-1-tom@herbertland.com>
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


