Return-Path: <netdev+bounces-85913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7A389CD29
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FE01F24458
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB718147C62;
	Mon,  8 Apr 2024 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzjsh1qV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE493143C59
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610120; cv=none; b=ffLFrJYw95MlLTn8yQYSFc4QRxlwiYRKeANoUl0TFQ0jbe+8JCYFR4RVlMm0WfJAP/63SwwvWfQ46t1M8xTMFF8QIEw454ZovemSHclrstxzbZqsyY7F0KR7esJmlR0S7BUL1vwuj8zd1qX9GMyi2OHxglwUNpQ39OR51oqSyI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610120; c=relaxed/simple;
	bh=QDv9KCPej2Z8S2WV7lTHZumyjt9/B0HyqKssydv/Pls=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PZNzdbqkFkwXtF0nsJsG6T7rCSYqmBHkrs5XCnrlzR1WMTJPdsyy9miy9ZyY12eS+kWuiCBZMm72rl0xB1oNcE5GtpAAgdBQQn7DpjyXuwop0lLCgQVxGRPgMbM4GbEzmj7kggl3LTXSsIhQ2Ts9whZsYyrELt6kNTMsO4V19Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzjsh1qV; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7d5db4db530so231677739f.3
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 14:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712610118; x=1713214918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uLznkFGOlo8A8sZ3jlYvQbdFRdAfe6UEwaM81J09PTY=;
        b=mzjsh1qVleyafv/lKamYEIuBAX99NQrwnuOEZj3jHR0fL7uMQ6t1Qop2jApHfjpLEZ
         x+vbsa8sYIFeLvELOmEb9c4GX41F1lL7pQL88i2yiCtPW3gg6aOK4+077/0cxz97FToO
         FwJApSfGQxDVTQU8b4mfyqAm8d3wfR8v7ApLaQo3m2ztkJxMtvK2TyW0lRGk37Qp8dWi
         zc1zhg+qG9gjax/iAtJBQQtHt7ZvZncD1iSjp8M/bMIwV75RjyX6RInqC/F5M5EC4scm
         Lf6yuHsBR5PMdInouXhfIqLasUTbvu89PfNqDGKYgSY27Ss/12Dx5txdOrf+w5CqeZhF
         0OYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712610118; x=1713214918;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLznkFGOlo8A8sZ3jlYvQbdFRdAfe6UEwaM81J09PTY=;
        b=Vytv/jyxTxLK6S+5K4wZB0WHLtTk6IgFqwHps8X/4YgbA5Zk1P93b11bUH07bieTvk
         n8Sp0VAoepKyeGQmfo7Ae9vS9waJkYTjngKAMxbmVWGVb+sauj3mHrsiZe9jFhFQV0UG
         EX6acTJAV2azp4Zn8cFSnfZJibKsVJ7p8g/riExMwjHHhhbfhQgX46BZBTc5YDCfsTBm
         GtJ7yWdfvGghpnYYMpJKO+NGOyg/WHNced2lVFLCg8zOziAQYfD2P5tCPhKkcRlWa6E7
         v53ACFwvN1PaQ9WSjHCcusDlmpYv/ZWhgt4O7nBRtUrANps3ku4mqkXrJL0V1YBkUlP8
         d5lg==
X-Gm-Message-State: AOJu0Yzoh9qqSbSE9aSpSGWZ+tMmdAkqDQswr6+YoOGduxHNdlBDh9ad
	Ta2VFZfAiOVbs5an5EkJOQcLedG/sBf8U10n1OO8grHeSbJ6I6NbSXasCS+Jn2HUPIvhHxjI1G+
	2KgKecr9ICi+vGJbYGtUD6Q==
X-Google-Smtp-Source: AGHT+IEGr267JScNfp1B4UlKiG6XyHv5ciIvwN48yFMEaQAmwmT6K6r1WRh4Kcw0kydKAgqdYMX9SMs35EnZJ+W1bg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:890a:b0:482:8cc0:c8f7 with
 SMTP id jc10-20020a056638890a00b004828cc0c8f7mr316594jab.4.1712610118054;
 Mon, 08 Apr 2024 14:01:58 -0700 (PDT)
Date: Mon, 08 Apr 2024 21:01:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAERbFGYC/52NvQ6DIBgAX8Uw92v4EWo79T2aDgifSmLBgCE1x
 ncvunVsx7vhbiUJo8NEbtVKImaXXPAFxKkiZtC+R3C2MOGUC0aphDRHb6YFbHQZYwKPM9ikYdT
 +KqgAEyKCASUa1cgGpeGclNgUsXPvY/R4Fh5cmkNcjm9mu/15kRkwkFopI0XD6gve+xD6Ec8mv Mj+yPy/Li/dDttaci0Ft+1Xd9u2DxxSuMQ1AQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712610117; l=1957;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=QDv9KCPej2Z8S2WV7lTHZumyjt9/B0HyqKssydv/Pls=; b=GiN8E2PdpuyazNGKio0kvQzwE9Xwi36Z1fTx7zPsR5N6i/jSMjsusCuUBk1erOgK297kwYBQF
 WlgTEQpCPabCYBdGyS7jfne8GRlTTEgsn6Y8PIMJuQiOUXps1bhmin5
X-Mailer: b4 0.12.3
Message-ID: <20240408-strncpy-drivers-net-dsa-lan9303-core-c-v3-1-0c313694d25b@google.com>
Subject: [PATCH v3] net: dsa: lan9303: use ethtool_puts() for lan9303_get_strings()
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="utf-8"

This pattern of strncpy with some pointer arithmetic setting fixed-sized
intervals with string literal data is a bit weird so let's use
ethtool_puts() as this has more obvious behavior and is less-error
prone.

Nicely, we also get to drop a usage of the now deprecated strncpy() [1].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
Changes in v3:
- use ethtool_puts over ethtool_sprintf
- Link to v2: https://lore.kernel.org/r/20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com

Changes in v2:
- use ethtool_sprintf (thanks Alexander)
- Link to v1: https://lore.kernel.org/r/20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com
---
 drivers/net/dsa/lan9303-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index fcb20eac332a..04d3af0eb28e 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1007,14 +1007,14 @@ static const struct lan9303_mib_desc lan9303_mib[] = {
 static void lan9303_get_strings(struct dsa_switch *ds, int port,
 				u32 stringset, uint8_t *data)
 {
+	u8 *buf = data;
 	unsigned int u;
 
 	if (stringset != ETH_SS_STATS)
 		return;
 
 	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++) {
-		strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
-			ETH_GSTRING_LEN);
+		ethtool_puts(&buf, lan9303_mib[u].name);
 	}
 }
 

---
base-commit: c85af715cac0a951eea97393378e84bb49384734
change-id: 20231005-strncpy-drivers-net-dsa-lan9303-core-c-6386858e5c22

Best regards,
--
Justin Stitt <justinstitt@google.com>


