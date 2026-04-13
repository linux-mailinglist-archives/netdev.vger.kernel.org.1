Return-Path: <netdev+bounces-277952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHn2JQR03Gn1RAkAu9opvQ
	(envelope-from <netdev+bounces-277952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 06:41:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F42183E753D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 06:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AA17301497D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 04:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40113815D2;
	Mon, 13 Apr 2026 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SO588cYn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D737C102
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776055215; cv=none; b=URrM2Ke8grUQ/GDQdc8h5vWlQEUT5KOy/HqnMyfnT6+K2SojizddQlrd0ecdZlrE0+A5AbAxz33BzErMLkq+0Ty3oO1JBaPRBJH4YE4tlpNmbPlqzhGCh6nPy6smpq2z7jpDPwGLu3+AMmH+zbcshrCm9iZZyL+RkJwzo2nh0wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776055215; c=relaxed/simple;
	bh=32i2CGMRFLkk71ry4kqEvU3i5K2ngl/kHrRJQNNg15s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QSsA1d3SzS+N0Ko1W43ooxLup5KI1DAA9rcV38ehHupG7gM/p1Fqj6ftiokOXeXWsP1iO9uapUdQXb3k23bZOMHZHq5jKpz7fFN+v8vNMzzcC+DNDH1uiuHasJlbcfEfRibf6veVyWCyraLZZNrH2jntb4F4MJ82uUmY80eHbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SO588cYn; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8a037bc8688so4173006d6.3
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776055213; x=1776660013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEhC8dL15vha3u2nezC8YntUF4AHPl/GJlnlwSrjKaM=;
        b=bjaqk8hsW8UagLnWdrioanupJtmwRqYIncrk36EgeEtwr44448KzxMvWsjww3GeCYa
         gGwlkkDsghE8dB6WNOVl0h69paxA+vFJiWYG3+G0M1IpM8PvercXqzPpanFBl+UGxspA
         7jQsEWQjTrsnqVkpqKFQV/oYIn4suFqW4T3rBl5f2JgzeuZ+1e1n4p9L0qbk96chhd4S
         fipZP/bjk2wmccw7EOpgSXsGSsiIkBwxPzVEhixY6X82BpmUA2wwn5p1eJ3fTwppllsf
         DIstJmZVozjzQ6ZD8dqETsgsA1Tw3zaJiTCkCIwUdxn9FKDEN7/mw5ngJeVf0Gvew8IZ
         nmqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NPK/W8VPi3xoVQs6YDbWxedKMrDJSR1kUvNdTiyne7EBN52ecGJ3UqGX+voosXocti/f16C0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5wZ/zyKNLgzDYocXq5eCjEXqvgj2QBEWzyYpIbNUF++i5LAbg
	CNkS2l9BEwVPuLWCplXGKc6bY0A2jhizSzlpzjWqvEmItx4YQBtcF7XnEn/dQEAvTIRfZApRF7y
	A/ycoq9HHhfULL2n2bhZDZvvSMvoyA1ZEWn6v2BK3zH3poPeQxDGxvaU4d6t37yHMbwJVWHEHaP
	1rigf6bfEGVjoAiTGb3tS+xBRvolM6c2kbk3b5Clihey5BgAvsY1lJa8DIfV2tZG+nmNA0X4nCZ
	/peeGSxlZ34xnWlj5iV+nZvVxPYYn4=
X-Gm-Gg: AeBDiev0DcG25LOUshtDRvakyrGZNYT9582DeA0mX+2ON5SAtV+x7fV6DPahzWOc+QD
	mlptQCcSKj/z1e7hrl/mlLyGJfYKO7kQehciUGJVxCN9NKlJsziSXzIKBpic/+GIsbKCH4p6isb
	5UvfbpTTij1vd+eWfw/7HAXqWFJVZXsOcXRyM6dsV2dyYy2q66j31ztjHz2N/o45cRuPiYCcc7e
	AWO6SYNCpzJRa8xOjm4560IHOGkN+y9WSIu3A5PFmtOGyvMCkLPU2/3OkGl1Ui+c6OH2IQ/KyST
	wx8kO7NfNh7yHL2CvImhZK0PaeUsZ6a1uYkKTgFiFZA1GxqxO0CQQZiMTnReRLp8jv2MImwlwDi
	PAqoN9WiYk0y7keFYPVPyD0YG96JIq+W64LWKFl/jQFYIwxHwYxrTn4oOQ3BDH3ONQPZlRSROZx
	mkir1HGO57piGRAzMyXCUkLKq6vhJSb94KpQ51AzBgNpFZdu1OG/yGVDgOclUI3tmB+4dcfNtMY
	w==
X-Received: by 2002:a05:6214:1c0e:b0:8a0:ee7:7abe with SMTP id 6a1803df08f44-8ac860cb71cmr143163976d6.1.1776055213256;
        Sun, 12 Apr 2026 21:40:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ac84c63690sm7046586d6.18.2026.04.12.21.40.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2026 21:40:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8a5bf7ee420so13279766d6.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776055212; x=1776660012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEhC8dL15vha3u2nezC8YntUF4AHPl/GJlnlwSrjKaM=;
        b=SO588cYnpMSCK8ejZkVQ8h2BFBcwM1VVp/9ajY/xxmPZ+Ir/4sPgpSVTN8K24cZSwf
         ZPcgEJZ8NBlyX2z9e6sYnGQ6Bu2poj9Pfuo6Rk4i2sdaDSXn+K/FK90LQq2bst/JlWR7
         sjFL0ZA9gV8Eb99crGO11wK0VmQVqPiuWlerQ=
X-Forwarded-Encrypted: i=1; AFNElJ+0g+eoxjx78V1mttGbYClZXjpkMIcpn39Joa8YWAN9BH26gs4mocxW1alUim1BEcx2cAPcSJ4=@vger.kernel.org
X-Received: by 2002:a05:6214:2424:b0:89c:5159:ea52 with SMTP id 6a1803df08f44-8ac8627aaacmr140468886d6.7.1776055212398;
        Sun, 12 Apr 2026 21:40:12 -0700 (PDT)
X-Received: by 2002:a05:6214:2424:b0:89c:5159:ea52 with SMTP id 6a1803df08f44-8ac8627aaacmr140468666d6.7.1776055211924;
        Sun, 12 Apr 2026 21:40:11 -0700 (PDT)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca5222c8esm38017646d6.28.2026.04.12.21.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 21:40:11 -0700 (PDT)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
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
	Mukul Sikka <mukul.sikka@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1] netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR
