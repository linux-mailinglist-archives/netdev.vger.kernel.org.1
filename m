Return-Path: <netdev+bounces-252965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLF2IurYc2lXzAAAu9opvQ
	(envelope-from <netdev+bounces-252965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:24:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E367A95C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2B74300E5FF
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B526F476;
	Fri, 23 Jan 2026 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/K+HMfQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF93E55A
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199844; cv=none; b=DD71+V/9zMECCHnooQmmSGr7gQiMgY/Tk4ChfeT4N0FRMTIUSmEOkZjVWd/fk5hVn+hwm26XreSlMzTpckV04+U0qXzrsPn3TZ5ghzx4La2HH+FKiXKlBxwQeu0PYwBYyXpK/zs30jq0LuwFo8HwRN9DapdQMInN6+5dyP+u8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199844; c=relaxed/simple;
	bh=a6ukDfiHiKi5XfccsBsdGT3goJVGQDGOaNtK1WCRH7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ky8bvahzJZnBPbFzVH6IvKGOcE2rKkSfqzzhdB5QFDglQn1SijDFajzFlJ2K3cBfPAr3wJsfUytH20UVeEJIT6MsUKknaQwpNwUJogYjRAWgiR6Vbi7Mnd4fOEGLP7Mwde7sLs8hHTpbvasE8uLDpn3yf+fzaYmRN8D9LrkpRac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/K+HMfQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81c72659e6bso2668129b3a.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769199842; x=1769804642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y/+MCAvn6zq49yLies7LM3lPpbdAqnm4aVigMaiLOu0=;
        b=V/K+HMfQGmwqeILt8BpalJC4oSp3ITAYCS8YKp/YBx5V91IflKJ7v+6vnyOS3f4moV
         jxt3GIE0zXQQaBj8juijK1MbCCBa9Nuu8eqJVR6O9dzn9iijwruE5fDKYpJnEC9lRPvu
         b4gSIuL7AeEcPp0/J9b7tbGroHmN4sH7Iq9SnyRD1PlqkTZIjRbfAbdlc7s6kwgiIBty
         jKcnnx4m4MV5UztsZTe3A31VvFZgSOCcmxi6EDDVUDoF3ROSKTNXEXG38NyN/BYgIRDi
         VoadTjSrDsg6w2ECUEaNFL3Umk0GmSGVqS3XOnpNs6dED5eu+gjzWa6OoSBNUbc461K4
         0Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769199842; x=1769804642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/+MCAvn6zq49yLies7LM3lPpbdAqnm4aVigMaiLOu0=;
        b=gYlvAbH1EEQ68Q8OElOHB751u1eMTZBDXrEWbS6xkZWeGmCB2uwHih3JEGV7yXVhQB
         AAClA2pN8a080pLEIgRUBavFd9aXHLieaFy3vgnvuPLr3dkVoMDkx6VQL/760jpVIqLm
         otT8twqgaI4y5QfWKFqZJrYFEGyu0LZd9DXCn12uY5DbH+LXQPF44JsC9SdMVNkZNZQQ
         gqKabYxE/ts0AOfl6o+fHgGmFWTpWBKlV1bSLd6d3tEbXSPQg+PZrYHHH15FnWwhF51J
         b0OCiJEPKDjOBflk1oVroekbG5rUdWJpJvDDHfBHPXKFhS8ea1gsiECG63BjbtKdeLNH
         tHNA==
X-Forwarded-Encrypted: i=1; AJvYcCUJQND5Z7j3wL51SRtQvsJlxNop6mZvFieiqkE0IJXDW3M7xpjvTIEhH/33f668D38y/qTEXH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytKR2Xt3OtPR4idOQ33KGwkiXGpoHl59GK4WWUYhW5RkZhb8xx
	wg962+uRX2SaFOmZd+dYhrUs72yVJ9AgGBOJdsQSondx8r9b19CbUJo=
X-Gm-Gg: AZuq6aL6iYV8X+ii/EaEr07Vli6VTBImxtI4geg8l+VD75+jHsMWGtUC2x1grHhl0UU
	CL0Opqz6oXZz6zDb+B12hHe8srOjbk06o2suEBarIml0eZ2lrpmrd5hUw+gV3AbxNulQZT/X/G4
	wnYFul4rLGWX/9ZfVJSTXUFIjQalgwMevLyoy5sorpkvA5LqR2aOke0fruISIg3XXwTCNmLzuZG
	rotiaMX15cWxGSbTvUvJDT8NgSJaHhmRox9M2vrQGV9mE4anYwRVLUvld0Pv151HgvQCcoKSpVU
	4pwEIE8ACrytaqPCTGdYOZJeR1dOm//uwrXn9zmKQD124nI7ysP9Sq1spH3V/qai2Z4fPu3jOl7
	DhEE3HH8JKSiotL7ZTWsMiNTyT1GASkcHtSVRmhlStNycv/M3UScY20CvUrYHUKNZhikxXbrxow
	qlpIsIkRwlAWssYyM=
X-Received: by 2002:a05:6a00:419a:b0:81f:de60:39b0 with SMTP id d2e1a72fcca58-82317d956f8mr3031318b3a.13.1769199841993;
        Fri, 23 Jan 2026 12:24:01 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([38.76.140.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231866b92csm2889233b3a.25.2026.01.23.12.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:24:01 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mingo@kernel.org,
	tglx@kernel.org,
	acme@mandriva.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] llc: fix resource exhaustion in llc_conn_handler()
Date: Sat, 24 Jan 2026 04:22:11 +0800
Message-ID: <20260123202211.2082-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,mandriva.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252965-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qikeyu2017@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 28E367A95C
X-Rspamd-Action: no action

llc_conn_handler() does not check the accept queue limit before
creating a new socket for incoming connections. This allows an
attacker to send a large number of SABME PDUs to exhaust system
memory by creating unlimited sockets.

The issue is similar to the TCP SYN flood problem, but LLC lacks
the protection mechanisms that TCP has (like SYN cookies and
accept queue limits).

Add sk_acceptq_is_full() check before creating new socket and
call sk_acceptq_added() after successful socket creation to
properly track the accept queue length. This ensures that the
backlog limit set by listen() is respected.

Fixes: d389424e00f90 ("[LLC]: Fix the accept path")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 net/llc/llc_conn.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 5c0ac243b248..9296b5d6b04a 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -802,10 +802,15 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * in the newly created struct sock private area. -acme
 	 */
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
-							      &saddr, &daddr);
+		struct sock *newsk;
+
+		if (sk_acceptq_is_full(sk))
+			goto drop_unlock;
+		newsk = llc_create_incoming_sock(sk, skb->dev,
+						 &saddr, &daddr);
 		if (!newsk)
 			goto drop_unlock;
+		sk_acceptq_added(sk);
 		skb_set_owner_r(skb, newsk);
 	} else {
 		/*
-- 
2.34.1


