Return-Path: <netdev+bounces-235810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 584BBC35DAB
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C61884F6EC7
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4A8320A17;
	Wed,  5 Nov 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKOzkVFR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0809F31DDAF
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349517; cv=none; b=twO/MdodY+e3jhRvDbGA6LjBy8o2CdAnl76M5mZOUdvOo0IKWeZeBt73MfFAGGV4t+jzJ5bhXU7LXn5bYh+7IdQxaIkGcr9w2hoTO5sddAd8gxTE++5nPJXorNw2+NZ0JAKqht3w8c82D8LybPgF2FfnREIh5g2HJ9JNyzUYwC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349517; c=relaxed/simple;
	bh=MP3cL1oYebmC+ikDcuXun/rbIUAB+b6coo4qpDEgtAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4Otkbf8+2hnAN88Paq4LNIPPtwWE9F+kMT9RJDTgGrTtQygXUuMOvYDyjQhBMg1PMVvqSkOhfdIYQBUxOQTYDdX1J1Je9LWUxfjEpScJ24lc5F82sQ3ORCRzB9Hpg2ZA4MtkWjhGU4B0hO3UAsnPNi7uk+4mRe0MslcRyRIN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKOzkVFR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso1586502b3a.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 05:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762349515; x=1762954315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9q7NmFAvFvN7/b+XYPKzCuzMXs5E1SZ+dhFSeIfp7eA=;
        b=ZKOzkVFRQferQLJYfz8FK7HIiOFsLQT+TiB/ghnk2mkOtNzSqpBUyHvXqQ10cajnWS
         qJ2JnlbTV/4cG/yZaUxP0cfU6i7rxg8M+V6cYUL4R1w4GlH2d3XjD7XndNAUm8poJx2f
         2Rgg6qM4JHgNggQfAf1s6n5tpdK6amjrJhNjvsxlXtCF42hMTN/nDRpxyNwD3+iFOI8Y
         lyHOUt0md0KHUuSpwNp39fG4SDS6BpOAHUhyfOhn46dNJ5ZLvOmSLdHIYjkX+ef2jgN9
         lfkRHOgOEh+Qj1I2AQVz/N5vQw0tjUSF/MUdLEcBOiSaiI+eWYAvAZj/nWzq97Mz1qUV
         qZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349515; x=1762954315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9q7NmFAvFvN7/b+XYPKzCuzMXs5E1SZ+dhFSeIfp7eA=;
        b=q++IpU8lbm9cj65hjadz6Yjzln0O3fZnTU1dDWzrtR/6PnWIT0I/PyLM5by10+RQ5Y
         L5pOxBfvja9pA3EBhQpmP4BLJAUYBp3Bs6S/cbzgGaEXslLUt8jq0N04DWcCHVtwzStZ
         wcVXyOLSfQ82NZeeZz/9dEeVyhHKDYw+q25acv8qUn7SNXA4+8w3uHh839QauyhKPLuU
         MN8iNN3zkq95ppgW2ocMZACxN/2BRnxZd5TIVTZPeHq5Ubfxwhn5rPsMVYAbQuTnAkl8
         kz0JM6Kxc5NQd656p+/8qAms8hD83WRrfs2roIwDQzhgrHyO94ZGCpnTlc2V/Ep2LHIu
         uj4A==
X-Forwarded-Encrypted: i=1; AJvYcCUB/7QAMlh6GgKS4Er7ganHBpWCZoG62cTZMiuF/vtq0+TJxqO2T7MHXU+8p3P8D95aX5GiRoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRS7x6DeYSdSRQz1ZyKnQUYnz7wkJu0TsLYPqwHa1Oh/Gk0tm8
	HLqnh+U+WnA0xj0snlhXE99aN5Eul4V69843mSJIk7t8MCT1U+c2OSHR
X-Gm-Gg: ASbGncsBACV2PgjuS09jWqrN066B+F3cCy13bqXGH+XC2ryivqRrs5guZA8DWsGUwo3
	BhczoOVGMweEsn/mAUeCXF7525GaL+JREm0D3ZVwbgQ9N1jqv35/sIl0HgGYnfNl5jXe7UisGey
	i3ZXVQFERsuShrJJVtHFXEqstMdj2h9PpwdrIqZSa3s7tMOEt9fX9UoylFOCNAi1Ucnmn6+rMxn
	x4diS/xlWhWHx1lgICyVbLYD80rWuxRmb6E7Y838EBJGJ9SZ8fQgD5jDGBKy97/GMgRiDqUdvJp
	nzkgBpAhjJiw29X3quYWvCcOiqVlnPw/+1QHngv5TApkoqVBMN5Wie8/XsFkYc/4D2FfEBi5asi
	dHqqqIg6ES76f1AFJi2/qnOPjL3vTfVGBr5eTHsY4fR5dan2DpSWLqBqEYKDOkQ+qOf4BaYm5aN
	ovA3oZP+W2ITgPBp8C/adZtXvJfAWYNWswKb5sxddyq9jBA++Z
X-Google-Smtp-Source: AGHT+IEOr6yEZt6Lg0Vg3/B7D14110LC9/cBO37o4H78DD0sx6yTnN4rQct43XksS1O46eS9oX2C9w==
X-Received: by 2002:a05:6a00:2e91:b0:7ad:de47:f685 with SMTP id d2e1a72fcca58-7ae1e6c6a14mr4949434b3a.17.1762349515131;
        Wed, 05 Nov 2025 05:31:55 -0800 (PST)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd382ad96sm6419447b3a.22.2025.11.05.05.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:31:54 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>
Subject: [PATCH net-next v1] net: phy: qt2025: Wait until PHY becomes ready
Date: Wed,  5 Nov 2025 22:31:26 +0900
Message-ID: <20251105133126.3221948-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wait until a PHY becomes ready in the probe callback by
using read_poll_timeout function.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---

drivers/net/phy/qt2025.rs | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 0b9400dcb4c1..aaaead6512a0 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -12,6 +12,7 @@
 use kernel::c_str;
 use kernel::error::code;
 use kernel::firmware::Firmware;
+use kernel::io::poll::read_poll_timeout;
 use kernel::net::phy::{
     self,
     reg::{Mmd, C45},
@@ -19,6 +20,7 @@
 };
 use kernel::prelude::*;
 use kernel::sizes::{SZ_16K, SZ_8K};
+use kernel::time::Delta;
 
 kernel::module_phy_driver! {
     drivers: [PhyQT2025],
@@ -93,7 +95,13 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
         // The micro-controller will start running from SRAM.
         dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
 
-        // TODO: sleep here until the hw becomes ready.
+        read_poll_timeout(
+            || dev.read(C45::new(Mmd::PCS, 0xd7fd)),
+            |val| *val != 0x00 && *val != 0x10,
+            Delta::from_millis(50),
+            Delta::from_secs(3),
+        )?;
+
         Ok(())
     }
 

base-commit: 89aec171d9d1ab168e43fcf9754b82e4c0aef9b9
-- 
2.43.0


