Return-Path: <netdev+bounces-291259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJtLAPwJFGrVJAcAu9opvQ
	(envelope-from <netdev+bounces-291259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:36:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741485C7D56
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B34E3301A7E9
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 08:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3FB3E317D;
	Mon, 25 May 2026 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWCtNkXj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66733E3148
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698148; cv=none; b=QvsuLZxkHku9Y52qGk0tdGxhOBlkDHrr3j28vP80HuiXcqYLoWNqvXnMY2q88oFCqle9Ahfm+eDlhtUHlcoZOb3wgM+jNr9euWAP3TtWS1oyMmLsPiu8dr9FuGcgLh0Erd78SBfcc45CO7fWgOBEDkjlJCnG1VE8+KpYPWUMOxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698148; c=relaxed/simple;
	bh=lxrDq+Hf0n3HqjB+26ew77FKM8HYDVY+yUOVL/3P/Bc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YINdobFSbgstNvIw15WPWQeTctk/l8HCMWVXgpghGdUpicGDeMOJw0YNDEtBfu7lnLbjxx9YnIOkF5Gy6qBL8g4daAdtByJQCjU0A0VxBr0qx2tRmOp4xkRLweE7UWT/8QnyGw+A0fMkM6Ac45jIG2Cbz+6d20ip+w3SBld93zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWCtNkXj; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-515224a8aa0so23917121cf.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779698146; x=1780302946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6j8U06xs5iFtU3uPKRjpBuYNR58bnozin1yjuUkI0SQ=;
        b=tWCtNkXjbO/dXsi1dDUoRoEHqt454Qjc4bNWU7TSTmtcBdEtC8UJp4UV7h03QY6+8k
         dXJXDZ7KiBMF0DJjDO7xcby1ykNz+hwe0dg0/7Jv6Hf0dhxeWLzboG2MkThrjUBSLGy4
         vihBZWyH4NP3cg0ZBWhUz+Vhd6zff8uTSr76mahNgnb2E+5JwY/ZfSvbDm4ejC1Dtron
         Cu/xzPs7rrAR3uS2hhNVARPHpjFRIm0MGIarCdRcLpGaKLY/96ITYRFUIKf/8KTnhcQD
         E/NpWiYAc9rbyMTlo3TaTrceB7wzRjTMbkJTtZUo80qLHjI0EK7caKp+N07rCVdChOoE
         w1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698146; x=1780302946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6j8U06xs5iFtU3uPKRjpBuYNR58bnozin1yjuUkI0SQ=;
        b=RWD2yIQKHdGnqWQUceJ7hf8YwqplBUmJUe5x/b7oWqoxwjqqC34rnuG38FNZNp3kw/
         af6g6/9MG18NM+rqQM6q2LFFsgqi27VRfxdUveua2Lo+LnpdYXiwmvSbzrP9rIX0/rl+
         jSzT8kolAvbcTAXIuHqBRlz8i9PrV+GCR9coUTNcLJ7J2Mx1KQsl7Mom3QDs4/eSjCM5
         KPfySpuDxtl3aHmnxDGAn7AGodnJuvv+fRxjTmxuKY6JlUo3T1zPGXEOX6LBYLoBPCZN
         dd1JRWEmjACG7JD4teGxAf6oYqZMv0nNsriLaSnt7FcKrzRfetLMvhS7E5ThEI23XbXB
         bdKg==
X-Forwarded-Encrypted: i=1; AFNElJ86BpYJsgamBr00RiAcaRyhueY+WsCjJslDmf1+kme7u/UFbeynSlQsN322BDfNzn9pVpI1CTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFqAe7+bH4vwKPoH7HRTMHL4WOQ8CPXmskJsRheJX0tZrRuFmf
	RwyCj6FnqF1EoHcfg1rmVHCBYlFp1M7h9WxCGx8TzuY7PLqDlPVzEyDkwAAvKQaTatmwHlMZhbX
	0WaS2XkDCfoGByA==
X-Received: from qts16.prod.google.com ([2002:a05:622a:a910:b0:50e:28db:352])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:a9c8:20b0:50e:635b:5579 with SMTP id d75a77b69052e-516d42e5bf5mr150003071cf.19.1779698145556;
 Mon, 25 May 2026 01:35:45 -0700 (PDT)
Date: Mon, 25 May 2026 08:35:38 +0000
In-Reply-To: <20260525083542.1565964-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525083542.1565964-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525083542.1565964-2-edumazet@google.com>
Subject: [PATCH v5 net-next 1/5] rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291259-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.950];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 741485C7D56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Avoid corrupting a netlink message and confuse user space in the
very unlikely case rtnl_fill_prop_list was able to produce a very big
nested element.

This is extremely unlikely, because rtnl_prop_list_size()
provisions nla_total_size(ALTIFNAMSIZ) per altname.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 0aa429336ffe1015390be634fc4bacbbb9842a50..cd1004410dd7f5c45ebfdc329b461dde7b1d9411 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1970,7 +1970,10 @@ static int rtnl_fill_prop_list(struct sk_buff *skb,
 	if (ret <= 0)
 		goto nest_cancel;
 
-	nla_nest_end(skb, prop_list);
+	ret = -EMSGSIZE;
+	if (nla_nest_end_safe(skb, prop_list) < 0)
+		goto nest_cancel;
+
 	return 0;
 
 nest_cancel:
-- 
2.54.0.746.g67dd491aae-goog


