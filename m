Return-Path: <netdev+bounces-287471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FL6MhMyBGqNFQIAu9opvQ
	(envelope-from <netdev+bounces-287471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:10:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BD652F5CC
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79F5F30CEDA5
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BA0379C4D;
	Wed, 13 May 2026 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pi2WgQGz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2F13955EC
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659739; cv=none; b=SRBAD3afg6pFduzdM2eYJ1zeJ8Goou72NXk9vHlF/cmHkqIahi+NtBpGaI8ize840ERblAjraarU8nbsQm/BGTTrNHcB24tTBqdAL/V3/w50nCr/GeSyruZ6hmGlgwqEYmOAZALlBUJ83U87J/kaht7Ak9dxxRqqN3WSV2m21g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659739; c=relaxed/simple;
	bh=gEDYOSB87brfJqwgBImKBTcnxUjSCAwpPLF7RNkizQU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b4x7FqDrYXTrk9EOA+LFqEMnyPV0KNpkSMnqMdWv2096XsKXj1aIO8HIRbVM7xSD/9zxHLQpwWW5lb3l1Lj94T9biWE2cHrlRJZj/t+erGkljOmH88js26avGsvcWXBAeN+gdA9AV2fs92txim0oFwOAHh1AZMd9sd/BNl+kEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pi2WgQGz; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so53935841cf.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 01:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778659737; x=1779264537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2p2OHFM/6i6WGjksUyv2MQ6v3hUiEY9VhMFZVw6n8c=;
        b=pi2WgQGz4GMvQue31mnSEO2VO7+rjqBYdeKz+4N/glrc8kIwPoPJzzpHlQXt/EiLgI
         5riB/77NdjFXozLxzu5w9Ip3toUsZzZG+H9930ttPIcerrogEbsPTC2jmcR4YE4VtI77
         MTqyNGayqbXgnDSlDJTXPhWQ3p/Otff9VcY0WEMnPl6hxtZYQDEaR9KCkyuwBsEJ4oem
         zfkJXmDWvVxDnpUpOkgSIZk2nRFJd68tIaFwTv1tMLzOiw9xVvo6gEFyQC2unpxWr6S1
         AtcKMyRFzi0BkxvcsrL9Ek1P6NNKKLqzgae3utPmB4bf/E2IJF7OYHThT8NjkzCttZRI
         wEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659737; x=1779264537;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2p2OHFM/6i6WGjksUyv2MQ6v3hUiEY9VhMFZVw6n8c=;
        b=aXyVQnw2o50MWit0Dmrv+J1zNAFlIF5xc9tXpDD5UMPLzBOOXwYnEJMsK4Au/omFuU
         mSpxeQta3h4BEvcaRrjHk4cwcF4sRbNBPPBcAAgbcKTWf4U8hEIclA3rIW3miw/qr6MG
         YEgNzkF4dZFXcQym7oxn7SqqThhiupJBvn1LgHh0yK8GOey3iVwi/Dq+RPtfCm5lO3wg
         CxOpvTaLfB9KWLxsuzguOjNqi5l+ToB5X/TgUFDm499krmZpRgZ+5KE+TWm189qliydp
         P9LRJ7tHr5MfDC009/qPjB/s2xfGiFrkfSQYFUlNqjE+NSJsIGJi/emxy68zkgw9g3WK
         hd0w==
X-Forwarded-Encrypted: i=1; AFNElJ/odbM19P//5G6hmOy8QId8Ihro0W6oz/DDoYs9CTdmXxA8oIp5IaXDZoEs+ljCxtMnNf9EFow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yway+fsy+fNwhjOaNpV1Vypk3YZM6y988gUVY5kM8jPUIoiRzJ/
	FocQEq3GQZMT8SDzabhk4ZCnGT1TXCjQzDwKjqZSlITbfrR68caaJJtSYRxZaXM2LThllIoRM8V
	+ZqQnYvv28VU+WQ==
X-Received: from qvhd4.prod.google.com ([2002:a05:6214:21c4:b0:89c:6289:f17b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f0d:0:b0:509:127d:ee06 with SMTP id d75a77b69052e-5162f65cf1cmr28523141cf.58.1778659736752;
 Wed, 13 May 2026 01:08:56 -0700 (PDT)
Date: Wed, 13 May 2026 08:08:51 +0000
In-Reply-To: <20260513080853.1383975-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513080853.1383975-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513080853.1383975-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] net/sched: qdisc_qstats_qlen_backlog() runs locklessly
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 33BD652F5CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287471-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,nvidia.com,toke.dk,vger.kernel.org,gmail.com,google.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

qdisc_qstats_qlen_backlog() can be called without qdisc spinlock being held.

Use qdisc_qlen_lockless() instead of qdisc_qlen().

Add a const qualifier to its first parameter (struct Qdisc *sch).

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 9e6ed92729d282642e17a72cc578f25e1d22e4d9..d0ca932b1871c086f0ba7aad11241742bba0a9d8 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1070,13 +1070,13 @@ static inline int qdisc_qstats_copy(struct gnet_dump *d, const struct Qdisc *sch
 	return gnet_stats_copy_queue(d, sch->cpu_qstats, &sch->qstats, qlen);
 }
 
-static inline void qdisc_qstats_qlen_backlog(struct Qdisc *sch,  __u32 *qlen,
-					     __u32 *backlog)
+static inline void qdisc_qstats_qlen_backlog(const struct Qdisc *sch,
+					     u32 *qlen, u32 *backlog)
 {
 	struct gnet_stats_queue qstats = { 0 };
 
 	gnet_stats_add_queue(&qstats, sch->cpu_qstats, &sch->qstats);
-	*qlen = qstats.qlen + qdisc_qlen(sch);
+	*qlen = qstats.qlen + qdisc_qlen_lockless(sch);
 	*backlog = qstats.backlog;
 }
 
-- 
2.54.0.563.g4f69b47b94-goog


