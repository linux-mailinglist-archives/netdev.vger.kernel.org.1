Return-Path: <netdev+bounces-171375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 155E8A4CC03
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 20:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B561894BD7
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 19:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11948214A93;
	Mon,  3 Mar 2025 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Flt7mgPG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459A1C8604
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030373; cv=none; b=Je9TBnt4kpwFv/OSFDdzFN1Gvm+cKuJLLXMRVdR4jKjloFhYWgm2DGkjc20mNy8XaOReTth0HV97WimReYOJqFqungOzR7QBI2pu39LNyGgI0IKlZ9f6A1SvPIS3A09ic1BN8J5HnWfKePwM5Gvwwp1MEeMe8BgmrOSMZjViCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030373; c=relaxed/simple;
	bh=0VMSB2O0MJikZNSDjmXSMMAz2W/lpShULie4XwxTol4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gx/i9SbgmI3B0IF6x5dj4evnXlRgZexZMZ9lBoxKuFslKc0SUl8c/3JnmSmahD+ZNAwV99ppngLumU2iImONwWV/lf2+hxR9NniFIzxT5jPjuV6eKdKMKWS6QHQ30UkfZBhcSg+uBKNJPms7PAI/dIspy5MlokyNPuibpke+Z9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Flt7mgPG; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be49f6b331so486683385a.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 11:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741030370; x=1741635170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ5qkFVsY7VE+1m3ZWo7fB1WRrOqQu4migYvOb+yNUc=;
        b=Flt7mgPGLMN1ENqvKTXjHyoczQWoU7LhKfd32a0ODnIMQDBLH6bS6PiisUmMsR5qWj
         S3waw3rX85qu2i3EvLWrVdsB8BAkyohFAdHDWh7N2UkIBhIqAsMvPHyvCQ2TWV/OOwQz
         IGcgVPVXr2OEO9jp/c2zCMR5w1XrieNaJfjQ1bfeZeXeFYxIoZYXkPh2S8habnLvPI9V
         tXVVfVBFucQq8vxJnIq99XS6BT4G00IICp9KVgfBY89xADDMeHfX5cOmG0gRc1xxvolL
         S4qMIvzNp/AuXs6bkTh5RMZM3uGXbthT2I0decpv1zWwMYDkuaerAlKbZIlrm7ASpa3c
         6h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741030370; x=1741635170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZ5qkFVsY7VE+1m3ZWo7fB1WRrOqQu4migYvOb+yNUc=;
        b=XT9MfpXjROa5QK+IF56Zn9fePrf3Wk33gtHiabxZFuZ0AdTm216Zc3kpdciNb3k6BP
         L3D5G6gb2+wOeSwO4YrU8SIZd4qyN8Y5ZX1EBa1myCCWxcJjbxOUfLFChBpf9j27lhsA
         0Ls5abI4PZmhqWUmTJNcBdOI0Bp/Wi5pg8r5GttwqOe3xYPbyXr1lUsQTqbEHM/oOvbc
         2GcYMowE72n6gcuxPx0p8GSAeAwOAHVP8mxCnSs7TGO2H3jcQXmD2NpFLehnjalmqhep
         b/qe41TgXx0oMBou/hmZUAFJLfuQNdjLKgyvLxn7hOcIb0rxGW+lD2ec0lFnnRK1TJDm
         pRdg==
X-Gm-Message-State: AOJu0YxMR+k2WWpvhNg9KWLMVVCAzBSE3bBzAMV1UovjhCOb3wAn1kWH
	+7GaAY9UcQ1BVNgv5u9pf71dhKkKW0KCJqZlJHQbzuc8pcriqXvFGtvMcC0H
X-Gm-Gg: ASbGncvmbG1tXlFUZNgmFDSidsju2oDC3eS2zdHkJCy+utOMVjsYtlVJp00+Pv5P2by
	pZhyxc6UB1GVFpZQbqA0ONNiYhTBcmcYHj7nXtp3774VBBEgjvS7PkahiCMm3iQ1U9ljepOMSNz
	qQWVTI9N773JzsYny8RbwjmIJr1zJIphz3wYzjDD5DfJ8zgFhCPVZjgRqrPwvpdeqxyr/eiyrTM
	bCCF3zP6W4Tkhd6m+3QIfy6QOoEjhYqq9umYuq0A8h9ysvAFae4pPYafz9bRv/rPEP90Cqpq8cl
	Na6+Kxv/ceRCWn3SQs5AMaaVxAXof6rU6DltaBI+EvAqGBNTny2yd8gMgagE55DekPJ3zuC7sPl
	gvJTAsuiS
X-Google-Smtp-Source: AGHT+IGxnkv3yOl0mZGx4BpIs1bORrfb2mY0w9cJbtg06XKQ9JjdA/DOsL6kxVL1WScRprGqjM9r2A==
X-Received: by 2002:a05:620a:244a:b0:7c0:c214:f2d with SMTP id af79cd13be357-7c39c4c70fbmr1991319085a.31.1741030370158;
        Mon, 03 Mar 2025 11:32:50 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378db7091sm632580385a.115.2025.03.03.11.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:32:49 -0800 (PST)
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
Subject: [PATCH iproute2-next] man: document tunnel options in ip-route.8.in
Date: Mon,  3 Mar 2025 14:32:48 -0500
Message-ID: <528cee6bcfd8ff5b4d294d5b59d5c1ccfec18e19.1741030368.git.lucien.xin@gmail.com>
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
 man/man8/ip-route.8.in | 63 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 7 deletions(-)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 69d445ef..ccad430b 100644
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
+- Pecified in the form CLASS:TYPE:DATA, where CLASS is represented as a
+16bit hexadecimal value, TYPE as an 8bit hexadecimal value and DATA as a
+variable length hexadecimal value. Additionally multiple options may be
+listed using a comma delimiter.
+.sp
+
+.I VXLAN_OPTS
+- Pecified in the form GBP, as a 32bit number. Multiple options is not
+supported.
+.sp
+
+.I ERSPAN_OPTS
+- Pecified in the form VERSION:INDEX:DIR:HWID, where VERSION is represented
+as a 8bit number, INDEX as an 32bit number, DIR and HWID as a 8bit number.
+Multiple options is not supported. Note INDEX is used when VERSION is 1,
+and DIR and HWID are used when VERSION is 2.
 .in -2
 .sp
 
-- 
2.47.1


