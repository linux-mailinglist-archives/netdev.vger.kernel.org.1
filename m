Return-Path: <netdev+bounces-144200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128039C6009
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4612895A8
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0714215C4F;
	Tue, 12 Nov 2024 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SJar1CkO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4894C215032
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435247; cv=none; b=eYir+YTWs2aNlzefm3m6vATH7zjll7gD2ul4QmaYovgvWqvrRFbJPJLWn/AHw8Sif7e2gYS5EIYeSEukn+Uzo06vv4GE7pL1u809EzOwePdVR9jaZVpOzSXJplJPVbXoJ6u/TOgRgCVQW10z2PSP36ZUBmnARXIlG1zTKZy5oG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435247; c=relaxed/simple;
	bh=NnS3z9cjJO4YVqFtXyK8vlkgipp94VRvCIu13Ove+ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h9c29Zgd13cmiL9vRQ2stuKbFC333JQGrZOmlUwgt1uDsZO0LLyOHPXJqTEi0iNTt/HWlc02o3YSpFMV204UgALzB/SYkFo3WnPbXMUorENWOYyolD7fHw+tzcC5//I7xRlsuCaO4861QHA8mU+kx9ze1p2Ah5l62JCDRpBs28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SJar1CkO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e9b4a5862fso3428567a91.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 10:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731435245; x=1732040045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9zyCwMmQ+AOfjAIucv2tsOp1yqEzPx8WzSjLaogOjsQ=;
        b=SJar1CkOGRu34m7GNTX6cQE/0GpykZ70hqdGuq3Bl8hvcdHHIneU4KsBXzqd21BtVB
         0jgTa7GkDwT8O7Y+Qa/DK/zqhUAyXNXYusQqaQi5JT4SKlv4pMfO/DJTF36u/NIAYIqy
         HF8oaW9K2S1nkwkXLdAL1Y9nCZjI9Ryabf3fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731435245; x=1732040045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zyCwMmQ+AOfjAIucv2tsOp1yqEzPx8WzSjLaogOjsQ=;
        b=UmfIals3/082hdkxTQHsVgIrZ4IOg75eJ69yjQD8mKt7wB+uOvsMHLrPCkAdHnwJ0t
         H//CaeFVSttL/eQT3LjTZrLPW1ZYaOEQcfjyUebcNNg+zXCNo3bpT5raEkK2MiJzk1vJ
         h+/ih7FleRsnCWowvOU0LF6CdFIeHmOnsBjKriO/JmVKvST3AloBpxBRvha8dtiw8GV/
         m3WLLbr/G/uzEcsI0K15vcQNHkMY2pfnE3CtIYZ0YSRXu97xJemtgIgz/i5MW9tl3M6G
         3ylnhiW8graXxTGS22Z5k7hopXFLVhqQ9hzOx6DT4IbptIK5rMOAwVjTYbnJJo1nY7tZ
         NvLQ==
X-Gm-Message-State: AOJu0YxmZcicZPTxf/0zqsuH9cYVXQfoIneB6s30QD2UMo/4iWnp2x9Z
	ZCK04Ao4hsbJDnZyKDdDGdc9KlkI7WkYDMktiXlVdtlmUr7r2d+4F2zcquJjNvcIgLYwPY7Mtd3
	rGfn6RxFDj3DOLdcYJ+o0sGDQa6G34I4A4FgC9FFZ5redBK8gZzrbfivxy3u4AblmXc4LG0bss8
	vdK6FI5Px9mToSj0BW6JTmf3RVS4zrnpnLsDs=
X-Google-Smtp-Source: AGHT+IEkChb/NIc/aPAwj0LhBa0qze4BdB189g+8/DvsjWtht40fTFybAU5utfvaV6IcyGcYLp5l6A==
X-Received: by 2002:a17:90b:2ec8:b0:2e2:b46f:d92a with SMTP id 98e67ed59e1d1-2e9e4adeecbmr4630263a91.14.1731435245118;
        Tue, 12 Nov 2024 10:14:05 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6a388sm96639035ad.245.2024.11.12.10.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:14:04 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list),
	Mina Almasry <almasrymina@google.com>,
	Simon Horman <horms@kernel.org>
Subject: [RFC net 0/2] Fix rcu_read_lock issues in netdev-genl
Date: Tue, 12 Nov 2024 18:13:57 +0000
Message-Id: <20241112181401.9689-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Paolo reported a splat [1] when running the new selftest for busy poll.
I confirmed and reproduced this splat locally.

This series proposed 2 patches, which:
  - Patch 1:
    - Adds a helper function to reduce code duplication that sets the
      error, extack, napi, etc.
    - Fixes a similar issue in an older commit and CCs stable as this
      fix could be backported.
  - Patch 2:
    - Uses the helper added in 1 to fix the recently added commit that
      adds netdev_nl_napi_set_doit which is exercised by the selftest
      triggering the splat that Paolo reported.

I retested locally after applying this series and confirmed that the
splat is fixed.

Note: I only CC'd stable on patch 1 because that code goes back a few
releases. patch 2 is fixing code merged very recently that does not yet
appear in any RC and so I've omit the CC for stable there. I've sent
this as an RFC because I am not sure if that's the right thing to do.

Let me know and I'll be happy to re-send (after 24hr) an official
series.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/719083c2-e277-447b-b6ea-ca3acb293a03@redhat.com/

Joe Damato (2):
  netdev-genl: Hold rcu_read_lock in napi_get
  netdev-genl: Hold rcu_read_lock in napi_set

 net/core/netdev-genl.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)


base-commit: a58f00ed24b849d449f7134fd5d86f07090fe2f5
-- 
2.25.1


