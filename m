Return-Path: <netdev+bounces-95342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624A88C1EF8
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B5A1C20CD2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF215E81F;
	Fri, 10 May 2024 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pgvIV2wO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9205635
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715326176; cv=none; b=serXdx8rj9+MBShdv3Yr9GdJICcRN4QgUrj6ccRWTzGMm/U+oysWg/uc8vTuFOfqsaTku/IVFn/X/MF+wMhfVOtmnOFHiVPejGCz4kInzS/IUxack1Xe2hhx1aTUE65Md7MX+y2IhMxk6KNgAgcXM1rFzNCLJosafIMtnH7I0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715326176; c=relaxed/simple;
	bh=rutH6b+JygXzdhtamSHVzcoXyoI8eozU0pAnrdu2xB4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bOUheUbbha6d6rjYygGeZ7sAj03ojtrd9te8ewavv8u4c9vNpv+MYwX4fAxmheOQYLDgDq9ZV4qfJbuFIY/7X73ZMjsZhfE3/bQ1gJuyjk80nK1+QD6TEt9AHKDMVx90P/EEyYviRUfaz+t0i6zIMa8Cgysqumbmp6zIn94mleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pgvIV2wO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so2345261276.0
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715326173; x=1715930973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x+7j0qW94Da3XPGyn/JF0sNtafbGXdoe4euD9gRiuXA=;
        b=pgvIV2wO1mHpAwx8F6KtymVwkpXMQJYMK+kBGzrrYyVqgr7NnFOxVDAktdnQw/10h5
         TNZOjKys1DvFjzzGfeKk5LZ8FsFNERJ+I/3oiNPVp/vLjuJXsdeldaCx3AeTqRFVwVkp
         17FomE/9nseX7Vk/gQJpexWDAlZSFzmE2q0kALLh9UyJtTquLvxOHzMCIrXunis+k8km
         mELalrWF13tXnJSr44hGVBdwglBf/QbY8JKGkuz83obbdgM32wXXeREOKlBH6pmaMnV/
         YxdhJILUQJ+3eDDYurjqQMvQbSvopq0q8pDEIPqD6KkKWZCFw0ViChtKq0lgFtZCzEGZ
         hvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715326173; x=1715930973;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x+7j0qW94Da3XPGyn/JF0sNtafbGXdoe4euD9gRiuXA=;
        b=jedBzsQov7omgCMo4s0TdlYc9hI2YcZL2DUnokDWbmaaEuCLCE+Mae6Me1Z3S0C50I
         naWSEE6hr2YZcnmiF2In3u10j6cBSlicMo/h7IR/SBJJjdydMv9uK8+JEBEEdOv0G5AO
         jn9e2bAW/9EJ6jIDQK5esWboF/bsUTynby3wgPLxMu9zLXffv9K0+7dGbtpkHfVS9I5t
         jz137poffLpGOF6g+nJW727bC4Sh93hXRokT1uXBw4jqNM2JcNK1TSb5OZNuGgDh3zb7
         DNZHFGyLYGoTxdVhKm0K/phSE+6FjwP+MRTsiCYcMrna02HrmRrwjjPoBTZVDScIhdiY
         w+BA==
X-Forwarded-Encrypted: i=1; AJvYcCV5maDYt8qtREOIVFukaZVjytyn99ktgdvB1qQLd16e2CMVNsU0sWsTyogjE/8ATfI4bnVPnAVIL168UbdO+ei7BvN9lmVX
X-Gm-Message-State: AOJu0YzxL0eAHm6PWof8RjK0CFfhDXnYDBscmFa8luohX/fZNaLvWqGt
	rarCw+lhIhitcsvIs7wnZ7TZCuoVn0do+DAuMQo2WtIL/0sYCTg8NmrVIfsWMYQym+9gnnn2MeY
	Ea2yD2l4lOA==
