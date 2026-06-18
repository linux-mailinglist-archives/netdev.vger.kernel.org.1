Return-Path: <netdev+bounces-300357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lx8cKeOuM2oaFAYAu9opvQ
	(envelope-from <netdev+bounces-300357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:40:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D617569E830
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:40:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="fnPi7h/+";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300357-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300357-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1882301F300
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D6C3A5E6F;
	Thu, 18 Jun 2026 08:37:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D43AF64F
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 08:37:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771861; cv=none; b=fX1UodwNxtlVomd7yEdzupQ//o8eYBi7r4r56bAKbbjbn+7v5e+q2U7jv0TPT7IJg9jns/ae2KeGLkOo8Mr76yGLgpTq5USjQ5sLr+kYS7M83v+yteU17AULK5y8EzjlPA705IGfDmA2G8BS6i1m8f75+ENs1z2aIyrwQ5HA97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771861; c=relaxed/simple;
	bh=aIbJosctl5OF9ZsLu4oXkOHrco919wfqLXR+++iz1xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnbChRdhMNMlYh0JgELk+Si5bFIhDK5EVoQpNTvcrZ9aHmHZXXvtEQjgM8mYpHG/J0V+Txj8w60R0VylTJxWc+wz2DJjlzvQspb8bQsTUYVafUM58/y/DmblqVg/obqU3KfRaM1JWPz86johKZiDLgqM26NJkbnIt6Lr6YouZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fnPi7h/+; arc=none smtp.client-ip=209.85.214.225
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2c168baac83so2980765ad.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 01:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781771856; x=1782376656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9hVwQ2uFHG9yjsxEMthJtly1U3KRAfycxfm9+vQlLA=;
        b=bumIvjtWa/b7+WXocuZfCQ/m1iN4020asCIyLjOks157LBddLih4tY+zARmP/j9tEK
         6oMV2pMgggc0VKjuBkuSZxsQl3I9rVGVYfrqpagbBhp8KYV0Y1nCvIQ1Q/FIKXq8NGS4
         5h0whhHcHaWmyNWUkM9Zlhxqz1NStXNHmfFfGQDLUMkcvD7nEk4qB4Gf+YqsrLeayguC
         aBNbm0fi6P6vbfstP2oTIdhiBUSBlzGr0Cm658EOy0u9LwYU4EO9s2HMDb3Ompp+vfPD
         Ozd8S8+XKvu9UOaYZYSbK7JO/y4mO4uU7A7BlfJ3zSed+nsNbClnireCmU42/tYHc0QO
         7PQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8E0Y9WnwaF8cu7DPXydaR/mQqmGVkY5cNi8r1f7bkHzWIjWELDZl1eBTDoiRyig1oTNq/AH84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIXYRBHhVKzrlBQjZpBOHWnU19o+5fYm6AyxDb0sp1Vlfvm20t
	45Xhdfmo1cCuXhtW90URz+zG1XQzYGUQLmVaVcV3k3PtoWNqEDpcMpSd4YntHGhyF7v1bSKJCg8
	9xDa24Fo6x4Nexq2oAchTuc4bNL9NVafduHf1IPd+XWfAq87ZBF0nAT+m6v03LZXZlsW+c6/3V8
	yhMccnPu/88mT9le8sr3UolrKd/sDiqeo1fvL7BHrGnNNUepqCP4vrzVnyS/l9b/THtEQBEEqnF
	Xe9XlIoasC1b/cheQ==
X-Gm-Gg: AfdE7cn6DpwJJIPb8qJ5B9lrsJfyo7Rbul2AaADeIozndIZCQtoL5s/X0o1UPdin0zO
	jn0WJA3rsRgf7ED10ZL3ImRnaWhdmdV0Cxcxi8mFkGF7xxY96J0vQated+XefjKpDZ1cfgApDhv
	SNg+3IlQmuqO7tUJs8ZrIZDSLUDtVK0ey5z6aRgzOv/SnjkoqYaKxG55RnApF2gouhl+Kw7E3Jp
	6IYVP7sRZc/o9cAUR5Kq0IeK8oVI9gR7IRcLiqpG9EfNNcFjfhqabSPlAyCwLbSJDW8H8hAXTyX
	M/LgiQnEbUL966/uVHSkySz6IBqdaBm1PUyVt7xrlCxTlMfCjyzAjqmJuw7b6JtsnGY41NN0pER
	r2YXXkH6sZY83FPVHn5YLGfhM4vMZk7z6knAdBNQxIBG5/1En8MtYuiidDlMlNIkZef2v38hzLP
	upJku4qA3ZG+ImxsM3JgaBoLf5gUvXhNo8k6lQNRcxIat8jlxrJQ==
X-Received: by 2002:a17:903:19ed:b0:2c1:6e2c:a5e2 with SMTP id d9443c01a7336-2c6bc221b98mr77909135ad.17.1781771856151;
        Thu, 18 Jun 2026 01:37:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c4329a3a83sm15608925ad.34.2026.06.18.01.37.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:37:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bccca5620so778851eec.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781771855; x=1782376655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9hVwQ2uFHG9yjsxEMthJtly1U3KRAfycxfm9+vQlLA=;
        b=fnPi7h/+J2SSTjCUSzrMopCYHYLHUIfXhy7fUkFFuJ3ZYuFFnAN88eLJ7ca9wc+Mv3
         Uk5ttiN7FpOJ5UM/EZNSwALdHsc3zPxqqIT2wOzrKSd1HqJlD4rResvS9Ua5YIC5NnCA
         /XDh5FfLTugpc0OmaVWsnjGz/J6tZe+KC1haw=
X-Forwarded-Encrypted: i=1; AFNElJ8OHNGDTOjVbMCHx7C0DPboOtpk4tSZ47w4NlRfF0EGSdPTAJpdzXSAWtiA0fdTHTml+Ig32Uc=@vger.kernel.org
X-Received: by 2002:a05:7300:2209:b0:304:acc:f079 with SMTP id 5a478bee46e88-30bca09e535mr4462725eec.27.1781771854585;
        Thu, 18 Jun 2026 01:37:34 -0700 (PDT)
X-Received: by 2002:a05:7300:2209:b0:304:acc:f079 with SMTP id 5a478bee46e88-30bca09e535mr4462680eec.27.1781771853897;
        Thu, 18 Jun 2026 01:37:33 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm27475037eec.4.2026.06.18.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:37:33 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaosuo@gmail.com,
	iri@resnulli.us,
	jhs@mojatatu.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	GangMin Kim <km.kim1503@gmail.com>,
	Bin Lan <lanbincn@139.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10 2/2] net/sched: cls_u32: use skb_header_pointer_careful()
