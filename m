Return-Path: <netdev+bounces-219942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71101B43D1E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3DB1C204FE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C9D302779;
	Thu,  4 Sep 2025 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPObGBnm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83C302CD9
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992362; cv=none; b=TtmOs96MzF80xW4u67sWnPqP0grumD/Bc5hsTYo9nnUzo2Kdq2Bsr4YWV7PzA2/F/ysvUJ3VthSI6xKRD7svCMxI5xjAU6IcfpsGCOeua9hv4T80Px9k+mg2EIN0oLAnkmaLK+quDX6NtX474Hw0JpPMCG3RtoO1CwHcORrr0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992362; c=relaxed/simple;
	bh=PlRj6Adt1Mzn52kuUg6+tgNBCAoGfLR+D3970I0/lwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tXS/4ytKPm3L3EhJXlOKFTsWvlWyGsPwLW8C4KDG2vpR+DPyW3xFgAC9blI2Q2XO+gEBF3uwoDyONxDlF3IZqMhSIuc8ESN54rJ33YFbo6x67q+IsabjN4ZjdO4b6qvHfTZe37UY0c9YSYh2fcmrp7zQiqH3pkGe1BHuV6Yx9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPObGBnm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-71d4cc7fa4fso38588167b3.0
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756992359; x=1757597159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ALr9M0apJRI/evitcayQqWsTaVbk+hHSJYYr+E6EfYc=;
        b=jPObGBnmh2sfr8i4pODXjwLpX3z2UBEt4pCGSb49/BCh4EMGBow1W8ay0sNqDrVp2h
         0aiS019+ZzBY9tEVW3tndrEVw4SPTK2HrbNdtUSqo6KUK7B97ZIkYKSEanGAirKfsE2z
         RaStqee01w/6MfOaQId9KFSkYU181B9wP0SIBmomqK1gvsReNhWYU5qPtzSBRh475Itb
         Wp1RPHYS+SANctrDaj6NCvRsMlrqjoPDJJzA80gXF4W6DmwT4wQTINKUCu+vpv+1hYIz
         FJpP+9oR9jukPGT5nbx2w8TMduZ+E4viBpc1cTUXrErASL7JqSsq2wWvc8BHXv+ixVyo
         xS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992359; x=1757597159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALr9M0apJRI/evitcayQqWsTaVbk+hHSJYYr+E6EfYc=;
        b=GHD5StkxItB2AxrkFANInHTPjTNqv5nd1OERTe23wMyeiSfn2KkPDtr7/3KVXkLnO4
         w19IzYMoLuNfkIesJehP2OBut/frV2u8vi0GRhMsGuHkuBBi5hX6+3qz5W5pyYD9F/Np
         /NkCJ4UCNrfMOdjj1jsZvdVCvUwToWswy01xdfEGzN88pZ6+InMHOUCYVpr9J0t5nXoV
         978looK2VbskckzGBDAnTpSeIdG5hn5VUrNnvT+DCGBuunXwivsedy0WXKtymGyrehpA
         Qpzy9RSpSvbrQ1DAL1Nq88xvWC+7K26mF6hPM0lSMTguI1ru0t8Qljou6gkvVAHTYaW5
         8eyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqnmOKo1H6i4Jwxvi8kxJb7V+89ub7fHZskRDpxOI6GbImcVXMT04ZGXSEBkAPCK2uN2KJG6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyehfV4mnUkKIFUFjQ1sLZOUYCOor1XBx3/0PKjqhiM4V6AR00
	uhJ6Z5538AvdoX5lHXpMEi3yf39JEK3slutkf3Xveo7SoBthJwk+C4R7j48N+INuRw1DrO7PO1l
	5FVypzM8E1r4fAQ==
X-Google-Smtp-Source: AGHT+IF7RBdn7UV/0/7L7fXGurFTB1u1ciY50peqelwPZ+SLPFA8EiZcjGxFK9wtYs6NoItA1QgICWSrlQ/dkA==
X-Received: from ybjh8.prod.google.com ([2002:a25:b188:0:b0:e9c:2659:a70b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:408b:b0:5fe:26ea:e61b with SMTP id 956f58d0204a3-60148624da1mr2288937d50.1.1756992359392;
 Thu, 04 Sep 2025 06:25:59 -0700 (PDT)
Date: Thu,  4 Sep 2025 13:25:51 +0000
In-Reply-To: <20250904132554.2891227-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904132554.2891227-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904132554.2891227-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] ipv6: snmp: remove icmp6type2name[]
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
2.51.0.338.gd7d06c2dae-goog


