Return-Path: <netdev+bounces-291713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOKPHhquFWpkXwcAu9opvQ
	(envelope-from <netdev+bounces-291713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:28:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 001D75D77B0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D3431965BC
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2D40242B;
	Tue, 26 May 2026 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Kr5CR1pu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB8400E19
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805089; cv=none; b=sUNvhKzpTWA0OcetHto3KzVdLu2RQ38Vz92oiRDHInN1d10tDHMnxJg4QFHn35/yOAbj456eGpjCFAYrdW/Se1L+rMxKaS4VW+xtOMgNBUu3C/wH02QRHb+NGS0cl4dc+ce3V+Op/LfbmW5ZIcSF14W4rXZ1L7IPtBg3/iTWC3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805089; c=relaxed/simple;
	bh=A14j4ivDNBl2yGcg6n5ndH+ByZLqjyYb/4BbZyB+vg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsJAEwcP7Ugx1A8KFk1Fctd6c8PGe26iJV1Ozs1Iza/7VJl9Js1f9FbPf+bUlzMsrHNGHnhKjVQqili3XIHuKN4a+LicavzU8wuY5AhJ0zzPU9LcibrVtbiychVCJhosAD3k2JLL1tfa/klz32UUz96lUh/7WutWUSLp/ffpcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Kr5CR1pu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4906238c62eso21188835e9.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779805085; x=1780409885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWA1rx79U563LTGj65VSgfxyjti8CkpfF8kpzyqUrdk=;
        b=Kr5CR1puBNaF4clfOgdrSY811kH0XkJYaXu+tVuev20pRHeBFa6PmkgFfS7uPTR2Mj
         fccEIsQWEhUkWS/CT8WCi3/1a7oZuBvZ0BapIIz3Tp+MeoOcr1VGd0OfwtIMkjbrk1bb
         S51PVUaLe7Z2+cP8ML/eZy1CDRItho9DvS6wXJJhHCYPnaQRkpWofV8xMl3D+fAmy3L+
         e8z7ETF1JDJ+fKIfD9mFwX7Xn3lnn0nDGBAeeV/ZNq4TxDc3KDbcEEeWE8PRq1sgwGN/
         5b2esYUBdADisNNp39HkOaTwLPlCZEXJANrO0FuFsYBD8fAgQRjXET1mdfBqRTJMj+3X
         x24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805085; x=1780409885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWA1rx79U563LTGj65VSgfxyjti8CkpfF8kpzyqUrdk=;
        b=pmfPsHutcJ1esXyR44uAha2+b/Ko9utaUu7YeCFhaTQ5G39ZyKLvxjyyPYKAOn2Bek
         NH30J6ss77LSNHA3JbJ4Gb0IK+L8JFWhlfgmlD2Ygf68vneHPQjI8zoNZniKIC4i2YYq
         2g4c6P1JRbxWssvnPWBFxX3Iw/EBHt+ErMgXFm6AQDbqI0bAJ0gSxPD3xyeAoZ3RmZmm
         2H/z217YopNya/FtJRtoxfv8m8Cn6l1U7zKB6OzHxI8uWEu61xOSAsxpbwaGnokhQErN
         fb2R5PJCrpvUbx1U9Kt728ac87oWl3guzw3MOTUWeABrHICG5yn/Wwcmx2NXFkYCGQ9l
         k/xQ==
X-Forwarded-Encrypted: i=1; AFNElJ91rQDtwykIldsmFoNpvdL7qq4J+zdcoSla9XAqz+NnOE+rUm3wfsPQyMtpRJ9MCq354CLOj0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkzal+s2FXhyD3jFXb4GiGoXrhuH4wIH7UbNQed9Eq5NtdUCl
	WToHPwJpdPdkPQp8QlNjlABuqmgSpgX+vMsFQh+BCefCCn56wufdrEKpc3vfAnYaFDo=
X-Gm-Gg: Acq92OEaW8XvYOYhTaAC8ZG4CaPj2iCYRW759rPeqbSJebkdaEZ+F2PxZQDXZcifK0E
	hxrfcC/Lvn+0tpvzN4ICNLJI2N5vvgHN+WRAr4lqRwqGRZIL3AHPbCfPdtCoSSGEmUiBzVn107S
	VwUgeFILJvJW8BFUpVxhWZmTATSAOaYiRUnmh0yzZZi2DsQObCBXtnt9xEYcEFCpe6/5gxOmOef
	7D8jXF0+kB5lGkowlP1+PcDBKKNGxalpEkAOpUzKfezpnkGtM+sC1Am2YS4eU7fHQANJtEQ2vpF
	N6hdysMmV698HAlnqyJAL6lQSm+5MkAhqPJ4nM2ZO6tiEj47Dxq7NnG+CaP4aQ2QDDYucp7DHR6
	fCZcimQnk9p624FvWS4pkE5nJGNc9VtVQdkjhmQd9wnu6fI4ByoQGRRt0ywNsga1BvULlY36q87
	ZXuBTuUx+w5nc2oFHHJ1gZ0Xvuo/pbEWpOVUjXtI51xf11MzGn9C8GMBlT+j4+RYmlRHwzeg+V/
	lP77GrOzzivfXHUiq1WE3PsQQ==
X-Received: by 2002:a05:600c:4592:b0:490:6237:5213 with SMTP id 5b1f17b1804b1-4906237537cmr145220735e9.23.1779805085104;
        Tue, 26 May 2026 07:18:05 -0700 (PDT)
Received: from localhost (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4904561a160sm379625175e9.9.2026.05.26.07.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:18:04 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Max Staudt <max@enpas.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v1 6/8] zorro: Simplify storing pointers in device id struct
Date: Tue, 26 May 2026 16:17:32 +0200
Message-ID:  <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=A14j4ivDNBl2yGcg6n5ndH+ByZLqjyYb/4BbZyB+vg8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFauEMCO+XO5wBiq0WLDW9CPIg9uJbXOSVo41d x54C4q2mLiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahWrhAAKCRCPgPtYfRL+ TjnnB/9l+SDbdriw4+P0R0QawXzQR6RNcTSEDOsG0Za0QxbkFa85XMb5sLwAO0owuw/Rowx6ky+ QMdsAXUgR3vwvQLdxYJlkEl/VA/XHq/xJJAuw+YZlvI7KLvHFN3YqbmJgo+fHO56QX05JkYBvJ2 Jk9WKvtvJ58lFHkr+5etBSYF3AixiJ+YBuoVcvjao9lM8EjUJ8SyDU/sXtdjUltWSXQmsKSN5Wa cffVeDubVIqpPQNOIDt4M8130VMFMoHEz1nySiOBmpolGD4C9tykhh7r5xGVttivy5+fc/p6kFl 64ZyNUXuXtZrf+NrGcA7ZEOvBZuObVE5B7q9XxMf4MX80c3s
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux-m68k.org,kernel.org,HansenPartnership.com,oracle.com,lunn.ch,davemloft.net,google.com,redhat.com,enpas.org,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291713-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.984];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:email,baylibre.com:mid,baylibre.com:dkim]
X-Rspamd-Queue-Id: 001D75D77B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Technically it is fine (on all current Linux architectures) to store a
pointer in an unsigned long variable. However this needs explicit
casting which is an easy source for type mismatches.

By replacing the plain unsigned long .driver_data in struct
zorro_device_id by an anonymous union, most of the casting can be
dropped. There is still some implicit casting involved (between a void *
and a driver specific pointer type), but that's better than the approach
to store a pointer in an unsigned long variable as this doesn't lose the
information that the data being pointed to is const.

All users of struct zorro_device_id are initialized in a way that is
compatible with the new definition, so no adaptions are needed there.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 include/linux/mod_devicetable.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 3b0c9a251a2e..2673a1bd82c4 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -640,7 +640,11 @@ struct mdio_device_id {
 
 struct zorro_device_id {
 	__u32 id;			/* Device ID or ZORRO_WILDCARD */
-	kernel_ulong_t driver_data;	/* Data private to the driver */
+	union {
+		/* Data private to the driver */
+		kernel_ulong_t driver_data;
+		const void *driver_data_ptr;
+	};
 };
 
 #define ZORRO_WILDCARD			(0xffffffff)	/* not official */
-- 
2.47.3


