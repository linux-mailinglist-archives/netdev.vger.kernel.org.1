Return-Path: <netdev+bounces-147111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D419D790F
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE95B226A1
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 23:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6071185B6B;
	Sun, 24 Nov 2024 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3rgm/nG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F359183CD6;
	Sun, 24 Nov 2024 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732489214; cv=none; b=Xl+D73FJsDtCV+JZ6VUrGfC3bMNx1p4rM1xpVytvfpeHA5R4P+JRKIUPi2qLjyN8bCBiWswqd1yb5oeKkI0DZF74lSjn/a3Yazm+H3TrfvUWDn4EmY4vh6pHyN1/QF8C/OT8wgjE0T7C2idnS+udNBUQspuDFs+FlB3nTSSDWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732489214; c=relaxed/simple;
	bh=+Xu7LpvkWORKcGzWxzrP1e3ZbJIL5wrdHr0BLgTc1xU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xt5jKumNn9iQfNoZqeL5z8DtnP4xkBI2UgZaHupWAyxYi8eavd+XLe+Rcc9eGfZlz7ZHjWeUb20bVzFrzjTIihFkfvUisZmrDhNKm2yu2Rz6jpTiXAMQWM5VTJXK4NBsf6+SwrOlv0lbISPGiKAauQ8+baLzQKJWFNnYYSVEmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3rgm/nG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724e7d5d5b2so2017252b3a.2;
        Sun, 24 Nov 2024 15:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732489212; x=1733094012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mpwQAY/y3s/YiKLLW+31fL0gZz6Q1yNva27VtG1Cnnw=;
        b=U3rgm/nGKNTqtMhU08iU7CtRvfhk+qOpPgqwPXWdvzxTtrHKW7bLorylFWdHjTvRS8
         vaIbTqHQooX8j18h6HW1ieDbJUIgiYRytoeEJnHgjA+Hht0rQVejl5JRrxw8vKQFZ63o
         F6mVHsP1NcfdhZ4KebMArddeUTRudj0a/OybmIQbc3FWqEjkYC5wwRItY65TdzFGWuKS
         0K/bOCy/NBXj8o/W1SlhHUSM/PAPeil2KWU0e2nXkmIMcB5vFE1vODKdNVLQgJEZCnm/
         corv4YvDTNQRUaOGWqzoruPH7mOGU5iQcJpLcrvs5fxSb8UX5PY1x+oOmUTmDCS9G3jA
         YLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732489212; x=1733094012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpwQAY/y3s/YiKLLW+31fL0gZz6Q1yNva27VtG1Cnnw=;
        b=u3F/kADMJ2xzV9BZqlz1+45eQkA/5RMbpzFhj6zV9gamOlOdlbywJNca4/hbloUf7S
         Yv/2ISrtfpx1Jxz41QiYmAlE197eJnVCPXVNYrl9yjBD2qzj21SfoO3fdXhhSWPBHWrh
         l1U4RRChH7HdXN9GcV9S5iaTeL7PR4GItqBWWKMW4xwiW02eZLNhIEuKUX0n23J1Pzjb
         M8EVwzrY3XsRU2dGALvUIVhuWV8xGPrya7CeIBRXiw8UtoWwyWZorlsD+Bq7n/yXVIHF
         ZzPjoeC17NuT128Unj5zge6KRy4HFj8qP450eW141nl6xeBZmW/CCOhGpv6d0/dI4rEd
         8Lxg==
X-Forwarded-Encrypted: i=1; AJvYcCV5UHzcW2MjiYZmFADJoB3w3oXNlcmipqKKrhsgoJ4aME3+fUheB1u9lK4BwBuZOycEhglz11VN9zP8BCWe@vger.kernel.org, AJvYcCW/M1TaKwgtSWuiC6sivOIV5W7j5WVkObo3W0HJjQkFm5lo0g0fcUOqJio3u2SvVgAJIkBaSEIX@vger.kernel.org, AJvYcCXimMeE5q/h1f3RM76emdJ9YdzXPGdKGi0lKiQ9uZP1o++hLAG2kbhXmE9BTqmD3HN6IBWSj7cj6qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTkCaYGC2zQQkW2PJbE4Qw3jy8+DF4GcCpWB+2nFhSuI0o35e/
	67Uf/fUNkiBk9TUcMN0mRXV/EQI+0h+G9OflrMM8DUQ5zXqdhKdz
X-Gm-Gg: ASbGncsWERYHnyvAHd1glnlyW4U59XZYKRP3gZpY7F4wHnNqbAFL91v2qA1h+NM7ZFT
	2r8w/+HzG24jHwYU9ZH5kXl1O1CDtMHlz6dcajpeDG0VqsBoKiUe/bhXAVrWDRGWvSNOch5krj+
	NExTmHAnDti0zl8ar/468w5ijzffob8v2r66ZJub4ks7PF/EVsmofMY1BON8vfbvdicoQTsP2AS
	ng1I2uiijBeVTS1bSMip0ZIYebc4o69O1khfPfgnwSx/6r3RPgjfxrnTbeKzPmIuw==
