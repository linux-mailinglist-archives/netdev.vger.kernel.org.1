Return-Path: <netdev+bounces-111866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62659933C33
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D121C22697
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 11:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955C17E919;
	Wed, 17 Jul 2024 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYIJO7Be"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AB38385
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215533; cv=none; b=qFBRWl1jXFRLpMo7LWAbNljlsnPFVlx3LDIjb6R/QJ/JvUnJ2N7lLoeBeQRlB7dJUxgM9sFREZB7uYV4+o1ven8QzQTGZJn6/tbF+j1xCyRjsVRjT9yZQto6Lr366Aom+B1nCDpHpL+KQ2RSS5eQT8N+zKjiPuUwHz63lIbZCeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215533; c=relaxed/simple;
	bh=KRytGZa/Wq0s3nQ6kjL56Vpr9ZB+Q3WsyhgadEfClVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mv1HEa/XD/Xizlr+zJjAM0x6MuLNStHtoGTtG6PcQCB1pgZuof3mBdmdKAkl83k3vYQsDEIwN4Ay2IPao5XFXofTrBFi5HA5pitPKWOm4p0Nubfhqdzbt4RB9zJwI2rITXqtz3IB8orvUUTnLyMUpJc8eVlRrdi9mKWY3BKp0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYIJO7Be; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721215529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RcQsPs+dvINVUZvlNfMcEwuBa73I5WIWYg0jHdpgq6c=;
	b=JYIJO7Beai39lgEp/wj6EKFfyot5aQDMBiYhnKFccx8+kpcJgT3wlUaLjH6tNv/dNqYufy
	BJl9aenSVETKIrEawS2LpxeNMdDHUW69gOMCJAwpPL64778hRkNQQnBR3YKuMEeDtjGYO7
	8nTZF4vw4xKbURwfSvXLpWZcDT82PY8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-bU2Etq8GM9W76xjXAkj_gg-1; Wed,
 17 Jul 2024 07:25:25 -0400
X-MC-Unique: bU2Etq8GM9W76xjXAkj_gg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 263D91955D44;
	Wed, 17 Jul 2024 11:25:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.76])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84E2B300018E;
	Wed, 17 Jul 2024 11:25:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] eth: fbnic: fix s390 build.
Date: Wed, 17 Jul 2024 13:25:06 +0200
Message-ID: <5dfefd3e90e77828f38e68854b171a5b8b8c6ede.1721215379.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Building the fbnic nn s390, yield a build bug:

In function ‘fbnic_config_drop_mode_rcq’,
    inlined from ‘fbnic_enable’ at drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:1836:4:
././include/linux/compiler_types.h:510:45: error: call to ‘__compiletime_assert_919’ declared with attribute error: FIELD_PREP: value too large for the field

The relevant mask is 9 bits wide, and the related value is the cacheline
aligned size of struct skb_shared_info.

On s390 the cacheline size is 256 bytes, and skb_shared_info minimum
size on 64 bits system is 320 bytes.

Avoid building the driver for such arch.

Fixes: 0cb4c0a13723 ("eth: fbnic: Implement Rx queue alloc/start/stop/free")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Arguably this is quite sub-optimal, but sharing anyway to have a
short-term solution handy.
---
 drivers/net/ethernet/meta/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index d8f5e9f9bb33..a9f078212c78 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -20,6 +20,7 @@ if NET_VENDOR_META
 config FBNIC
 	tristate "Meta Platforms Host Network Interface"
 	depends on X86_64 || COMPILE_TEST
+	depends on S390=n
 	depends on PCI_MSI
 	select PHYLINK
 	help
-- 
2.45.2


