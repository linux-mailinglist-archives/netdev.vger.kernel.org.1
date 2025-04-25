Return-Path: <netdev+bounces-185815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A80A9BCC0
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3511B3B9837
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FEC13C3C2;
	Fri, 25 Apr 2025 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="XKEhbJmG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10FD42AA5
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547653; cv=none; b=l4LyPuquMeKOOZGKIQ2rVIQZ89vgdtZX1jipMPalTEAlMJM6n4jp1h3vqQxrnP6heSaMXVJTOCZ58b27Edq+zoGLcnt+OI08UtbNh+gl1buCSrwrvs2PkXD21SOc7c2z7nQ+sfgzgN93rg5QOfOJ2snA0DlXTLJwE+JXdC5GBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547653; c=relaxed/simple;
	bh=AOwq4wKCyUK1h6HBYAptAc8HgADuYvqYJbho9lfnZLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWqbCNKniMxi+M2oNmcFG3YC8VfRe8L0VNE2WCmL5b4IQg2JVsV+HQO4hd9UHh0Wei2pacz6kOC1k6re3ZBZ5GYHeK6Gm9TzEElyEtBbCFWbNxQx6ViYbOAC+LcoohkPJnH/VBM1UFfsVsnX7qKrMiWylxyBSkmjx3xdhu4cSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=XKEhbJmG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224100e9a5cso21676015ad.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 19:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745547651; x=1746152451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXddNb1W6KK1jprW37xYlkJB4Qlcao/SYuYblDCnLhc=;
        b=XKEhbJmGGuiIPDnnIC2+HUXaqgGP7AhbcnWLRNjrK1DqHP4bVydNW5/HumMlvM4vb2
         o6l5kzRTg7548ufNJ+rlVRMUTc+a9i5hSild1pXuXsITnH9EEQpSl6zZ8JEdtbN93q6d
         0rLq+By3cL2DH2LhRWRcLNOE9nAQvLP/SrfI7wvaQo1tpzMPJr/NsEaVEpDX6BRpzEdh
         8ve1c9nlIy+O8huqkXe1Dkp9YGbZ4iAfsx3z24nPROOmX1rrvVV26EGAII+L85yg13Lv
         TI86l5z2jER7YV+wwKUMZaK+fyCJNyjxGvC8GTzcKCGQxKb3ee584lxejQhjgRXNX7fq
         2wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745547651; x=1746152451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXddNb1W6KK1jprW37xYlkJB4Qlcao/SYuYblDCnLhc=;
        b=YNOall/l9f7bITwATjq7c5oHVQWMMNgTjCpUGtpVjRqrlJNoRQdP2c5W/6YXEN9ZrD
         biCSN8LpEMHQDJsaIjCu7dJxtWHlbLVi2laQdsz8PLDty8ws6z97UeSj9AKAISwaGKGy
         qjidvH2BCSAhHLJAXnvUt49nHgjIJCXqlLz/qp/dT+CEsiq9LS/PqmwcThLBSKZnhgYC
         2wp/lFrRJTwdhUGcNj/YHLg4tea9lF5CxVazQnnCstvj8knAINEY6sVY8jip+aLKyf5q
         Z81CWQfX/IG5a73I+1fCA/1azFIYpoEXi15I2e433yc/Dl2Xd4OlBM/Yz+v8f/YN3hdh
         xqPw==
X-Gm-Message-State: AOJu0Yyn7HVJMDr+f8t5JeRHboKkUE9JCm/kboBzgzrnralZ2USbp2Wc
	4+Jl7ouqtGD/i/0/eirJkqt5vE5+1v9L2+ZZTR1tJLz08b8RzBDvQyz9TjF+FYfe9evhpqp8NFF
	0
X-Gm-Gg: ASbGncvWxm9czqjPwjw6ispThQl1LpJADOYX9rRoDeO0RQyKPPIm+66HQlX7Wx1t6KY
	RCde2oq4zWnQDb0pfQAl6wgjaI5X1ciUdkrTMIvPLyYIWULp0ShelTE0cDuUAorwrHC1U+ejzeM
	j1aSoDksKNQaguFfiXcG1n6IscfKQqiYH6VwU3joyxdyZqmw4RP/CQDzKKxzlGvU0CVtGai77Sn
	ySC2sNtmp2vr93gfOhVORp4948Zzjp5EDuoMMtGBCtHG6HWNeByZx+8uon61LqlEUqja2HMZ0Qk
	K2pFbQP5ezB9LOjxfcGtLeulYw==
X-Google-Smtp-Source: AGHT+IEbrogwlst94EeCj01TJoQBJxE40F6ZRJgyPm8bfwyLaN5TwxVOKKz0RV+tUpNwKs4IPGDFrg==
X-Received: by 2002:a17:903:2445:b0:224:2715:bf44 with SMTP id d9443c01a7336-22dbf5ede35mr9328385ad.19.1745547651009;
        Thu, 24 Apr 2025 19:20:51 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f754fed6sm387140a91.0.2025.04.24.19.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 19:20:50 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 0/3] io_uring/zcrx: fix selftests and add new test for rss ctx
Date: Thu, 24 Apr 2025 19:20:46 -0700
Message-ID: <20250425022049.3474590-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update io_uring zero copy receive selftest. Patch 1 does a requested
cleanup to use defer() for undoing ethtool actions during the test and
restoring the NIC under test back to its original state.

Patch 2 adds a required call to set hds_thresh to 0. This is needed for
the queue API.

Patch 3 adds a new test case for steering into RSS contexts. A real
application using io_uring zero copy receive relies on this working to
shard work across multiple queues. There seems to be some
differences/bugs with steering into RSS contexts and individual queues.

David Wei (3):
  io_uring/zcrx: selftests: switch to using defer() for cleanup
  io_uring/zcrx: selftests: set hds_thresh to 0
  io_uring/zcrx: selftests: add test case for rss ctx

 .../selftests/drivers/net/hw/iou-zcrx.py      | 122 ++++++++++++------
 1 file changed, 82 insertions(+), 40 deletions(-)

-- 
2.47.1


