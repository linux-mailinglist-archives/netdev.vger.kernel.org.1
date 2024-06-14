Return-Path: <netdev+bounces-103538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6169087D1
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50DAB213DC
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95500193083;
	Fri, 14 Jun 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtwI73NE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA419308C
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358238; cv=none; b=aabaGzcpk/vL9EADLPiL7XJlIKvmTJdxGCE2iZh9yhhrI/e7u4G3C/aPyxy8/CZ7w2JatXbK5YZ/2SSSWpV5E4tm3iTriZam24bbPwBuPfk9Z82a0Wnf+j5l7GUGbJAO/WHg0vf96sBiu99FvNGvIuI8RMnUvFWked/c8qeSo/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358238; c=relaxed/simple;
	bh=kOpVHQ8v8RsfD5nMX+U2u0NgqPZFZdrU4RP0CSCPj1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3QfCxlpko5TDNQLQlAB9RxvuquW55JwbXJF36lYfVLLPsW+qXM/g/wP9xVxKRZm6ePlp0npBjqfXQOFLN+H+Qam+e+u2MZiqNRkMO/5QhRx27un0c6esoR+FChjznTNUPyt+LeuUOUJsg/FeAkKcMNg7k9p9FH/TiS7WX/EmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtwI73NE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718358236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MfqTN/CbY1HyFIhalUL/iKeJVM9fDG1FDPUMa7yrEEo=;
	b=LtwI73NEmM0+OU3oem4dim2dsAk+dC59IZ4RUAPqHGnRMtLEfJ2/glFpji68V8vWSxBy0n
	Z1DL38zonC9k2LWyqJeu8VsFRrTLwYiE2PpiuLQ8nHG9F7Ahx/oZIUNoDzav/l3YQXtlqo
	rDZRG2sjYkzbPsniMEc5m0zFTZqShsc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-ZQfYF44uPSqh_GPFT--fjA-1; Fri,
 14 Jun 2024 05:43:51 -0400
X-MC-Unique: ZQfYF44uPSqh_GPFT--fjA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FF941956086;
	Fri, 14 Jun 2024 09:43:49 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.224.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07AFC1955E91;
	Fri, 14 Jun 2024 09:43:44 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com,
	przemyslaw.kitszel@intel.com,
	Petr Oros <poros@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Konrad Knitter <konrad.knitter@intel.com>,
	Marcin Domagala <marcinx.domagala@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] ice: use proper macro for testing bit
Date: Fri, 14 Jun 2024 11:43:38 +0200
Message-ID: <20240614094338.467052-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Do not use _test_bit() macro for testing bit. The proper macro for this
is one without underline.

Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
Signed-off-by: Petr Oros <poros@redhat.com>
Acked-by: Ivan Vecera <ivecera@redhat.com>
---
Changes for v2:
- added target tree
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


