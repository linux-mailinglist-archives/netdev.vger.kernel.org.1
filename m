Return-Path: <netdev+bounces-165497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23D1A325C7
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD3D168883
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3247B205AD4;
	Wed, 12 Feb 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPEp72qX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63032271829
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363032; cv=none; b=DFjqLtQC/VrlMQCzM+11HT7rRw7dbsw3xCbOyP4SH0E7nwy3FFldlYw6hT5Veo7By0kAhvD2Na66QFOrPos+02jRwKg5eI56twlIYt5yo61KMwTfj7+p5s1EhRj0qw6Ox6M8UhqWee+3lI0JqTZv+Ew9lYZIMFCz0BwwLiyBcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363032; c=relaxed/simple;
	bh=P8wr2M3nvuWSPpOqgXYZf1pQ9j88n247IgRWZk8kZ8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKPyrLtY16/5bYkW8v//Essnp33ZHJCJFCtNLWwB/BqPNmg0gnySU//sCsbA20ifvcUp8CxevU/6XV2llTwErn5lDeUFAr1JbOe6Eul+iJt48OTDzVdPstN8xjips/tEhyweK05erkmwgiz8IOlhmCGgTzdjs5yebjdmkHrrspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPEp72qX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739363029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JZQefua5AebH/+/11zGJwh/06CwZX5nV/z+iB9+OeAs=;
	b=jPEp72qXRrJNhdxNizvEFFQx/SKj7LmbVTxKO1ecNyhNOmYtmnbiqRAtuz9LDIAJf1OMbW
	MvjXn/fT796TdRYW/7abvAsSeyDAxbD/ENCWk9246eDEPM76TzlaH95OEywNdyWMkW/D8R
	NU1TBtMkcLzSdJSbBjz/Ck4bMVuN8ys=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-RsnC697eMIynRDxQX1m45Q-1; Wed,
 12 Feb 2025 07:23:46 -0500
X-MC-Unique: RsnC697eMIynRDxQX1m45Q-1
X-Mimecast-MFC-AGG-ID: RsnC697eMIynRDxQX1m45Q_1739363025
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAADD19560AD;
	Wed, 12 Feb 2025 12:23:44 +0000 (UTC)
Received: from rhel-developer-toolbox.redhat.com (unknown [10.45.224.146])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3F8318004A7;
	Wed, 12 Feb 2025 12:23:41 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>,
	Corinna Vinschen <vinschen@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>
Subject: [PATCH ethtool] fix MDI-X showing as Unknown instead of "off (auto)"
Date: Wed, 12 Feb 2025 13:23:27 +0100
Message-ID: <20250212122327.42074-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The current version of ethtool is unable to show the correct MDI-X info:
 # ethtool --version
 ethtool version 6.11
 # ethtool enp0s31f6 | grep MDI
     MDI-X: Unknown

For comparison, an older version shows it correctly:
 # ./ethtool --version
 ethtool version 6.2
 # ./ethtool enp0s31f6 | grep MDI
     MDI-X: off (auto)

The blamed commit accidentally removed the ETH_TP_MDI switch case
in dump_mdix(). As a result, ETH_TP_MDI is treated like Unknown.

Fix it by restoring the ETH_TP_MDI case and breaking out.
'mdi_x' is initialized to false, which is correct for this case.

Fixes: bd1341cd2146 ("add json support for base command")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common.c b/common.c
index 4fda4b49d2fd..1ba27e7577b4 100644
--- a/common.c
+++ b/common.c
@@ -171,6 +171,8 @@ void dump_mdix(u8 mdix, u8 mdix_ctrl)
 		mdi_x_forced = true;
 	} else {
 		switch (mdix) {
+		case ETH_TP_MDI:
+			break;
 		case ETH_TP_MDI_X:
 			mdi_x = true;
 			break;
-- 
2.48.1


