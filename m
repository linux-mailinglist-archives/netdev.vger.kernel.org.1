Return-Path: <netdev+bounces-125095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A323596BDE3
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158171F21623
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC131DFE35;
	Wed,  4 Sep 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oId6Xyqh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2tGGhiio"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1501DEFC8;
	Wed,  4 Sep 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455143; cv=none; b=iW7+y2pBTeRe30Nf6cmaB276uuWj2lOOTdEvxm4cE/cZbZsqESDR5PDevcdeyZYm4DRnXaLaEtuRp/zhfFYs0PXFGz31JnN8YKy47X/C2nSYoZlgLaOoiQJojVTn1llksRn328VHI82gIMaF7XIwhx3wG7x9fpbk76iIROJmKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455143; c=relaxed/simple;
	bh=53Qu+mZNVA9LMP8wt82pryIqg4R9IHgNbSfzDTdUPnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFMaIG1l69F0cHnxxpCrJTbWHdJNHs7kb0qUmFO/DP9EyNZKRPJDOhG4T2WNfxMkq5CHIoH5hGsZJ40zP+awqeYkPn28EbpsNe2r5+79TrlwNMiun0DznrQWSxzNw3dfehT6y9eAlqfOhMACNtGAlujOPgsW4FFOGUb+Lv+rxig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oId6Xyqh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2tGGhiio; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NqwpnyrFg1QVhhfFvZbjd8GTWo9T8rGMAEt4kbVzwz0=;
	b=oId6Xyqhb8BluxKsbA0UFv/950t0HHUh/umBvqRT+nOdHNOAur5soDP/4o7RWyxytl5NDR
	05UqOskqpDWKhM90PHGdBcqs+0TYi6L8ORwn72i3k2GhBZ5eszJhcUngx9Cype6aUKbM6c
	Um7YDXtXIQaEZstBsiTAVYL6ArKTrN9kq0WuR4EQUT0abkPBlcYidD+reP2TDk5ALMPSXq
	ljYJPERFx9cB/fAex4V7q+AtP0NHVmQWzc1X1U5G57zeBxs1z6EhcCdedMhaU41It5dtZ5
	fFp8mVsAltx8iF75PjHyEHnBpYdeHKsegfFXUP7IbX7aET/d9pU8qBsmKzvcug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NqwpnyrFg1QVhhfFvZbjd8GTWo9T8rGMAEt4kbVzwz0=;
	b=2tGGhiioz16mddKFwGZakFHH3N7/jCHrLmVZNKi8ysTMdO2Gx2JZyV0QsZ33lb201KlSlc
	jZDOpCyx8ANn2hAg==
Date: Wed, 04 Sep 2024 15:05:02 +0200
Subject: [PATCH 12/15] iopoll/regmap/phy/snd: Fix comment referencing
 outdated timer documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-12-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, netdev@vger.kernel.org, 
 linux-sound@vger.kernel.org

Function descriptions in iopoll.h, regmap.h, phy.h and sound/soc/sof/ops.h
copied all the same outdated documentation about sleep/delay function
limitations. In those comments, the generic (and still outdated) timer
documentation file is referenced.

As proper function descriptions for used delay and sleep functions are in
place, simply update the descriptions to reference to them.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: netdev@vger.kernel.org
Cc: linux-sound@vger.kernel.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/linux/iopoll.h | 24 ++++++++++++------------
 include/linux/phy.h    |  7 ++++---
 include/linux/regmap.h | 18 +++++++++---------
 sound/soc/sof/ops.h    |  6 +++---
 4 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 19a7b00baff4..34b52ab2e394 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -19,9 +19,9 @@
  * @op: accessor function (takes @args as its arguments)
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  * @sleep_before_read: if it is true, sleep @sleep_us before read.
  * @args: arguments for @op poll
@@ -64,9 +64,9 @@
  * @op: accessor function (takes @args as its arguments)
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
- *            be less than ~10us since udelay is used (see
- *            Documentation/timers/timers-howto.rst).
+ * @delay_us: Time to udelay between reads in us (0 tight-loops). Please
+ *            read udelay() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  * @delay_before_read: if it is true, delay @delay_us before read.
  * @args: arguments for @op poll
@@ -119,9 +119,9 @@
  * @addr: Address to poll
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
  * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
@@ -140,9 +140,9 @@
  * @addr: Address to poll
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
- *            be less than ~10us since udelay is used (see
- *            Documentation/timers/timers-howto.rst).
+ * @delay_us: Time to udelay between reads in us (0 tight-loops). Please
+ *            read udelay() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
  * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 6b7d40d49129..b09490e08365 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1374,11 +1374,12 @@ int phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum);
  * @regnum: The register on the MMD to read
  * @val: Variable to read the register into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  * @sleep_before_read: if it is true, sleep @sleep_us before read.
+ *
  * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
  * case, the last read value at @args is stored in @val. Must not
  * be called from atomic context if sleep_us or timeout_us are used.
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 122e38161acb..85de129a9e02 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -106,9 +106,9 @@ struct reg_sequence {
  * @addr: Address to poll
  * @val: Unsigned integer variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
  * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
@@ -133,9 +133,9 @@ struct reg_sequence {
  * @addr: Address to poll
  * @val: Unsigned integer variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @delay_us: Time to udelay between reads in us (0 tight-loops).
- *            Should be less than ~10us since udelay is used
- *            (see Documentation/timers/timers-howto.rst).
+ * @delay_us: Time to udelay between reads in us (0 tight-loops). Please
+ *            read udelay() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
  * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
@@ -177,9 +177,9 @@ struct reg_sequence {
  * @field: Regmap field to read from
  * @val: Unsigned integer variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
  * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_field_read
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 2584621c3b2d..b1b8253aefad 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -597,9 +597,9 @@ snd_sof_is_chain_dma_supported(struct snd_sof_dev *sdev, u32 dai_type)
  * @addr: Address to poll
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
  * Returns 0 on success and -ETIMEDOUT upon a timeout. In either

-- 
2.39.2


