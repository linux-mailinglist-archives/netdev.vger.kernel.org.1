Return-Path: <netdev+bounces-63128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCA282B4DC
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3512B2303A
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455C454BE0;
	Thu, 11 Jan 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="BsEoAtMK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E553E23
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9344f30caso3886313b3a.1
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 10:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704998704; x=1705603504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXiwtsBj02EdK8fJqvGHYuYq6nsBbsRGVOYyO29NQoc=;
        b=BsEoAtMKWxOL1ZAYv8zk34U9No6axjWxE9h4+rPXueTig2obRecU/Ow27KQ22uvhGG
         6QgEtWzwSKCg+rT4CrPjHZllmCoAY6x+baX+4l5mE9M+NaZgKXxexWzVa2ZztYs6b1zc
         Kr6wPQDYUb+BURSd+1HdXp7JL5SEG3G+XQVZMcFRAS7B+0cT32FOrCo4wdjiqMNWJs5n
         XUXPTrlGW+o1b7Ew5Nyu837GVO6HQzLazjR0RtPH2NOMvzSkwSGTyEnWxXtvNuB50W0O
         bI1YZGFQtY8yj5chNoSSeqxzZ1Z/XnFsFOOji+l1tfq3VOwVXL5wWvNwy06PnE1kO36c
         UYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998704; x=1705603504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXiwtsBj02EdK8fJqvGHYuYq6nsBbsRGVOYyO29NQoc=;
        b=CdwjFis58w70hNrBOSA2AgO94O6mbpVb6hTrr67N9yRcBEpEwsyIWVMv2Qnz7Z10Y2
         hY8KDbsr9BE1VjsQdoCJ1ENImNyf6oFLzYdXFD8yHaswNc2YUhrQSiHI/qVHFmnoi4BQ
         bxrl98KovIqVTdcBso1iX6OcMi55V32vgyrVgBF1Ou4imXZ6A/fqNIzEoznzR52+D7i6
         foSd3UQhGE/J7KW1UuPh23ITjJkqCIcq2XNJYhjHtCLZAYOrpiHWqyfSF36kxMCls47Q
         T72q9SvOx8sWYFjZFo9EFOPvTNng/BclOc//KcDKy9xSHN2v9W5aR5JB4QxsoKz1zXIn
         75LA==
X-Gm-Message-State: AOJu0YwaXdOevisQ3va1tb8hqqSiOhlhBjYHFv0rrXyIO0gnPQDNo/1N
	wRLVDc2emLQ5lKkMq0jnViaW2kZCKhgMVlR5uyPBzULbUJJgNA==
X-Google-Smtp-Source: AGHT+IHVbAQ4PJ7gAD0FSluYsddCIj+BPGRN63XHopXC6g5MV+KJ+ohX+k5g6xAHBL3l78pEh/99rQ==
X-Received: by 2002:a05:6a00:92a0:b0:6d9:c201:f887 with SMTP id jw32-20020a056a0092a000b006d9c201f887mr395292pfb.1.1704998704530;
        Thu, 11 Jan 2024 10:45:04 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78083000000b006d9b4303f9csm1513460pff.71.2024.01.11.10.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 10:45:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 2/4] man/tc-gact: move generic action documentation to man page
Date: Thu, 11 Jan 2024 10:44:09 -0800
Message-ID: <20240111184451.48227-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111184451.48227-1-stephen@networkplumber.org>
References: <20240111184451.48227-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert from free form doc to man page.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/actions/gact-usage | 78 --------------------------------------
 man/man8/tc-gact.8     | 85 ++++++++++++++++++++++++++++++++++++++++++
 man/man8/tc.8          |  1 +
 3 files changed, 86 insertions(+), 78 deletions(-)
 delete mode 100644 doc/actions/gact-usage
 create mode 100644 man/man8/tc-gact.8

