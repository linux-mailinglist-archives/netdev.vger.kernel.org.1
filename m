Return-Path: <netdev+bounces-142416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDD79BEFF4
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D311F219EC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAF31DE89E;
	Wed,  6 Nov 2024 14:18:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59447502B1
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902714; cv=none; b=KR1VBrCCWHSrfCgNC+zogqN5juuM4MnuGL1uBxx6JFw2rmwH9P0uE+rk/NxE1mkvbxWw+q6S6gmtUtYd4SJU87mj+hJfnRjxommDQnIkdcNjZsXG4zh9MAIlpMjB0qBegS1JzJWCnP/i94xcUpr29qMrOHFsQau6aXpXzhLq5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902714; c=relaxed/simple;
	bh=gseoWO0JQZsLmnir8Uc4wp8eGzpFf9nBuPM1Y79guJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URX4xvCT/p/776Eicw8iHa8/oTNhJKXgdDlfuugYhxL+Q5grnyS74KJVCO3NJCxzw/Gml0lAd5qz424/tiBQUx//Ydjvv5DrvzKl4jQ7OIHkNFQ5R5RK+JErl4EAAh90G9RZ2q/vqPFNe7+6+pAIynHb8L15KN/O/jrH38WoimI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.247])
	by APP-03 (Coremail) with SMTP id rQCowAAHqe5BeStnagZ6AA--.36946S2;
	Wed, 06 Nov 2024 22:12:21 +0800 (CST)
From: Wentao Liang <liangwentao@iscas.ac.cn>
To: viro@zeniv.linux.org.uk
Cc: netdev@vger.kernel.org,
	Wentao Liang <liangwentao@iscas.ac.cn>
Subject: [PATCH] net: ethernet: miss media cleanup behavior
Date: Wed,  6 Nov 2024 22:11:52 +0800
Message-ID: <20241106141152.1943-1-liangwentao@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHqe5BeStnagZ6AA--.36946S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryDtrW3CF4kAr43tFWxCrg_yoW8Gry8pF
	4jgF9rC34kXF1Yqa1UZw1vqFW3uas5Kryxurn3X395Zr9Iyr12va4Fyay5KFWUtrWxu3sx
	Xr1rZry5uan8XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUym14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUVMKAUUUUU=
X-CM-SenderInfo: xold0wxzhq3t3r6l2u1dvotugofq/

In the de21041_media_timer(), line 1081, when media type is locked,
the code jumps to line 1136 to perform cleanup operations. However,
in the de21040_media_timer(), line 991, the same condition leads to
an immediate return without any cleanup.

To address this inconsistency, we have added a jump statement to the
de21040_media_timer() to ensure that cleanup operations are executed
before the function returns.

Signed-off-by: Wentao Liang <liangwentao@iscas.ac.cn>
---
 drivers/net/ethernet/dec/tulip/de2104x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dec/tulip/de2104x.c b/drivers/net/ethernet/dec/tulip/de2104x.c
index 0a161a4db242..724c0b3b3966 100644
--- a/drivers/net/ethernet/dec/tulip/de2104x.c
+++ b/drivers/net/ethernet/dec/tulip/de2104x.c
@@ -988,7 +988,7 @@ static void de21040_media_timer (struct timer_list *t)
 	de_link_down(de);
 
 	if (de->media_lock)
-		return;
+		goto set_media;
 
 	if (de->media_type == DE_MEDIA_AUI) {
 		static const u32 next_state = DE_MEDIA_TP;
@@ -998,6 +998,7 @@ static void de21040_media_timer (struct timer_list *t)
 		de_next_media(de, &next_state, 1);
 	}
 
+set_media:
 	spin_lock_irqsave(&de->lock, flags);
 	de_stop_rxtx(de);
 	spin_unlock_irqrestore(&de->lock, flags);
-- 
2.42.0.windows.2


