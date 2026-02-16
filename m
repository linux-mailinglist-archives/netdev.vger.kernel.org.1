Return-Path: <netdev+bounces-258855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM9mNNDvkmkQ0QEAu9opvQ
	(envelope-from <netdev+bounces-258855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:22:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7A41424D1
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E35EA300C93A
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3A62FF66A;
	Mon, 16 Feb 2026 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hegog2NH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808A2FF669
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771237325; cv=none; b=UfolVjxFJiU1FSETEuNxQ3mwgSIkbPx+0HcSCDKseFzw0APGwO2pW0AFjMvRuMNarQbY99Mmcqw33eqEvA3gMx5cJExxz97TJdENFfNJgn8CjP0TuXWZZMTjNn3wZCOuYn0j/8yjK3SXNdY4s2hmr0B7H3LmSBho7ynumsbtstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771237325; c=relaxed/simple;
	bh=dzIh5HLHMjACK3joTcj7CkUbYuIelQm3aP8ZVXYPHHE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y/UfmkKvT4vAhjRsK01ywrkFTNt9VMmfmX4UOxO8c/6omhcmZZW7+8xP2du7CfwL0Z7yzOVm0RWagb2y2htHmNwM6Wl86b9u/JxQvjpKLkZ8eTwNg/kIt201TYY32aNErRB+tNLX0gC574ZOI+ai+3dzQVJC2Ptl+2ewczPYbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hegog2NH; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c6ae763d03so325000885a.3
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 02:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771237323; x=1771842123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4OwKE2ukVIDKM2GXGcheB6FaHo/Hvgq7dk878FzVDUY=;
        b=Hegog2NHxSlWqqOuRULB543Xnk1te/G34mAoJadaIGGWL+m0g7pvmZS1RqD1zr6NFK
         iMUgWja+LaPIIOvjfm0Zyxs34kENZ2tu+gHBWDi2UA778hIwFtx367kYXIcyki1imQ5Q
         1H79/I92rZ3PWT+N/HB3mrqOjI6D+yDKMOraiI5QaxoTQuIAFszv+kF1cXCI2moa9woO
         L47B6RsvK4vvBq6lMdc5TolirrHbuJwHWDXy50vO/9h9Z7YR69w+VHEKz03iExB31O3s
         8Bj4MizPI4mTXBlP56otZh/mJh250D0dgv/G+D7OSnRFHsD750t/pPo95tdN+rKpKhzm
         LfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771237323; x=1771842123;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4OwKE2ukVIDKM2GXGcheB6FaHo/Hvgq7dk878FzVDUY=;
        b=FHc+eDBlWyEo62lHwRjPsYKF18dX5dN9k7+pcY3xIvTNR0GMud6dY0nKkple1wPx/k
         Kn1GQkcBB/8xhvtl9RawuBOXf+XzWT9B40QNcGSHXDfzYiiE8lbLWrU7VD+LUwNe9xwB
         RWBsYyQ2+72KwAVlQ5UR/O//YgR94XEQaCEUTBd9gDEcJfM+qN3dksF3TygE26lUaeyh
         3O4RCbDValuz8SC0EMB62sNvr733C5ZUJxyX/fPwcm6cd+01A59zXhsUlEzXCRURBGaF
         A5Z8j+rWfgIiCjjtltCn1snh3NgBfAjdRWQiiEd3qWWaS222crOqDzGnCeoJpI5l4z7p
         fddg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9c8hmdMoO3oVb8XwIjeSRAAxL846cpy/bmQ0L1JHpu7eKotI2bwjg8Bj7PIBuWEVIZ8fUGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwYxZN1I/OGSNb/fpOA8hnXOJSXKW/kCZS72jM9b6fCii+D14
	rWqM/ZFic7froYYJn92e+r+GLGQPpAgrepXTyJ36K1Xz7+E8qnGb8QajyD6mlo7It+EdQX+yEuk
	ubzKIVUBRsVeDog==
X-Received: from qknpa4.prod.google.com ([2002:a05:620a:8304:b0:8cb:a9b:63e5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4709:b0:8c6:d309:f9c0 with SMTP id af79cd13be357-8cb42262ee3mr1188207685a.8.1771237323134;
 Mon, 16 Feb 2026 02:22:03 -0800 (PST)
Date: Mon, 16 Feb 2026 10:22:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260216102202.3343588-1-edumazet@google.com>
Subject: [PATCH net] ipv6: fix a race in ip6_sock_set_v6only()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258855-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E7A41424D1
X-Rspamd-Action: no action

It is unlikely that this function will be ever called
with isk->inet_num being not zero.

Perform the check on isk->inet_num inside the locked section
for complete safety.

Fixes: 9b115749acb24 ("ipv6: add ip6_sock_set_v6only")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ipv6.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index cc56e09525d03b8e12dd92cec2751c2a13f16c10..53c5056508be543ae5d312e26dea6ed78fcc04ee 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1213,12 +1213,15 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex,
 
 static inline int ip6_sock_set_v6only(struct sock *sk)
 {
-	if (inet_sk(sk)->inet_num)
-		return -EINVAL;
+	int ret = 0;
+
 	lock_sock(sk);
-	sk->sk_ipv6only = true;
+	if (inet_sk(sk)->inet_num)
+		ret = -EINVAL;
+	else
+		sk->sk_ipv6only = true;
 	release_sock(sk);
-	return 0;
+	return ret;
 }
 
 static inline void ip6_sock_set_recverr(struct sock *sk)
-- 
2.53.0.310.g728cabbaf7-goog


