Return-Path: <netdev+bounces-261303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AlpGFkyoGmLgAQAu9opvQ
	(envelope-from <netdev+bounces-261303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:45:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9841A543A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E21730DE1AA
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046CD374160;
	Thu, 26 Feb 2026 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="LYnTT94t"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993737647B
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106061; cv=none; b=SWjGKMPZsGYz+YswzPkrRpdykVbjscjV4+MdDrkbXXRsoECK//HKt32JlgKEmu0jWwpqa3gGp7r9uUuUCuTPZ5wY5MesYI4iHp+lWFzvDqvOCL6fEf/OdlaGOVRbdAUWGR7PNXUqIm5jgaJnGideJHNZC3+ANrKzcjkTNb+j0n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106061; c=relaxed/simple;
	bh=35l5betl4RNLVy7CQ50UnZD0c09KQBVZpKKYeV8BdKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jReI8jipwMfnoJEhUBBBRJ4aVw8HicGnRd0pY6ctX8CFqNQDFKr53C5ppUsw7IjoQJHID9Wrsbf+ejVywFET+ZsdF59bvuFMDv+PPIR5TxwIfdWQIt+EnsmPS7GLqaNb9vf5+P0PXdDiPsoK/kSznsyOiqq5y1S4Tl1GOcRA8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=LYnTT94t; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=937; s=dkim-tub; t=1772106059;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Q5lINAeBwrVc9/HqW3rI5xs16XeQENQ1HSAPqZNIAzs=;
  b=LYnTT94tb2ISf6eti0FOwLn7s47RN+I4zSlESpueC6xVOERfs8nylWE9
   Yi6UeWtzHqAYIdQbTP3IQK9auQDIT6sttc9osrI4BQo3kzWJo0B4QtVS3
   Sigkq79fFKLUOuqvU6tfFbZeSDPB9T+f8udtrDtd5FTxCqabZD3AocLHa
   I=;
X-CSE-ConnectionGUID: m4XkvQADSgOjMaqTVXEr7A==
X-CSE-MsgGUID: 75oZ6ztbSzqq68/w6odNIQ==
X-IronPort-AV: E=Sophos;i="6.21,312,1763420400"; 
   d="scan'208";a="57705320"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 26 Feb 2026 12:40:46 +0100
From: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Date: Thu, 26 Feb 2026 12:40:15 +0100
Subject: [PATCH net 1/2] net/sched: sch_cake: avoid sync overhead when
 unlimited
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-1-01830bb4db87@tu-berlin.de>
References: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-0-01830bb4db87@tu-berlin.de>
In-Reply-To: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-0-01830bb4db87@tu-berlin.de>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, "Jamal Hadi
 Salim" <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <cake@lists.bufferbloat.net>, <netdev@vger.kernel.org>,
	=?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772106043; l=951;
 i=j.koeppeler@tu-berlin.de; s=20260219; h=from:subject:message-id;
 bh=35l5betl4RNLVy7CQ50UnZD0c09KQBVZpKKYeV8BdKs=;
 b=pdUb9rdZeavBYqwPp0YOYNPKjTOFxdxs/eMI6jDcfjzSwbmCp7KMJDKCGbjvdQN7QmKNLUqrr
 Ba6OJQFCfIQBzfKs2dyJBtniL4cxQ3GEYkBgpnWxLhweuXM6e385zqY
X-Developer-Key: i=j.koeppeler@tu-berlin.de; a=ed25519;
 pk=+pMLYEiy24PHhKr0HCDJhKWgh9WowPOEUOtiuMX7LLc=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-berlin.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tu-berlin.de:s=dkim-tub];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261303-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tu-berlin.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-berlin.de:mid,tu-berlin.de:dkim,tu-berlin.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA9841A543A
X-Rspamd-Action: no action

Skip inter-instance sync when no rate limit is configured, as it serves
no purpose and only adds overhead.

Fixes: 1bddd758bac2 ("net/sched: sch_cake: share shaper state across sub-instances of cake_mq")
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 net/sched/sch_cake.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index d2bbd5654d5b..3718200353b5 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2013,7 +2013,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 	u64 delay;
 	u32 len;
 
-	if (q->config->is_shared && now - q->last_checked_active >= q->config->sync_time) {
+	if (q->config->is_shared && q->rate_ns &&
+	    now - q->last_checked_active >= q->config->sync_time) {
 		struct net_device *dev = qdisc_dev(sch);
 		struct cake_sched_data *other_priv;
 		u64 new_rate = q->config->rate_bps;

-- 
2.43.0


