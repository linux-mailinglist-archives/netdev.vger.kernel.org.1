Return-Path: <netdev+bounces-57812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76CC8143EB
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0600C1C227D7
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 08:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8027168B9;
	Fri, 15 Dec 2023 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6I02UDM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F345171AC
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso443367e87.3
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 00:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702630149; x=1703234949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDIP5QCTtf8P0jNwrKedcIPYH3ksCN20vWE4Bnd44rw=;
        b=I6I02UDMr/Fhm+OoXXWx7YLDjJdXA9MjJ/3e51noljM4Osw+U4jTVx1x/b51I89P1u
         AFuRz55z5RTMJvV3FVPMFmpIhfpAcS/HvlFGqRaH22IrqjWMgUT0M4n6s2LTLArpRZiU
         iupYasyDJMM3esHcgl4r4H/uxVZ43hSoqSmUtHZU0jc7u9k+2aKCe72Q1nPO5h3y8c5Y
         4ym5oiroo8Q45J3boLgACi8X/UE3fkVf2EnMdGhkbTOPge0x1newTvwMBKjAXKvcIJUq
         I/Oue9bn5FnOeHeDjW5g/e/GC9DDBtt+gVD7QAmcbDnnRZVdPFAnrto7NfCynd6P8SvU
         u6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702630149; x=1703234949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDIP5QCTtf8P0jNwrKedcIPYH3ksCN20vWE4Bnd44rw=;
        b=tygKeAJiCcHV/UuXA0lVCdKQ+emZga7q3+LU/mH5clwuxREYilmjMU64BcPxAQT74f
         OcqLMd60O37ICdbQKsshWe3WzEAukDnk+/txfqic6yGDSFf8ogqvkYoSIzSyrqvwEDuc
         bz85ahoeDOais/AyLqR5GdCVuJsrWdKzFfPjwOwXRIARXlNR1+n5Vu11F8NJBPm0xx9/
         a/ftb5dJG90EJV8wd3NGOdsAZhR+yr76eiWa9Lct/5mUvgJJPsr9ybSLsssKsjIrEINp
         r6sX935IR8E9LxsYU688oDcf+xla7FlU+KEmPq51qy//UpLHy6Rbh3D/aw2KRI66uk0Z
         KdaQ==
X-Gm-Message-State: AOJu0Yyhy4Ery+Q+TJzQTUsXGugcN6IjLOR+gOgecpv81inexcCviA1w
	OMo35wMSIHv/k2EajcAlDh+SAw==
X-Google-Smtp-Source: AGHT+IENDRKlnHRXHF13iBGRuKSp9DI2yebFOYheAU6Isj+oTeC1MMr2zwyvBOWWNcdRDEWumkthdg==
X-Received: by 2002:a05:6512:3588:b0:502:f2a8:d391 with SMTP id m8-20020a056512358800b00502f2a8d391mr4969717lfr.45.1702630149289;
        Fri, 15 Dec 2023 00:49:09 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id cf21-20020a056512281500b0050e1db15277sm166692lfb.162.2023.12.15.00.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:49:08 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 15 Dec 2023 09:49:07 +0100
Subject: [PATCH net 1/2] net: ethernet: cortina: Drop software checksumming
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-new-gemini-ethernet-regression-v1-1-93033544be23@linaro.org>
References: <20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org>
In-Reply-To: <20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The recent change to allow large frames without hardware checksumming
slotted in software checksumming in the driver if hardware could not
do it.

This will however upset TSO (TCP Segment Offloading). Typical
error dumps includes this:

skb len=2961 headroom=222 headlen=66 tailroom=0
(...)
WARNING: CPU: 0 PID: 956 at net/core/dev.c:3259 skb_warn_bad_offload+0x7c/0x108
gemini-ethernet-port: caps=(0x0000010000154813, 0x00002007ffdd7889)

And the packets do not go through.

After investigating I drilled it down to the introduction of the
software checksumming in the driver.

Since the segmenting of packets will be done by the hardware this
makes a bit of sense since in that case the hardware also needs to
be keeping track of the checksumming.

That begs the question why large TCP or UDP packets also have to
bypass the checksumming (like e.g. ICMP does). If the hardware is
splitting it into smaller packets per-MTU setting, and checksumming
them, why is this happening then? I don't know. I know it is needed,
from tests: the OpenWrt webserver uhttpd starts sending big skb:s (up
to 2047 bytes, the max MTU) and above 1514 bytes it starts to fail
and hang unless the bypass bit is set: the frames are not getting
through.

Keeping the size check but removing the software checksum makes things
work again. This was probably dubious to introduce in the first place.

Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 78287cfcbf63..255fcffc1579 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1145,7 +1145,6 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	dma_addr_t mapping;
 	unsigned short mtu;
 	void *buffer;
-	int ret;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1166,14 +1165,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		 * checksum buffer is only 1518 bytes, so when the frames get
 		 * bigger they get truncated, or the last few bytes get
 		 * overwritten by the FCS.
-		 *
-		 * Just use software checksumming and bypass on bigger frames.
 		 */
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			ret = skb_checksum_help(skb);
-			if (ret)
-				return ret;
-		}
 		word1 |= TSS_BYPASS_BIT;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;

-- 
2.34.1


