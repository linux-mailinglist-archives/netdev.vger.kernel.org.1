Return-Path: <netdev+bounces-31061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E143A78B33D
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 16:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96838280E1F
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8B811C98;
	Mon, 28 Aug 2023 14:37:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA2C46AB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 14:37:19 +0000 (UTC)
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC908CC;
	Mon, 28 Aug 2023 07:37:17 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 9882B1868CFF;
	Mon, 28 Aug 2023 17:37:14 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id UxFglozsGboL; Mon, 28 Aug 2023 17:37:14 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 46D921868ACA;
	Mon, 28 Aug 2023 17:37:14 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XGCoCzZOAfKh; Mon, 28 Aug 2023 17:37:14 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.233.169])
	by mail.astralinux.ru (Postfix) with ESMTPSA id 8A3051868CE4;
	Mon, 28 Aug 2023 17:37:13 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Chas Williams <3chas3@gmail.com>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] idt77252: remove check of idt77252_init_ubr() return value
Date: Mon, 28 Aug 2023 17:36:46 +0300
Message-Id: <20230828143646.8835-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

idt77252_init_ubr() always returns 0, so it is possible
to remove check of its return value

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2dde18cd1d8f ("Linux 6.5")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/atm/idt77252.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index e327a0229dc1..2c8e0e6cf4b9 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -2296,13 +2296,7 @@ idt77252_init_tx(struct idt77252_dev *card, struct=
 vc_map *vc,
 			break;
=20
 		case SCHED_UBR:
-			error =3D idt77252_init_ubr(card, vc, vcc, qos);
-			if (error) {
-				card->scd2vc[vc->scd_index] =3D NULL;
-				free_scq(card, vc->scq);
-				return error;
-			}
-
+			idt77252_init_ubr(card, vc, vcc, qos);
 			set_bit(VCF_IDLE, &vc->flags);
 			break;
 	}
@@ -2586,9 +2580,7 @@ idt77252_change_qos(struct atm_vcc *vcc, struct atm=
_qos *qos, int flags)
 				break;
=20
 			case ATM_UBR:
-				error =3D idt77252_init_ubr(card, vc, vcc, qos);
-				if (error)
-					goto out;
+				idt77252_init_ubr(card, vc, vcc, qos);
=20
 				if (!test_bit(VCF_IDLE, &vc->flags)) {
 					writel(TCMDQ_LACR | (vc->lacr << 16) |
--=20
2.30.2


