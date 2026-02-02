Return-Path: <netdev+bounces-255702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJPeGBwigGnw3AIAu9opvQ
	(envelope-from <netdev+bounces-255702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 05:03:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9590C81B5
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 05:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D416230056FF
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 04:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A673278779;
	Mon,  2 Feb 2026 04:03:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906BE3FC9;
	Mon,  2 Feb 2026 04:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770005017; cv=none; b=LsRBetUrPEI+dL4nE6xCWEkrscyYipvonr7cksAbG0KlQyxJegbRJBSJzro94ug0nInB4CWTgNEp9QZQm7G0UMeWkBt0hYpU0Nwz3RGDqLqkLaYipVtSDEHXom9w9fali8UOLKCwMnhNAquyWje9rfwnwrnA/v6v3y0ic9htkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770005017; c=relaxed/simple;
	bh=xHs4k23ufZZWDeVPPd3ZNFC7r9Q/+zsDbO5EYt3WBOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=huObKkVKfHoxX+XlcpVJDb1i4H/E/jgRB2BbQVK8vHoVI0ViaLUYqivvnNksjqXqmJbNkWKpnjHwAJIDHreUeRolass59bSQ7Qd/xHv2IUi308FpsPauqA5ylu0aEbhW1VXJBniLOc37vrUlssVw1LQVnit3chv4C0N/c3M2Lp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowABX7A8IIoBpjVFJBw--.9450S2;
	Mon, 02 Feb 2026 12:03:20 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com,
	nicolas.dichtel@6wind.com,
	alexandru.tachici@analog.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next] net: ethernet: adi: adin1110: Check return value of devm_gpiod_get_optional() in adin1110_check_spi()
Date: Mon,  2 Feb 2026 12:02:28 +0800
Message-Id: <20260202040228.4129097-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABX7A8IIoBpjVFJBw--.9450S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw4DXrW3Xr1rJF4rGF4DArb_yoW8JrWrp3
	ykCFy5XrZ5Jr48AanrJw18uwn3AayrKrWUKF97Kw4rZ3s8Cr4UJry5ta13ArW5JFWxKFya
	qr4UZrsruF9IkaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeUDGUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255702-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[nichen@iscas.ac.cn,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: A9590C81B5
X-Rspamd-Action: no action

The devm_gpiod_get_optional() function may return an ERR_PTR in case of
genuine GPIO acquisition errors, not just NULL which indicates the
legitimate absence of an optional GPIO.

Add an IS_ERR() check after the call in adin1110_check_spi(). On error,
return the error code to ensure proper failure handling rather than
proceeding with invalid pointers.

Fixes: 36934cac7aaf ("net: ethernet: adi: adin1110: add reset GPIO")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/net/ethernet/adi/adin1110.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 30f9d271e595..71a2397edf2b 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -1089,6 +1089,9 @@ static int adin1110_check_spi(struct adin1110_priv *priv)
 
 	reset_gpio = devm_gpiod_get_optional(&priv->spidev->dev, "reset",
 					     GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(&priv->spidev->dev, PTR_ERR(reset_gpio),
+				     "failed to get reset gpio\n");
 	if (reset_gpio) {
 		/* MISO pin is used for internal configuration, can't have
 		 * anyone else disturbing the SDO line.
-- 
2.25.1


