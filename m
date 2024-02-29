Return-Path: <netdev+bounces-76145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7424986C832
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CAB1F261C8
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F77C6EF;
	Thu, 29 Feb 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gaFgSSfe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F47C091
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206824; cv=none; b=BIxFvsUt4ABMbUu3LP2IN8BmX5/jR+2sKr9ll7/3gpzBmhaKVD4LmAJWZ9OQCUrocUAcEGJ/mJWn99U5ZTKInxrq+8vNT9FY9bW9czfMlOSSikIf4RNrXZ64RIgUwy5bUnPv9OGxgk7Mm6XhxsMx3nKHDRdRQhnCUE29HICqlxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206824; c=relaxed/simple;
	bh=C4PmBXoSoBa6O7y4Dd0rpk2vmISWK2TWMUla+sPPANw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SxaZ3Q/CUgrJJJumiH1u74YFa/J3TljCV76/9n7czGM7gLJ1MligEa3bthzpkes3eCnPlofVMqHNTFMHg1V1395Pg0lEnJymhekjVC7E6QuofATf3x/RGw1fdP2VesuWGwMxPzHPJu+26gqSO8lmaFoiscO47YyUqDcLOdDqP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gaFgSSfe; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-787ba4f2b68so92695285a.2
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709206822; x=1709811622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0OUOZny0/QFYcWKXYQ6rJPZIn/Ju/wuUkzay864jA94=;
        b=gaFgSSfed0GGu7+L7wVhG7EiVEAJgE9+5CdvuKbxCd/u+MogoguNlOyZ+B+fPqOMBF
         Fva27nEOwqlwo25ZarXnIEKT+KN+ggjqiLUePKKlHMbF35w23+J2Mzak7c69mzXZ0len
         0Jx3Tv0+1r0MiY/fqDAoPU0JG8NW47rBjC6rmvWC/CflI6pVpvv6vavqo693GId2l4cy
         p2zuEuUgdEzUdMLlTnX6QN9nE3aQU9UiPD0vt8hkUW29CrMdyH6kmL3ELWGOxJoH8U54
         C8Yje9isJcgC9keYNDZOKuG77jXbc/GKAhMOTSYWDEvMH77qNz/v0mlgriAC6OF43ujY
         QEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709206822; x=1709811622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OUOZny0/QFYcWKXYQ6rJPZIn/Ju/wuUkzay864jA94=;
        b=o39afDLCFvINbbJk+dU/spBsPwNxZmHr5Ysi1hMmMLGqSZMzI3Xds2GQs7Pv0oL0Su
         CZykGL2CQ6rRJYQEzIBfTK/y2CxBeAQdm1OO2abiou7GAEkDlchv9GUg0XuiJFAmtVyK
         acRA8NgbLyj2/ZcULqmxFigKqGfwpigWzX2je2NAzAwqsWrzyxRbwDblOWDX6do7Hdeu
         TKRObJlNHQf/fOrKSeqRF27u/btobvmV2IVwqBIIhDKqUnILySPQJMBPpczC+YrDue+k
         pz0sXKLPBakUu1D4b0D4tcJMMF5/CeqdcpiM3vl3hJUnJtLO5Jz5HieR5Dj2LASryDi+
         a3fg==
X-Forwarded-Encrypted: i=1; AJvYcCXYfDjA8GgB/zD2FJXVzSGv2SReZOe66qrQm4Jpy4Gt1SPitr0JTibDVoBcYsqm6kN5cSwLIiqtlekvUTISwDCVPDUjgL8r
X-Gm-Message-State: AOJu0YzXS2jsgq7YjaPhUxBt7X4CBy7FF/QWYU1faCf62flNIYfbim1U
	EeE+qUKjGhSqYFmaUr9M+CWBBqNiims+3n0qEnCrBjDUCephjFWMV4LgRNIdAn04aGGCWEyBRr+
	+KXwnuE06Qg==
X-Google-Smtp-Source: AGHT+IFtm+VTVqGyyvOt4pvpxf6gE+YeIbNAO15ZyHYUPSXdabqhOyvBqi5S5NxhiThrEDRK2fXdQAqNBlHUZA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:2948:b0:787:d89b:cf61 with SMTP
 id n8-20020a05620a294800b00787d89bcf61mr20151qkp.5.1709206822029; Thu, 29 Feb
 2024 03:40:22 -0800 (PST)
Date: Thu, 29 Feb 2024 11:40:12 +0000
In-Reply-To: <20240229114016.2995906-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229114016.2995906-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240229114016.2995906-3-edumazet@google.com>
Subject: [PATCH net-next 2/6] inet: annotate data-races around ifa->ifa_valid_lft
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ifa->ifa_valid_lft can be read locklessly.

Add appropriate READ_ONCE()/WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 1316046d5f28955376091d9e02ab4594e19fbd09..99f3e7c57d36ff028edadd4efd66d996ddc5d9b4 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -714,26 +714,26 @@ static void check_lifetime(struct work_struct *work)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(ifa, &inet_addr_lst[i], hash) {
 			unsigned long age, tstamp;
+			u32 valid_lft;
 
 			if (ifa->ifa_flags & IFA_F_PERMANENT)
 				continue;
 
+			valid_lft = READ_ONCE(ifa->ifa_valid_lft);
 			tstamp = READ_ONCE(ifa->ifa_tstamp);
 			/* We try to batch several events at once. */
 			age = (now - tstamp +
 			       ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
 
-			if (ifa->ifa_valid_lft != INFINITY_LIFE_TIME &&
-			    age >= ifa->ifa_valid_lft) {
+			if (valid_lft != INFINITY_LIFE_TIME &&
+			    age >= valid_lft) {
 				change_needed = true;
 			} else if (ifa->ifa_preferred_lft ==
 				   INFINITY_LIFE_TIME) {
 				continue;
 			} else if (age >= ifa->ifa_preferred_lft) {
-				if (time_before(tstamp +
-						ifa->ifa_valid_lft * HZ, next))
-					next = tstamp +
-					       ifa->ifa_valid_lft * HZ;
+				if (time_before(tstamp + valid_lft * HZ, next))
+					next = tstamp + valid_lft * HZ;
 
 				if (!(ifa->ifa_flags & IFA_F_DEPRECATED))
 					change_needed = true;
@@ -810,7 +810,7 @@ static void set_ifa_lifetime(struct in_ifaddr *ifa, __u32 valid_lft,
 
 	timeout = addrconf_timeout_fixup(valid_lft, HZ);
 	if (addrconf_finite_timeout(timeout))
-		ifa->ifa_valid_lft = timeout;
+		WRITE_ONCE(ifa->ifa_valid_lft, timeout);
 	else
 		ifa->ifa_flags |= IFA_F_PERMANENT;
 
@@ -1699,7 +1699,7 @@ static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
 	tstamp = READ_ONCE(ifa->ifa_tstamp);
 	if (!(ifm->ifa_flags & IFA_F_PERMANENT)) {
 		preferred = ifa->ifa_preferred_lft;
-		valid = ifa->ifa_valid_lft;
+		valid = READ_ONCE(ifa->ifa_valid_lft);
 		if (preferred != INFINITY_LIFE_TIME) {
 			long tval = (jiffies - tstamp) / HZ;
 
-- 
2.44.0.278.ge034bb2e1d-goog


