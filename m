Return-Path: <netdev+bounces-260242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKdwAQjWnGkJLAQAu9opvQ
	(envelope-from <netdev+bounces-260242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:34:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 773DF17E69E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A47D4305C312
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A9737B416;
	Mon, 23 Feb 2026 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElvaeJHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823A36C0B3
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886084; cv=none; b=VdH/rssc0h4vDDbqtCAp50tw2/4d5jccGvwcCuyTaFRlPr5CpyziV0fNZ61RW0pekKHXYXE1vdF3CZfqmwflWJxf2JD4Fy5kTn6lAIDfGBuuAKqX2qPJ2b9Hbod6KepVbCKIeezeRTfCUpG+GgQd/sf6fN/3cnLdLHdAvHyghss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886084; c=relaxed/simple;
	bh=7gD75EHPtyaviLJz6VZWAmzOkHMbvhTjQBUNej6fvfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=okqgEL1hoVDMXI2ayxGeMD+WhaHiGpTThk0jDKjL9m5SVsTmcBiUqN35jY4c/m3u0O7d24bOcof0tHQzDECy/Bn2QtDDZJLUF3R0IYxGygzer6f2ymNZ9+BTVHynPGEhXsn2DH3JF+YOkuCx0UKv+CCvLR/vWytjc6zGkPCyFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElvaeJHZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso42162355e9.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886081; x=1772490881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I+30rpk5R2NXxS+cps7D/ds0pZw0Nh20viRiXAAQ2fo=;
        b=ElvaeJHZvh3aE0loQQBJKA05BuNOfswrdybFOiP5bCt4ZLNaCDvhmgap8q/7QUaHLo
         RsskqoflpjWEUpiCXPOiztobGA+IJaaPC66LN3RMgBDykLHB1F6gt8ri6KouwkEQc1ih
         HX+oOS7O5OrK7BGy705GebeDvk9hf/tFG2VA+L5gn1B21MeTWwsO3SonhfSF0q1u2ZvR
         FJNign0UNXrV9APW1lr54oixjEGB1Rop+aWvGvdxIPFbm1VWephpwxNU0jMrPRk02UXg
         FhTB0G8L2tK04TSh6RCD5ZM3iT2KHjqAmvum2wVHBP2NeLzOUfmhYPJP5wC4g/1XYyaD
         xLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886081; x=1772490881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+30rpk5R2NXxS+cps7D/ds0pZw0Nh20viRiXAAQ2fo=;
        b=sz70eEyd/mpUDb/phWi/065n+b71I2zjCjQ63ThNxXcgEuAzPO09tYjZVqXIaxp7Qo
         PlUqlhRtcZt7PTa7VQEHOmCxv+QjAkupvTn8qX26VL/L3AdueoiFXZglvZbbgPhbLykP
         KKy86bWm4NCX6HOgVSi5zSiLlqLSJUAjMjd453hZ8S+C+YsGgFG92fnjTHu8Td0P8zjk
         xGr2YtUwGU1x+XxtczjQO+lS/7VLKrt7XiUa+TmEuhRBHmG2RLNbfFR/M2/6dAHNUhdA
         ofjkEyYe6Hu2m7GyFRlCSHOp5TMZQIdnlpvGQlvXoV4bgizrOm//DTOwoHnkbWm9PeqP
         ux2Q==
X-Gm-Message-State: AOJu0YzTlR98yDbPrNd32Mk8ClFpdsjpmvHwHxmAq2qjxBntgczdZaoX
	k59gDYMn6dfL/qy+t9WG1Zd5veExbkguUXFoqv7JgkmT+sDLf88YF8FVtMBmWw==
X-Gm-Gg: AZuq6aKk5/H6jxnS3BsrdlLmPnLgvD1tSONi71lfSUnjlNimjMyeuUO3tFGaQ/B8VH8
	wHxagx9TShthl39B8j/n5rjH6/BeLZzb3AL4EnujcsK1ihdQkLV/siBjv2WE+55d4nl9s+fQncY
	p26hH4rX7WDU4+CM1jHuHWfoAglvFiWJ2ihaH0w7jghmxDu0Ynf8l+TEh6jE43J4TbKJ6yc7G7B
	WkEGclrip0ZyUwAnbOS3FsK6UYqKf/9y3MKTHPffEMzl9OE977lIw+GRpc0Cs6t/ye5HC+xQNvK
	J7DKfOv0Rr0TtAjdznr0xKlKLgXK0dHTWDgfwQ9vAV0TXwA3NXiLwnihti6nTR+wlqjVsRiMEZF
	mZ/ilBdPx6AOUBaktTWyGZcNSRytdNwkljt66lzq5oIyinK/OJ3HElUJOBLSd0/LuDwpuLwaJnG
	sW0ecz6Tmh+/o=
X-Received: by 2002:a05:600c:4fd3:b0:47e:e20e:bb9c with SMTP id 5b1f17b1804b1-483a95fb0a0mr144821435e9.8.1771886081252;
        Mon, 23 Feb 2026 14:34:41 -0800 (PST)
Received: from nz.home ([5.80.177.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cab38dsm195976145e9.9.2026.02.23.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:34:40 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
	id 02C23418A0511E; Mon, 23 Feb 2026 22:34:39 +0000 (GMT)
From: Sergei Trofimovich <slyich@gmail.com>
To: netdev@vger.kernel.org
Cc: Sergei Trofimovich <slyich@gmail.com>
Subject: [PATCH iproute2] include/json_print.h: add includes for `__u32` and `timeval` declarations
Date: Mon, 23 Feb 2026 22:34:35 +0000
Message-ID: <20260223223435.289652-1-slyich@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260242-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slyich@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 773DF17E69E
X-Rspamd-Action: no action

Without the change the build fails on `musl` as:

```
../include/json_print.h:100:44: error: unknown type name ‘__u32’
  100 | unsigned int print_range(const char *name, __u32 start, __u32 end);
      |                                            ^~~~~
...
../include/json_print.h:82:30: warning: ‘struct timeval’ declared inside parameter list will not be visible outside of this definition or declaration
   82 | _PRINT_FUNC(tv, const struct timeval *)
      |                              ^~~~~~~
../include/json_print.h:57:45: note: in definition of macro ‘_PRINT_FUNC’
   57 |                                             type value)                 \
      |                                             ^~~~
../include/json_print.h: In function ‘print_tv’:
../include/json_print.h:60:48: error: passing argument 5 of ‘print_color_tv’ from incompatible pointer type [-Wincompatible-pointer-types]
   60 |                                                value);                  \
      |                                                ^~~~~
      |                                                |
      |                                                const struct timeval *
```
---
 include/json_print.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/json_print.h b/include/json_print.h
index 59edd5b2..c0d6315f 100644
--- a/include/json_print.h
+++ b/include/json_print.h
@@ -8,6 +8,10 @@
 #ifndef _JSON_PRINT_H_
 #define _JSON_PRINT_H_
 
+#include <sys/time.h> /* struct timeval typedef */
+
+#include <asm/types.h> /* __u32 typedef */
+
 #include "json_writer.h"
 #include "color.h"
 
-- 
2.52.0


