Return-Path: <netdev+bounces-72695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 644598592F0
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 22:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B71E1F21575
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 21:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25287F7CF;
	Sat, 17 Feb 2024 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVWCk9kM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D1C15A
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204878; cv=none; b=bj5qEQtHUmD9iFNU5SwemrJCVBiYtEtqpuLu0OoeF8ACXcL54vBhskyl/DnEY1cEI3QUPvB+wJtxnqojCZvHWVDpgVFOP6xq4B+nM2Yx/Mf2Ta7l0oB7d4z7yT6gNWvX6sTOfLCieSSyOUNMPg4Et2rjxemy0kiw46uY3QWLeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204878; c=relaxed/simple;
	bh=iYkWBJbmMoKdw7VgcIRKPcBjlYsfcy2RAzGAJH3+tmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rGSI7z3WRj9eTJEfhDDlkLxl9RwqvFE8bdw4N+gqOZwLKKdv2tnihaBZzPLTUfJopqvxkdXXqjLlJxwROxZ3xDX5tEnk5GU8H1NXd1UF4DUIDPUv+H2dTapJa8RIeYz+sN5Jcs/gF4FxYXNE04L0vbeKdoXJ0vDBDrigAo0wcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVWCk9kM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d375993f4so226642f8f.1
        for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 13:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708204875; x=1708809675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xc9TWqlvGWC1FFttDhc7iXWaNdMd2dygwi/wjcDqkW4=;
        b=FVWCk9kMWcQP9EvB9W4mXpizlRuptxtJvjg0t4hDfmxEG5XSc/supxUzBjD1Oyw8eB
         O8zsOmjTN6icspR9Z/OtqrIRXh30mSrMOfZs7hNs2FHKHpIgrphs0WL3BwUFKzZbGxwC
         LOIHsBCRNve4LK75u3Z6lHkGovOe/gk1RgRSJlQ6mFjwxRj5R9slQIv/gK3LrMHe6YkB
         nBEUKxxP062sGXYL7n4iwHBMQzNdJtJ33Jyf+c1I0yCAlNbYRGKpMwKM9tl2ZNRSeW1H
         H5g0oH8V735Yl8N3UFYOW9vg8stEh2zOGcfpV2JmesmVrLfH0jH6lmvEHkgiDuQHRMH+
         7PyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708204875; x=1708809675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xc9TWqlvGWC1FFttDhc7iXWaNdMd2dygwi/wjcDqkW4=;
        b=Pukvl3giVpTh8hX2PQ6E/jw15xhDkXQ4Vz/IXNe6IXcWxYa23V36BECrSs8K39eLUv
         dXVgNGNN6trOlDVgpCeRcBd+NKed/swUEnUJKDXlkq1CCroEuVNiMp3bW8+AhP7ZordN
         gT7TxK6D91Rfeic0ccsBMhZ+6OJva5lUjCK4TFrjGWlX+FUaj3KbL4vo7M/DR6Y2DQGh
         dMwiEQ1HKzEroG3ByEruJ3Rgh29q6ENh/fQt3D1Nok2wM/YSbOsQa4CcbxxQpS9wRb1J
         /QJMHWHXAcXHBHze0/BNE2/HA74c1IIflx73m5dDpp6AmECGfidEzbArNjjO4x+fODNo
         Cseg==
X-Gm-Message-State: AOJu0YzaCaipcN8QGSZRBJTxXOkwmCAybJbF+v2JgZUS5PuroZ+pjckI
	Ll7Bpwzs1lr0ZlZoCtR/WsDiJel4oJ/Tc3dadtP5TaFAOr6IfOQlKi9q+IhAvIk=
X-Google-Smtp-Source: AGHT+IFXqU5TKWRzyJG8qxakRvq7f79tdMyfUuyoKZaIeGQuzB/CvKsOchQZYvjRYDBg8UvR2mpguA==
X-Received: by 2002:a05:6000:d84:b0:33d:2a1e:99fb with SMTP id dv4-20020a0560000d8400b0033d2a1e99fbmr2118234wrb.57.1708204874393;
        Sat, 17 Feb 2024 13:21:14 -0800 (PST)
Received: from lenovo-lap.localdomain (89-138-228-209.bb.netvision.net.il. [89.138.228.209])
        by smtp.googlemail.com with ESMTPSA id g16-20020adfa490000000b00337d6f0013esm5810779wrb.107.2024.02.17.13.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:21:14 -0800 (PST)
From: Yedaya Katsman <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH] ip: Add missing command exaplantions in man page
Date: Sat, 17 Feb 2024 23:21:02 +0200
Message-Id: <20240217212102.3822-1-yedaya.ka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few commands missing from the ip command syntax list, add
them. They are also missing from the see also section, add them there as
well.
Note there isn't a ip-ila man page, so I didn't link to it.

Also fix a few punctuation mistakes.

Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 man/man8/ip.8 | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip.8 b/man/man8/ip.8
index 72227d44fd30..43a5ab2334ee 100644
--- a/man/man8/ip.8
+++ b/man/man8/ip.8
@@ -254,6 +254,14 @@ Request the kernel to send the applied configuration back.
 .B addrlabel
 - label configuration for protocol address selection.
 
+.TP
+.B fou
+- Foo-over-UDP receive port configuration.
+
+.TP
+.B ila
+- manage identifier locator addresses (ILA).
+
 .TP
 .B ioam
 - manage IOAM namespaces and IOAM schemas.
@@ -266,6 +274,10 @@ Request the kernel to send the applied configuration back.
 .B link
 - network device.
 
+.TP
+.B macsec
+- MACsec device configuration.
+
 .TP
 .B maddress
 - multicast address.
@@ -290,10 +302,18 @@ Request the kernel to send the applied configuration back.
 .B neighbour
 - manage ARP or NDISC cache entries.
 
+.TP
+.B netconf
+- network configuration monitoring.
+
 .TP
 .B netns
 - manage network namespaces.
 
+.TP
+.B nexthop
+- manage nexthop objects.
+
 .TP
 .B ntable
 - manage the neighbor cache's operation.
@@ -306,13 +326,17 @@ Request the kernel to send the applied configuration back.
 .B rule
 - rule in routing policy database.
 
+.TP
+.B sr
+- manage IPv6 segment routing.
+
 .TP
 .B stats
 - manage and show interface statistics.
 
 .TP
 .B tcp_metrics/tcpmetrics
-- manage TCP Metrics
+- manage TCP Metrics.
 
 .TP
 .B token
@@ -415,19 +439,24 @@ was written by Alexey N. Kuznetsov and added in Linux 2.2.
 .SH SEE ALSO
 .BR ip-address (8),
 .BR ip-addrlabel (8),
+.BR ip-fou (8),
 .BR ip-ioam (8),
 .BR ip-l2tp (8),
 .BR ip-link (8),
+.BR ip-macsec (8),
 .BR ip-maddress (8),
 .BR ip-monitor (8),
 .BR ip-mptcp (8),
 .BR ip-mroute (8),
 .BR ip-neighbour (8),
+.BR ip-netconf (8),
 .BR ip-netns (8),
+.BR ip-nexthop (8),
 .BR ip-ntable (8),
 .BR ip-route (8),
 .BR ip-rule (8),
-.BR ip-stats (8)
+.BR ip-sr (8),
+.BR ip-stats (8),
 .BR ip-tcp_metrics (8),
 .BR ip-token (8),
 .BR ip-tunnel (8),
-- 
2.34.1


