Return-Path: <netdev+bounces-167716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A6A3BE58
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C67F3AD918
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 12:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4173E1E0DDF;
	Wed, 19 Feb 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="pQT6NnvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC981DF26A
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968950; cv=none; b=Xs8yJCx4N4qfckP3zT3P59FQk9ouTMvj73CeBSSk2XDZIa1/O8JSUjgOqx7ADi4ZNP100TzkrQ/UOo1YDVmiJohlwIJb/k4Fdjm6OedEPIlKHSnVJea5NCR6xmrfyS0aSTbC5MDjhxlgpl9wZPNooocDFMpZZ3i77tVER529o+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968950; c=relaxed/simple;
	bh=aEZmkm1hV21rp3YTZCGbmxtF7lznLzqBxNFTStfv000=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=se1qr1XGhurqXWG445SkMgwRgF91y8FM+YkuaruPQvXRg20Nkr019u4nmOLc1wFjqK3hvURJbkE9FjjdfgpbWqT7SjXxZhuO1/inXSWD1BccI5sPpnVMna1o34Epb6EwOZ030SqMc+to68+F7YpNxvMOHHyOClAR6cO9G5g0tJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=pQT6NnvZ; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id EA101240027
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 13:42:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739968944; bh=aEZmkm1hV21rp3YTZCGbmxtF7lznLzqBxNFTStfv000=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=pQT6NnvZ6QfK1XDthLHJDMPKVx3k8igsFAYEsAIgkHpyT6BY+1nN8tUrupat7jimK
	 zHTpYhnn30MdGiye563aBLsivzaviAiLcJiepd/274OuadD8TJH2aFNeApGBfM26D+
	 99NCeR7KerlqLOFN5G+LQsU4Dn7I+l69LvZChk2t+MvIFqQMsoeMDsdDXsBNcbiFC+
	 z4B1oSHb7Sju9cJywgAQ26xp88Lr1/e7AlL6fBZaXcRyY9VcaESTH7/Pyi6nV+ZJuC
	 FhJENGJ1yBSaJ6oBTR2jMjdfZ/kZ6Z4y2EtMLwY05GD3SqB1INXpu33+h8DZw2fo7+
	 HNKQeHdOJTpOA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YybdB0TTPz6twQ;
	Wed, 19 Feb 2025 13:42:21 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Wed, 19 Feb 2025 12:41:55 +0000
Subject: [PATCH net v2] net: phy: qt2025: Fix hardware revision check
 comment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-qt2025-comment-fix-v2-1-029f67696516@posteo.net>
X-B4-Tracking: v=1; b=H4sIAJLRtWcC/32NTQ7CIBCFr9LM2jFAUYgr72FcVBwsi0ILhGga7
 i5yAHfvJ+97OySKjhJchh0iFZdc8M2IwwBmnvyL0D2bB8HEiQmuccs/iSYsC/mM1r1x5JOy2pq
 HOUtowzVSizv0Bp4y3Fs4u5RD/PSjwnv1j1k4clRyJK0MY5KZ6xpSpnDsvFrrF0cv2YG6AAAA
X-Change-ID: 20250218-qt2025-comment-fix-31a7f8fcbc64
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739968933; l=1517;
 i=charmitro@posteo.net; s=20250218; h=from:subject:message-id;
 bh=aEZmkm1hV21rp3YTZCGbmxtF7lznLzqBxNFTStfv000=;
 b=rjm5rN4NKlBBwxqtODOZ62E5SaiIwJVOr7MYv+DUdwOfAoKfVDgfiHI+azP52m/u1tkggWizk
 96yrORzotrkCAN9hSMpfRgWQviEksl+UYf1bvmTy5AvGN3kmPMY4z/8
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=tqvFF75nwS3URscujaAaCD+j9ViKh5jLMkj1mnX7Rws=

Correct the hardware revision check comment in the QT2025 driver. The
revision value was documented as 0x3b instead of the correct 0xb3,
which matches the actual comparison logic in the code.

Fixes: fd3eaad826da ("net: phy: add Applied Micro QT2025 PHY driver")
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
Changes in v2:
- Resend with proper patch subject, according to netdev documentation
- Add "Fixes: " tag
- Link to v1: https://lore.kernel.org/r/20250218-qt2025-comment-fix-v1-1-743e87c0040c@posteo.net
---
 drivers/net/phy/qt2025.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 1ab065798175b4f54c5f2fd6c871ba2942c48bf1..7e754d5d71544c6d6b6a6d90416a5a130ba76108 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -41,7 +41,7 @@ impl Driver for PhyQT2025 {
 
     fn probe(dev: &mut phy::Device) -> Result<()> {
         // Check the hardware revision code.
-        // Only 0x3b works with this driver and firmware.
+        // Only 0xb3 works with this driver and firmware.
         let hw_rev = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
         if (hw_rev >> 8) != 0xb3 {
             return Err(code::ENODEV);

---
base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
change-id: 20250218-qt2025-comment-fix-31a7f8fcbc64

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>