Date: Mon, 13 Apr 2026 04:32:47 +0000
Message-ID: <20260413043247.3327855-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	URIBL_MULTI_FAIL(0.00)[broadcom.com:server fail,sea.lore.kernel.org:server fail,strlen.de:server fail];
	TAGGED_FROM(0.00)[bounces-277952-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F42183E753D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Florian Westphal <fw@strlen.de>

commit 07ace0bbe03b3d8e85869af1dec5e4087b1d57b8 upstream

pipapo relies on kmalloc(0) returning ZERO_SIZE_PTR (i.e., not NULL
but pointer is invalid).

Rework this to not call slab allocator when we'd request a 0-byte
allocation.

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mukul Sikka <mukul.sikka@broadcom.com>
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
[Keerthana: In older stable branches (v6.6 and earlier), the allocation logic in
pipapo_clone() still relies on `src->rules` rather than `src->rules_alloc`
(introduced in v6.9 via 9f439bd6ef4f). Consequently, the previously
backported INT_MAX clamping check uses `src->rules`. This patch correctly
moves that `src->rules > (INT_MAX / ...)` check inside the new
`if (src->rules > 0)` block]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/netfilter/nft_set_pipapo.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 863162c82330..2072c89a467d 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -525,6 +525,8 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 	int i;
 
 	m = priv->clone;
+	if (m->bsize_max == 0)
+		return ret;
 
 	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
 	if (!res_map) {
@@ -1365,14 +1367,20 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		       src->bsize * sizeof(*dst->lt) *
 		       src->groups * NFT_PIPAPO_BUCKETS(src->bb));
 
-		if (src->rules > (INT_MAX / sizeof(*src->mt)))
-			goto out_mt;
+		if (src->rules > 0) {
+			if (src->rules > (INT_MAX / sizeof(*src->mt)))
+				goto out_mt;
+
+			dst->mt = kvmalloc_array(src->rules, sizeof(*src->mt),
+						 GFP_KERNEL);
+			if (!dst->mt)
+				goto out_mt;
 
-		dst->mt = kvmalloc(src->rules * sizeof(*src->mt), GFP_KERNEL_ACCOUNT);
-		if (!dst->mt)
-			goto out_mt;
+			memcpy(dst->mt, src->mt, src->rules * sizeof(*src->mt));
+		} else {
+			dst->mt = NULL;
+		}
 
-		memcpy(dst->mt, src->mt, src->rules * sizeof(*src->mt));
 		src++;
 		dst++;
 	}
-- 
2.43.7


