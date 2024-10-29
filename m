Return-Path: <netdev+bounces-139812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBCE9B446D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F464283B46
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0876B204004;
	Tue, 29 Oct 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFVqDMun"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940220408C
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191322; cv=none; b=PQnzEqXcEsPKQZLf63/DZbRCX4uOlAMTHrl8G8/Ox6IsUOLe7af4nl3G2+It2YhS4W+5w47Ja7BHgssFxLbL++Gy/8uZKFdCapo2vEeo+IljZWPl0huzQaU5UVNHgnSnV1rXLu3M3EKxDaR7r9a47sX/zo0avlWyIVTsh1BAbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191322; c=relaxed/simple;
	bh=47IWp9EzSE658+HrLYx2QXrAM+CMMTgbOmNCWhNPk3w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RtDRzHnwXATVxFvPbOgNL0pYr2jIrsZfnmS+MlTNtUy9tZAqOOu8dCiD12yvX0DvABxm8YTiICO5MzW2eiyXSNX2BUidPC/Az/YjOihKWOuTFQ8go/+MD0Tlqd0tTaYGcsBo56GIXYznXtf5SQFb89BRiZZ5aSdLMR85V6whlvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFVqDMun; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730191319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s2JcuH1RCp5Qo753XXGQQPEK6YW7WZITvV9BapLEJS0=;
	b=dFVqDMun++vUWZ/jVStncVJfw10ope0XvtlMm2IeM4na/Fh+LREZuuj88sY6sE8zAzh4Sm
	+iV0TxshEhVkbS9xPtzaESkae3/CpKZycqtydp5uoAq8vH7RT8LRtsZU+RWTK2kQb+UPRH
	s5NSY8qJLcKv+G4FBOsk05mjj6q9ttg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-CUyk2RkUMmqYDmflGRdEWQ-1; Tue,
 29 Oct 2024 04:41:58 -0400
X-MC-Unique: CUyk2RkUMmqYDmflGRdEWQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F371C1955D61;
	Tue, 29 Oct 2024 08:41:56 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 691C119560A2;
	Tue, 29 Oct 2024 08:41:51 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	dsahern@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] vdpa: Add support for setting the MAC address in vDPA tool
Date: Tue, 29 Oct 2024 16:40:06 +0800
Message-ID: <20241029084144.561035-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch is add support for set MAC address in vdpa tool

changset in v4
1. Sync with the latest upstream code.
2. Address the comments in v2 and remove the MTU-related code,
   as this part was missed in the previous version.
   
Tested in Mellanox ConnectX-6 Dx card

Cindy Lu (1):
  vdpa: Add support for setting the MAC address in vDPA tool.

 man/man8/vdpa-dev.8 | 20 ++++++++++++++++++++
 vdpa/vdpa.c         | 18 ++++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.45.0