X-Google-Smtp-Source: AGHT+IGUnZQWDsFadewkQbsu/0WUOmWeV3zVIZ5pQhuvrj989/R9KFsT+pSTCdbaQi5sq43QHljjEg==
X-Received: by 2002:a05:6a00:2313:b0:71e:db72:3c87 with SMTP id d2e1a72fcca58-724df660821mr18578671b3a.20.1732489212456;
        Sun, 24 Nov 2024 15:00:12 -0800 (PST)
Received: from tp.hsd1.or.comcast.net ([2601:1c2:c104:170:9817:7858:9b63:8745])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de57a53asm5090028b3a.198.2024.11.24.15.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 15:00:12 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net
Cc: Leo Stone <leocstone@gmail.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] Documentation: tls_offload: fix typos and grammar
Date: Sun, 24 Nov 2024 15:00:02 -0800
Message-Id: <20241124230002.56058-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos and grammar where it improves readability. 

Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 Documentation/networking/tls-offload.rst | 29 ++++++++++++------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/tls-offload.rst b/Documentation/networking/tls-offload.rst
index 5f0dea3d571e..7354d48cdf92 100644
--- a/Documentation/networking/tls-offload.rst
+++ b/Documentation/networking/tls-offload.rst
@@ -51,7 +51,7 @@ and send them to the device for encryption and transmission.
 RX
 --
 
-On the receive side if the device handled decryption and authentication
+On the receive side, if the device handled decryption and authentication
 successfully, the driver will set the decrypted bit in the associated
 :c:type:`struct sk_buff <sk_buff>`. The packets reach the TCP stack and
 are handled normally. ``ktls`` is informed when data is queued to the socket
@@ -120,8 +120,9 @@ before installing the connection state in the kernel.
 RX
 --
 
-In RX direction local networking stack has little control over the segmentation,
-so the initial records' TCP sequence number may be anywhere inside the segment.
+In the RX direction, the local networking stack has little control over
+segmentation, so the initial records' TCP sequence number may be anywhere
+inside the segment.
 
 Normal operation
 ================
@@ -138,8 +139,8 @@ There are no guarantees on record length or record segmentation. In particular
 segments may start at any point of a record and contain any number of records.
 Assuming segments are received in order, the device should be able to perform
 crypto operations and authentication regardless of segmentation. For this
-to be possible device has to keep small amount of segment-to-segment state.
-This includes at least:
+to be possible, the device has to keep a small amount of segment-to-segment
+state. This includes at least:
 
  * partial headers (if a segment carried only a part of the TLS header)
  * partial data block
@@ -175,12 +176,12 @@ and packet transformation functions) the device validates the Layer 4
 checksum and performs a 5-tuple lookup to find any TLS connection the packet
 may belong to (technically a 4-tuple
 lookup is sufficient - IP addresses and TCP port numbers, as the protocol
-is always TCP). If connection is matched device confirms if the TCP sequence
-number is the expected one and proceeds to TLS handling (record delineation,
-decryption, authentication for each record in the packet). The device leaves
-the record framing unmodified, the stack takes care of record decapsulation.
-Device indicates successful handling of TLS offload in the per-packet context
-(descriptor) passed to the host.
+is always TCP). If the packet is matched to a connection, the device confirms
+if the TCP sequence number is the expected one and proceeds to TLS handling
+(record delineation, decryption, authentication for each record in the packet).
+The device leaves the record framing unmodified, the stack takes care of record
+decapsulation. Device indicates successful handling of TLS offload in the
+per-packet context (descriptor) passed to the host.
 
 Upon reception of a TLS offloaded packet, the driver sets
 the :c:member:`decrypted` mark in :c:type:`struct sk_buff <sk_buff>`
@@ -439,7 +440,7 @@ by the driver:
  * ``rx_tls_resync_req_end`` - number of times the TLS async resync request
     properly ended with providing the HW tracked tcp-seq.
  * ``rx_tls_resync_req_skip`` - number of times the TLS async resync request
-    procedure was started by not properly ended.
+    procedure was started but not properly ended.
  * ``rx_tls_resync_res_ok`` - number of times the TLS resync response call to
     the driver was successfully handled.
  * ``rx_tls_resync_res_skip`` - number of times the TLS resync response call to
@@ -507,8 +508,8 @@ in packets as seen on the wire.
 Transport layer transparency
 ----------------------------
 
-The device should not modify any packet headers for the purpose
-of the simplifying TLS offload.
+For the purpose of simplifying TLS offload, the device should not modify any
+packet headers.
 
 The device should not depend on any packet headers beyond what is strictly
 necessary for TLS offload.
-- 
2.39.5


