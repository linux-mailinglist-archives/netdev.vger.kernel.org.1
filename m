Return-Path: <netdev+bounces-172542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A397CA55505
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81DD1695C2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C361825A637;
	Thu,  6 Mar 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dL4wCEmv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C52E3387
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285864; cv=none; b=Yd3qGCDWnj79pix4zqjvC7jYYy3JQw1h1VPWrU2SJjoUWEZTFr/AXtP+6KbodKIvScGGGEzBlr9fReTgptORXd9ZczC34BE4xClGWzQgRvr/sBLMT9mxEZ78Vtb6gnrGhgYWqdY1N5FG8ibFuHLrn2X6wxfaVJYotAkFiUNath4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285864; c=relaxed/simple;
	bh=I+JayRe5Fk56kS9wGwD/+k2PZJHeI1iG3cI12BMb9Gs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oy2AcC9J4lxraFvRxLqqa+IVgpZ5XHo6ml0UkQaiDt/ajhupTPweyyEXrMlS+Iz78HneEe7QSQf5R+vgbY3rqUM6vDuR1HarqZ6JFB4PRSIl/0IAk+UJe7ZLAdsz8p5BmRLf5NGFiWLBLoTfe4HDIdSpzps1HWUYjLo3CHgEMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dL4wCEmv; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e6bb677312so18930566d6.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 10:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741285862; x=1741890662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ow5GiJuYLDPa2u0dtTepKbMmxDNkEFDS9ftBvgwKRek=;
        b=dL4wCEmvNtpke6ycoriJKAtHZ6YUmSzBUr7KylQSln+VGc2ukJwIhph3p7veivDAmS
         Dq0w0mmqRqujbcIhxKhBViuTnkUPRAsy7COeUJN3hk2AWM0xCeE+bOq17Iz398X7C/X0
         t+8dKBVGj6/T65czBfAsxkDPSfPeZ3diBrDOavcvjziqOy6Lf0w9Skq1mb2TcloW8ret
         D730p1xpgpoPL5HMfghegHPUZcVPkRlLJPxj7fX5ry1lj3CwWoFjgP6GMO86tHUt1FSh
         d2s3kdXzF+9PN1qYCBBMkUmIszOr2wcv7GZKO3QL2EyTg4pQS+vRUffIQ203PDQxdcLD
         79IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741285862; x=1741890662;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ow5GiJuYLDPa2u0dtTepKbMmxDNkEFDS9ftBvgwKRek=;
        b=BiheSRYMOBkhTQApUt9UJ604LL2s7AM1DiYfNuKUmOJiL9AMIFE1O4v2VDzuckmAj7
         aJMPcu8EWXWrjMKJatO6vUZsgOG2KTCZE0elTVBn+psYfGMuPekFZTdNaGVTsoZX9VXD
         gFVmsEYlbMgZf5eU7Bl4j0abjKORU0G2TgT2+5Nvr0o/oKK1tKseScRWMGLPbY79tmTA
         1ymox+CfjjV8Etyan5KqqQR5X2rbLeO+PcAfrx2bxereF5j3O54Rj1mcJn0weIMpyPxT
         XWbW+nglb7X0m6XYOYjGiLW2acwwTQD0Zr8aoc7xddULVGgrtnAYzgOQxFtn2pUl35qP
         jmlw==
X-Forwarded-Encrypted: i=1; AJvYcCWqTOFjvqX+JJBblNI7fjCWI2BmRIfIahqeuHJOzjqre28DsC6Py3JFd6NjEPEmISGgsRmSlqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkJ3EQ3fBNl6r5djkMphLYE92S4GLyS52sf1ivWWUQZvmHDvy
	6QaFQBasP6qrq+46syHlXUihCKf1m4fLNLCRj0fC9fNqDR0u8/2vP/s6tI4p/sUlqWoIYkgfpF8
	4ZCIH7xwV1g==
X-Google-Smtp-Source: AGHT+IGvXCNEnU0pqUSVfepSLRCg3TQK7E7AUh/ydoZ+GMhr7hc0haPuz+RjfqHVdKcaXSysIyr5rXxE7hdSxQ==
X-Received: from qvqg3.prod.google.com ([2002:ad4:5143:0:b0:6e4:6f95:b483])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:f27:b0:6e8:9535:b00 with SMTP id 6a1803df08f44-6e900621ae6mr825256d6.12.1741285862048;
 Thu, 06 Mar 2025 10:31:02 -0800 (PST)
Date: Thu,  6 Mar 2025 18:31:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250306183101.817063-1-edumazet@google.com>
Subject: [PATCH net-next] udp: expand SKB_DROP_REASON_UDP_CSUM use
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use SKB_DROP_REASON_UDP_CSUM in __first_packet_length()
and udp_read_skb() when dropping a packet because of
a wrong UDP checksum.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 17c7736d8349433ad2d4cbcc9414b2f8112610af..39c3adf333b5f02ca53f768c918c75f2fc7f93ac 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1848,7 +1848,7 @@ static struct sk_buff *__first_packet_length(struct sock *sk,
 			atomic_inc(&sk->sk_drops);
 			__skb_unlink(skb, rcvq);
 			*total += skb->truesize;
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
 		} else {
 			udp_skb_csum_unnecessary_set(skb);
 			break;
@@ -2002,7 +2002,7 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, is_udplite);
 		__UDP_INC_STATS(net, UDP_MIB_INERRORS, is_udplite);
 		atomic_inc(&sk->sk_drops);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
 		goto try_again;
 	}
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


