Return-Path: <netdev+bounces-171344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68724A4C9C9
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894133A8D94
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187092288EE;
	Mon,  3 Mar 2025 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="MCZKYT0C"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653E19CCFA;
	Mon,  3 Mar 2025 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021560; cv=none; b=AeSfjWedwEQO3jFk5y0UFGGE6rqQPi2G8lv1TfmBN8ca8ELJyY99+5Xxc5PZzWrKawpgleDxFnjdNPHUhWWjhuy8lw07tn0k9/VO96KVfC8yzGo12Gj9wUw3kgYFENYYCP1VhAY6XQt2Bppv2VOuUUYMr16dL7eieKuk607AvLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021560; c=relaxed/simple;
	bh=GAFzs6c/tdem2VteSlju2f1Qb6J7aiZhObEdtoup3aA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TPiC2ygUmu4qkNv/eNTe3pUkPv6Z8nNZBgQWZkc4jDbL9xH/4wYAxHEZR8ttxAkqNZH1xl28luvxEIZ79zX6+sOMRJURPWJlWGiO6i1OGb5Jt9Mu9hpW5JPKl5xIun2EyVdgow+QxfWAaK+1AqJho2dSFWNaH+rAjzfd0IAuZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=MCZKYT0C; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49F8243281;
	Mon,  3 Mar 2025 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1741021555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rtIIDfTlYimU1VxLvX4hdukX8dfCk6d8uugjBvXTyoc=;
	b=MCZKYT0C9sRC69yd0bYu4yM/blr2FZWSgEj+10OA6Hnti1zcK1zmhfonbWyD4F4agEXIwf
	ugC0IUNR7ue6aYfDEKoyYih6PTRaUPm5/xsOY3vzFzYUSGfTONXwUHqVVOQVCbHTrZfwf+
	87KDQm87G4l0mxvwsRxuRTML+RjIsRu7FhAnRJozvoFpTMr+dGh9FfWtKB7RCRFbNYZ0TB
	poogWpD4XupcQie/OdIrMenAccyeOWqhqfkKGJrJvkUz1BSiwyAIqSP+DygKhDGclo93js
	pJQ8iPIuEBBV2Brk2K6I3MnONVgpheol9jJb2oPD6Fw8JR0jy1cFKM0uRFHm1g==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH 0/2] net: phy: dp83826: Enable strap reading and fix TX
 data voltage support
Date: Mon, 03 Mar 2025 18:05:50 +0100
Message-Id: <20250303-dp83826-fixes-v1-0-6901a04f262d@yoseli.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG7hxWcC/x3LQQqAIBBA0avIrBNMM6yrRAvNsWZjohCBePek5
 ePzKxTMhAVWViHjQ4Xu2DEODI7LxhM5+W6QQmqhhOI+GWXkzAO9WLg1enKLE9a6AP1JGf/Ql21
 v7QMUPbeFXwAAAA==
X-Change-ID: 20250303-dp83826-fixes-a854b9b0aabf
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741021554; l=974;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=GAFzs6c/tdem2VteSlju2f1Qb6J7aiZhObEdtoup3aA=;
 b=RiJEp3N3GBpXD1PZbBtTwZY8Epj2Pq2P5DfC3/0ytrFromNjHCcMeMXUKYPdmIbhTq0jK8o4i
 /z0tpisQ9fSBY0S2uemZ0nhkGldIRoRtQn4DGGEtH+zBdmvbP9j6XW/
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflvggrnhdqofhitghhvghlucfjrghuthgsohhishcuoehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrgheqnecuggftrfgrthhtvghrnhepudetheegiefhleelleekteekteevhfdvudeguddvvddugeehleekledtffdtheejnecukfhppedvrgdtudemvgdtrgemudeileemjedugedtmegttgelmedvieelvdemrgehfhejmeejlegvtgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudeileemjedugedtmegttgelmedvieelvdemrgehfhejmeejlegvtgdphhgvlhhopeihohhsvghlihdqhihotghtohdrhihoshgvlhhirdhorhhgpdhmrghilhhfrhhomhepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgv
 ghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheptggrthgrlhhinhdrphhophgvshgtuheslhgvihgtrgdqghgvohhshihsthgvmhhsrdgtohhm
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi all,

Please find a small series to ensure correct operation across different
setups.

- Patch 1/2 fixes the TX data voltage initialization issue when
  CONFIG_OF_MDIO is disabled by setting default values for cfg_dac_minus
  and cfg_dac_plus to prevent PHY init failures.

- Patch 2/2 adds strap reading support during probe to configure RMII
  mode, MDIX, and auto-negotiation in line with hardware defaults.

Thanks for your feedbacks !

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
Jean-Michel Hautbois (2):
      net: phy: dp83826: Fix TX data voltage support
      net: phy: dp83826: Add support for straps reading

 drivers/net/phy/dp83822.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250303-dp83826-fixes-a854b9b0aabf

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>


