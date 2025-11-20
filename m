Return-Path: <netdev+bounces-240208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AA5C7184A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1A22A29370
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 00:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3DA13A3ED;
	Thu, 20 Nov 2025 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOIB5VMa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AE53E0B
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597728; cv=none; b=aiA7WPr/tOQH5P0jdbwxuSb26KR9gyty0DIiqQi8o5GTH41mQJBfp7QsBBus0zqG01vLk+poXtGS5Bzz+cY+jHKDVHpqIgShl/sw1e31ZhhKStxWRcF1mxdw1rJDuM/9cQ77gSEjWrIiorDqzUA5+yNu+r8eNp1Vn+O68jAn+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597728; c=relaxed/simple;
	bh=ZWbIRr7n2aoMbY8heM7aapqtIXZdjA83PeUvT6BwCdo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FTqL+l0TEl37OPJ/EzkoV9DL1vbynWpFYaxfLszzs8dBHQuG60fMsHo5wCj5W9U0D7xg75a+vVGtC3IMDxVJoDm3KQMK8SjVwKGQLvm0xj0yN+UAE6JBGXxxocaBG1iyk9pxhBbBoi7Zujn7noK8z0HF86TL3TQkiKw13q33LT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOIB5VMa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779f9696e7so40175e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763597725; x=1764202525; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGhZ791IGgFpw2D5wv3W1q8tnRzQiHL6cpc8pYhiPAo=;
        b=JOIB5VMavhMC4Avx9GGANtqlP1wnKDieHRJpH7CnwCMIOpnyTp2mDMYmmmwK+Wd2D8
         BJBrhyC3lp0eopSson9Rw9g9qSZViBbG/+Blx+5zrjh3kp/cJPWim6mGLpUIPlbBGlZx
         gFldImLZsSfgLNJDob1RPnE+uS2nLwYv0+rFUdbfdzt04kyR8o1kBM3woKLpHZDAsMUj
         YaesFnNS2hxt68TEAhHOBi9sdUvLPnPJfImqhTnvyDGF49edM522SNd2TVl0nA8U3evm
         mOo0GS0dqzSKAuLWTpzbJoXp7TzPzhtSt9WquNsntoyvRYIjCj+nBequW/zgV/cgx365
         MsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763597725; x=1764202525;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGhZ791IGgFpw2D5wv3W1q8tnRzQiHL6cpc8pYhiPAo=;
        b=OrazEjY8H1ayS3tnt4zugGcmq2dlSrcopSSo0iddDy06Rzf9uwq4i2xQsID4729i80
         ARBWxgKZG/h/bZuUnvFPQ9vqwBceZ7BBUPnoycfzM0/+iD/uAY7seC2IhM/UIs7kcutw
         J/lXG0rT3lyzn1FRBbYBwQ0Vu3lkvx+LKxJ+jYJJkL5ftvmI9fmsUceSsxXU/m6KjWx5
         sbXfcsNA8tgILpJ64RoK1wNAf+5j29SJiUKMbxCY60BnuPb2zykjF8M+b4M7e48V+DlX
         32+L1p0B88O/MiMxOyh9tXwfudbIGvtbDo7SJDre/pvaQQOgzcBGH6hZ5HT3WqfrCHMY
         nn+w==
X-Gm-Message-State: AOJu0Yw5IKEqNe8SrTUVsX6I3J7vUMb83D8+Kczq4vLcLN/07iyp8OW7
	T57Jv+m6zR7itnttqr96lcd5No5pxpFPDfaB7WwJaPVDFOF20/KN8lWe
X-Gm-Gg: ASbGncu38i2VqHB4qAwuf1CQgtMsJKB2lB5ipKCl1L+z17YHg/iJr7WDtGT/JUREV7S
	Z1tGpt6EGiTqZgmfuEqPiCw312jxXqyeEw1m9pL8vx29Z9bQGi091mXPr0Hw8kguajPlzLdUoeQ
	4G4ZAJFPaaKjndbxU81rJbSlMdvT4hhiVk3L2+ONMa+tcHdtiGZSe38Zw1pX6yGeKpGZfHNT5Nk
	9FKgwV/zGgFN5QcVw7WPriuVE919E33tt+HPBoaAEcoHuPsKUAInaA8fjWOaGOadPBpiNaaAR4D
	zTkX8u4xT4gA/Pt1ZNCJnXJqm/4l4eBAKFncmW+Sz36fwHNNF24JUU1sDcRspCj2L0n4Uc4p3TA
	CAnnqBmqiw58D0miOBvnmPjYNEung+BPJANTZkVffPbVNyHnwmCgAOTL9HXfqT2mSRMkQRvnsZj
	qms226Gsuq5cM5PkejaRkNzA/Y/hCtYrPHRO0o9w==
