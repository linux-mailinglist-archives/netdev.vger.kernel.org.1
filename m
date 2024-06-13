Return-Path: <netdev+bounces-103345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49B0907ACC
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40479283F1E
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF96015666B;
	Thu, 13 Jun 2024 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahZ2eJe8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61321156649
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302446; cv=none; b=bz37jfEDkYI5xJhvhc8cPLnWMgMHN5VIvLJ8f8AAP2GfO4zdP9lBfmYFBgJKDHVwd6LVeWpqUylt7T5QHUM/AQIeFBp+pbLIuFoG4Tf9vJPAZ5d4rrHRKTTJQ5FBv+fRSuRzRCZHTpCwI3t9O0G9IKSPT6EmvW4/KQwmNfXoidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302446; c=relaxed/simple;
	bh=5JqVjxmPk9EyBKS7/pb/T29BWulebD0MWUEgIgBmR+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZzeUAT5tZ9nVQ6kIcXgXFHzpATIRxiK3wOtpu2AEsB9aLu1x8zEV9dS2sFWCvO049J4BpGOx87bcYCMlIVk9ZP2KMNYXkAF37NSREKsuKEoo0LYr0il0trjkXUA8/0vsXaj9oZmjU1og6qMAW0d0DgoKH+UnC8YG2D5XG3dpjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahZ2eJe8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718302444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOkoaB5xzwhDX2W0MeFOUKk+4e/RFT6nSx1ZB6Em4wQ=;
	b=ahZ2eJe8LIiO6ViR4B+DXwWxuOzv7tAa0A5+a6l2NEgVdl1wJexLzWLXARJydBBQ7ci3CC
	fzR72vqA1Kv4J4YjVtpm4Uoqs5bLwEikYhzDz2cHfNdiXWwRqtwTGC0UYZShUMNGSqDHZ+
	pE8m1xgYM6VaSBouGGpf/4iwnuHD+eE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-qFpO_VSIPveO-WSic5ymQw-1; Thu,
 13 Jun 2024 14:14:03 -0400
X-MC-Unique: qFpO_VSIPveO-WSic5ymQw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72E5C19560B8;
	Thu, 13 Jun 2024 18:14:01 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 389BD19560BF;
	Thu, 13 Jun 2024 18:13:58 +0000 (UTC)
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
	Adrian Moreno <amorenoz@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [RFC net-next 7/7] selftests: net: add config for openvswitch
Date: Thu, 13 Jun 2024 14:13:33 -0400
Message-ID: <20240613181333.984810-8-aconole@redhat.com>
In-Reply-To: <20240613181333.984810-1-aconole@redhat.com>
References: <20240613181333.984810-1-aconole@redhat.com>
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


