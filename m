Return-Path: <netdev+bounces-251531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDTuJbHAb2kOMQAAu9opvQ
	(envelope-from <netdev+bounces-251531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:51:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C78748DFF
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53C7564D394
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA82314A8D;
	Tue, 20 Jan 2026 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="nrfN+00U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB0314B91
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924667; cv=none; b=M4giGKIWHSOhzrLHe9LBDxjyXY/Qq5q5bGxZVewWbXYeKb1uBsFt4mfqeW0y3VlAuXQE5Yiq31Q441ruYhJNAelkXebWEeZHbB3IwOxECtrNxK4qCUlB+UpbaxUTXvAh3KMVvDD9VnvZyWvgPXcGvpQ3sf9r66Xoq2X32K96n/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924667; c=relaxed/simple;
	bh=Q3jZ8i1dgm0geWGcKYEDkz4Xcu60RW+VP7vWspRvnrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUNt3txwqpNKg42fIT35KS4H34UvVwh2jS8bjHd5Bi4yWxJUb2wSfpHI8KkhcYqmcxUEHwijbWl39s5MQ6ykYN3y2tjM0DcJlRBcwkjnZ6sZ82uqkRvVSk6jfWy6mp31l0wE1yFUzj4YeffrHxiltf581jO0Q0ccJxp7zvRYLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=nrfN+00U; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so1573380eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 07:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1768924665; x=1769529465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDVOTSHO4BkrVaUL+NxqaqqJd2byL2pEcox/3hMBRE4=;
        b=nrfN+00UY2zNwGDx33+KZED2uJIg1L3BpduYerqLj0haL22AyRgV1pul5wRXR7P1w7
         d7UtmO9iWXPGcNCr6clQt8aNfOsA2N7FlTc3NIaDBeWLUeubWXrqpfppCeeldZOBO306
         jgYHNz13+2trpQCfKlDdL4+IJ0caDCa4OW1aITUIftHZ9QLEzu2gZ1LQr5ZKWYY2UBsd
         KYSYpjZKIywDiIGxpuxt9z20a2wO99JXqEsPxAsCaEZWm+OUd7gckz9pJyFuPRaDF0rU
         GCCI6CWuhv515R86U5kE6Z4uBGKdTnyOydLTQWYnCCrvTqOUG5RWgSn0nSlWZ9iF5BnL
         3Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924665; x=1769529465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CDVOTSHO4BkrVaUL+NxqaqqJd2byL2pEcox/3hMBRE4=;
        b=rAVvKGBqGCGS9NwV0zV3nFoYdFmjA8E01G+BeZW+ikm6+fepsmDm6OiopbaRs8gYZL
         kT8yu8zMxAm7KGJmopuM6e01JEjdg4uYbwKCozOw9IUIVm6234XBBzBIoIItRNzVRpdh
         2UIzj28/xjJ9W2XWgGn37FkhfWHGBnJ2gKUmvZ0ww7gV7kCgQIHKeoaZRBqIY0/yZwvY
         qjbzp9YAwEA7qQL4prORDtRw3W8OGuaHn9TF1W9IfSv24QZy2PNXLVZXXe9ZZzvFO4Q6
         FHiE6Oj4P2XelaVmJgZS8tNLset0j+/IUyliVyUlAtKbVR6v/2voCb1ZGPh03yD6dlBn
         1p8g==
X-Forwarded-Encrypted: i=1; AJvYcCVanxPSdgosbFnEn1A1o2VEIgZqjGolmXK29eKsfC7oxKTisZFvujPnwmy7QbnDF4VJ1iaDaJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM2tRghl0F9lqGUaEZKo40Bs0FwkLfbtYUb4tNhB7UoWEnMLCU
	VBcmXGuizXU0+xJG/tEWz1S5DCQTGjX7MFgB7qOSWaSy2jwmIlP3i4Uij+C23JBbMg==
X-Gm-Gg: AZuq6aIdEw3oCN+9xge4I/KIRLhmS4fU5Rvm9VzSd/8ZYBAjzepstIJX6DkohLQ5ygc
	uaiHBeiqbJvtJxR32ulxCPAB8UmSlKjSbZYz84OMC5BkNL9Rg+whWbM5t0eregkYljNpWMFWxDE
	gUtKVAooGqF7fe+56dl6+qK+uIpNPoP/VgpQoNaeiAnba5jIU0vJKOXUYCxIDV0y2ybZZ94MYwz
	jV9NmFrw239T84vTdnDW/qAqWW43wTbjTwGHBXLQUvtJT2NbdOwuXA8LaAySw33WoFDleilyscO
	PqQkpekE2C/PQjAIBM5oD5RtW5MzySCWKFx97C+egmTlAn/quTW/p6tuApYXfJRqSq5Za9yMTVF
	bvhkwIYOrmSvsFzHJihf5+IVSiTbl75E5zF7z+4+M1w1+PcYgVwEaS69mpfB/oTNaLMaS/VkDVp
	p5YLIsUKjQ+C7rg/GW5ssx1GXZnewAZqT2oY87p5Ph6PAP0B3/Pg==
X-Received: by 2002:a05:7300:6d15:b0:2b0:5609:a58c with SMTP id 5a478bee46e88-2b6b4119739mr13598652eec.32.1768924664652;
        Tue, 20 Jan 2026 07:57:44 -0800 (PST)
Received: from will-mint.dhcp.asu.edu (ip72-200-102-19.tc.ph.cox.net. [72.200.102.19])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2b6b36550dfsm17650283eec.25.2026.01.20.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:57:44 -0800 (PST)
From: Will Rosenberg <whrosenb@asu.edu>
To: 
Cc: Will Rosenberg <whrosenb@asu.edu>,
	Paul Moore <paul@paul-moore.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cipso: harden use of skb_cow() in cipso_v4_skbuff_setattr()
Date: Tue, 20 Jan 2026 08:57:38 -0700
Message-Id: <20260120155738.982771-1-whrosenb@asu.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHC9VhR4d7WXOVR7Y9ee2+=-t2nThzOo-ySMB+5x_87LfBJbZw@mail.gmail.com>
References: <CAHC9VhR4d7WXOVR7Y9ee2+=-t2nThzOo-ySMB+5x_87LfBJbZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251531-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[asu.edu,none];
	DKIM_TRACE(0.00)[asu.edu:+];
	FROM_NEQ_ENVFROM(0.00)[whrosenb@asu.edu,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,asu.edu:email,asu.edu:dkim,asu.edu:mid]
X-Rspamd-Queue-Id: 3C78748DFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If skb_cow() is passed a headroom <= -NET_SKB_PAD, it will trigger a
BUG. As a result, use cases should avoid calling with a headroom that
is negative to prevent triggering this issue.

This is the same code pattern fixed in Commit 58fc7342b529 ("ipv6:
BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()").

In cipso_v4_skbuff_setattr(), len_delta can become negative, leading to
a negative headroom passed to skb_cow(). However, the BUG is not
triggerable because the condition headroom <= -NET_SKB_PAD cannot be
satisfied due to limits on the IPv4 options header size.

Avoid potential problems in the future by only using skb_cow() to grow
the skb headroom.

Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
---

Notes:
    Given that IPv4 option length should not change,
    this may not be a worthwhile patch.
    
    Apologies in advance if this ends up being a waste
    of time.

 net/ipv4/cipso_ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 709021197e1c..32b951ebc0c2 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2196,7 +2196,8 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
 	/* if we don't ensure enough headroom we could panic on the skb_push()
 	 * call below so make sure we have enough, we are also "mangling" the
 	 * packet so we should probably do a copy-on-write call anyway */
-	ret_val = skb_cow(skb, skb_headroom(skb) + len_delta);
+	ret_val = skb_cow(skb,
+			  skb_headroom(skb) + (len_delta > 0 ? len_delta : 0));
 	if (ret_val < 0)
 		return ret_val;
 

base-commit: 58bae918d73e3b6cd57d1e39fcf7c75c7dd1a8fe
-- 
2.34.1


