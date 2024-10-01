Return-Path: <netdev+bounces-130828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55D998BB03
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDA92839E7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611391BF80B;
	Tue,  1 Oct 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRMh12UP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E401BFE08;
	Tue,  1 Oct 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782051; cv=none; b=CPSsPkfg5CLstL0RXnXd/y8xfgVQFRaglvRHBtL8o2BUaIiAg3WvCVENZdrSJYzhnSsgDwJQgUxXkOLBh4SRuVXcj3UBHqMIax0/X9DNvWxWhjYMJdF9NC5nwQjNhAhafqMO6np1T6Jujd538IIjafUAqJ4WS0O5fDpHTqX9Lig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782051; c=relaxed/simple;
	bh=z1tvJac+wulzjgyyNBFmijEAw1eTJetwD0pYE2+CZvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7mE+SQIMNOMJXLsN6v8twlNEgYlj5e9oZa5QJOms9ypGKr8p9CkMHFMNWDxmg+4J2Lp88+h/ZyZ2QXHv7xz716rRIrx5QNydV5x7qborIp7IFXRlnEQMUA6/4otWANwR+OUtUm1pi22jd+SOoJ0FI/8osiD9U8pAnpEn4LjMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRMh12UP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b6c311f62so23521485ad.0;
        Tue, 01 Oct 2024 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727782049; x=1728386849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrPqaj2Ya16E49/9o1fMXj5stPoK5YS0iZG1Gh86Sgs=;
        b=eRMh12UPOJb5e3FDmmLvuucQPgfDYJPeSIvzompJwmDXH5uVcmGq8yK+nyKkLnlkpS
         ZtgCT2+M9LUOsqCqKLSuM/Kd9PwTiJXf9EXNtrBlgWMhEZGSUWT/Q3V01buIHfWe5nKT
         95xBuYsUlQxGif/i5vhdZRyNg9vPIPMazw40YySZKFCbGBpZMQGtxj3tppcmalE5SjC9
         qiK8XXNCkuGQ9O486/5xJmPWsEB3YC7bRJ4ku6UHvrJGBmtLOEvhp27ulx9Mqu1a8oY8
         w0gi9v/eC3qKaYa2cii47zYfo4UTU6CSTALmZABK5jhRjT0/NHTcFC6GfasVULJkt78z
         c2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782049; x=1728386849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrPqaj2Ya16E49/9o1fMXj5stPoK5YS0iZG1Gh86Sgs=;
        b=IzXvANk4iD0DsNll+f/xIB6NKwcdBXo0xVvzxMRA/N3Nd2c6q0EZ7e1oiZrzl70rvc
         GVun9bRUwE7ax/36lMb+9XMeFMx9FBUPVN6QAqmCmlPktRlcya8qn1QKOVH8UxvWFjyj
         jLeeeBdSDaN+xGqHR5e3gQgAjnngoa890V2WVNWgyoX3RNEPNUjgE/ML6T1pueJH46in
         FPdb3oQgzVYwBurV1u2Xbjo76Wb9SdajHO4xF+Ra1DfkR0SlfaAs0xV22fsoE34u/C08
         rnZ+EE8rIr/ICLF78x1nSUNlo9qs6pgf7I3oddLUzeb1olX8a7RHI6CGvgj44ITlBnO9
         GzDQ==
X-Gm-Message-State: AOJu0Yx9brdK/KtEh/kaOgY18C6AbLNl0SceA/iwg1wxvrx8y7xc1aeG
	DyCsuUcsdaB7zzuBUeh6b7/BPwnSeVThR41/FE5IlbpRssF6RyAsUte6emlc
X-Google-Smtp-Source: AGHT+IGmIDhOLA/7JLQ0sE0UPPYPP2mEHWIqxQ4GSZjbu/nlGpBOwiyuskrgx7YHjuKnO8F8RbUknw==
X-Received: by 2002:a17:903:187:b0:20b:a2b8:184a with SMTP id d9443c01a7336-20ba2b81e52mr44584215ad.50.1727782048960;
        Tue, 01 Oct 2024 04:27:28 -0700 (PDT)
Received: from mew.. (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e51330sm67893655ad.254.2024.10.01.04.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:27:28 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com
Subject: [PATCH net-next v1 2/2] net: phy: qt2025: wait until PHY becomes ready
Date: Tue,  1 Oct 2024 11:25:12 +0000
Message-ID: <20241001112512.4861-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241001112512.4861-1-fujita.tomonori@gmail.com>
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wait until a PHY becomes ready in the probe callback by using a sleep
function.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/phy/qt2025.rs | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 28d8981f410b..3a8ef9f73642 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -93,8 +93,15 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
         // The micro-controller will start running from SRAM.
         dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
 
-        // TODO: sleep here until the hw becomes ready.
-        Ok(())
+        // sleep here until the hw becomes ready.
+        for _ in 0..60 {
+            kernel::delay::sleep(core::time::Duration::from_millis(50));
+            let val = dev.read(C45::new(Mmd::PCS, 0xd7fd))?;
+            if val != 0x00 && val != 0x10 {
+                return Ok(());
+            }
+        }
+        Err(code::ENODEV)
     }
 
     fn read_status(dev: &mut phy::Device) -> Result<u16> {
-- 
2.34.1


