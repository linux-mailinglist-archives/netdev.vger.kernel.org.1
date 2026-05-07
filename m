Return-Path: <netdev+bounces-285192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG42FqhQ/GlOOAAAu9opvQ
	(envelope-from <netdev+bounces-285192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F04E5019
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C13943003627
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FCA36074A;
	Thu,  7 May 2026 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjUIttSA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CDB35DA6E
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143395; cv=none; b=B1G8+RWByPHhBCE2hK6rLPL3a+oq7JAYemafAT7Ia8xOhbTJ7u7YTvOe+rJeftkwTTk/5gwovq80b43k4SbKq9hurDysjZsWJZQQK6exgI5rXzn8kRHYv5x2D7iUYQly4vU3Jq/crHn85qz3GCidY7XOpfbZ+87Mh4F/Ksb4B54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143395; c=relaxed/simple;
	bh=qUqJNVV3Wb9QmpH0NEX/AWIjhGzeN8ylxAobTrJbbXY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Mo9sSZ+LDLMvm9ySNhH0tgOglkyYiMfznOWrVAuIw6yOCeZCKEYS9HfUP2e19nrX6gyjSvPB3nS1oh4OB0Z1Knf2PMSbD2wGUsu3KXIrklMf56NrQvZmD6RThu6IqM1AgtfWbMA4M3PXqbzdSHv9rrl74U+QPIq7yHhKMVmLEes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjUIttSA; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8fcc3e2a3baso98214385a.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778143387; x=1778748187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IbLl5ruVbHNJWZ4th1uX1TQ2PaF1IxlXSxks7sS10hI=;
        b=vjUIttSA37cEyKPTIQ+0ppXVAD/6r79samq+r5WI9/5f1PVsxPhZgUSdd3NxZFmCHQ
         RWif8AZBDHs1vh1Y5qjALy5ECmacZSBI17PgjXnRbInZKkotT/GJZy99AgNKpfpwnF4g
         /OFzQ29jLh/zpBcBy+FrO1qrDipXQNGKbRE1i0ucpBr9sjOfmUVSx4fT0eeeh6VUHp/r
         ZAbjGHDEO+ORkZCQg+g52sBmaegqC8MIlEM39pzzvtYM0gw3ErwnCKRlCq9Q4sVFxoV9
         35HAzdicn4G4FAc1VvbWOgyUy5MsCxLIeuQDr3S3NK3VUKc3Xa8AQKIrMfJ54Fkg5t6g
         e8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778143387; x=1778748187;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbLl5ruVbHNJWZ4th1uX1TQ2PaF1IxlXSxks7sS10hI=;
        b=mXttpbZYoMYpUHUd4sKfSFJlbOaRsjUjTaPhAp306Mm7ns+BPAAz51lUBzDK1RqFkp
         jq4+e1P/UYTuiMDN/U2HE7yWOj9YLcYYo53qxe9PXkeAdoajLzlBUa+GBSvWmI7x6sH8
         1qk16x7Ztw22LwIhfaLttPU5iu2/SnHi4X36R7kSGZo4utc0BhZjHecIWFSQpPW8+JDi
         Ah+K+H9EcfTnzhXDu1RT3vGIQ9gEURyC4EgfgbHVJ6755ylBfSJ804S9paSWNY6s6PVH
         fqjm1e9bcK00HbfRzMtPUvzm6Eny4xEllzVA/s3olqKjYGqHD60jvKtsjCvUbjAyLhLM
         bfYA==
X-Forwarded-Encrypted: i=1; AFNElJ/9LNjiNt8rkg1b01UUsH6YgtmS4H0qk/c3nqxEn3HIVwZmtLLj6dmXWgMdXOQufJoFvJrvyW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhumHHKLRikqQQ5TrlVxGl/bkdEUdxg6RZX2BZqZaJQk3kyi5/
	ggACZ1891ywRvvuTAvmogYAjBGFb0NkXholAfmcFf8Mh52Gd6ZnPWNLZnEX6VoPoIW5hweGIUy8
	6419oCiKXhHQJvQ==
X-Received: from qkhx9.prod.google.com ([2002:ae9:f809:0:b0:8cd:7d21:ea76])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:280e:b0:8cd:b626:cdf1 with SMTP id af79cd13be357-904d69d9de7mr1037133385a.46.1778143387136;
 Thu, 07 May 2026 01:43:07 -0700 (PDT)
Date: Thu,  7 May 2026 08:43:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507084305.2506115-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] net: use IP_OUTNOROUTES drop reason
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F08F04E5019
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285192-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

First patch changes sk_skb_reason_drop() sock to be const.

Second and last patch add SKB_DROP_REASON_IP_OUTNOROUTES
to both tcp_v6_send_response() and inet6_csk_xmit().

Eric Dumazet (3):
  net: constify sk_skb_reason_drop() sock parameter
  tcp: use SKB_DROP_REASON_IP_OUTNOROUTES in tcp_v6_send_response()
  ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in inet6_csk_xmit()

 include/linux/skbuff.h           | 3 ++-
 include/trace/events/skb.h       | 4 ++--
 net/core/skbuff.c                | 5 +++--
 net/ipv6/inet6_connection_sock.c | 3 ++-
 net/ipv6/tcp_ipv6.c              | 2 +-
 5 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog


