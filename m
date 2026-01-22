Return-Path: <netdev+bounces-252137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIfIHJqFcWk1IAAAu9opvQ
	(envelope-from <netdev+bounces-252137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:04:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6DB60ACB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FC7D4062E6
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8547F36C0C0;
	Thu, 22 Jan 2026 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A454K2pc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A036BCCC
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047253; cv=none; b=Vc/1cu6i7irwoxvgxKcsE+UnYQga1MJgbO+JrbspJsJoipB7F4qPFGsDO5/+QRCaV4Bu/GW/HYK8djotdN1mR21TCsE1tH8po6HXJLBLBYqY7u5sdMItfj9ubKcxP8s2oZhA8c5clRutD46wyk7uWzAknEk11N2jLFZp0GZjETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047253; c=relaxed/simple;
	bh=iIE8re20lsjTBnYk5+H33FGulJ5mYzcJH8tI2L8qaXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaIplCPq4M7EwX0bijYL0XmvYjm4ZFCGD8fzOs9JfHB8iEdJKjC1Kw8L2jGxDtjYGWHVV+5Gz5rde76Z7D3Ub5TEYAoR2WJyIW7TOxX7arImHGiiDd5tm4XBu5JxPsJtyV5WvFz5UiKDoJ300/pHumYS0ZbQNfEUZqy8DCM+L+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A454K2pc; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b714f30461so448393eec.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 18:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769047251; x=1769652051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg0wswL3UiVCyK8pC6Hx23JoxxNi/TA43rjgfSUgEB4=;
        b=A454K2pcqWl7MB9ScUfJ4TBHDLe1CBHEwAlQPdj0ymhzNFc0SsuET5a50/gVSxiXwK
         S7PKWFEgI5tMQezFBU5OKm3K9VBO8N2qvsBr8peqTeAuRM66jjUu7GP/slBlqyFEHW/v
         XvgvydH7Bisr/jGyvYrNGbT24UMhnlD8/MAYIpCph5qL/AGgkC2/wkPayEhYmugNUx/C
         XgSUI3EdHJ+Gkdl4bVPFKkMHmjGVMYMObPcyZnnzcRhvm26BH5M+Wl+ACGEzbRw2gcJN
         dQ6/PHLuAS6cQl8I5/9L1YWAerJbRFBI+bPDUHZD1nMOqVuwmEQWffcYFCKryEBCRJ+E
         1rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769047251; x=1769652051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tg0wswL3UiVCyK8pC6Hx23JoxxNi/TA43rjgfSUgEB4=;
        b=ENp1ZJw8Asu1TkFcYTLs+/qn880kmr93XaK6khaYe4dtaQqw0iBws7o9w51wP06wCF
         497WSDbk8im1xt1mAHwlZmqsxoadherZt1WoHxOIWo6cFLjUTJPJVn0YGmaMvFg+rgiE
         DEwuTfu0lN0+DhMZD9KzQWV90pbarVVwjxYg5ebzwFdUTj25S1LGl32d1NxHkGN8u3Pn
         1rdi9zaH9VH6P+DNgILKLfQdiSqqAcFIWBKkUTu1VReeSTNiCLaCL+t9xQH/oAZsxOpP
         ARGQ43dqsIzFDVS+TunM8Cu7g8aOUOC8JQhgeRpgNK4ndZjHbhCRANOzU2EZf3rDbo8h
         pfFg==
X-Forwarded-Encrypted: i=1; AJvYcCVRxW9uQ9cN6C7+4bukrSrZVXUcgV8AT/rFKMs3DCaLOj9SLSRwTDUxTIz8q30dyzR4FaB/18k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9y3iHOwqSLv9YOUR5Ti6ay74EnLBZ1uJACpXisXxDN/5PJDM
	Tc4Spx6jZY28KFiQ+WLFmNpN2k4XQeEogOJksw88iImAfa09ankpxxxg
X-Gm-Gg: AZuq6aLRijjt2YBHIQaT2WCBCCwo333z+XGfEEK0UjGJyT5f3Y37Qyj3r6wy6HQzopH
	0a519h6dVnoyCM+k1+X3cYRIFVcPnNGK7GaKH6jruQwEwXoivkCvSukNQWK0elVOisCiOMYkJz7
	gVoBtXQ6tn47MrLXlLXIzvSr9RpUMvtn3fti8f9H7MGPMepqoS+Aq8IaGGQKaMCZcDS306P8da0
	fYxve3Fefmvp/0Cps5VOzw+N+e5R9eoOR9kz5gxgxswCr8bA+YdAW2SLNjn26rkpw5nj86SsOVa
	GZa3lKMORu203sModKti+qPTm6oSoAFIUYu4/b7qWsRX6i++zRSXSqT4+XyQWL+FparELcEtmZK
	shxZsHsRbqFnGmu9wtuBMamnCpQ2UTKywDIksaqAQaB1qcqG7ZOtDZohMEQHFhpZ3J+ZYk5zXUx
	F00P0=
X-Received: by 2002:a05:7300:cb05:b0:2b0:6a03:e66f with SMTP id 5a478bee46e88-2b6b3f29e91mr10715914eec.10.1769047245987;
        Wed, 21 Jan 2026 18:00:45 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b361f5d4sm23807434eec.17.2026.01.21.18.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 18:00:45 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	mhocko@suse.com,
	vbabka@suse.cz,
	willy@infradead.org,
	lance.yang@linux.dev,
	hannes@cmpxchg.org,
	surenb@google.com,
	jackmanb@google.com,
	ziy@nvidia.com,
	weixugc@google.com,
	rppt@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	jis1@chinatelecom.cn,
	wangh13@chinatelecom.cn,
	liyi1@chinatelecom.cn,
	sunshx@chinatelecom.cn,
	zhangzq20@chinatelecom.cn,
	zhangjn11@chinatelecom.cn,
	Qiliang Yuan <realwujing@gmail.com>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH] mm/page_alloc: boost watermarks on atomic allocation failure
