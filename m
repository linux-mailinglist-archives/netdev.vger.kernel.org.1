Return-Path: <netdev+bounces-97367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74828CB178
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 17:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A5128176B
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB40144D36;
	Tue, 21 May 2024 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItcG5UDS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36040144D16
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305711; cv=none; b=dl6Y4agPWDTtpdlRJqM0SfrIYbFAwRhbxCy50SI04c6AndW4WJiY1SmqLVoomvvDH3gR6wMl8tJFtsUSDhgN7yoptoP2pVFQxZ/qYqafRRDy2+UNxMCE7bgMcyXG5Ma3a9DjjUy6v2LkfTkANMajuW4ZNx/n+zW0ib1MDX0kEZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305711; c=relaxed/simple;
	bh=yNK90+Fu3/Egv6BUzfR2b4UhSJudcMdn2qAYCS/ruB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WEJeDT09qEdc7yLoTd2yOwwXe3aB0i/SBZFTrQaGHtOQxJFNH+HoQriP1sjJYVQuzKuPGT3RExThFdq3fdzPWbFhn0cJF6hPLEyzkk0VKHhxAgnCn/I9IAeidDw7q2koP8CEnHSp7/FugogZ9kjRWqAO8+IixBVhWrgN4I2sH48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ItcG5UDS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716305709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dhL1Q+jWnYDABNtKHJSo7WSr7N/mSKlyJQWOyp5Mr2I=;
	b=ItcG5UDSx+rE26ZZtec08EfjD6dZ73qx9Zux+fds6ZDdtQeCB9M3LXKkAX8m0DtP6tQXb+
	bxvMFj1dOhxwcAQTnFKmMVXRev2WigkXnfKTyPiBeogfPOU2rv4iD6kkaxoERxewDOrRZZ
	kffj09+RlrapifyFGTrCszWBKZVlrSQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-EAR_zu1OPjiATrZTrRr3TQ-1; Tue, 21 May 2024 11:35:07 -0400
X-MC-Unique: EAR_zu1OPjiATrZTrRr3TQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b4330e57b6so12740412a91.2
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 08:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305706; x=1716910506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dhL1Q+jWnYDABNtKHJSo7WSr7N/mSKlyJQWOyp5Mr2I=;
        b=DhfQ/wKrR8OZT54JG3DSgrbB4t40xhrpNRWDX1ujGq/xkOaq4q1gFBMjHK3nkJWwld
         PW7EFWhg0BaHRiufv0U2GpSa0ZPqi8LIx9a2xwNRuD4SIY0nsiY7jhNioo6fcCnMgGAq
         vtqPvCx2o65tHKmya+5HqXIjezYxroMSEvKvTqVou1fmFQiMf384AmCnSRPq53FjHhSk
         t0EhdwmAT/sLZjV1vpabdMOnoVwwb91bufHwPw+cF5sf8WFlAj8JhA9SiQKfNmv71da+
         dkHP+qKDBnVO84OTLvtWR6N6/fro0xfHOW+DFWvxmF9EQAQM9udASw0qGsvRn9VSJvDy
         2udQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+vRzoGK2R05MY6J49CcWJMIoFA1k+7TzL8dxqmXibiuOP3tJ+At0W636PmjNCMVbQ9HfHVFdTLRtDHE88PeKO6dMyfIGT
X-Gm-Message-State: AOJu0YxkH6J56vaMs8oY94EmaXYrX+BgBNsMUvxBNUnVlexSvZIF3bo1
	b1OZ4ZdWmXMzRUVtj4InQkuU3nO70TRI4oCosprXER6SL4iaptGP/Rv1uGwn66LvZNI6j5xQUaj
	SkJ/qYg0ewp1MEEcUWpHoDbBH2XF5lhflN4t4yfOMVsipS1X7x9axaw==
X-Received: by 2002:a17:90a:17ef:b0:2b6:ab87:5434 with SMTP id 98e67ed59e1d1-2b6ccd9ec2amr34415232a91.35.1716305706571;
        Tue, 21 May 2024 08:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0tskduGSJKFC3yV7n4L+QWe03s7d30NZ0FNcJ84NxEFgxCHGmSxbxr/In+XYHJkoDv0vXpw==
X-Received: by 2002:a17:90a:17ef:b0:2b6:ab87:5434 with SMTP id 98e67ed59e1d1-2b6ccd9ec2amr34415189a91.35.1716305705973;
        Tue, 21 May 2024 08:35:05 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67158c30bsm21819678a91.39.2024.05.21.08.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:35:05 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syoshida@redhat.com
Subject: [PATCH net v3] nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()
Date: Wed, 22 May 2024 00:34:42 +0900
Message-ID: <20240521153444.535399-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nci_rx_work() receives a zero-length payload packet, it should not
discard the packet and exit the loop. Instead, it should continue
processing subsequent packets.

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
v3
- Remove inappropriate Reported-by tag

v2
- Fix commit msg to be clearer to say
- Remove inappropriate Closes tag

 net/nfc/nci/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 7a9897fbf4f4..f456a5911e7d 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1531,8 +1531,7 @@ static void nci_rx_work(struct work_struct *work)
 
 		if (!nci_valid_size(skb)) {
 			kfree_skb(skb);
-			kcov_remote_stop();
-			break;
+			continue;
 		}
 
 		/* Process frame */
-- 
2.44.0


