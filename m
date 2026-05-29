Return-Path: <netdev+bounces-293019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHWaInk/GWpVtAgAu9opvQ
	(envelope-from <netdev+bounces-293019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:25:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E435FE7E2
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9749D303B6D4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C14237C0FA;
	Fri, 29 May 2026 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okIJ7jlU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEABA2FE074
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039177; cv=none; b=ra4vb+bcCG8JNsDMDLsL95RZWalbsKRrRsI/wP4P0nOvYJjUBMNvSTBLXetW2dAwTrWK2l4lxqh9QfzO3rKMRubkrM+1cAaO2iVNpdybYeTWsr6+Pp3eeuJRkBQf+/U68X6vrI5M9Low3VC4jse6aXEIozKdqx+aExOIyZGXogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039177; c=relaxed/simple;
	bh=lvBzjbjwsHSamzgVJuzljlh4xQh6VT+oxbFJ8mT/Hxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o9b7EWfU4rI/+EN3pibGqfsF41UpntsMbx1KF7cwmKpZQFf+TBZ6d4rQ81LnmarE5C+KeCSm/jIpJZ4vYcKELlWfcnFujfjCmSq3yK1GD3cvfC+rODzvj62ueqa7SYLR7FVSgyoyU28iogAZz3U4baE+VpiiDx7PnucJsKHbcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okIJ7jlU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso58660675e9.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 00:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780039174; x=1780643974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUPoKgsqf9IYvngriOSrkcKb9UgwJs35aRy/89k4iTs=;
        b=okIJ7jlUKfW5sZnnGznruIenfW31sXofygIixXJDqPcmOfCgu3SmmoVAm8dRUqWpu8
         r5opeZ5KDerJC/E6fJMOlfA1fwxjO0f8pVp76bOWCHKR1AFMbkZC5H3hpEQqbSmPmokz
         OyC8970+UZ8FmjvvKSuVAX+6P5YjZzwlnANcunIz6Cf757K3vUn9E71uGBmrL1ZiWZnT
         RhASMYX5Zgu1dhr8CFLGJ1POHy3hN47Wzq15HAWlmTAN+2K4rogtxm2ma+5EW95uhT4D
         LbhFscJLfs5I+ab+Chj0EAHFGMZKRqUyN7CsyZQz8DdTObvEvicrN1Rg65FzksWUl9HS
         gylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780039174; x=1780643974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUPoKgsqf9IYvngriOSrkcKb9UgwJs35aRy/89k4iTs=;
        b=bmYOPqDBLQuKolcpz2y0zh1ivSKncuQBrfMCo0UmDmNfWyAbrWLu7S7rbMe/aMQEig
         t0Z+HDZYvHmvtuC61JIbThMaAg/6G0XTzP9KJX918x+RphvKO+6ElkF6H6TCPTfFRBQh
         UNZLYBjSSI4IbmQM0gZof7+x/aL6y+8pKNCvOaDJcsXoNQmI3BNabiVersVUkvxBOQ+V
         XpzhjWMVz9gDUs6bf0fIQ0klDBpKytvpVeyz0EnrHywAuV2WYoPZqx1FVbcTBPTM7g2v
         TTy/tlfDMv4YvoLwnG92k//y76oymtlbRxGzJp2wi5KwOIMjxJygoW1OvVCMpFsbDFC7
         OP/w==
X-Gm-Message-State: AOJu0YwjHSRJEEyXceEuMU9tf4fBTHO/3IzzqnP+yhQ1PPXgZKz6rVTU
	3AXqeMTg+qbcKcWHCp26K/3d/sRmObLRGMj1D4fEl71CXIoGQMkSwL9l4xA3Ga9/
X-Gm-Gg: Acq92OFDpZnrP92f8m+20ppen8aCl9+MRyRYZgV950lNOcg8vg8dvnpynJNazR1Uzye
	YDvFjj/seZhnE9F0BWj7K2S//qLRR8XUhNgRYsrbQHdcrENtHsIgXcMOpISbXxOrTyVOS9fr6Za
	GDYKEUGqt1H5a1DvGQmlPpK84n1kZZqYX2ALrOuPcmMEmSfxHzwcahR0WNbN8vgemUNvA/lbPyY
	5wiehDaEiQkWAtlncGrdQQidYpeJ61aaesvs22aJ5KP3BCyu1XGalZhyL2cAkzNUrSiZMcYOMEA
	YGjRXlsoLtCdinypSHUBeCN/zbax9p91Hgofsm1dqcu39sGw1qGUX/J+ssKNZqMBSUMzfiYf1cw
	/k376yE2+Q2cIZBEiSuUSoyPOWPuxYjt8Quq1U4fzO+aWpO0UI4t9nMVsdPWVs2eF6EdVbDk+Ft
	bIUcBOAuNvy0F3j0ojPBNGSlAO0BZezrhtPdCrFOhkYDTcsGf5yvD5GrGdr6ttpc6so4MO98xWk
	3/5M0R/YKD3X4LfEPacWhTSGenPGz+ZC0l7GbF6eBJtgPv8+1g43oeQsU2AsQa6zPjjUvUVvMMc
	ww==
X-Received: by 2002:a05:600c:c3cf:20b0:490:5466:8591 with SMTP id 5b1f17b1804b1-4909c07f2b1mr20575105e9.12.1780039174418;
        Fri, 29 May 2026 00:19:34 -0700 (PDT)
Received: from localhost.localdomain (host-217-59-207-212.business.telecomitalia.it. [217.59.207.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c114e99sm8610615e9.25.2026.05.29.00.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:19:34 -0700 (PDT)
From: Alessandro Schino <7991aleschino@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Alessandro Schino <7991aleschino@gmail.com>
Subject: [PATCH ipsec] esp: fix uninitialised req->src dereference in esp_ssg_unref
Date: Fri, 29 May 2026 09:18:46 +0200
Message-ID: <20260529071847.1301-1-7991aleschino@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-293019-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[7991aleschino@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E7E435FE7E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When esp_ssg_unref() is called with already_unref=true, req->src has
not been initialised yet because aead_request_set_crypt() has not been
called at that point. Use esp_req_sg() to obtain the source scatterlist
directly from the tmp buffer layout instead.

Fixes: 2982e599fff6 ("esp: fix page frag reference leak on skb_to_sgvec failure")
Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
---
 net/ipv4/esp4.c | 2 +-
 net/ipv6/esp6.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 5d3a8656687e..2429c7845984 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
 	 * Skip the first sg which comes from skb->data.
 	 */
 	if (already_unref || req->src != req->dst)
-		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
+		for (sg = sg_next(already_unref ? esp_req_sg(aead, req) : req->src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
 }
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index b963b8e72604..50af6ab9b8fc 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
 	 * Skip the first sg which comes from skb->data.
 	 */
 	if (already_unref || req->src != req->dst)
-		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
+		for (sg = sg_next(already_unref ? esp_req_sg(aead, req) : req->src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
 }
-- 
2.41.0.windows.3


