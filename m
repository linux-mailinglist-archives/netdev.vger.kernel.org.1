Return-Path: <netdev+bounces-130586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919F98ADF4
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A118280EB0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490C21A42AB;
	Mon, 30 Sep 2024 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDVQ2gpz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D821A3BC0
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727272; cv=none; b=dVHdBQWpsSy1sFqLII183F2opAtC8joRk1suh6J85VtLIlrgQ7r//cMuMCEyu9q7TbboBCgkOYbp/hFpzqZkBJ04ven9Diwt+8CZDGqcyeVkZgsLBhuo/b25VN2WnEVX4zY4VMSitSdAU7cHJzxzNnuGzgw++ZbdHOB3SH6O7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727272; c=relaxed/simple;
	bh=3sFK6ohKBfjbKqpeMer5E4SiRe74+gADhS8Xvs8bGjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBo5J8a50ms4GRkV3E0YkEnkLBVWIN/z61KNtExmqNn5FQmA1LCqVZnLbKfc1OUAL5gPRrP3vz4PZ69jONJBW+Y+mdx3gkB3O7nz8eL1n2mkswxegMwPQ6BEYDAL1BrKja+0UD3zlQhX0k0GQ+2Tc7XkK0/sdWomMf3FKGd0jUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDVQ2gpz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727727270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5yoLzHqzDYMoo8JKEcZUXSdhcVw5MkEGCtLdOL8Nxw=;
	b=eDVQ2gpzAENBqZP1xZQA1rNgwrQizIHlBFrkjyWuwrDbYShFiDQM/TvT+hNZ9id0IhTH+K
	WsXa2DcsfunT7Nx+6IHCOJYMj92YshTr3BsJpg9HeNNl3OXI1VmFxS1CFQy9JWiYvKiCIr
	0DN++djIxDp/AkTyPwYR3AJPKbgljpE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-WrNaCy74Pky-JAdSQRPKvw-1; Mon,
 30 Sep 2024 16:14:26 -0400
X-MC-Unique: WrNaCy74Pky-JAdSQRPKvw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89072196A105;
	Mon, 30 Sep 2024 20:14:24 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (unknown [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDDFE1955DCD;
	Mon, 30 Sep 2024 20:14:21 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	agruenba@redhat.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	netdev@vger.kernel.org,
	vvidic@valentin-vidic.from.hr,
	heming.zhao@suse.com,
	lucien.xin@gmail.com,
	donald.hunter@gmail.com,
	aahringo@redhat.com
Subject: [PATCHv2 dlm/next 07/12] dlm: rename config to configfs
Date: Mon, 30 Sep 2024 16:13:53 -0400
Message-ID: <20240930201358.2638665-8-aahringo@redhat.com>
In-Reply-To: <20240930201358.2638665-1-aahringo@redhat.com>
References: <20240930201358.2638665-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch will rename the config.c implementation file to configfs.c as
in further patches we will introduce a configuration layer to allow
different UAPI mechanism operate on current configfs configurations. We
need a different UAPI mechanism as we want to separate our configuration
on a per net-namespaces basis. The new file "configfs.c" only contains
functionality to maintain configfs handling.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/Makefile                 | 2 +-
 fs/dlm/{config.c => configfs.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename fs/dlm/{config.c => configfs.c} (100%)

diff --git a/fs/dlm/Makefile b/fs/dlm/Makefile
index 5a471af1d1fe..48959179fc78 100644
--- a/fs/dlm/Makefile
+++ b/fs/dlm/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DLM) +=		dlm.o
 dlm-y :=			ast.o \
-				config.o \
+				configfs.o \
 				dir.o \
 				lock.o \
 				lockspace.o \
diff --git a/fs/dlm/config.c b/fs/dlm/configfs.c
similarity index 100%
rename from fs/dlm/config.c
rename to fs/dlm/configfs.c
-- 
2.43.0


