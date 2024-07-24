Return-Path: <netdev+bounces-112774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E6D93B221
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 15:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB371F242E3
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897FD158DD4;
	Wed, 24 Jul 2024 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPZD/DCn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021FC156677
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829396; cv=none; b=Jn+Scbf98nxAd62DM2CIPsRG1ppatr6QNFVhY7bSYCP8jmud2VqISS0z6IeJ3UqFpFWrIqU5atX7r06XRgIh8Wr/lfCRllyRSHr168MopYaE9AuMARSKvV0QazcVxwGZ/g5k+SCh1vJF4rgs8ET9TBNRwq2CjTNskqvbdDk743I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829396; c=relaxed/simple;
	bh=SAjqmh/BLGtim+vtA52dOehpZeqvRWDIVdUK8nzMpbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYM+Mwr8Y+yNA7DctKGttvfq8jo273JlwH5uDKbNb7v7w+fJxMQZQeYylRQ05e8TEA/MKJgs7avLYtr5ePHfxuXK7vZKh1jSEbGBIYBpO7Y0peQ9c33Gq9L05A5NkIDbjQm3fRlpFeiPRf/PrP6a/IFtJIATOPhrEEwcBbAZvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPZD/DCn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721829393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w6G0SfWDui6haP+QkrlZi2OYiAuFOXCgkThuAWcxZVo=;
	b=hPZD/DCn64ChVE3EM4jPg9L7EJUju5zI5T03D1w8Yz/2zLT+EISS1GnPn0tupb0QHRF7qq
	eeDVU9E8JNbyf/S9x6Fut5nzEkvpLxPbiBUzl9WYADUiHw7utMZw5l8pQYUOM1rk+ifLiv
	Jr5K5CrKVBZDXrumYUo/zgZnTHwoRX8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-qd54ccWRPn6wcXy58eHjOQ-1; Wed, 24 Jul 2024 09:56:32 -0400
X-MC-Unique: qd54ccWRPn6wcXy58eHjOQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fb116ff8bfso20129695ad.0
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 06:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721829391; x=1722434191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6G0SfWDui6haP+QkrlZi2OYiAuFOXCgkThuAWcxZVo=;
        b=Id8vq5260JC810ui7BrZTsUAig6l4hSSNnUBbZNCv8Igq35TBInH9LNdcTbm4oZr6B
         5crc5zP7TcUfu2neNkSXKrf/Fw9u+xFdcU/Wo1+TzyhABGjgdJqGaii5DOKvP+wnkJ0M
         UAWCiLmZ04AySDp0Eba7lHZQha807X59nHagY7Z1X8J10YB+acnMB3jqFhEoKIoOFLq3
         Kbs6c3YTRjD9rfVdEOjPnZfEQA1c4wfMnqDl6SyD97c/sJ+s1ziESF+QfcczhtLEZ1zW
         UHQf4aMAagc6y2ZqcxeVCI0lIQOcW/J7TP23ivr6JUl/IyLLXo+myjIS2gZArMLv0IpP
         9jFA==
X-Gm-Message-State: AOJu0YyUeQCB+EshK+z1iUcOGixULJuzkVlqnYC/yVURIsMzKf1esFq3
	oRljojyHmSOc3Gy4ltTlCHZwQDTUPgFNZWemipVfUxC7ZCqII/NmDophKnRkZCOEeNnBeBnaHrG
	IeAYu6JNoEA393cI8LYBds8AGZuIIvueMtQvfUf0Tyz8W+dtdrxm3Kg==
X-Received: by 2002:a17:902:e892:b0:1fd:6529:7436 with SMTP id d9443c01a7336-1fdd20edc9dmr31053815ad.8.1721829391295;
        Wed, 24 Jul 2024 06:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcg6fpS+w8IcgfqaKJSV23XPUmGkySpEj5lsBc/ADne3OoONkx6JCt6twOrhpHEzEPRK1Klw==
X-Received: by 2002:a17:902:e892:b0:1fd:6529:7436 with SMTP id d9443c01a7336-1fdd20edc9dmr31053585ad.8.1721829390812;
        Wed, 24 Jul 2024 06:56:30 -0700 (PDT)
Received: from ryzen.local ([240d:1a:c0d:9f00:ca7f:54ff:fe01:979d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31bd9bsm94359755ad.157.2024.07.24.06.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:56:30 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] macvlan: Return error on register_netdevice_notifier() failure
Date: Wed, 24 Jul 2024 22:56:22 +0900
Message-ID: <20240724135622.1797145-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_netdevice_notifier() may fail, but macvlan_init_module() does
not handle the failure.  Handle the failure by returning an error.

Fixes: b863ceb7ddce ("[NET]: Add macvlan driver")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/net/macvlan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 24298a33e0e9..ae2f1a8325a5 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1849,7 +1849,9 @@ static int __init macvlan_init_module(void)
 {
 	int err;
 
-	register_netdevice_notifier(&macvlan_notifier_block);
+	err = register_netdevice_notifier(&macvlan_notifier_block);
+	if (err < 0)
+		return err;
 
 	err = macvlan_link_register(&macvlan_link_ops);
 	if (err < 0)
-- 
2.45.2


