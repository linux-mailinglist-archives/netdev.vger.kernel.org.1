Return-Path: <netdev+bounces-230195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C22BE539D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068E43B7E8B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F6C2882DE;
	Thu, 16 Oct 2025 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkFRHul4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1B3346AF
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642711; cv=none; b=Ln56+5ImEYUkmXX6gBSFI+yCHC81uJzjH6L5J01t169My+a/bA3D/09p/A5DmE8zEP2Mv3Yaw64I1Om6o5agQcDLQXEaFxSrQzcb6yb2mNuM8/U65j6ZzkVHbypaDKTR4nZGa9gwkssiKgfk+JdLo/ypWZ9NQelz9u61GDF1O1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642711; c=relaxed/simple;
	bh=5hClzf2cuptCLwFlmdyEJrsgjkK4Wm6UaINvDimZ4+g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=LfVTmRFc0aMlmVLb8RD+lXcvP3tzTJCQoVQa9Mj/O/F33gEK4qvvaIXQ6vYk2+21DKK9qpKEXTVhZxg+FRh9kr7W8bl1alU35aowpocaK9kLu/TJhbvziE4qV0KiFjBpDifIILbPURAo5qcPUByMFjo0wZiF+GCBx818Y1r0XLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkFRHul4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b5c18993b73so187484566b.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760642708; x=1761247508; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=emhKWl0KIKo781lc5mknm2iJGpKmRFgygW/E9mzChfw=;
        b=PkFRHul4TjRmBa95P1Rn3BlJvUHMcL8T8CuY/fA5/D4rzGAQ5RYQ59uMZx/ZTaqnbT
         vqpCtzppvclHd44LtT9hxJDtPvlLs8ssuFLOGhBIlPn2BwQ3fxiVHnX9ftZcxV/DrYLs
         8nU/dT3mzd2+IZ0bWrYwO+uHwKiP3pney3FZz+lpqXpUqUsSca2PrZjYXEaPEWvfhV5s
         FFaqFCUkyzWNcbgK5mE4S4syOj1vOKuD4nUcj4lJJEqcV4N9KPNszLGNWhSJl+mXT+RP
         TgdFvSTUNuBhljahCHa2ITXqTtSCUhGdumSbIBfDXdUIcSxBJZddlnxcget5/hnhz0Lp
         MjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760642708; x=1761247508;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emhKWl0KIKo781lc5mknm2iJGpKmRFgygW/E9mzChfw=;
        b=hlkzbNkX4Dk+pm+rEIZ5aYozXEKSgKd2oouHqdVEyzdWaP6v6uIJlDNJYM0yipKoN+
         XH0iHPdNKhYRyQzBVuxxpi5r2vtdCkHr03Q7tzoGIxCZP9Jrd9ACOO5uOla7MWeuQ4Dq
         BPEA3Ha0YBUG1wYs2sd5Mis50FRQA7CYGl4xB5FpgpvMhwiAjcUlwlYzFQneeI4VoVkx
         PehJgkSq4Od4U+5CkuhE4/63FIV+IgKD4kTgTwVAMUxGx2uQikYjocWwahCZmcXxZNPu
         K0aG1Vq4xG18b7MJUooNSdC3/N7HaMYBUL/1/DrqV4LUJBRSXRU8AmFj7OTfbkFoXrGC
         XeSw==
X-Gm-Message-State: AOJu0YzhqCSs3fzo33JMcA+ZgFGUeRNzqjT1i0aGj7QTDNLwwKdQMBvM
	ZR5DVb1RUSQUdjS3p1vt2TeZF5kHoRxFJ2vNsXhHERRpkVi2Kb7LaQBW
X-Gm-Gg: ASbGnctOmftwNxPUZq7r8Z22hTZ/tONmuugV73rFk9Y3gyyylVSnrnq7gbQWfQOcKFR
	Q2aeewZx9d0PrBdimuBQl7OpuykjFsqwcHpmta3riXfBTTSOKRh3etgynZfuzBj4qMdeQQxdJBY
	oz5oKXro0oG55QaBWABmqleHKS9eFNgkm0AXsUB1PSGfYTRn9bY4yNjKSvwxdxMWDp4ZMGPiZaF
	7wO2VbjiafmyvQpS5kGgmD0Kjz/neCLjXYO6v2pjKl6H2S0VbI2003V/zfXJaaT5JvEeo3bPNQR
	MhZqh5+4bJj511C3LUO1BQFMo+Kh81LE2ukJmq57+2W00A1OVBczoAS8Vknho6jmFlkIOudcHcr
	XB1tGY5yuBgO5cLcAOuyvmmUZw2gU4u/YsRouNRCtPBOmWuH1TfkzeD2FUPga32Bx919Ljli+ow
	MI9IR/f6Tx8BH1HtpH47cPJiRBWqfW8APwbzqm1dg2XRjRFU8iqIZW1PRx+gNTmId2d8Bhj6LX9
	KmbXRnmHnr8t6J6PJV7MjENtlK6FsMjsGzpRoz0Pdo=
X-Google-Smtp-Source: AGHT+IFvA2aNkVEVR/ppVS5KpNcbUWteRT9s/4DAHcnTHSu42ZxxiFC2SHgHHeqr9dfWUqhcYdbKnw==
X-Received: by 2002:a17:907:3e96:b0:b46:cc3b:65f8 with SMTP id a640c23a62f3a-b6475220c06mr119549566b.45.1760642708189;
        Thu, 16 Oct 2025 12:25:08 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f27:2100:21e7:7c7d:15e0:869f? (p200300ea8f27210021e77c7d15e0869f.dip0.t-ipconnect.de. [2003:ea:8f27:2100:21e7:7c7d:15e0:869f])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b5cb965cecesm591177166b.3.2025.10.16.12.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 12:25:07 -0700 (PDT)
Message-ID: <a5c2e2d2-226f-4896-b8f6-45e2d91f0e24@gmail.com>
Date: Thu, 16 Oct 2025 21:25:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RESUBMIT net-next] r8169: reconfigure rx unconditionally
 before chip reset when resuming
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There's a good chance that more chip versions suffer from the same
hw issue. So let's reconfigure rx unconditionally before the chip reset
when resuming. This shouldn't have any side effect on unaffected chip
versions.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d18734fe1..2a4d9b548 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4995,9 +4995,7 @@ static int rtl8169_resume(struct device *device)
 		clk_prepare_enable(tp->clk);
 
 	/* Some chip versions may truncate packets without this initialization */
-	if (tp->mac_version == RTL_GIGA_MAC_VER_37 ||
-	    tp->mac_version == RTL_GIGA_MAC_VER_46)
-		rtl_init_rxcfg(tp);
+	rtl_init_rxcfg(tp);
 
 	return rtl8169_runtime_resume(device);
 }
-- 
2.51.0




