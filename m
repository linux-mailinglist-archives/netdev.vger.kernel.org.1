Return-Path: <netdev+bounces-191408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC1BABB74D
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C291613CD
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359B526AAA5;
	Mon, 19 May 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TdDbqeW7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fk9TJmpO"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55426A0F3;
	Mon, 19 May 2025 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643602; cv=none; b=rVqS9JyyKiWoAkxLP7XeMgcibkTqlCN6WY9FHEjFAy7lxhaxpg71526XJQe3MPPz3hEG/yvcjePUicwm+hpAZcF6vbFg8rfR7KxRvRslBp2ls5FY+Ox6ngTlZiK7ZlUIAC+jwIz7CUq7JYnyF5W/5OMqqa+YLFMjx9c5a0BW5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643602; c=relaxed/simple;
	bh=wlpwNyknMfR1RoDXQOsQOLe9nGuz+tJKa17ta22S/mA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SXifZBjoQqDuG3nWbIZVqgBoBjQhL5IDs/8pi5eknBgYNXQhGnQNwG4lk9K0Ce+/BhuBm+M2Kyl4II6xa7KrRNU0YZ+6lYwd08IuxpxHYtcb+lmHkaraRpcfQu9wR9Lhh4Hov3JB6ndWiHR9d+Wck2gZyVHXv5q9FQ6ZeieUZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TdDbqeW7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fk9TJmpO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083025.715836017@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PLK3LOofu2itK9FE/VIdqa3Xxrw13vea1Zi9cuZZRM0=;
	b=TdDbqeW7xJSZBq+Ley0iGfyW1zImBQjGBoX/+xnFmUAnvfOaSSO8zR/WDq13cpjMZ8jpUG
	edJODaexIBsLFPsZuU+AT/KiiXz3oFbpYBiDqar/z8FuBRmkxvvxQNMn7i9G1SpxCKbI0p
	6QYHcHuuepNkWWpyaHcOAoxEpO0gC7TnJ/DaJCC2L262lZj3jp+7rWK7rbjXfPFciRAWxT
	ce1DbH40cM97HJv7GgXbONzAo7NJR5MkFdXrz63aSLyJhCKhUaNhW9ZXwHwEMLIvaZa1LC
	LalBAq3HT7hlMcGufAryu/+9IQeJ7FeL/9HNc5gM9MWFA/7BslSod+yhTu225A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PLK3LOofu2itK9FE/VIdqa3Xxrw13vea1Zi9cuZZRM0=;
	b=Fk9TJmpO579fid/aMb5B2w9Cl7R1XgjdG0C5Rue0dEh7x2hXfdKH9BNuWmE9GYeHvt5gzz
	75hoAcA5zqlCWCAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 John Stultz <jstultz@google.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Nam Cao <namcao@linutronix.de>,
 Antoine Tenart <atenart@kernel.org>
Subject: [patch V2 02/26] timekeeping: Cleanup kernel doc of
 __ktime_get_real_seconds()
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:16 +0200 (CEST)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -975,9 +975,14 @@ time64_t ktime_get_real_seconds(void)
 EXPORT_SYMBOL_GPL(ktime_get_real_seconds);
 
 /**
- * __ktime_get_real_seconds - The same as ktime_get_real_seconds
- * but without the sequence counter protect. This internal function
- * is called just when timekeeping lock is already held.
+ * __ktime_get_real_seconds - Unprotected access to CLOCK_REALTIME seconds
+ *
+ * The same as ktime_get_real_seconds() but without the sequence counter
+ * protection. This function is used in restricted contexts like the x86 MCE
+ * handler and in KGDB. It's unprotected on 32-bit vs. concurrent half
+ * completed modification and only to be used for such critical contexts.
+ *
+ * Returns: Racy snapshot of the CLOCK_REALTIME seconds value
  */
 noinstr time64_t __ktime_get_real_seconds(void)
 {


