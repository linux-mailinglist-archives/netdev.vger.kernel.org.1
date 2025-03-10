Return-Path: <netdev+bounces-173565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE83EA597C6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30743AC270
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD1222D4F4;
	Mon, 10 Mar 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8C8CxUz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6522A4D3
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617351; cv=none; b=P44tVCiF2d0PxR28sfOsaS/vvAdVnS5fq6wCeyrJEBmE9n6gn74tltAhSIcx6RgVplzJdBlavcpgCp/mRN6g+vsRRreVMHUmG2eZuVsQZ4iWF9teFwrr+gyUSbji5aQu+1ZnFjL4trVn2EjfXNOwItPpL2PYftfeeAQYk42KJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617351; c=relaxed/simple;
	bh=AM5g+RWIaNSJ2sLp8SG090P8eEvN+G9L+7BSsCcMNvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhVWvK4MHs0x2fCt2pSbKjtCPAUIZnSPFzCCJk+MvlW+k6cd3TNnKpO+/aqfpadJ5C7lLbUqxpO/Z4DyEuApaA5/AbZlc0nAXU4/hMiWznwF/90KHC4Rau9h50vs7ViDppPl1XCjIiXtNohiQv5B/Y9Y+e5sM2iS3LP6QnFPk8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8C8CxUz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46fcbb96ba9so56848681cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741617348; x=1742222148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfGqH+MxiTtPaMD5/mNX+CLiIn8dxq+Moq11zpG8gO8=;
        b=g8C8CxUzMhNh4aLkeOT+iG9r/Hxw9i/WsFWqCrb0JuOYBPp3C9yR6/Q2So1U0z79A9
         2twE+/tYNIcXE+i/7xP3lLPp5V5UmT34ApQCnhyETswSlogqTH2Y59lEngfD8lXfzxHi
         NVNVlCsulki+zSo0+bgq/ptkq7xeAQ8yuNG6HyDxK6zejPf71TFKYAQXE+U+7l7QFAme
         kBcfUYOfIJbmHPv6C8Eq/DvBCuv2z8xO6ScawH/R2bxJZRKqbXTwanKRfWmfdcs6waa4
         m2QuXFemIIYL9Qm0+tCYi71h35ThGx+RUuAMBWumd+0MPIZ6BM+wHoKN+rX5Jm9QGHYd
         iRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617348; x=1742222148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfGqH+MxiTtPaMD5/mNX+CLiIn8dxq+Moq11zpG8gO8=;
        b=HIoZmHgHfRUdMgKfitH7VJXBAoB3/BiT7MEl+Yqh4jZgYYR9EQPsd4p/wwZumyGZIZ
         KruUy9rR1bIMDvFrpd7pKwXl6+6ow+71EWwdmvwEy2YP5sWTSkHoYkVfHsGJE/LwzeZD
         30R0m/DPGu/D7T2H1LbLAfy27erSfpD2dlodSmsoJIQZAhC23oPZ+jtSCrLqMyvub6Tl
         /kDXP/5gEHg6thDtVQOShjlG/6jdmDSyFlebgwKPLDZh9BzvwWkBfYIddm6y5wsnd+Yn
         MmtJkMY+UhkRtamaGjYaeGOZ+mvhWSh5OXfqJDiWnBcHL5Xq2fSiRnJ0MmcKwEt/4fl7
         NN3w==
X-Gm-Message-State: AOJu0YzZSdzZdQFFkRhUB3Qjq7uIDWkhs368VRIeeCuRadru2k69zETR
	IGCCcTOhL7dAfn1KnqqJNJ/vCmJ48nRKNuQADdAxJz4b4ayk0uOki/Xvzw==
X-Gm-Gg: ASbGnct8VuBeImEutkZoOu4g0wGCkhZpM2LRnV3qJa5+JLaUPedEexK+qr27ho8NwUU
	m37timwKAUG3dApcTnPIc9Xe4G9vV5QPQnpGAg78lQJmG9tRtO7BiW6mnAhOJoJglI9tPdhH2SZ
	p+EhUnpDd05SRVs9x+DFAlbu+zoB7R4vJ0TgEXNd9pfz3hIaJDIuLJfhXDDg856XiyTyVtNSJSB
	ytamvRgT3iUPQU9ROhbkKaENPK3DbrfNLCTDkN2iF0sXE2SWGea3RXICw26YkJ39211f0v93tet
	HgUwLYSSKbX80OWLiRp4KwRSfPBLFWEVSrISiTQWOxXR/ODJLe8DcH9Bu+8Wb0WWpUb90nuhKi8
	hdTMATKga
