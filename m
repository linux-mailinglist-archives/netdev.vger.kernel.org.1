Return-Path: <netdev+bounces-244099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB243CAFB00
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 11:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4238300A6E9
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4D2D321B;
	Tue,  9 Dec 2025 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="OzXUGLhu"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay90-hz2.antispameurope.com (mx-relay90-hz2.antispameurope.com [94.100.136.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B62D0C7F
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765277635; cv=pass; b=jKu6V2biashkSWYY6zihhsEC9hbXnVVie1+LOaqktVx9PovByiwhpwq+qmRzyVUibEsNGp6VRjjOqrhJ2G02cjcWMfsXo6P+mkXxlqYAUV3T/clJPlCgMQvMV7nSb/Gn6k2HjjI/UVhYi7GsrGDz6SHMiQNBZjRGLLAxQSC1tgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765277635; c=relaxed/simple;
	bh=zAreKBXYzW+jAqB87lL5Vm6L5UsJmH4bDsBImwL5xHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQlt2b/OE1OjIR7hC72V5RF9zXKbEu3YWGaIPsAHY2RZOhz+6dZrFYWs/u+fRQW3yJMDJYRNutl9wypuPuCHflrJmiaZsDseqb7SYBlx8tHaAH/myaTLN1xQPfjKkxsBa0/v7kmEdLstA7poi1pg39YcOvXQf7vDYpsk7ivn/YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=OzXUGLhu; arc=pass smtp.client-ip=94.100.136.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate90-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=6npgSCSljI1jrpntYRig2rdWG53oGjgIHhHgeY2CZ1Y=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1765277620;
 b=K+tfU79m4aAwcDlMZ/pQRPsq3dYhVTiitfevAUZSaOu1Nf1pZ559i6sECp7V9Q4T6n063UJc
 9gLcYtPb+yZd4/U+D5wULdNLv0N2tLkMihnY9C7jFSQxSGW6Dkpq0I8HDOjfp7TF2+RNSNYJHoH
 F2rU8muBSCbhM22bXvf5qN8nXiXp+dDyE7kBUm2CkFxqZ45+gVRpYb0v4suK9ETyaxeMBYMGA6n
 Bjz0TKGxWoQah3VFf/7N9E/WVtYA4QHUhMXolLOMLGd4Hlaped0dTHUKPssuLJuAIXol9DSDcla
 v8RuXWbEEo+mDzwTjT52Nn5yB4mIf+BmGDN6IsBJ5KEHw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1765277620;
 b=Jn7/oFRaBPQh29ZWEkiOQivAWZbZlWsFhlWelvOC/7bISxaOHUitDHu0hLjLE/lcEUV9m59H
 LqTjVHE5fEHtYcnGNc2CJ4dOdYMeKJI3TyIYJuXj1FaLN2jpnuxDNR40npZiNo6T2Hebi45nOqj
 3Lepxis/XvZW3+Z7//kOwTbiCjZUXP1wAbPundG462dldK7tHO/vbuLPzz3qHRWY2Sq5dfW7E1Q
 10aOtu+loq98dxHewMHWJFz3oGR5JPhCzBcWxUXaXC4KTYQ+XhGTbDtYLu8Swamoz882MgNysz+
 hGeXPSVKZ0Ge6JE6Fveq2gz80+41ucZ+Ce7Hk8w9Sr/9g==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay90-hz2.antispameurope.com;
 Tue, 09 Dec 2025 11:53:40 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id A89F5CC0E8A;
	Tue,  9 Dec 2025 11:53:20 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Martin Schmiedel <Martin.Schmiedel@tq-group.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/8] TQMa8MPxL DT fixes
Date: Tue,  9 Dec 2025 11:53:06 +0100
Message-ID: <20251209105318.977102-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay90-hz2.antispameurope.com with 4dQbL93XFFzWw50
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:f63f4ee375f07f63483e39071c52d6f9
X-cloud-security:scantime:1.678
DKIM-Signature: a=rsa-sha256;
 bh=6npgSCSljI1jrpntYRig2rdWG53oGjgIHhHgeY2CZ1Y=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1765277619; v=1;
 b=OzXUGLhu0SEkx1PXEAJrvPzQex/NfVLb7miuJk57Lr3TXg7L6ccAmxPJK66vLMQiy9D8sryx
 LBQK7b4dHXaxTOM9gjiWLwFBMuuA9a8x6/4vIuPPZP8dqOaEyYFxhl4oD3vGzxaF/7hA0OCZ8rB
 elywPhUmcZ6jQP8EKMNWE4dy2S7ucWNvbjcn1E9qKIdZ9LRVVSCpswKcD3C1ZS3bN8lGo6ER3XL
 9xhkZMt2fzWQCes21TireMLkM1ckiF2PDTb4EednM760FauN3xmRel9w0UMCfzkaa+OYaJ7SezV
 RYw35xG76QOqbuKwP4u4Nq4Xj4VhQ4xpAtTJALTU0VRMw==

Hi,

this seris includes small fixes for TQMa8MPxL both on MBa8MPxL and
MBa8MP-RAS314. The ethernet IRQ type has been changed to level-low and CEC
pad configuration has been fixed to use open-drain output.
For both boards the HDMI audio output support has been added as well as
the ENET event2 signal on MBa8MPxL, which can be enabled using
/sys/class/ptp/ptp1/period.

Best regards,
Alexander

Changes in v2:
* Collected R-b
* Fixed typos

Alexander Stein (8):
  arm64: dts: tqma8mpql-mba8mpxl: Adjust copyright text format
  arm64: dts: tqma8mpql-mba8mpxl: Fix Ethernet PHY IRQ support
  arm64: dts: tqma8mpql-mba8mpxl: Fix HDMI CEC pad control settings
  arm64: dts: tqma8mpql-mba8mpxl: Add HDMI audio output support
  arm64: dts: tqma8mpql-mba8mpxl: Configure IEEE 1588 event out signal
  arm64: dts: tqma8mpql-mba8mp-ras314: Fix Ethernet PHY IRQ support
  arm64: dts: tqma8mpql-mba8mp-ras314: Fix HDMI CEC pad control settings
  arm64: dts: tqma8mpql-mba8mp-ras314: Add HDMI audio output support

 .../imx8mp-tqma8mpql-mba8mp-ras314.dts        | 21 ++++++++++++--
 .../freescale/imx8mp-tqma8mpql-mba8mpxl.dts   | 29 +++++++++++++++----
 2 files changed, 41 insertions(+), 9 deletions(-)

-- 
2.43.0


