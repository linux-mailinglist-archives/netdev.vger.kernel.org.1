Return-Path: <netdev+bounces-290432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COkeHcILD2omEgYAu9opvQ
	(envelope-from <netdev+bounces-290432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:42:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF80A5A61F1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBAD731CC925
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858503DA7E1;
	Thu, 21 May 2026 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qa/ZKEb0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1307D3DC4CE
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369565; cv=none; b=GMu+hJk7pLd/oTtUMF49cqD3lbK6Hmb4yYnyriyjYD/FV4xu+M82HB2pNAUkxSFwHTap/tmnbnfZmkxAO3wBzskGujwLGJkNjJWT2e6gYOXz+naTRgdptpUniQCBThqKTHbO4+F9Y9WzwFNu4HnDdWR8NAMMGhWJhXVPPR3qle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369565; c=relaxed/simple;
	bh=oog7mXuudEnObwiDTq7SFN92/1hwKC/SQZ7F/dhLJl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sxudd/AxPFNhgJP2Enr+eH7rLkUGly61VN64xkStwcK20yFwCZcbMNPE/ztIUb2Uwsib/mGNp5GpIhZx17UvK0Zrl3QdgANDiNc144lTfquzFh6yBYiuFuEEkkoWUXrLMvRt2B6AQ2w+KyAJHTTryhGTtAvZxlp9hHec05pq7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qa/ZKEb0; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-90fb1490e2cso1436941785a.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369563; x=1779974363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=13zatORPRZFRloaLShXF1OwNUr2kxr5mCkr1VW9YwoY=;
        b=qa/ZKEb053rBiDfNL3noCTDR8LycoUR59gA4es9/Aqz2I10zPt3zi3yRyF/eOX7UmO
         RW2UGaDeS2evXEfZmjpe/bAc1PzdUOrZ4v+agAkqQcgcCtRaGcfzhNaKWoLdIDbjMFWm
         JUXosuc9jDHxrx99q6Da8uY9c/3sUtShLBpVBNxAnS3ThDjWoBqdE/zQ6+Ch7AMecfaO
         bOQrNAg8jKwkGk2xBUSQa8jqogJmi3sf4nqqwm/kUEEIzSWhDqGwaWOgQ+jXUqIVAUK5
         oksH0Go0oFl32i6G2qNdZN9WF98kVSlynh2zjIX2z/OVPmDeTc/2kw5qT34jKL4zlyxQ
         ey0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369563; x=1779974363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13zatORPRZFRloaLShXF1OwNUr2kxr5mCkr1VW9YwoY=;
        b=dyuKlQmwKdobwFGrmodLJ9Yp7UsX7PbijpWxeA3V4saDGlDMYP8UnWFh+0AMznezK0
         58HbDXB8NMrU6HwrSzPoJkmxg5fjuRMUHw0GjWRqvGtc844eFETyRshwPaBg2fAtMTa6
         VBCtAgss94f3x9H3QNuRN3jebjdaHmgBA5fnKYW6gYDYMh4PCLScTaQdOpLdCGW3S6La
         Q76Rsq/vWgrHQJCvKE21T5qvcthEjzJ3BUvO7bQvaGueRT0Tnrla7pcIMdB3teFAMnKQ
         elhdGXjNbRAdV+qwjRnVJs3dLGU+/JXD6dGIv8CKOf0PtzJI/79ZbmDCD8/0fzzAOMrq
         E7XA==
X-Forwarded-Encrypted: i=1; AFNElJ9mdHwLi807Y0YDSZCYILeEgebsCLLedkFBCHbAPkuFu3obz+7OHAPjKgv9hN5wJJj9Orz1tXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJQe/CQ5JGTKCffMwlS2paxIkwqNV+cqnLH5SK8cymUehJ9WC
	CQJc/XKZTLhXskyTeN7TUbcvCoK6fddeyX2GtCaQf9m4pWYEnLBtAZ0MmXVpqpH1vcokByH6o8w
	TydXny9GjVkVZug==
X-Received: from qkgf15.prod.google.com ([2002:ae9:ea0f:0:b0:8ee:7c1c:c4f2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a28:b0:90f:fdb3:b752 with SMTP id af79cd13be357-914a2a5cc52mr399460085a.17.1779369562432;
 Thu, 21 May 2026 06:19:22 -0700 (PDT)
Date: Thu, 21 May 2026 13:19:06 +0000
In-Reply-To: <20260521131916.3627204-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521131916.3627204-2-edumazet@google.com>
Subject: [PATCH net-next 01/11] bridge: add a READ_ONCE() in br_timer_value()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,blackwall.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290432-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CF80A5A61F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

br_timer_value() can be called locklessly, the expires field
could be changed concurrently.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_stp_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_stp_timer.c b/net/bridge/br_stp_timer.c
index e5d453305381baa34225a144ac99e98f2a62d810..83cc9c6a3943508eb94d20ddc1b7e737a58d7abb 100644
--- a/net/bridge/br_stp_timer.c
+++ b/net/bridge/br_stp_timer.c
@@ -160,5 +160,5 @@ void br_stp_port_timer_init(struct net_bridge_port *p)
 unsigned long br_timer_value(const struct timer_list *timer)
 {
 	return timer_pending(timer)
-		? jiffies_delta_to_clock_t(timer->expires - jiffies) : 0;
+		? jiffies_delta_to_clock_t(READ_ONCE(timer->expires) - jiffies) : 0;
 }
-- 
2.54.0.669.g59709faab0-goog


