Return-Path: <netdev+bounces-283619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH2AJmpq92mhhQIAu9opvQ
	(envelope-from <netdev+bounces-283619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:31:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8FC4B6430
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F33C301A926
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF241362157;
	Sun,  3 May 2026 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpPlA9HN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542636164B
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777822251; cv=none; b=C6PJ1U76FGX19lRTfDvQf3y15anQMFllJub/tLnRQFG+KQ+gh270ZvSQHgkBJdusYJcLfLZf7c8LBZOwWksDao/za+/kEf1l4FVPXnljnfwRL8ddc+f7krX6Mp0ACIiyUHEYylQriopxv/l4hd+aA+I90guPCc7WiyGnA3JPm2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777822251; c=relaxed/simple;
	bh=BSTzEBaaN+NWXJVVixdnU57ue3HFodgdwLMDtirjrR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sspp23S83X7JavPpuJkrtvK0uzmkC2mP39MPl4jBUVUaZGViE3eXHZFPEQsEpSSwoicM9Q7gfLsWO1VHQOleZnJYojfcWlaKfmd6vwvZzFX0dyoPPym3nggQrIarfl5MqCVRO1QyAjpXf22EqqQlflW5LNe+04OfqaYwEXuf+CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpPlA9HN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-837b39eb078so20304b3a.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777822250; x=1778427050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTRLMrl3D3fTn8kce4owvI8q2Q0Tu09IKToBmxbz1vM=;
        b=jpPlA9HNTnIKVBWBvmJv+RdUWrEjDnrJzXnrmP35yqV6ZchQGJureBQCooEm4sFrXA
         tbT9SI0CfJvVxSTaEzsTjaD3nU1cz6fkjF2BIGSPckM2XigNhnoPZnBxCqKzdXTDDLK3
         48T025JkxI8KwbHDLmdODsT907gF67kR2obD/Rk3k5YIZ9P4NsI+k52ER1oNTYwYMr6Q
         qTRbCTvm6RoqP6c3xb6K7dwpJY/iuAi+N2Xm6F4Yv4II/59gWBkRkfnCc5v3WN8LPreD
         afU+Mb064flei0u52g+dH0sTQNjZlYxHV91VuSj6ayPLmJU0wUfEj5sNcEQtSipP4sHp
         5zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777822250; x=1778427050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTRLMrl3D3fTn8kce4owvI8q2Q0Tu09IKToBmxbz1vM=;
        b=VcJ+6J5/7jTOItjpvPj3IWr7k81KRRMk1Mlz7+cfHGlEbWDgw6NLeBqfttBN0KF5hL
         4lIqqbhL+7OzenQXB4zZnv1KCIpn2oray179u0a5v7rl0SCMep+8zZrdFYG00j1H1p+w
         ATcQ3lqo3ao1jR9K5t2zOud1RmR8zw6Rj677xeB+ogjcWHN3UpLR4OpygKZpuzdRsIZ/
         S+XtzdVr73MSdZC5H7mo7zqhWx2oxYIweLETU/AVWWAC/hUXIPHb06OewzzaDbcOD9DL
         5cjQ9Q9VGXrNsQuoimuN+VoiNe8bJCoacjkGuA3slMMf6G3goTmOvDATCk3s8o86hCrN
         mYOw==
X-Gm-Message-State: AOJu0YxIyn4ZT/2d5ITKkprz4mo9zgKZUrQEvlUfgHUSyNhf8V6FdXhv
	/PKPLEiIemdf0i+9nb+ht0m4Yvexu7yxn7zNx5JnG6/YWUNVEpzeVo3D
X-Gm-Gg: AeBDieuiMmBJlWC+6qkoT1clm0JnXx+SMCFOQ/npII66qVCOE0/tvrlI6IhX1V77Su5
	50raP/CBIyXubt2z8U0YD5BFQ8eCJefk0zp9rmhNe4cab1mE45HKj/1eHWcJZYQhk2gAL0jeIlX
	pwDFQaeknj3lmXRgz6p/Vebq162dgn919Oj7nqolL0nH48e5q2S/BT8YIRwlREWXhZtEy3qzOvd
	DX9vrDybyHDLhMGSyE2a1W4D3Jfm01E6gi1EfYR1GVLFv4IB3iXjQW2drc+VbMVmbfBkHOurMWZ
	tvtoUV2/up3gsIpDkH+uRdDOK3ZMmxAu072CGaof9G7OwqdGjobwxymmGyc86yPJuuz7o5ZHRDQ
	UoWWfZyml85T25Umv6wwe5qH+zGKn8G7fAe/EMEb9NMNzUHlbGlKDUCOiR9XR2f+UYoVev8JDN7
	kqDqEcekZOeaQVBQFxNHHKwqgDtgk=
X-Received: by 2002:a05:6a00:a1f:b0:821:7d7e:41cd with SMTP id d2e1a72fcca58-8352d012d24mr6351663b3a.10.1777822249726;
        Sun, 03 May 2026 08:30:49 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8352bfe7a49sm5589667b3a.46.2026.05.03.08.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:30:48 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Google-Original-From: Yuya Kusakabe <y-kusakabe@bbsakura.net>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH iproute2-next 5/6] seg6: add support for the End.M.GTP6.D.Di behavior
