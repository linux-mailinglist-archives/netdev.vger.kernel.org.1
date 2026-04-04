Return-Path: <netdev+bounces-275367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OARmFy0V0Wm8EwcAu9opvQ
	(envelope-from <netdev+bounces-275367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 15:42:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E33439B3A5
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 15:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE22C300C59A
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F952EAB6F;
	Sat,  4 Apr 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/ucTpRl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2532494D8
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775310121; cv=none; b=I50Lgxy7zvGK77j3Kn1Ud5W/p2nG9TeESUReFrBpJ7POEN3q9K6WwPrRIZve5wwHqjiJZ8mEtz1mFbH2azzkRrWZEAIkWdvFigk2NgSCu7ddoy/SZDudd40/BDhuHOJRH48kc7GSPq+bzpkbiOhzMNRuIS9N5O9yZtkU/0sLlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775310121; c=relaxed/simple;
	bh=JCJ3DYX3PDv0sF4vaPs/g40VMIbphBzFgOKIuzxZQh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cDfKg5YA249HtLMr8BhzR0QSeHR+7D/ERHVWlACQ52q25VOpbyoA4OSCEVXDAUpv9buL4IUfmJOikMUU6ea7bjkXVcmhTDYPZEIeHnX9cUX//PHcwt2J9nuNoKVzy22Y7DXnuL6YdpCO0MJT48Ba0hUVyq/g15g9s9QwG6Ka5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/ucTpRl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b97f9587e6eso357883366b.3
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 06:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775310118; x=1775914918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k1j6N8WMAfkzRObM5NgviDdEdPkVaIdiLqpbzrP+FDk=;
        b=j/ucTpRlBj1hVP1Qvn0YaG8TEbSjbgdmSpc7kRURmK2UUIxU5mdrakq3FF4IApGaV7
         Zkuu+9VAyw3IbsDr1gQX+vSD93/pIpsM66iBAuN03pzz1H+TN/RdvpuNTQ61z8RdakpD
         6eHJUaKXir5lFWupXKBqgF/z27lUY0k9rQNLVJkx8+iYkbllB6oebH6DdwnIGhaOUlvV
         dFTwl8lvGn0r84XGFfU9Tvi7/rBCp709FJr1SR589c5DxVqG8YhDe5smDO6Hujalha+/
         5JqMGYeAuAWB2ldnA0rjZM+NtPiKW7qcmO9G4tG/+4EN34xyUhQJv42GGFyQB/sh9Wpb
         Xlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775310118; x=1775914918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1j6N8WMAfkzRObM5NgviDdEdPkVaIdiLqpbzrP+FDk=;
        b=VUiPOLxxJdTaRuXubOXFT3Wzd+BuYAeSs8ajW2TVuj0rE3HKxZHCOH1ZsQncibi8l0
         ISYNnvyaqygYgyBJFFClpTNuerVMwXCOyStGB8JXsAi4J1M+7nsJL+XWx5/Pj6xq0eAQ
         FKkMOcKIz68tUE8MDd+AEPhRfuJm0GGYQWNmVv3YODNX7wVkNhP9W45tYTn+bXKI35hM
         5YBLc5buz1CLCuEyMsVZidbVaGHJZ4j5tGTfaaCn+4d0Wdz12HfjWRMIZTcHmhFJdKRq
         JgsfdGh6iy4aR0UAr/+0Ey4vvuyhYjps9GSMnRUiaX2d88BDW0wZIl0sU0HniQyQfO6s
         7foQ==
X-Gm-Message-State: AOJu0YxwZjhMcBTAVHcPRPs4cilvFwsMjKYVsHPKAalPxFYzPahEnZZf
	Sx7TNGglkrXrvRYbF8QJIj+srwrVDtLUrivz4KCSWVedxu7D5VZn2Y0/wCKPFg==
X-Gm-Gg: AeBDiesd4TlgGpqrclXM5BgIepDujayEHAJgkA5WPqra8p0qcjJrscS0nhwqkNC+AdB
	WF44t5Es49YH9BYQrfACmfLXLx9SctCl0lIeBDTWaHFOBD8nshBN8m0CuR+uXnWhmqAb4up4KWs
	oUofiFMclrKLQKVksQZnRQo0FP45K85Ssq4OmVA+3/pD72R2OizQShwtE+zDr0JsErkwYRkJwu8
	DYxmunDGka01Xgd2gCUk4bG/Jc7+mJCpq5R7sGdP3XISVgao3NxVDbeaQgnhfQLgssd/TNVUJlK
	VtQ+Pve/BSCukRCzJ9uTbmH7sCyNpy10MJnmeZFkXXbx8QBtwlishRk4C2Ys+x884bqTm20XTtX
	lHyrNi48A2yQVs8fO9+eFhRKMgFIyiFNZ7Huc3r1XPIN9UOryNcfitl5uh0xPnGBy+DEWFs2//e
	meJfmajN8IwoKyO3Hsu2I9cvZZONf6vJPor9U+cjYtq7w=
X-Received: by 2002:a17:907:c009:b0:b96:ef71:49f9 with SMTP id a640c23a62f3a-b9c6742fc89mr341121566b.9.1775310117830;
        Sat, 04 Apr 2026 06:41:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a75e:9a00:eb80:1fe:7625:6ba9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3d028995sm294184166b.57.2026.04.04.06.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 06:41:57 -0700 (PDT)
From: Justin Iurman <justin.iurman@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net] net: ioam6: fix OOB and missing lock
Date: Sat,  4 Apr 2026 15:41:37 +0200
Message-Id: <20260404134137.24553-1-justin.iurman@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275367-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E33439B3A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When trace->type.bit6 is set:

    if (trace->type.bit6) {
        ...
        queue = skb_get_tx_queue(dev, skb);
        qdisc = rcu_dereference(queue->qdisc);

This code can lead to an out-of-bounds access of the dev->_tx[] array
when is_input is true. In such a case, the packet is on the RX path and
skb->queue_mapping contains the RX queue index of the ingress device. If
the ingress device has more RX queues than the egress device (dev) has
TX queues, skb_get_queue_mapping(skb) will exceed dev->num_tx_queues.
Add a check to avoid this situation since skb_get_tx_queue() does not
clamp the index. This issue has also revealed that per queue visibility
cannot be accurate and will be replaced later as a new feature.

While at it, add missing lock around qdisc_qstats_qlen_backlog(). The
function __ioam6_fill_trace_data() is called from both softirq and
process contexts, hence the use of spin_lock_bh() here.

Fixes: b63c5478e9cb ("ipv6: ioam: Support for Queue depth data field")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20260403214418.2233266-2-kuba@kernel.org/
Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
---
 net/ipv6/ioam6.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index 05a0b7d7e2aa..e963a71858a7 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -803,12 +803,16 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		struct Qdisc *qdisc;
 		__u32 qlen, backlog;
 
-		if (dev->flags & IFF_LOOPBACK) {
+		if (dev->flags & IFF_LOOPBACK ||
+		    skb_get_queue_mapping(skb) >= dev->num_tx_queues) {
 			*(__be32 *)data = cpu_to_be32(IOAM6_U32_UNAVAILABLE);
 		} else {
 			queue = skb_get_tx_queue(dev, skb);
 			qdisc = rcu_dereference(queue->qdisc);
+
+			spin_lock_bh(qdisc_lock(qdisc));
 			qdisc_qstats_qlen_backlog(qdisc, &qlen, &backlog);
+			spin_unlock_bh(qdisc_lock(qdisc));
 
 			*(__be32 *)data = cpu_to_be32(backlog);
 		}
-- 
2.34.1


