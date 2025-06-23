Return-Path: <netdev+bounces-200339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03226AE498B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D287ADFB8
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8595222FF37;
	Mon, 23 Jun 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="QZHrLMtX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8447846BF
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694482; cv=none; b=f8RnIXKw+MZKUMlCcYCG96379tACY9UhCiZMJmq3dzL/dbKjx5Gbu0wwxXO1VIemMhVd9hPcEMvzc9gDDCjwcl0zt/HUNwjdAnKwPJ8TBsYAp2ORx8SnWEOEAyKDgLlPzzFV5iqlvUOVXFga+5srQLsfJhcBOh2C0/+cgeX1Xe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694482; c=relaxed/simple;
	bh=W2njX0aNcEZksb+ZdOEylLnZ6LAQ8oqd/7eAfvsvd4A=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ow36qPaC4xfeNhSOAGJi/F0GR48YhfqyMwwvt92eJOyoQzkrZi4z3BbaXM2tx+C3JEYRfck2lNOxn7kuJSAEqxGsQGJD6xQFTxdbk+qeqz9ahLHN6yWxwd5EQQGS0TmT2uv9WU0+uEaClQSPhT65u29/WPnFX4BiK4UbUi3CDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=QZHrLMtX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso6819420a12.2
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750694479; x=1751299279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GV9eywOsXK84WOKUgMvagNTBliIluKm+MCneZcnY37Y=;
        b=QZHrLMtXg4ohYmdSTDD1Np4AKe4rNiGOBD/zVy2sFwi4GJsSsusAh5tnvWKF+2eVva
         yq3rRjJ9NpVpDk2p9qlnCCsHX4IH0lWOrtzrBTHw28yuLvJgPIAhEw2epvXwI974LSAZ
         7PqDVHyirVxVN+rj8rYpsk8MFLeOwPhziQE0oLvWlZlFDEHWuFaKeHM5Av6i2hjbs9qC
         PYMpYRF5bMWVsWByK6AIeptH7VXDG0RF4ZUXxUdVgqGViud92siPvgsI8Oqa751yyzHr
         Y83ff7JX87DMlTSAjZFbN0+qohesOhjbXi7SXinXNLWd8e26lkgQXNCM6r3f8Ai+l2Zt
         r9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750694479; x=1751299279;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GV9eywOsXK84WOKUgMvagNTBliIluKm+MCneZcnY37Y=;
        b=SbmYSmj73JZGplxIAqjgDNEv39yuQFpB5A96FVOBaCVZEVBGXwwYTZezmppS/gIAud
         tBaIQjQo2RsVL4h0u2/Ma5JFB4DcmJMypecFVeDzQYPCQxkdWzzv898kwqyFjNzOSJ/2
         1LVNG00mdgRX32nVWXhPedfnDWQPHrmA3UtyTQHWfgufwNAzbjhkRk5NeHoeXKocR/2a
         Igj43gAaawpceA/MCPFcUyIHaWFh0g8qCqKbRby3BNqeoWdQPb2BE6/bV2c5TvMz+KPQ
         0zcmwRSd0TTnaGeYwxAtrXfi2C4rirEN1OmQ3Tmjn63/2yBi563Yc0Z/hcoiS2+Og3BP
         Ga8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+IECgHrIIQd44zYn/VXp4/dpYxIPk7gHLeIJBWoudoEferEmbD0vK5qYPnPVv+n2CwqqXy+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvhhWqzWD9fHmkkuyuthUeBwnpkh4nuxmE1r5hZrxw90YqnuzM
	aexEvxjRbuwBY8JEIICLCWfwgbgEDp/zhal5xCWRbWAmFGh6imggue77Z1gTQw4JGQ==
X-Gm-Gg: ASbGnctXgZqoNVoNavab6hj1uNwSEq8SBF0WJk6mKdfGSKvNnL4sRT32eiRIReC2YO/
	VzOJ5piNQrVCigQE+vadTK1yJKUYajjLnFK0WU5HZBio6hWbrWsoOqbpA8jPVPeDt4Mdnwtp/Ep
	eH63YLyNoIwoII+btrUAHhO+dxpnhd0XlXUMq/cGj9DR2aO7uZT54bpZ4bUUx7pItkf3M3bDQwn
	09cGRvNcenR3z+5gtxSLnwdhLtGNTJVd9FE+LZcZ59EGJsut0t3JLfHdR/n+QGxJ19pm+3rIfuB
	dmBAQfDUkxl16RPIUefgtzyMyJBTMdpD5cyubvh6FteZgwURZa0Wz86bT8g5nOzj
X-Google-Smtp-Source: AGHT+IFeFRf7fXY8ItbHGsczF5S/sRpaMQZSC5ENBtBuUJ/TvWbUeEnuAnFx8nQF8fRGIRrYzCtMHw==
X-Received: by 2002:a05:6402:3493:b0:607:e3ec:f8ea with SMTP id 4fb4d7f45d1cf-60a1cd1a66cmr11552849a12.6.1750694478557;
        Mon, 23 Jun 2025 09:01:18 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a185449d5sm6231911a12.28.2025.06.23.09.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 09:01:18 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <b7856437-2c74-4e01-affa-3bbc57ce6c51@jacekk.info>
Date: Mon, 23 Jun 2025 18:01:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/2] e1000e: ignore factory-default checksum value on TGP
 platform
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <fe064a2c-31d6-4671-ba30-198d121782d0@jacekk.info>
Content-Language: en-US
In-Reply-To: <fe064a2c-31d6-4671-ba30-198d121782d0@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As described by Vitaly Lifshits:

> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> driver cannot perform checksum validation and correction. This means
> that all NVM images must leave the factory with correct checksum and
> checksum valid bit set.

Unfortunately some systems have left the factory with an empty checksum.
NVM is not modifiable on this platform, hence ignore checksum 0xFFFF on
Tiger Lake systems to work around this.

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
Cc: stable@vger.kernel.org
---
v2: new check to fix yet another checksum issue
 drivers/net/ethernet/intel/e1000e/defines.h | 1 +
 drivers/net/ethernet/intel/e1000e/nvm.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 8294a7c4f122..01696eb8dace 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -637,6 +637,7 @@
 
 /* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
 #define NVM_SUM                    0xBABA
+#define NVM_SUM_FACTORY_DEFAULT    0xFFFF
 
 /* PBA (printed board assembly) number words */
 #define NVM_PBA_OFFSET_0           8
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index e609f4df86f4..37cbf9236d84 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -558,6 +558,11 @@ s32 e1000e_validate_nvm_checksum_generic(struct e1000_hw *hw)
 		checksum += nvm_data;
 	}
 
+	if (hw->mac.type == e1000_pch_tgp && checksum == (u16)NVM_SUM_FACTORY_DEFAULT) {
+		e_dbg("Factory-default NVM Checksum on TGP platform - ignoring\n");
+		return 0;
+	}
+
 	if (checksum != (u16)NVM_SUM) {
 		e_dbg("NVM Checksum Invalid\n");
 		return -E1000_ERR_NVM;
-- 
2.47.2


