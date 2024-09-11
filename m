Return-Path: <netdev+bounces-127223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEC2974993
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0971F22083
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D57713CA93;
	Wed, 11 Sep 2024 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1McUAerT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Rx/tsqf"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0E1311AC;
	Wed, 11 Sep 2024 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031639; cv=none; b=gUkzqv46ueOgAJSvYk3dm7seM2Iwz4Tq+wD8xW72FuRHDqa5wBhYF5nUr/JDsGvAf7gltPmu6xfJMrBmfXfNGqN2c+Abtt6HckQPtLPPXsuClbAf5qJ/T9BERn9+zhAhdfjK1+HS3GcJ/9g/T9l/rIsTzU99R8C3ToK2XIPrHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031639; c=relaxed/simple;
	bh=4wZOhasrUFvkS2mb929tmW0a4bdElDKj4tVHbruyRXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLqGbfvGJ9oR5U4WgiKlCZKy7fBIMZyOik51LKgKGvYqrA5DbIWSBd88xmkM15WNyfLUMRAzGKidgwEG2yajnp+lXVn0p8HG+DXpizEIarDt+CY+o/2Lb1mwPS69tdgveixE9xs5UnuBOB+vgOybrrDZjPQJtv10aDudip9N6iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1McUAerT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Rx/tsqf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726031634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfajaFeZI83lFduG7CKpozyUerHLUcwmwL6H0ejEapI=;
	b=1McUAerTDnykbb607X6HZcOdWRi99+O/Ed8+hFUfTlnYpU8gx6U06ZDUW24Fe4jOG/AOJT
	H2S7trd71N9cHxhb8+mRGMEpcjK/r2AUIr+z4VkQRTVklnOGVhNCHjYQ6GWlzVqNMPB2Dx
	u9v9eiBiXSE9ft07ifGOifLPJD5R1YgF4tZJmSCHgeseyhnkl5H3eusDYVAInYyMysVWnN
	Rfhnit4Fuokes4GfxUaeI+to/P/EmCWBBwaQaqYkVUSyeVz27M7EQxGec8ENYO3gKVgrjJ
	Oi7G/+Y1XtHInkIk4N9WjcTmO1RT8H5piXkpymMmUEoAa0UF4zBfgdwIaAWg2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726031634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfajaFeZI83lFduG7CKpozyUerHLUcwmwL6H0ejEapI=;
	b=9Rx/tsqf3aTcs62gDJpBTJs9diWutozT6F6UcymLJ6R3Rm9oIyZsPNKub2Junk9z7Xr46s
	SM6I1+Gqo1Om3XAw==
Date: Wed, 11 Sep 2024 07:13:38 +0200
Subject: [PATCH v2 12/15] iopoll/regmap/phy/snd: Fix comment referencing
 outdated timer documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-flseep-v2-12-b0d3f33ccfe0@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
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
place, simply update the descriptions to reference to them. While at it fix
missing colon after "Returns" in function description and move return value
description to the end of the function description.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: netdev@vger.kernel.org
Cc: linux-sound@vger.kernel.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v2: Add cleanup of usage of 'Returns' in function description
---
 include/linux/iopoll.h | 52 +++++++++++++++++++++++++-------------------------
 include/linux/phy.h    |  9 +++++----
 include/linux/regmap.h | 38 ++++++++++++++++++------------------
 sound/soc/sof/ops.h    |  8 ++++----
 4 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 19a7b00baff4..91324c331a4b 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -19,19 +19,19 @@
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
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @args is stored in @val. Must not
- * be called from atomic context if sleep_us or timeout_us are used.
- *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @args is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
  */
 #define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
 				sleep_before_read, args...) \
@@ -64,22 +64,22 @@
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
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @args is stored in @val.
- *
  * This macro does not rely on timekeeping.  Hence it is safe to call even when
  * timekeeping is suspended, at the expense of an underestimation of wall clock
  * time, which is rather minimal with a non-zero delay_us.
  *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @args is stored in @val.
  */
 #define read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, \
 					delay_before_read, args...) \
@@ -119,17 +119,17 @@
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
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @addr is stored in @val. Must not
- * be called from atomic context if sleep_us or timeout_us are used.
- *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @addr is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
  */
 #define readx_poll_timeout(op, addr, val, cond, sleep_us, timeout_us)	\
 	read_poll_timeout(op, val, cond, sleep_us, timeout_us, false, addr)
@@ -140,16 +140,16 @@
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
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @addr is stored in @val.
- *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @addr is stored in @val.
  */
 #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
 	read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 6b7d40d49129..cadf51441ee1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1374,12 +1374,13 @@ int phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum);
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
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
  * case, the last read value at @args is stored in @val. Must not
  * be called from atomic context if sleep_us or timeout_us are used.
  */
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 122e38161acb..d733b08466fd 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -106,17 +106,17 @@ struct reg_sequence {
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
- * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
+ * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
  * error return value in case of a error read. In the two former cases,
  * the last read value at @addr is stored in @val. Must not be called
  * from atomic context if sleep_us or timeout_us are used.
- *
- * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
  */
 #define regmap_read_poll_timeout(map, addr, val, cond, sleep_us, timeout_us) \
 ({ \
@@ -133,20 +133,20 @@ struct reg_sequence {
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
- * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
- * error return value in case of a error read. In the two former cases,
- * the last read value at @addr is stored in @val.
- *
  * This is modelled after the readx_poll_timeout_atomic macros in linux/iopoll.h.
  *
  * Note: In general regmap cannot be used in atomic context. If you want to use
  * this macro then first setup your regmap for atomic use (flat or no cache
  * and MMIO regmap).
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
+ * error return value in case of a error read. In the two former cases,
+ * the last read value at @addr is stored in @val.
  */
 #define regmap_read_poll_timeout_atomic(map, addr, val, cond, delay_us, timeout_us) \
 ({ \
@@ -177,17 +177,17 @@ struct reg_sequence {
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
- * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_field_read
+ * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout or the regmap_field_read
  * error return value in case of a error read. In the two former cases,
  * the last read value at @addr is stored in @val. Must not be called
  * from atomic context if sleep_us or timeout_us are used.
- *
- * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
  */
 #define regmap_field_read_poll_timeout(field, val, cond, sleep_us, timeout_us) \
 ({ \
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 2584621c3b2d..d73644e85b6e 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -597,12 +597,12 @@ snd_sof_is_chain_dma_supported(struct snd_sof_dev *sdev, u32 dai_type)
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
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
  * case, the last read value at @addr is stored in @val. Must not
  * be called from atomic context if sleep_us or timeout_us are used.
  *

-- 
2.39.2


