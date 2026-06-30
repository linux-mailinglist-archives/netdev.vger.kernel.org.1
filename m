Return-Path: <netdev+bounces-303001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iK3gOfhqQ2qUYAoAu9opvQ
	(envelope-from <netdev+bounces-303001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:06:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDD26E0F79
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:06:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="gRrZq/MJ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303001-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303001-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CDF23011789
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA54395AC3;
	Tue, 30 Jun 2026 07:06:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C8026B742
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 07:06:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803190; cv=none; b=BFzGdviQom+AEEd55Vw5Qz/4pgICdy6b8WaG5iy7TaFh4nfiKOstG262bPTmeCKVfp2jvtE8Mtv2xNSm8i8rFfbnKZwNUTBhFwHTCzVotDwAUHClzVTPUv7iYhGa39xIM4Kwty3eLvfqQUZVRZRNsEB9sEmbYy9ZX5RS8byj5Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803190; c=relaxed/simple;
	bh=/2/1eUa4XIeTTgJvUZXFmPJWF0OERDMdVOsdvtYn2Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raVQKRwkRsHOO/W5Bv+kwj3Xi5PFs/UJxZVEI4yRaqTpnBug7SzcmZLWKGdpMVL+ylXIT/mZ7J4yoLzTEuERQswS3zGhjWMhuLkSfrqp7vK6IhsWlR4Ykb/+/f7u/etBCB/6yXKu0OB8CwqmCX+CHiLsSXj46r78JveIT6dvhEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRrZq/MJ; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-846970f0acaso1603915b3a.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 00:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782803188; x=1783407988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWjLqORHci9olVWPKhnodoR/H+h7JsSR8ZTGlVJEUwQ=;
        b=gRrZq/MJtZhdM6qV/wS2zn3TwV6bjGNSep69CeZxryFScOIXPPUt+4T0vleEqhHh2S
         WcF4P+CJUVEe+T+kZZ/3kdly3p8DM17CPFv2v3PUYQNfc0SGnZt+tkdlN8vMNYnRidWb
         qfSOR9oUR/hq0CTAsLBu4sgSk0KKSKlvm1HTfzOuv5K9kVP0jPCNcMGXAmc3WYfa0qK+
         Wmn5ItpVQbrtFGfRQ3hJCVm2Y8Cy3G/yol+w/+jYPIdVp84lxKIRyeA1SPw/c0UeHqde
         onzzB2SSPovaQe1xECLweBjmY8Ee5gOFT7BuaR0sHv3qMXdTRZB4gDjrwn+nSGBRZ3UL
         0T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782803188; x=1783407988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWjLqORHci9olVWPKhnodoR/H+h7JsSR8ZTGlVJEUwQ=;
        b=HO18DBp1ShooXtoR3nKnVOTNra7Panc5en1F0642LkejVtTkbEcNYVUpjdfm7ZlLwz
         b/lcw/mLR09DYo8U40SDK1WOjB+r6efHR9Mjk7JbvzxbISDnRobQJPaksqGmi5Gs0j9G
         wC3GUWePt19YjTVetYpUTqrG21INYDmrxH///ItfMailgmll9VDkL/UF/bersbG1Cg8S
         t4rn6ikoc56qPAPgd7q2tz3XnHv2WTPoSIYBryEMczdP6+kHkss6jcqMmSs0C/aFI8y8
         cH2qVuk4bRgLwj86Re5EUsen8GbHengozfOdP3GPaRfLN9+Y/V3yJjLkjQszwEUCLsC9
         16vw==
X-Forwarded-Encrypted: i=1; AHgh+RoGYhuKZr4TRw89Oa4LqDg9wwV5tucpFMgamAoNuVquMNpNQzWAhBd8zDZS6yG959cQGKAogpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66oY+KWyi67hOLbq0W94jIOFkRqtsH8FQrLbceEl7vEZGEz63
	SX78s6GKcizp0O/bBJj6yjdYQkUk5k46nxKM2Kwsf6yiZtmW13ms1AzD
X-Gm-Gg: AfdE7clyv4iuW+9Z6eStDcREHndrMAM/Cw93qc+JPwLrEF+kN5APMlAsTjrTlklgnGV
	tx0lDonjwXQVsKc56UlKStDXyljiVWwXFPvYp7glJ4Jm0jQ3iqGAQm9LCJn/qYfQg7IwY/MNmNg
	vc7tIKhFOvjrlCN8DF/k89YtyyVTFThPlmrWRBBafvTnpOH7lpMFe4p8zSwKwDTNpX36HWf7KbT
	vuiK5upF4lY95Uk5GD1Glrzyr2SNmvP7AXiUFwIQMVHITAbuEo+xmMk1FlDByFCo2VpjUmNaYnO
	4V2RGzE8MKpgxgejflR8a/znTBm7CNcy47+lZjEvqp0YJtATeTpigS0LdfcMLsYrvj6ZxorO2/v
	XOaxwGnfmLPiSK06LlmDoSoailV3lQPXYxZ6bd8i8GijX85ma7NdxdxdBC7/V6QQBcp4X2cDpa/
	ftoEYaRtnazY3FgkctXeS42J+UwX6kQAhZH+OkGPaD97xXv+dj9hNry+9tbL4g8pqroWiO
X-Received: by 2002:a05:6a00:194d:b0:837:e9cc:d474 with SMTP id d2e1a72fcca58-8479efe8fe9mr2186537b3a.2.1782803187889;
        Tue, 30 Jun 2026 00:06:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:da8:8001:864:a421:5bd5:31d3:9cdc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479fffa4f0sm1263525b3a.19.2026.06.30.00.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:06:27 -0700 (PDT)
From: Yiming Qian <yimingqian591@gmail.com>
To: security@kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lingchen5202005@gmail.com,
	yimingqian591@gmail.com
Subject: [PATCH] af_unix: mark MSG_SPLICE_PAGES frags shared
Date: Tue, 30 Jun 2026 15:05:56 +0800
Message-ID: <20260630070600.484-1-yimingqian591@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303001-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:security@kernel.org,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lingchen5202005@gmail.com,m:yimingqian591@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yimingqian591@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yimingqian591@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DDD26E0F79

unix_stream_sendmsg() splices external pages directly into skb frags when
MSG_SPLICE_PAGES is set, but it does not propagate SKBFL_SHARED_FRAG
afterward.

That leaves later writers without the shared-frag marker even though the
skb still references externally owned pages.

Set the marker after a successful skb_splice_from_iter() call.

Fixes: a0dbf5f818f90 ("af_unix: Support MSG_SPLICE_PAGES")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Can Liu <lingchen5202005@gmail.com>
Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Can Liu <lingchen5202005@gmail.com>
---
 net/unix/af_unix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a1..f2cd0f8ec0914 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2458,6 +2458,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 				goto out_free;
 
 			size = err;
+			skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 			refcount_add(size, &sk->sk_wmem_alloc);
 		} else {
 			skb_put(skb, size - data_len);
-- 
2.34.1

