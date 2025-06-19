Return-Path: <netdev+bounces-199308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2033ADFC42
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8203A4EF1
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 04:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF541238151;
	Thu, 19 Jun 2025 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vywo7rLv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91723BF9E
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750306503; cv=none; b=A0gG2o0YxCvV9mY4mPhMRWAp83rpRZfGiZ7FktwgaAJyp5Y8RjN1ASjY84xZQK2w71AQf6/u6n60XRFDp6+oIubnQ1nTXT6Wa20DshTQZTrXabUljLwNdAFkOqUPy1ibmjb/FFTZxHvx6huj3uDt0I6m1q37J3tv0QOyDZc3mY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750306503; c=relaxed/simple;
	bh=rc+zECxNWT/7NQRBtry6HvQ5AIFBQNMcEqJVYK+lJCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lH4eqxn2/e3tlf8FS9BeGIAnf3WEwIqt9s/wuCbQWfWHDedktnMPw1J15Gd9hSvubE4bChWgFiCdIMOQgpgW4B5gorhWg/O2mn4yLro5qclaJzSO5aFOQle2l5k69ykQs1Vy+B/g0FtpM5cAa+VJbP+aRRyDJkEQPzkp7MpElMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vywo7rLv; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2c4476d381so241528a12.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 21:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750306501; x=1750911301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X51fVzkyzM777UAZKFNgobT2572fwvti8yjBHd1ASz4=;
        b=Vywo7rLvDzTmiIljhjoDPHGEJ8E8dC/XPgZ8mYgVZhH3ZaI//sESFLRyiU1CiY+U2a
         SBTlo7R82IEelWyzJW2KNYCKgF7RegVG/x71fQ+9aw7e7K92i8QBhcLlNAPM7GAEF1AP
         L4kKVSl5TqT2c+RBvnjNWGmMt/8mlWFt6ggbJ5parDgiyMJHOEVSW4ncQhyE0ffBHPAV
         vHcCR3Wov3tzHbZS9ZdnaSrvrmjnyLzT3xRESNXdUFUWEOOBWXfWVOaGr3B4A2kFQQg4
         Zz9IMYKkQiXBACOBA+8X3NxHXzLGNoyo18v8f3ePMsl1lSVuPzReta65zHZSpvykpmpB
         5ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750306501; x=1750911301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X51fVzkyzM777UAZKFNgobT2572fwvti8yjBHd1ASz4=;
        b=bGsBmhy/vKqf8cgi3MmqcGQQYzTponQH0R58LBeV9IovOLUOA4u101sAvDNRgkavhg
         /n11BQjZ2yYqAEK7scoVv1sq17zE9eGaD4hicE4VabzZ5wTkzPkfQbUdKgTYNiCiNaqc
         k0LYdLKfuWmZo4/6XNF0G69zLIc7G7MMyon4TjVSiqkW+7ANPwl5PEMpTBR9Q9brCRjj
         RNqiX1RfpEuFazPskqRic0NQv2TOlYcBJiEcUceDcl3olfZVnKVPGmAkn2HQ5phu64sV
         3rjpI07qzdzNYppYprm7iDr0LWdxwxQhGRz+KFs5IkO17/xSAG9RlcCrx0VfKWBR/t3K
         ylcw==
X-Forwarded-Encrypted: i=1; AJvYcCUqqxEPe4pMF/YUeTNSvWo90p8CEl+iB2UL3MdIZTZwxraMJRb247zW63bXrsMQd5pu4lGuq4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42d1drUBgHXtQ0gUUM7c6Zjni9kbwKS9HaZysmTTaMSnbMcwk
	yEhnx7916VBb60a7nYzuN5DZ9x1/16yqCpGv5HOH1blxQ1bPkWeAV9c=
X-Gm-Gg: ASbGncsta6RFztrPNLS2mLCrBPfsNwaM8GPlOFDuhootADr6SJXy+Z5MNs5DetArlxo
	RZOMewNpC6yQ7sjtoRA8c5TtWrcfbonWoVfFy3dMoq1aa8cWYzLhKUSDJXM4T4Ymsuhy6/BY7oB
	bgIn6gMijZ7a27TnRpRnnghl4rJmp+/TdmYOFEtBTwhUr4zcIOik0sA9YBo/8Xfs1fwdX9cWxI+
	89PygLM3G0uHlkqatSoxRb0Titeg39S5BPORi14bKmX6423k6k/A94CdxqQrM0LrBj5Uf4iZxC6
	zfPY3+s9fbAu0DrOjLNDCcMPE3uGiqoNx+Mo0m4=
X-Google-Smtp-Source: AGHT+IHt7u8EM6J9YCvbMgCAkBEiTDBU+RfxZCuUdK8bRkUXbjj0D6hUVJhnSCt7fXHj7Mu0YBKDqQ==
X-Received: by 2002:a17:903:1105:b0:236:6f43:7053 with SMTP id d9443c01a7336-237cbe9b5b3mr31254145ad.2.1750306501336;
        Wed, 18 Jun 2025 21:15:01 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de781b1sm109928585ad.89.2025.06.18.21.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 21:15:00 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Rao Shoaib <rao.shoaib@oracle.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 net 0/4] af_unix: Fix two OOB issues.
Date: Wed, 18 Jun 2025 21:13:54 -0700
Message-ID: <20250619041457.1132791-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Recently, two issues are reported regarding MSG_OOB.

Patch 1 fixes issues that happen when multiple consumed OOB
skbs are placed consecutively in the recv queue.

Patch 2 fixes an inconsistent behaviour that close()ing a socket
with a consumed OOB skb at the head of the recv queue triggers
-ECONNRESET on the peer's recv().


Changes:
  v2:
    * Patch 3: skip the leading consumed OOB skb instead of freeing it

  v1: https://lore.kernel.org/netdev/20250618043453.281247-1-kuni1840@gmail.com/


Kuniyuki Iwashima (4):
  af_unix: Don't leave consecutive consumed OOB skbs.
  af_unix: Add test for consecutive consumed OOB.
  af_unix: Don't set -ECONNRESET for consumed OOB skb.
  selftest: af_unix: Add tests for -ECONNRESET.

 net/unix/af_unix.c                            |  31 +++-
 tools/testing/selftests/net/af_unix/msg_oob.c | 142 +++++++++++++++++-
 2 files changed, 161 insertions(+), 12 deletions(-)

-- 
2.49.0


