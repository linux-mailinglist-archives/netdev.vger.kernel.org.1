Return-Path: <netdev+bounces-104212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA3690B8FE
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1772B1C22A25
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD1119B3DA;
	Mon, 17 Jun 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNhO1YnT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126519AD4A
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647375; cv=none; b=AfaRtbBz5BKw+o0A3U9+Sb7u3ixC6udfAHKt7tVm8SNan98u38BaPURy4IOpI9z4K+QpR/DXxCar8xjzH8Ewtd8fNCO3PE8TGMo+0EJipKj4mu0CI8kjcSufkjNyB6TUevSsHIW93PRNafkpjOQ2XcDWRP5UEyuzDLIXKz5haRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647375; c=relaxed/simple;
	bh=RZ14lsCYb4YxKJjabopa0avjAflKI1wcPKwGhod+Gzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNuNXymDEXSC7J0UJtufa/Ygb7LQxwyxepF7yx6fd3HhNkAZ5RUDfRh0J4OA+EKahO5ry0tAe91dwmzXHHvwB3xjhMKdy5xRRNbUHau0OpD680EjseXUub598guzcew8KLkjs6bvcmR/NPsWJhIsLAVATPJ/1nl3WGtTzy+/TOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNhO1YnT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718647373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MT58cRhLJAAVBSqhZOpx+MX2NQrfS9vYxE2s7Gss0cM=;
	b=PNhO1YnTOEnuK/Pu4r4DJYxpEzgPAa4G1jxSi18mSZD10sB+Pf9P4Sfbjf2v9BvUzL1eN2
	U5Qvz+a1QC6IfaVDJZviZGOEW9YBFgzRwHGQ1zlRXzEayxeG+0oB67pgxcdoSYTAEwdD8d
	WZMJTSHYCBLD0XQV6IeDNrLCxJEfm60=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-e9ZtlnUiNrKJbpPoqofFag-1; Mon,
 17 Jun 2024 14:02:46 -0400
X-MC-Unique: e9ZtlnUiNrKJbpPoqofFag-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1227F19560B1;
	Mon, 17 Jun 2024 18:02:45 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FDE719560AF;
	Mon, 17 Jun 2024 18:02:41 +0000 (UTC)
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
Subject: [PATCH net-next 7/7] selftests: net: add config for openvswitch
Date: Mon, 17 Jun 2024 14:02:18 -0400
Message-ID: <20240617180218.1154326-8-aconole@redhat.com>
In-Reply-To: <20240617180218.1154326-1-aconole@redhat.com>
References: <20240617180218.1154326-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The pmtu testing will require that the OVS module is installed,
so do that.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 04de7a6ba6f3..d85fb2d1f132 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -101,3 +101,8 @@ CONFIG_NETFILTER_XT_MATCH_POLICY=m
 CONFIG_CRYPTO_ARIA=y
 CONFIG_XFRM_INTERFACE=m
 CONFIG_XFRM_USER=m
+CONFIG_OPENVSWITCH=m
+CONFIG_OPENVSWITCH_GRE=m
+CONFIG_OPENVSWITCH_VXLAN=m
+CONFIG_OPENVSWITCH_GENEVE=m
+CONFIG_NF_CONNTRACK_OVS=y
-- 
2.45.1


