Return-Path: <netdev+bounces-83501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EFF892AEE
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 12:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FCE1C20850
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6581E896;
	Sat, 30 Mar 2024 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVrctO8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F51FBA
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711799345; cv=none; b=lCb1yvKkqViLPgto6qBd7bGC1k4hY0gBevNa0w0YFCPxaUzW8VqzeHY1sgQ5A0FZh954+I2gvuR5n12hCQHsHJOgS5v/Gi9u+v3Z361912dKPC831fqJeSvjkjXuFTKai996glJw7AiXxRj1daS/+64xfEAH7nOye8R2uvW6qdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711799345; c=relaxed/simple;
	bh=nBJiVvg3k1NRVdugpi2ZiNvoICXFmLmlgnxcSt64rsQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bOFOB4Ut6Pdms1hLzqrSEMPNdhBbNWKaAAO/AIGHweFGIPic6DdWY33YstMKOGFi2afh6TlvhZikb69HCwYX96G7wzEay625oRQ/C34wz6nbFOqbNShRgI98Jz9f9K3ZOz4Gj4T0WDXuPOMGLDx1ptF7wMke8KKKujk94UaGONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVrctO8z; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46de423039so155836866b.0
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711799342; x=1712404142; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5NtRlwss60JP8pGsT9m1cDwtgx9pjihCANYuglI/hk=;
        b=RVrctO8zu+eAZG9EPTmxRiyu/calS/TqaP0F9ZG8PrZ3/Jo3xjwKLN8X4ZK/4TYU3a
         rSQrSlu5HqF0fNvrt30exFRh/qgp4FtByN+zrvfsz2PY2w3Gr8ngJ5x2tZjtG5ZMTFGP
         O+hxZuVu6OyqZAMPlhZY7bAdrR+Fpog76voQxreeoudyRHDCUenycUpIjHQ688fH829b
         UctP8Y1SNHFVQC6TWYhBVHegQXRMVRDB+0n3awk40INjMzoFJFdITZJ8LAR5MDUlDMtG
         sWqD8HXMN/HqLl0EJG70kLL1thNSTXta6DucUB+dtSrocDb+5bw7cOTLyWUiC8gKDJMQ
         wjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711799342; x=1712404142;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5NtRlwss60JP8pGsT9m1cDwtgx9pjihCANYuglI/hk=;
        b=r1PER1fL8VFDVe9SflApOYV2puqWqsBrWbxhnATCsUElFfPojXXpuUEOa7Cw6jlO1I
         Y/JOqFZgnx35/xPh2HfP2MdJbs5QrFiMuoi00FDdA5Fmy0vd4YL8Jdg8qGU+HAJV7pPB
         fbo/CEse2MLtmpmx8IHLfcaI/bGqZOMbEF/pjD237xpKFVhTWHH8q/4dXf/yFIdn/VYw
         eemYFXJJowd4CahQQc8ehoZX3mUioC7PbcpqYUjjt4QMoNrrnBqrMvrQtSCp8WHqvr8R
         nRiyYqoz3DibT21nVLN0U+Gz79hMyslNZTzHQCRzKNSPWINkqZykNuRS94/nfxghgG0h
         t5jg==
X-Gm-Message-State: AOJu0YydR1ERlIv7pJ6TCclWGN8YIK/hLrH2VXj/ZXo3xo7n8pwnoQ2q
	ElWoxeTBOz/b7pIq5lCvSn4PtwgSN583DOnzQnq/FYwMHouK8T5Y
X-Google-Smtp-Source: AGHT+IGQ0cjHf8II8DkumlvWkLc84Qgd4pmaAGa35vXiFfYnufrSy6ERo1o0GCNl7Oj0HqwD+/Z78w==
X-Received: by 2002:a50:aa8a:0:b0:56c:5990:813f with SMTP id q10-20020a50aa8a000000b0056c5990813fmr3776712edc.17.1711799342242;
        Sat, 30 Mar 2024 04:49:02 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c54b:5400:d8e5:ac12:4b1:6e15? (dynamic-2a01-0c23-c54b-5400-d8e5-ac12-04b1-6e15.c23.pool.telefonica.de. [2a01:c23:c54b:5400:d8e5:ac12:4b1:6e15])
        by smtp.googlemail.com with ESMTPSA id n24-20020a05640204d800b0056c5d0c932bsm2043917edw.53.2024.03.30.04.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 04:49:01 -0700 (PDT)
Message-ID: <64f2055e-98b8-45ec-8568-665e3d54d4e6@gmail.com>
Date: Sat, 30 Mar 2024 12:49:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] r8169: fix issue caused by buggy BIOS on certain boards
 with RTL8168d
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On some boards with this chip version the BIOS is buggy and misses
to reset the PHY page selector. This results in the PHY ID read
accessing registers on a different page, returning a more or
less random value. Fix this by resetting the page selector first.

Fixes: f1e911d5d0df ("r8169: add basic phylib support")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5c879a5c8..3936db3d4 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5141,6 +5141,15 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	struct mii_bus *new_bus;
 	int ret;
 
+	/* On some boards with this chip version the BIOS is buggy and misses
+	 * to reset the PHY page selector. This results in the PHY ID read
+	 * accessing registers on a different page, returning a more or
+	 * less random value. Fix this by resetting the page selector first.
+	 */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_25 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_26)
+		r8169_mdio_write(tp, 0x1f, 0);
+
 	new_bus = devm_mdiobus_alloc(&pdev->dev);
 	if (!new_bus)
 		return -ENOMEM;
-- 
2.44.0


