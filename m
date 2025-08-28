Return-Path: <netdev+bounces-217654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189DB39701
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ADC16CCE0
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26042E92B0;
	Thu, 28 Aug 2025 08:30:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C872BB13;
	Thu, 28 Aug 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369834; cv=none; b=J9GvELWewY5S4uQcpSfSEcFJ7Txtmg7LtA0fHUlyzBZkkP82t/cVJRBUvqptAJNpzuh/H/aHF/riXiSQsL743yxz8cnzVyxUsKRDwzRGd/WUlziKaJnQvrCMQpqWJ/Wle2vMeg03Dy8QXVGape4i6teT/YLGMtepb+ZAb2erHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369834; c=relaxed/simple;
	bh=lYvOkaqSmiPB3fPDePClMUAcE7IkORIZ2YlXR6J25JE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JunvWI14VZ+ztyDD7fEUqgx1o4IELkuRgS2mFICZmaTmUFIDAwGv9hiREOkePJ0BhZI6wwXR8tgAZc51dT6+agIg2ryJWhuTqjnn+sTfwflElS+7bxGwh8NQxPgqSBISQ6EtonWtVbEL/A3Ig4ocuCERuXlc0MMr3gfYDjmG/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.22.77])
	by mtasvr (Coremail) with SMTP id _____wBXo0GFE7BoaXOmAQ--.35203S3;
	Thu, 28 Aug 2025 16:29:58 +0800 (CST)
Received: from ubuntu.localdomain (unknown [218.12.22.77])
	by mail-app3 (Coremail) with SMTP id zS_KCgC3uGt_E7Bo4vgRAg--.32381S2;
	Thu, 28 Aug 2025 16:29:56 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	vadim.fedorenko@linux.dev,
	jonathan.lemon@gmail.com,
	richardcochran@gmail.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net] ptp: ocp: fix use-after-free bugs causing by ptp_ocp_watchdog
Date: Thu, 28 Aug 2025 16:29:49 +0800
Message-Id: <20250828082949.28189-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgC3uGt_E7Bo4vgRAg--.32381S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwYMAWivX3kKvwA9sh
X-CM-DELIVERINFO: =?B?tDe5dwXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR14rLicSpEjZUZiR0XyfQpfqCNvLUJpn3cUPDpJvueWGVIASmmDqvMev1Dccqs2H3z1uh
	i0RlUb/Ldsdi21hmwFQW6Se2hnaYR5/2T5LD0dLogoMhDa3yq0Flmth1VeHgmA==
X-Coremail-Antispam: 1Uk129KBj93XoW7WFy7KFW8try3Kr15CrW8Zrc_yoW8XFy5pr
	WkGw43Ar1jqr4UCa1vqr1kJFyruayvvFy0yw4rKwn8Z3Z8WF1SqF4rKw4jgayqkrWDWr1S
	yF4Fq3y5AFnYk3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
	JVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7xwIDUUUU

The ptp_ocp_detach() only shuts down the watchdog timer if it is
pending. However, if the timer handler is already running, the
timer_delete_sync() is not called. This leads to race conditions
where the devlink that contains the ptp_ocp is deallocated while
the timer handler is still accessing it, resulting in use-after-free
bugs. The following details one of the race scenarios.

(thread 1)                           | (thread 2)
ptp_ocp_remove()                     |
  ptp_ocp_detach()                   | ptp_ocp_watchdog()
    if (timer_pending(&bp->watchdog))|   bp = timer_container_of()
      timer_delete_sync()            |
                                     |
  devlink_free(devlink) //free       |
                                     |   bp-> //use

Resolve this by unconditionally calling timer_delete_sync() to ensure
the timer is reliably deactivated, preventing any access after free.

Fixes: 773bda964921 ("ptp: ocp: Expose various resources on the timecard.")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/ptp/ptp_ocp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index d39073dc4072..4e1286ce05c9 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4557,8 +4557,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	ptp_ocp_debugfs_remove_device(bp);
 	ptp_ocp_detach_sysfs(bp);
 	ptp_ocp_attr_group_del(bp);
-	if (timer_pending(&bp->watchdog))
-		timer_delete_sync(&bp->watchdog);
+	timer_delete_sync(&bp->watchdog);
 	if (bp->ts0)
 		ptp_ocp_unregister_ext(bp->ts0);
 	if (bp->ts1)
-- 
2.34.1


