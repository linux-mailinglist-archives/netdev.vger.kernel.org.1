Return-Path: <netdev+bounces-249086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D5D13C2F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4926930F643E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0633612E2;
	Mon, 12 Jan 2026 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9n0X+7Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4535FF64
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232121; cv=none; b=aYxyTXFzHQV0yZNnqhZ28hhXOAkD5uzFG/UmEhS0LCbQ4MfMO5JnhEh8zl3fO+cKYI2gv4EjZolV9wEcBa5Ba04Enso3IHRj8eaFZWEGQqjp0Uc1owwX98b2GmYCE3MjTd0U0paamZXPprnYrjiK0LNhOdx/LTUgBOX0vIKDLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232121; c=relaxed/simple;
	bh=CqkrBbQJARC77HViTJ7Fw835RSSe59j00Y/6Yal3gVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fVSOBW3WM0ktYow+pqP+XGWg02V535NBhy8gVqwmJYrgslvHsogDqfze9Q9TJ/k+q1uAP5+HYa8yVFG0Nohg4AYLEpt9eodmASNyOEZLmHDfzON8m8LAUMJsgFGJDS+KK4W9bEdMMMm10HEoUPTCsOo/dwe/EyaV7umyxURICdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9n0X+7Q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47796a837c7so45317445e9.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 07:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768232118; x=1768836918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bisDuv4nPIuBAuwZ3nv0ukh31CRRL1f/LFbl87ZPJiM=;
        b=D9n0X+7QWT8DaUBECRPZFql2/dw1VTf8WiXIdYwrvAqtKEL/DOi2N6oXE7P/u5K6MM
         Kml8FbKjx05yrg8GbLcH6gH5mMKEeZQH+ww/hUgeeueG0kyhyjHcXFCW51B3lZ223PX5
         iYGBF6lWvo197Uw8CRni2C9jMPerPEn8ebrrbdtlehZKIoCpd6qDNvKyiKh/gN5ccIeg
         pPOoJC+1qr3Ld6TsSSfLBHS0FoGTnG3w7nQv9MWabMicebP6XgojgbB70Zqsws08TYdp
         EKqZb0pvCcWuJjJSvp6XGTcdZ8V27izgbvxETc0mlRMzHBXxhAMc7ABkgnQcZbk3q8dy
         IEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232118; x=1768836918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bisDuv4nPIuBAuwZ3nv0ukh31CRRL1f/LFbl87ZPJiM=;
        b=VreXxWOgI1C+nY+e5Rt9rIMvIKFXYz009HXTkSy9KLIsPKAJohBuX/vz94QFkG1pgU
         C33ooln9FpxMeHG50tmDeKP0ldBnv4NqaPwDHMdgLH4E9IDXuPKukoizJJZDA5LxtZOe
         Gi6HOaDt6M4ae9SZduaz4KZXJYyz9lwYZ9TsoVGQPS572cRgtZtEwdkexdybKHqtBttJ
         MwptPnXBJvIxz3lAYb7dwJo+uV33Y5MpL/GNmIKYlND8uHmqV22I+8ChSwSdrx+VZSUX
         lC0+U/dGZeHBSS+KmdjiBibr5RiuaNcM0+hoD1JvzPRzJzSY6+NxAB2kWjqbd7+XHZ+l
         KFKg==
X-Forwarded-Encrypted: i=1; AJvYcCW9sjEYM7Dm7PKrYfSHeUtoCJX1S2yfO1Mn42US32DAoqkN+0FSFkh4UUVLswum1KYWuWWduH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Ca0hw/9WrdXTmkljwYopptuBWYQrH+GP4afDQLf2A+ilWV+M
	vVTK49E/+k8oM47976lrtPDL86hbx/J7WbSgvuV5cui1YJFf/TmI3Jz7mcgokRY0
