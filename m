Return-Path: <netdev+bounces-258778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNjsCrjakWlpnQEAu9opvQ
	(envelope-from <netdev+bounces-258778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:39:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E013EE21
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AD49302D5CE
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0D12D46A1;
	Sun, 15 Feb 2026 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2rbX+xIn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D425A2ED860
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771166314; cv=none; b=QiX+rDvwr2U4pSaK37L9uVTBD7RzbnY79kpELpTAgFBtJWpMdM3YBmkq3Y1ViZ9P/5XT0aHMLzI+4WW+mqj94clW9Wnb6SrmesBaX/LKIjcISUrs8kbdpEyeBjnqoub1c+GnMIr/udXF4kNTXC3xsVbpNMJQQqri9T7g5Ns8ohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771166314; c=relaxed/simple;
	bh=GdqTMQL0mNlodXXcZDRZpZ14HaClJhGxiixjljB5/Ck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GYc6WpG2iCezqv/JLnuHxtudedW/ncQ3UXvVpE78neP4ldupouAQaDVylNW+zOEe/srLz8g0/Oy3DBx7k56UQUcVOsw5PfLFdwxmstqhmA3dhqnra7+gHWaoeLB+4MS89jd2PsUe0q7pbDSUX23BjZb9PXeudqoR0IF9rgeohTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2rbX+xIn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-797aaae28bcso22328017b3.0
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 06:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771166313; x=1771771113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzKcSQRfZDsqkkVdX+AvR+JZwOL6I3dAJ1Fd7HyeG50=;
        b=2rbX+xInr78cZeruuFk1DiTWt4kZ9g/VOkLU+YPakF74FZp0Lahsq+eDu0LTkf731a
         X8GS7DSgNPAHgsfN6fPkEz6u5ZTnHo/OSMgTx5p1k7Mh+VQu9HPsudr69tY1nfIdSHKB
         uaJwiI5bCi1YiYwUR+/g3KEr/fWQRabMxf5YegKmc0U6wJfBMPaB3pZnCjGPjpDORjKH
         hK7z5QTdioVIdcyKqmkoftKFuupMaEMObewAdBOO2JCBMWPd5CaCKKP4QMrNZEG2evIL
         FGgsCjKhAZ97gznxq4IoRrUEaad0uXhTxA9Ucw2zIyPmDA1RcFGhHdZfRFSCuToox7vS
         U38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771166313; x=1771771113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzKcSQRfZDsqkkVdX+AvR+JZwOL6I3dAJ1Fd7HyeG50=;
        b=MoCBMXPN1c90YLTKdF5cMc6M27uY/8rgKSg+zleNzmgc6cm4MpANk8oO1+/PMg7QyA
         jbidWVl+Xu4rAUHfIAaBQ7+YiGbX1fxB8jUMNjgvcZkqceqgneyFrLOCA89RtCPj6IVH
         i8CJJlMFndsdzbjSaqTGw5mL/mNE2T2joZF58zkxaXTcxstQEzocsl/d3mLkcL0lfnT2
         1ImG4uvEba4VizSmvUSzQyLtgPl38kaItTubOSvoJwMBcUZORwm8UkDWJb+CJaN5xpNl
         7oqL5xf6DW60z61wOCbEnsjZl4RZ4KWSKWCBCt0Ke0Y98cZgusx2e9HjKIyDSTvfvxzJ
         LWjg==
X-Forwarded-Encrypted: i=1; AJvYcCV6B99ONJYGRbUj7mk4VyWCFax3vZK0JrGUt7qjvkuNesBJI5Giu9p4Y0+CsJGeiSd8gFMBw5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1dkrjtu6HqXcHQE/PP6eLxE1EvyVvBzpyB4quq11u1i3KPmr
	e5bK2j2OT0Gm49aUNpMeSGxs1F4JDGw/TDXIl5c0phEvo2rQaFWPdrHFYgFkmrsWcfKK5xIiObq
	lsr/cGTnr3/4QzA==
X-Received: from ywb4.prod.google.com ([2002:a05:690c:9504:b0:796:2f94:5c11])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:c4f9:b0:797:be09:5dac with SMTP id 00721157ae682-797be095df6mr18609687b3.8.1771166312563;
 Sun, 15 Feb 2026 06:38:32 -0800 (PST)
Date: Sun, 15 Feb 2026 14:38:21 +0000
In-Reply-To: <20260215143821.2330791-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215143821.2330791-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215143821.2330791-6-edumazet@google.com>
Subject: [PATCH net 5/5] ipv6: icmp: icmpv6_xrlim_allow() optimization if
 net.ipv4.icmp_ratelimit is zero
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258778-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 915E013EE21
X-Rspamd-Action: no action

If net.ipv6.icmp.ratelimit is zero we do not have to call
inet_getpeer_v6() and inet_peer_xrlim_allow().

Both can be very expensive under DDOS.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/icmp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 0f41ca6f3d83e86ce97ce5a30613f58f4dc22dad..813d2e9edb8bed7c1649e279cea9229806af4132 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -220,8 +220,12 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 		int tmo = READ_ONCE(net->ipv6.sysctl.icmpv6_time);
 		struct inet_peer *peer;
 
-		peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr);
-		res = inet_peer_xrlim_allow(peer, tmo);
+		if (!tmo) {
+			res = true;
+		} else {
+			peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr);
+			res = inet_peer_xrlim_allow(peer, tmo);
+		}
 	}
 	rcu_read_unlock();
 	if (!res)
-- 
2.53.0.310.g728cabbaf7-goog


