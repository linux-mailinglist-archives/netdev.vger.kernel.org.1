Return-Path: <netdev+bounces-76147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C596C86C835
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7ECB23247
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B468A7C0B9;
	Thu, 29 Feb 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0DtQoDPH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7447CF10
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206828; cv=none; b=nEdXV3CH1tgQtYBdvBoR/B15FcBxPYovGwP6TqXvc6kd9cz0DtH4ExPoWroLEZYq0Z2N5fK2vd1AZKSoBVHrmTpKO2YjQSVTYwDz+KyNb8F4x6DQ9f7SvedNnAgzYwsShory8nRX+aUWm9EhYnyEIBd1Dr5HhwvYhdQai7gpMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206828; c=relaxed/simple;
	bh=X3fIBea3nDCpfhmsoE78Zjk407CjrUMlH3E2Ui0sje8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D1o4KGv+eWQg9VPIktZh2ny7VxSym3idUWgEMTJ8Pp1L/gKDWTxaLJe344o4q5N0bmO6bDsVwuT9rJ2bxvSuRpgqhJdXJQzDDXIuELz9JSv2r4KBTlRaP/mzanqHotetnsqkuZR/FNEm3L9OvfamwCgJd3y6GlzOjQhFNzRIZpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0DtQoDPH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so982532276.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709206825; x=1709811625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zw60ERsK7mwNepnjWiQI55oc8/dMLCRYKkYFuuWsyf8=;
        b=0DtQoDPH7K6J+vowYd8x7160ubUfammUQBTq/vJwB7TLRLuR7UM+ZCF94oPWyU4Zts
         R4kFGcwptWip5ivu3Y3I9nhYF5YQgbPpM/XH49mMN7nus5MogypqpRgVdiiEVg1Aabke
         iZ5xzXOMvErc+vg5FrsUDIE6WWJCdv26jsgAO1s7VkL9NBXL7jK9RPtON0SH5OPpwldP
         4bo0VJYC7jMNhArBQteVus1cLnRjfWYoa9n3xV4a+5DUj9uvYaoqT8tTRkLoaPD16o5p
         yfynvO+kSqhWRqIC1ZAHKWn9sc6ZLAv4I4hSexV6xKvf4TzRJTqEfKx5/tAetDH67/uc
         9C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709206825; x=1709811625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zw60ERsK7mwNepnjWiQI55oc8/dMLCRYKkYFuuWsyf8=;
        b=sjanN/4NU0SWOdSabiwy/CpbzpKIq5ZDKXNbuJkt3AVUUmBDyT/cz/IRgNoVvwjyI9
         b8zayKCikIEoRyVVkLrLmlK0/QUF42qtwE5nZC6blYmWbT6hZTFeduACl2rBsEwao1mb
         i7tpqGnafedE3sJjFAEPvfDG1W+aAW6gObH2MfMHHgqlyUuxKimRh364b51sePVG6vBg
         +TS5VGuapGozxdsYdIN+QuYZ2Zipik2HZ2ilrZYyfeTAHG1/LS1RrBfsrunTaVu91Mnf
         PRNY6axYVk6KyNGynChC2VOJWIkab2Z5l0PaBhv+Sb5C7WsQR7gpNYesFc7s+Dy5PuY0
         NuNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp/uM5zOVXeALKtXmjlb4VJMvCmcHa7l3q3mgzy0sLIsMP+GFKaEvxXP8UZUXW6BZMcR6UcPyqAELwjANyuw7b8l1wtL+P
X-Gm-Message-State: AOJu0YwffMXIL7S6DmqAvOwfmFmWpu7mkuDhfVM/36cGxCSxR9hb9KTI
	C5Z3o/X3TuYTs1o9A2gmzIYSLWKXcXsm+2TX7Sr2hI1pVUfkFryXmqOdb02fApRbV4d2TOjul1v
	J3rYaI3HAWQ==
X-Google-Smtp-Source: AGHT+IGIQ9Cb1gygYNxUwPVzdYxuLXpcYuwLyPeIuCmT1aATR4TPoHbdxloPfR2TQJ6ddcUVs2TkpqQKENdV3A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:e90:b0:dcb:c2c0:b319 with SMTP
 id dg16-20020a0569020e9000b00dcbc2c0b319mr66651ybb.9.1709206825036; Thu, 29
 Feb 2024 03:40:25 -0800 (PST)
Date: Thu, 29 Feb 2024 11:40:14 +0000
In-Reply-To: <20240229114016.2995906-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229114016.2995906-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240229114016.2995906-5-edumazet@google.com>
Subject: [PATCH net-next 4/6] inet: annotate data-races around ifa->ifa_flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ifa->ifa_flags can be read locklessly.

