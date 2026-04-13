Return-Path: <netdev+bounces-277951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBNGEJtz3Gn1RAkAu9opvQ
	(envelope-from <netdev+bounces-277951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 06:39:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C399C3E750A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 06:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 274CC3002B3C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 04:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFC037CD29;
	Mon, 13 Apr 2026 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HpSI2RVO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945D220F49
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776055193; cv=none; b=SqPzqsP3o5nxrBnLp6+yPiRgLEUSqmSEoIkKlunhuHH+ulm61Gl0cg6J/Ot/ZhwsiGfBpKZgC8liGR0RahkNIp7su1S3G85Clsgqy6U+tNwQp6Ad4hV2g5GRcCBZxcQzIB+5A5Sml20F61HzCmzBC4GGzdxfBgE+gbCyV1d062I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776055193; c=relaxed/simple;
	bh=wtSSTcWRwe559pZ1gDdmuMpz8Bc8ySi6j0tYNMZuVwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ycf0BAHX7j5YP0eMehGZ0wRZ0TwJHKYAZKAS2ZJctCRhMLuYkU6l1es9FlwxwD7XR7ioP3/N1OoQ3B/3SFWyXklGoEs2krZUm4IlEWL3BhoNWZFpmfltiY6/5tGWPeui0dRCZUZGPAvyNxPYcNwttXPN3QA/LQrrF3gOn93dses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HpSI2RVO; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-8d42b9d150dso44366485a.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776055191; x=1776659991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qLamvoygs8XdLleM+az9cX6DHqELe8TmHOQBddVvD8=;
        b=Wbr+4Ro+uyd6xdbnuHbMhRyNcHvix2Ui6M91Di69KqvQBaMqMDMBWkCn2A1RbfqM9C
         dEp1SMnjFUJjg8hcHGWQRLtZ1XHCEZQtqAH5BuQL9Iu4oNK3jha1+wExGhKHjUv8U3rf
         lXUYdHHZBHgSwSRG+pcfUJmJBM4Y6gPtU8XZckHi9VjZHNXx6L2T73MPHksAhdTo9I8s
         HalpNyxHuIArZKgGQ+kZVqe1SDWRrtRgk/2DGqMiS6OLyhMejHemLA57XcsD5bS18hp6
         wtMlWtarL0iZALc1yT5TCcvknrVVKeE/bppDXnuiOjnxzH4pAsSfhJz9GhHYOiRxZPEs
         tnvg==
X-Forwarded-Encrypted: i=1; AFNElJ92MilpSsTgbuubUg5ZqI1r/SzQt1WujwKrqvD29NLacnNiVWKmZNYm2/2DZqRY55+BWcX7geg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyItg1p8CvcP8b4IZLxFpkk3AKW56JyUt4SSnKIMCVzAqUNJ/qP
	4Ucc7qPb9JizLzqMy+Fe+Ar+RAgLOUDqbjIh0F2Idbdp/FZtRmlO/ShDkuC2VVZK8JpNEv+dYxP
	zh5BvALtyaZa93iNHld+WRSHpvL6+fN5JYNBLOTvXV7RbdkX7R7t6V66FhLoh0hkXLAdDSFORMM
	/EpaL/MhCIyVsl2xGWOMGG9uKf7cR85TPl9Hs7maBv8nq9+3VaexX1Upe1HkilRL1a1f6+40STH
	8EPRiqe6D9SLyZHK32/S19Y/B1Zn8A=
X-Gm-Gg: AeBDietBt4QhuPfHiOe/iswMaoavGYKEfsY4h85uuS3SGcE9OKFLR6dGmo4IOTij/MD
	BPODMWYF0ZiJdzh79grAmpKkVKmE7fPjaHbmmXEaY9JnVxVBpms1B1kFcIZBy0QeasagdzeE6d+
	3gT1nMm1RzIVRk+aV8Psz4o3zQASofKUh3avbwxHL600WsT/XYyvl8XTAg+5Qr6K/ECGBBGRS7Y
	9YMzCYMFgtUSaI2hZnld78dtyZDr+akLtItZa2A3yI1kL3ygdbGtsBMFWnBIoF2EBY1zfw2TxSj
	Biwdfg5EmiZzeH2HJiEOfDmvJbVPadDHmxhEzX6oATlHB/2tuhKzo6UQyWS21zwmpP55QfV+3/0
	rDvEZHlnqRVa+gzgp8y5jf9F76BPJl7xGQW3UZhbxD413DywaMvYnYrGrMHCRvDX4++uVwwvWi+
	wl8l5AWm2hiLr25WDRP1fxKwngVOgESXMyIJK417nFLJzpNXZYGbUm7/u7B7jpmvhWEFnqLvgVs
	A==
X-Received: by 2002:a05:6214:250e:b0:8ac:b1c5:a5e4 with SMTP id 6a1803df08f44-8acb1c5a94fmr16619056d6.1.1776055190677;
        Sun, 12 Apr 2026 21:39:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8acafc9f4afsm1498656d6.20.2026.04.12.21.39.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2026 21:39:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b33a19837so12069391cf.3
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776055190; x=1776659990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qLamvoygs8XdLleM+az9cX6DHqELe8TmHOQBddVvD8=;
        b=HpSI2RVOGwNnCY0VhVy7LD9oFYUJyBdHxuVeVw3djJOilW/R2fsFD2cFr+pqsg+/uX
         zNkFFt3Lis3oRUqevrv02ssMtrQLNl2Gpd07xwMMD+OfKUB5Lp8KXMmknDbRPseZgSab
         6BOFACv3iZ98WfiG9WgIP+7KsPngAYBVk2jcI=
X-Forwarded-Encrypted: i=1; AFNElJ+ItbaPJhMVji0vUYC6ct0abBaHuULjWSK5ZeUpjkYJ7huJ6I+yq/wfNlML2Ibau5KFoOg2nRA=@vger.kernel.org
X-Received: by 2002:a05:6214:258a:b0:8ac:b300:c558 with SMTP id 6a1803df08f44-8acb300c627mr10722586d6.2.1776055189871;
        Sun, 12 Apr 2026 21:39:49 -0700 (PDT)
X-Received: by 2002:a05:6214:258a:b0:8ac:b300:c558 with SMTP id 6a1803df08f44-8acb300c627mr10722376d6.2.1776055189373;
        Sun, 12 Apr 2026 21:39:49 -0700 (PDT)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84cf55b7sm85742136d6.45.2026.04.12.21.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 21:39:48 -0700 (PDT)
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
Subject: [PATCH v6.6] netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR
Date: Mon, 13 Apr 2026 04:32:23 +0000
Message-ID: <20260413043223.3327827-1-keerthana.kalyanasundaram@broadcom.com>
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
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277951-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C399C3E750A
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
index c3ada6798d4a..98cdeb9fa210 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -525,6 +525,8 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 	int i;
 
 	m = priv->clone;
+	if (m->bsize_max == 0)
+		return ret;
 
 	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
 	if (!res_map) {
@@ -1394,14 +1396,20 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		       src->bsize * sizeof(*dst->lt) *
 		       src->groups * NFT_PIPAPO_BUCKETS(src->bb));
 
-		if (src->rules > (INT_MAX / sizeof(*src->mt)))
-			goto out_mt;
+		if (src->rules > 0) {
+			if (src->rules > (INT_MAX / sizeof(*src->mt)))
+				goto out_mt;
 
-		dst->mt = kvmalloc(src->rules * sizeof(*src->mt), GFP_KERNEL_ACCOUNT);
-		if (!dst->mt)
-			goto out_mt;
+			dst->mt = kvmalloc_array(src->rules, sizeof(*src->mt),
+						 GFP_KERNEL);
+			if (!dst->mt)
+				goto out_mt;
+
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


