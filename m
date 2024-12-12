Return-Path: <netdev+bounces-151428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A399EECAC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19FB164B89
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835F62185A8;
	Thu, 12 Dec 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gr+4xbLf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA1215777
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017692; cv=none; b=fj/vgMiE6GlG6umhyXifCx3hHwBjz6RrkyArESqe3RheBPsr3mbjNgapputrzFEJku72TSobJtuO83ym5zN+DRslTuUk1ZHkvOO6V6s0GbDiBWp3yBL0O0nuwQhuMO+C4PhPk5EcVHHuxCAQ90IkXxsIOFqhjpqZWPNLtyxvl3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017692; c=relaxed/simple;
	bh=waZhSssR+wVCPXSbljZm/oxMw0c1I81n9pG27iL0bLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlcQnAjK1K3QuD61fwoSBKahJVRz9vtYmIV78PEybz62ARuFErufBa3oS+oPUvs9fBgvDS1FuwjbtCWokgjYQYsIsgGUPKN32EsloiOhUnVZlHSzBhHKfBWDpvKeEkR52lVPXAD3+qEPrUXQg4Iiw0lnqBt2dVve+NTL+VUHH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gr+4xbLf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734017689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34N7kwn/zaU+vQFweCsw3RqHwt99xwUtzQvb6O57PsE=;
	b=Gr+4xbLfDHsNwySb/oCIm1CzIW93Gwk1iuFVpPhsv2yjQeAzC8LwNV06pzAwjC2nakCVFy
	yBodW/Y2hUBUT82OkS+pMCN0y8OjUpUbE/5dBkGEUIWslLCQC0OtTYe+tdBa06fp1ksnlM
	9GfS0Cz46CydsmTyEUJPWnM5ILRBhFQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-k1jKMSBDNtKyQVKutMRq2g-1; Thu,
 12 Dec 2024 10:34:46 -0500
X-MC-Unique: k1jKMSBDNtKyQVKutMRq2g-1
X-Mimecast-MFC-AGG-ID: k1jKMSBDNtKyQVKutMRq2g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77D8319560B1;
	Thu, 12 Dec 2024 15:34:45 +0000 (UTC)
Received: from rhel-developer-toolbox-2.redhat.com (unknown [10.45.224.236])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CD92195605A;
	Thu, 12 Dec 2024 15:34:42 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH iwl-next 1/3] ice: downgrade warning about gnss_insert_raw to debug level
Date: Thu, 12 Dec 2024 16:34:15 +0100
Message-ID: <20241212153417.165919-2-mschmidt@redhat.com>
In-Reply-To: <20241212153417.165919-1-mschmidt@redhat.com>
References: <20241212153417.165919-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

gnss_insert_raw() will reject the GNSS data the ice driver produces
whenever userspace has the gnss device open, but is not reading it fast
enough for whatever reason.

Do not spam kernel logs just because userspace misbehaves.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 66390eeb2343..9b1f970f4825 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -146,9 +146,9 @@ static void ice_gnss_read(struct kthread_work *work)
 
 	count = gnss_insert_raw(pf->gnss_dev, buf, i);
 	if (count != i)
-		dev_warn(ice_pf_to_dev(pf),
-			 "gnss_insert_raw ret=%d size=%d\n",
-			 count, i);
+		dev_dbg(ice_pf_to_dev(pf),
+			"gnss_insert_raw ret=%d size=%d\n",
+			count, i);
 	delay = ICE_GNSS_TIMER_DELAY_TIME;
 free_buf:
 	free_page((unsigned long)buf);
-- 
2.47.1


