Return-Path: <netdev+bounces-80062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF9687CD02
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 13:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343612837E6
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 12:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51C1BDE0;
	Fri, 15 Mar 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LarYQq4j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3D18EA8
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710504323; cv=none; b=i/VEiKq9dBSM2X7NBiilLN6DzDA5wihw934v9ivT45VsjKleCIE265eRb/1Ib2SHp4cN4tsX50yxeCJ4MUz/y8SbOjJaKpEBZbEB+PjlKDss7q953n6XfEFd7XoN1U5qzV8nCimo4spTZW4Tpn3btj/hs3MSxL+mDJ/Rjw5wyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710504323; c=relaxed/simple;
	bh=7VXQfjdk/MbEsbbqW5N6rG0COnPGgQTmZSu0kiC+nik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=We7ftSYKJlvpXjOI84TUKBapjaN6NuoyO4l41CLT793CWJdNJOSz/Yn7MwIogNNwaXR6PZDZiTQdMVhBPRXJqggEA/K0QtbpYYZnGqFv3ivBoCKcy6dbD2b7CKs3KqACy1TqWa/urfKM1Nau4EBdBYbrN5QVGlV1bWAfEnaoNcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LarYQq4j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710504320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kn24Hzs/NOyHJ9zT+/JeXQsL6NssdOOEzODdJVZXeKs=;
	b=LarYQq4j4iucL48AZX7QdRB8KkqHDkE8Lh5WXjijxMqBGEyNy8U2GpMqgGTVI3upifBOKi
	TEQ/mzBy1kIT0AFIkKE1iHXieTUiSpjbpfZQSj1Lk+FGPb7b1CULSBCX1GG08VTVu+r1Rt
	+wpzVstFFCeO6hiAUteEkf8mtmitsBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-hqf2JLXlNp22xSr4D9UHYQ-1; Fri, 15 Mar 2024 08:05:16 -0400
X-MC-Unique: hqf2JLXlNp22xSr4D9UHYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A0E885A58B;
	Fri, 15 Mar 2024 12:05:16 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.225.235])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4395E3C22;
	Fri, 15 Mar 2024 12:05:15 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leitao@debian.org,
	dkirjanov@suse.de
Subject: [PATCH net v2] hsr: Handle failures in module init
Date: Fri, 15 Mar 2024 13:04:52 +0100
Message-ID: <3ce097c15e3f7ace98fc7fd9bcbf299f092e63d1.1710504184.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

A failure during registration of the netdev notifier was not handled at
all. A failure during netlink initialization did not unregister the netdev
notifier.

Handle failures of netdev notifier registration and netlink initialization.
Both functions should only return negative values on failure and thereby
lead to the hsr module not being loaded.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 net/hsr/hsr_main.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index cb83c8feb746..9756e657bab9 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -148,14 +148,21 @@ static struct notifier_block hsr_nb = {
 
 static int __init hsr_init(void)
 {
-	int res;
+	int err;
 
 	BUILD_BUG_ON(sizeof(struct hsr_tag) != HSR_HLEN);
 
-	register_netdevice_notifier(&hsr_nb);
-	res = hsr_netlink_init();
+	err = register_netdevice_notifier(&hsr_nb);
+	if (err)
+		return err;
+
+	err = hsr_netlink_init();
+	if (err) {
+		unregister_netdevice_notifier(&hsr_nb);
+		return err;
+	}
 
-	return res;
+	return 0;
 }
 
 static void __exit hsr_exit(void)
-- 
2.44.0


