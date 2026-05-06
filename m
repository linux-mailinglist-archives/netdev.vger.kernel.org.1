Return-Path: <netdev+bounces-284724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AICuFzzo+mlIUAMAu9opvQ
	(envelope-from <netdev+bounces-284724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:05:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F634D6FAE
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DF8E3013A6B
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 07:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C3F36AB5E;
	Wed,  6 May 2026 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5NkPFxF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C036A008
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051087; cv=none; b=cYgVqJWakleT/7s+k2Nf+4fssIxYXEPIbjWt8XAzaN8OVgzmb0KME+5s+2Eww/qTuVsqOo4TcOP0pgwu4P3X41qhd6iiP3Uo8GUspHSKdLvq7YVWscSDdLD3vasxK9pnsaNQ8oL4DlJH31NlXaBqghIpKzOuGwABRQ5vROGqvsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051087; c=relaxed/simple;
	bh=HHg94/Yn6hwO+RBLZCLrXChZondSbEbnPvu2w0RrJtk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HUHRVd2O3cJfOwt7scNoWL3ZWeF5UdUkgpu7xoemPErLcwuhHmBR9aQrG7YSJt2EEbfHNfaQ7FH891c8rQBMt2+4b4EWp69rzLpVLxbnonN/wMBTCG37Zkqop81Ybk9mAYukx/n7YGQIz5Lf1lqzmduhwNdaceoeutS63lRVntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q5NkPFxF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f74f0e3c6so3864468b3a.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 00:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778051085; x=1778655885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AA6ODREd7lP27SkccAJSJu6di97ZotDgeK5i2XTbKMY=;
        b=q5NkPFxFDxlslfV8oM2WUL5Lij+Lf7d2KT/pdLGwANN6IFxKujI4VsasD1IJvqz7Vb
         9TxPKWHs8JlGt3RPybwwXBvkF3f/kFgKHE25tBMnXumS4zgQNkW1i90qhjk+bJYcYe6P
         KAQkuHCt3oVmA81SZnZWKKvIBkBQs/SagpNXroueP1L6dcicjwmRpCz/Doe3JRxkcw2G
         4ir2diywMD9gaAqnKQIBFZePYgS57i8fMg/k9hG65mM8pflTyQ8d97j7OofKfWD0L8Yk
         s1QA3l4TDP9Py1YsCB92jKDljKYvhH30hPQx4tO5xgKZjm4GvsMz63nSmIRGgLMpb5Dl
         Rfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778051085; x=1778655885;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AA6ODREd7lP27SkccAJSJu6di97ZotDgeK5i2XTbKMY=;
        b=VzHBduP+fgW6aoLRkhHJcK/OW5tw5CQHeUmcdTOV7MudklAjt8Ln75e2siEE3p32JD
         i9Bgth9MKyNYohla/QN9PS1KJ46A3FcVWSNVd1NiJDAyGhbKkV8SadPhdItqx/Hwc/su
         PlPavGvbzKLeGBekkdLkHTWPMRcTt61bgpdrb4V89ySpS1VWhccFxGhVuiHBVDQqxFP1
         LkDTbPQ/LCC9tIWU7KHDExKKvEXy1XYqfw64WGZUYuxD+G7g1XPGm+bXs+Y5WGmQytwX
         2XZMWEOge526240W+ybSsz1zCh/XOqZ9B0qhDSyeclVqhYjQLSN2+0C5wRXawuAm65OA
         9fUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8pFoiXf0T/+BymndR4uyEH3pS/fGP0YAgGnBSEcAFc3GgxN4uPDqRya62oJTuw5in4J3q7bKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2fSXwNZFHewV4RkT05lVhN2G+9l+657YdbOF327bPI2xkrIrL
	ru+sx8jx3yfrQjYjSug+EPplsU7mmaKZ/W1Qty1jnNVonI8QvIe3jq1hzSaIa5SRo4uTOtabQSW
	rQj3H7g==
X-Received: from pfbhs6.prod.google.com ([2002:a05:6a00:6906:b0:82e:7f41:df84])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4391:b0:835:351c:f22b
 with SMTP id d2e1a72fcca58-83a5dc5de7cmr1884840b3a.35.1778051084846; Wed, 06
 May 2026 00:04:44 -0700 (PDT)
Date: Wed,  6 May 2026 07:04:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506070443.1699879-1-kuniyu@google.com>
Subject: [PATCH v1 net] tcp: Fix dst leak in tcp_v6_connect().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 24F634D6FAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284724-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SEM_FAIL(0.00)[172.105.105.114:query timed out];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

If a socket is bound to a wildcard address, tcp_v[46]_connect()
updates it with a non-wildcard address based on the route lookup.

After bhash2 was introduced in the cited commit, we must call
inet_bhash2_update_saddr() to update the bhash2 entry as well.

If inet_bhash2_update_saddr() fails, we must release the refcount
for dst by ip_route_connect() or ip6_dst_lookup_flow().

While tcp_v4_connect() calls ip_rt_put() in the error path,
tcp_v6_connect() does not call dst_release().

Let's call dst_release() when inet_bhash2_update_saddr() fails
in tcp_v6_connect().

Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/tcp_ipv6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2c3f7a739709..3f7bab6faf9c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -288,8 +288,10 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 		saddr = &fl6->saddr;
 
 		err = inet_bhash2_update_saddr(sk, saddr, AF_INET6);
-		if (err)
+		if (err) {
+			dst_release(dst);
 			goto failure;
+		}
 	}
 
 	/* set the source address */
-- 
2.54.0.545.g6539524ca2-goog


