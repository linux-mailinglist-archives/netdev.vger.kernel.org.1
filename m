Return-Path: <netdev+bounces-252878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFZnFkWgc2lqxgAAu9opvQ
	(envelope-from <netdev+bounces-252878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:22:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C22F2786B7
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD4D23021599
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7002D3A89;
	Fri, 23 Jan 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYAsjmwx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097E5212550
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185345; cv=none; b=tOuGHjg61lXAgRzCqiiuehKzynUO+Vt+2X7gDgO9YtEF8PmlNBsdnxYffIagQXjVvD7RwlBzhcqKLaucA0Eahr93v+OvwFA4HZ+P+s7c7/kNjDE1SJssdWpejcFlMbO68vuR1qzmSi1mgqLjVOApW8htV1hxq7NqxqJr8g78fBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185345; c=relaxed/simple;
	bh=w5MIfnlIHaBZE9Sx+nDab+c35nSGwa8xj0TFBnbl3RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrAcNgkyaluss/Nz6a8dGQxY2x5xy7lewCm8I6mHNAg1QvhACwz06xI9cSGJQ9ANMaYZZAMO87JqNCqJNAHOFDbgPPFoOtudPg6wo8Y+AzLefTtuWjFb19CAe0i89FkR66wozFU14A3RgLpfTHgj5wuCHBe2dAbfXJP4ZTf5HEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYAsjmwx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8230d228372so1028251b3a.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769185343; x=1769790143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1hAVBooT6RSatSb0JkTTI9JelC7CFfOn3FnTuarbB4=;
        b=DYAsjmwxu3adShH3XSnF59IQqoBbiazlOzRhwU8sDXDpIni6snHqasTsswFd6vGHdb
         oP88BvSbTABYhYtrHTxCoTwD6ls9O2ygMjTFXnSeElpsx9gsnplq2qLl01hQvqQpRH9q
         Fqe3e2p/uwarWt8kEzt00Ls8wBCtFfrj07PqrdlrSgtUvmCDVMeQCUzo1/fxP38JhIwl
         w8BJTms5Tgs5rAoGP5GIvo0Lg38sUZeYnPb0jh825q1IkgXUGsAtlHKNPMUB+BC4d/mu
         J/wCjC09I36X/r5gr1ABpx/qRT8Od3D4guo7SMw5BQgr9uMrGYlxVAIBxwLuRy3Veihe
         gtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185343; x=1769790143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j1hAVBooT6RSatSb0JkTTI9JelC7CFfOn3FnTuarbB4=;
        b=FVG8Fp8aYBhXkC+sanoymqhng7H2HIlkeoZI3ud6kmveqbGPAP/YfQZzwnQT4qTM1s
         YXHcqTsSdiQOPIOd4i2E3PHUUdrU4Y+p53GCIB1ICvrH4NTNkSW3Wjm2Ph0monbhUpox
         serTFXgAjQLiHvtoWwWzlMhlq4lbXfgD8u6/CNpjRxPuOs3o8mPtLk5Nrp7z5UtZWF9l
         2tHql4264fQhcVP56ad6DphSwki7UDZb/vIMwRbjCtmAygqC8VHZTIgLdand+ZnjEs8V
         6XjecB4ug4wyb3hKFppGysIvSrGpncuz9RP+1bLENI4PAK8XI8MoxE15kqdHcG/OXHm0
         U7iw==
X-Gm-Message-State: AOJu0Yx1y52OujIut+teThduS2QzKbCHYDCUsF48h1o8KP3AlYx52x/y
	9VkJGHkwPdBIRhb8hzDwvQW8K0dOSrwatlzKNL/YpTeZDj4xoVi955SNZVtD4g==
X-Gm-Gg: AZuq6aLRrLOnWzfIqeh50iWVbA6A8Dot0askv9mzrHLf0ElxUN66ZARZbJpJwRmpXkv
	yq5c5dxupg8YbNe25HFMHvXSxOf4BDvuUlJ0g1+dblS896TdYHsRDygOKmj5EONN9dcmz88q3Dx
	2qLV3JBcH1FMGvnsW6q1H00siDhzwIN/1VrYYfKDcpN9gGNBuWFva94hvKOLnbeZfekc+sniM+X
	fxjR3kLaYE6as3myWy3WB1csOh4Tl7ouZ9OL/2WTJlhN3rvzGj9zGNAReJ/1eFoQNJ6mKa4pKFD
	CpCRJnLasu161wNHHGVJVzbYrMZsOyXKFzrqlJ+ilNKoM3yGAxaZS0kw+rv0S3gxg+bItdeV4n8
	VSn2Ty1WdIuG6EzfVOadHPiUKoFeVmgzLdq9MmFicxroPjWsabtopOY8hKY40kXM/3qEbNvoHeN
	Qp5tEWObt2w3Y3qGHvL+4pSQh7LEtYu6pcA7KVchcY7pIeCY96DrE6EA==
X-Received: by 2002:a17:90b:2244:b0:349:3fe8:170d with SMTP id 98e67ed59e1d1-35378ba82b6mr1242634a91.3.1769185342968;
        Fri, 23 Jan 2026 08:22:22 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50882sm2496967a91.16.2026.01.23.08.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:22:22 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Breno Leitao <leitao@debian.org>,
	Carolina Jubran <cjubran@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	dev@openvswitch.org
Subject: [PATCH net-next v2 1/7] u64_stats: Introduce u64_stats_reads()
Date: Sat, 24 Jan 2026 00:21:33 +0800
Message-ID: <20260123162159.2877941-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123162159.2877941-1-mmyangfl@gmail.com>
References: <20260123162159.2877941-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,nvidia.com,ovn.org,fomichev.me,debian.org,vger.kernel.org,lists.linux.dev,openvswitch.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-252878-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C22F2786B7
X-Rspamd-Action: no action

The following pattern was observed in the code tree:

        do {
                start = u64_stats_fetch_begin(&pstats->syncp);
                memcpy(&temp, &pstats->stats, sizeof(temp));
        } while (u64_stats_fetch_retry(&pstats->syncp, start));

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() or struct copying does not
guarantee tear free, although compilers never generate such instructions
in practice.

Theoretically the affected code should convert to u64_stats_t, or use
atomic operations properly.

However since there are needs to copy chunks of statistics, instead of
writing loops everywhere, we provide a safe memcpy() variant for that
purpose.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/linux/u64_stats_sync.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 457879938fc1..15ea4db2a77b 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -79,6 +79,14 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return local64_read(&p->v);
 }
 
+static inline void *u64_stats_reads(void *dst, const void *src, size_t len)
+{
+	BUILD_BUG_ON(len % sizeof(u64_stats_t));
+	for (size_t i = 0; i < len; i += sizeof(u64_stats_t))
+		*(u64 *)(dst + i) = u64_stats_read((const u64_stats_t *)(src + i));
+	return dst;
+}
+
 static inline void u64_stats_set(u64_stats_t *p, u64 val)
 {
 	local64_set(&p->v, val);
@@ -110,6 +118,7 @@ static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 }
 
 #else /* 64 bit */
+#include <linux/string.h>
 
 typedef struct {
 	u64		v;
@@ -120,6 +129,12 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return p->v;
 }
 
+static inline void *u64_stats_reads(void *dst, const void *src, size_t len)
+{
+	BUILD_BUG_ON(len % sizeof(u64_stats_t));
+	return memcpy(dst, src, len);
+}
+
 static inline void u64_stats_set(u64_stats_t *p, u64 val)
 {
 	p->v = val;
-- 
2.51.0