Add appropriate READ_ONCE()/WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 368fb56e1f1b2e3b7888f611a3f113f3bd5fc2af..550b775cbbf3c140c66e224c69996df7051b3d36 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -716,8 +716,10 @@ static void check_lifetime(struct work_struct *work)
 			unsigned long age, tstamp;
 			u32 preferred_lft;
 			u32 valid_lft;
+			u32 flags;
 
-			if (ifa->ifa_flags & IFA_F_PERMANENT)
+			flags = READ_ONCE(ifa->ifa_flags);
+			if (flags & IFA_F_PERMANENT)
 				continue;
 
 			preferred_lft = READ_ONCE(ifa->ifa_preferred_lft);
@@ -737,7 +739,7 @@ static void check_lifetime(struct work_struct *work)
 				if (time_before(tstamp + valid_lft * HZ, next))
 					next = tstamp + valid_lft * HZ;
 
-				if (!(ifa->ifa_flags & IFA_F_DEPRECATED))
+				if (!(flags & IFA_F_DEPRECATED))
 					change_needed = true;
 			} else if (time_before(tstamp + preferred_lft * HZ,
 					       next)) {
@@ -805,21 +807,23 @@ static void set_ifa_lifetime(struct in_ifaddr *ifa, __u32 valid_lft,
 			     __u32 prefered_lft)
 {
 	unsigned long timeout;
+	u32 flags;
 
-	ifa->ifa_flags &= ~(IFA_F_PERMANENT | IFA_F_DEPRECATED);
+	flags = ifa->ifa_flags & ~(IFA_F_PERMANENT | IFA_F_DEPRECATED);
 
 	timeout = addrconf_timeout_fixup(valid_lft, HZ);
 	if (addrconf_finite_timeout(timeout))
 		WRITE_ONCE(ifa->ifa_valid_lft, timeout);
 	else
-		ifa->ifa_flags |= IFA_F_PERMANENT;
+		flags |= IFA_F_PERMANENT;
 
 	timeout = addrconf_timeout_fixup(prefered_lft, HZ);
 	if (addrconf_finite_timeout(timeout)) {
 		if (timeout == 0)
-			ifa->ifa_flags |= IFA_F_DEPRECATED;
+			flags |= IFA_F_DEPRECATED;
 		WRITE_ONCE(ifa->ifa_preferred_lft, timeout);
 	}
+	WRITE_ONCE(ifa->ifa_flags, flags);
 	WRITE_ONCE(ifa->ifa_tstamp, jiffies);
 	if (!ifa->ifa_cstamp)
 		WRITE_ONCE(ifa->ifa_cstamp, ifa->ifa_tstamp);
@@ -1313,7 +1317,7 @@ static __be32 in_dev_select_addr(const struct in_device *in_dev,
 	const struct in_ifaddr *ifa;
 
 	in_dev_for_each_ifa_rcu(ifa, in_dev) {
-		if (ifa->ifa_flags & IFA_F_SECONDARY)
+		if (READ_ONCE(ifa->ifa_flags) & IFA_F_SECONDARY)
 			continue;
 		if (ifa->ifa_scope != RT_SCOPE_LINK &&
 		    ifa->ifa_scope <= scope)
@@ -1341,7 +1345,7 @@ __be32 inet_select_addr(const struct net_device *dev, __be32 dst, int scope)
 		localnet_scope = RT_SCOPE_LINK;
 
 	in_dev_for_each_ifa_rcu(ifa, in_dev) {
-		if (ifa->ifa_flags & IFA_F_SECONDARY)
+		if (READ_ONCE(ifa->ifa_flags) & IFA_F_SECONDARY)
 			continue;
 		if (min(ifa->ifa_scope, localnet_scope) > scope)
 			continue;
@@ -1688,7 +1692,7 @@ static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
 	ifm = nlmsg_data(nlh);
 	ifm->ifa_family = AF_INET;
 	ifm->ifa_prefixlen = ifa->ifa_prefixlen;
-	ifm->ifa_flags = ifa->ifa_flags;
+	ifm->ifa_flags = READ_ONCE(ifa->ifa_flags);
 	ifm->ifa_scope = ifa->ifa_scope;
 	ifm->ifa_index = ifa->ifa_dev->dev->ifindex;
 
@@ -1728,7 +1732,7 @@ static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
 	     nla_put_string(skb, IFA_LABEL, ifa->ifa_label)) ||
 	    (ifa->ifa_proto &&
 	     nla_put_u8(skb, IFA_PROTO, ifa->ifa_proto)) ||
-	    nla_put_u32(skb, IFA_FLAGS, ifa->ifa_flags) ||
+	    nla_put_u32(skb, IFA_FLAGS, ifm->ifa_flags) ||
 	    (ifa->ifa_rt_priority &&
 	     nla_put_u32(skb, IFA_RT_PRIORITY, ifa->ifa_rt_priority)) ||
 	    put_cacheinfo(skb, READ_ONCE(ifa->ifa_cstamp), tstamp,
-- 
2.44.0.278.ge034bb2e1d-goog


