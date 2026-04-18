Return-Path: <netdev+bounces-279454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPOAL8L44mneAwEAu9opvQ
	(envelope-from <netdev+bounces-279454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:21:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E74841FD41
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D42302F703
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 03:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370932E121;
	Sat, 18 Apr 2026 03:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="Tc+N59E+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F531A07F
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 03:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776482437; cv=none; b=IfoPpDIAk/ax/oToOZ34aG2PfcqACc3idmBywhJok3xNhVDEZr7+625LuIHAqzDaj/sdBf1kt2JRKiV0+KZiAN2kuOVSDywFzBn0AfMvg1f902eA0Z8xeZmAgJufTaefxfYNzJ/cfbTmgoeVwgwB4gSYSbAskBrrXD7UdmkubjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776482437; c=relaxed/simple;
	bh=KRFbZ8e8NoHIOWPL3KDgmYq2vaa/ItF3b70/29KtNxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbaQm+VbxqxxjCHy9Mvx7hQPi7MmKR0y6BLToTxqbdKmsNCePU2cTiYr4cFZ/tmHOE/3jYmuSPVgUPUHoFHIztaOd4HwwbSHv94ovANYL15wX5SvI4GbnrD9/bT1Hg+uUB9OVAXkLL93tohvhnY9WDOFu1rYZKmb1OcUvdFdubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=Tc+N59E+; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dbb6c072f1so1297350a34.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 20:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776482435; x=1777087235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YY5iV7l6gxlqPZikCEp9TEV+FDZFJ5bzFc737a8jc5c=;
        b=Tc+N59E+g+B8o8RSlEwHZPJj0TtZBz0uihuGlSFlgGztRoJb2yIauIPOTy1R7HwUpR
         qmhK+DqM2gyDvdSFWMWg7e9HB7p8fOA3c5HTB06T4+ZM/o6nUpfWWQSL8Qmgcjf4nZ+T
         XgG3G44amwcm66KOjH6TuAQXAGLi7+98+9/Izb4OOn/lrz9UGF3CQQ1sqzH5pGNKeHOg
         fP1X9IQa9JKPYNKXoV1hOdWqFCQ9Q9ik6j9+VrRogvpkcgIz7eSKY4DNyHOISQosro0u
         kV9Xrdc4rvMB2kDeJLs3ADnq45bKcAJwHiPi4es9pRdPx1iGyXovV/H4lQCPsGhjRY4D
         YoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776482435; x=1777087235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YY5iV7l6gxlqPZikCEp9TEV+FDZFJ5bzFc737a8jc5c=;
        b=fFA7d5gm7N/9/HoeUteKHhXUnQlwnkmL2bMpVdYxcyczEXINMdgxhb9He9k6BYLvtj
         6ioj1bt5laGv65JbR5xAfCehWiR4FuX8isk0aDVEb4Q6qvtAg14Spo9bzytHjQrDLXxz
         fD+QFPKXXgH/bk9zaAiQ9c8zoGI7co2dzGyRW49k+2gKvnYLQxXXpIe+jrAYyxsyBDS9
         3yHDesjMHnPrWwQkNBudGQSmV3l+gHtUczp5FX7owB5Hp5ZJMuRmyBeNfCZwgWS6p0MA
         B1Z7Ch+Xd1cLMDddriNwMJUYreAV24SVD3alDVcJIdLM6jJTPORtbVwt9RMn/2VNDnKh
         GAmQ==
X-Gm-Message-State: AOJu0YxGnPnCvxyBVivRVrI+Ryx5nZPoyCpMogNTnq502g7seuW4/UJE
	r2Tugoj7wM5Cmhl8ZpLebiyFm8SSpQXDhbZOrFiRuMHlv0bnkygHIx26IcbsbIq8lXNjLEn5dFR
	2ZBKW
X-Gm-Gg: AeBDiev89klKQmBMwI5XceoscMFfM6cbsh6eysQ54WMQOQHRB4BXJbVSPGPUuRaRD6b
	tIbGahF/h3SBYsBzeByLeCdvnuDkNHek24oUwZPsmxsayqjXJzu64ErTgIjPA+J6PeNP4997cE0
	b0J+G6Sfv/6fuq2qgBzhLOTpEIAGCw3y5t6Vnp7eI4mrVKTG5YsAsmLDAkYOVQScDK455b0Xi7f
	urcJfWIukCk2rjnY+PFT3O29AyE74L9065F1RDWtbTbcXizQRVLJUmLejZ6ScvyXl1iQCuU1i5m
	TzSni9CmbokVxf7B7GG6de3jYibdKmSnDdDJxiSpKt/MuVlX9Bi0vE5RLqItrFVYF5rtqjrODtP
	kG0j4rtBYtt0zW2uLCv+TSvRGMkpd74AB9AnijkUp8QpSWgzhSAjC81lYyV0pEzrb5o6HNDsMrd
	D3fM89XsD4S+TWsyBvxQho3xhIor1Zl38MTfJb/Yos/uU=
X-Received: by 2002:a05:6830:2815:b0:7d7:48cc:ccdb with SMTP id 46e09a7af769-7dc9521cb0amr3588018a34.19.1776482434717;
        Fri, 17 Apr 2026 20:20:34 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dca7b6b5bdsm276902a34.5.2026.04.17.20.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 20:20:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	horms@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Martin Ottens <martin.ottens@fau.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v8 2/6] net/sched: netem: fix queue limit check to include reordered packets
Date: Fri, 17 Apr 2026 20:19:40 -0700
Message-ID: <20260418032027.900913-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418032027.900913-1-stephen@networkplumber.org>
References: <20260418032027.900913-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279454-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,networkplumber.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5E74841FD41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The queue limit check in netem_enqueue() uses q->t_len which only
counts packets in the internal tfifo. Packets placed in sch->q by
the reorder path (__qdisc_enqueue_head) are not counted, allowing
the total queue occupancy to exceed sch->limit under reordering.

Include sch->q.qlen in the limit check.

Fixes: f8d4bc455047 ("net/sched: netem: account for backlog updates from child qdisc")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 8ee72cac1faf..d400a730eadd 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -524,7 +524,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 				1 << get_random_u32_below(8);
 	}
 
-	if (unlikely(q->t_len >= sch->limit)) {
+	if (unlikely(sch->q.qlen >= sch->limit)) {
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
-- 
2.53.0


