Return-Path: <netdev+bounces-65240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B3839B8C
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21F32842AA
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCBD4A987;
	Tue, 23 Jan 2024 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea35Vkei"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80587487AE
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047014; cv=none; b=D66yS3M5tqse1aO1o5x1arPK3b1pGe42XdwDf/GMZfRDnY1pOkW9fM+2WEzC4ctVfspf8t0lvsQkNlnMPBhbSw0W3bqZ2h+F1KtigR8onnHAExUkpd859hpM5wDtYpzhaDzfvUz6TEdmBPSAn2GI11gf3efR0HMo7fEzjA3TWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047014; c=relaxed/simple;
	bh=dQad2+Z/Xb/mU7me8aRLowsUyHw4NHkMWxImuVtMQuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHZVOVDHrsKL/q9Pk6U/77wF00JdPCVvaDX5pCw5mbxEDZ/1m/PCdvV0zm8LxdF91jP2WNpDZjdg0JsfIYLUPfHEl8qSaZbFoc1OV4OwQvgyf9EUB/yaxtbcS/UZa6QWk/mvi7XW+aiOdAv7vt9NsOI2bu5whQ8INFkldEFNOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea35Vkei; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6dd7b525cd6so916944b3a.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706047012; x=1706651812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhR6ETdnDbAnJOABgKbs6pb2nligN/fWqMlDmzJKoA0=;
        b=Ea35VkeisjSks13O/CDyE/05cSdshyiamlJAsHKi4nfgsyxBKFXnDGQlLo9OEYwFQ3
         +F+j08xsrUlRe0oFkyGosJAuStdUBRKphe1z1+Xvc0thsLoX101uGTX/hMKjZjYZ64SO
         cw5TlSE72iS6zGZR02l2/8jQxZW8SYw/EjM99I6y1avF8+LcymyTU2auF15xTSRpUMxz
         dlcVbs62QxE31/oRhjtKTKwKF0Vy28WLnAispOq17vFxRvBoXk2jOp23RlJjRxCKDPsz
         y2Eq5MGDUoIaoTcW4Y4VMMolnMKpxajofv8qRQ9TXfAjNHVJ/m/CyqbWofPVrFOdvJ1e
         sCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047012; x=1706651812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhR6ETdnDbAnJOABgKbs6pb2nligN/fWqMlDmzJKoA0=;
        b=SWYtm4NDtDg+toSlAyPsGNL2kBs+ZZrXcOVPKgYtaZIp67IqrlUuRUrfRcbIWcQUcS
         Z8jy/vEjEj+esoe53BMwSypF9GQgkxoZwxHa6hbRKhQglQLtimUj59CHINhjIvH6GFnU
         qU0qibgLulLB4DenncZz70+5PxcexxBvqRQoiFc4ZtktrJYSIsfzmQNrJQzMGOJvtlRn
         b/kFKO0VWM+Oqc9swSEkzXB36P4zpbO6dNf8S+q61sgWCXBpf0d96XjRyuzvixbA4Zp5
         XQ6pLtmDpltrNvKbHp3RBWyJ0IQUpSN+CKiJfUBkO1GEAmhWy8njCDz9nWQOTnXdINGV
         mioQ==
X-Gm-Message-State: AOJu0YxGMGxUkyvgTdlxT0wBzapLYXFfBMs6mJ8+3/2cu5NkOo65ylGX
	5gR8KxxqpQgjVFLQpQgfEvJZANGM6evBOzHXaKGKG/m6lhNJG3I4QuITupArgMI=
X-Google-Smtp-Source: AGHT+IEB8oHdNs2KIA/e3/fmkYwnZP2g98IKR2XL7CINA+bv+NqoaMq03aOudnpg428BRtmuNdee7g==
X-Received: by 2002:a05:6a00:1812:b0:6db:e54d:3ae6 with SMTP id y18-20020a056a00181200b006dbe54d3ae6mr3469237pfa.42.1706047011812;
        Tue, 23 Jan 2024 13:56:51 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id q17-20020a637511000000b005d43d5a9678sm693738pgc.35.2024.01.23.13.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:56:51 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	ansuelsmth@gmail.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH net-next v4 01/11] net: dsa: realtek: drop cleanup from realtek_ops
Date: Tue, 23 Jan 2024 18:55:53 -0300
Message-ID: <20240123215606.26716-2-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123215606.26716-1-luizluca@gmail.com>
References: <20240123215606.26716-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It was never used and never referenced.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/realtek.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 790488e9c667..e9ee778665b2 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -91,7 +91,6 @@ struct realtek_ops {
 	int	(*detect)(struct realtek_priv *priv);
 	int	(*reset_chip)(struct realtek_priv *priv);
 	int	(*setup)(struct realtek_priv *priv);
-	void	(*cleanup)(struct realtek_priv *priv);
 	int	(*get_mib_counter)(struct realtek_priv *priv,
 				   int port,
 				   struct rtl8366_mib_counter *mib,
-- 
2.43.0


