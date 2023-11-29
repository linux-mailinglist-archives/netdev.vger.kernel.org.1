Return-Path: <netdev+bounces-52207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 401757FDE03
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C44DAB20E65
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E163D0A0;
	Wed, 29 Nov 2023 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Q8lz/dRx"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 09:11:34 PST
Received: from forward206a.mail.yandex.net (forward206a.mail.yandex.net [178.154.239.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F91D1
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 09:11:34 -0800 (PST)
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward206a.mail.yandex.net (Yandex) with ESMTP id 5603268FD8
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 20:04:25 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:7d84:0:640:6613:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTP id 774D946CB8;
	Wed, 29 Nov 2023 20:04:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id I4Z91X4Oc8c0-vXHyeDrt;
	Wed, 29 Nov 2023 20:04:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1701277459; bh=A8rwaLBdmdoH3ljvyJC9Zh3/wiZgmRUvbRMlhaG57TI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Q8lz/dRxV2CXR0pdkg95Q/bg4bUhH578RmHB7LRFiCqIsMVjTtVfkgSIGm0XX20eL
	 ZpQr5/weL3VDarMQS4kExSwxmeTMwjhuBVniBhAA9wgmybeZERKxAbZoF0yZG5egPg
	 PCljVElbLg709uUk5wk9AAPkBgickVXMbD5d5O2A=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] nfc: pn533: fix fortify warning
Date: Wed, 29 Nov 2023 20:03:46 +0300
Message-ID: <20231129170352.6050-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with gcc version 14.0.0 20231129 (experimental) and
CONFIG_FORTIFY_SOURCE=y, I've noticed the following:

In file included from ./include/linux/string.h:295,
                 from ./include/linux/bitmap.h:12,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/paravirt.h:17,
                 from ./arch/x86/include/asm/irqflags.h:60,
                 from ./include/linux/irqflags.h:17,
                 from ./include/linux/rcupdate.h:26,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from ./include/linux/ratelimit.h:6,
                 from ./include/linux/dev_printk.h:16,
                 from ./include/linux/device.h:15,
                 from drivers/nfc/pn533/pn533.c:9:
In function 'fortify_memcpy_chk',
    inlined from 'pn533_target_found_felica' at drivers/nfc/pn533/pn533.c:781:2:
./include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  588 |                         __read_overflow2_field(q_size_field, size);

Here the fortification logic interprets call to 'memcpy()' as an attempt
to copy an amount of data which exceeds the size of the specified field
(9 bytes from 1-byte 'opcode') and thus issues an overread warning -
which is silenced by using the convenient 'struct_group()' quirk.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/nfc/pn533/pn533.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index b19c39dcfbd9..7fb0f6c004f7 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -740,8 +740,10 @@ static int pn533_target_found_type_a(struct nfc_target *nfc_tgt, u8 *tgt_data,
 
 struct pn533_target_felica {
 	u8 pol_res;
-	u8 opcode;
-	u8 nfcid2[NFC_NFCID2_MAXSIZE];
+	struct_group(sensf,
+		u8 opcode;
+		u8 nfcid2[NFC_NFCID2_MAXSIZE];
+	);
 	u8 pad[8];
 	/* optional */
 	u8 syst_code[];
@@ -778,8 +780,9 @@ static int pn533_target_found_felica(struct nfc_target *nfc_tgt, u8 *tgt_data,
 	else
 		nfc_tgt->supported_protocols = NFC_PROTO_FELICA_MASK;
 
-	memcpy(nfc_tgt->sensf_res, &tgt_felica->opcode, 9);
-	nfc_tgt->sensf_res_len = 9;
+	memcpy(nfc_tgt->sensf_res, &tgt_felica->sensf,
+	       sizeof(tgt_felica->sensf));
+	nfc_tgt->sensf_res_len = sizeof(tgt_felica->sensf);
 
 	memcpy(nfc_tgt->nfcid2, tgt_felica->nfcid2, NFC_NFCID2_MAXSIZE);
 	nfc_tgt->nfcid2_len = NFC_NFCID2_MAXSIZE;
-- 
2.43.0


