Return-Path: <netdev+bounces-102923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B689905742
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D8928160F
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E22180A85;
	Wed, 12 Jun 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfmgpWZk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24D1802AA
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207193; cv=none; b=VKJV+1HPfTyl8I4zL+v0G0fdj5BcKWzQqSisA/l2fz0/yD5vHPh6DCQsIndh+bxS28P/dwNc/UE+EqIEtWW1k3yd5mshxWwuOkRsf3sBsAZ9r+lZJ6tpu3FG3HNkQJiT/C4tmMBq+AoGX6GO13Wkf4Yq3gN/8quZ0VZPWJQLoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207193; c=relaxed/simple;
	bh=7ZkQvStndLOmVquQJ9fhk7f7/KaQtGuc/zUBftFVSqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TfC7gPS3VLwolgV9jEMqPeWmaDs+huPUhGFLglbIXUJ2nMfRsUobKEiuDxYJ2zp3zBun1Ui5vDuPb5Ph65TP3pMq+kaH6paYAPasB9AtB50yS3h0CZMDRSosOxAm1J14wFIwLXlLvUIcI0fqTGk9dhFW4elNe6tvgOI+9m9zEVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TfmgpWZk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718207190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uRTS/1/7k9uLEpm4344Kh+NF7Wq4enN7raNJbrOkX2M=;
	b=TfmgpWZkLDpbUnU4dnsejfk2/yLJto1XwjsQ71I8LC0U2f8+w6Q/XICtWQffUHOdZ8DEeU
	pqeHOZF0j72fL3quUY0lHV0dc863uDa5IrC59p+quMiEy/iq4SFpYAsJDBT/hdN3yCimrs
	wd9FSsd2v893Mc5RxGM2YJvgoPiMKv4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-_9fc-zS9MAK-KGZGOqqDpA-1; Wed,
 12 Jun 2024 11:46:22 -0400
X-MC-Unique: _9fc-zS9MAK-KGZGOqqDpA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5D2C195606B;
	Wed, 12 Jun 2024 15:46:16 +0000 (UTC)
Received: from swamp.brq.redhat.com (unknown [10.43.3.192])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60C4619560AA;
	Wed, 12 Jun 2024 15:46:12 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com,
	Petr Oros <poros@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marcin Domagala <marcinx.domagala@intel.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Konrad Knitter <konrad.knitter@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ice: use proper macro for testing bit
Date: Wed, 12 Jun 2024 17:46:06 +0200
Message-ID: <20240612154607.131914-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Do not use _test_bit() macro for testing bit. The proper macro for this
is one without underline.

Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_hwmon.c b/drivers/net/ethernet/intel/ice/ice_hwmon.c
index e4c2c1bff6c086..b7aa6812510a4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_hwmon.c
+++ b/drivers/net/ethernet/intel/ice/ice_hwmon.c
@@ -96,7 +96,7 @@ static bool ice_is_internal_reading_supported(struct ice_pf *pf)
 
 	unsigned long sensors = pf->hw.dev_caps.supported_sensors;
 
-	return _test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors);
+	return test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors);
 };
 
 void ice_hwmon_init(struct ice_pf *pf)
-- 
2.44.2


