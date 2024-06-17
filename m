Return-Path: <netdev+bounces-104196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CA890B7F2
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82E92833E2
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A44E16EB5E;
	Mon, 17 Jun 2024 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXPvPn9u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4716DC2D
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645054; cv=none; b=IfrdBHBfLSyC8xJUjijKJpvMYCiECjoKyNptzMVVBtHqRG6nZAl98B5X+YC4KaxjVdOvAjj5BNrt++2LZnzwNkIdYujrmVFMLipsKcUTvrst+Q1QcS9/IYE4jPg1vIpRP+Nq7m+UpWLpxG6ILz5CnRpkFsXHyRTVmAT3fGFJMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645054; c=relaxed/simple;
	bh=qapk+M0fAQpXalVcEmkEZe+nvZycMQQn2U0PZdsXwkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPSkovaw80K9heQUd2xd7vud90HcZ85XsP1yddABABo1UbyXx9+g0UtxxgFEZZaLxfXdYPMJkq0HPNxHxWDbJdSJQ2fmk3tCJEvMH00V5as0ae8mc2Icfwm74ETMprZvMVW8qzMn//odluU6dUJJtL3bLbFW20MaA6152uP0n0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXPvPn9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718645052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PQG1dIYUC1pjJkVhXERij4oho4CExQtMEDV6mzee4QE=;
	b=LXPvPn9up097S9mbARW+cgniSFPoE0VtktnZ02c/DeMyFuDdVnHJOcmKiMF6beGkphBV71
	VR/MigvN024T36lALMy59PFbTr+9ACmJjS4y+82v47VkuSCqtAgkWNUX4MM4cwHrwqZu+G
	l2WoD4/GDc8NJZJagdGeY4KJAAIGNDw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-4EtdMWQQOma558wG2kSh7g-1; Mon,
 17 Jun 2024 13:24:09 -0400
X-MC-Unique: 4EtdMWQQOma558wG2kSh7g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB00F1956089;
	Mon, 17 Jun 2024 17:24:07 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.18.62])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44FF11956087;
	Mon, 17 Jun 2024 17:24:06 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next v2 0/3] net/mlx4_en: Use ethtool_puts/sprintf
Date: Mon, 17 Jun 2024 13:23:26 -0400
Message-ID: <20240617172329.239819-1-kheib@redhat.com>
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

Changes from v1:
- Remove unused variable.

Signed-off-by: Kamal Heib <kheib@redhat.com>

Kamal Heib (3):
  net/mlx4_en: Use ethtool_puts to fill priv flags strings
  net/mlx4_en: Use ethtool_puts to fill selftest strings
  net/mlx4_en: Use ethtool_puts/sprintf to fill stats strings

 .../net/ethernet/mellanox/mlx4/en_ethtool.c   | 59 +++++++------------
 1 file changed, 20 insertions(+), 39 deletions(-)

-- 
2.45.2


