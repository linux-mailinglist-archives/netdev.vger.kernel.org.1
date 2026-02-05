Return-Path: <netdev+bounces-257021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DufJxFLhGm82QMAu9opvQ
	(envelope-from <netdev+bounces-257021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:47:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 262B4EF916
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712403029E4D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1B235F8A3;
	Thu,  5 Feb 2026 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g6VclQ92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3535F8A8
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277604; cv=none; b=su3jVC1jLi3YiYWhV/c3LCtHLP1WC4gQe9SM7C6H1oJnkztFF6S7NwtOTF+wD26PFuluYgnZ4AiufPFymUeiQwUsWEOKkfEh//prOLvDW1Ej+l23B1vIOymWQm1XOtxQWM1GqnKlr/HL+b0s9WexQ5m/2atHUVSZUyIVzJcyUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277604; c=relaxed/simple;
	bh=BZAm3zfS+K8re01D7iQcVFbiBjsf6a3DLCN+hVqBjSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4j5oafAw5kM35kZ2rx2+waVF1I8WeTuCFHdM04GsnBoqEbVuDOVr5tKjlZkvikDjZ7+FzJhJOiKNinChh4oD+sC3d7On+vxntDkkMH+X3oTR31+mF5QydE56BSR6cqLKEj6gUi77HgOhR+Ynf6Sc7/S2R6A/H2Uk48HF8lBUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g6VclQ92; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7d1a2680f96so89262a34.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770277603; x=1770882403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSevupTzEHu0sF+WJcXaAghgvNkaKInyzTJ6cRAu8bA=;
        b=daa+ovE6hXVT6reOWnW/FjEu6vUM8/Q58cUnjBTiL6r/awJ1gyht4mRRtKI0B689pk
         Id6jJZ53vIAGJ823mi41ASpQnUI0qkX+vKQcq8tmjxL0hVbp+wxSX94tkkMBaSmRAhRS
         YrrWT19lm6GWqf/tldEfRQG7tUFNjg0xKmf5XcpCmjK2+lfWHBQB2aDSYyAQ8Uk6Ii72
         mCjtIiFAgExsxBBxZGX/K4BH0HNDqgzmXOvQqUVi/FZvobTk2xUbT4F+gVhTtJUYebTz
         FkjG2/kamkv1PSymhl8hn5iyImTauHu+l2/RAb9RGoOpvdfvneE7rxmR+yAa0hNMUehq
         wUAw==
X-Forwarded-Encrypted: i=1; AJvYcCXU5txcKLQyH7FaG2zaQDcURVzpFR4Pt0cVMl8I3wFeoMziNb7kGJjpJA9TziwY+X7CKTjOmds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5xwVXFes9Q7PxtKvqj9NWI/GCJEZ3uyz/hTuTLx99BaMUtoFp
	9fsq+zcT6nroub/0+7Dp6sFveA/0Q5seGp+/EF+UxB2mxIvc6k8O35dm5Hn+0veRABzUGqEf8aX
	IJbaUllQQNfc5n1h+I0Gm+elp99jzHCZ7GA5DmRAbnmv1U7gTcdAH74duzW3uXLM7Tgwc/J6jsd
	Zl7IT/b5LRqYT/k5THnAhu8iTZKDgpAw8bLdc1qWQV3ONJmZmmCXlzbWnEXJYxNPszpZIJ+bh+R
	g6NVc56A98aWInSbw7LyzFTDdZnUf8=
X-Gm-Gg: AZuq6aKGOtQqKfrotAYXKQ7Sku0zfSfqe7E8e4rkWdPuPH4FllFtN6vAARE6Z+c/pTi
	orlxFDbJp4kRLaEhbmpOjqmVtjGRVZFKNl0JJJcWCgxLX7Fj4GNd1azgtNjrFaE9l4mgeUMnZP4
	PB0qq+gdKRjZ0zbEnX4lglokxc6ek0nNyhCe/I6+bDDSJEh02gAF8DFNP+x0/VTdeLfDUZGhy2C
	tGbPizu/5xJekjuRTUvAX6Y6Nb/nSFLs6g3aKvEY0S7eaa//GAMPAavwGiYX4zb3ooxy0v9TLHS
	ccQUst0CESc3RgBN9jOH/GJtDrHImKiQfTwjA0RTYy7hHlQbqt6aueDtwmVPLOmVXGJxRfDjLc6
	T1Q8yaxVIjrTav7oEhHRY5QBITcro+duvPYSqKKnkxVUG9/39XSwewG+ume02wwazRxjLdcBVyF
	82QCMLiRvLL9aawn5PlHmk0C4g/y033xKXCW6in2MuJxAnDyuXdosOGIgpLsk=
X-Received: by 2002:a05:6830:310e:b0:7d1:4684:ea8e with SMTP id 46e09a7af769-7d448ad784emr2596571a34.4.1770277602967;
        Wed, 04 Feb 2026 23:46:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d4491a8e6fsm865755a34.3.2026.02.04.23.46.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 23:46:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b8326a9117so19450eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770277601; x=1770882401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSevupTzEHu0sF+WJcXaAghgvNkaKInyzTJ6cRAu8bA=;
        b=g6VclQ920khstvNzbqEsq35iaC7EMJ3prUBNYO69sVFticXEKV3Pf2da901GF5qFjB
         kLeb/fwjwsfc/oqpm4s2XWGXkD9mZ8aA9sGqFy02VvSMdGr9d+mLXr9oQlz8XegsGYZC
         wm6G6tVXOjZmUGzDbnEARPOjnF4CDLO70RVQU=
X-Forwarded-Encrypted: i=1; AJvYcCVFdXkzbw6XJeghTukFIojP3lx+qRUZXMTiYqr1FATTIK7CrqKV8eWgFlJ/KJebsbAJRZpl/os=@vger.kernel.org
X-Received: by 2002:a05:7300:c29:b0:2b7:b88d:b75d with SMTP id 5a478bee46e88-2b832743f4dmr1306041eec.0.1770277600542;
        Wed, 04 Feb 2026 23:46:40 -0800 (PST)
X-Received: by 2002:a05:7300:c29:b0:2b7:b88d:b75d with SMTP id 5a478bee46e88-2b832743f4dmr1306025eec.0.1770277599982;
        Wed, 04 Feb 2026 23:46:39 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f503ecf4sm3840166c88.15.2026.02.04.23.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:46:39 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	kuba@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Stefano Brivio <sbrivio@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v6.6 ] netfilter: nft_set_pipapo: clamp maximum map bucket size to INT_MAX
