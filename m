Return-Path: <netdev+bounces-63233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1AF82BEB2
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 11:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48874B247CB
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 10:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777F55821A;
	Fri, 12 Jan 2024 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="OKhOhXEo"
X-Original-To: netdev@vger.kernel.org
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A0282F7
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2c09:0:640:19b6:0])
	by forward102c.mail.yandex.net (Yandex) with ESMTP id AE01260B14;
	Fri, 12 Jan 2024 13:40:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ZehXvY6e40U0-vg96RecO;
	Fri, 12 Jan 2024 13:40:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1705056036; bh=rWhX9Vhior1wd1O1QkZSHiwky6BuwBQ6uhIaZqKUEM8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=OKhOhXEoe+so+H2H//04QoYHt2h/gwYmUsMRXMmuQ60t6b/8CeEBTPgRuh7nDlhyY
	 vW8JbKCwffb+BbfTbLtABvvlhzAFDQAYyydPPUVI6FEC115dpVNRSyDkAyA0zZb3Lq
	 c4FetLzJ+AslZSA604JQgd8jzdXKJT9tGaTJOFM8=
Authentication-Results: mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] net: b44: fix clang-specific fortify warning
Date: Fri, 12 Jan 2024 13:37:33 +0300
Message-ID: <20240112103743.188072-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with clang 17.0.6 and CONFIG_FORTIFY_SOURCE=y, I've
noticed the following warning (somewhat confusing due to absence of
an actual source code location):

In file included from ./drivers/net/ethernet/broadcom/b44.c:17:
In file included from ./include/linux/module.h:13:
In file included from ./include/linux/stat.h:6:
In file included from ./arch/arm64/include/asm/stat.h:12:
In file included from ./include/linux/time.h:60:
In file included from ./include/linux/time32.h:13:
In file included from ./include/linux/timex.h:67:
In file included from ./arch/arm64/include/asm/timex.h:8:
In file included from ./arch/arm64/include/asm/arch_timer.h:12:
In file included from ./arch/arm64/include/asm/hwcap.h:9:
In file included from ./arch/arm64/include/asm/cpufeature.h:26:
In file included from ./include/linux/cpumask.h:12:
In file included from ./include/linux/bitmap.h:12:
In file included from ./include/linux/string.h:295:
./include/linux/fortify-string.h:588:4: warning: call to '__read_overflow2_field'
declared with 'warning' attribute: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  588 |                         __read_overflow2_field(q_size_field, size);
      |                         ^

The compiler actually complains on 'b44_get_strings()' because the
fortification logic inteprets call to 'memcpy()' as an attempt to
copy the whole array from its first member and so issues an overread
warning. This warning may be silenced by passing an address of the
whole array and not the first member to 'memcpy()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/ethernet/broadcom/b44.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 3e4fb3c3e834..d87d995a1a15 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -2027,7 +2027,7 @@ static void b44_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	switch(stringset) {
 	case ETH_SS_STATS:
-		memcpy(data, *b44_gstrings, sizeof(b44_gstrings));
+		memcpy(data, b44_gstrings, sizeof(b44_gstrings));
 		break;
 	}
 }
-- 
2.43.0


