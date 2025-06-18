Return-Path: <netdev+bounces-198885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E24ADE296
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2ED3B32DA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF021DE2A7;
	Wed, 18 Jun 2025 04:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDXN4JPS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011910FD
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750221299; cv=none; b=OeEF+ZVUq2gtR2jcKwZ3g4TwLpCYF0gOM9QwnY9rP5JRfwmfQvyxu0Q1fog5RP8f68Mlmil+Hfk8+70ELbBt3hYNgG/3YPiTGyH14iEUqnxgP3kSp7O7H9FHViSzfUa/tJsn5TTQi3hueqgR1eTusOF6SOiVMxXGxlbDGibL7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750221299; c=relaxed/simple;
	bh=qX2wFgyeDcOxdhxD6bgAyI3KmRFFTOFLudPKlHWzuGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5alI0SolBUgctEt2oW5I+ceniK+BCX51fgsHRa+5xBZSCphWKEP6M/W3i20F520O1im1YT5k+w6zaZsGRlZI9Et0L2I8Unjp6Nf8XO50aUtKcsdpCG0JSo/pHorhHNI0SRBlKjWFv0qTiDcH6UGxk/ZjiqZMqrzMFGbd4HNQlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDXN4JPS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234d366e5f2so86166385ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750221297; x=1750826097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ltme1xW7z/JhRf2Ansqk8tSHFOLlMXnqdnvlBrPYXrQ=;
        b=hDXN4JPSo8YarCWt/Wpp+Rei5H2y8etqBCTLwSoxe1nZTsIM5rY2+tU9kEfBAKZ7H6
         L5OqT562V3NPNa9YqeWMzwLzZ8HFIAcQ89h6YDwcqOyYpw0u+3Kb0rgMeL/7V6zF69Na
         KIVjkbqpse8mXeHaneNNMx60TNoxoXqksW6I5lfhsH+VrslGfYWtp3+HqaS46fVy9rHA
         eA8Hj0hTB7PEiPiZ7VdpRfrGGkP+Esdxvm72MlM5ZLWLLPJy+QE9w2aR4iF6XWgn3pnr
         /NzGBCxbC4fo/iydR+cO3dmTiIVmA7yvYoC8QtVoKXMPb8+smuRmJoxF1unse6J8Glgc
         6gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750221297; x=1750826097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ltme1xW7z/JhRf2Ansqk8tSHFOLlMXnqdnvlBrPYXrQ=;
        b=Qji9l7qbW8eprDOTXMojxKWH/ntKJ9hMOZXmdRbJ968SDGUvBCiTEoxrOQYCuDkCvi
         74W5o4zXhoppXzp4qT3FbqTczhC9i524pYQScMb7J+vWK4NmAwGwOVpakpgpcFTeDoVt
         H1XvYD9uzeDKIOXPUaKRwQ2FhjryxgUml3k3enU9Kov0KVUHwytW937R8VPOs0Y6tPCd
         q3QGV797G9c3Z66KUUHfZI/cmW20a8LYsPm25t7Tf6iZNPBM6KCAmArseN17SWI4nQg+
         TROczByPP3ATZLLhTC0BIlyCbwBf8yltinkSLbt6JKy+/lRQH3rcXIR8uXfd4HB1ex5N
         qt9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGxbq3BKfDsuoLsa9YgDmCQnOT6X6d3uvr7Q+vhjduk/oNeoyXKpDnRoBk0FidQUkbZde3KGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzikxtnYNX/L96rfD/JysOebMk0hZwSo8lNVzVWrDLtH5/kKOfJ
	wNDpTlo1D6UjctPa4aLit43tGR/QevzHCjIcKPeaC+cj+8ElGnPHTyY=
X-Gm-Gg: ASbGncu8XvPatPBFDkA0teLVSwUm44qzFbWOYacnkFQsR5nsOSXrITnE5o/uvERl6Sx
	IxrdqU+uz91RwAtVfAOzVF4kyWLf5ym6i96m3Rn+QxaS1XpcJGicFu6257gBUGIxb+UjigxkAJu
	gFLDKtdBcGiBQBHN+Y0hLt1fhqX+Q1BDq25WfEyCndu0lWKnsfDhJXwSkbLlsVd1vIYmxNabfqN
	j3h9uP3m4rNKKkb5LzuhasktRvkj9UuD4tcR9eMhBLo7qGM1+9aDnWhswwoO3bQggMmKb/u87f7
	GSKbIKMnlabo9U7qWerMzKSWN9quX38zR9NTwW0=
X-Google-Smtp-Source: AGHT+IFWW0KoZ8sqjZvwqltDtiQh6ahs+12kGgC9eSbZ84Jv6OE6/fdfgV5rFEuxXH01v6ilv3P3DA==
X-Received: by 2002:a17:903:b8f:b0:234:a44c:ff8c with SMTP id d9443c01a7336-2366b329f71mr210507975ad.18.1750221297453;
        Tue, 17 Jun 2025 21:34:57 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de77610sm90072225ad.135.2025.06.17.21.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 21:34:56 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v1 net 0/4] af_unix: Fix two OOB issues.
Date: Tue, 17 Jun 2025 21:34:38 -0700
Message-ID: <20250618043453.281247-1-kuni1840@gmail.com>
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


Kuniyuki Iwashima (4):
  af_unix: Don't leave consecutive consumed OOB skbs.
  af_unix: Add test for consecutive consumed OOB.
  af_unix: Don't set -ECONNRESET for consumed OOB skb.
  selftest: af_unix: Add tests for -ECONNRESET.

 net/unix/af_unix.c                            |  29 +++-
 tools/testing/selftests/net/af_unix/msg_oob.c | 142 +++++++++++++++++-
 2 files changed, 160 insertions(+), 11 deletions(-)

-- 
2.49.0


