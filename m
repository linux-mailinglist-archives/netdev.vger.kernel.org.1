Return-Path: <netdev+bounces-67271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 641D7842884
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024DC1F25BF7
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48585C6C;
	Tue, 30 Jan 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PQ8Sh66q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078EA85C61
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630302; cv=none; b=ESW6Me8l5KrH3M7yg5bCeVIK0b+Y0nDTkTZ9iQrSMlMPOyI+/KA4eq/RjSNntNMLymBzaZunfzNDt4/uTBpkogI/fYNQjZdDbxlwtXPUwF9tTT7EfTvHMyCJbO/LzGwktQV79D8cKOrd0jDGqnppuuBmcOJDrY85GFYmxZu0eOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630302; c=relaxed/simple;
	bh=vGngBmxXTomuP/vpBIQ3bf01KEfPj3CLlspWz8I9tyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCWc4HXtNptcASpxWFsBjm9Uqt2RnwpTghy7Rg9cjc0C3BzkwBAsfv1yoU7MunYK5v/yk8ZwZ/KAQ+GWI3cFceVIbzXeyOzdur3c+djd6hGJ81PKxFAwk3NApHKEWz71aMxsfZHiglmY6xrh6tJh0pmWlXZS2qRGRYC1d46Z+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PQ8Sh66q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40faff092a2so2841415e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 07:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706630298; x=1707235098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kp7BtQrHgEbPedtnBZofKASR1P5L52u8moyoZoK43Z8=;
        b=PQ8Sh66q/ifr1kQpiBcoV1pol1jNva4MnztpxgwZMsbkeSgBvykdFdY9/ruyx5fZor
         YuZKzuGvCpgKYYIMH7lSuJD5cxeweQPR++Ph2nmWJwHpEL5pYdHeLx0dGIAFBaKEIeLa
         4nFg+v/Hc1P7ztAFSGknrU6NDWLlsVlQ5jrpdqJyKZr6Qwi0Zg8DaZAM5oBEGgMKmk3p
         lPT61RZZwdUS1kEwRNuKmNfcxcjGSr1REJxnzwpraT7rRHTcVgCpO2yox8VXvCwmq8e9
         Ae3EPcms+x/NU6FR2rPaBHaGjgH0geUuOVcZRhqcuVaOxBzhVSvuxYRNIEKHNo0bNZHe
         cPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630298; x=1707235098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kp7BtQrHgEbPedtnBZofKASR1P5L52u8moyoZoK43Z8=;
        b=O8CLL05s0WBkAoAlf9qAaJcHwKICH0X1ypn1CdbZygZdxtIFXsvuzSF7zT5G0KadPC
         g08T0uPUTKk/LqO2LT8/ZmcIMgBNGO4RNvTdDBHNHeZglXqept/Wf3UA9gYTWUunlg4I
         QnJhV2U+l7mLUnmWthQ8ubRI4SRySetD9Zx1QAvRSZ+XjI4bOyXawAlFsnMHAn8l32px
         adKvN47kWMhFwE+kPLsWeepOIhAH9Pu6DEBWjkCNLuR419E5scwC3HKiv629yDEdafvT
         lcEuoTRb8al8JxWe5K9uybsBfJvMGYgh42rAydWbsI0iysd/DzXMAdvxonPHDHtXwt4Z
         +bNw==
X-Gm-Message-State: AOJu0YwIPShS5G9vU6ytaC/oQgPu1wpvpt/xpvXu/WmeFvUBpQ6ls3s+
	Sm1nTVlkO3++0ejimtZhzVLoKOs15q+yvGkfV83ydwkLGTK9TW1LGQRTFplXbw3JVsrqMz/QluY
	tlmKJYg==
X-Google-Smtp-Source: AGHT+IH1cDW91fUA6vTUDWB+GC7K4rsNJbGXOmR7ryO1ddDwAavdHSKehpdm7sJ/Fm7YxvyGdQAtIg==
X-Received: by 2002:adf:f884:0:b0:33a:e4da:2214 with SMTP id u4-20020adff884000000b0033ae4da2214mr5708782wrp.50.1706630298031;
        Tue, 30 Jan 2024 07:58:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXgkBSCZUFb6zn3saaEq/l5yGnq+DljSDAjpFghRF1VyPIrcXohivd9uGgf0ZoR7pO3BuNmvgGUnVLwQRkWVysSPnCZi9VfAIDobUXEFNTYiXWZlzOUdDZnFC/74lTr4wXZB3y53BQo9VvlAxOEZVYVfYYdwZod+1Qy/3XwMBnu8Cf7lu7Ef2PhcOhy7zM8kEpnhnOg1JgmTk/Mw9dW+B0zDwtr1KhYm3BEO6TgAkvk+6Shn0n+yX7v
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id z18-20020adfec92000000b0033afbd1962esm1885919wrn.69.2024.01.30.07.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:58:17 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com
Subject: [patch net-next] dpll: move xa_erase() call in to match dpll_pin_alloc() error path order
Date: Tue, 30 Jan 2024 16:58:14 +0100
Message-ID: <20240130155814.268622-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

This is cosmetics. Move the call of xa_erase() in dpll_pin_put()
so the order of cleanup calls matches the error path of
dpll_pin_alloc().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/dpll/dpll_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 5152bd1b0daf..61e5c607a72f 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -560,9 +560,9 @@ void dpll_pin_put(struct dpll_pin *pin)
 {
 	mutex_lock(&dpll_lock);
 	if (refcount_dec_and_test(&pin->refcount)) {
+		xa_erase(&dpll_pin_xa, pin->id);
 		xa_destroy(&pin->dpll_refs);
 		xa_destroy(&pin->parent_refs);
-		xa_erase(&dpll_pin_xa, pin->id);
 		dpll_pin_prop_free(&pin->prop);
 		kfree(pin);
 	}
-- 
2.43.0