X-Google-Smtp-Source: AGHT+IFXUjHg6SegqTG3YAmbER8EfE5jvjfcXESCwX6MBhcgKDEsremMld60RdJ8ATTXR7EqnD8RG+WcE/e6rg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:c03:b0:de5:319b:a211 with SMTP
 id 3f1490d57ef6-dee4f1b0cb2mr161422276.3.1715326173675; Fri, 10 May 2024
 00:29:33 -0700 (PDT)
Date: Fri, 10 May 2024 07:29:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510072932.2678952-1-edumazet@google.com>
Subject: [PATCH net] inet: fix inet_fill_ifaddr() flags truncation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Yu Watanabe <watanabe.yu@gmail.com>
Content-Type: text/plain; charset="UTF-8"

I missed that (struct ifaddrmsg)->ifa_flags was only 8bits,
while (struct in_ifaddr)->ifa_flags is 32bits.

Use a temporary 32bit variable as I did in set_ifa_lifetime()
and check_lifetime().

Fixes: 3ddc2231c810 ("inet: annotate data-races around ifa->ifa_flags")
Reported-by: Yu Watanabe <watanabe.yu@gmail.com>
Dianosed-by: Yu Watanabe <watanabe.yu@gmail.com>
Closes: https://github.com/systemd/systemd/pull/32666#issuecomment-2103977928
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 7a437f0d41905e6acfdc35743afba3a7abfd0dd5..7e45c34c8340a6d2cf96b4485cd4249fd4da7009 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1683,6 +1683,7 @@ static int inet_fill_ifaddr(struct sk_buff *skb, const struct in_ifaddr *ifa,
 	struct nlmsghdr  *nlh;
 	unsigned long tstamp;
 	u32 preferred, valid;
+	u32 flags;
 
 	nlh = nlmsg_put(skb, args->portid, args->seq, args->event, sizeof(*ifm),
 			args->flags);
@@ -1692,7 +1693,13 @@ static int inet_fill_ifaddr(struct sk_buff *skb, const struct in_ifaddr *ifa,
 	ifm = nlmsg_data(nlh);
 	ifm->ifa_family = AF_INET;
 	ifm->ifa_prefixlen = ifa->ifa_prefixlen;
-	ifm->ifa_flags = READ_ONCE(ifa->ifa_flags);
+
+	flags = READ_ONCE(ifa->ifa_flags);
+	/* Warning : ifm->ifa_flags is an __u8, it holds only 8 bits.
+	 * The 32bit value is given in IFA_FLAGS attribute.
+	 */
+	ifm->ifa_flags = (__u8)flags;
+
 	ifm->ifa_scope = ifa->ifa_scope;
 	ifm->ifa_index = ifa->ifa_dev->dev->ifindex;
 
@@ -1701,7 +1708,7 @@ static int inet_fill_ifaddr(struct sk_buff *skb, const struct in_ifaddr *ifa,
 		goto nla_put_failure;
 
 	tstamp = READ_ONCE(ifa->ifa_tstamp);
-	if (!(ifm->ifa_flags & IFA_F_PERMANENT)) {
+	if (!(flags & IFA_F_PERMANENT)) {
 		preferred = READ_ONCE(ifa->ifa_preferred_lft);
 		valid = READ_ONCE(ifa->ifa_valid_lft);
 		if (preferred != INFINITY_LIFE_TIME) {
@@ -1732,7 +1739,7 @@ static int inet_fill_ifaddr(struct sk_buff *skb, const struct in_ifaddr *ifa,
 	     nla_put_string(skb, IFA_LABEL, ifa->ifa_label)) ||
 	    (ifa->ifa_proto &&
 	     nla_put_u8(skb, IFA_PROTO, ifa->ifa_proto)) ||
-	    nla_put_u32(skb, IFA_FLAGS, ifm->ifa_flags) ||
+	    nla_put_u32(skb, IFA_FLAGS, flags) ||
 	    (ifa->ifa_rt_priority &&
 	     nla_put_u32(skb, IFA_RT_PRIORITY, ifa->ifa_rt_priority)) ||
 	    put_cacheinfo(skb, READ_ONCE(ifa->ifa_cstamp), tstamp,
-- 
2.45.0.118.g7fe29c98d7-goog


