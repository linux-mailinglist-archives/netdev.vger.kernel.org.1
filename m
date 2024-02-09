Return-Path: <netdev+bounces-70452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA7684F063
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 07:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE651C23D72
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 06:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B083857308;
	Fri,  9 Feb 2024 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8ywGMWI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE58C651B4
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707461263; cv=none; b=OpJx/q998f9E+XhPItI712tME5useOO2KKMq6GG9rqa/Pdl6t8lR0bbiGKGwe5YUoonrPwHkxfuCNq3IshV/88j36lrsP0ahwqA/Y0AwrWzNlXVwEWm7FJIZ304h3G5ZdG4r5xtOxcAjxBkkyM2gPOkzAwnoLH0s+A0miPlVhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707461263; c=relaxed/simple;
	bh=htRKAegrGUoj+9zEdleSObI2jo0gzUSS53ZArEOtaXQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=l4FFRQUpdWrYBF2jtNXjz3EAUwrXCCh166myXW18fu1z5UXbvNWZYgke20v3mepYiphKM4x7Y5NucMcQEMThXH144UamKEGOglIfYoMXYAqiefntnLo+zuHotAmuRxLn3TcMRmhDLRez/sQW6ekXqgQe9bz/9JCVvSHjp2T6MwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8ywGMWI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3be9edf370so30844566b.2
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 22:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707461260; x=1708066060; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e8qF5R16cd0JrgyNaKlrvh59EBHZ64zZIx9QbYlRSj8=;
        b=W8ywGMWII5QOEJerkFFGHGMFgS+8bkU33C5IUq+6PHnBR2d53mt4vH0hO3fOJMpnXI
         9F4Wnjh4Dc4bD14CTByj8LasEjQF1H5A9jan3FHwafnhH7I5QVBVs6BBJUDbdS1docdG
         VB7lTJDyFQwI+ZqMDF1WMK4axY3PwVntGA0BBCz2rFO9A+Ro0YV1XMylBg4tYptvvZpc
         IvciL/LBZ5awzcM9/r4bhoOQxkqc3hs4ydNL+hNchAHFPbfJ/xrXvl5ntEj+FsA5E41s
         2lhWA66XspLtro3tAor2FjruzvpSnDlTCczwXLqBpu/QNkLji6E14NTR48Y1f3wTkkpe
         g7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707461260; x=1708066060;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8qF5R16cd0JrgyNaKlrvh59EBHZ64zZIx9QbYlRSj8=;
        b=eKvnNklu+Bd1ccl29Kj7MqjiNjLizbB7+gHKLic1d0DDOvAqwl6xryANSI1EfgxohF
         8NAm71xkj5KXP+wX1IFeJWOYheKv1j+X2A/fD4D7ExfdVHhYGSVlR/TUhsUb0t3rSryz
         2pI6e/tcgdj2TwsBAogSyJLu3cjFEMWXtXY8zGknBaTW2ax6HkBD2ZGhBy66Kuvx8ZZN
         8m3Y3JF0Zlk83aBgeluc08uhZCwSa5rvl2fJOOdiWBdsLITzgPYFW+6x+HancTj0i8G+
         hKtC3pE/myIxQK/UqDV1tV7+ZmGgzGJoV/jB693ziz9JWawlOoveJc98eG8I/VjIXr37
         aaxA==
X-Gm-Message-State: AOJu0Ywj1PW+i9LJoUemSCvfzelGUX5OFZEYxBhQGnphzi/sf9QPZSE0
	YoZrJccblN/kgIx6FNjkhklSWfzTuEmUjhQBS2f7ZvcjQLC8UCOgRohAGKf2
X-Google-Smtp-Source: AGHT+IFceShAqQDp46x+Xv3gfAoyWiUTVpr3Byr3KbldCPwFFqIxKvb0jgURjyuH/qibOSLjnpR7FQ==
X-Received: by 2002:a17:906:d8b2:b0:a3a:fee7:3109 with SMTP id qc18-20020a170906d8b200b00a3afee73109mr390376ejb.8.1707461259844;
        Thu, 08 Feb 2024 22:47:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUceYlyu0+5Vgbs0nxVRBrd/6LAxckfy2soYktCUtUEp/FyBOhOR+2ewq/4Z2Ws7TXAbawHoct5nWlGST98/+lRVO2DdVhm+pJ6kBDoWdKVPuFLyQR+pco1RpbN+mekcBdO2Ax0RJnOjTXw63DlCy6J5AOjC/Ssx0K70pM4qHgYdWcPMK+5INttvvSM9Gk8YmMhvN5z+e7S4dPEfJ8yLcFdJZIv9gCLzgvowAaXWtCE8Sr7W9qgJfV5z71NId3P98p0jY0H2aNrkqwQ5Pyfax3fI+wQ
Received: from ?IPV6:2a01:c22:7ac0:d000:4d9f:2347:ab87:326a? (dynamic-2a01-0c22-7ac0-d000-4d9f-2347-ab87-326a.c22.pool.telefonica.de. [2a01:c22:7ac0:d000:4d9f:2347:ab87:326a])
        by smtp.googlemail.com with ESMTPSA id qx28-20020a170906fcdc00b00a36a94ecf9dsm451417ejb.175.2024.02.08.22.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 22:47:38 -0800 (PST)
Message-ID: <3e4a74f6-3a3b-478d-b09a-6fb29b0f8252@gmail.com>
Date: Fri, 9 Feb 2024 07:47:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] tg3: fix bug caused by uninitialized variable
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Aithal, Srikanth" <sraithal@amd.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The reported bug is caused by using mii_eee_cap1_mod_linkmode_t()
with an uninitialized bitmap. Fix this by zero-initializing the
struct containing the bitmap.

Fixes: 9bc791341bc9a5c22b ("tg3: convert EEE handling to use linkmode bitmaps")
Reported-by: Srikanth Aithal <sraithal@amd.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 50f674031..7d0a2f5f3 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -4616,7 +4616,7 @@ static int tg3_init_5401phy_dsp(struct tg3 *tp)
 
 static bool tg3_phy_eee_config_ok(struct tg3 *tp)
 {
-	struct ethtool_keee eee;
+	struct ethtool_keee eee = {};
 
 	if (!(tp->phy_flags & TG3_PHYFLG_EEE_CAP))
 		return true;
-- 
2.43.0



