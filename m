Return-Path: <netdev+bounces-114639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E779434ED
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF7E1F23464
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF741BD4E4;
	Wed, 31 Jul 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="aSD0huch"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E21BD004
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446638; cv=none; b=MQDIy47rjb4FX2m4m2pRGrDmbnC7XMbMojGPi9CG0CrsnxmATG843ND5mdtTz++++471/iD1GXc3ubWyl4ibp0bpaPjpQ1V5+nujThY7p0glUKlaYxiLOLUp+jgGYHJMEqtPVXocMypCMSyALGG0zYZILtqlxzZhIZgqmVkdXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446638; c=relaxed/simple;
	bh=UBnlbylDQiGGFqb824hJ8LOfBeF2it/cgHiViI1JVBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iGCJ7jxDD5xCXaqKvr8o0yGfMHL7dfKNaXmrvt6GebTN2K6SbdUHiZ9Eqxj5PeH5QVAvQYVggWryOJNYExwFBLshdw7yNq7x136zRqfh/IiFpK1GC2z1huVh1Ir+ihvcaYG6kXkSs7u/k/hzMiOksf4sLuCahDHGGN6paQT8oZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=aSD0huch; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25dfb580d1fso2693656fac.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446636; x=1723051436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f2VEr48rqS/xVUGYX/zdpL28CXVAGtsS1olIt5KoRY=;
        b=aSD0huchpLYp9lMTDyidEQSA/AtfKHi+qwc5n01mVi0vKTDC/uLYxh/N1TbxIr5o0J
         3zfjz/aguzi1rV6DVvgRK/OUkK80KISmNCF/hHi3Aj+N3UYV1VBh+f8+KVSx0c87sx1d
         KFyHZnhlDbEfWm9tCPPGd1m+aMC0gpcUjTY3BT3CXWtA8WyabEUsYWs44diQnj6c5W4f
         0jjIpILnjK/nKtIyG3mMjC1g3bCDo+W+pa6pgAKS5wpPHRkS8m9FtQgRd/XcvCf+K+kC
         o+aOJE9O9taR3IMnTU58YjFi1XAQr0NDtVPq92HaeSr6U3hTKMEyDl2TYSRZO7BWGWHT
         +aZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446636; x=1723051436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8f2VEr48rqS/xVUGYX/zdpL28CXVAGtsS1olIt5KoRY=;
        b=m9oC697UZLCc4kfuqvXdzIzakW2cObfX5laIzecOxwnAVsZmXUyfTUlN55v7cuomlu
         z9AMd3iAMzVi37MGHASiMqJqGeOGOwpjEbYVDIV2Jv1GOz3qq5YHim5H10IF44p7JfX0
         awkrzWYzh2K9wfowGiLytaW4n5a5RC+AYwGi01l9K8B23L2LvG1jHjz7/6eT4Lfb4w1n
         ytOtEwKVsDq+9vnpUouL0eDgnihA0cQ+TpV6EMVT0iffshxXTIjLT1E7aSk6zJcNpBE8
         KZM7yE4znnAjQf+uzOsqaqWEugpYGc/dkhShjZSWKjpAcQqQGp7tbE1abaS3ATX2IOWL
         SAjA==
X-Forwarded-Encrypted: i=1; AJvYcCVj7cFXH3cli6p3ASgrdxTl5I5IushSYIfyv8SC89gmcHv6D6AW28OxrtD++6sfcLwLGiV+tXYundbibUPwMz0WnptUmUgY
X-Gm-Message-State: AOJu0YwpDtdCvJjYl/NIyviVsbHu/Eq4agJNzhG7BFLyjHJhK9fU7qH4
	tJMTxGe8lPsa0xtwhZvvbPR+gdgFSZPi4EBrG5Uxfgbs/Oia9r51uV5xsbbYhJIE5PES2MtoGch
	pdw==
X-Google-Smtp-Source: AGHT+IGwBSHi1BId3E48H2h8nNpnR8g3goMlcdHaj6q6+v1C/nYhws4c5z860rXgGddcCGnHXzmepg==
X-Received: by 2002:a05:6870:8a24:b0:259:8cb3:db2e with SMTP id 586e51a60fabf-267d4f01dafmr17784968fac.39.1722446635701;
        Wed, 31 Jul 2024 10:23:55 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:23:55 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 04/12] udp_encaps: Add new UDP_ENCAP constants
Date: Wed, 31 Jul 2024 10:23:24 -0700
Message-Id: <20240731172332.683815-5-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731172332.683815-1-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add constants for various UDP encapsulations that are supported

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/uapi/linux/udp.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index 1a0fe8b151fb..0432a9a6536d 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -36,6 +36,7 @@ struct udphdr {
 #define UDP_GRO		104	/* This socket can receive UDP GRO packets */
 
 /* UDP encapsulation types */
+#define UDP_ENCAP_NONE		0
 #define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* unused  draft-ietf-ipsec-nat-t-ike-00/01 */
 #define UDP_ENCAP_ESPINUDP	2 /* draft-ietf-ipsec-udp-encaps-06 */
 #define UDP_ENCAP_L2TPINUDP	3 /* rfc2661 */
@@ -43,5 +44,17 @@ struct udphdr {
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


