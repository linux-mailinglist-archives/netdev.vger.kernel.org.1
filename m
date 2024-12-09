Return-Path: <netdev+bounces-150069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1BD9E8CE9
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9096164C7D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E18821519D;
	Mon,  9 Dec 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDMcqsCW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68A215187;
	Mon,  9 Dec 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731309; cv=none; b=EYoWCf5vy9driEZLD7oPiIA9kVFi15s5qHPZ3+Q6c6x7Zio1o7U+8962HIhsFRBlcW4Th0I1LhDvTANEmARveuPLBjVV1fpe/1GPGt3aLAsQc+QyugpEKWnQ/EfFLpGI6ltyMTI8y9RDdTbBO8bycG3FpQlibBAQ2r1jm9Kecq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731309; c=relaxed/simple;
	bh=akpuU8iAvhFkyl41n5dk243jfH9laOe/uww9ehcdnyg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RHwm+5E1SpXadVMHfqxFYUD5ZdIL8xURP4Po0qfFUYgaeCXkyyq4WpuahEcLRk/LsiQaS3O57MxjDSOzgbo/TQgsNHsurKJs44/4dromyKUW50KP17hkQgC6/gDvX9wwuDyCwcTV8DetcGcAfUvWJ0W7QYMhYR/rbBdhAz6JmK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDMcqsCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBCF5C4CED1;
	Mon,  9 Dec 2024 08:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733731309;
	bh=akpuU8iAvhFkyl41n5dk243jfH9laOe/uww9ehcdnyg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gDMcqsCWYAR7UMbo9XNQY8fXZJVCfrL5XL4TN+pqa/7o9Holg2YftE3ekRy6LT8Ho
	 AKrlb0WL/HNM4rOiJu8Z2ZoztlFLWtpKtEktLPe0amoc1zpI+95trs0tchtOdl8JjV
	 EPgA1LokhUYr5bDXq2wt1016jZn+U65KVFxDBsiwsln+QrfXst5rxyW3iVou7+5TLX
	 zAE4rFZrdzhavNIzlWOo5xCBLqebhTpT7KiUgDjt/ak3tMStGOJkN+U8n08KkUITlz
	 /F58FC0LHHgKCcZh3iW0lq4IXq8+oj68cqrQp5thY/puCZPOZ6hziK4qCOxKhS/6cn
	 lLBhid42il1hg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A86E77173;
	Mon,  9 Dec 2024 08:01:48 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH net-next 0/2] net: phy: dp83822: Add support for GPIO2
 clock output
Date: Mon, 09 Dec 2024 09:01:26 +0100
Message-Id: <20241209-dp83822-gpio2-clk-out-v1-0-fd3c8af59ff5@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANajVmcC/x3MTQrDIBBA4auEWWcgGYv5uUroouiYDC0qakoge
 PdKl9/ivRsyJ+EMa3dD4q9kCb5h7Dswx8vvjGKbgQZ6jDRotHFWMxHuUQKh+bwxnAWNXYzTitV
 kHbQ2JnZy/b8beC7o+SrwrPUHfJMjCnEAAAA=
X-Change-ID: 20241206-dp83822-gpio2-clk-out-cd9cf63e37df
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733731307; l=1027;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=akpuU8iAvhFkyl41n5dk243jfH9laOe/uww9ehcdnyg=;
 b=VvlYey2w+r42PDWrMgENn0m+P3s0RxqudImUMmE2aM9aEtJO7jbyQnNLZHYmhCyqjitClveOM
 LPavXTfljwMAUxxl5oRWzaK7cy0E518yZeMXzmF95BHSDB2VjDpo9nH
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

The DP83822 has several clock configuration options for pins GPIO1, GPIO2
and GPIO3. Clock options include:
  - MAC IF clock
  - XI clock
  - Free-Running clock
  - Recovered clock
This patch adds support for GPIO2, the support for GPIO1 and GPIO3 can be
easily added if needed. Code and device tree bindings are derived from
dp83867 which has a similar feature.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Dimitri Fedrau (2):
      dt-bindings: net: dp83822: Add support for GPIO2 clock output
      net: phy: dp83822: Add support for GPIO2 clock output

 .../devicetree/bindings/net/ti,dp83822.yaml        |  7 ++++
 drivers/net/phy/dp83822.c                          | 44 ++++++++++++++++++++++
 include/dt-bindings/net/ti-dp83822.h               | 21 +++++++++++
 3 files changed, 72 insertions(+)
---
base-commit: 7ea2745766d776866cfbc981b21ed3cfdf50124e
change-id: 20241206-dp83822-gpio2-clk-out-cd9cf63e37df

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



