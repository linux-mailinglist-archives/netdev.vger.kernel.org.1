Return-Path: <netdev+bounces-255138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEkkF/arfGlsOQIAu9opvQ
	(envelope-from <netdev+bounces-255138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:02:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA887BAD7F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F1A0303F05D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1337F117;
	Fri, 30 Jan 2026 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUDwfrtM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961C37F102
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777962; cv=none; b=G5DZWPcv+0SjU9MrCpoZFnCUdjsrVRPmKrKQdUOAZwjIwVt3n1Vyp6zRuXlWHb2AM0m34G3+7QpjY4qSTu+E9+cRvQjAb7B3lDd2Ug1DshbPBrJMVTvhkFeYfjoBEXvuSr9h/D1ibpcoeAIcKyx7UnXsx7qZtxCvvkMiMD3HUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777962; c=relaxed/simple;
	bh=dg9kYr8aZfQN0Z5Niq94kmT7y8LXjeCMZKoKN1fucL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LnT0+ibbrUm4y+GPIiDxKnK668AF9vSN0In7xpqBTH8FaqQ76V5qzo+/GjfKjMsjoDoBedp7+WIJZHvAD/8JrcxJ5hCPCW3am7cjDxhtvTY80Wsp7ACVxnrCMmH0KSI0PP4DkiZrIxE1Gj56pZxcYKuiAVE5Dco3NU+BODrtth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUDwfrtM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806bf03573so11443055e9.2
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 04:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769777960; x=1770382760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQzOK0aKaeoderdrXRGweVvWgIMEPYBk9+gZ71lrHVY=;
        b=TUDwfrtMBRTOay6PjScNvnb/YvIhPKnrWTzlLshk33D4cWqqb5SLCG52f8zVAp20uv
         f5j8HjAzxGwkD5/B01OKkAsq3mV+3OVOA6ItUUILgxa/HE2zd/uPFd2NTMHiL6IbnfER
         5ou8z1ASnJnLsY8ycmksZISmadxU+Y39FF8RSgpPYARgJGbg65eGIyL2mrPYcn31Ucas
         mCB6zp5rSJr0xNauFu3adYMV2mqIUgg+OXmmyUOe+/5G35PprQRznL4g5VkxMH/9EApL
         vSbIu/mO/TKuI1OTa/BwHMdJ+G0CcjoUcqcZ38X7GptBBd1yWC6gEVH16Q8NDBLsJV8Z
         Y9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769777960; x=1770382760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQzOK0aKaeoderdrXRGweVvWgIMEPYBk9+gZ71lrHVY=;
        b=I45bekihpFSFBG1meYq0UaYrMc16ekJynj5NWIjYzmy2DIb2IWSm20sbqx4jnWZS6h
         qlOXaIJDIlVOG/e44vxtbOsxgKgWcYs2oR5ZMT1AOhGndLG8n8dMexs2g1PWF2j+MRlv
         euyPnGlhKqhTDhOLOY7k09cSJOUibjGPXMbpjDUODoh/uGLV8zA/gw2BPUt4dIR6hDmU
         zuWAbqQiRE9qjTt/hAUXvsIxoWa46LUOFsEKCTX5bws+tWuqbpJZSwdJ+kWpH++tjdvu
         MF+7rhi3fS4hvXurzzfu9XZp9ELlmq52XXucU2X7gdyfz95zIjhQgFq6ZK0KLlKwt/Ky
         a+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV1uvHnCN2YBTtKd6Gqt6+hHu94GO/kMMqk6M2i87h7q3S07+JC3b1bPFzC5skZf73xmfUF1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfJ+LRwTlkmvRLeSFTbJOQbbJJKVrR70eIL+oyXIAdA4l/e/L
	/RIzu3wfp21qyfESqKHdL3joFjDReQ2FBtmi+SRx58lZo4Hxi9quAVo4iqP8oA==
X-Gm-Gg: AZuq6aILlQnoOv/Jyia9cKoHTjs7VHZtMwkXJr/GTtxzgu26bhLIldeOw9o5JIS0vpE
	KURjgHQP+qUcEVE8LUIgzPY4FAsA74QLohZ0VXTSHCUjluOwgncXAAnr/FAhP/Nf+ChPMVv4Lhu
	vSS4OAE0OdD0a8f8WW6JvScu3HQBwvMSbAFXWOOQIJCNQSA0zkLtOsLmpeq2qj0lGUqdmEbMAxN
	Wr0MrtwoSBNs/JlO7WNeYGlu89MHMsec61dpgK5cn+R3mW+ednruUjPGxqHNMMYssDY2XihxugA
	HQpZGx7gZHb+ZR5fu6vx2w1U1vL9++2Wc9X7nC+szS2wpIzERtWEzQCrjH+d2Gm+MKHlU1uKD42
	3KBoA3oI5N77vL8ktFD47UxsxvNoUmEaBEfXQo4CvZnm0ZNTBGdBMSceudyZlys/XxlHetWo0FS
	zW7cz9hUou7h4+vYIOHlxnFVZtMDP0K3uREbCgCkqkjhZFAbWDI0JX1VgQXioMw1BpmS7+
X-Received: by 2002:a05:600c:190d:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-482db452371mr35162815e9.5.1769777959687;
        Fri, 30 Jan 2026 04:59:19 -0800 (PST)
Received: from anesterenko.. (62.43.64.127.dyn.user.ono.com. [62.43.64.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37433sm237357355e9.10.2026.01.30.04.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 04:59:19 -0800 (PST)
From: Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
To: jeff.johnson@oss.qualcomm.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
Subject: [PATCH] wifi: ath9k: add range check for epid in htc_issue_send()
Date: Fri, 30 Jan 2026 13:59:15 +0100
Message-Id: <20260130125915.47036-1-alexandernesterenko837@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255138-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandernesterenko837@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA887BAD7F
X-Rspamd-Action: no action

The fix for CVE-2024-53156 (commit 8619593634cb ("wifi: ath9k: add
range check for conn_rsp_epid in htc_connect_service()")) added a
bounds check for conn_rsp_epid in htc_connect_service() to prevent
out-of-bounds array access. However, htc_issue_send() accesses
target->endpoint[epid] directly without validating the epid parameter.

While htc_connect_service() now validates the endpoint ID before storing
it, htc_issue_send() can still receive invalid epid values from callers
such as htc_send() and htc_send_epid(). This provides defense-in-depth
against out-of-bounds access.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Signed-off-by: Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index 00dc97ac53b9..7821a31c0abb 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -23,9 +23,16 @@ static int htc_issue_send(struct htc_target *target, struct sk_buff* skb,
 
 {
 	struct htc_frame_hdr *hdr;
-	struct htc_endpoint *endpoint = &target->endpoint[epid];
+	struct htc_endpoint *endpoint;
 	int status;
 
+	if (epid >= ENDPOINT_MAX) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	endpoint = &target->endpoint[epid];
+
 	hdr = skb_push(skb, sizeof(struct htc_frame_hdr));
 	hdr->endpoint_id = epid;
 	hdr->flags = flags;
-- 
2.34.1