Date: Thu, 18 Jun 2026 01:08:07 -0700
Message-Id: <20260618080807.1269070-3-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
References: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SEM_URIBL(3.50)[139.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300357-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,139.com:email,msgid.link:url,linuxfoundation.org:email,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALLOW(0.00)[broadcom.com:s=google];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiaosuo@gmail.com,m:iri@resnulli.us,m:jhs@mojatatu.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:vamsi-krishna.brahmajosyula@broadcom.com,m:yin.ding@broadcom.com,m:tapas.kundu@broadcom.com,m:km.kim1503@gmail.com,m:lanbincn@139.com,m:shivani.agarwal@broadcom.com,m:kmkim1503@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,resnulli.us,mojatatu.com,broadcom.com,139.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D617569E830

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit cabd1a976375780dabab888784e356f574bbaed8 ]

skb_header_pointer() does not fully validate negative @offset values.

Use skb_header_pointer_careful() instead.

GangMin Kim provided a report and a repro fooling u32_classify():

BUG: KASAN: slab-out-of-bounds in u32_classify+0x1180/0x11b0
net/sched/cls_u32.c:221

Fixes: fbc2e7d9cf49 ("cls_u32: use skb_header_pointer() to dereference data safely")
Reported-by: GangMin Kim <km.kim1503@gmail.com>
Closes: https://lore.kernel.org/netdev/CANn89iJkyUZ=mAzLzC4GdcAgLuPnUoivdLaOs6B9rq5_erj76w@mail.gmail.com/T/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260128141539.3404400-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Bin Lan <lanbincn@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Shivani: Modified to apply on 5.10.y ]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 net/sched/cls_u32.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index f2a0c1068..e501390cc 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -149,10 +149,8 @@ static int u32_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 			int toff = off + key->off + (off2 & key->offmask);
 			__be32 *data, hdata;
 
-			if (skb_headroom(skb) + toff > INT_MAX)
-				goto out;
-
-			data = skb_header_pointer(skb, toff, 4, &hdata);
+			data = skb_header_pointer_careful(skb, toff, 4,
+							  &hdata);
 			if (!data)
 				goto out;
 			if ((*data ^ key->val) & key->mask) {
@@ -202,8 +200,9 @@ static int u32_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 		if (ht->divisor) {
 			__be32 *data, hdata;
 
-			data = skb_header_pointer(skb, off + n->sel.hoff, 4,
-						  &hdata);
+			data = skb_header_pointer_careful(skb,
+							  off + n->sel.hoff,
+							  4, &hdata);
 			if (!data)
 				goto out;
 			sel = ht->divisor & u32_hash_fold(*data, &n->sel,
@@ -217,7 +216,7 @@ static int u32_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 			if (n->sel.flags & TC_U32_VAROFFSET) {
 				__be16 *data, hdata;
 
-				data = skb_header_pointer(skb,
+				data = skb_header_pointer_careful(skb,
 							  off + n->sel.offoff,
 							  2, &hdata);
 				if (!data)
-- 
2.53.0


