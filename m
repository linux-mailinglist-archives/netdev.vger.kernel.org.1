Return-Path: <netdev+bounces-176933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E018DA6CC61
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 21:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B397A2DB8
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC3723372B;
	Sat, 22 Mar 2025 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tel4EGsR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C0175A5
	for <netdev@vger.kernel.org>; Sat, 22 Mar 2025 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675780; cv=none; b=q9jOOVTrueaHLe7B3GVomHNWnd516ROQF7X2X6F10S9o3v1TbGC6FHZ7KseIGphPudCIlzYaYKYL2ZQgLqaLSHpDcZIdtT4zNcb+jO0w5uC2NHzYs3Gx3EMSnFQ0eadl7OP0ieEeNpcbEcaXjhAIUfrkSE59SXa830tkiVzObHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675780; c=relaxed/simple;
	bh=/zm0caTFpa5mQQPIid8qQMt0SVoU13C1ydN1hUjgYNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1yX+V3w4gDVS1oRxRJx+6pj7mUdgXtne3yTUBw7fENi4Ab8dPU7oYvuBLqQcZ5S2u9JzH7T6lg6xsaTytFV9Gq4kZA61yVqQs3ZtS9RYqyWnKeBcex54yi89gxr769sVi6B2ny6pQJ2tT/jVQtpMq7H11sNdtYPuF4x3Yl2O9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tel4EGsR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3014678689aso4396769a91.0
        for <netdev@vger.kernel.org>; Sat, 22 Mar 2025 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742675778; x=1743280578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBCRJIfeoI4+hYoyENJ+XtmGOK3o3ECSkLKYl4KE6xM=;
        b=tel4EGsRZ9i0Mp5lyCT2l7sHMN8qBGw4+M31Xa0xkDQ+MbR0Zq/7ldE15b6VMKOSA9
         cvxrbjEZD0+3cV8XJwRroptZPoeFkcE2ggo2nEiZI2orL+MyyHj7TZs7D1qfi84bZJIM
         4Dxen3IrC12Si3RWJw+8bKQ8M4KP1iFajXpEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675778; x=1743280578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBCRJIfeoI4+hYoyENJ+XtmGOK3o3ECSkLKYl4KE6xM=;
        b=WFqUjYgmJxuxoAfntniPEjDgwGSWhC1vBYwNhD2OKPPu8pvyNno5j7ES979JzDDkTW
         lgwRPrFNqXBw/oRFhgdn+HMd0l2cmnGlRwZm8tsLaGkzoZS8H4fQbYXsNXhKRfYBzE5t
         CIW/0Bu3cOGKGOIwL3ZDO0flk99Pt/czBvUgvOpyGe6kwLQZGY2cMwqeImA5t0lzxzy6
         9Az8iO/MZizVB7z2TkT1bMJ71uv8iZ+PkDJ/6CX7ETIWUMa9RFjt0gWvL/ALRpXjL2lD
         nsQDOhAzfI1FZTp937mOI41eX0rBEuRW9/RJPfCUk5GMbOMf6z8jEEHkJVly8sGqDlTZ
         foxg==
X-Gm-Message-State: AOJu0YxqxeiBflachldXuup3mDo7t2CQl4QGC9c27ghw3wbVKOuK8Jwr
	j61E5zkYNbXFD/9gKLL/hB0U3ABa7U5C/lU9Dyloeo8edwd0aeA5c+qynyf2tLo=
X-Gm-Gg: ASbGnctiIDbcCXZYx1dyjlFzCZw3VFKTGgJ2FEKjVmKnQGBg8tBfsKA0q2WzPfVTz7R
	R3EksL3QB7M8J0aoxhI9wvh0lbW/dkziP/s2YNMeROMPu+OIjEUzP+xkc2Fs4nC4ZC33rPvGqgE
	NroqG7OBRHTcGZJDSazTzFt99exWlJJphm9NVgYgkM06UIEcDnsPxPh1hos662JR9jnB54smiHE
	0UnhT9AQxXROSb8wM7yhu1DR5wWfGvB5QuMjYk47J3DRrp06vdxyv5Z/79IzKvxMmcT1tdxOF7e
	RIOVIIj4qv4AqQ7MPQ6ZLdHVFhonoIlNiSOerYkD10lLS1G3j3vmvRSnWp+T+0c=
X-Google-Smtp-Source: AGHT+IE37OrujyxGFgxAEo8ctQ3AWaU9G2PByR+MB79aOMDqG+16a9oIBZcx1WW8S9MeG/hspBAWTA==
X-Received: by 2002:a17:90b:4ccf:b0:2ff:64a0:4a57 with SMTP id 98e67ed59e1d1-3030feeb744mr10822043a91.26.1742675777943;
        Sat, 22 Mar 2025 13:36:17 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a579sm8711798a91.32.2025.03.22.13.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 13:36:17 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	brauner@kernel.org,
	asml.silence@gmail.com,
	hch@infradead.org,
	axboe@kernel.dk,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH vfs/for-next 0/3] Move splice_to_socket to net/socket.c
Date: Sat, 22 Mar 2025 20:35:43 +0000
Message-ID: <20250322203558.206411-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

While reading through the splice and socket code I noticed that some
splice helpers (like sock_splice_read and sock_splice_eof) live in
net/socket.c, but splice_to_socket does not.

I am not sure if there is a reason for this, but it seems like moving
this code provides some advantages:
  - Eliminates the #ifdef CONFIG_NET from fs/splice.c
  - Keeps the socket related splice helpers together in net/socket.c
    where it seems (IMHO) more logical for them to live

This change is essentially cleanup; no functional changes to splice are
introduced.

I based this change on vfs/for-next since 2 of the 3 patches are vfs,
but I am happy to rebase this on another tree if necessary.

Thanks,
Joe

Joe Damato (3):
  pipe: Move pipe wakeup helpers out of splice
  splice: Move splice_to_socket to net/socket.c
  net: splice_to_socket: RCT declaration cleanup

 fs/pipe.c                 |  16 ++++
 fs/splice.c               | 170 ++------------------------------------
 include/linux/pipe_fs_i.h |   4 +
 include/linux/splice.h    |   3 -
 net/socket.c              | 140 +++++++++++++++++++++++++++++++
 5 files changed, 167 insertions(+), 166 deletions(-)


base-commit: 2e72b1e0aac24a12f3bf3eec620efaca7ab7d4de
-- 
2.43.0


