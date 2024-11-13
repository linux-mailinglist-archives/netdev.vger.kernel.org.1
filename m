Return-Path: <netdev+bounces-144287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFA69C6728
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A5D281B50
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9C6135A4B;
	Wed, 13 Nov 2024 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Sl0lysDR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841129CEB
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 02:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464289; cv=none; b=SiId1mxvr5kKkfoRopZqRpxD6qHSiNql8LmrAsH8nEObRPmVTsHAIm3x0YImf1u/q2gdbFtCj9hvsNnhU+bLVSJzk6/3tkFGgH+tkkvIMCLWTyatX9B5nrmq0XVgmUkZ6pphQSCeC/Ec4Z75hyTRNjIShuL0GctJu/5Wlqcw2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464289; c=relaxed/simple;
	bh=bYY6Kr1keYM2g0w8UAmOSNl1C18medULvLG9mdvugq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upHyxZT8+YiWfEIyT10vqbtXl6lchwbmPPt0UwksugR2XJtYWySIuYof6hhW426S0TCtpBU4PLFJOSByHj5fdTouhlHA2SNXqZHvvBTLSz+WQjDRezFUsFoXqu12yWfmVZtpGUZdZWJ6kfyr+h6PCG8Ej3qeFhKnjr6L+SbFVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Sl0lysDR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720c2db824eso6901908b3a.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 18:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731464287; x=1732069087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZhcOiO1OL6G128/5sIoHfk0z/KZCSiTiT9fVhK8QHo=;
        b=Sl0lysDRutLXowKJ2tgrEaUAZ4+3x6HlkJ4KL9zBYJlZUNSfZjzXFdNxOti+xzMmY/
         eBkK0xnH+jtpjmPW5ZJLp4M5XG0BpRHtADk1EwrZxWtF9L6XKBjF/03dDVP+6rTUTCoM
         yVONEWhHOyv2KRpQBdkOw3rppbQNO2IP8pUzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731464287; x=1732069087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZhcOiO1OL6G128/5sIoHfk0z/KZCSiTiT9fVhK8QHo=;
        b=KYgpKK82EwX+pR7HOgnUk91SC4vwDUdspMlgscQIqOLvdSZcR9OC3YPaHJ/EuRhSgK
         E3LovKQn5fCOIx4HyUURVcv1OqAwI6KdHKvgfc4Kf+R70Zd1kylBmIML+z0WMtRa5dtD
         96zXPU6G2FO+xmJ9KRzV9Dh/pgmuDOoi9jAaz8+6gM5JGbwSOwj3Cibyw3p0feBJylnH
         iz+ooL4y8caK4ANgTnDwg5g+4dZJjJck078JrtS7vH4Yplvd0f4ClV5FKQsfs+obtnpa
         B7+FrA/omVu+aat6M7aT27WEBqcZgKf9wrd98iX3VAoDRv6TQScHDosMXjArjFYfLZBG
         hQpA==
X-Gm-Message-State: AOJu0Yx77EzdJwyYYdh4fwtwQ2U+8+1WRbJOvy2frzwR/3qUSfH4B9Ij
	H4/RHmIxPsjP0+dlBnKN1ZzvTkJ/Sutzp5kXoEbtOgeg3ROBZ6QIWZSCF+vPMCXUNwYfX67H5qn
	W1PaGKKQR73oGVOUGb7hutAP/lRR4xyjvPcdrmEzA715howr64NNJhOK91LXCTlvGjUyQiYfJbB
	SpYVyGuRh5kBzEmF7vkzv6msL8mFjIDh20nGs=
X-Google-Smtp-Source: AGHT+IETlyMcrnozssH5GbEDo2MXOTQ8l2MhvBV2fEi+srfyvG//z3dAVJxhIkY1vdipmlGEbnp7MQ==
X-Received: by 2002:a17:902:c942:b0:20c:5a64:9bc6 with SMTP id d9443c01a7336-21183d9d8e5mr246698805ad.50.1731464287142;
        Tue, 12 Nov 2024 18:18:07 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dcb1dfsm100209505ad.14.2024.11.12.18.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:18:06 -0800 (PST)
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
Subject: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
Date: Wed, 13 Nov 2024 02:17:50 +0000
Message-Id: <20241113021755.11125-1-jdamato@fastly.com>
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

This series proposes 2 patches:
  - Patch 1:
    - Fixes a similar issue in an older commit and CCs stable as this
      fix could be backported.
  - Patch 2:
    - Fixes the issue Paolo hit while running the selftest

I retested locally after applying this series and confirmed that the
splat is fixed.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/719083c2-e277-447b-b6ea-ca3acb293a03@redhat.com/

v2:
  - Removed the helper and simplified to just add a rcu_read_lock /
    unlock in both patches instead.

rfc: https://lore.kernel.org/lkml/20241112181401.9689-1-jdamato@fastly.com/

Joe Damato (2):
  netdev-genl: Hold rcu_read_lock in napi_get
  netdev-genl: Hold rcu_read_lock in napi_set

 net/core/netdev-genl.c | 4 ++++
 1 file changed, 4 insertions(+)


base-commit: a58f00ed24b849d449f7134fd5d86f07090fe2f5
-- 
2.25.1


