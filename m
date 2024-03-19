Return-Path: <netdev+bounces-80703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA8D880722
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 23:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC17281603
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 22:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2C24F218;
	Tue, 19 Mar 2024 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BAGNpghu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E11D4F217
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886197; cv=none; b=fW5i4oDwKgYgmmMMM4/UBLZEouzHN+ZMrW68xIEQplCOn+Wev0DtN4McZo0PX4MQdKPGnqzcYrfyuSk7Iv4mm9kNGA4imE+CwfPBqSNZ1CfWDlyOrLejkl7GW72bWo9+zFU3goxwFmkQCJJ9FXw/Y4w+JgBCjUUZV8xKjVegjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886197; c=relaxed/simple;
	bh=3stVh4mgfjT90u/vVL4RPSOox8XmIDu6U3JTln/ZCUM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mjMq4iOUEm9eDVvJaVywSKvkbdMjWHdjRtVapMNwf767Ee0RUBvuMsjx3G8ZXxm6aJrhF+34AP3wH38v1WGpmTsv1mo7gTCd09Uq1ItmXy3xKAqfOffdYRfbIjY5i8mYT5aH4ArQCud9VYQq+bGo6yyvfZnPWvZu+BN4wBcxKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BAGNpghu; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710886195; x=1742422195;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gY5tGuBBxbjWnKHz7INJKL36XnPDim4953LDmJS0URc=;
  b=BAGNpghufOYEhbUgTePTimcFOc76uZzz85Rif8/e9l0m38hUrC+XUro9
   YcVd8Tnhfy/QVTEMzjv++scHx36n7KDaDvm7pMHDgaNhxCzQrbiO4846t
   UBgSj6PeUgjUApxBMhD2VgH3ifrPsIzQrBQfiZYdBmDdDty9Hvf9IrONV
   I=;
X-IronPort-AV: E=Sophos;i="6.07,138,1708387200"; 
   d="scan'208";a="281285375"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 22:09:54 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.0.204:59249]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.44.197:2525] with esmtp (Farcaster)
 id e8dd12a4-56a2-42c7-87b3-1c7c6c3745a3; Tue, 19 Mar 2024 22:09:54 +0000 (UTC)
X-Farcaster-Flow-ID: e8dd12a4-56a2-42c7-87b3-1c7c6c3745a3
Received: from EX19EXOUEA002.ant.amazon.com (10.252.134.207) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 22:09:54 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19EXOUEA002.ant.amazon.com (10.252.134.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 22:09:53 +0000
Received: from dev-dsk-jorcrous-2c-c0367878.us-west-2.amazon.com
 (10.189.195.130) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 19 Mar 2024 22:09:53
 +0000
Received: by dev-dsk-jorcrous-2c-c0367878.us-west-2.amazon.com (Postfix, from userid 14178300)
	id 82B6F1547; Tue, 19 Mar 2024 22:09:53 +0000 (UTC)
From: Jordan Crouse <jorcrous@amazon.com>
To: <netdev@vger.kernel.org>
Subject: [PATCH 1/1] devlink: Fixup port identifiers for 'port param show'
Date: Tue, 19 Mar 2024 22:09:53 +0000
Message-ID: <20240319220953.46573-1-jorcrous@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Commit 70faecdca8f5 ("devlink: implement dump selector for devlink objects show commands")
inadvertently removed DL_OP_HANDLEP from the required flags so that
port definitions no longer worked:

  $ devlink port param show pci/0000:01:00.0/52 name bc_kbyte_per_sec_rate
  Devlink identification ("bus_name/dev_name") expected

Return DL_OP_HANDLEP to the mask so the code correctly goes down the
dl_argv_handle_both() path and handles both types of identifiers.

Signed-off-by: Jordan Crouse <jorcrous@amazon.com>
---
 devlink/devlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index dbeb6e39..355e521c 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -5050,7 +5050,8 @@ static int cmd_port_param_show(struct dl *dl)
 
 	err = dl_argv_parse_with_selector(dl, &flags,
 					  DEVLINK_CMD_PORT_PARAM_GET,
-					  DL_OPT_HANDLE | DL_OPT_PARAM_NAME, 0,
+					  DL_OPT_HANDLE | DL_OPT_HANDLEP |
+					  DL_OPT_PARAM_NAME, 0,
 					  DL_OPT_HANDLE | DL_OPT_HANDLEP, 0);
 	if (err)
 		return err;
-- 
2.40.1