Date: Thu,  5 Feb 2026 07:42:29 +0000
Message-ID: <20260205074229.2091135-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257021-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 262B4EF916
X-Rspamd-Action: no action

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit b85e3367a5716ed3662a4fe266525190d2af76df ]

Otherwise, it is possible to hit WARN_ON_ONCE in __kvmalloc_node_noprof()
when resizing hashtable because __GFP_NOWARN is unset.

Similar to:

  b541ba7d1f5a ("netfilter: conntrack: clamp maximum hashtable size to INT_MAX")

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Keerthana: Handle freeing new_lt ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/netfilter/nft_set_pipapo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 6813ff660b72..484ca8cf2e80 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -665,6 +665,11 @@ static int pipapo_resize(struct nft_pipapo_field *f, int old_rules, int rules)
 	}
 
 mt:
+	if (rules > (INT_MAX / sizeof(*new_mt))) {
+		kvfree(new_lt);
+		return -ENOMEM;
+	}
+
 	new_mt = kvmalloc(rules * sizeof(*new_mt), GFP_KERNEL);
 	if (!new_mt) {
 		kvfree(new_lt);
@@ -1358,6 +1361,9 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		       src->bsize * sizeof(*dst->lt) *
 		       src->groups * NFT_PIPAPO_BUCKETS(src->bb));
 
+		if (src->rules > (INT_MAX / sizeof(*src->mt)))
+			goto out_mt;
+
 		dst->mt = kvmalloc(src->rules * sizeof(*src->mt), GFP_KERNEL);
 		if (!dst->mt)
 			goto out_mt;
-- 
2.43.7


