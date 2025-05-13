Return-Path: <netdev+bounces-190246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8467DAB5D40
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CD186079A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898932BFC8C;
	Tue, 13 May 2025 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAApWayl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED19D2C0861
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165178; cv=none; b=PAb5xXeROfCuV33BjaL0eLXmX+4Y0RYER1IrmmBpkb36WzxhhYcPFObZFmRu0NF1brfsChCFtjdjN2kZjiQEl7oWcWfmha9qfe68sHBa/cCdDMd6XetbDt/4STqoBYgNur2nQSDOf28NgT3r44GsVyGNydQn801Rf9UHQBLDYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165178; c=relaxed/simple;
	bh=mhF0lSQ3mS3Vd3/yLNo87voaHxlO5rmsPUmJ+wk/MW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bqyW63vpcX33LSt6eUvmtcxdlEa5yXd/6Zgej6AetKzwBvO3ZhNQPU1OaSEmzY9sIRquLGj/JvDZcnTRGsOH/48uHDf204uxOl6HTatCg4U6bKcJLUO0q8elk4R8tfXstbBi+2pP9FeSEYE0ijlJXJzG6kRX57wh5M7IzkooD5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAApWayl; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c54a6b0c70so522510085a.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747165176; x=1747769976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8vjCFpFOwA5accoFhuhaGlxoIzJ2pEpLjFwgAal2W70=;
        b=bAApWaylzt1+0oJU3tvGmPJ3n4IO8pK9uTzaNY1h/Knwkk19R4Oh7QRVzr10P0RUPz
         l2xEyZN4g83liLlWILg8PPn0kJBTrGILnnXWFys+m6Z8JU7OIQkEhS58YAP+RljF26dP
         m07gaCRnRaQ+1e5duZGjGyT/Nfvxz4Y6Nes9K0lPCDju65ooVVO3ShkYj09m81Nfp4SR
         esksZu8dE9H3WZbVeT1L9L0faZ3Yl04zaqnhcus5OFyLPTPDXsLIpTXqJND1arIJ0FXr
         FrZbNMTFZ17+a0zKNg/nxvPvQOkTqCIbXv12sHgKDPJIdG2pUKb2Q3KBmuyADC8znkiL
         8MVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165176; x=1747769976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vjCFpFOwA5accoFhuhaGlxoIzJ2pEpLjFwgAal2W70=;
        b=YpFUU15xE7NqE2zlGlaIODKkIlv9iRP09PzJx2NYZt6PYXgATA/b3NwS3qhrn118Tn
         TC3md77HDOplvT552c1btfvhwZ3LOz+QET0VWWjMnKkcBTnHHLlxItzDae1MulRpjqjU
         qxsoYLCvWejMWVswt2yBwpLYoYK3wKU5U3YrFURHHNYT4m1A6ybpaqpRB+OTuphl6KOD
         6axd0ESLj3zbo+3iKcEYSjPfoFEY9Ky0p1b2lGMCoiAjGHNmMOIpNJUtKOrZRoMGwSkN
         JixpWMf8z22CiBRmxFfVhYXK1+kG9XWg+6zyqDDABssgNtB69fnR6KylxCKCey0fG31f
         63WA==
X-Forwarded-Encrypted: i=1; AJvYcCUyrIULq7kaTsn0NTtLLLjzi6A3aC81o8VLBfu8oW4jcrG26tCsnjPQl8Bb5JsS3bWKj/bO8/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgPBtVm1+xec9PCXON3VNbPRRJ62s2Zn8Q5ZCLyBTPILkckUJc
	3/fAbSacKYK613aEiH4WAF+77H5lt2IaENpr7a3pvSrgQSbn9H+QW+nrs+gpgcQQVn7v6zAIogR
	9xtUrytX39g==
X-Google-Smtp-Source: AGHT+IHsdJ/fQ/WhAKKjIZtNvicAvH79mryTame6k6pfjqlCzp24qfvZFTazAvQ2VsrMSiie4XYy/VwJHZi1qg==
X-Received: from qvboo13.prod.google.com ([2002:a05:6214:450d:b0:6f5:3eda:f268])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3009:b0:6e8:f5db:d78d with SMTP id 6a1803df08f44-6f896e35f47mr12498276d6.23.1747165175922;
 Tue, 13 May 2025 12:39:35 -0700 (PDT)
Date: Tue, 13 May 2025 19:39:17 +0000
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513193919.1089692-10-edumazet@google.com>
Subject: [PATCH net-next 09/11] tcp: increase tcp_limit_output_bytes default
 value to 4MB
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Last change happened in 2018 with commit c73e5807e4f6
("tcp: tsq: no longer use limit_output_bytes for paced flows")

Modern NIC speeds got a 4x increase since then.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/ip-sysctl.rst | 2 +-
 net/ipv4/tcp_ipv4.c                    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index b43222ee57cf9e54e38cb78f752f050c2f43a5cf..91b7d0a1c7fd884ee964d5be0d4dbd10ce040f76 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1099,7 +1099,7 @@ tcp_limit_output_bytes - INTEGER
 	limits the number of bytes on qdisc or device to reduce artificial
 	RTT/cwnd and reduce bufferbloat.
 
-	Default: 1048576 (16 * 65536)
+	Default: 4194304 (4 MB)
 
 tcp_challenge_ack_limit - INTEGER
 	Limits number of Challenge ACK sent per second, as recommended
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d5b5c32115d2ef84b0c91d43f584e571f342d9fb..6a14f9e6fef645511be5738e0ead22e168fb20b2 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3495,8 +3495,8 @@ static int __net_init tcp_sk_init(struct net *net)
 	 * which are too large can cause TCP streams to be bursty.
 	 */
 	net->ipv4.sysctl_tcp_tso_win_divisor = 3;
-	/* Default TSQ limit of 16 TSO segments */
-	net->ipv4.sysctl_tcp_limit_output_bytes = 16 * 65536;
+	/* Default TSQ limit of 4 MB */
+	net->ipv4.sysctl_tcp_limit_output_bytes = 4 << 20;
 
 	/* rfc5961 challenge ack rate limiting, per net-ns, disabled by default. */
 	net->ipv4.sysctl_tcp_challenge_ack_limit = INT_MAX;
-- 
2.49.0.1045.g170613ef41-goog


