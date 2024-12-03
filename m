Return-Path: <netdev+bounces-148703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7EC9E2EEE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1097F1631E1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE841F472F;
	Tue,  3 Dec 2024 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEHcituU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2411DDA3D;
	Tue,  3 Dec 2024 22:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264209; cv=none; b=fi1NywLqs9sM7DpYCoWkru7tklcYxuXdV9FgHCnr9XMWXNfT0SbfTARsjfRk5OegQE3EEm6nBHk5zN41YdOd+DD51Lt5gTLTLR9vmuRY6WzXpZRFbdOpDi+pkvsspMiCCAahdBDpiEQCnGypZNMw43KtozSsJLR4H+rReKk4cMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264209; c=relaxed/simple;
	bh=XBdFAs2cPxI0M40uwpUcyfZkFGO2YXBhz/J87Pe2kwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EglS9uamj90jvCut75yqF1vLqbE2Hka8q2AIUDsl4no5x9ufxlcTPT8ZsGNGf1BdNIGYxEdVllYdXJjV01yMdbBBthI1Ti8uYdRXhF4M1Y6Nj7UlYBY3FEnvLl5kmS0sLYWaYIUCeaUOsoarUQ1cIt6sIFSPDL/JpVowlE9Fsls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEHcituU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-215bebfba73so12967475ad.1;
        Tue, 03 Dec 2024 14:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733264207; x=1733869007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=haiTXTrqAzXvaUPvAaWiZpIXLnFLLaTifEtYnRB0sCA=;
        b=HEHcituU04e4MysJwddc1UzOoJtwxf3xOTbcHN1CWQMkCW5NJpJOMQxloNEcG3B9Ds
         h3azCKJXo/6hbWWtNRJ0Z6ln6aiC+paVcm4LqOl1C9raVD4Q51/0GDebtOeIOuNJtLEo
         0v+W89t+Vb8pvfDMnzbTt7iVd8TOyaFNteo8LshiKip85SWtLHqmGcVLGswEVsMApmxw
         2kJhiNdTqQp0PASCx7XHCR0REfdNxg/gnFB6HPrWwJ5jO3iEYigfDjRTYnU6fJXwM8XO
         dT10hEdfU7G1Xc1TydzBCSZWQ1AbUkn79X6f6fMhMb2jcd8IH0Oi+rBIrF2LL5GOgMB4
         /2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733264207; x=1733869007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haiTXTrqAzXvaUPvAaWiZpIXLnFLLaTifEtYnRB0sCA=;
        b=bh8d1k9+MujAzzhQbYyhV21nCbrunrd3ywJHn9TaZ3xalucwi0s/L0WdGRwEqNMvyM
         8hdu8rD10WEybRE48y+4DoCH4/2fWg9hVUG5bizZSFWuK7ubezYT42tsEVCu/2geD3cG
         wZSiLUGfffh+BERHdrRKnulqxAEVP7r3N8XM5sqpQa55oudQE+5n3TTIwwzh7xq5xHjy
         m7pEMTAVie3qqtbVFRt9NLpKCFCfYVMKTdr9gm7T9aABmE/T9Lxuao2wu2zS2IH3qgPz
         dNva2riyQe8v/KHV5ZpF7SW2yYV5HOsjGI3gl/EcMs6D9Tbx35sE4xbZVme3qFlsCNzq
         Xfkg==
X-Forwarded-Encrypted: i=1; AJvYcCWXPtG6FPtDOtajwxuj7CohGCaYXQfSsk9QGvSX4kHJEJDUnoNtpUh5dufAgUIZVEChO+djOYBXsWtx9cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLmxHWKyXVdEhUqK0AE1wDs2zY26A8JYZ1Oq7EvXJnzoI4cepm
	3SMZPALMA9LL0/3/ZLAhMecqt03iVVPJ34o+Ae2pgl6JdhLOSZt+JLPOZY42
X-Gm-Gg: ASbGncvOu7cQx0X5+Y32WKb26I9lPPNO6AFKAnvuhs7FV0KetUgP2WQawvL4er3tiKN
	m6U/Qa0SSfXzWoUEJzkCBJK7KavFHvIP5ept/0rCx+knJbISQ2cJA37nOUYosLWbAk33U2kU89D
	nfl1FReTcF2GDJmerVefa1SPy/8JbLLyEa3jBX0zfET9awRT/TBi5DgiJW4cOdacrCrji/jb+B+
	/lJ9O8C0Ebcn1u5BsVowyowMA==
X-Google-Smtp-Source: AGHT+IEmvnMN5zq41czJHWt8tfKHMOEoDQ63A4/d8pYoRt8VJqv5NsgIbsvEgSAuj86bIrvt97ufpw==
X-Received: by 2002:a17:902:d489:b0:215:401b:9535 with SMTP id d9443c01a7336-215bd13edf3mr56138685ad.47.1733264207189;
        Tue, 03 Dec 2024 14:16:47 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521904caasm99779045ad.60.2024.12.03.14.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:16:46 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	ansuelsmth@gmail.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next 0/2] simplify with devm
Date: Tue,  3 Dec 2024 14:16:42 -0800
Message-ID: <20241203221644.136104-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Makes probe simpler and easier to reason about.

v2: Just resent.

Rosen Penev (2):
  net: mdio-ipq8064: use platform_get_resource
  net: mdio-ipq8064: remove _remove function

 drivers/net/mdio/mdio-ipq8064.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

-- 
2.47.0


