Return-Path: <netdev+bounces-139731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1B69B3E98
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65591B21EB9
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD1F1FAC47;
	Mon, 28 Oct 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b="C2Gnsf2C"
X-Original-To: netdev@vger.kernel.org
Received: from nabal.armitage.org.uk (unknown [92.27.6.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944F1F9ED6
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.27.6.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159090; cv=none; b=anIeTyrVfJwxMmc9j1w2K+BegYNdLUMrizbR/VNf89j84ikKIVlT0+THsX6t6hhkV85uFt7rIyDljbQkWTWzRrpx7zMWaPC9p34/sCbYeekevriX8hDg86M1XngWlDQv8ghVfYWoZNCERB/QNe2vrajiaL4AvPo9ZVNV1lXooSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159090; c=relaxed/simple;
	bh=SC4WoCL/k8iXaAAzBkka/83PzEThNzAZTlTYYehggXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fMnwcfM7913l8b0y2fIEhaEcFfkbrM16/YUNbko1YhpiRSHtqUVfqOhSiAVzbL9XZU5/H+Fn8fsWp9fBZzuWufJECmM8y069PEWXpErpzdJ5knFU60JSpp5l9XPAOpiqkqbeLXL89l+2/7XQYPUnFWN8KiQnevrHCsg70AM3vY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk; spf=pass smtp.mailfrom=armitage.org.uk; dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b=C2Gnsf2C; arc=none smtp.client-ip=92.27.6.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armitage.org.uk
Received: from localhost (nabal.armitage.org.uk [127.0.0.1])
	by nabal.armitage.org.uk (Postfix) with ESMTP id D119D2E53BE;
	Mon, 28 Oct 2024 23:44:41 +0000 (GMT)
Authentication-Results: nabal.armitage.org.uk (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=armitage.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=armitage.org.uk;
	 h=content-transfer-encoding:mime-version:x-mailer:message-id
	:date:date:subject:subject:from:from:received; s=20200110; t=
	1730159066; x=1731023067; bh=SC4WoCL/k8iXaAAzBkka/83PzEThNzAZTlT
	YYehggXU=; b=C2Gnsf2C/L+h2EiD2ck8vgrU+hdAsJ4n4OVDFuvs0/QS0AYW+QK
	oygvDlR/C1+MwhllGuIhPVB0IJJ0bSsh7hIqZtsEc79NTz+WpZGjloi6Qk0fNYxA
	ikPlOOPbwuqYrC5FHzIeBYjIfv6LnkJATXLBCIcU383o1EfxGx05fUw0=
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from samson.armitage.org.uk (samson.armitage.org.uk [IPv6:2001:470:69dd:35::210])
	by nabal.armitage.org.uk (Postfix) with ESMTPSA id 24EB82E53C3;
	Mon, 28 Oct 2024 23:44:26 +0000 (GMT)
From: Quentin Armitage <quentin@armitage.org.uk>
To: netdev@vger.kernel.org
Cc: Quentin Armitage <quentin@armitage.org.uk>
Subject: [PATCH v2 1/1] rt_names: add rt_addrprotos with an identifier for keepalived
Date: Mon, 28 Oct 2024 23:44:20 +0000
Message-Id: <20241028234420.321794-1-quentin@armitage.org.uk>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

keepalived now sets the protocol for addresses it adds, so give it a
protocol number it can use.

Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
---
 etc/iproute2/rt_addrprotos | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 etc/iproute2/rt_addrprotos

diff --git a/etc/iproute2/rt_addrprotos b/etc/iproute2/rt_addrprotos
new file mode 100644
index 00000000..f9349dee
--- /dev/null
+++ b/etc/iproute2/rt_addrprotos
@@ -0,0 +1,4 @@
+#
+# Reserved address protocols.
+#
+18	keepalived
-- 
2.34.3


