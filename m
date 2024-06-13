Return-Path: <netdev+bounces-103361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E784907BAF
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1CCCB23574
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C56C14B94C;
	Thu, 13 Jun 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esrro/bi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7914A09C
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304239; cv=none; b=Xlg6XftJPbPD9PRzoi9N3RVyD+MBs782OHAd57paY/oXXlWzS3jyukejSoYp9aabgT4HoGJ371QrwcXpSokzzAQEBQGjkXHdfpJg//wc9b6HN3xRB90iojBhvJAJDM8fZ4TLneSjzJxk5qzRYfnsTgR7/6+NcpB7BqQ35fufinc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304239; c=relaxed/simple;
	bh=UVmtpT7Uco6dpDC+/LW4zHgc8tDk9AOgGFpoBQBAmAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhEB1Xu7m4NP/6HLQxBtbKFSwagdta6SD0FF/ykaxWDgezExRBG0r7HYykUJ8o01STATtzGedtDfCnhsWewlte4lvzQnPlpYBeqXnyVC3YEsdIR6FZrM6vUcklc7ZPIVAliJOYmuFG3PjUMeODxPq5y5clCwcMtO4CT/UY/R0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=esrro/bi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718304236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=whtleKggswuDdZXJBktLIhnlernjsyNKrmTcF2hDT80=;
	b=esrro/birI8XCU8ZEAfyuWsbGj74PF8IpKhJONPrbinLmlGmPJTiksqLaLYfiFys76iFW/
	9LWd9VKlwaer+NSbXch4npEUVrI3Z3lj2pILreuwWh4URUgqwtDfHF4tWv0yXbGzgwzw6j
	QJBlM+OAyPwgbpaf/7XT4Il267V6RGg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-5kH_4_SfPr23YR9aY769Xg-1; Thu,
 13 Jun 2024 14:43:52 -0400
X-MC-Unique: 5kH_4_SfPr23YR9aY769Xg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1C3B1956053;
	Thu, 13 Jun 2024 18:43:50 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.17.127])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 425251956087;
	Thu, 13 Jun 2024 18:43:49 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next 0/3] net/mlx4_en: Use ethtool_puts/sprintf
Date: Thu, 13 Jun 2024 14:43:30 -0400
Message-ID: <20240613184333.1126275-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This patchset updates the mlx4_en driver to use the ethtool_puts and
ethtool_sprintf helper functions.

Signed-off-by: Kamal Heib <kheib@redhat.com>

Kamal Heib (3):
  net/mlx4_en: Use ethtool_puts to fill priv flags strings
  net/mlx4_en: Use ethtool_puts to fill selftest strings
  net/mlx4_en: Use ethtool_puts/sprintf to fill stats strings

 .../net/ethernet/mellanox/mlx4/en_ethtool.c   | 58 +++++++------------
 1 file changed, 20 insertions(+), 38 deletions(-)

-- 
2.45.2


