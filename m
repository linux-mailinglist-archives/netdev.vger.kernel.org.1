Return-Path: <netdev+bounces-250277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4BD26EF4
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F57130EFB0E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962A63C197A;
	Thu, 15 Jan 2026 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHqFAkl6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB793C1985
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497943; cv=none; b=ljIMyjRhba6TSDw9Kkv77LN1Aa4mGvEFV4wlRY8PCOKTjYX7ClgGx821qWieT0LaA8ZU6P2BXoEzbh/gtcHAp7y0FP2PWtmdTgEyH7k8U0EGnVOG4xewX9+hfmdl3fsMVfRx56FxMMWJcgyUfBdBOwuz3cKBTerHvo+JC7GmQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497943; c=relaxed/simple;
	bh=636EeRlWKPUF35YCX4M7favf9q2EFq8+BzbyWv7fv3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DdA6nWtF+eLBvS5UaePjlYy2hWqoqy3yyx710NN/hUsSW53vwlAeqsk+itpDzmQkbOij/OCcWR5osF6WB+siTrynC26/LWdO1Bx0n9AwEWUwgFPRfjHRGc05S09O53MR6h6r02vFRnqsE5yZDa5vbdjbwDTf9B7xV5wlu+xvf+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SHqFAkl6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-81e7fd70908so2144680b3a.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768497941; x=1769102741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XeZA1LDs7atBI0ne5plnLiKQW/ZKjljcs5iRIVQV3z4=;
        b=SHqFAkl6CkYa3fmNlCZBbtYxVpT4lyFCHOTQruomH+aEBwS+ukXClSaul/UuU9Sxuc
         2gn6Jo6HbgaFUdh2a9emvjwEUTGv3KEVHpPjscIpZyF+B6bW/lG/mN9+GAHgyPXsaDFb
         j99ptEYr3dkPz7qmejT1BjqSJczbmGVVJmZVB6KHr+9PLyWx+dEtwyZp7HQck0Zh3dBk
         b7nTkcnFhVFAtI3dMUMP2hZxmmK6Jks9CDK/IVli+IXFNiS12RFwEXBkp8w+YMred6X+
         oUGkJE8N4ZYB6NU2R6PNRKpH98vDgLKQGp1Wpyhk5/wxvioz1jvUtWV3qq8KTR1PSYy6
         NOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497941; x=1769102741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeZA1LDs7atBI0ne5plnLiKQW/ZKjljcs5iRIVQV3z4=;
        b=Chucdg+9PQfobix9Wv52hdmm/x1mrz+vjZMMZld9swLbckGsyJnjCYccJ3vpgpgrqW
         C20EeOmmp5Aapl/38WSWxpe+PJXTD9r6YgswihURY13JEGRqo2RDCIP8sqI8QmuRqlpA
         4oNyweMwBmRAut8dwOwIHEWl6TMgzyBIF0PA08oI9glUd6jgzLq2piRFa1tQxyOH3FQH
         wArRTV3ArEO7bN4XFTsQAjlaLdtoHEOVbpSJ+mUvGym0GiXcwNAfQaZgYa11uAoWz8mN
         VpRVtYH2vmi9beFIOdiU/F8/d8QzfJVh37yjPUSXiiEd0jfiPgOyNGPMSlcxJ69yXyon
         KFTg==
X-Forwarded-Encrypted: i=1; AJvYcCXJa1D8ZMV6cmi7vZZg02YRT6BUrWrFz6c/YnUhRSNx7KB7VrjJQa49265H/XUgqvAsNsZIfdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqUhjEXSAcOr6ei26LfL0J975m5eLbnyJrX5LYr2eB+9pDeEoc
	1BtRUe/fiXnjpnCIV3dyN/haJL2yuT2bvDH6stxo7C7iYX3Fmjpxb8khZKt5azn5BeKfN0hVr5Y
	jjBeb5g==
X-Received: from pfbc5.prod.google.com ([2002:a05:6a00:ad05:b0:7b8:d5a9:9eff])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d07:b0:81e:591c:e7b9
 with SMTP id d2e1a72fcca58-81f9f7f61aemr282367b3a.2.1768497940730; Thu, 15
 Jan 2026 09:25:40 -0800 (PST)
Date: Thu, 15 Jan 2026 17:24:48 +0000
In-Reply-To: <20260115172533.693652-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115172533.693652-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115172533.693652-4-kuniyu@google.com>
Subject: [PATCH v2 net 3/3] fou: Don't allow 0 for FOU_ATTR_IPPROTO.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

fou_udp_recv() has the same problem mentioned in the previous
patch.

If FOU_ATTR_IPPROTO is set to 0, skb is not freed by
fou_udp_recv() nor "resubmit"-ted in ip_protocol_deliver_rcu().

Let's forbid 0 for FOU_ATTR_IPPROTO.

Fixes: 23461551c0062 ("fou: Support for foo-over-udp RX path")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Updated ynl spec and generated fou_nl.c (Jakub)
---
 Documentation/netlink/specs/fou.yaml | 2 ++
 net/ipv4/fou_nl.c                    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 8e7974ec453f..331f1b342b3a 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -39,6 +39,8 @@ attribute-sets:
       -
         name: ipproto
         type: u8
+        checks:
+          min: 1
       -
         name: type
         type: u8
diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
index 7a99639204b1..309d5ba983d0 100644
--- a/net/ipv4/fou_nl.c
+++ b/net/ipv4/fou_nl.c
@@ -15,7 +15,7 @@
 const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] = {
 	[FOU_ATTR_PORT] = { .type = NLA_BE16, },
 	[FOU_ATTR_AF] = { .type = NLA_U8, },
-	[FOU_ATTR_IPPROTO] = { .type = NLA_U8, },
+	[FOU_ATTR_IPPROTO] = NLA_POLICY_MIN(NLA_U8, 1),
 	[FOU_ATTR_TYPE] = { .type = NLA_U8, },
 	[FOU_ATTR_REMCSUM_NOPARTIAL] = { .type = NLA_FLAG, },
 	[FOU_ATTR_LOCAL_V4] = { .type = NLA_U32, },
-- 
2.52.0.457.g6b5491de43-goog