X-Google-Smtp-Source: AGHT+IFfBKmCElskkDWpxvhXD2xwXBA9C3CY81kk6qdXFaeOgEXAPJuS5KSHw2Ybxms28a1rCSPGeA==
X-Received: by 2002:a05:622a:1a06:b0:472:1f07:7a9 with SMTP id d75a77b69052e-476109c1886mr207244171cf.31.1741617347909;
        Mon, 10 Mar 2025 07:35:47 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47678eb3136sm25118261cf.6.2025.03.10.07.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:35:47 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	David Ahern <dsahern@gmail.com>,
	stephen@networkplumber.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Andrea Claudi <aclaudi@redhat.com>,
	Jan Tluka <jtluka@redhat.com>,
	olichtne@redhat.com,
	wenxu <wenxu@ucloud.cn>
Subject: [PATCH iproute2-next v2] man: document tunnel options in ip-route.8.in
Date: Mon, 10 Mar 2025 10:35:46 -0400
Message-ID: <e53824a6dc6a300b44d2a58a067722e35d2b74da.1741617346.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing tunnel options [GENEVE_OPTS | VXLAN_OPTS | ERSPAN_OPTS] and
their descriptions to ip-route.8.in.

Additionally, document each parameter of the ip ENCAPHDR section, aligning
it with the style used for other ENCAPHDR descriptions. Most of the
content is adapted from tc-tunnel_key.8 for consistency.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
v2: correct typo: "Pecified" -> "Specified"
---
 man/man8/ip-route.8.in | 63 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 7 deletions(-)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 69d445ef..aafa6d98 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -216,7 +216,13 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 .B tos
 .IR TOS " ] ["
 .B  ttl
-.IR TTL " ]"
+.IR TTL " ] ["
+.BR key " ] ["
+.BR csum " ] ["
+.BR seq " ] ["
+.IR GENEVE_OPTS " | "
+.IR VXLAN_OPTS " | "
+.IR ERSPAN_OPTS " ]"
 
 .ti -8
 .IR ENCAP_BPF " := "
@@ -783,15 +789,58 @@ is a set of encapsulation attributes specific to the
 .in +2
 .B id
 .I TUNNEL_ID
+- Tunnel ID (for example VNI in VXLAN tunnel)
+.sp
+
 .B  dst
-.IR REMOTE_IP " [ "
+.I REMOTE_IP
+- Outer header destination IP address (IPv4 or IPv6)
+.sp
+
 .B src
-.IR SRC " ] ["
+.I SRC
+- Outer header source IP address (IPv4 or IPv6)
+.sp
+
 .B tos
-.IR TOS " ] ["
-.B  ttl
-.IR TTL " ] [ "
-.BR key " ] [ " csum " ] [ " seq " ] "
+.I TOS
+- Outer header TOS
+.sp
+
+.B ttl
+.I TTL
+- Outer header TTL
+.sp
+
+.B key
+- Outer header flags with key in GRE tunnel
+.sp
+
+.B csum
+- Outer header flags with csum in GRE tunnel
+.sp
+
+.B seq
+- Outer header flags with seq in GRE tunnel
+.sp
+
+.I GENEVE_OPTS
+- Specified in the form CLASS:TYPE:DATA, where CLASS is represented as a
+16bit hexadecimal value, TYPE as an 8bit hexadecimal value and DATA as a
+variable length hexadecimal value. Additionally multiple options may be
+listed using a comma delimiter.
+.sp
+
+.I VXLAN_OPTS
+- Specified in the form GBP, as a 32bit number. Multiple options is not
+supported.
+.sp
+
+.I ERSPAN_OPTS
+- Specified in the form VERSION:INDEX:DIR:HWID, where VERSION is represented
+as a 8bit number, INDEX as an 32bit number, DIR and HWID as a 8bit number.
+Multiple options is not supported. Note INDEX is used when VERSION is 1,
+and DIR and HWID are used when VERSION is 2.
 .in -2
 .sp
 
-- 
2.47.1


