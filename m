Return-Path: <netdev+bounces-145864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEDC9D1334
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C136B240BB
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D220819FA92;
	Mon, 18 Nov 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oafBZTBN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E719644B;
	Mon, 18 Nov 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940238; cv=none; b=hofyNgxrROt1x0htc9i2EdetaHKIt3IRzryqKUMEJmJ10czPTbYt1Kg06UAWi4od49r6CPFN2HWO8BZiJDGdQ0rnWbGHXylGw8HgdUoj5F++vTuafvhGzUCKofhHUV2NWdJ75biNb4+Kr6uMcYSbIF+Ig6PPUmDTJ3dWTwh3bEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940238; c=relaxed/simple;
	bh=FXq5Cf7VHzuwBMR/MOh2YNWTogYHGhhe16mnSSQYCcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mbvR1ylA67YAjkn3y+D2Q6Vg0U0XSTC6sCaSJ5/0Yri9tEI4fqE/CZ3H5jHDyAdLGfbFmZiKZs1BjzUZ3H0yBa0rF3yDzVaTFDcpXEdd3WQLDn/M4NHEIQeahVbm7/mhkkNe0YVL13A5sUptKnX++biRU7BLyUVtCDjSRFGut3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oafBZTBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29677C4CED6;
	Mon, 18 Nov 2024 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731940238;
	bh=FXq5Cf7VHzuwBMR/MOh2YNWTogYHGhhe16mnSSQYCcA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=oafBZTBN6oM83s6qc8zTXIdfC/ZRGXKP1YY4TvT/xg81NyJMlfISNvcbl3j7UO/Ri
	 iX2kpv40Mryg+f744vnFLgBSIKUi2TzFHtUiLy+nfcI22ExsJof9hl7J7UA/DMA6AE
	 fWiVPU6qR4T4jYbdciQVXPOcJ2yOPKvG0rMDcXu9wUa8t+Npe+XOxbDXX2AxRi0WgJ
	 CIBkG7auw+BaCS/0USFugCc7PMEOrp82zY3ZQ56R0xhIbYMKBu9rGEz+bqvQ3xRZwW
	 rAdEJFbwZFFhoFyDdSEbXsKi4oSKhxkc7YsnEYpnm6ulbM8gZLnw4JjlQYzlpRLeJB
	 A86ii8i47bRyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15317D4921D;
	Mon, 18 Nov 2024 14:30:38 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Mon, 18 Nov 2024 20:00:36 +0530
Subject: [PATCH net-next v2] net: phy: qt2025: simplify Result<()> in probe
 return
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-simplify-result-qt2025-v2-1-af1bcff5d101@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIAItPO2cC/4WNQQ6CMBBFr0Jm7RCnSgRX3sOwgHYqk2DBthII6
 d1tuIDLl5f//g6BvXCAe7GD50WCTC6DOhWgh869GMVkBnVWVyKqMch7HsVu6Dl8x4ifmFWF1Pd
 NY2quLqwhj2fPVtYj/ATHER2vEdpsBglx8tvxuNDh/8UXQkKrTKPZ0s3q7iEi0ZSdLsVBm1L6A
 TNXe4bIAAAA
X-Change-ID: 20241118-simplify-result-qt2025-1bb99d8e53ec
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Miguel Ojeda <ojeda@kernel.org>, Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731940236; l=1498;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=aNU3+RJ8lBcv7tT/MtgstLYhDl/ERX/hXonU5AJGIRw=;
 b=aKxqt8ceYzbm2O7JpvqJGoSp1qYHMsTzRsrMTB8+OS1LGL00Tyy6twRxjXiO4RBEuY8TARKEm
 YjN5JzMkyPvDkEbaNYjUkvGjmzeQLN61vIPio3EC07kOSA6oeNMAxDO
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

probe returns a `Result<()>` type, which can be simplified as `Result`,
due to default type parameters being unit `()` and `Error` types. This
maintains a consistent usage of `Result` throughout codebase.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1128
Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
Changes in v2:
- Add Link: and Suggested-by: tags
- Link to v1: https://lore.kernel.org/r/20241118-simplify-result-qt2025-v1-1-f2d9cef17fca@iiitd.ac.in
---
 drivers/net/phy/qt2025.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 1ab065798175b4f54c5f2fd6c871ba2942c48bf1..25c12a02baa255d3d5952e729a890b3ccfe78606 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -39,7 +39,7 @@ impl Driver for PhyQT2025 {
     const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043a400);
 
-    fn probe(dev: &mut phy::Device) -> Result<()> {
+    fn probe(dev: &mut phy::Device) -> Result {
         // Check the hardware revision code.
         // Only 0x3b works with this driver and firmware.
         let hw_rev = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241118-simplify-result-qt2025-1bb99d8e53ec

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>