Date: Mon,  4 May 2026 00:30:05 +0900
Message-ID: <20260503153006.900533-6-y-kusakabe@bbsakura.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503153006.900533-5-y-kusakabe@bbsakura.net>
References: <20260503153006.900533-1-y-kusakabe@bbsakura.net>
 <20260503153006.900533-2-y-kusakabe@bbsakura.net>
 <20260503153006.900533-3-y-kusakabe@bbsakura.net>
 <20260503153006.900533-4-y-kusakabe@bbsakura.net>
 <20260503153006.900533-5-y-kusakabe@bbsakura.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE8FC4B6430
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283619-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.985];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bbsakura.net:mid,end.am:url,end.map:url,end.bm:url,ietf.org:url,end.as:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Yuya Kusakabe <yuya.kusakabe@gmail.com>

Add support for the End.M.GTP6.D.Di drop-in interconnect behavior,
which translates IPv6/GTP-U traffic into an SRv6 SR Policy while
preserving the original outer IPv6 destination as the final SRH
segment.  Unlike End.M.GTP6.D, this behavior does not take
sr_prefix_len.

Example:
ip -6 r a 2001:db8:f::/64 encap seg6local action End.M.GTP6.D.Di \
    srh segs 2001:db8:2::1,2001:db8:3::e \
    src 2001:db8::1 dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h |  2 ++
 ip/iproute.c                    |  2 +-
 ip/iproute_lwtunnel.c           | 10 ++++++++++
 man/man8/ip-route.8.in          | 16 ++++++++++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index ed44fb858600..0ca8405df2f2 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -80,6 +80,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_M_GTP6_E	= 19,
 	/* IPv6/GTP-U decap into SRv6 (RFC 9433 Section 6.3) */
 	SEG6_LOCAL_ACTION_END_M_GTP6_D	= 20,
+	/* IPv6/GTP-U decap into SRv6, drop-in mode (RFC 9433 Section 6.4) */
+	SEG6_LOCAL_ACTION_END_M_GTP6_D_DI = 21,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/ip/iproute.c b/ip/iproute.c
index 8ced32a4f84e..1604545febc8 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -107,7 +107,7 @@ static void usage(void)
 		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
 		"            End.BM | End.S | End.AS | End.AM | End.BPF |\n"
 		"            End.MAP | End.M.GTP4.E | End.M.GTP6.E |\n"
-		"            End.M.GTP6.D }\n"
+		"            End.M.GTP6.D | End.M.GTP6.D.Di }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
 		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME | MOBILE_OPTION }\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index d54bf4628f6f..1234c9f146bf 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -409,6 +409,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_M_GTP4_E]	= "End.M.GTP4.E",
 	[SEG6_LOCAL_ACTION_END_M_GTP6_E]	= "End.M.GTP6.E",
 	[SEG6_LOCAL_ACTION_END_M_GTP6_D]	= "End.M.GTP6.D",
+	[SEG6_LOCAL_ACTION_END_M_GTP6_D_DI]	= "End.M.GTP6.D.Di",
 };
 
 static const char *format_action_type(int action)
@@ -632,6 +633,7 @@ static bool seg6local_action_excludes_final_seg(int action)
 	switch (action) {
 	case SEG6_LOCAL_ACTION_END_B6_ENCAP:
 	case SEG6_LOCAL_ACTION_END_M_GTP6_D:
+	case SEG6_LOCAL_ACTION_END_M_GTP6_D_DI:
 		return true;
 	default:
 		return false;
@@ -663,6 +665,14 @@ static void seg6local_action_check_attrs(int action, int srh_ok, int nh6_ok,
 			invarg("End.M.GTP6.D requires \"srh segs\", \"src\","
 			       " and \"sr_prefix_len\"\n", "");
 		break;
+	case SEG6_LOCAL_ACTION_END_M_GTP6_D_DI:
+		if (!srh_ok || !mobile_src_ok)
+			invarg("End.M.GTP6.D.Di requires \"srh segs\" and \"src\"\n",
+			       "");
+		if (mobile_sr_plen_ok)
+			invarg("End.M.GTP6.D.Di does not accept \"sr_prefix_len\"\n",
+			       "");
+		break;
 	case SEG6_LOCAL_ACTION_END_M_GTP4_E:
 		if (!mobile_src_ok || !mobile_v4mask_ok)
 			invarg("End.M.GTP4.E requires \"src\" and \"v4_mask_len\"\n",
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 35e6e2080a1f..0487338707c6 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1117,6 +1117,22 @@ The action requires either no SRH or an SRH with
 equal to zero on the inbound packet; other matching packets are
 dropped.
 
+.B End.M.GTP6.D.Di srh segs
+.IR SEGMENTS
+.B src
+.IR ADDRESS
+- SRv6 Mobile User Plane End.M.GTP6.D.Di drop-in interconnect behavior
+(RFC 9433 Section 6.4).  Identical to
+.B End.M.GTP6.D
+except that the original outer IPv6 destination address of the
+incoming GTP-U packet is preserved as the final segment of the new
+SRH, allowing existing SRv6 networks to be inserted into a legacy
+mobile path without changing the destination semantics.
+.B sr_prefix_len
+is rejected for this action: the original outer destination is
+preserved verbatim instead of being repacked with an Args.Mob.Session
+field, so no locator length needs to be carried.
+
 .B Flavors parameters
 
 The flavors represent additional operations that can modify or extend a
-- 
2.50.1


