Return-Path: <netdev+bounces-176734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50F0A6BC16
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 14:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87144639DA
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 13:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DCB84D13;
	Fri, 21 Mar 2025 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="itv+0EZG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aUcHCUM8"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CEA7DA6D
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565178; cv=none; b=Uyc/4jgX4emw4T0iMH04ACF+Pv3WO4r0xFT+fKCmHEhnM7jqoK2IpoX9KRmC8XT/Z6+E7dRe3h2oe71pfMlBt8qDu36fXLm45V2NHqLkTF4YNHZFz1BQi7zlM96AJuflXDeyCy/Rz2kbupQShTNJbepPmBOmtXTTNXHOF5ArqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565178; c=relaxed/simple;
	bh=P40GZ4G9yd+e7sKqm/mmO82KzXdZXEhcibJG2malgvI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L6KqkGNAMpjpPKKAFp2oXxNc/Vc0FjelVL4u9vkv42rBSvYfwVDwo6Oj+w2Uc3WM8VZQXduZmMG57T4pbLI824JsbTtaFehQf7zrlzp1DO5Da7H8LyWUCvA1lGtcWLxwquh4AJxBUdvxdLdFH5EzcUTSnC1bRstYhKRVA9LOBMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=itv+0EZG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aUcHCUM8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742565175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=06E78oMyiImg2+G4t0PLhWz3e/+c+P7mEcu1s70sBpo=;
	b=itv+0EZGRnz1W0zIxtlV/ZUcjnvdw68DGfGmoKZn3+hdFGcJA46L8bKLx4yEKeo9AeN4kd
	B02J6LZbJp6/cm5jCoYXTGPMrm+tIbOZLTppguRx/S1MX0Jhl9OOqS6P//r1KfrNDW9UEr
	a+MUb+wvejV5w/+ESuGEXrkfHADD09bHZny5dNHjbqom38FiPXhnS360RqT4akuqee1xNV
	xdn27RCSwF/FzUl8bdxtygUvD1EFdaeqHw3tERgRzqe5ywEDAgx1sd/VfBlFlDJ0s1uzHf
	Kbm8+0rTEv1GsYJ3jSP3uZx/XVs08fSFmn6i/q2+2bnC5rG5HtpmFVVvdNhiuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742565175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=06E78oMyiImg2+G4t0PLhWz3e/+c+P7mEcu1s70sBpo=;
	b=aUcHCUM8pVE0LdCel1RWSIMdO9bdGH8ImslX1KjimlK5UVlCQbSUo2b/FDpHQvU5r3qxua
	w3Mg0Zf+0Wnc+pCA==
Subject: [PATCH iwl-next v4 0/2] igc: Change Tx mode for MQPRIO offloading
Date: Fri, 21 Mar 2025 14:52:37 +0100
Message-Id: <20250321-igc_mqprio_tx_mode-v4-0-4571abb6714e@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACVv3WcC/23O0QqCMBQG4FeJXbfYznRpV71HhMh2zAO61bRlh
 O/ekKAIL39+zvefFxswEA7ssHmxgJEG8i6FbLthpq3dBTnZlBkIyAXIjNPFVP3tGshX41T13iI
 HMLI0uc60yFk6vAZsaFrQE6NHxx1OIzunpqVh9OG5rEW59B94vwZHySVXdSagQdko0MeO3H0M3
 tG0s7iQEX4YWP0vQmJKrbWtpTKFLdYY9WWUUKuMSozAxmCRo65R/DPzPL8BFY4gKlABAAA=
X-Change-ID: 20250214-igc_mqprio_tx_mode-22c19c564605
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=P40GZ4G9yd+e7sKqm/mmO82KzXdZXEhcibJG2malgvI=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBn3W81d5RUdGbiE0AsAZU8KxCxJigOogkzlUBUW
 D8kwmnHSB6JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ91vNQAKCRDBk9HyqkZz
 gtvuD/47rteR9VuaA2qyK4rxERdt9k1HHYsw+yEJwQlDhoNJeLLbQac5qpLyzuBquOQ26H4l40K
 pvXpAfvYyyK/arBKgnMPkHglMozvHLg38JTlynUqPOMlViszSFz+FXbhUZMl+GlH1G/CbOH5Iqo
 FnpAtzm6mdqLo5d/1uX9n3z2xnAlrN9Gz3gBw5mZ66yEUwZk1Z4w7QiAccxUhxEQHH+JRULXry5
 tnR4/SGpn+l66jO5A7OYaBdzcab6063RxoISfWQR0JNeGtYOuTb4O8ipUC2jNAgCH11heE241g1
 9QYJV0W46Komn9GjVB7mpH9Jes3+W9BgyDdtSbIT7n3WKGIJootl9+LJYLlC0wP1C5Kt/liiFZS
 F3ljNPVZ8JEesocma7BTJwrXgNQfObyXZqoPF/8gyCHQOTCbtCSw49gxW0DI9LrpXqYaUm6yLEC
 V2utUlefrhWEgnr8SbM31pM9JfQiFHOniAmPndPQkYDNMQOy+sIzpVqpfU6BfHlSe4IH2UqVEjh
 PcEWbIriP/q2QNLhDR+pQvwzUU3LVz10RpCqNteiqqaoYaJMxyqN8GEsH0zjStfaFWu2Hn50bZD
 29bX2r+HMLqVbW8tnThLA80jT7cKS0PdTbgJjl2a6gwSc/4BolT2ll+QN39wBCDOn8L7fqzuD8J
 +IgNf5yQm1t8uVA==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Hi,

this small series switches the Tx mode for MQPRIO offload to harmonize the 
current implementation with TAPRIO and to allow to integrate FPE easier.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v4:
- Split patches (Simon)
- Add tags
- Link to v3: https://lore.kernel.org/r/20250303-igc_mqprio_tx_mode-v3-1-0efce85e6ae0@linutronix.de

Changes in v3:
- Commit message (Paul)
- Link to v2: https://lore.kernel.org/r/20250224-igc_mqprio_tx_mode-v2-1-9666da13c8d8@linutronix.de

Changes in v2:
- Add comma to commit message (Faizal)
- Simplify if condition (Faizal)
- Link to v1: https://lore.kernel.org/r/20250217-igc_mqprio_tx_mode-v1-1-3a402fe1f326@linutronix.de

---
Kurt Kanzenbach (2):
      igc: Limit netdev_tc calls to MQPRIO
      igc: Change Tx mode for MQPRIO offloading

 drivers/net/ethernet/intel/igc/igc.h      |  4 +---
 drivers/net/ethernet/intel/igc/igc_main.c | 18 +++++++++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 40 ++-----------------------------
 3 files changed, 20 insertions(+), 42 deletions(-)
---
base-commit: 6f13bec53a48c7120dc6dc358cacea13251a471f
change-id: 20250214-igc_mqprio_tx_mode-22c19c564605

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