X-Gm-Gg: AY/fxX6Y3RUpoRI/C3chnC6XrWyLZ4HqUL/fjvmxKlrRUDDwzqaxjr9/EDwDf2vkGD9
	NnBB+kWbiRqhhbxWnjvqO9boqlZ0v0/Hf4H1tPhFFm2v4YQ9tBjGaSRq6W8nf7tF08WsvAYQXOw
	bPbINutEgadGv6Q0bq43Qu01LmB/e9KNey9XG0t3YODpUzsXPTGffA3tYnKwMLmo9LyUOfFKF1H
	TXZVFArR1APeyJta2nr8rOQBj3IKfv3xjRzcHjDTltR0K8UJEgbDqz4Z9F0JebW0ef2IUE5cbja
	E4ZfAuWHlvRuHneWLt+jvqh3Bo8py34P+JtOPv4VdFXRxYve5Jqbsf1h61qmBbMDFiQ5ayQ3i0D
	oNwgEKAuJZrldsLj4pfJ7ETMM2UGbpH6hIz3FMh8vy3+CQrHCzJr+nWhsawG3vbu59OEcijkK4m
	1Xr+lUS8AclumUPXiwd54/jfv2xFV6l/1scg==
X-Google-Smtp-Source: AGHT+IFkionbBPxAVMu1Bo9fnGCSD/FhMiTLzbgpT1ra0OiOGliqUo8UWo/OByWQL36OmxlkAVQrNQ==
X-Received: by 2002:a5d:64e7:0:b0:430:f7ae:af3c with SMTP id ffacd0b85a97d-432c374fc2dmr21802974f8f.31.1768232118128;
        Mon, 12 Jan 2026 07:35:18 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c1a8:6cc9:af79:502a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9afsm41592789f8f.24.2026.01.12.07.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:35:17 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Donald Hunter <donhunte@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net v1] tools: ynl: render event op docs correctly
Date: Mon, 12 Jan 2026 15:34:36 +0000
Message-ID: <20260112153436.75495-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The docs for YNL event ops currently render raw python structs. For
example in:

https://docs.kernel.org/netlink/specs/ethtool.html#cable-test-ntf

  event: {‘attributes’: [‘header’, ‘status’, ‘nest’], ‘__lineno__’: 2385}

Handle event ops correctly and render their op attributes:

  event: attributes: [header, status]

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/doc_generator.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
index 3a16b8eb01ca..8b922d8f89e8 100644
--- a/tools/net/ynl/pyynl/lib/doc_generator.py
+++ b/tools/net/ynl/pyynl/lib/doc_generator.py
@@ -166,13 +166,13 @@ class YnlDocGenerator:
                 continue
             lines.append(self.fmt.rst_paragraph(self.fmt.bold(key), level + 1))
             if key in ['request', 'reply']:
-                lines.append(self.parse_do_attributes(do_dict[key], level + 1) + "\n")
+                lines.append(self.parse_op_attributes(do_dict[key], level + 1) + "\n")
             else:
                 lines.append(self.fmt.headroom(level + 2) + do_dict[key] + "\n")
 
         return "\n".join(lines)
 
-    def parse_do_attributes(self, attrs: Dict[str, Any], level: int = 0) -> str:
+    def parse_op_attributes(self, attrs: Dict[str, Any], level: int = 0) -> str:
         """Parse 'attributes' section"""
         if "attributes" not in attrs:
             return ""
@@ -184,7 +184,7 @@ class YnlDocGenerator:
 
     def parse_operations(self, operations: List[Dict[str, Any]], namespace: str) -> str:
         """Parse operations block"""
-        preprocessed = ["name", "doc", "title", "do", "dump", "flags"]
+        preprocessed = ["name", "doc", "title", "do", "dump", "flags", "event"]
         linkable = ["fixed-header", "attribute-set"]
         lines = []
 
@@ -217,6 +217,9 @@ class YnlDocGenerator:
             if "dump" in operation:
                 lines.append(self.fmt.rst_paragraph(":dump:", 0))
                 lines.append(self.parse_do(operation["dump"], 0))
+            if "event" in operation:
+                lines.append(self.fmt.rst_paragraph(":event:", 0))
+                lines.append(self.parse_op_attributes(operation["event"], 0))
 
             # New line after fields
             lines.append("\n")
-- 
2.52.0


