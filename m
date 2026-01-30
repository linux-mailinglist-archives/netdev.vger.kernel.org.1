Return-Path: <netdev+bounces-255136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDrPChKrfGkaOQIAu9opvQ
	(envelope-from <netdev+bounces-255136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:58:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 84810BAD04
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A848A300BC42
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF0F37F0FC;
	Fri, 30 Jan 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYUJOe/p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C86837E302
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777615; cv=none; b=MJ5MlOakACKoma2DtN2w5bIR1pg9mmfZjnuF537tgDDWwDQN5ZQ2G3y1flCgs+Zhzz0JVYtinOalSonIvulr8qDl3xtKX7MmHZYkiOJr71TmViOw4kz5JtFw/nrdcr0kFIDOPQIMzPUFhIkZuh9d1RBtjawvYzZPLwrrKmKKGyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777615; c=relaxed/simple;
	bh=dg9kYr8aZfQN0Z5Niq94kmT7y8LXjeCMZKoKN1fucL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bAWxEWVklesKyx4grAq7lqbvZ/yfuUxZvNYZji28ouRAthnhcvHcNrwetd5yucuQWqD6FlYcNrah2RPV8x79Ws2yifdoFE1OnNOmoaTIwKacTQ95nlJCHA9e/88DyA1323WVyB/kYHti6LQeGE7OTHOOJs/QFtzEgcesBlgQC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYUJOe/p; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso18616925e9.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 04:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769777612; x=1770382412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQzOK0aKaeoderdrXRGweVvWgIMEPYBk9+gZ71lrHVY=;
        b=cYUJOe/puO5FiZ+6g7TGB6pDF25G31nSEqTwbmJK/HrQfCGnEi/ZMC/Up2hnPGy7ZJ
         u6Rzxm6wAxy+Zl29ClbyMNl0xZU6fvKazMSs4xJmQEtwS5iPyBEjUaE/l6eAxZTZCtvx
         La1QcZR2ZNJI8ZTesQXSRv6BfzH2HYb1Op/zxIXa2sjhTRXyoafKfvsWHHmSz71ASvWO
         Dgk4c/llexms3jwznIrmmxqeB8myHz0Ty9e/jOPlYAexv9vBYsrqlqxfhUTzPF/4VURO
         Mf8v9UZ7MviIwye7BhqbECqVSzNqf8OIH0KbxLb4ILplW+WmMrZM8supsYBqBvagtP0W
         lItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769777612; x=1770382412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQzOK0aKaeoderdrXRGweVvWgIMEPYBk9+gZ71lrHVY=;
        b=SY2gWFbC5XLU4Bw5z8YH3j5Uvv0HYGF6tPr5jIphXs9agZUJH10z7ElS2oSa9+OpSX
         VOlKzfjBp2Yz4fie9tJuVfgmAC4SuKrpBsQap+1az4rbbdBt9WVGvu4Ja+WbANcOjNV/
         y/EdIan4Ri3QwO746DOSbK9Wtm0s1S4Pxn9BqgpjADkIwtuNZYMet+ZW/wA7dwLetKtf
         ZQu4LRVMZN0XUnXPfsu1R2SG/H1+ujswrksI61N1TFzKcfmHoxdJ50ZnJ4JlTeLgw8CJ
         nFMCvUbpZyluLkJwSomiY+7pgGybnK/vYFXM8EFnVuvVNn7zq4DGqaMYANxqawUTFiM/
         ESzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVICZr6gxDsffmmMJ439+Ewoev58X+N4M8GCmHGe5V9jLA4yjp/KYlWnQYiBYqDkF9XRgJJq0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YydVpDMPn8Zjo3dEmFbZ9gZep3zxlozWPg9bTS4j2lYWATm6E58
	cfEHpXm37PXZT0aFJxnKBnK2Ad6gRvxGbhZg56uZD/GxfSBIEi9Bh3U9SdUHAw==
X-Gm-Gg: AZuq6aLtiOmdYXz7Y7Epz1tM0PZjKmrf26y3Vw11GvLxZeszB/RmAGFglARKIEYzdc3
	5LN/cA/DTVjcAxjwjbI0gUPfvsqTTEMmjpIqad7dcRRzDVFBjN+RPAetBnTeOMdSJaQ3M0hX5vl
	IMgPl6CYVqF6VDbIgFGKi15WL+K+indOTw/xhvaM1qmUsDeZCb0y28kQenVs6efPp93BPPJcbSv
	tXs+3uU/LP//EntznsaeGqz9ZYXvO8eRFtcRE93ObzLyx3bZ5plFbB9+pAwFZxHxt1eQ3tPdaER
	AzqrAOw287KvLVa8JLBCjwwSzUsSd6MRBhn0qNEkAtXaqTrGNBE0hxW3WwhzzXon0A31K7YvnYX
	Nwv7rl1HWjBnJJAI/XdYfM9FpL5v+Ilise58tCnkJLIpouuzg8DuNgNqYTKwr6ltEVYejE4usAO
	4mR+Mam5MoGj2NHHCPyAgugLCDMAS2ZsNKNGdKm9YKphDbpBy9ezKNV5fYokOiE4oMLgWw
X-Received: by 2002:a05:600c:8b52:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-482db476c30mr33587235e9.9.1769777611406;
        Fri, 30 Jan 2026 04:53:31 -0800 (PST)
Received: from anesterenko.. (62.43.64.127.dyn.user.ono.com. [62.43.64.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e267b699sm12837375e9.16.2026.01.30.04.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 04:53:31 -0800 (PST)
From: Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
To: kvalo@codeaurora.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
Subject: [PATCH] wifi: ath9k: add range check for epid in htc_issue_send()
Date: Fri, 30 Jan 2026 13:53:26 +0100
Message-Id: <20260130125326.44456-1-alexandernesterenko837@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255136-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84810BAD04
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


