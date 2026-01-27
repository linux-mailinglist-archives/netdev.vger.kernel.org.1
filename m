Return-Path: <netdev+bounces-253673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCI6KlQveGn5ogEAu9opvQ
	(envelope-from <netdev+bounces-253673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:21:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F388F807
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ED91302EAAD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6062029E0F6;
	Tue, 27 Jan 2026 03:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3fZQrA4T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045FA1A9FB4
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484112; cv=none; b=NHnSLCDlCEq9PhP/acksd8+BwQX5TRtxtYVi5dyqltCd3Z5S6EB+UzmBx81npxiGcmlnVcyB6UJE5s45vw+8WUeAWENW0agRqBtsYUebNcpAcVXgvDUO3WziICisF/AVGQsQ+27zbnLxkqx/NCFuTGNr8Rk8Rf3Orv4rnR4jD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484112; c=relaxed/simple;
	bh=tJ02h+dGqmyHu9oUCGjLXqJDppsAP4Tr27xhs23D2oE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rN0EO4foCfCaLAAO50G8bMjD8gNSaapZ1aCGmX/fj2gii6Az6g9e9rTJCBVwbuMcZvyyzt662joPBE+ovRHN3lSXTtzZVTSkSCGHVrDSGdmHDFsPW9CVrgBMP6CQpIzVZF45I1dLSeMR4YM6AUHHiygwl4abActjwT3s2zhK3ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3fZQrA4T; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5014936958cso195547071cf.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769484110; x=1770088910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ko+9Xt6i6JXDRryf+QK8PevbLhauQay0Me1917kFTYE=;
        b=3fZQrA4TS3ad9rSWQFnTo1qtHPAZTnMVGTlevUXpPahqqnCa6Soct6+Eo62GBYOVYA
         K5piWSuaa34X+AdXlxkPKa7TBEJtIY35VBYGOyXxZp9tDWLc+A2eb259jdKHbjSInG6W
         AROiDDR20fGwNyIM5RO7viJB0xeRP/kk9uqf7N6DNe1YVOSF0UbMyKbR4mEFgMkUVQz3
         uWTQ0QW4ky/SlRgkJ11eob8p961l3vBsnJf9t0iISssiwpGYGnUryx2y0j8GN1Zaq4cD
         O1+/KzSgAZ+yKlQ9BjIu3kTgCDcKS+TilgMrAIuFI4SyjNAtmv7kRQjFQv85KjhSX3E1
         9Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484110; x=1770088910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ko+9Xt6i6JXDRryf+QK8PevbLhauQay0Me1917kFTYE=;
        b=hrBaigjw+iodYy3OV1Aj81zH+2rqr3Plg809uqtUREy3/AkJa9nQM/Rn8lHcXNejgp
         KwYwDc007sjWdbfXY9lkvLEPNG2GJpBhekAYGAhBQO02wibOTi3ig9APidVTeVz8VEJA
         JwncM5fCavyhKZzitH51tLEQLHVm2a1I5e8TCHtDMQ5AXm0OUq7IXi+aQIvANG8PArn9
         74gP+wEGA+qwZIIEztXugNhD5DvBOwtY/T2uMX13YuiTjNsBwtometTGPrfbFvT/haRy
         lbFcCMannGSaZh4PQ542CUS1sXHC7fHSZhuYuGE/tJ5lKIdTiciPe4USlLlcXnTUOMYk
         vI7g==
X-Forwarded-Encrypted: i=1; AJvYcCVRazncrQebDWvRGwco+NEAUodEXGuAneddAzoJFPN0W5lrjIHcFK41h7eTnX4gGnCD/athfcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rq6tXu0okHoW3+mtiFdLk4UcdNkOS3VFLiyxzpdpmn2TMzYA
	z5tHVY/8fZgZC2Lqv8yVJCIuxHbnn5IieIU4mMeBrbUMdhsY2RaSo8Ay5QWYv0QMoymV5h6jIEc
	hzU+tDL+O7WdzcA==
X-Received: from qvvv11.prod.google.com ([2002:a05:6214:808b:b0:894:9492:81a7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d46:0:b0:4f1:ca82:f1e8 with SMTP id d75a77b69052e-5032f770435mr3604681cf.7.1769484110090;
 Mon, 26 Jan 2026 19:21:50 -0800 (PST)
Date: Tue, 27 Jan 2026 03:21:45 +0000
In-Reply-To: <20260127032147.3498272-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127032147.3498272-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127032147.3498272-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] tcp: mark tcp_process_tlp_ack() as unlikely
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253673-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28F388F807
X-Rspamd-Action: no action

It is unlikely we have to call tcp_process_tlp_ack().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9e91ddbc6253..f2fafba95705 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4283,7 +4283,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_in_ack_event(sk, flag);
 
-	if (tp->tlp_high_seq)
+	if (unlikely(tp->tlp_high_seq))
 		tcp_process_tlp_ack(sk, ack, flag);
 
 	if (tcp_ack_is_dubious(sk, flag)) {
@@ -4333,7 +4333,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	 */
 	tcp_ack_probe(sk);
 
-	if (tp->tlp_high_seq)
+	if (unlikely(tp->tlp_high_seq))
 		tcp_process_tlp_ack(sk, ack, flag);
 	return 1;
 
-- 
2.53.0.rc1.217.geba53bf80e-goog


