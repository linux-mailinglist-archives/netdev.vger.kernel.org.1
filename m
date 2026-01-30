Return-Path: <netdev+bounces-255137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNQiIpKrfGkaOQIAu9opvQ
	(envelope-from <netdev+bounces-255137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:01:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B7EBAD2D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C1D23037143
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AE737E2FE;
	Fri, 30 Jan 2026 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQT31aW9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F634DCD2
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777815; cv=none; b=COeKSG/w27pWJnpktOO0QhlMR7WwCSmnfjZtLiiAoyORnbdWOZzHvgEtSsAGjkCU9q9cvNOavMe+F8BfRkJiOmR1B1dZu+qvfcu6K6czr8osG2AKScv6SdCptyCXrE5t0ssDWtJ5oNW+43MSJvcuV9U/Ny9wHEyJlEJ7Xe7YBEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777815; c=relaxed/simple;
	bh=dg9kYr8aZfQN0Z5Niq94kmT7y8LXjeCMZKoKN1fucL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ke55j/Vb9zQeVaPezcwZpsMIg6Aq74qiOSP7uXSj/kzdLMT9OR8mdxg1mul8+gi9IgKFN1sWuAQlnFbjj9l6TNMWMxGSfFCAj8kTD38qo3iggQbMOrVuhhUUmzAvcidhpKK9zU5JOLzKCtVCW1pWddL2fjYw2KfAslDtKXQa35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQT31aW9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so20119705e9.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 04:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769777813; x=1770382613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQzOK0aKaeoderdrXRGweVvWgIMEPYBk9+gZ71lrHVY=;
        b=TQT31aW9kXm7Y4MrPD9NDb+keD+yzYvE0/tN9KSiKLKKif5eza+UuY0Da1Z9j38xxU
         ehJe/rX57rm/7QOOZ0Tr6B9iOwJIeXzDoV6l3nTIQc/URTBoo2cHNLB3IsXMRVNHml0B
         fhQApywnFACwOZ4xn4WbpQWPYNbZcm9zNfBGA6ys/NTXzFyupljiU565bNCFRRbaKDs/
         Bf1m3+/w9v2zNo5iFQ2VfjF8WtcXZkL/LWo+PaEbf3JCNp4KzzMkKkRzp6qmCx60ZI6L
         aMZ9UlZG8I8Dn98umdtVOhd/jr0vixXEZQIEFtWmgCy8ZYnxQexRQUS36ldRNzHrXrIL
         VELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769777813; x=1770382613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQzOK0aKaeoderdrXRGweVvWgIMEPYBk9+gZ71lrHVY=;
        b=VBeY1DAjHEQoPoVUC1+Sophr+QBhUDjtNb9hW035wY9XeXFRQ+aWvTG0fZTdhWXs/g
         nwFZJ15hPTtvr5BWlNWU1z4EaAoot1Y3ksC/AGf4Q5XSUn8OHRqXbQLg9HjowsbLr7ZL
         0lUrqBr/FDJ9wuPGIEme02+79U7XElNWEGFMTPaKHOaz4NcreSnc21yOn6WXPOspYm7O
         g5s/syxLfUIoJO603oyVGF/FU4TM5C5ci7oqBSVFhTWRv1jwdtpYN/F9nCBHiErhdMAs
         QINJsKfa6iG3ZSjdZXyzqJCYswRE1uZX3eUkzf4JFjv2iejmLP89ZSGPfC8P7YMWKGGf
         6JlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIMq40f4gjM6QcG98uAUEYXELKTIBmGWCA6PY/9TTIl9vy8NjLT1so0h6GddKK7mowffBUyME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyouCneLnn9vwNeaLrlLe5M+wzdb/ao2HY0V+j/x45CfJCisoU9
	l5pF0kic+ctvcZIDTklQ4iphgZVRHE0cUQgcnYNjUDWhvGWSuQyfr+OY
X-Gm-Gg: AZuq6aK3tKNMyIDLu1ZVy55fHrIQ59tEVAXwVWHzbiUxnr6BkJGNqid9PFI8pdZSIrC
	UkrcZ3A6qC0hICDkP0rWBQ6G07qf6J/+pKZEulGj70Mv6pz4Dx0zggxgl0VC8LBVEz12L130OH7
	brM2Cpzqyi3fgyquvUGsYrmzPWb1KRu0f2cLUwtQ89h7MPaBffSM7n2K5eyz6UvXROjiy/DSu7x
	oQKVbh/iyP5TIRuIrcL3PW8p8S0nktAaAkpG+k34ZZGUDnsoNhskOjIOE+Z7BSfaWP9dF0tzBsF
	HCBW1SuWny9pPPhROMh/9tE0y3ozm9V8w9EjG/solWnwqx186JIuI4Egz7jvRXFty7qs/wEIKYr
	qvAUoTfIGQ5AFcrniwCbMtfH2zV1clGTpL0mScVlkCRhjBYAVsI0IvP8KNvQlHQI9/KRt0tsKiF
	LZU9B8D+yfGQrn736HTzuYypgYKITAFK/7LTYE2X9/VM8ig7KJgG7SjgtmuQ==
X-Received: by 2002:a05:600c:1e8a:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-482db4958famr33084195e9.27.1769777812528;
        Fri, 30 Jan 2026 04:56:52 -0800 (PST)
Received: from anesterenko.. (62.43.64.127.dyn.user.ono.com. [62.43.64.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dffd47c2sm15117155e9.0.2026.01.30.04.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 04:56:52 -0800 (PST)
From: Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
To: quic_kvalo@quicinc.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
Subject: [PATCH] wifi: ath9k: add range check for epid in htc_issue_send()
Date: Fri, 30 Jan 2026 13:56:46 +0100
Message-Id: <20260130125646.45925-1-alexandernesterenko837@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-255137-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandernesterenko837@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[alexandernesterenko837.gmail.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34B7EBAD2D
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


