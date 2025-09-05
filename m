Return-Path: <netdev+bounces-220416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF33B45F74
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677A4A07E6B
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B830B53C;
	Fri,  5 Sep 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SyTKQddB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006630B52F
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091499; cv=none; b=qKgh8gTyoE687pr+5pdo5v+Aqqw2/VachO6cNWDIXsy4aHtgvZsUq99m6EiaWG0LMg2Ue5xxH8WRlr0rpTYqLbk45kRciRNubMHi+wm9OKkLkeHWhAkPSnSePUL7IMo0Y2HF9gjUZrQCAoJ+T3U1VZrIzIxIh7KEw+PSH+L7hY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091499; c=relaxed/simple;
	bh=ku7ZceNxa/Bqp4MlmyUqPVOooKgbru4aPiGB412OQnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JDbUeyu1JXKG6oem+SaLqB0DBNB24+1IFC9EiNRfcYpk5XEbZ8dqV+EvUR//4+Lk4+feF3836sLwYZhDI6qbbMk5S4IkbJtVV3MmoG76ifR9UlYcPJ/cmKoynL6gyhiwys05XGDXotqwv9IRVt18pteF2QVaFWeCgz9wCvKtElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SyTKQddB; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e870315c98so792749085a.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757091497; x=1757696297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ji8uGS+aCi8xjucOjIKbix2FEdr+e9RkelUyIbbx8w=;
        b=SyTKQddBRY6yrKyPOnI0THC6poQTVRBnuVqhTeKsh2FRnvtoV1Nd6jxIbF2GPkV1bi
         0uKTmrf8zLJf43wEjyKUv9Tcq4XV1nJiPZprhk5F/U/V/ZtBdgGuqq8DGz0Z1QOWQ1Pt
         sk8qnBVznWjsBG40x8sYWJMjggrhWCFpWrey/qRKL4Ia1R878HW2HkIkcemPo92r8Rz1
         uWROPWdV3rTVIEZOdC3gEpNd4tfJA4fwa0XulDCHcLMzpsnYdfPu6OfKz0Py3H64aet6
         adMAUDeX4O5vFAamgL67Xf+WJp5mVNvZNiGc+zfhnagIjRpkZvo7sjOuQ21xxJTds9kW
         fTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091497; x=1757696297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ji8uGS+aCi8xjucOjIKbix2FEdr+e9RkelUyIbbx8w=;
        b=cf2NmaPE5y2VD4HWiZTtyh6RJHp0prwD9rAmygrLhrhAXrT9tGTNCIm+EBm0IUUrPN
         G2p9KSrIHDhrRMEQRmR2s3AxQA6UjfZpO/RzNIeFRuyKBwWrjdldlxQczBDWvuoobh4m
         3Rdtu9SOZSNayChqQWEtTXdruYmrc8mvmr2hquZwX3q4UxzSa4fjhI56F/fFI22ChdQO
         9rP25diUNxYgsNpz1P3jPF/z6aNwxygRWq6kL1UVg7x1ZiqGixyhIv5LI14sVWe7SPxC
         V9dagGTksycgPJY/gs8Vd1nc6cA/XIPcvUwdbjb59O0eNqvYkBEHDRx9Nw9+MRRiKZyp
         Fpfw==
X-Forwarded-Encrypted: i=1; AJvYcCWOn69cPw0KP7GflVb4M4U+5zpLOJkw7LIi8ZK0M20nEDMijJMPQRA6wmO5GKA4thxsM1EPC+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YycmyH/l+VMQFe6nKjjj0FEV2IjKliooGBsT84nUxGfNqdNbGDt
	TA3MHJvnXWCVhKGbD+S7egb/xGPTU68S9hXVccWNxkbd6ABaS6u2DQnxzBjfd/Xw9iHvKYGGPwT
	57PDwhN2XT85FKg==
X-Google-Smtp-Source: AGHT+IHxIm+invZr3z+Xb9MWILfo7m+bFx1EH+Inv8ZzbULJrimJV21mJPuW/pxuPBj5WZqMlI19rGTowJL0XA==
X-Received: from qkpa26.prod.google.com ([2002:a05:620a:439a:b0:802:be88:2d95])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a81:b0:7f9:3472:b079 with SMTP id af79cd13be357-7ff27b20341mr3318390385a.22.1757091497045;
 Fri, 05 Sep 2025 09:58:17 -0700 (PDT)
Date: Fri,  5 Sep 2025 16:58:05 +0000
In-Reply-To: <20250905165813.1470708-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905165813.1470708-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905165813.1470708-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/9] ipv6: snmp: remove icmp6type2name[]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This 2KB array can be replaced by a switch() to save space.

