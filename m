Return-Path: <netdev+bounces-280463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLUHBGfy6GkdRwIAu9opvQ
	(envelope-from <netdev+bounces-280463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:08:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FF34483FA
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1A8E305FA06
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D24837C912;
	Wed, 22 Apr 2026 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gica2eBG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F937D13A
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873910; cv=none; b=Q5Z3X32Jmr2IOrB1+J4kUMTcEkVDdftdNsUQrK+WHuXYe5suB0c8myz9DNxDJocvm/FAIquwqmninH1G7cHRWp3U8vdN7baHU7h571+WjCGVCN7SeIzk+ZgN1rp7qWxgBhI4gu8/16TgNN1Q33zX2o76NTTDU2+c4wN3Olt9CoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873910; c=relaxed/simple;
	bh=VQKE++kSkNnafuk9pDx8+P5r00uAWKMmjuCw7JxQ0NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BknmKbIlh+dFuFCDwJGeJiSdtDAfWu2UFWXEhLPjcMbATOcGOarUT+UBm5hJOlkXHqfKrpJgBxKkXngNIZBtbBbNl6NJzsnPdBssGulxHnf44H6/hcmL+UNGh1bsDMOLlcxBn8s9G0hEV3Q5mPIOB23adhGU7htZGYpWtb/mpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gica2eBG; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6108228a851so1930299137.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873906; x=1777478706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbIScAHLkzfolps6mpjGZEZ/01fVfgMv8ysDQ0vf3Jk=;
        b=gica2eBGAKJXaP9LEss1tHCTUHXVXf8+exWJcWNUvCxyZ4HZOB1ZRIe3GEG8V8SZvB
         Uoo+D8ID1zQQRGbDiL9AptZn445zEe2O0W16viafB/jxwResCBnO0r4t5Z4BtW8eScb1
         5GybJi3mlchaNApHnSQLq9137Cyu4pTo8yut0QXe3+5KzhYtZIFJT6cKy06G2JZMA7Fd
         9egIp0H0X4bD9k/+5ABSaFd+PaD5a0EBgswdIb7efsn2V7cElQHkHSKWAH0DQ78hXYda
         MC62vGDwdU439cD0XXN8m/PvguwxNjJVDOBQ8yBBiEPXdiaThbhvaFNWhSABr8P4aJlW
         cVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873906; x=1777478706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dbIScAHLkzfolps6mpjGZEZ/01fVfgMv8ysDQ0vf3Jk=;
        b=p9BD4LKkvYxXceMWjMSoEUdWU3bvJiJmCORoDwpMBJND8wkfCfgN7YHq4n0AAz288E
         jqYdxBgJsv1Ps//rgIq9REPi0cjRM5iZ5ITcaYTjX4ppIPzKZrYmX7zNBDYF6ai0sFrD
         Hey6xzQgJ/aOeF7ngLrLm6JEIh+FPhxGsIp2ioRLxwjdh3c5QZWP8v9Lx2ciWqXflk8C
         vQ37YT9hZrwBUKFQ2U0oknO6DiSTXtvdMIM9O0LGZIurVO+M2cv0yubgMkobLJVTKBa+
         qRKY3udlGaeEwkw0UVSROWlnAW4Mmy3MBIQ2bAGZ6544RyzbukXT7WQmMjJZ42ET9MmC
         7WGw==
X-Forwarded-Encrypted: i=1; AFNElJ8WFa6lXWaH06XRPzexpA8TZQCWS7ZjWbdqjXaX+e5LkJ99UG3+n2zPkkWu35sVtn3zNIcdQv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKB/0XxhnR/8dJiiF89S4VRaaexo3OaAa+1yZv+in7jJpvYudL
	ORZlljEbGVkf/5p5a3OpYKWVbxZCQGj2sJ/XNV7hHLOpRCZrNr7k5XIX
X-Gm-Gg: AeBDietw8ir76Os6i7JQfCqkgJ3tm2DwQyk21k2zJ5D2GyUn4uwsfMFCy841Hh/TmUy
	qi+NG1rgWK4MMJXF2yobTbMt9sO1lKTti0cPXI761wbCC2gaw8PyDbUH+jjfmKwsTk7cs9yfiWR
	9O15yhWDeeR0wSTlMgZEmbQBzsb6maqWIZU6y54fG8C6wKg/UIFiin7ydYMKgeU9ox/UOEo/XCb
	tTjVF6fbHIR2DMeV1Nkorr616jc3p0445MR9JKeyC3W7IjGWsy4TDxz33O8FfpxiV6VU4S1e+XG
	i+BAYoeabaKJ3mTOWGzO75wPD5O7CauSZ2Up7V5LIrs3ezcUWNY9xNsiQR5L8FkkAXJWQqqVNKT
	yjfK3JUAYhIwLHIJXegn5ilmF0p3CsMRjoN5VAajq1qgbVAXPgJYctPOVaQNS8UMuxYd6dpMSKs
	8eew3Prvn/CYtHgFdImAsF6uR1jxu2gwBTGOgoDp1D/T8ZybCV4SsTeYwxYH1DMGVKCXjzYo+64
	NuLyIrYLXpk3FYHgHAfO0V5gHw6Xj8=
X-Received: by 2002:a05:6102:5987:b0:613:95c8:d941 with SMTP id ada2fe7eead31-616f4f6f185mr10900447137.10.1776873906029;
        Wed, 22 Apr 2026 09:05:06 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac462d9sm136370786d6.7.2026.04.22.09.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:05:05 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/6] net/ncsi: validate response packet lengths against the skb
Date: Wed, 22 Apr 2026 12:03:37 -0400
Message-ID: <20260422160342.1975093-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422160342.1975093-1-michael.bommarito@gmail.com>
References: <20260422160342.1975093-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280463-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2FF34483FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ncsi_rcv_rsp() reads the common packet header before checking that the
skb contains enough data for it, and ncsi_validate_rsp_pkt() trusts
the response payload length before accessing the checksum field.

Malformed NC-SI replies can therefore drive header and checksum reads
past the received packet body. Make the dispatcher pull the common
header first, then have ncsi_validate_rsp_pkt() pull the full response
body before validating the packet.

This keeps malformed responses on the error path instead of letting the
parser walk past the skb payload.

Fixes: 138635cc27c9 ("net/ncsi: NCSI response packet handler")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index fbd84bc8026a..1fe061ede26d 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -38,11 +38,18 @@ static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
 	struct ncsi_rsp_pkt_hdr *h;
 	u32 checksum;
 	__be32 *pchecksum;
+	unsigned int len;
 
 	/* Check NCSI packet header. We don't need validate
 	 * the packet type, which should have been checked
 	 * before calling this function.
 	 */
+	len = skb_network_offset(nr->rsp) + sizeof(*h) + ALIGN(payload, 4);
+	if (!pskb_may_pull(nr->rsp, len)) {
+		netdev_dbg(nr->ndp->ndev.dev, "NCSI: packet too short\n");
+		return -EINVAL;
+	}
+
 	h = (struct ncsi_rsp_pkt_hdr *)skb_network_header(nr->rsp);
 
 	if (h->common.revision != NCSI_PKT_REVISION) {
@@ -1182,6 +1189,11 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	/* Check if it is AEN packet */
+	if (!pskb_may_pull(skb, skb_network_offset(skb) + sizeof(*hdr))) {
+		ret = -EINVAL;
+		goto err_free_skb;
+	}
+
 	hdr = (struct ncsi_pkt_hdr *)skb_network_header(skb);
 	if (hdr->type == NCSI_PKT_AEN)
 		return ncsi_aen_handler(ndp, skb);
-- 
2.53.0