X-Google-Smtp-Source: AGHT+IEMTSv3dIL2/ZMldxuzVoEdRjDPFb3TccQKkSzeYDnuSagtLzuQoAMP2Jf9CdKrkeJOK/wNCQ==
X-Received: by 2002:a05:600c:444c:b0:477:a6f1:499d with SMTP id 5b1f17b1804b1-477b8d8e81bmr5154015e9.3.1763597725203;
        Wed, 19 Nov 2025 16:15:25 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4f::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b106b03bsm76258005e9.9.2025.11.19.16.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 16:15:24 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next v3 0/4] netconsole: Allow userdata buffer to grow
 dynamically
Date: Wed, 19 Nov 2025 16:14:48 -0800
Message-Id: <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHhdHmkC/4XNTQ7CIBQE4KsY1mJ49N+V9zCmofBqSSwYIKRN0
 7uLrLrS5WQy32zEo9PoyfW0EYdRe21NCsX5ROQkzBOpVikTzngFjDXUYJDWePvCXq1GzFr2uAQ
 nlAiCchhUpxpeV3VLEvF2OOol83eSlmm9BPJIzaR9sG7NvxFyny+AVb8vIlBGoeRtx4ax7Ir6N
 mMQF2nn7EZ+sKD4Y/Gv1cqxGVEB40dr3/cPZucg2R0BAAA=
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

The current netconsole implementation allocates a static buffer for
extradata (userdata + sysdata) with a fixed size of
MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS bytes for every target,
regardless of whether userspace actually uses this feature. This forces
us to keep MAX_EXTRADATA_ITEMS small (16), which is restrictive for
users who need to attach more metadata to their log messages.

This patch series enables dynamic allocation of the userdata buffer,
allowing it to grow on-demand based on actual usage. The series:

1. Refactors send_fragmented_body() to simplify handling of separated
   userdata and sysdata (patch 1/4)
2. Splits userdata and sysdata into separate buffers (patch 2/4)
3. Implements dynamic allocation for the userdata buffer (patch 3/4)
4. Increases MAX_USERDATA_ITEMS from 16 to 256 now that we can do so
   without memory waste (patch 4/4)

Benefits:
- No memory waste when userdata is not used
- Targets that use userdata only consume what they need
- Users can attach significantly more metadata without impacting systems
  that don't use this feature

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Changes in v3:
- Split calculating the lentgh of the formatted userdata string into a
  separate function calc_userdata_len().
- Exit update_userdata() immediately if we hit WARN due to too many
  userdata entries.
- Use offset instead of len to save userdata_length in update_userdata() 
- Link to v2: https://lore.kernel.org/r/20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com

Changes in v2:
- Added null pointer checks for userdata and sysdata buffers
- Added MAX_SYSDATA_ITEMS to enum sysdata_feature
- Moved code out of ifdef in send_msg_no_fragmentation()
- Renamed variables in send_fragmented_body() to make it easier to
  reason about the code
- Link to v1: https://lore.kernel.org/r/20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com

---
Gustavo Luiz Duarte (4):
      netconsole: Simplify send_fragmented_body()
      netconsole: Split userdata and sysdata
      netconsole: Dynamic allocation of userdata buffer
      netconsole: Increase MAX_USERDATA_ITEMS

 drivers/net/netconsole.c                           | 386 +++++++++++----------
 .../selftests/drivers/net/netcons_overflow.sh      |   2 +-
 2 files changed, 195 insertions(+), 193 deletions(-)
---
base-commit: 45a1cd8346ca245a1ca475b26eb6ceb9d8b7c6f0
change-id: 20251007-netconsole_dynamic_extradata-21bd9d726568

Best regards,
-- 
Gustavo Duarte <gustavold@meta.com>


