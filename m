Return-Path: <netdev+bounces-228234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDC1BC567D
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 16:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F21F3B7B93
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A02298CA7;
	Wed,  8 Oct 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3FWpQ1C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B8D2980C2
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932875; cv=none; b=tgop+frDTDMUk/WxiaxrV+tDpIfsBxjkJt1jkx3Z8a9UCfVjnrHiI4vOTAFlWyJ+mRHjsEme5rji6RDO5hP6+cyERphVMSRgJc0tbOUIVyB21za5efGhwv5V6n/YIIB9yKRXJh2iPttPLO94/kVLj4GcN7MBj/IdjlbrS6PpR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932875; c=relaxed/simple;
	bh=kmEWOb1DQ6PU7j7I3ZDzT0cpIA0LPrVczuwNMhA7vm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YvoVUgA9YT30DU4ghswc8DSYQ0mfk8lNQZPTNg8Tu1Wpg/hztLbtXAhc+tR4PTLvLzQK+lVk3+LOMkp1I5ePZ0sTnwWHp/VN/0FmqsMMjDwQi/08atGE97HnRPGT2ePSu8AHRcMfkUiZaYcPDKmshAn8fZcuUpO/q1E5ryXpxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3FWpQ1C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759932872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oYh8HFnLFM2OC3MSbODq350hBosxnk0XuD1fw/F+QdM=;
	b=L3FWpQ1ChoIlSKhiEFg212goQvH4foVDC0k20Jmix2horm6I3yXpvaiY8ol9il5X4rbqtG
	+nSKkVXqPtZgDtUxxs3wqs/AYZeEWE5m/jFi34kk9ST7W9TGxGxkGJ98zP3maT1T3vocdE
	PMZH5bxelBhLkND2lSX29LIRFbFRuM8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-QPzE80SSOvOGMdK5hiKT8Q-1; Wed,
 08 Oct 2025 10:14:25 -0400
X-MC-Unique: QPzE80SSOvOGMdK5hiKT8Q-1
X-Mimecast-MFC-AGG-ID: QPzE80SSOvOGMdK5hiKT8Q_1759932863
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ABFC18004D4;
	Wed,  8 Oct 2025 14:14:23 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E6C5180035E;
	Wed,  8 Oct 2025 14:14:19 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] dpll: zl3073x: Increase maximum size of flash utility
Date: Wed,  8 Oct 2025 16:14:18 +0200
Message-ID: <20251008141418.841053-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Newer firmware bundles contain a flash utility whose size exceeds
the currently allowed limit. Increase the maximum allowed size
to accommodate the newer utility version.

Without this patch:
 # devlink dev flash i2c/1-0070 file fw_nosplit_v3.hex
 Failed to load firmware
 Flashing failed
 Error: zl3073x: FW load failed: [utility] component is too big (11000 bytes)

Fixes: ca017409da694 ("dpll: zl3073x: Add firmware loading functionality")
Suggested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dpll/zl3073x/fw.c b/drivers/dpll/zl3073x/fw.c
index d5418ff74886..def37fe8d9b0 100644
--- a/drivers/dpll/zl3073x/fw.c
+++ b/drivers/dpll/zl3073x/fw.c
@@ -37,7 +37,7 @@ struct zl3073x_fw_component_info {
 static const struct zl3073x_fw_component_info component_info[] = {
 	[ZL_FW_COMPONENT_UTIL] = {
 		.name		= "utility",
-		.max_size	= 0x2300,
+		.max_size	= 0x4000,
 		.load_addr	= 0x20000000,
 		.flash_type	= ZL3073X_FLASH_TYPE_NONE,
 	},
-- 
2.49.1


