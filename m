Return-Path: <netdev+bounces-103521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57E69086AF
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5391F2265C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8D19146A;
	Fri, 14 Jun 2024 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZcUpI15"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ADE190475
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354806; cv=none; b=hhOLxheM56zhtb6FMfbybuFGJ61rqrNQo2BZUeujBOVVYC0sfNqzHcM8+phOVjsltkqerCYyy007m41DIz1C4D0Hf1wU+6qRJq9grCFLKaTo8JD/ALqmTVTTNw49HjfeP+aWnoXyLGiIB/DAC7v3IcW5gX/Ba0JmahHWL788F5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354806; c=relaxed/simple;
	bh=qNoQFmqsQmMD+5AhPYE6VqPgaswfpIH8+ACcFxL/gLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K48o9l8yBXcrKK0kc9S1ZA6MV6Z/Ve0BheQhh8lRLmrnyKJ9oaZcgaNu+BXK4D6svyvFhbY96ab/eJSGalb6Q5UbdYKooEJC6MUyVI/ID5+7DLYcGov51YQsrGU2VE4HGHvINc+7REhqgbiIhonqa6nP10j6XM3eTJxgAjpnJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZcUpI15; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718354803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8utKZ9NbJQXHi/9loh5+wQeBJ6pZphNl5y/Zt++GLds=;
	b=FZcUpI150tSMrA/Frny6Qt7KpB62po405CLvVEo641by1ZgdkkA3auxl9y4n1j1LSmKqh3
	k6ghQ7wwkgiQwKgyymYGqp7WkiXXCk3uwgrtmFP4gKHYS14cGrFs9xygTCiNmv+u3HUfy3
	cEFbX6nN6/KhSnfZv3hH3vhTm/YnaLo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-bVL9uVtgNOSUB7oqBjhZ8g-1; Fri,
 14 Jun 2024 04:46:41 -0400
X-MC-Unique: bVL9uVtgNOSUB7oqBjhZ8g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31E6219560AB;
	Fri, 14 Jun 2024 08:46:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.73])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A734A1956050;
	Fri, 14 Jun 2024 08:46:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Documentation: Remove "ltpc=" from the kernel-parameters.txt
Date: Fri, 14 Jun 2024 10:46:33 +0200
Message-ID: <20240614084633.560069-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The string "ltpc" cannot be found in the source code anymore. This
kernel parameter likely belonged to the LocalTalk PC card module
which has been removed in commit 03dcb90dbf62 ("net: appletalk:
remove Apple/Farallon LocalTalk PC support"), so we should remove
it from kernel-parameters.txt now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 423427bf6e49..a9b905bbc8ca 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3184,9 +3184,6 @@
 			unlikely, in the extreme case this might damage your
 			hardware.
 
-	ltpc=		[NET]
-			Format: <io>,<irq>,<dma>
-
 	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
 
 	lsm=lsm1,...,lsmN
-- 
2.45.2