diff --git a/doc/actions/gact-usage b/doc/actions/gact-usage
deleted file mode 100644
index 7cf48abbd90a..000000000000
--- a/doc/actions/gact-usage
+++ /dev/null
@@ -1,78 +0,0 @@
-
-gact <ACTION> [RAND] [INDEX]
-
-Where:
-	ACTION := reclassify | drop | continue | pass | ok
-	RAND := random <RANDTYPE> <ACTION> <VAL>
-	RANDTYPE := netrand | determ
-        VAL : = value not exceeding 10000
-        INDEX := index value used
-
-ACTION semantics
-- pass and ok are equivalent to accept
-- continue allows one to restart classification lookup
-- drop drops packets
-- reclassify implies continue classification where we left off
-
-randomization
---------------
-
-At the moment there are only two algorithms. One is deterministic
-and the other uses internal kernel netrand.
-
-Examples:
-
-Rules can be installed on both ingress and egress - this shows ingress
-only
-
-tc qdisc add dev eth0 ingress
-
-# example 1
-tc filter add dev eth0 parent ffff: protocol ip prio 6 u32 match ip src \
-10.0.0.9/32 flowid 1:16 action drop
-
-ping -c 20 10.0.0.9
-
---
-filter u32
-filter u32 fh 800: ht divisor 1
-filter u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:16  (rule hit 32 success 20)
-  match 0a000009/ffffffff at 12 (success 20 )
-        action order 1: gact action drop
-         random type none pass val 0
-         index 1 ref 1 bind 1 installed 59 sec used 35 sec
-         Sent 1680 bytes 20 pkts (dropped 20, overlimits 0 )
-
-----
-
-# example 2
-#allow 1 out 10 randomly using the netrand generator
-tc filter add dev eth0 parent ffff: protocol ip prio 6 u32 match ip src \
-10.0.0.9/32 flowid 1:16 action drop random netrand ok 10
-
-ping -c 20 10.0.0.9
-
-----
-filter protocol ip pref 6 u32 filter protocol ip pref 6 u32 fh 800: ht divisor 1filter protocol ip pref 6 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:16  (rule hit 20 success 20)
-  match 0a000009/ffffffff at 12 (success 20 )
-        action order 1: gact action drop
-         random type netrand pass val 10
-         index 5 ref 1 bind 1 installed 49 sec used 25 sec
-         Sent 1680 bytes 20 pkts (dropped 16, overlimits 0 )
-
---------
-#alternative: deterministically accept every second packet
-tc filter add dev eth0 parent ffff: protocol ip prio 6 u32 match ip src \
-10.0.0.9/32 flowid 1:16 action drop random determ ok 2
-
-ping -c 20 10.0.0.9
-
-tc -s filter show parent ffff: dev eth0
------
-filter protocol ip pref 6 u32 filter protocol ip pref 6 u32 fh 800: ht divisor 1filter protocol ip pref 6 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:16  (rule hit 20 success 20)
-  match 0a000009/ffffffff at 12 (success 20 )
-        action order 1: gact action drop
-         random type determ pass val 2
-         index 4 ref 1 bind 1 installed 118 sec used 82 sec
-         Sent 1680 bytes 20 pkts (dropped 10, overlimits 0 )
------
diff --git a/man/man8/tc-gact.8 b/man/man8/tc-gact.8
new file mode 100644
index 000000000000..81aa30eba5a0
--- /dev/null
+++ b/man/man8/tc-gact.8
@@ -0,0 +1,85 @@
+.TH "Generic actions in tc" 8 "11 Jan 2023" "iproute2" "Linux"
+
+.SH NAME
+gact - generic action
+.SH SYNOPSIS
+.in +8
+.ti -8
+.BR tc " ... " "action gact"
+.IR CONTROL " [ " RAND " ] [ " INDEX " ]"
+.ti -8
+.IR CONTROL " := { "
+.BR reclassify " | " drop " | " continue " | " pass " | " pipe " | "
+.br
+.BI "goto chain " "CHAIN_INDEX"
+|
+.br
+.BI "jump " "JUMP_COUNT"
+}
+
+.ti -8
+.IR RAND " := "
+.BI random " RANDTYPE CONTROL VAL"
+.ti -8
+.IR RANDTYPE " := { "
+.BR netrand " | " determ " }"
+.ti -8
+.IR VAL " := number not exceeding 10000"
+.ti -8
+.IR JUMP_COUNT " := absolute jump from start of action list"
+.ti -8
+.IR INDEX " := index value used"
+
+.SH DESCRIPTION
+The
+.B gact
+action allows reclassify, dropping, passing, or accepting packets.
+At the moment there are only two algorithms. One is deterministic
+and the other uses internal kernel netrand.
+
+.SH OPTIONS
+.TP
+.BI random " RANDTYPE CONTROL VAL"
+The probability of taking the action expressed in terms of 1 out of
+.I VAL
+packets.
+
+.TP
+.I CONTROL
+Indicate how
+.B tc
+should proceed if the packet matches.
+For a description of the possible
+.I CONTROL
+values, see
+.BR tc-actions (8).
+
+.SH EXAMPLES
+Apply a rule on ingress to drop packets from a given source address.
+.RS
+.EX
+# tc filter add dev eth0 parent ffff: protocol ip prio 6 u32 match ip src \
+10.0.0.9/32 flowid 1:16 action drop
+.EE
+.RE
+
+Allow 1 out 10 packets from source randomly using the netrand generator
+.RS
+.EX
+# tc filter add dev eth0 parent ffff: protocol ip prio 6 u32 match ip src \
+10.0.0.9/32 flowid 1:16 action drop random netrand ok 10
+.EE
+.RE
+
+Deterministically accept every second packet
+.RS
+.EX
+# tc filter add dev eth0 parent ffff: protocol ip prio 6 u32 match ip src \
+10.0.0.9/32 flowid 1:16 action drop random determ ok 2
+.EE
+.RE
+
+.SH SEE ALSO
+.BR tc (8),
+.BR tc-actions (8),
+.BR tc-u32 (8)
diff --git a/man/man8/tc.8 b/man/man8/tc.8
index e5bef911f21b..3175454b9d60 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -871,6 +871,7 @@ was written by Alexey N. Kuznetsov and added in Linux 2.2.
 .BR tc-fq_codel (8),
 .BR tc-fq_pie (8),
 .BR tc-fw (8),
+.BR tc-gact (8),
 .BR tc-hfsc (7),
 .BR tc-hfsc (8),
 .BR tc-htb (8),
-- 
2.43.0


