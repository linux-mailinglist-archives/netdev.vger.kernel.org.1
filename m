Return-Path: <netdev+bounces-106601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F167916F23
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050C61F22B75
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF9317D882;
	Tue, 25 Jun 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czhoYDA6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877017D370
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336194; cv=none; b=GFOVQ/oqAF/AeTY2ekCbGXGGc7uwPud56+PIowXoiO2qyxhN30l2AJaXmRt9bfKgmRMz36HNWLdBMqqufF+LCWNiRG/+c57CKHigHVrxY/xG3lbM5Oh4NgzpVwAB/M0Rj7Cn5Npb7hhgSCNtgRN87sMMEOjLtOOHvboidWiwB9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336194; c=relaxed/simple;
	bh=J3wiOr92FQ3z0v5kwwjtS5iIfbHdoFjlBJ88j6xKFvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O42d3m3dny62cYL5WznkvBmN4f9c600vgeh2Jt+pMCckmj58xkC/zsvrIWxB8ztOxnU+ODpYl/TIyY5GcZw3ql5hsihUxPE2A/qC4ok7lA0Q+GRDzpk+Uq/Dk0M7DRvFPA3f8iP6qgC5WdD/RxAFHUAdp9scHWIuRhxQDBEGlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=czhoYDA6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719336191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMxQkVMeeqCp/fm83KpE8+aeQ32h+4CbBVsVdrK3ckA=;
	b=czhoYDA6ah5xIs64p13fiI5yy1N1PwLUChgNE/zrtXJU4hjqzJwTaUp2R0FQ0GghgPIbiM
	PtftLckm2pZLzEdpFh4HKjuGsNOIaykDg1o9YjFo83Woe/NwmCvSDoq8HVhRuaiG8U4j73
	4JMydkxcvo600pTz1pgal+YmasrksNQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-nU-LX5inPOaTUfE4fgZSBA-1; Tue,
 25 Jun 2024 13:23:07 -0400
X-MC-Unique: nU-LX5inPOaTUfE4fgZSBA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED54819560B4;
	Tue, 25 Jun 2024 17:23:05 +0000 (UTC)
Received: from RHTRH0061144.bos.redhat.com (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C84C619560BF;
	Tue, 25 Jun 2024 17:23:03 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 7/7] selftests: net: add config for openvswitch
Date: Tue, 25 Jun 2024 13:22:45 -0400
Message-ID: <20240625172245.233874-8-aconole@redhat.com>
In-Reply-To: <20240625172245.233874-1-aconole@redhat.com>
References: <20240625172245.233874-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The pmtu testing will require that the OVS module is installed,
so do that.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d4891f7a2bfa..cf43a1d07046 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -103,3 +103,8 @@ CONFIG_XFRM_INTERFACE=m
 CONFIG_XFRM_USER=m
 CONFIG_IP_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_MATCH_RPFILTER=m
+CONFIG_OPENVSWITCH=m
+CONFIG_OPENVSWITCH_GRE=m
+CONFIG_OPENVSWITCH_VXLAN=m
+CONFIG_OPENVSWITCH_GENEVE=m
+CONFIG_NF_CONNTRACK_OVS=y
-- 
2.45.1


