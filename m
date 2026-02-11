Return-Path: <netdev+bounces-258321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJshLGS3jGnlsQAAu9opvQ
	(envelope-from <netdev+bounces-258321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:07:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C481266C2
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D73E3006094
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8162C346ADC;
	Wed, 11 Feb 2026 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="b9cI8FgO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BD6345725
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829660; cv=none; b=PVVgJt2TFmDvbV1AINrhJkRcgGHp+Va9Om/sFFXD1AvV/nP9CH+55Ut1lVOW+73M5TbM0jORYa8tmTUx0DSM/24m5wUk43MnLXnXey1cBgAd9j52yvFU5KhFHp8k1wM5Pe30zchmX+geJLb4W6a3IdIkxcedRapFJswE06AFB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829660; c=relaxed/simple;
	bh=gf3LQX9a9nC+MJzUQdFOk0xQcrM8SfWKgs4irf+DzIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiYEGQMbhp6vQH1O1HayUKfcqRgCK06WLrk2xumplECIQe9rA/mJ3Gp1rgJyc66EH3eq42wwHxtEuPpz2lMJ+VEwdPPKNGm+wh/C5tITcEjCpF2iL22GTmQZhCrwebNr99a88cmk2N3lkWumTSV2J2J/NDxzrF0SNofRn2B5rSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=b9cI8FgO; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba68df3687so5991469eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770829658; x=1771434458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lqmc9Z7MFjEK48y/RU5GGS3AYHuscK+I+Np4nW6GRQo=;
        b=b9cI8FgOXRBAB7gWw8dbUXstdo41HVFVbSO/3nCg8wNvGIK6dvReoME1zC82CZQfv+
         1PEvdkXvdFCeYSjHtOruxvR0MtPGfQUd1qcaPsweAP4D5jg523+ZmUzboYgkTSCKLmH9
         PtvDPw0TMxtFr5ZRZsiVMFhyYELgPvpvZ0MHffIlbrYrP/G+/avZJh7IUdzJybTyUiLs
         Q64I2wn5V20Rhi3q59RbOqPDbN2wPjFg1lYNs46O4mAeutKUNH23e5oDaT1QkB8uvAYx
         L11yHae7RoC9aXUnETzSwIdebh0N4PR/uZKA29sJNuqBb0TO1bQcViwM96Yt2FhgC1bj
         zFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770829658; x=1771434458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lqmc9Z7MFjEK48y/RU5GGS3AYHuscK+I+Np4nW6GRQo=;
        b=mkQOVpqyDmc/GejoDD6Aoew1CbrFLBEGYM3tXRUOFjef19mg4mrIcVtTIgVHmW2V3C
         TU8LBPZYsMbe3Xwwi48X05dvAiZEGsya3XiqJGaUB8OT94zBFPhhB0bJJmrijNP67C7i
         5bvuKFxL3+JOz8GzFi5XAtDms2siXNuBrwwGIaKcG/B17FP6gCuebdyWUSBPZ7YopkiT
         ZjkvXFtgUjVWfGCaupuPOlJhqpjzhmNZmVjE2ysEJDzTaEFxf0DzQpn4M4UTNXfGLS5Y
         PYZiv6qFBkGTv1l03Yq8DrOf8Cp8gwWaVDCHv11MFzl5EvgGU1cQ/sUp7AVU8fkWYEjH
         h64g==
X-Forwarded-Encrypted: i=1; AJvYcCURUDccfB95TLpsqLg5nSq0UV4Af11o0LsyH294N4DlW1wlht+jVYXAPxpVVv5v0bGz6zt2BVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4DeVinmCJiRr8n5HZfjGfWwXMtVA2caqjJnc35RsMF2jKHSG
	RghbKnbOP+30DtrKJBWEQUeCrq4gVsVjVlnm/I31flLOq9yo+SpfW4HCS2ZRnu/8AQ==
X-Gm-Gg: AZuq6aL6P6OQwILjUTqWad+Qw17/Im963JWY/jNM8OAoc3GjUvt3pGKZjT05IzYD0rQ
	TzEZP33TYqoOoifmlhNSjbjCka0tQUPrioJF3ZK/t/K+AC661UE3qPrVLZixp6TU5IMjbAbjpTE
	i+njM2BpmqghmHWinjNfZp/mteVvgmKtn7Rj4PyXvrcDM0Y+AKj/OuDS4icWeAokx6zHSoY30B8
	HNZHdIcCx1dQTu5YhXpqBpCN7A2Cob+L1wfU3vAba+Ov935u9I3kZn76H3ZgS2WtJ5ykH8c6WsD
	5o+7S+wYjNLjZR2EL6YUVZuQvoSUM6T9+SswluMlwIl0MWz4p86mUOgfeMM3Vy8jboPYtZLLZYs
	Y+IIdh5NCGpyB6A91u3mDVvsEmC46+IJmax+Nu5sz6KR1ptD6b0wvfIAHIvrcqEp6V7mfx0759F
	8t9W4sRyTaXutGgr0FG+nB4R2Sx3370A==
X-Received: by 2002:a05:7300:6da3:b0:2ba:7aed:560d with SMTP id 5a478bee46e88-2ba9b4dab61mr1634266eec.28.1770829655329;
        Wed, 11 Feb 2026 09:07:35 -0800 (PST)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dd00ae7sm1649496eec.31.2026.02.11.09.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:07:34 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: dsahern@kernel.org,
	stephen@networkplumber.org
Cc: jhs@mojatatu.com,
	deren.teo@outlook.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 2/3] tc: Add JSON output support to QFQ
Date: Wed, 11 Feb 2026 14:07:24 -0300
Message-ID: <20260211170725.1514427-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211170725.1514427-1-victor@mojatatu.com>
References: <20260211170725.1514427-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258321-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,outlook.com,lunn.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C6C481266C2
X-Rspamd-Action: no action

Since qdisc core already assumes all qdiscs are able to output JSON,
add JSON output support to QFQ.

Fixes: c91d262f414d ("tc: jsonify qdisc core")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tc/q_qfq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tc/q_qfq.c b/tc/q_qfq.c
index d4c0a591..04061fcc 100644
--- a/tc/q_qfq.c
+++ b/tc/q_qfq.c
@@ -90,13 +90,13 @@ static int qfq_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *op
 	parse_rtattr_nested(tb, TCA_QFQ_MAX, opt);
 
 	if (tb[TCA_QFQ_WEIGHT]) {
-		fprintf(f, "weight %u ",
-			rta_getattr_u32(tb[TCA_QFQ_WEIGHT]));
+		print_uint(PRINT_ANY, "weight", "weight %u ",
+			   rta_getattr_u32(tb[TCA_QFQ_WEIGHT]));
 	}
 
 	if (tb[TCA_QFQ_LMAX]) {
-		fprintf(f, "maxpkt %u ",
-			rta_getattr_u32(tb[TCA_QFQ_LMAX]));
+		print_uint(PRINT_ANY, "maxpkt", "maxpkt %u ",
+			   rta_getattr_u32(tb[TCA_QFQ_LMAX]));
 	}
 
 	return 0;
-- 
2.52.0


