Return-Path: <netdev+bounces-278300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO5AOw7j3WnrkgkAu9opvQ
	(envelope-from <netdev+bounces-278300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:47:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D423F63B3
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9E05307AE5E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 06:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B436F43F;
	Tue, 14 Apr 2026 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ti2EBGoj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDC236EA86
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776148818; cv=none; b=SeNY7ZeQwb2tDP/p7fI6vhxxEe8xds/ByCe7rnhJPqfVtQCIYnujuvh7ryYQ5AkrEGJjjgP52q/7ipEA2jF99iytbbHlSK/hvb1Eu1WT1baG7hlbCz4KmcKT8Z4OaUJ5D4t+zzJ4d7VfCGD9uYUs9s6GnxuTKicn5df4Sn9dPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776148818; c=relaxed/simple;
	bh=eUByrnPJ2nona1QXhiPKoFAJ4ou5D+Pn4Dg2jpFDt6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PGfsius9L8SsrGUFTNdXtPablRKT2AM2C50zhN2ksykitEjyeHd7Bltm1qFk5rPLe+D4xlqQNPC1CIoawkCqWMrUyuXG2Me24Pk4Xjw9wMranaP53vB4+NNQcPmkMNLhLSzVRZ0637OUOGfPe7pC9oHD3XDsP89BBfAsOIgGaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ti2EBGoj; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7dbb4fdc04eso1171537a34.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 23:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776148816; x=1776753616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2l7i8vnpUJQTdJaWwY66SR5P0SKGOILNorZy9BBZKRQ=;
        b=BwO9yuw7CXYUduRaO/O8aEM2E9isKroV1nWo/Nd9NqBKoxPPTbUs7NFwOVqSWYa/Lb
         RYjeQKWxw2m4m6wKAN9wySgDGuRXgixJWjvfzYSTqO55wke3uGnrbkibsLQqZhbMYZxq
         aCHyEdx51UYOGYTZai5/zSxionu9Bv+Nz2IFtZEYud0boEDcICm+IHgWxDZAyElF6J9N
         soV5b6MlVxkeuF8E1d4MVnZQGCbMIr7bymXzZilCNePX4HLmmoL24OeDdbUdvZf0LXo9
         jUKJGOqvZqByqFkcV4ANljeJJHovhgqQciPG/2DMHYMcd2g3Yjn4PI5xh89UzMopbkCY
         W5dg==
X-Forwarded-Encrypted: i=1; AFNElJ+nCyXkZk9t5nU1OgtHBq4cmW3Qks98y0R18AuGYj/e+J9jTYokDgBBaDNFAske6laCgszWRvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwQZ6BYjPgh2U+DVuAtCXPXk4sYSdIkAzZZ6Q4IF5rViGbQtEU
	BWrVhj3Yq7zflGZsLmoabdk1c6nMW2Iv9KkiGkut4cNRCCtLULJQ58Q6U/xJ9UMtZ+2A85ifMjq
	enSYGCp66/kZVbyowE7M2cI8qJhjQ+irD1Pcm4NmlhZN83Uz8AGZ/fK9iMSqHlpERFv5wnj5dN2
	ZrQAFF8mRYvYl9lyABHc/SN97SFZBqrUfFCyFrkbCDKNSR1ZAstAsbuUL7oKVYSiVk7bHbQS0Tb
	vsX5j6d+NL5Ts2UkeZRu+UdfcGSjPg=
X-Gm-Gg: AeBDieu1AlgsPEnj96oXm9uUGFkH1aEnJJwpGn87vOVgBfXpF/2FnuuM9cJQKaSxj15
	yR03R1VSCazYKjz3TatL3UGMWQVNFV4/ThvuROrQvfc5xnLnjMBKrHJ9uLz976E7WuCjY8K+G3+
	VF0zWisI49sOtTjCfXHs1mCm0SVMOU2ifQ1Q4FTstwgfqElY2cGtlEETwO0CAEUy0nYG0twCy3I
	BV69LfehmTGW1P+Yj+SVqdpZ40URH+ORvwWiYZvOGJImNWduXfFNC1Oqe28cSTvH3YvmCAS0mEt
	2US2/by7jTaETWiSVsaDxUqlF1ILwTXIebx733dt/OqXMlI1Sr3TWbgeAlKCn0J605pLwr5HGcI
	N3OJIyJhdrCDGXSehge4kmqG3PSVX0UgJoXubIpicn+quxyNDAyj9IzF1LVANxvzkzhWRZjAvD9
	SKOwoIK+KrfaOlCW20F3d+vfQP7f/rIgDBhlazrdIh728OR3yvq6GioqFP9C46zdzlbwL/xu/ln
	NxDWAmnhTzq
X-Received: by 2002:a05:6830:3491:b0:7db:c389:64d5 with SMTP id 46e09a7af769-7dc29f23a1emr6718624a34.0.1776148816411;
        Mon, 13 Apr 2026 23:40:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-423dd788a6fsm1585398fac.7.2026.04.13.23.40.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 23:40:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8d45ebdbc9fso104169685a.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776148814; x=1776753614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2l7i8vnpUJQTdJaWwY66SR5P0SKGOILNorZy9BBZKRQ=;
        b=Ti2EBGojhCEoCjHxHmHkv1o2ejoAfa6151Jh1Nh6c07CljOglc3Gg6ilw9iYl3JpGB
         MyCp2ORQ054YiPpwIYlIglO58Sqv24PC0plyxkj0v9j+V8Xu5h4yyx0afm3nrrgikHhv
         YJOtXhgylpAmOE1lrjxoGAuNW8CdR6HZ2Z9N4=
X-Forwarded-Encrypted: i=1; AFNElJ9COeLQwli55gcsdboyM9e+Kqj39oIu2LI9fcdNXUaHn+Jk2Dlkquw7tXu+xzYxkej3K7dwR6Q=@vger.kernel.org
X-Received: by 2002:a05:620a:44d1:b0:8cf:c757:f1e8 with SMTP id af79cd13be357-8ddec1f0d27mr1636846885a.7.1776148814382;
        Mon, 13 Apr 2026 23:40:14 -0700 (PDT)
X-Received: by 2002:a05:620a:44d1:b0:8cf:c757:f1e8 with SMTP id af79cd13be357-8ddec1f0d27mr1636845685a.7.1776148813891;
        Mon, 13 Apr 2026 23:40:13 -0700 (PDT)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca5222c8esm71566416d6.28.2026.04.13.23.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 23:40:13 -0700 (PDT)
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
Subject: [PATCH v5.10] netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR
Date: Tue, 14 Apr 2026 06:32:43 +0000
Message-ID: <20260414063243.4062926-1-keerthana.kalyanasundaram@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278300-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 97D423F63B3
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
 net/netfilter/nft_set_pipapo.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index a4fdd1587bb3..83606dfde033 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -524,6 +524,9 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 	struct nft_pipapo_field *f;
 	int i;
 
+	if (m->bsize_max == 0)
+		return ret;
+
 	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
 	if (!res_map) {
 		ret = ERR_PTR(-ENOMEM);
@@ -1363,14 +1366,20 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		       src->bsize * sizeof(*dst->lt) *
 		       src->groups * NFT_PIPAPO_BUCKETS(src->bb));
 
-		if (src->rules > (INT_MAX / sizeof(*src->mt)))
-			goto out_mt;
+		if (src->rules > 0) {
+			if (src->rules > (INT_MAX / sizeof(*src->mt)))
+				goto out_mt;
 
-		dst->mt = kvmalloc(src->rules * sizeof(*src->mt), GFP_KERNEL);
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