Date: Wed, 21 Jan 2026 21:00:35 -0500
Message-ID: <20260122020035.227449-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121125603.47b204cc8fbe9466b25cce16@linux-foundation.org>
References: <20260121125603.47b204cc8fbe9466b25cce16@linux-foundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-252137-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,suse.cz,infradead.org,linux.dev,cmpxchg.org,google.com,nvidia.com,kvack.org,vger.kernel.org,chinatelecom.cn,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A6DB60ACB
X-Rspamd-Action: no action

Atomic allocations (GFP_ATOMIC) are prone to failure under heavy memory
pressure as they cannot enter direct reclaim. This patch introduces a
'Soft Boost' mechanism to mitigate this.

When a GFP_ATOMIC request fails or enters the slowpath, the preferred
zone's watermark_boost is increased. This triggers kswapd to proactively
reclaim memory, creating a safety buffer for future atomic bursts.

To prevent excessive reclaim during packet storms, a 1-second debounce
timer (last_boost_jiffies) is added to each zone to rate-limit boosts.

This approach reuses existing watermark_boost infrastructure, ensuring
minimal overhead and asynchronous background reclaim via kswapd.

Allocation failure logs:
[38535644.718700] node 0: slabs: 1031, objs: 43328, free: 0
[38535644.725059] node 1: slabs: 339, objs: 17616, free: 317
[38535645.428345] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535645.436888] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535645.447664] node 0: slabs: 940, objs: 40864, free: 144
[38535645.454026] node 1: slabs: 322, objs: 19168, free: 383
[38535645.556122] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535645.564576] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535649.655523] warn_alloc: 59 callbacks suppressed
[38535649.655527] swapper/100: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
[38535649.671692] swapper/100 cpuset=/ mems_allowed=0-1

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
v6:
  - Replace magic number ">> 10" with ATOMIC_BOOST_SCALE_SHIFT define
  - Add documentation explaining 0.1% zone size boost rationale
v5:
  - Simplify to use native boost_watermark() instead of custom logic
v4:
  - Add watermark_scale_boost and gradual decay via balance_pgdat
v3:
  - Move debounce timer to per-zone; optimize zone selection
v2:
  - Add debounce logic and zone-proportional boosting
v1:
  - Initial: boost min_free_kbytes on GFP_ATOMIC failure
---
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)
---
 mm/page_alloc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1faace9e2dc5..8ea2435125d5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -218,6 +218,13 @@ unsigned int pageblock_order __read_mostly;
 static void __free_pages_ok(struct page *page, unsigned int order,
 			    fpi_t fpi_flags);
 
+/*
+ * Boost watermarks by ~0.1% of zone size on atomic allocation pressure.
+ * This provides zone-proportional safety buffers: ~1MB per 1GB of zone size.
+ * Larger zones under GFP_ATOMIC pressure need proportionally larger reserves.
+ */
+#define ATOMIC_BOOST_SCALE_SHIFT 10
+
 /*
  * results with 256, 32 in the lowmem_reserve sysctl:
  *	1G machine -> (16M dma, 800M-16M normal, 1G-800M high)
@@ -2190,7 +2197,7 @@ static inline bool boost_watermark(struct zone *zone)
 	max_boost = max(pageblock_nr_pages, max_boost);
 
 	zone->watermark_boost = min(zone->watermark_boost +
-		max(pageblock_nr_pages, zone_managed_pages(zone) >> 10),
+		max(pageblock_nr_pages, zone_managed_pages(zone) >> ATOMIC_BOOST_SCALE_SHIFT),
 		max_boost);
 
 	return true;
-- 
2.51.0


