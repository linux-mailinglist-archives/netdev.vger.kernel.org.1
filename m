Return-Path: <netdev+bounces-265900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H5WGe7Hr2nWcAIAu9opvQ
	(envelope-from <netdev+bounces-265900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:27:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4451824650C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B7D0302AD29
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5053E5EF5;
	Tue, 10 Mar 2026 07:27:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C8304972;
	Tue, 10 Mar 2026 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127639; cv=none; b=D94pcmTRmUWnOfp6DzEwRWUNEG9i0j5VzQ0nP3BsDinjVq8RylTQflSZhtuA2F3vVoDnXL3jQjmLpuNQr7fdBQfUEanwZCL0EBSKrfUQ94+RCSWTyqlE8wi6YDdH96W857jbRD8rGGTTHKr3P/7sprQOehyEfTVHdsQWrkUgmpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127639; c=relaxed/simple;
	bh=gt+IEjZVyREX0OHtB3c5uCJO6Q8mAcODIGcUtN9VhAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OqgightNn3+e4Nb0tRNQxEpc7RgAPjuBxvazkTdoMX0nMKb6Jd5DdZOo49VudUdhGDDOisdvXOrd4U+1BK1e9gPrV+5B3UsBYF4lEgSwXT24iHdcHeA+mQvzqegQ0l9e/fv4QoYtNeg4qgt1XsNLKfeB2IMKJs4yZhJAwKHWynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowADX+N+zx69pfnQ6Cg--.6292S2;
	Tue, 10 Mar 2026 15:26:43 +0800 (CST)
From: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
To: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
Subject: [PATCH v2] net: ethernet: bgmac: use pm_ptr() to clean up PM code
Date: Tue, 10 Mar 2026 07:26:37 +0000
Message-Id: <20260310072637.739541-1-pengpeng.hou@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADX+N+zx69pfnQ6Cg--.6292S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw43Wr4ruF18Cr18CFyUWrg_yoW5Jry7p3
	s8GrWjyr1kGFn8ta18ta1kCF1Yyw1ftr9xWFWUWw4fZas8CryxJr40qFW8Zr95AFW8JF13
	tF1Iy3yfZFs8XFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU6UDXUUUUU=
X-CM-SenderInfo: pshqw1hhqjhx1rx6x21ufox2xfdvhtffof0/
X-Rspamd-Queue-Id: 4451824650C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265900-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[pengpeng.hou@isrc.iscas.ac.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,isrc.iscas.ac.cn:mid]
X-Rspamd-Action: no action

Hi Andrew,

Thanks for the tip! Using pm_ptr() is definitely a better way to handle
this. It cleans up the code nicely and keeps the build tests happy even
when PM is disabled.

In the current code, bgmac_enet_suspend() and bgmac_enet_resume() are
always there in the core driver, but their only users in
bgmac-platform.c were wrapped in #ifdef CONFIG_PM.

As you suggested, I've swapped the #ifdef guards for pm_ptr() and
marked the platform wrappers with __maybe_unused. This way, the compiler
always sees the code, but the linker will still toss it out if power
management isn't being used.

Signed-off-by: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
---
Changes in v2:
- Switched from #ifdef guards to pm_ptr() as Andrew suggested.
- Cleaned up the BGMAC_PM_OPS macro and used __maybe_unused for the
  callback functions. It looks much better now!

 drivers/net/ethernet/broadcom/bgmac-platform.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index 86770f1..f9c32e1 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -257,33 +257,22 @@ static void bgmac_remove(struct platform_device *pdev)
 	bgmac_enet_remove(bgmac);
 }
 
-#ifdef CONFIG_PM
-static int bgmac_suspend(struct device *dev)
+static int __maybe_unused bgmac_suspend(struct device *dev)
 {
 	struct bgmac *bgmac = dev_get_drvdata(dev);
 
 	return bgmac_enet_suspend(bgmac);
 }
 
-static int bgmac_resume(struct device *dev)
+static int __maybe_unused bgmac_resume(struct device *dev)
 {
 	struct bgmac *bgmac = dev_get_drvdata(dev);
 
 	return bgmac_enet_resume(bgmac);
 }
 
 static const struct dev_pm_ops bgmac_pm_ops = {
-	.suspend = bgmac_suspend,
-	.resume = bgmac_resume
+	SET_SYSTEM_SLEEP_PM_OPS(bgmac_suspend, bgmac_resume)
 };
-
-#define BGMAC_PM_OPS (&bgmac_pm_ops)
-#else
-#define BGMAC_PM_OPS NULL
-#endif /* CONFIG_PM */
 
 static const struct of_device_id bgmac_of_enet_match[] = {
 	{.compatible = "brcm,amac",},
@@ -299,7 +288,7 @@ static struct platform_driver bgmac_enet_driver = {
 	.driver = {
 		.name  = "bgmac-enet",
 		.of_match_table = bgmac_of_enet_match,
-		.pm = BGMAC_PM_OPS
+		.pm = pm_ptr(&bgmac_pm_ops),
 	},
 	.probe = bgmac_probe,
 	.remove = bgmac_remove,
-- 


