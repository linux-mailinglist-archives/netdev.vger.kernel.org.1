Return-Path: <netdev+bounces-302423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aDohGQ6ZQWrjsQkAu9opvQ
	(envelope-from <netdev+bounces-302423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:58:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C76D50DB
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:58:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b="KDBA2/oA";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302423-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302423-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9507300901F
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 21:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875B63B95F2;
	Sun, 28 Jun 2026 21:58:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9739023A
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 21:58:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683916; cv=none; b=EYKfGagf204TTOfEnnpe9dC88snGroZeGuQHSO+Y+FGnOTPmm7Y+hSqmbhdreYYuoB+GYjF5lpIPVfDDMu3Zthj9UtgEMt8ALywCE3zTm0A7smOK3Hp8cV9VKO0UmXHHa+h3AjWHxxnwDJDuXtEQ0hdaPSh13hoIiBFmNd6ELjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683916; c=relaxed/simple;
	bh=vrWnXwOBEFqvQMci/AIv280VxVOyotUsQO0ClKkqswE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkD5G6sfxLPnKK1VREwDJBIkEsmKYMx+NBXKf1X6hTppECwMGhjwOJm5/Vuz9DvQK9X7/UFWNQm8fC8goa/GKo8ShhgcMss0shY3ZYt2ApjcSwgfQVOfTqfywhGLP41EyqxM+08vdm+CcFa9EQaAl5conh6+U7RX8QZ4NLnUJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=KDBA2/oA; arc=none smtp.client-ip=74.125.82.41
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1397e093f90so4522108c88.1
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782683913; x=1783288713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lP1y4sy5xHQwRNPg5YoRcLSpRVU19u5JDLJN4zIGwjg=;
        b=KDBA2/oA7FhNjQ8c5GAKIOX1keC6d4YTloDBTOik5iUFDGyjyeK7nQVfr+JnEAndO4
         63M1+WFDskj5snQ82fLvmEWgHsbZFeTzkGBRCX4rpWsDsu2K/GmntDi92QNLje1cRdAL
         EJFryZYwWOWs9syyPkC9lg2Fnf+7q3p65tAbxLknD06lV23bCU25eVlHhZXq2GkX51Xz
         NeeOMPQiLAPP8HC0M3SSw86ohtFaEWeMBZG/IBm5QZ+dNvM3wbfBdLd7mFeBNVVmrO7m
         367IPeOYVJM/+007dRpR47R+BYBefEZ2dYT3D7iNNW2ninQM//zdtOnT8FuG9CDEaPxf
         Nyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782683913; x=1783288713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP1y4sy5xHQwRNPg5YoRcLSpRVU19u5JDLJN4zIGwjg=;
        b=HbZHeVuw/UonoV/dZ2OPLkPYmzZLNDvWvwfCAR+EsbD4XVo7jeyOpvpPFY88GCzzxS
         sfeUOSHyQYiIosYYL1k4PeDnEGtliuctZlA3qOatt7cuK81PysRgnvnACZYdsnN80jLi
         FkaSrtzE9MxA3o9mdaEUpA+Ww6sWfOvMSrYRS5PKW/HMI8JRionbIMWsWrs/Hjiou4E4
         u7km0gs8hRrKGzNHXSHtG20XuLUSTt0dimi6+B+uEOHlipGLmiheKcxBNJD0ejQwaLrX
         RW7fQUy6j3k4jo+0zE50IA6KT3dZDgDfwCN2da1lEOY5O8/EPOWlgi8w+gLnYkRMnzbO
         SI5A==
X-Gm-Message-State: AOJu0YzVqpBLHWfWo1/vd3/A9AS0aBA5G9OiGRXZRQxj0Sef9EpqOyXJ
	kqZij8MtYprlvelB4uneigWUneiOTenaaReWNyg6kX4IRaFy9KTgg3qhsIbD6Kj3PoDsnZHtHOl
	RfXGQ
X-Gm-Gg: AfdE7ckesAnX2mQdL6haYfchjDqphY7EsN3gaWqGl9IAHO0T5T6JEpMyt++ubFz53gh
	YITjMna7uM/o2/nS11xif+90WitiRsMGfbhdm5sc17/OiELvaQ0DPHrU1nB4ovDpT1P1bAE/RU+
	tN5i7TkR0gBGKRVusS5oCPZJFJVkJIftbDZsxLsNtWBepeJ/FGtmmf7Kgd1WXfAqqQZyafxl5iC
	K+i5a2xY00vXpvRJa1+BkWzui8VkbGbj3MxUtz5RW8CrLdYgjw55PeOlmmMAsgKiFH8rDhYfzFK
	AbU+JIsZmiEFFy+Amv2LwVAmuBJV+qt2qvSEo2idAjy03LJk8XNIbx5DXQbjcW9sqhp2TC9HifP
	5MH1hKGr0ZykaDv51bRGM4OYDFxdCSfwrsaICCt6OfUrZHV7fQannVC7h6pzS6AKA+KUciKxhD/
	gOE6BVg7uIcyzkDMyJJxI3YVxozQUMH2VeWx5sNwhPKWU0P7rXxEY=
X-Received: by 2002:a05:7022:6298:b0:139:f3cd:22a2 with SMTP id a92af1059eb24-139f3cd251cmr4550650c88.44.1782683912885;
        Sun, 28 Jun 2026 14:58:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm40753503c88.13.2026.06.28.14.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:58:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] man: fix troff warnings and whitespace
