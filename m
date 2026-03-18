Return-Path: <netdev+bounces-268877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDs3MO8kumk3SAIAu9opvQ
	(envelope-from <netdev+bounces-268877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 05:07:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D6D2B5AA8
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 05:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 134CC3070AED
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC3C33C50D;
	Wed, 18 Mar 2026 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLHOntPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F033A6F9
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 04:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773806798; cv=none; b=sbAHqbGX92yZgc89FmeodmvO55ECJb91uRzz+Ds42EbKq0zeytgEvbU2uPCznrgSMhJzFpEg+PstxSbdUW1/7du1vwOygp0PhHMe9EaCzFfowbRvtYaLcANUbDHG0rDjpDHbwERpCDcnmGsZaoMR157Aw4/uB1WBL3Ey2V5c9Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773806798; c=relaxed/simple;
	bh=6S8H3E+I5jrhkdb7Zg7GN9kN6TEFWvKeGaf2Fg5+mis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZsXzk5GHiP2c+vpy0+VO0Y7eZ9Suq9cFYn1Zc5zWav0XJnnzxYkV2FVyytqcOR78AQ4uIrF4RszbGxNPLyk7QWZEO0/KDQ6MTrx1CPfypeKn0vSJsI7F/b+hg3JTTIq7JdmX7eUY0zThiMnVrgfr1Wo9KMCMePNOZe7/hAvLLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLHOntPQ; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-64ca1ba0089so6300771d50.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 21:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773806797; x=1774411597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5febONs6DrEdwVAiln+ffrvvThmSM7RqYP6DaP7WAg=;
        b=BLHOntPQIeUlN6ZOHySf4L2NbS5FMTENb9SSzjajP/FtAVBLmfbbmWf2YhfVrhTnUs
         a+SkAvSLEadbWK/Fjbrc6+lQ6TmGcNa8hDX/SYQmpCidK1S9bXUTl9Up1pCApW1hFN5H
         jUytPCMsDVeb2V65m+T6vl2XpAMcmd3vyCJCsvgPU+N8ofU93h4mAWMYr+atTzqtJkcQ
         FXzyRMe0nJHd9FdpXvadQJyOVQRWXgVJRVwYoOX7v5Vk+GgW4RBfpBjDDuWyZwOgvR8M
         1bAeL23R7TbGh57XNqMqUAUzRgXxqO7EEAdpO681CNAiz+7pPLHZV7lTDJJpAHcoCp3y
         RmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773806797; x=1774411597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F5febONs6DrEdwVAiln+ffrvvThmSM7RqYP6DaP7WAg=;
        b=VnDD+2SvWJEh2fOfo2r90fbmNIwFyZwW5bSli7n81jkS1KJ0QWo8tWKnQ/e6vzZaue
         GDOmJcfFx5YMzxAycDfo2OF9bZz2bPhraTOZ3yA4yjS+DGcEq+Bvg9pE5vSTs59iuVYh
         WUNlLT7EaGkQWrNMJAu4zm78rxu4BuN1p7c+dvg19IwQl9HycHTM/RvGpe7HVbgi77Fh
         UaE9xeTpPMZaCY+dqzVzip6DdfxjfFn2XPiytR74AKI2cEpPBa0dhh7mr92uVS8xBejj
         z8OKJGPerySjIH5FWJAaU6qBFa26qt864vYReec99bH+DIdQ5iMsoa5/RSqyzo5d9Vw/
         N5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUCCJj+8wEc2s0DRoT2l90+kIPaVRpx32Tp1gl4AfRo343GRlRoYN7e50kNSSBTgx5PGE+Xx08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGJx+5fX5MnsWWIEKUg6w7Tg3pGpUBH8OGrfLfh1ZUqf4kYG2
	TFTWUSgTjTJFeZQP3i19S+fuuDpcqp9ftv1FA0jDH12UyV4KOn7cQQohHgB1CZUNXDARNQ==
X-Gm-Gg: ATEYQzyltY8JY4UAeOZa5fpIPp1nSWDPF6ENJmHLKrAVX/h0UgPgBsoGql0jAw5Gd7A
	EQeZ4YZ/N7VZC01PAamEMmtB7vCIRGxwbIAi1dV9NT/1amPiAuqFrOf0CWk77uUrS1Wrs3QhBEx
	NqKAlbnOtw/JMZbzGDgvm66vJFb6hOlZD9NcqLrCxYsuuM6TYlrOqsgzwLoS1NsP6s+FerCN3tC
	3VAqLfaHBI64Rvz/7fsEZKo7D13w7n70Zhlb8tr1Prt0c8mvc6L1y7td8wSnTBRl1w+1c82++bK
	LnPYpKIcDrX7GRtEqdBO84Q4qxz8rnfKPD7tnZYhmZEcbaZHcOp7GNypUB0hAMbKOidUIHx/N2r
	uGHKwBoLcebnV+kPs+VO1VNWggFF4N+HNXU0WsRYWTPq2jHE5PS78xGD/QR6DwJMWUJ1rVQrTha
	bxPy1ULf3PNT6LYtr6Dh6WScUESpLkGxUuLt4TgqBbIeLvM1J/xyM77Li4CP0=
X-Received: by 2002:a05:690c:e00e:10b0:797:f226:3a80 with SMTP id 00721157ae682-79a718cc7a0mr16015197b3.26.1773806796735;
        Tue, 17 Mar 2026 21:06:36 -0700 (PDT)
Received: from Computer.attlocal.net ([2600:1702:6f11:2d0:7876:bdab:8062:a5f9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a713fe5adsm10228307b3.19.2026.03.17.21.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 21:06:36 -0700 (PDT)
From: Omer Zalman <omerzalman42@gmail.com>
To: oliver@neukum.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Omer Zalman <omerzalman42@gmail.com>
Subject: [PATCH 2/2] net: usb: cdc_ncm: prevent silent u16 truncation in min_tx_pkt_store()
Date: Tue, 17 Mar 2026 23:06:32 -0500
Message-Id: <20260318040632.69531-2-omerzalman42@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260318040632.69531-1-omerzalman42@gmail.com>
References: <20260318040632.69531-1-omerzalman42@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268877-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[omerzalman42@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47D6D2B5AA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

min_tx_pkt is a u16 field but the sysfs store handler accepted any
unsigned long and assigned it directly. Values that do not fit in 16
bits silently truncate: writing 65537 wraps to 1, turning a
"never pad" intent into "always pad".

ctx->tx_max can itself reach 65537 because cdc_ncm_update_rxtx_max()
increments the negotiated NTB size by one pad byte when it is an exact
multiple of the USB maxpacket size.

Clamp the stored value to min(tx_max, U16_MAX). Any value above tx_max
is already semantically equivalent to tx_max since frame lengths never
exceed it; the U16_MAX cap ensures the result is always representable
in the u16 field without wrapping.

Fixes: 39eb7e0e8c88 ("net: cdc_ncm: allow tuning min_tx_pkt")
Signed-off-by: Omer Zalman <omerzalman42@gmail.com>
---
 drivers/net/usb/cdc_ncm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 6fcb4d711a64..edd69f4e1596 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -242,11 +242,17 @@ static ssize_t min_tx_pkt_store(struct device *d,
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
 	unsigned long val;
 
-	/* no need to restrict values - anything from 0 to infinity is OK */
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
-	ctx->min_tx_pkt = val;
+	/* Clamp to tx_max: the frame length can never exceed tx_max,
+	 * so any threshold above it has the same effect (padding is
+	 * never applied).  Also cap at U16_MAX since min_tx_pkt is
+	 * a u16 - without this, values like 65537 silently wrap to 1
+	 * and invert the intended behavior.
+	 */
+	ctx->min_tx_pkt = min_t(unsigned long, val,
+				min_t(u32, ctx->tx_max, U16_MAX));
 	return len;
 }
 
-- 
2.39.5 (Apple Git-154)


