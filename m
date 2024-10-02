Return-Path: <netdev+bounces-131102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C398CA0E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 02:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB161C20A79
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6BB138E;
	Wed,  2 Oct 2024 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Qw3XJqDa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC8624
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829251; cv=none; b=PNaOedqw5deHo+mAiwp1jnqtVNHCiMeqruc113kwMpBA1nindbExgbEIcw8z+lPmmq32F9eRUw9bP/WdigHXFPhL/HqiwCBQmZ826QTUkeIzvXr9is7rAypMlSFYoi6tQFHUR5wD7Z8OgcAI9c3qq6yWBwqMAwd0Cuh++kXE4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829251; c=relaxed/simple;
	bh=2rkNPvJlxqa0CubTyPDpR/tEx4ZA9pbbhUunc9ewgcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s3dJlAcIheFNUDt9MsqzIQbpZuBHCl80UhV3RjH89plxJqcJUgpXzyTh3/xGOpleSljO990tAtiz2/iJOZMYmdt4MPI6RMtRKzV0All0zunIyChTlEuFo4QrKnclz8hLC3ibgh1l9MOxuguHqh+pB52woUHwoSP8NOawSDj2XMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Qw3XJqDa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b93887decso23453735ad.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 17:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727829249; x=1728434049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FO5R8cdqVEZ/UYrxFLZyYiizB9jbmk7GftZJO5b/CPY=;
        b=Qw3XJqDarowQwD4pQgut9Ekvv4pwAEJnzxHJVESkeeAXBEZo0ELckMEXj1bRsc2VDK
         OfbVawbz3VkFCdqxngeZzk84b9hxFBCZbGodyTFm9fZqZctTg01cN8wKWye3ayHBW7EW
         qJoh726qc7sY7CihI9wB5/l1wCg56lmQkEEyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727829249; x=1728434049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FO5R8cdqVEZ/UYrxFLZyYiizB9jbmk7GftZJO5b/CPY=;
        b=k9rnXBMRSDsBx+CDAwli9/2vfqI7LO9IZAELgNjyeCvg22dUGOH+uXqc2x9+aDDKOq
         yV7ggI5lmwIiQUpNKcM/Nc24GYkD9m/qrwrhT3eSySbgT9LYThbkFHM/ttahH3F9mIBX
         4moZunzigmZ7TCEGrWv+m83t+oq+xOcmmtDpYbgH3dTXYBOkMBlvYZjjNfTF4FXUu0Jr
         2c32MAujV6PMsgm1+butFR5UUgau8vkAZvDqEHKt4nLh682cDKFBTd9PQRZoWFkvPuRv
         la51huqwZwjGumPf4vxtHACrBUgKfJ6vgtQ+fonLn+dqZxb6wLuqB6NlrSWK1yElG9IU
         Sydw==
X-Gm-Message-State: AOJu0YxagdcQekeXExxJ4y33/O4DX0PeBcTSBtfjpW1GL67NOjXQP2E9
	jMj63zE0YDYvc2T1OmykNjzp6k7/NwjbW9A2IuI6Y2uvXE4rvHq8X+xPlytFKXxnV+YC7QDiYE6
	xPAGPjGzf7J2NrtIEqHDqFqjZthKuyLZhmrdL8JTn7X17i65tmNjpSIGkEOzBEOodxGYmFAhzQx
	eFVwV4PgsEGy81iApsaCSqaL07V51LSemUSrI=
X-Google-Smtp-Source: AGHT+IH2HSmZDNrH/knCay8KR3iK7382ru2jqg7iXcmq1FjlvJOm7vkhVKsGQ/ztlc1T1lXd7XDRQA==
X-Received: by 2002:a17:902:f685:b0:208:d856:dbb7 with SMTP id d9443c01a7336-20bc5a5d0damr20242885ad.39.1727829248624;
        Tue, 01 Oct 2024 17:34:08 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5ecc1sm75521295ad.268.2024.10.01.17.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 17:34:08 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: darinzon@amazon.com,
	Joe Damato <jdamato@fastly.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kamal Heib <kheib@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	Noam Dagan <ndagan@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Shay Agroskin <shayagr@amazon.com>
Subject: [net-next v2 0/2] ena: Link IRQs, queues, and NAPI instances
Date: Wed,  2 Oct 2024 00:13:26 +0000
Message-Id: <20241002001331.65444-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2. This includes only cosmetic changes, see changelog below
and in each patch.

This series uses the netdev-genl API to link IRQs and queues to NAPI IDs
so that this information is queryable by user apps. This is particularly
useful for epoll-based busy polling apps which rely on having access to
the NAPI ID.

I've tested these commits on an EC2 instance with an ENA NIC configured
and have included test output in the commit messages for each patch
showing how to query the information.

I noted in the implementation that the driver requests an IRQ for
management purposes which does not have an associated NAPI. I tried to
take this into account in patch 1, but would appreciate if ENA
maintainers can verify I did this correctly.

Thanks,
Joe

v2:
  - Preserve reverse christmas tree ordering in patch 1
  - Add comment that the API is for non-XDP queues only to patch 2

v1:
  - https://lore.kernel.org/all/20240930195617.37369-1-jdamato@fastly.com/

Joe Damato (2):
  ena: Link IRQs to NAPI instances
  ena: Link queues to NAPIs

 drivers/net/ethernet/amazon/ena/ena_netdev.c | 40 +++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

-- 
2.25.1