Date: Sun, 28 Jun 2026 14:58:02 -0700
Message-ID: <20260628215830.379088-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:stephen@networkplumber.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302423-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D37C76D50DB

Fix troff warnings about line breaks around URL's.
Remove unnecessary whitespace at end of line.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/ip-link.8.in  | 5 ++++-
 man/man8/tc-flower.8   | 2 --
 man/man8/tc-fq_codel.8 | 2 +-
 man/man8/tc-netem.8    | 4 ++++
 man/man8/tc-red.8      | 6 +++++-
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index fc7f0248..38f5a13a 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -3071,7 +3071,10 @@ are supported:
 locally terminated traffic for the given DSA switch user port. For a
 description of which network interfaces are suitable for serving as conduit
 interfaces of this user port, please see
-https://docs.kernel.org/networking/dsa/configuration.html#affinity-of-user-ports-to-cpu-ports
+.nf
+.UR https://docs.kernel.org/networking/dsa/configuration.html#affinity-of-user-ports-to-cpu-ports
+.UE
+.fi
 as well as what is supported by the driver in use.
 
 .sp
diff --git a/man/man8/tc-flower.8 b/man/man8/tc-flower.8
index adde2168..3f8ba465 100644
--- a/man/man8/tc-flower.8
+++ b/man/man8/tc-flower.8
@@ -418,8 +418,6 @@ bits is assumed.
 .BI enc_tos " NUMBER"
 .TQ
 .BI enc_ttl " NUMBER"
-.TQ
-.BR
 .TP
 .BI ct_state " CT_STATE"
 .TQ
diff --git a/man/man8/tc-fq_codel.8 b/man/man8/tc-fq_codel.8
index 78590636..6ed523c7 100644
--- a/man/man8/tc-fq_codel.8
+++ b/man/man8/tc-fq_codel.8
@@ -66,7 +66,7 @@ the local minimum queue delay that packets experience. Default value is 5ms.
 has the same semantics as
 .B codel
 and is used to ensure that the measured minimum delay does not become too stale.
-The minimum delay must be experienced in the last epoch of length 
+The minimum delay must be experienced in the last epoch of length
 .BR interval .
 It should be set on the order of the worst-case RTT through the bottleneck to
 give endpoints sufficient time to react. Default value is 100ms.
diff --git a/man/man8/tc-netem.8 b/man/man8/tc-netem.8
index a4cc0d61..8d608c77 100644
--- a/man/man8/tc-netem.8
+++ b/man/man8/tc-netem.8
@@ -383,15 +383,19 @@ A filter classifies all packets going to 65.172.181.4 as being priority 3.
 .IP " 1. " 4
 Hemminger S. , "Network Emulation with NetEm", Open Source Development Lab,
 April 2005
+.nf
 .UR http://devresources.linux-foundation.org/shemminger/netem/LCA2005_paper.pdf
 .UE
+.fi
 
 .IP " 2. " 4
 Salsano S., Ludovici F., Ordine A., "Definition of a general and intuitive loss
 model for packet networks and its implementation in the Netem module in the
 Linux kernel", available at
+.nf
 .UR http://netgroup.uniroma2.it/NetemCLG
 .UE
+.fi
 
 .SH SEE ALSO
 .BR tc (8)
diff --git a/man/man8/tc-red.8 b/man/man8/tc-red.8
index 662e4d8b..dd6bc6cf 100644
--- a/man/man8/tc-red.8
+++ b/man/man8/tc-red.8
@@ -132,7 +132,11 @@ With this parameter, traffic that should be marked, but is not ECN-capable, is
 enqueued. Without the parameter it is early-dropped.
 .TP
 adaptive
-(Added in linux-3.3) Sets RED in adaptive mode as described in http://icir.org/floyd/papers/adaptiveRed.pdf
+(Added in linux-3.3) Sets RED in adaptive mode as described in
+.na
+.UR http://icir.org/floyd/papers/adaptiveRed.pdf
+.UE
+.ad
 .nf
 Goal of Adaptive RED is to make 'probability' dynamic value between 1% and 50% to reach the target average queue :
 .B (max - min) / 2
-- 
2.53.0


