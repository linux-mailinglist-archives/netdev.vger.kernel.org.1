Return-Path: <netdev+bounces-157264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D099FA09C5E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 21:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DA9188EDF0
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F03215049;
	Fri, 10 Jan 2025 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="j2I29u3e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A320DD43
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540780; cv=none; b=We/SzRA97Kbv/jwENqF+Z3h39Ax2H3MvZOx0Xad44GjlljNRDRB4bw16Ee3NXbQtELNlNl8gn7JQsMfHa+CnhsgPAFwVaaWFeuGQiFvj0yvxEFC4akm34lwYBk3XpCHM+RMA1KN02Q+FHrc8H2d2sMC1mZHCvj/W9ngMtQats3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540780; c=relaxed/simple;
	bh=Xo0gE3Mz2ABxEjO3uSGnAnsv0P4c2/27bA2L41PyRFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IuoHAA/LIfXmHFQ6MvGi16TokiZNxVrmEzc1cZIgD2uoWMpk8AA9LHUvzBmoY4Xq4HDUQHQknT26n4Y7wJfUcE4FhPV12Il+3wNlQ/URzKb4dstsRQi4+/BUe07382vFZMbP+G+2ZT4EZl4mtiGANbXh4GpawpJc/WpBEUYR0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=j2I29u3e; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2156e078563so36609335ad.2
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736540778; x=1737145578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NgEKaAYjEQkVoq1sjh2PN8hyqxTEtZd69YDO7/mBq+4=;
        b=j2I29u3eS7X6z+knDUc0D+pHGwg3eWA5DJeDSyHUCgIwT8g0WQVEIbxTtCCb33QWut
         daT7CA0Dmk1cWfGMcW3chr2C+StMD/M4HSBqUQQU4YD0/UJjvhORtvpbjKCxe8QLn3z2
         kAu1gCV+XOGLgPeZq+BTrKlUxW+ceeS5kdtzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736540778; x=1737145578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgEKaAYjEQkVoq1sjh2PN8hyqxTEtZd69YDO7/mBq+4=;
        b=iOye5N3MOcI1Ry+EPlz1If9SSsmX9oBdp/q4y36nnaDn+0Av4g6ni0DUnWypn/27jd
         oxQN+nP7lGueBiZ7yZMdzoNl4lAzIIlT2W9XQJ8c4sCmK0C2iRBIDDmsF1s7GotTcU/i
         JQuwfzFqIPRCSpG4D0GQWNfn8NIH8D/uTWgzjmYYCDdX2zYQEkE0uAaoZXSCGXGq1kVF
         cKJVpGxntKQMSBSYRX0nn3NQCZIg+U1fEleqmQMAq9ujj3/QxH0noGtXfbMzobK55WJn
         +4RrBe3laljH4oR6xpWAvqQdYpDr9vDYC1QzG/ylcJTzlCx/P2g3/iyPSLhYomvtK23A
         T0Vg==
X-Gm-Message-State: AOJu0YyXxk75VMLJ8+UBv3SdKOjc4qkfnQfhL/D5L1XZgamXvUCd2YTO
	QtMPqHrvohN0q/SS7adl68FRrv1fCOI3I0JwNTAkV1UQXYa7R4Mhzg3Ar26lYsTGS8Lc744OUVG
	4F5Iac+xTjaF5tR2iPci6piYM0nlzuB/JKm+ObISdYZ/SfH+2gvPS4FgNfFGikApwhYkYopKzyo
	y79dao4NGyYomxspMoMl1thKtdIpwhVV956Sk=
X-Gm-Gg: ASbGncuUgjnpNyhWzDOhGQh3FfMOAsjGUzltg0H2YzKWQkJQ+06ZvXqjEj0q/+rNrMI
	LPecz0HWT+7WPrIvBa4qFH/zTTr6fuxoJhsbZYRp9LnNx/SqPB0OzqJRoCsMepp0Lj+KVzDdPSe
	wCwVXMJ1235vPso6mkm7pQk86eh4Bt5tGUDMmXlukPFNbXNqM8ykAGimFuQMiWYN2jV4F+fOnwx
	K1aKMFPveYoEUerxa9g72Fu8z8RTtvDJaNVoQeznwda+Xi2DxMfsh7VgZonkkZh
X-Google-Smtp-Source: AGHT+IHjLKyND/SFeTKqLeqcEkuKAdYPWdTMIhriRKuPFfdIBg2wiJFD7YroP+PiW7Hy24jWiDFI8g==
X-Received: by 2002:a17:903:1109:b0:216:48f4:4f1a with SMTP id d9443c01a7336-21a83f4bfa8mr180322945ad.16.1736540777654;
        Fri, 10 Jan 2025 12:26:17 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22eb8esm17091825ad.166.2025.01.10.12.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 12:26:17 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next 0/3] virtio_net: Link queues to NAPIs
Date: Fri, 10 Jan 2025 20:26:01 +0000
Message-Id: <20250110202605.429475-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Recently [1], Jakub mentioned that there were a few drivers that are not
yet mapping queues to NAPIs.

While I don't have any of the other hardware mentioned, I do happen to
have a virtio_net laying around ;)

I've attempted to link queues to NAPIs, taking care to hold RTNL when it
seemed that the path was not already holding it.

Note: It seems virtio_net uses TX-only NAPIs which do not have NAPI IDs.
As such, I've left the TX NAPIs unset (as opposed to setting them to 0).

See the commit message of patch 3 for example out to see what I mean.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250109084301.2445a3e3@kernel.org/

Joe Damato (3):
  virtio_net: Prepare for NAPI to queue mapping
  virtio_net: Hold RTNL for NAPI to queue mapping
  virtio_net: Map NAPIs to queues

 drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)


base-commit: 7b24f164cf005b9649138ef6de94aaac49c9f3d1
-- 
2.25.1


