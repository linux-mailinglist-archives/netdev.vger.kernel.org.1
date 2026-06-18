Return-Path: <netdev+bounces-300391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2N9UGXvFM2pKGAYAu9opvQ
	(envelope-from <netdev+bounces-300391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:16:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D8C69F32B
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:16:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=AgmwK+1W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300391-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300391-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D682B3067B03
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5959625F7A5;
	Thu, 18 Jun 2026 10:15:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F93DD512
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:15:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777713; cv=none; b=lBksr98x8FlWsY5XCgjzdaJPjCBaK4l6U7MoY8yHz5MLwYD5wrGDA+lEWSXPs9zaqbr+nzfeD/uZ+UxUIYDFpoA9ubb6wwPJsQMcieaCTTk5Tf1SFGeBUq9a7V+TT1A8fQ8Kq2Am5CpVyPpenzch11TFbrj0Dnf1pKZuqnqpoNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777713; c=relaxed/simple;
	bh=1Pk+ay6yU++Vt771lsD3x/881ULnMf1UUk6bSMRDqb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VBHSVTpb9yI12kHm6XO+4g1fAAsiERXzTRpRUdtdiKmx4/xxJZTQQSrZHT1XuM4nPTltQEFPyZ0x5b+A5Xio/QPDUvBa02nF/qdxST92DAcmXPJAwlGQDD2EZ2SEOaw2CzElfeeGUNnKpD9AbvxW0bccdiQd4fGMBe52eux6c+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AgmwK+1W; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-460166910e6so496288f8f.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781777705; x=1782382505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ekg7H/2XArtMw/8kbK2+ZwTBpxjVhy5IaU3nSg0eAI=;
        b=AgmwK+1W3eZEGfZ4xvOhviKpNoRCbWMSEeBFNICDmG4WqdJf2TuwgyvKjzRUBs0Wnn
         uUihI7+BOdS171CehnwkUKR0GzxInlajtu4TpmaDLGne988eJzKO0f+BDE52QcLExtY5
         s3TRSviVpNB4aCFEpepmrmyJKYtcbGoIhvBPnOSdxyialAknn1cpHCAAdwoyYcLXq0R6
         Tb0ayryDWAQ1C5jZFGBMPrpYoehw6y7p828JE0OH3M5p5L+1TdnhNhZZTpA4hD3y6cbB
         JyxsuejPUf7gyDMi3HYWY1gfq0bp5/1f6Ym+Dzzoj6qV5UPgQxdVlDwSKrp0hMebj2rr
         OLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777705; x=1782382505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ekg7H/2XArtMw/8kbK2+ZwTBpxjVhy5IaU3nSg0eAI=;
        b=XUF3ispLZjvLSHgHu/P7MLoAfNswcCgtxbPab10+zJVrljFMhT6bzZBmq5KVCghUrX
         s9uMaM24AVAgkOIfClFWy/ZblSVEuPIFEfWPog8yHysgWHIA5d3q3bSGlSr2T2tSSHAA
         6fb6GGXJal0JSBmdcBmrr6MxerVw924hvwS+eCKKg3b9WwqrQeNgqq1emVX82DOH7XXN
         hSEmEqsCpj0zP/dnhD4Qe92x3sd8ygDdWtQ5R2aL+cxdTlu3HT/CVoivdQiZk3EpcFUd
         BEwiGQzI5JeWQVLYHEmQq/kUkNyTBRsS85GW6sVrqRjPyXuwtTSPKYYSHAwDzqoLEnjx
         PV1A==
X-Forwarded-Encrypted: i=1; AFNElJ/7mlP9bHLmu6QHdOJOImNB6ywVCujFFVsoQL/ErLO6sKBXPnxuAixDQX8vbQ/amm9+l+lOIZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0rNOjt+VVwrxMaYsSBQyKFHnZptdl6IK3ENV6eQfeMXuz8/ol
	t8n2LJkMm2zAmLcPqtcYGZLqZlftUk13Mlg7T8I/B5IC8FfXsVHGDQ7atnDXuMLgr/o=
X-Gm-Gg: AfdE7cmY+YpiIeJ13MhavLgmUr7Dt7ZAE1VDs1WXuBiTky4necaVRafuUGDNo3JmCmD
	yHror1/dZetYtQzdhQKLSHqJ6NM3JXsJWMT7RdB6t1JCX5VVO2SA+qOIUgZMWDFXuGG19WcyIq8
	/KhC66IsGPxe4jKO2A+0twNLn8owPHWnvj81AgcXnmA+/V5IHnmwMRwW3SkS9MrDK1t7eRBf90W
	ReTsRb4MgCAjOdivW/gB7+CTVpS0A2zE/G5QIN5okWaKoI4gE+P7aR5K0YInWGNa7XjbhA0BBkh
	gK45me5wZmBpwTh9c+Bb4edXMsKB/vgjInlvrcoG6aFBcegX08jh8fipOetMSlb3ti3vjpGG7aj
	2IW5Mzxs/rjIspWD8oW+Bosd338WafpNFu8clHbu1ejVjaMgy0s2vmB2l/t1IIFMeMKb9A6BtoB
	4+fnToe1ICcw5dt/MQHnqUKfkoSKtO2eXhIExXA9r4IdxHKEOAuaKJPNPig3J79Q+0BiHjU2Emm
	Dsj
X-Received: by 2002:a05:6000:1869:b0:460:25f3:b25a with SMTP id ffacd0b85a97d-463ad6ca6efmr5164409f8f.34.1781777705484;
        Thu, 18 Jun 2026 03:15:05 -0700 (PDT)
Received: from localhost (p200300f65f47db048595530b320b6c5c.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8595:530b:320b:6c5c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f2b0d70sm62313771f8f.19.2026.06.18.03.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:15:05 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v1 0/3] thunderbold: A few cleanups
Date: Thu, 18 Jun 2026 12:14:49 +0200
Message-ID: <cover.1781776904.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=1Pk+ay6yU++Vt771lsD3x/881ULnMf1UUk6bSMRDqb0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqM8UasF+6Bo1y6lFzE9g1UVds6rVHrzDi0jehW NiZ2GrAUXGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajPFGgAKCRCPgPtYfRL+ TnYJCACPUCMkUE/rTzhYUhoiVMd246EVg8RCAy5wgNvgNSSVUwEKjujh6GwcrU4QOgqiXd1WayI uI9P9v4OBNfEDfcF8/wDivE2hiWxhxs08vb+b7uXlMjVyxKt0qT7rLFOhRGE6FVAn+VmttF9tyo zWfyMRFFguDni/aSkghI9R+tVMw/XFmwmdq+l6zs6agTIDHZgvWdR4IK2nzwgaYbZ60KorJAtI6 8AaZHgsx8Lj8eNnW0af70A2etoJ3zdexC6jIVFkCLXTuB4GgTloMJQlq+ZcMtWC9ibI9NsoCs4A 0mtx6QMSrU0WqKtz3clb+26hq3Qi8gKilHLbhJ/qim+zXL67
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300391-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:westeri@kernel.org,m:YehezkelShB@gmail.com,m:andreas.noever@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andreasnoever@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[baylibre.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,baylibre.com:dkim,baylibre.com:mid,baylibre.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03D8C69F32B

Hello,

I'm currently working on a project that includes looking at all device
ID structures from <linux/mod_devicetable.h>. While doing that for
tb_service_id, I spotted these patch opportunities.

These are all non-critical and also my quest doesn't depend on this, so
there is no urge to apply these patches. My suggestion is to apply them
via the thunderbold tree during the next merge window with an ack from
the network guys.

The first patch touches drivers/net and drivers/thunderbold. It could
theretically be split, but then this results in at least 3 commits which
seems excessive to handle three drivers, so I kept it as a single patch.

The third patch is a style change and so is subjective. Drop it, if you
don't like it. Here splitting would be easy, but given that patch #1
already touches the same files, letting these go in together without
splitting seems to be sensible.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (3):
  thunderbold: Stop passing matched device ID to .probe()
  thunderbold: Assert that a service driver has a probe callback
  thunderbold: Drop comma after device id array terminator

 drivers/net/thunderbolt/main.c | 4 ++--
 drivers/thunderbolt/dma_test.c | 4 ++--
 drivers/thunderbolt/domain.c   | 4 +---
 drivers/thunderbolt/stream.c   | 4 ++--
 drivers/thunderbolt/xdomain.c  | 3 +++
 include/linux/thunderbolt.h    | 2 +-
 6 files changed, 11 insertions(+), 10 deletions(-)


base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
-- 
2.47.3


