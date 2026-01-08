Return-Path: <netdev+bounces-248075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48785D02FB9
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28B7D30196B7
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47053563F3;
	Thu,  8 Jan 2026 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK3/NvR6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0002773EE;
	Thu,  8 Jan 2026 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877705; cv=none; b=WhXV/p1EaKQip77WIWk2YsqO5LshZp9U2QAxv04d0SvrMi9LbTe/GBTng1tlCZ5s5bcTeEr7msXmZOiDcyfoIxGBOGjR62kS/dqYuZuQq5t1L6IpENfz3WNa1i7i0xdxfdQbc/du01CkWA8GIOcmkmY2iPiB1KG+8+yKOWwY7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877705; c=relaxed/simple;
	bh=d2oLmhos7FqCo4pDfLBY/b8vig+4Qxoc9GDWKS1KhqE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E7PcgYBOUUb4vgtJjGwF0UOFDdpMCIbBS54TO3mIUsMzWTX5acEt/mOP4pBDWQxUgNQFzvfbAwx0PJShUJhoLsXipYofIvaDkklwcgHSVU3gHPwUe2Ixic1IRhFnMFy+omal8OoMHB2scibBF6QFvZjmXhhBms2/KncKbzj50OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK3/NvR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8166CC16AAE;
	Thu,  8 Jan 2026 13:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767877705;
	bh=d2oLmhos7FqCo4pDfLBY/b8vig+4Qxoc9GDWKS1KhqE=;
	h=From:Subject:Date:To:Cc:From;
	b=CK3/NvR6zP+u9HAE6mvU73Xn1ldX+Q60SocIgj3CI3jU1oeoNie+AX9b08X3dBMYI
	 wTfl6a3M3WSDte55xE+u9h/x5wnKppn06TQT7g4dwUe74L83Q6W68Tz0l0dMRenPnI
	 NHkXHCiJ/ldaY+7+R5FgmBUT3yuroKKvFgTxXWTshFMoL/Eg3IAjZJM57CqEa+N5QM
	 pM8j4j5zanHFRAFgC3G8jqTcmubR8L4VwIhnhTnAD1gKz5EhGZA9U2HLope9oPnmR0
	 66IMaiO0WvzPnFX9urRJSHM3SLtTWJqmV+XJSZE795ruvZkaGc8HB054zjuzGrM/4e
	 rTCH2Oy+NzsRA==
From: Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v3 0/3] net: stmmac: socfpga: support both stmmaceth-ocp
 and ahb reset names
Date: Thu, 08 Jan 2026 07:08:08 -0600
Message-Id: <20260108-remove_ocp-v3-0-ea0190244b4c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADisX2kC/23MywrCMBCF4VeRWRuZTJPauPI9RKSXaRvUpiQSl
 NJ3Ny24KLg8B75/gsDecoDTbgLP0QbrhjSy/Q7qvhw6FrZJGwhJSyIjPD9d5JurR6HUscizwlS
 oCRIYPbf2vcYu17R7G17Of9Z2lMv7NxOlQKGNIqMYVdWo8539wI+D8x0snUg/m6NEvbGUrGpLq
 poSjSa5sfM8fwHxL/kh4QAAAA==
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: bsp-development.geo@leica-geosystems.com, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=dinguyen@kernel.org;
 h=from:subject:message-id; bh=d2oLmhos7FqCo4pDfLBY/b8vig+4Qxoc9GDWKS1KhqE=;
 b=owEBbQKS/ZANAwAKARmUBAuBoyj0AcsmYgBpX6xE2Yv8WhiMeSHCVFto9B7KJXVsVuB7XuVX0
 MCoEwOLzlyJAjMEAAEKAB0WIQSgeEx6LKTlWbBUzA0ZlAQLgaMo9AUCaV+sRAAKCRAZlAQLgaMo
 9FSoEACYWlkgvXysoU+OTl8MRzOUImHYPeTWo3Y9ZGS/I1eEvVP2cRpYR9EtiiWpyV4xsIEN/+J
 5fWBwc+1wgQC8nh8ENVWWQaNSAPFB41LhwQ7JyjBGFIjz6phv8mHLW0YT1qsSVRbxUv9WRbO8S4
 XpaVnsbx1oRrSVk9sXmDrKwt0VIPXcLJL0lejv7iQPD2bBCTtYA6OyZqgkdK0ZJoLbW8O1Qb6mT
 vjEmFlnQUgH5HZdiAvQvRd9gB8g8K+uzYaUS/V3b3V+UvQbk786BcY9hM1QpKD8geljGXPCQb3A
 9g6F4HBnys43WjondrIriZSNPPIWQqpn3IUJ4+7742Ky0siZUho0hlg+FEhYi3uDbOj7uWokmS9
 fkNxhQhLgSAUTFn3rprlC+DpVl18yQT0b2WZZ8yUflhB0REPo3ggTX4adeVskkBmXnPqcoN+bT2
 Nran/niGE3745TINqzRCYJ6jqrcaVebshZ8+Ph7ia/piiyNkpxcAiGTtbSvb2QF+1DDNioKwCiG
 M7EG0I3A1cWbjwHkXPrOz8yuCbkI0dpKWdpJIk3vyCH/grUiL3vRlBQnKN/Utw+LDuQAqau/NIk
 FS8vZcWqKE/+JEWfgyMx5aHDtXrtsH65U8v2uSM9uMBAdkrMbHiBZVGj/J17w/Hyb+Zgy3qShIJ
 Ftemo8mazwGC7Dg==
X-Developer-Key: i=dinguyen@kernel.org; a=openpgp;
 fpr=A0784C7A2CA4E559B054CC0D1994040B81A328F4

The dwmac-socfpga stmmac ethernet controller supports 2 standard reset
lines, named "stmmaceth" and "stmmaceth-ocp". At the time of upstreaming
support for the platform, the "stmmaceth-ocp" name was used for the 2nd
reset name. We later realized that the "stmmaceth-ocp" reset name is
the same as the "ahb" name that is used by the standard stmmac driver.
But since the "stmmaceth-ocp" name support has already been introduced
to the wild, it cannot just be removed from the driver, thus we can
modify the driver to support both "stmmaceth-ocp" and "ahb", with the
idea that "ahb" will be used going forward.

This series add the support to call reset assert/de-assert both "abh"
and "stmmaceth-ocp" to the dwmac-socfpga platform driver, then reverts
the patch that uses the DTS "stmmaceth-ocp" reset name.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
Changes in v3:
- Edit dt-bindings patch to just remove TODO note
- Link to v2: https://lore.kernel.org/r/20260105-remove_ocp-v2-0-4fa2bda09521@kernel.org

Changes in v2:
- Added a dt-binding patch to mark 'stmmaceth-ocp' as deprecated
- Link to v1: https://lore.kernel.org/r/20251229-remove_ocp-v1-0-594294e04bd4@kernel.org

---
Dinh Nguyen (3):
      net: stmmac: socfpga: add call to assert/deassert ahb reset line
      Revert "arm: dts: socfpga: use reset-name "stmmaceth-ocp" instead of "ahb""
      dt-bindings: net: altr,socfpga-stmmac: remove TODO note

 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml | 2 --
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi           | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c            | 4 ++++
 3 files changed, 7 insertions(+), 5 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251229-remove_ocp-44786389b052

Best regards,
-- 
Dinh Nguyen <dinguyen@kernel.org>