Before:
$ size net/ipv6/proc.o
   text	   data	    bss	    dec	    hex	filename
   6410	    624	      0	   7034	   1b7a	net/ipv6/proc.o

After:
$ size net/ipv6/proc.o
   text	   data	    bss	    dec	    hex	filename
   5516	    592	      0	   6108	   17dc	net/ipv6/proc.o

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/proc.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index 752327b10dde..e96f14a36834 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -99,26 +99,6 @@ static const struct snmp_mib snmp6_icmp6_list[] = {
 	SNMP_MIB_SENTINEL
 };
 
-/* RFC 4293 v6 ICMPMsgStatsTable; named items for RFC 2466 compatibility */
-static const char *const icmp6type2name[256] = {
-	[ICMPV6_DEST_UNREACH] = "DestUnreachs",
-	[ICMPV6_PKT_TOOBIG] = "PktTooBigs",
-	[ICMPV6_TIME_EXCEED] = "TimeExcds",
-	[ICMPV6_PARAMPROB] = "ParmProblems",
-	[ICMPV6_ECHO_REQUEST] = "Echos",
-	[ICMPV6_ECHO_REPLY] = "EchoReplies",
-	[ICMPV6_MGM_QUERY] = "GroupMembQueries",
-	[ICMPV6_MGM_REPORT] = "GroupMembResponses",
-	[ICMPV6_MGM_REDUCTION] = "GroupMembReductions",
-	[ICMPV6_MLD2_REPORT] = "MLDv2Reports",
-	[NDISC_ROUTER_ADVERTISEMENT] = "RouterAdvertisements",
-	[NDISC_ROUTER_SOLICITATION] = "RouterSolicits",
-	[NDISC_NEIGHBOUR_ADVERTISEMENT] = "NeighborAdvertisements",
-	[NDISC_NEIGHBOUR_SOLICITATION] = "NeighborSolicits",
-	[NDISC_REDIRECT] = "Redirects",
-};
-
-
 static const struct snmp_mib snmp6_udp6_list[] = {
 	SNMP_MIB_ITEM("Udp6InDatagrams", UDP_MIB_INDATAGRAMS),
 	SNMP_MIB_ITEM("Udp6NoPorts", UDP_MIB_NOPORTS),
@@ -151,11 +131,31 @@ static void snmp6_seq_show_icmpv6msg(struct seq_file *seq, atomic_long_t *smib)
 
 	/* print by name -- deprecated items */
 	for (i = 0; i < ICMP6MSG_MIB_MAX; i++) {
+		const char *p = NULL;
 		int icmptype;
-		const char *p;
+
+#define CASE(TYP, STR) case TYP: p = STR; break;
 
 		icmptype = i & 0xff;
-		p = icmp6type2name[icmptype];
+		switch (icmptype) {
+/* RFC 4293 v6 ICMPMsgStatsTable; named items for RFC 2466 compatibility */
+		CASE(ICMPV6_DEST_UNREACH,	"DestUnreachs")
+		CASE(ICMPV6_PKT_TOOBIG,		"PktTooBigs")
+		CASE(ICMPV6_TIME_EXCEED,	"TimeExcds")
+		CASE(ICMPV6_PARAMPROB,		"ParmProblems")
+		CASE(ICMPV6_ECHO_REQUEST,	"Echos")
+		CASE(ICMPV6_ECHO_REPLY,		"EchoReplies")
+		CASE(ICMPV6_MGM_QUERY,		"GroupMembQueries")
+		CASE(ICMPV6_MGM_REPORT,		"GroupMembResponses")
+		CASE(ICMPV6_MGM_REDUCTION,	"GroupMembReductions")
+		CASE(ICMPV6_MLD2_REPORT,	"MLDv2Reports")
+		CASE(NDISC_ROUTER_ADVERTISEMENT, "RouterAdvertisements")
+		CASE(NDISC_ROUTER_SOLICITATION, "RouterSolicits")
+		CASE(NDISC_NEIGHBOUR_ADVERTISEMENT, "NeighborAdvertisements")
+		CASE(NDISC_NEIGHBOUR_SOLICITATION, "NeighborSolicits")
+		CASE(NDISC_REDIRECT,		"Redirects")
+		}
+#undef CASE
 		if (!p)	/* don't print un-named types here */
 			continue;
 		snprintf(name, sizeof(name), "Icmp6%s%s",
-- 
2.51.0.355.g5224444f11-goog


