Return-Path: <netdev+bounces-97392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF2B8CB3E8
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 20:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830181C21342
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE17A147C95;
	Tue, 21 May 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="MYS8fL3w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389BE1FBB
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317819; cv=none; b=Ul1XXqIZYWXUhO4YoS2tmu1JkKXg9P9tuBIW/F1a1Ljp5EAhoPZnssxXmoDkEROZ2tXvfo3KFEhm9PO4inOcssCGS8TSX7CpAKrudCfWQh4vGPhDQyPF3MMlCHoTwJHsXP1EGsfjl7qV4zKf9rMMgFRyQeICyrLIIg5vpNBi7bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317819; c=relaxed/simple;
	bh=uT+ls486dG8nHmi/MyCGG3XvVfsPdmT4J2Rnn+NHSdE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sp84XRQgY65wslxf/QZV0dy2rtHZT1mcvpb/uXmaZd2ZAux61x4QpBc35gZTJoWOlWIyetjcGYX7mrIdcHjP9CuNxTanIQthWIL2La5X77zLNnhMoXHCwJVPpouRY4nfmP5MUDASYJywvGXcZcv4rvQR3epDT7lX96FPDXwxSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=MYS8fL3w; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e3b1b6e9d1so67200081fa.2
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1716317816; x=1716922616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wK5e67Jdl5vfjzEOu3Eo6/JgeP8I4p2OioGReqzd8h8=;
        b=MYS8fL3wPzIJIPY41/mzt1cBgKJp0tSU7hDVp+u3Rva+IadjYFBeNQnVBc7ywkbHRz
         zWAikAMUJSB0xaWxHd+wvf2WDxKWizgBCCzJ/8M299ZekO0lG55Mf8NMI2lep/I4Xh+f
         0Azn578DgfvXtKippuirqphAY/2SQoVgRLao8PaXRAhiwVc+Z7MOrVGl0cGgsAeRH1ih
         IzBMPegnpgpf466ZE7sl5mYWJivlIkWm1rRvKNDDbSqMLuEmyDObGfTlPlyQxunMlqcC
         oFOiJ5wBSbLfNYx9Jfda7YX6JMh/KoasB/YJ+wVjX9NDWK/zjcoNhDEmJyGDhCsvRDmh
         uq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716317816; x=1716922616;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wK5e67Jdl5vfjzEOu3Eo6/JgeP8I4p2OioGReqzd8h8=;
        b=ZH7vWtaR4e61Et0cbR2WFwq5SVS1uFrx5NMOni8CbQF5lX4XqjvTGO0qx1luHP7vl/
         +PnHlGhg2f3a6P+9Kb7XQvllaNzbxOaNLetzaCGg7vNWy7vXEha8TldT598PEwbiz3ix
         sehvxa01G5kVQ++G/uO6TBdKMknEuoDKuPv2xbDhNTbS4DxunvpEgb/iew1xzGOvs0Oj
         YZT3k73whr9j5M8cR53lH6udunXfXMHJe2EGjGAQvPDy9X8V9yoaU8lz824IK9YtpRjl
         2L8seSwIIfns/Q4LEHXDPXYdqgOA8iwztzoKw/rg6sGVDF5SxKpk+zZaSmy8Km7av1jk
         ep1g==
X-Forwarded-Encrypted: i=1; AJvYcCU+MP9hOOWdAg9kGcp1wiHP1Pkh2diYbnGPZp8r3GCeXjWrJmc3vANuh4lqGv1/GgFnHjdKoArpUJJgdVSJdX1QoH73dY6A
X-Gm-Message-State: AOJu0YyvrDgBzJ7gkdACCCt5oqmkaQHn+CXSpau5OJ/5JwcZudtnS545
	nc9eM/nPkyO05G7ngIzHzZR8KGE7RdJ7zkyg6NSLsMSOemWLy0f/TlgxUSUw5uC48eDu+lMaAgf
	Mg7DuUFONF9wbopZ+5Jne/RrYZSHTN+gbz+Pj
X-Google-Smtp-Source: AGHT+IEqPa+du8fjYKGXkpILJkupqk3Qb0cGifkvSVqA1SHvtN7Dt3pRQ9a8SeREQmZzpASy17m8MSkPD92GjkUvBm8=
X-Received: by 2002:a2e:a58b:0:b0:2e2:891d:5f62 with SMTP id
 38308e7fff4ca-2e51ff6692amr237140221fa.29.1716317816220; Tue, 21 May 2024
 11:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Da Xue <da@libre.computer>
Date: Tue, 21 May 2024 14:56:45 -0400
Message-ID: <CACqvRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx=8=9VhqZi13BCQQ@mail.gmail.com>
Subject: [PATCH] net: mdio: meson-gxl set 28th bit in eth_reg2
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

This bit is necessary to enable packets on the interface. Without this
bit set, ethernet behaves as if it is working but no activity occurs.

The vendor SDK sets this bit along with the PHY_ID bits. u-boot will set
this bit as well but if u-boot is not compiled with networking, the
interface will not work.

Fixes: 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support");

Signed-off-by: Da Xue <da@libre.computer>
---
 drivers/net/mdio/mdio-mux-meson-gxl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c
b/drivers/net/mdio/mdio-mux-meson-gxl.c
index 89554021b5cc..b2bd57f54034 100644
--- a/drivers/net/mdio/mdio-mux-meson-gxl.c
+++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
@@ -17,6 +17,7 @@
 #define  REG2_LEDACT GENMASK(23, 22)
 #define  REG2_LEDLINK GENMASK(25, 24)
 #define  REG2_DIV4SEL BIT(27)
+#define  REG2_RESERVED_28 BIT(28)
 #define  REG2_ADCBYPASS BIT(30)
 #define  REG2_CLKINSEL BIT(31)
 #define ETH_REG3 0x4
@@ -65,7 +66,7 @@ static void gxl_enable_internal_mdio(struct
gxl_mdio_mux *priv)
  * The only constraint is that it must match the one in
  * drivers/net/phy/meson-gxl.c to properly match the PHY.
  */
- writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
+ writel(REG2_RESERVED_28 | FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
         priv->regs + ETH_REG2);

  /* Enable the internal phy */
-- 
2.39.2

